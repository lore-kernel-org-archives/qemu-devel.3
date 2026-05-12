Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADAACD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuj2-00051Y-Rf; Tue, 12 May 2026 17:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuiX-0004Fw-FY; Tue, 12 May 2026 17:32:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuiM-0002ZA-A4; Tue, 12 May 2026 17:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619499; bh=JUzy+Aux80fJCuGYOfjx3LkGiItOtwzq7VuAiSImeqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WfNtCbbnk5vfXJal2euM/fVIdUZt6V9cOjHKVPPn+Lok0Frd0AyRzeS23mnj4i/Tg
 5uy/o6Lf5PLzb0H0c9IkPbKlqI62H/lNIkKvq/9z0wtEbmkgwZ7Ykc9m8cqQYPI57X
 op35qsp26E5iGLmw+BOiYm8/bM6wTjAnDaTcJTGH4Osic32zCtljdeZYcRwFCgbpqa
 BYWyx91mK0E2i9mbPhbTmREqaPsOARUiZHXUeDrcdzJhWyAzPPLxcLMqsJ5x2f8IzR
 u6qW+ZjsADYcyAqmYqEMBrQ9rLaDePCESTdMIRCjz1OGNwzdjFPX+jm6gc6O+TCL7l
 7V59+JspiH8Ng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE8A51AA3F5;
 Tue, 12 May 2026 23:58:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DDECC3ABD4D;
 Tue, 12 May 2026 23:58:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 42/58] linux-user: Translate errno in IP_RECVERR and
 IPV6_RECVERR
Date: Tue, 12 May 2026 23:58:03 +0300
Message-ID: <20260512205820.361821-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(cherry picked from commit 9667bf3249256788245c6ca07bc12106f3e4fa22)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


