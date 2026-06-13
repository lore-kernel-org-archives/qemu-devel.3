Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C89BCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV6x-0004Du-Nz; Sat, 13 Jun 2026 16:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6u-00048Y-Tp; Sat, 13 Jun 2026 16:37:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV6t-0003Sa-DT; Sat, 13 Jun 2026 16:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382963; bh=oeWCQUoPxo3Y5KEpbVvM3clq9pSKvlzk66CPh2w8/2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lVtE0b8pjV1Qqb/e1J0b8HPbmpKrz1k3QuFBOatjvtc9hstb7HIyMExbYt5u5+PrF
 jYt50rOBXAONF8qC7ngZ4q2LxbQipUfw9z59CmSokwHUxCe90XltXwe6ttsaTc/E0Y
 iH+2ZwyokEPX5TVYVWu8pw2gySt7iRWmRsOyp8UofWUzWuG95fCOZM+D+Kylv5A6Kr
 7A6Pa4kxY8y1tKSVm0Glx6Qp0JFbEJls2/xX8jd2rCBGgdoYMB+ZobIWu9F4j+qvVK
 VeixeobHHOhQ82Po3NmKF+g9KBo92hoYE6DHEgT0pVVV+bMgzF+aqR3AFNr4zzHOiC
 kXqliyXqMNlzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68C841B6EEB;
 Sat, 13 Jun 2026 23:36:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D0AEF3CE93D;
 Sat, 13 Jun 2026 23:36:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 boy juju <agx1657748706@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 17/72] ui/vnc: fix OOB read access in VNC SASL
 mechname array
Date: Sat, 13 Jun 2026 23:34:43 +0300
Message-ID: <20260613203542.1809153-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Daniel P. Berrangé <berrange@redhat.com>

When reading the SASL mechname array off the VNC connection, if
malicious, the received data may contain embedded NULs. If this
happens the memory buffer returned by g_strndup may be shorter
than the original data. Unfortunately the code continued to
index into this buffer with an offset equal to the original
length. This is a potential OOB read of the array.

Fixes: 5847d9e1 (ui/vnc: simplify and avoid strncpy)
Reported-by: boy juju <agx1657748706@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260521103353.1645561-2-berrange@redhat.com>
(cherry picked from commit ae18df638fb4285c7b645f98c43f5ebc2e123a55)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
index 3f4cfc471d..9f15980fca 100644
--- a/ui/vnc-auth-sasl.c
+++ b/ui/vnc-auth-sasl.c
@@ -490,6 +490,8 @@ static int protocol_client_auth_sasl_mechname(VncState *vs, uint8_t *data, size_
     char *mechname = g_strndup((const char *) data, len);
     trace_vnc_auth_sasl_mech_choose(vs, mechname);
 
+    /* If 'data' had embedded NUL the dup'd string might now be shorter */
+    len = strlen(mechname);
     if (strncmp(vs->sasl.mechlist, mechname, len) == 0) {
         if (vs->sasl.mechlist[len] != '\0' &&
             vs->sasl.mechlist[len] != ',') {
-- 
2.47.3


