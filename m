Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48079CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCGC-0002H2-Tm; Tue, 21 Oct 2025 09:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCG8-0002Gp-Pc
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBCG6-0002YS-M4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:18:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso3827462f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761052716; x=1761657516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fajL8D4qjkZYuIz+6S2Vfjd7bqCu0mIrYWtAC9gi6bw=;
 b=xXGIcEND3zDm2NFfOc/i8aYWrRrZ/UkxN9d/9UCA6AhVYOMH09xXA9vwXa7bYzSy01
 +5Sc0x+agYJpm4VHgG0RLMSGJ+ldDrmZywyf/FKU7Zksj+jacmCqg4iJjBvdhxlDoM0l
 26OzsK2V52D/H9AZ1moK6Yaoaz+FRLIs8FtJuZVQhWITRGGjIScX0NU7Te0dcEAFFqNE
 HTt+XB9s1AAU4/VWiJROUSs3M8hsPWPpLs2+U56VVnxx7S+yJVZ3CzybCC0c0AO19kqX
 /B/G7recMXbxKpKP/40AQAQMnUcs3GE55BC0jVxJOELCYtzAzc24sqLlpZQU5ulCi3zS
 sFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761052716; x=1761657516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fajL8D4qjkZYuIz+6S2Vfjd7bqCu0mIrYWtAC9gi6bw=;
 b=XqA1ziTp3em//B3BBqm2mQQqkJuJ4zRZTvtgWSo/bzXE6g8BbH5JdeVE9NDlgQ3ijQ
 L0DwPlsWjnZGQykXp2uwB/oDwndLzQ+NSN8z7rsgL1cFAcO9+sYjVQnx1SSNM6yRHjvj
 H9HhW63I+khhdBvHZHCGTP8QyTpXI9aKPcA57zlYx0pb9NTyQ8vAwzoq/hMfhZoabCQH
 D4iug5PKxRaAH+TXDIk0K183Fujv9xFa+OgBRcuP97HrXnJiXB5rRxDHRoaE6ELYyDb7
 bX/lHAvISQrRIot1a76l3m03WwuYW8vftUh/lCBDKx1Oi/LWlRD4bSgd8Qi6ZMIZLpNW
 pnHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy+vdF7dek5u7RUxzCLHo7vEJRAu5aVE2fnmEw1jzypFxbzS3wiGsJ9/RSNQe05/BsH9ooclZZ/Zie@nongnu.org
X-Gm-Message-State: AOJu0YwMiwZpl21C/q/G19rYKylCzDMfbeuOZuYnPJLayTjlJcoHLP1e
 Ldq/Vkr3S5X4AM/gb1e7Sl6ilPGcyXU3Ko89AtRpru02EFVfq/7YH8Juts6dDo2Qh+0=
X-Gm-Gg: ASbGnctJBaFDNvjP0uTirPjSK8HDgIps0cZuLoBh4G3xJywVlrN1NS3c78qGsLh7CgG
 ZF8EkDGIlrm0LAMxELbNdrda6o+Ag1U0Znoq4I6v+eqAa+slcDThtAY39TGEQiqvx8L7HiR/Gxh
 HghirBU6k9AcmSHtHklnocJEZ540vEZjsD5p8NRrFqbTRWGYcAiOR2d/iZkuloug96kTXjs6TVg
 30/8MDnvXe4gDEkKulo4D2kHpEWBKBTlbcQb2ouiIqpjuEZ2FCRVn4k0qk/dTYAWtyYedOI/nWm
 YV23rSWIrp9xb5UDmqw/9yncZDCuhc2G5nrWm1eZW4jN2KAr8Jma8LxiNbXO0j/vuwTDMuiKsmM
 5cs/sMC6FNa+sJIgVHBcRxqbdWaNGJEvlkAa53I9ALQguA2EnNtngJxbk6/K6t8MaIvGxPdUIoZ
 dbStYyJPiFI8BG5hSjoMd2qZvWYAqGwQ8xg8qb8nrtGpHIo5392+iy8Um3d3hTV/zUmrDGP80=
X-Google-Smtp-Source: AGHT+IGdTf3jbXDnwIVm5nOMuReJXchf9bxXuWcDAyHHZRdqU61kWM7AjqAkvt/WVHCD/TuSyK8iag==
X-Received: by 2002:a5d:5886:0:b0:410:f600:c35e with SMTP id
 ffacd0b85a97d-426fb6a7055mr13815590f8f.8.1761052716385; 
 Tue, 21 Oct 2025 06:18:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239f4sm282487475e9.2.2025.10.21.06.18.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 06:18:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] hw/audio: Remove intel_hda_and_codec_init()
Date: Tue, 21 Oct 2025 15:18:23 +0200
Message-ID: <20251021131825.99390-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021131825.99390-1-philmd@linaro.org>
References: <20251021131825.99390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

`-soundhw hda` was removed in commit 039a68373c4 ("introduce -audio
as a replacement for -soundhw").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/intel-hda.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 0d35afa4ab4..83bb7e597db 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1301,28 +1301,6 @@ static const TypeInfo hda_codec_device_type_info = {
     .class_init = hda_codec_device_class_init,
 };
 
-/*
- * create intel hda controller with codec attached to it,
- * so '-soundhw hda' works.
- */
-static int intel_hda_and_codec_init(const char *audiodev)
-{
-    g_autoptr(QDict) props = qdict_new();
-    DeviceState *intel_hda, *codec;
-    BusState *hdabus;
-
-    qdict_put_str(props, "driver", "intel-hda");
-    intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
-    hdabus = QLIST_FIRST(&intel_hda->child_bus);
-
-    codec = qdev_new("hda-duplex");
-    qdev_prop_set_string(codec, "audiodev", audiodev);
-    qdev_realize_and_unref(codec, hdabus, &error_fatal);
-    object_unref(intel_hda);
-
-    return 0;
-}
-
 static void intel_hda_register_types(void)
 {
     type_register_static(&hda_codec_bus_info);
@@ -1330,7 +1308,6 @@ static void intel_hda_register_types(void)
     type_register_static(&intel_hda_info_ich6);
     type_register_static(&intel_hda_info_ich9);
     type_register_static(&hda_codec_device_type_info);
-    audio_register_model_with_cb("hda", "Intel HD Audio", intel_hda_and_codec_init);
 }
 
 type_init(intel_hda_register_types)
-- 
2.51.0


