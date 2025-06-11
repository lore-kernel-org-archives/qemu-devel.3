Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45949C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIa2-0002D7-9J; Wed, 11 Jun 2025 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPIZp-0002CK-L3; Wed, 11 Jun 2025 06:21:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPIZm-0007kU-IS; Wed, 11 Jun 2025 06:21:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450dd065828so44886435e9.2; 
 Wed, 11 Jun 2025 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749637256; x=1750242056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/tNXUBRudCnawBpN+yhXNppZ2tVapiNiwlXy0Y0vHHA=;
 b=BUmcBcPZuEgNVtV3za+y6a0UBlG5wPPpLMLj7oUceOxbFkdQ1/eEsZELT3pDvlBjhz
 15urQsBv7ewXgQmjSVF01M/5EJKsVMtOzGQD5a+XmE9+V1qrwNCvtsRiqmUeBkKLIu0B
 cXNQeL19CyiEemaGlcPksnyMm655K6X35vl48NmuRMXJbfxGuvKhm1D3niw8pn4SUDMZ
 UZCNxICyh7/K4X1FKX+MRrDLR/MOZal1sfPG9zwviYTAuRPsSUOobjLRq7O5hL6IqufA
 8Wr+K9Bq/K8KZKV5wbpxopwtmKLZ3fbkSZH4dDCvjtTvhgKmdgrS0kCYCq/UpovrC9Hs
 IAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749637256; x=1750242056;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tNXUBRudCnawBpN+yhXNppZ2tVapiNiwlXy0Y0vHHA=;
 b=a0DMTbWG6Py+/LWBUMIqJ+EFh/M/0TEXUsM4WyZJdr+CKvTWyWE9eAajRkiESB61XD
 uU7ovHev+d0Az3rK6LMYpr0Fuiqs++bYfl3Zr/ggyXSDHPN7hfDD3MT5NFi4DQ3McBzS
 udAXB45F4GCN699AIBSDDWajc9pCPvrSY4C1/d/Yr1njU7HWvAiuW0gvvJR8RGnbCimX
 +sp2UODKiuoC5ZYNM0zg51gZPCiEMnMhFM3Y3twQQKMTix0lxcfPIHSNq2pxuez/0rqx
 2PKoAtJP/FCr+M3iEfIqJO6+0Dz0Fp+s2cWm8oq2gU43QnV2oRZjz7mnDr3ivOktcPYe
 TIaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfHi6Kn8ZvLGSkScLNcGnNeAiu6DqzGZDvPK9SZ6camGm47lk1+24ZDw48Ug6BTeaiTZaErvFishnS@nongnu.org,
 AJvYcCWTwMbTHPk/3fNWFxq660QmIo9FONJ8qj3DGUanIPoRvgTL/6PXDdTVm3ITzFe9XifUuK/vuXZIl516@nongnu.org
X-Gm-Message-State: AOJu0YyiUGUPLpO8TkLRoNU0UIj31Gwi9Lq+LMFScaFdUw8vvd/Fjzei
 9XnTmbDw00hPDxC80QJNi1MMZzbIaRxkN05OO2lZaIzKmVIyHoqFQVti
X-Gm-Gg: ASbGncsVwo9P4xurL9/7FWM2eGTTLPkLbLflNnr6BpKE8LCMUDiioPQvq5d3PXvaium
 KPZiUkNEHvT60mauz5307/8NVeBuAxmUl+EIyejLAG8IXff4Xlm3QAihX71FDLREXUq25smdWQM
 HEbco7plU+vFDouYlSZkaM22p9TMobWg9tNwMfe+LRM8u4fTeN0hmpVP0LdTK5d068PFc4RkZ0+
 sDtdRddsKtM2D8nyDGmQ20cdMRJsfEMlCKGIfFrv0HTzZ53uDR9c7mA9+m63UTyx8s4msRKHrOs
 3X2xQkzE+FoDEni8S4ieM2X5tmwDuJZcWGnsNg468Ad47Urkck6tqjx8
X-Google-Smtp-Source: AGHT+IE8eeQr89g3QYsLomZy2KWncJMdO+GWPn365KRTenB+6DvGtt9fQ+Imno7dmMew8eYERJp+vA==
X-Received: by 2002:a05:6000:2088:b0:3a4:e6b4:9c4b with SMTP id
 ffacd0b85a97d-3a558a930a6mr1905681f8f.1.1749637255956; 
 Wed, 11 Jun 2025 03:20:55 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532464581sm15022875f8f.95.2025.06.11.03.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 03:20:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:20:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 2/2] rust/hw/char/pl011/src/device: Implement logging
In-Reply-To: <fc9689e4-f48c-4174-be02-9091338bfa1d@redhat.com>
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-3-shentey@gmail.com>
 <fc9689e4-f48c-4174-be02-9091338bfa1d@redhat.com>
Message-ID: <4B9BA81C-3E8A-4346-926B-1E17619E2009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Juni 2025 07:55:20 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Ec=
om>:
>On 6/10/25 22:21, Bernhard Beschow wrote:
>> Now that there is logging support in Rust for QEMU, use it in the pl011
>> device=2E
>Adding also this to match the C code:
>
>diff --git a/rust/hw/char/pl011/src/device=2Ers b/rust/hw/char/pl011/src/=
device=2Ers
>index 42dfa9509dc=2E=2Ee505abfae86 100644
>--- a/rust/hw/char/pl011/src/device=2Ers
>+++ b/rust/hw/char/pl011/src/device=2Ers
>@@ -305,6 +305,12 @@ fn read_data_register(&mut self, update: &mut bool) =
-> u32 {
>     }
>      fn write_data_register(&mut self, value: u32) -> bool {
>+        if !self=2Econtrol=2Eenable_uart() {
>+            log_mask!(Log::GuestError, "PL011 data written to disabled U=
ART\n");
>+        }
>+        if !self=2Econtrol=2Eenable_transmit() {
>+            log_mask!(Log::GuestError, "PL011 data written to disabled T=
X UART\n");
>+        }
>         // interrupts always checked
>         let _ =3D self=2Eloopback_tx(value=2Einto());
>         self=2Eint_level |=3D Interrupt::TX;
>

Will add as separate patch in v3=2E

Best regards,
Bernhard

