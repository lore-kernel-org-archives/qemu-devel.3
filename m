Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F502F433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 05:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDFaT-0003Sb-99; Thu, 16 Apr 2026 01:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFaS-0003Rl-4A
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDFaQ-00016e-M4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 01:48:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so99666585e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 22:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776318501; x=1776923301; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=30dDtFtVzrZ0rFH7FQtblfDTpXIqR78+UUjDSh4LLvs=;
 b=IArrUbguahQQbnJNRh+q41IDDyB29BNakMvh06/MpLLCTIPDd77HKlx1IBY03vyQyf
 dssSiYDF3R33GHda6Z1iCY+JNs2/DKPHBkAC7kaK342Yl61rxRlftNpmW2rnabWqVATJ
 LMdYi4zVdf79h/2O6qWQ6Siq23qjO09P+AOzuMhYPrF7MogXn4ICB5hkA/HJzdufayqo
 tLn4P1jdcIGgqiiV2PllH2fprZDJD3VwOYYNOnJLw/gYjgyA1aKEqOeL95cPAQcXtTik
 DurB5dHsIG33AKwBNOHQRrhu48xhrXhPumNaV6KAZudZnUk4h8akhymt7VglCgfw5ACL
 dpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318501; x=1776923301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=30dDtFtVzrZ0rFH7FQtblfDTpXIqR78+UUjDSh4LLvs=;
 b=hD2TIkBlBpujty/fEsGUe/LTrHCPNpt+9gu17VcazEtYpsHCv50s8FLjmTENY6CNcv
 lblK4NvM0xnBQyg6dklymh+Fs0fhOnFku/b3dxaC68+721zB4KFSrxDA5JKAYe75tJ4I
 b/j/AtIUkUY++bdxNrvU9U9lyznlpwsgAxvKhfYj/3HAIo0RhHBIpLC6TqHmS84t4v76
 UWYK/s+hExjBVOA4MKJsZPCgruv1pW+KrJSNXgdxedaRqeUpQNs+OuQhH2Q+1AV8CTJ8
 3alab3O4tcn1/tw5JpLSt329cgN/CMmNlPIx2HO1F4KBhluoKCqGtOGGFd/mNYlT0Ry7
 I/Vg==
X-Gm-Message-State: AOJu0YzE+iY2B7vt4buszG96eKB54XKP/mJSFH414msHrLPVsSdnvvAk
 s4h+VLxg84a3LiEqxZkUyodmjQlwP5aXt/fMuosTe5yr67yQAkAMkIhQxNxg1EhTHMY=
X-Gm-Gg: AeBDievtK/thUvLRg5VbbVP4SP4BP+X4fDlcy4R8hSWAdzEw12a+AunuuEIExLCRgoE
 +ARN+rdq2e3QUGy5eEMlB68cgHEs/yhThtKgd4K4Am8whVLEmSigemFZBttGuG3ka6OWNcSs2qY
 WipDZWDV84LCFqbFAdUwU1ar78oRYzUR6Sun7ubwwVMvN84PWW1N9GqOdcSicp4ebQmEgXv3+DN
 VYhvDN0hgw0fDxp53I0taVPYZ+k+47u9SN0KMkDhjeziZHeEuiApDfZxnOSjm4IU+T2nV2SLcyo
 IS8NcMqW8amiqFpipXIcVHTt5yUP9vx//PVyMINXibtTxlQhgGOEQAaiXU4OUKEzISKowIzB8BN
 dJcroIDiEz+N3PpFUwOc+TqIzGBwBxLaKSRRql9kvtFJcqyWg9gFizlHpswebiUwyuN4yx1HwS8
 eGm7wYYntPNExTaF/IQ5al+d40fPF14RKvY9AD0qPLUKIfjI7Kb3QJAKIZJARdJTwuH3UEK9GC2
 i7BtCapaOQXk/22tq5YmqLF23bCKQai980hhsJQ
X-Received: by 2002:a05:600c:871a:b0:488:a2ac:a34a with SMTP id
 5b1f17b1804b1-488d67f4299mr357889185e9.10.1776318500875; 
 Wed, 15 Apr 2026 22:48:20 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440559.home.otenet.gr. [79.129.177.223])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818e51sm39201895e9.5.2026.04.15.22.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:48:20 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 16 Apr 2026 08:48:09 +0300
Subject: [PATCH 1/2] virtio-snd: check rx buffer descriptor size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-virtio-fixups-v1-1-ec14e2de0852@linaro.org>
References: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
In-Reply-To: <20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-stable@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=e7CNu6bOPefkB4cYwLokIAQo8SEItIOzfhxsnDPZRv4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnA0SGdpNGliQnNkQTBjaGRjb2QxcDNaRm1IYi94CmI4NEt4MDBmVzVyYmJOTm50
 OFdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYWVCNElnQUt
 DUkIzS2Nkd2YzNEowQmdXRC9zR1Q3NG1hbHRFOFBrN29rKy9FWHlGVUVwWnpFYnVjSUxvK1JqOQ
 o4eGFveEd1V1VJVDVtbm9LeEtaa2plQnhlSVZvMkdCVDdSVXRtQUdGZVZCVGNqbVZ4MWkxTU1Yc
 2JUSTVWYTJ3CjBIcTJ4TjJOV3p4WDkxbzRCaE9QbEhPRDdCakllM21ZMytMTTFKc0F6TUZmc0Jx
 UW1LSXAwaEMrZzJqZjF3VjIKdlVydDhMb28vQmVIK2YzOUhES2ZPbGpnaE1aZUVDakdhNHJSd0t
 sSmJLdUpZUmxTa2R1QmRKT3dpdXhTYkVKWgpjck1WcUJLdld5SDFsLzFjRncvTnYyMGV1N2pvcV
 FKdm8zMWZOQWJMZjJpRzdNS2s0MTh2SUgyckJWZ0NCMEh0CldVZVpRMXpTbS9JLytnbG1RT3NRb
 GpSd0ExNEQ4Y1RSUVduNGlVajBuUTdVN1ZYMjgrMGk2K01SbVB2T0dsNTYKb1dGL0lxYmpDcTFn
 VTFrb1EwaVRxM1JFQmdYcTZvRXFieUtpZVZVWlh2R0tvdXFVcE82TkEwYlpiS2FKNTFySwptZWY
 xSW5wcnFPcEJ4ZlFCMkNBWXlXVW92OUVWcmxuMnJnZnV1T0lkOS9LMUgraEllTEtsS2FGTE9ON0
 szZXN5CmY2NWxSbkoxTk9GckdrZjNvTE9pS1MzMjFUbW9vWDM5WFN1YUFoWlN6QjdPd0VlT0ZUc
 nFGOXNnZ3R0UE9ZaFUKZ0s1MGMwV3FVeWd6Tm1VS0tjSWIvaEtGcjFzVGJFZHloUlFJL3ZsY1lv
 TTQwWlhPYjVXOGlKY21KYUJoMEJLOAp5VXM4dkRITGp3bHRhNmxJNkFRT3lTdENuUmxpRTM3L25
 uaHQ5ZHo1eDlsZzJZd1Y3UHQ1dHFBYUxTWVdOTndRCnl0MWh3QT09Cj03Qkp6Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It must be at least sizeof(virtio_snd_pcm_status).

I haven't verified if it's possible to get an underflow, but coverity
points it out so add a check.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb5cff386606d03e5cfce88f79e404e510bbcde7..93fbcfb43f7fdcfd5c164b496015da743822f5eb 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -970,12 +970,14 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
 
         stream = vsnd->pcm.streams[stream_id];
-        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+        size = iov_size(elem->in_sg, elem->in_num);
+        if (stream == NULL
+            || stream->info.direction != VIRTIO_SND_D_INPUT
+            || size < sizeof(virtio_snd_pcm_status)) {
             goto rx_err;
         }
+        size -= sizeof(virtio_snd_pcm_status);
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            size = iov_size(elem->in_sg, elem->in_num) -
-                sizeof(virtio_snd_pcm_status);
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->vq = vq;

-- 
2.47.3


