Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADA0C4453F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWV1-0004QD-FL; Wed, 22 Jul 2026 08:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSg-0004eq-A9; Wed, 22 Jul 2026 08:54:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWSc-0002wU-Ve; Wed, 22 Jul 2026 08:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=hn2j025oEONJYIInyqiFL/SkKApaOjgJgJoPStBuSn4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nqkhN1vQ7ZePcIhKbb4KR+qHUj6N72eawpolLeq9p9F/0TsmrH5IPMWazS3UGRuq4
 LXNX//mMVSpQQ9Jht92N3cmvDgdEmwDpIZMdSkA/sr/fBFDYoHP3/AM6fhX3fUkrJK
 OtxbPpxKtg+9lRj0ZyUz83hMoy66jQXegdZU2LgXwRmonia9W4ytJgPOiUG+QowTFa
 RAoo2mFm/uzf8VjU+nktWCD1OgJ955ldEUy2WbrYDTeVcc6jmX13uO+6T8CGSgWA0x
 um4JwPRPX1oYo/ksDvJ8eYUvbiUGi4ZHEq5nKZYCr+p8+9q2BJ/dIKnNkRzzwrzTIJ
 ftUlGHkk4sfzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1A6111C3B4A;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 632EE3F379A;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D427C17F69; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 109/127] ui/vnc: validate SetPixelFormat field
 ranges
Date: Wed, 22 Jul 2026 15:48:34 +0300
Message-ID: <20260722124859.32371-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The VNC SetPixelFormat message carries red/green/blue_max as 16-bit
values, but PixelFormat stores them as uint8_t. A client sending a
max value above 255 (e.g. 0x0100) passes the existing non-zero check
but silently truncates to 0 on assignment, leading to a division by
zero in the Tight PNG palette path.

Add explicit range checks if any channel max exceeds UINT8_MAX.

Fixes: CVE-2026-15578
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3976
Reported-by: dong ling
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 6075444c5a72ab531295d92050d95cebea8a8119)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/vnc.c b/ui/vnc.c
index 16cd3eac2a6..3a041926bf3 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2282,6 +2282,11 @@ static void set_pixel_format(VncState *vs, int bits_per_pixel,
         return;
     }
 
+    if (red_max > UINT8_MAX || green_max > UINT8_MAX || blue_max > UINT8_MAX) {
+        vnc_client_error(vs);
+        return;
+    }
+
     if (red_shift >= bits_per_pixel || red_shift >= 32 ||
         green_shift >= bits_per_pixel || green_shift >= 32 ||
         blue_shift >= bits_per_pixel || blue_shift >= 32) {
-- 
2.47.3


