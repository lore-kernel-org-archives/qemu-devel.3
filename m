Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A979CCE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSrz-00053t-W7; Fri, 06 Sep 2024 02:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSry-0004ys-Oe; Fri, 06 Sep 2024 02:54:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSrx-00032s-1S; Fri, 06 Sep 2024 02:54:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3DCF28C23F;
 Fri,  6 Sep 2024 09:53:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 050F51333F7;
 Fri,  6 Sep 2024 09:54:30 +0300 (MSK)
Received: (nullmailer pid 43368 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 10/53] virtio-snd: check for invalid param shift
 operands
Date: Fri,  6 Sep 2024 09:53:40 +0300
Message-Id: <20240906065429.42415-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

When setting the parameters of a PCM stream, we compute the bit flag
with the format and rate values as shift operand to check if they are
set in supported_formats and supported_rates.

If the guest provides a format/rate value which when shifting 1 results
in a value bigger than the number of bits in
supported_formats/supported_rates, we must report an error.

Previously, this ended up triggering the not reached assertions later
when converting to internal QEMU values.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2416
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <virtio-snd-fuzz-2416-fix-v1-manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9b6083465fb8311f2410615f8303a41f580a2a20)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 4d15fe0e31..f0e7349c8a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -282,11 +282,13 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         error_report("Number of channels is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (!(supported_formats & BIT(params->format))) {
+    if (BIT(params->format) > sizeof(supported_formats) ||
+        !(supported_formats & BIT(params->format))) {
         error_report("Stream format is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-    if (!(supported_rates & BIT(params->rate))) {
+    if (BIT(params->rate) > sizeof(supported_rates) ||
+        !(supported_rates & BIT(params->rate))) {
         error_report("Stream rate is not supported.");
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
-- 
2.39.2


