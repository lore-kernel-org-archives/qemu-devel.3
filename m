Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1063FD6E2D1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIb1-0006YA-Ig; Thu, 18 Dec 2025 13:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaW-0006PD-72
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:19:03 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaQ-00031P-S1
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:55 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso11461425e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766081924; x=1766686724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bvj1AJund8BJzCKIAsZJhSHjk28uN32H7UcwVRZ2KTY=;
 b=v33p0i4VKUWoTrO5d25jBdmpuJ/6wkvkpqkZpouGO52lZpi6RRDN3mPlsMxjhehcu5
 JXv+3BTR6qsS3Q+YXKOGNtY85jciKbHGbdYJEfTg8GqiJl9aGBpfc3wKj5GwlbKOnsvw
 FoDUOE/N2gD+lkMsquR279yJiloaNjZ0eOio5poMBokTxvtzUQCU9/ZW2AwZD2sFh+SX
 MTmaaRLVZCi3zHg2dE6ug+5TSEFJX71Nfb6H2cUDqjbkm9ptrv62S9oamIo+p/49OpV2
 vdhSDaKE52miIfGdOI5HhaUU/xYTBIBLpSkc+rfIyKf9wlF3inXo1kRB5Aze5DXGc10/
 HDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081924; x=1766686724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bvj1AJund8BJzCKIAsZJhSHjk28uN32H7UcwVRZ2KTY=;
 b=L2jr9pIPaBo0RrdctX6l/bkjcOAdMPwnyrR4vyCXqTMfAWpC5UUDE59/SvuRAxw9C8
 s2HQR3mgViZlGXt+c9G+ZqCnOq88T66zBVzkSQlgc3SZwdl6vuwe0KhylRPFM49O9esz
 gRt1n8eEbl61+fDBHYSDF9sSP9ZhP7Gu7ut9yoM3sLf5WVxG2/vlgx/9oFntx/FnO+6Q
 1WxPeEQlSYA0wY6VsyKwqol+2K2YMFXdVIMRsqNfrKfxE0GmWTj2oJpb/S4/399ddLcU
 9vpSnZNdz2zfQ5IaM7T4WueUAaHL7mibTw5S2uBTSaUmSCCA1CEQSSOFuLPNPSR0UAZm
 o/3w==
X-Gm-Message-State: AOJu0YyPnrhAvEU/VltJ2buKOQk6wNUKoVWAxE2BU7AhBk4MnZrgJnDS
 EPjVM7A0chFoxY6nBplyxTUE/kUY00YkOrxDLz4VqSl1D0HDplQ4jK9EKo/beb6dRWnTLFfKB00
 cM6h+Kvo=
X-Gm-Gg: AY/fxX6lcUHf9sawhAzGZz9/CylolwCvyWi58HiaAbs9yT5hcDrmTu6D2klH6XbYS5J
 vWZonrk5nvT57R5whWxW196/wNybPa7d8HL6qLBO763flPIKl2/pKSwyYidAkglP6xH5ZJk2Zzo
 9ALNL+/htnyHD3epOZ6XiemzPBW0NsYHNEZIIWH3kQL8fMFLv+Rf9q6m449a7u4nX1HrXYCtSAi
 SAb01vL0JnlL+NkE6vcYG9aqhmBKf8KE/hL5WWSo6a/JvZCp5IvyB1YcAMDHNEiS9zWJZo7SAiF
 KeGe8qg/kUkxLXCZ5nFZxx91JuaF1WcAkkGoqmFJfZ0Lg0oIgkA3CKw5Zl077PBP8J207wsuT4T
 s8XRxyXuY4ibENdCEcUkZa4WIZWUmuk1fMTs4u7254P+bUBwbnsghvKtziJRlBLJfD1OCU24XWP
 29iUnz7dXW65PPGu1LjDx2UetwOhNPcjA9P50+jwEKo+AFBwlWr1a517YzRFmD
X-Google-Smtp-Source: AGHT+IHHuTTKYx9RGCYajCMCUuN820Kiap/GpFsIBYAXwUF34Sg0U5YEuJQg4DCduJdHoGUzZRCizQ==
X-Received: by 2002:a05:6000:250d:b0:430:fa12:3b6e with SMTP id
 ffacd0b85a97d-432448bf55emr4584653f8f.24.1766081924100; 
 Thu, 18 Dec 2025 10:18:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm199771f8f.29.2025.12.18.10.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 10:18:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] hw/timer/hpet: Mark implementation as being little-endian
Date: Thu, 18 Dec 2025 19:18:09 +0100
Message-ID: <20251218181812.58363-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218181812.58363-1-philmd@linaro.org>
References: <20251218181812.58363-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

The HPET component is only built / used by X86 targets, which
are only built in little endianness. Thus we only ever built
as little endian, never testing the big-endian possibility of
the DEVICE_NATIVE_ENDIAN definition. Simplify by only keeping
the little endian variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/hpet.c                  | 2 +-
 rust/hw/timer/hpet/src/device.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1acba4fa9db..bfad626d5e1 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -648,7 +648,7 @@ static const MemoryRegionOps hpet_ram_ops = {
         .min_access_size = 4,
         .max_access_size = 8,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void hpet_reset(DeviceState *d)
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3564aa79c6e..4f4be84115e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -708,7 +708,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
             MemoryRegionOpsBuilder::<HPETState>::new()
                 .read(&HPETState::read)
                 .write(&HPETState::write)
-                .native_endian()
+                .little_endian()
                 .valid_sizes(4, 8)
                 .impl_sizes(4, 8)
                 .build();
-- 
2.52.0


