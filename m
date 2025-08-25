Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10A0CA0FE7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 13:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqXdc-0002Tv-1X; Mon, 25 Aug 2025 09:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqXda-0002Sn-86
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 09:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uqXdV-0005Aq-8s
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 09:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756129999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hNN6LHE+gFQtvaec4Kdxn4dFV9GUkdVJ1Zr3Q3qL1Cs=;
 b=Cr9r5gyq0TuDscROESJxpuvrKMlT+j2AY5xt2qaXp1NVREjEFjv5eR4QTW1P/M5/R2zhOd
 mUMd1SKqEWY4tb1wIu9QEADSbYI2c5fFiIwYF+K4HG9OPBzVCWKkgg6ifubV1U7def+Pzs
 mjxlmz9HazkhVxkkqPh0PbjZxoDexXU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-5WzW90PQPTOHQ75bcD_yOA-1; Mon,
 25 Aug 2025 09:53:16 -0400
X-MC-Unique: 5WzW90PQPTOHQ75bcD_yOA-1
X-Mimecast-MFC-AGG-ID: 5WzW90PQPTOHQ75bcD_yOA_1756129995
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8DF91956087; Mon, 25 Aug 2025 13:53:15 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.207])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35EE230001A5; Mon, 25 Aug 2025 13:53:13 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yvugenfi@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH] qga-vss: Write hex value of error in log
Date: Mon, 25 Aug 2025 16:53:11 +0300
Message-ID: <20250825135311.138330-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

QGA-VSS writes error using error_setg_win32_internal,
which call g_win32_error_message.

g_win32_error_message - translate a Win32 error code
(as returned by GetLastError()) into the corresponding message.

In the same time, we call error_setg_win32_internal with
error codes from different Windows componets like VSS or
Performance monitor that provides different codes and
can't be converted with g_win32_error_message. In this
case, the empty suffix will be returned so error will be
masked.

This commit directly add hex value of error code.

Reproduce:
 - Run QGA command: {"execute": "guest-fsfreeze-freeze-list", "arguments": {"mountpoints": ["D:"]}}

QGA error example:
 - before changes:
  {"error": {"class": "GenericError", "desc": "failed to add D: to snapshot set: "}}
 - after changes:
  {"error": {"class": "GenericError", "desc": "failed to add D: to snapshot set: Windows error 0x8004230e: "}}

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/requester.cpp | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 4401d55e3a..644514fb95 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -28,8 +28,9 @@
 
 #define err_set(e, err, fmt, ...) {                                         \
     (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__,  \
-                                   err, fmt, ## __VA_ARGS__);               \
-    qga_debug(fmt, ## __VA_ARGS__);                                         \
+                                   err, fmt ": Windows error 0x%lx",        \
+                                   ## __VA_ARGS__, err);                    \
+    qga_debug(fmt ": Windows error 0x%lx", ## __VA_ARGS__, err);            \
 }
 /* Bad idea, works only when (e)->errp != NULL: */
 #define err_is_set(e) ((e)->errp && *(e)->errp)
-- 
2.50.1


