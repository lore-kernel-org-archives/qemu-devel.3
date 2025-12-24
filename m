Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AA8E75458
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 13:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYPDS-0006Ze-Hz; Wed, 24 Dec 2025 08:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPDB-0006Kh-P4
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYPD9-0003jJ-DG
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 08:47:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso38874915e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 05:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766584049; x=1767188849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEDW4pEiOQF8aZTfRkTnnN7IXm4k0EgK0HcgihEUm50=;
 b=XrhVX0ttzGoUcaMV8zurqxZEZ16jNyjqtSICZY9/hwZ3yvcb0ILHRhvNqNEMPc5OZn
 1GQY2TIA2CbWlc2WkCf6AWKtnoVUsP/Oc8AGQTvDK0TuISCkma/sqWoHygRxWhXFCnHv
 MGr6Y1zeoELCsSu1+e1rex4GJuO+wEFM5YzhehTqeVeCAWhz++x9JTJMz9uQ1mbPmvGS
 iFSHDB6JmPyRGBw5N0XlUdIB1FR0BjkzFJGix4jxY0SqGMNgETjtdBeTU2OLi37WF4jB
 QtFvCHsKUtWuI58vLpiAyWJRdnKTy17MbISxQPYXBW0/v7vbmhni1xGZF9iHjpBKYA4/
 HxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766584049; x=1767188849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vEDW4pEiOQF8aZTfRkTnnN7IXm4k0EgK0HcgihEUm50=;
 b=Kpde9uTCmPJ65/nkTiTdD3PgqOaxMKxVHFf48/5NZLF8XfdyasFf2fmG7vHwpkgSku
 /CG34FpMfsD2dDzzgx9udOTFv3X7xxpAX8AuCrDaxwiMMTx/3UZKAYH2lNwwtYqUJVSN
 i8646rI1TiUooBN8dssFvIr+tr8f2jer9MvTEHPSGbnsTH++oFspT3qZ5HdHVmvoNQGZ
 WhG+5CT7KCi/ZVQ41O4d3LOEd3XklWWfAAouKsP8/M+lTh8Xl6HZ0qRo403x59vZjaVO
 8Yev+wgOy6xqkph9tnjzYM1slpiJl/EZdfrRIyz79Xnfxq0EskBJlonYjWa8eR0cJhZE
 yLxg==
X-Gm-Message-State: AOJu0YyeysIfXjkSmgdRTnredEQ0mvJsL9iLf1+yG5IhEegaSiHhq4Gv
 XSO/y8DTy5ykRcXM2Bv99o9Rv4dn3x9twbsxroA37iF6RkOTnluWw0XrmtF7nzqjHTTeGHdVn86
 rqoZpdmM=
X-Gm-Gg: AY/fxX793iIc/AsuepSgaBDuUYJnO8xlaXcqd3bcdC7DBpwuh8a053xri6MSMv1t62G
 40zWw/p76jUTR6hChVCvD11WdcXhgyjvt6IPg+xj6Rsb32GRUMBV02GC7LiwGMN7ivoZ1h061so
 MQV6jlOcr8TcHLesSY88vDYl3KtZskRyMUAl2hOXGfWS9DMs0OjvVWdJoqH13r3+rcIWPZc3Yit
 VBXl+bP0sNV/IWA60eP2QaSWUYF4dli1utvPvr+wRzJ4OS2uGeZmvt3mq1JYLEP/3qO1yX9QTpZ
 yflfUd+d9JAi7UBZ+t2YpTwM/0P9Tk6/A9RRc2M9/IY4gD/Nw2ZglwVjwtxvxEuVRsHoBbmWmb/
 Unnb48VFOLwrW9XYdQy2S1iby/ZRMgrZ/cfMiWoghbvpwE1GkL+wSJG5/hDLR88eLXlAvyyFZVr
 YBk+plk6zz5VhPWS+HxvA3UCqF2+m6MhCkPxFpaDttmlRnVWXvM7dY5FR59nqP
X-Google-Smtp-Source: AGHT+IHnqJsRELm10jBU2RIDVAqxKRtc3Jq/rf5twmbfPMauJFhpRv+bid2csAak0epOYGPiW2VxtQ==
X-Received: by 2002:a05:600c:4ece:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-47d19576da2mr172053595e9.23.1766584049207; 
 Wed, 24 Dec 2025 05:47:29 -0800 (PST)
Received: from localhost.localdomain (218.170.88.92.rev.sfr.net.
 [92.88.170.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbc0bsm300874335e9.11.2025.12.24.05.47.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 05:47:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 5/8] hw/timer/hpet: Mark implementation as being
 little-endian
Date: Wed, 24 Dec 2025 14:46:41 +0100
Message-ID: <20251224134644.85582-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224134644.85582-1-philmd@linaro.org>
References: <20251224134644.85582-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


