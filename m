Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1AFFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI8sp-0000qI-VY; Wed, 29 Apr 2026 13:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wI8so-0000p5-Si
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:39:35 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wI8sm-0008GA-LS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:39:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 286BF41986;
 Wed, 29 Apr 2026 17:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FA2C19425;
 Wed, 29 Apr 2026 17:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777484371;
 bh=xPd4mYwGCWKwRuBmVbsvO0gF+W85kx/Ix/pQDEmxgro=;
 h=From:To:Cc:Subject:Date:From;
 b=HKSTxbZS96hx8dgBvu9M2xeF3l7mRH0SRSG+7b8MrFTX4ztO5y/+vzRedYyW1XU8g
 btQhDJCgcgHkomlamLSUqJHjqirDo+jKJBShKijMUugYvXQjWo0zBsXUAqPkLwQGec
 jxnJ7Qzi/MPCYT7dxR/YchgPs4FNM8u2ME4vwNnRwa1rUic//zYq1vYaPRG+me/3Vk
 7tZtWfnb+8bSZN6kTXzZPZrzmiGqRgce63vQU6I28krIA+5hgq4IB6f11kvFukr/Jo
 OHg4bIbN/4MM6PJkGOQ0OC2izASRTH1L1RGS6F5+Rrscfwtr07EjV5PSWOsLlou+Mc
 vKkLe3HMvnlxA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user: Translate errno in IP_RECVERR and IPV6_RECVERR
Date: Wed, 29 Apr 2026 19:39:23 +0200
Message-ID: <20260429173923.3402-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

Translate host error codes of IP_RECVERR and IPV6_RECVERR control messages to
target error codes before returning to the caller.
For example, this is important for architectures (e.g. hppa, alpha, sparc,
mips) on which the value of ECONNREFUSED is different to the value on a x86_64
host.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/602
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d68edb7afd..d3d9fffb54 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2008,7 +2008,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     tgt_len != sizeof(struct errhdr_t)) {
                     goto unimplemented;
                 }
-                __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
+                __put_user(host_to_target_errno(errh->ee.ee_errno),
+                           &target_errh->ee.ee_errno);
                 __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
                 __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
                 __put_user(errh->ee.ee_code, &target_errh->ee.ee_code);
@@ -2062,7 +2063,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     tgt_len != sizeof(struct errhdr6_t)) {
                     goto unimplemented;
                 }
-                __put_user(errh->ee.ee_errno, &target_errh->ee.ee_errno);
+                __put_user(host_to_target_errno(errh->ee.ee_errno),
+                           &target_errh->ee.ee_errno);
                 __put_user(errh->ee.ee_origin, &target_errh->ee.ee_origin);
                 __put_user(errh->ee.ee_type,  &target_errh->ee.ee_type);
                 __put_user(errh->ee.ee_code, &target_errh->ee.ee_code);
-- 
2.53.0


