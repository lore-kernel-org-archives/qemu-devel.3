Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6479F8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 05:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDbTH-0006rf-0e; Fri, 17 Apr 2026 01:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDbTE-0006qe-77
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:10:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDbTB-0002O0-BX
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 01:10:22 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so162046f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 22:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776402618; x=1777007418; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MO94xCcoU6UDdF1hpEURZaIY79fEZkBmJ9yGiyO6ciM=;
 b=zQgFPCtWQiiRRbUxfInQ6E3PsqEjv7L6smopFhJN1oMgLXm062fbK2GUoiNMX5+aBG
 32BDrDxyt4x+IsSGIsnPZu0qx/Z42zRyA4CXT70PMVNkjEg6ZkcWoFVALR3uuK5vMk6S
 xPjvHDZ1UR4orNhpFiz9daesFlAdZE1pCNlfz0UjgwK060DfEQFQ76xu/Mo/g8FJS0N6
 zfv048eusQrLoreEYUXZbvL06tn3Y/yG7x2NaMr8u7qWR4hD/tv5BiMufXiy2s9Mgvfr
 OcwvoHCRR6fP8hW/q4ohs2gM+nk+APNLfC355oHGLBJsyl5LPUjfxR2u97sZQDl9ymvW
 4H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776402618; x=1777007418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MO94xCcoU6UDdF1hpEURZaIY79fEZkBmJ9yGiyO6ciM=;
 b=QUa9KkF4/3DgfCCMdB16CxpSLwIKQ6zBCbGl6LffJnUjS4Sw6kzex7gRqofOs60d2i
 0Hf4Q52fC0nUyOMCbVfKohnA1Nb3EEYNZFBWquNQnuDIJ9bZrqeq32/0smVxh8oETi6+
 zYsdRnMzRACG05h0ncP8Y+YHHWNOyQMG3rgSd4eLbP59nphJA6lVQokU2smZZxPd7zoQ
 dL7YEHcs+nKXWMFyrHND8DTEOGR2MxWoaAPPIBFxqHSOJOF1nCLM0eBTYTetmbWW/oWA
 mLgh15tI7Gwwd2+y4jJrKnDsTajMz1yksznekEyHiF8DsnCMjKS27IsMx2LS1Gikp5i5
 DosA==
X-Gm-Message-State: AOJu0YzClkvT135vPMBkkHkvsL8gB88H8INyjNMKHyyyA9PzE5qEu8fZ
 JRIHN+KX9aCZ84j8HXdmz5g/gur0VXvjyBOsBPaq1D6rZmz8HffhV/r0gAIT+0AW1xCWNAVirGo
 oh0mdG4g=
X-Gm-Gg: AeBDievETTI27Jv7MtlaP8fuAqu4jMtCcp9dkBBSTGY2DZS0XiIqTSlzMBolD34jzYP
 IOAuSuenaTieUgTF9OSjco3Vx+pFbooFfWiLJpZK5iGufhVjMkEiEp4J34JBEEHpgZM3cjgOGaD
 5/Vx7Do31qRnJQ8AjU8mBXEKYUGlHy8bBb+KnfY7w7WaOMKN6DjAbfNcdMUqoHDl3zC3SZeFNOr
 8tHVR1DqcRIKS0dmATjSX13kDxRJQ6FHKtlT6Rn7OwGGyCrDx8NRl2nv3cSOhikT2pMLQmAfZug
 95xqrAlw2sVaQPj7808JOi5IYFqAVdA1q2/idx+GzEmEdgaAOBOrW7SJSpjxWN7k1iPUvmfvlUg
 gqbd+1W7nn2QNpMRH95FiNRxhkRSui7qZiLdShys/SVyLAvM9a5REkRdaSNb6R3dojnmNHOYCEI
 6gGHJF5Du7N0LM2suKDeiZJd/7L10boqVLpkKLU9h9L3eFCZ0NcOP0fJEgw5EVtk+qvZKqpYpct
 eoDzgFuZEwEh9HgDc/t6xR7IvX6FAUDvoETLIuMecU71gy7c+yW9s4EKDHXgw==
X-Received: by 2002:adf:fcc9:0:b0:43f:e4f1:bd9b with SMTP id
 ffacd0b85a97d-43fe4f1bdf7mr467208f8f.30.1776402617728; 
 Thu, 16 Apr 2026 22:10:17 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm1749524f8f.20.2026.04.16.22.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 22:10:17 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 17 Apr 2026 08:10:10 +0300
Subject: [PATCH v2 2/2] virtio-snd: check for overflow before g_malloc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-virtio-fixups-v2-2-4a0d8636a628@linaro.org>
References: <20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org>
In-Reply-To: <20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=Bq62Ohx1DaKj6RUXlcem2LCLdDkwbtcNdp7LNhLzatg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0Y0MyRWNoUE1oRWVSZ1hZTGg3UndTMHJlS0xaClc3U1hFWG0vbVNrSUJTM3dZ
 VWFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVIQXRnQUt
 DUkIzS2Nkd2YzNEowTGNrRUFDTEt1THlOdnZ3YXVtUEhUWnB4MWk3MHRHTGovRUxzL3RuSnJZZg
 pKTHhJcXhpbWZFWW14VDc0Ujd0YUhMdDhWb2c4dmxVT0hicWVpYUswN2U2TTJQdlorZlY3bjhXd
 Vphb3JERzQvClNxZnNzSzdkdUNQVmRGbm5YNzJMWVdWYkVOQTk3a2dWdG9NV01yWkdHV3AxZUhQ
 Z2dzV1JrRFlSMVhBWGhLUnUKUktYcmZnM0hGbG9EbnZPOTZkdVI1aEVtTjUxQWFzUVpqcjY5SEN
 OWGdQV0N2blI0TlB6a0Q3SXQ5blU5MmdOSApkajlHK0FZcXI2UHdUTGMvUjUrN1UwTHQrMWhxOU
 JwKzVSOTc0OFBoNC9mWXNJMkdkQm1hdGNvb2hwNHZELzMrCjhBTVBZaG5DMXBCd00yY3JrOVhGM
 2lvQzUvS3h4T3YxOXlUS0orY29xZk9iL0lMcHlIREpCQlBtSE4vWkpTUXUKSm4wSU11aUdDdENu
 dDNGaDhQMTkrNzNkYlVnVmFOYkVSTlZ3N1YwdnJ1Vm9MMmlJL3R2VzVTOVlCS1BBbmRBWQpsTEh
 aUFl0ZldDT1lqMGdUV0dzQVFwK0l6QzNQMTRDL3lLNTlVeUdTeHhIN1RrUHhEVFdwWXozWEdyc1
 Y0OGprCnNqYWI0R1IvOExtdnpXR1JZdFJOVmFUMDMrNjZWWEpSbXlPTUVDQVJBcGFOclZ6WHlOR
 ERtL3lHUk5sY1J3L1IKTEV3V3dITFdIbTZPOHkyelp1alA5aVFsM3VsdnFLZEx2MHdjbTBZeTAv
 SDB1NGxpbXM4cjBibDByVlJvUWtWcwpROUJOYzRkaElMUmRyemZYRW5JOWFvOU1SS0JJNEswVGx
 xSnNYaWNvTE9SbjlnZE5qeXIxbUJHUUpPc1dteUZWCmJRVUhSdz09Cj02YWl2Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Coverity points out one g_malloc0 overflow, but it seems to be a false
positive. Add a check to it regardless to fortify the code, and also add
checks for every other g_malloc0 use.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 93fbcfb43f7fdcfd5c164b496015da743822f5eb..694bcebb60f6c866346470672cc798b3271ae34f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -850,7 +850,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -880,6 +880,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
             goto tx_err;
         }
+        assert(iov_size(elem->out_sg, elem->out_num) >= msg_sz);
+        size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= vsnd->snd_conf.streams
@@ -892,9 +894,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto tx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
-
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->populated = false;
@@ -932,7 +936,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOSound *vsnd = VIRTIO_SND(vdev);
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
-    size_t msg_sz, size;
+    size_t msg_sz, size, tmp;
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
@@ -977,6 +981,10 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             goto rx_err;
         }
         size -= sizeof(virtio_snd_pcm_status);
+        /* Check for g_malloc0 overflow. */
+        if (!g_size_checked_add(&tmp, sizeof(VirtIOSoundPCMBuffer), size)) {
+            goto rx_err;
+        }
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;

-- 
2.47.3


