Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FCACDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFnx-0005mA-0P; Wed, 24 Jun 2026 01:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFnv-0005jn-O1; Wed, 24 Jun 2026 01:05:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFnu-0005Z5-4H; Wed, 24 Jun 2026 01:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277465; bh=XToyEyO85k0wvOXd+H658vKKXC4nhak7e7vcR3tu/po=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vDka8qkvRY2YPkw5++qcFuAWSQopb6G276k1ql9CCF6xn2ZHHUOLv79txEhEUuQHR
 WSlb7JMUHp5SC3ObPLAdAVk9qBPO7CiLzQixyfxhZSg/6unuV8jcCUqfBlG+VrkFMX
 B8CS35eH+E2lehfWUG4Cmb/4tAeGjecVLWASKuilY1/puy6Z2DOrzGWtsZ47KKX6Ui
 r+jR6aWFxdTJ9QG687Kl5tYym/zWxDmiqfSidCscwZKYzMULrh6OeIX395L4Z4U/kL
 8LV1PMKGjCWXr168yJFgIwLGbZeZHZ4r3eyf+3gHL343HsHy/o3DyanyfDcpTpZKdi
 xKM3zV9PD8cRA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6BEF61BA63D;
 Wed, 24 Jun 2026 08:04:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4A92B3DDAC8;
 Wed, 24 Jun 2026 08:04:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 74/86] hw/uefi: fix parse_hexstr
Date: Wed, 24 Jun 2026 08:02:45 +0300
Message-ID: <20260624050404.394225-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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

From: Gerd Hoffmann <kraxel@redhat.com>

Make sure we actually have two input characters available before going
to parse two hex digits.  Fixes one byte buffer overflow of the output
buffer in case the input string has an odd number of characters.

Fixes: CVE-2026-48915
Fixes: 12058948abdf ("hw/uefi: add var-service-json.c + qapi for NV vars.")
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260526135948.599148-1-kraxel@redhat.com>
(cherry picked from commit d6601a7e1c2452100ed7e4b1d74a70b9acc0abe6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/uefi/var-service-json.c b/hw/uefi/var-service-json.c
index f5f1556833..8621b86c5c 100644
--- a/hw/uefi/var-service-json.c
+++ b/hw/uefi/var-service-json.c
@@ -98,7 +98,7 @@ static void parse_hexstr(void *dest, char *src, int len)
     uint8_t *data = dest;
     size_t i;
 
-    for (i = 0; i < len; i += 2) {
+    for (i = 0; i + 1 < len; i += 2) {
         *(data++) =
             parse_hexchar(src[i]) << 4 |
             parse_hexchar(src[i + 1]);
-- 
2.47.3


