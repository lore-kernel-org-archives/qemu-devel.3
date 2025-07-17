Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7BC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 17:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucSba-0003WK-3u; Thu, 17 Jul 2025 13:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ucQ5Z-000329-T0
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ucQ5W-0000qF-J1
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752764395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=s4PwemJfNWw4gTqH6cQb/KQ7d7y1Ytp/4de0LQhCpN4=;
 b=A2n4aWuzvwcCmRfknVp2sFAbQlbbqAQgUCU0Qmfxug1PXxBCNNgPDgvMjVPVpgWHg65zj/
 UEJMnUJEP9y5SYU9Fvq3NnM3u6F6pzxVhvBg94s7jK5cyng4eMqbzhH5NkE2GUSiot6fFS
 iFMhXdUuJKBsXzcL9puhTqeVLze4SPk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-_PFl5ccKMn2ALoAYxwElXw-1; Thu,
 17 Jul 2025 10:59:54 -0400
X-MC-Unique: _PFl5ccKMn2ALoAYxwElXw-1
X-Mimecast-MFC-AGG-ID: _PFl5ccKMn2ALoAYxwElXw_1752764393
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20A2B1800C36
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 14:59:53 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.152])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5091C1956089; Thu, 17 Jul 2025 14:59:50 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] util: win32: Write hex value when can't get error message
Date: Thu, 17 Jul 2025 17:59:48 +0300
Message-ID: <20250717145948.77870-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

g_win32_error_message - translate a Win32 error code
(as returned by GetLastError()) into the corresponding message.

In the same time, we call error_setg_win32_internal with
error codes from different Windows componets like VSS or
Performance monitor that provides different codes and
can't be converted with g_win32_error_message. In this
case, the empty suffix will be returned so error will be
masked.

QGA error example:
 - before changes:
  {"error": {"class": "GenericError", "desc": "failed to add D:\\ to snapshot set: "}}
 - after changes:
  {"error": {"class": "GenericError", "desc": "failed to add D:\\ to snapshot set: unknown Windows error 0x8004230e"}}

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 util/error.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/util/error.c b/util/error.c
index daea2142f3..b1342558ae 100644
--- a/util/error.c
+++ b/util/error.c
@@ -188,6 +188,11 @@ void error_setg_win32_internal(Error **errp,
 
     if (win32_err != 0) {
         suffix = g_win32_error_message(win32_err);
+        // g_win32_error_message() failed
+        if (!suffix[0]) {
+            g_free(suffix);
+            suffix = g_strdup_printf("unknown Windows error 0x%x", win32_err);
+        }
     }
 
     va_start(ap, fmt);
-- 
2.48.1


