Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08307C71136
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Jun 2025 02:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQGLU-0003bQ-2f; Fri, 13 Jun 2025 22:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGLR-0003YO-Us
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:10:10 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>) id 1uQGLQ-0006or-1d
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 22:10:09 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 343775F9F
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1749866975;
 cv=none;
 b=SpjVyNmVzgk1/nkZxJhHGAScIKPN515uHFwITUlzuF9+CqGHKFnBdifDJzYQSQqrdNmJfbK3kb995yReQw1vgea7sU6hBAJYLXtCbLWtHtlFw1WDQzzswG9uoGmFbUQBNiBkVlEwvdyU/+E13ch4WbPnlKRuYL6UNE7ECod2KsMuuHKodqHZKNqFR1n3ZG9RPsic2PXy/ZoCow4w6m401HWjNpOwNNPN80ji3Slt2wdMd+E+nA+edIpAIg4X27v0TJlwPnCJMX7kcptjvyLJAcO+8Xxvi4yfKJJAPclOE6OUuhLUAauZb3s3lEJfm29+ZFaxnI3hk1Ubdq+aKEEzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1749866975; c=relaxed/simple;
 bh=m0K56CSPcT09qRkK6ylaq0Uw2Aj41rsQzExHIcDXrOQ=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=WlZnjCxAOvNF2WQYA9hzPvV/n1B1ZznD1WYYCPvZvnQPQDeiGYyqw0bGtlGFsYmT0k3gcPrmGNkXkIYpskoZ8i1vsVm1we5y2Ky/VcDh96gxxJMTWENRXSe8am0r28DC0rB960uiZSterkw9qN+Wg/j/OS1VvbY3+2le50CtM5Q2XpUBSaaPStetlIe67DJFYGw9dKTRci4Jnokq+/nsZpWaoxklwEPyQ6uEMKDR+LCm24R78knXgRTWl2JKu61AJVNXolcX4nklELPd0GmpRyaJV4TcEARXdc1LLnemPBtrVQ92ps1LEpZ7btG0+2UXnyYpd7dy++/AUcvp4hVkxQ==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1749866974;
 bh=m0K56CSPcT09qRkK6ylaq0Uw2Aj41rsQzExHIcDXrOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rMwYb4BqW3r1x7nV6kXHGMuwLxgsk/OLMdYBr0VNfZmDkYElqpx0ASSLtU3H4h0qt
 M9fKVDD3VXQlxZV6hRq2Hgc3WlIvLZczm/+Zzs6AmMjoZQ9y1DANWRLNMyhaQeWX+j
 W3twbWdavinbfCac6Wm6LaMBAt8KzIhHwjvir+r69Fw+hI4C4Gl1klf/5V3A+XhKvj
 EwL1E/IBfznpOIIfzmNSJh5uziGbNz26JHGrttceKtlzXoxThOiz/rY7V/eBPdzUjM
 sT3Q2ymI+McBzbuCXEp/r/f+iYpFX2FC4u/238wQ4X7o3ECQ/1BqryWsZVae+/1DoD
 pCWeku2iZbE0A==
Received: from Mac.home.lla.com (unknown [207.191.242.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 343775F9F;
 Sat, 14 Jun 2025 10:09:31 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH 2/2] hw/9pfs: move G_GNUC_PRINTF to header
Date: Fri, 13 Jun 2025 22:09:20 -0400
Message-ID: <20250613.qemu.9p.02@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613.qemu.9p@sean.taipei>
References: <20250613.qemu.9p@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v9fs_path_sprintf() is annotated with G_GNUC_PRINTF(2, 3) in
hw/9pfs/9p.c, but the prototype in hw/9pfs/9p.h is missing the
attribute, so callers that include only the header do not get format
checking.

Move the annotation to the header and delete the duplicate in the
source file. No behavior change.

Signed-off-by: Sean Wei <me@sean.taipei>
---
 hw/9pfs/9p.c | 3 +--
 hw/9pfs/9p.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 8b001b9112..acfa7db4e1 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -201,8 +201,7 @@ void v9fs_path_free(V9fsPath *path)
 }
 
 
-void G_GNUC_PRINTF(2, 3)
-v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
+void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
 {
     va_list ap;
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 259ad32ed1..f4f4086cf7 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -456,7 +456,7 @@ static inline uint8_t v9fs_request_cancelled(V9fsPDU *pdu)
 void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu);
 void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
-void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
+void G_GNUC_PRINTF(2, 3) v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
 size_t v9fs_readdir_response_size(V9fsString *name);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
-- 
2.49.0

