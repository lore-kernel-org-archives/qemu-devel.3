Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C149C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VZ5-0008LS-0n; Thu, 03 Apr 2025 21:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VZ0-0008JP-3T
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0VYx-00082L-JL
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 21:09:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736ee709c11so1313575b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743728978; x=1744333778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ppDuu7UF+45EoAIpM5719mvR+IPFOKbM/LYFUmyG2k=;
 b=tl7Wg7EmGsrnENd++SjSISFpuBgLQvQ75wYu5rt8JH0T6tBJoI9niO9Tytqp/F06Vh
 btMYjv5tYNeQpVg3GcvXbF3k2De5warbrxQOLYosiShAXdxwoFnwa0eaPUsE8/USWrSV
 /iz+Hdx/7n4fyhMn2K7yPA/6++e7KONuEa/iSLjBDnraEUVYK8GHzjWAZSQpbz3iGpFG
 9hw8ZKvIx8+V12nzBkB41xe0RESYhfbuxSinhIc3pi1F5ZqZsn6gVCz8HAE9pjPo+BVx
 YKUC8rf+r+xcF6lWKO6DPSbgq87W8o6PedBUUXRxYdvLZzme5CLz8f0zEura5P7JjM5D
 6Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728978; x=1744333778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ppDuu7UF+45EoAIpM5719mvR+IPFOKbM/LYFUmyG2k=;
 b=mdzV5G/Aei4MlrxwhqkVymUpAydLKK4ptxUyg6WljGDYEGlMm+GPYnoAb9viuk5L7l
 puAZP/FWW2Lz9TvmGIAaSHtJW/lxorP+Uvduc/sQLnSoyXPYdXY/0bLio2uKNQRq3E5P
 4SXRe9iiN/KAEw0WXc6pnuKX42JPOATuH4kF6RuS9yx4UjtoFY3SCke4+LsYy5RaYvf1
 KhYrLyToqUaGOHAvdIRRQWtwUWQTbYXcObYCaM/FMeoPS/GdFa//gEzCT+18Gt/RaWiL
 yyszx5ZSX5+iZ0GHxoo01dLZ3/RRDhzf0Cf36xWQC7Z5B8BgHEhuy0kFUzst/BhOIRfe
 zw2Q==
X-Gm-Message-State: AOJu0YwjqZHGzQ7+rZv+7lxWZWLnbFjcSEufe9jl+gHxxONz61FchyMH
 KKHJAQy0dvY2DCwC33CApKPe/yuODrB6BVeB7nN07KJcIJX7mE5X7HHKVhxwJXhwzKUdhHBVeVJ
 3
X-Gm-Gg: ASbGnctFhmkr6uat5ajn6vqkM5XOI96S8D70i+rTggQe+dQKd0dB4d2KrBqJFd2908U
 z36ZP3Tb9RQJLVLj8ufDPllaIZIv/LvN1im9kiq+xvq85B6/3u0x/MXF/L02N4Yx4aXerbGv97g
 MQ3YiXRIknGaoZWxQWDilRegDWxFztYKmWoU/BfpmAh2J9pFWi7PjYhmb6ZOChnyb1XgePh5biw
 L7YFsk2Ji7uJgwACNCioTUYUgdETrW0Z8h7Cw7L/Ld4uTRwcRPbiPgfy2f/o7ddfEGxT9SHt8A8
 WzdFC9Z69REj0nJZeIRUJUF9lCwMlo4knwkZjYd8quIfW3AhYLw=
X-Google-Smtp-Source: AGHT+IGmhEGrOC1HSi9Ke0+MlTTGhwtuipNGRfeXPV0VeF0Fldod8FvkNJY+kG71hy+6c2D1wffX5w==
X-Received: by 2002:a05:6a20:d489:b0:1f3:1d13:96b3 with SMTP id
 adf61e73a8af0-20107eab10bmr968530637.5.1743728978024; 
 Thu, 03 Apr 2025 18:09:38 -0700 (PDT)
Received: from stoup.. ([75.147.178.105]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee2d9sm2171755b3a.39.2025.04.03.18.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 18:09:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/6] hw/arm: Do not build VMapple machine by default
Date: Thu,  3 Apr 2025 18:09:30 -0700
Message-ID: <20250404010930.164329-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404010930.164329-1-richard.henderson@linaro.org>
References: <20250404010930.164329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Unfortunately as of v10.0.0-rc2 the VMapple machine is unusable:

  $ qemu-system-aarch64 -M vmapple [...]
  *** Terminating app due to uncaught exception 'NSInvalidArgumentException',
      reason: '-[PGIOSurfaceHostDeviceDescriptor setMapMemory:]: unrecognized selector sent to instance 0x600001ede820'
  *** First throw call stack:
  (
    0   CoreFoundation          0x000000019c759df0 __exceptionPreprocess + 176
    1   libobjc.A.dylib         0x000000019c21eb60 objc_exception_throw + 88
    2   CoreFoundation          0x000000019c816ce0 -[NSObject(NSObject) __retain_OA] + 0
    3   CoreFoundation          0x000000019c6c7efc ___forwarding___ + 1500
    4   CoreFoundation          0x000000019c6c7860 _CF_forwarding_prep_0 + 96
    5   qemu-system-aarch64     0x000000010486dbd0 apple_gfx_mmio_realize + 200
    6   qemu-system-aarch64     0x0000000104e6ab5c device_set_realized + 352
    7   qemu-system-aarch64     0x0000000104e7250c property_set_bool + 100
    8   qemu-system-aarch64     0x0000000104e7023c object_property_set + 136
    9   qemu-system-aarch64     0x0000000104e74870 object_property_set_qobject + 60
    10  qemu-system-aarch64     0x0000000104e70748 object_property_set_bool + 60
    11  qemu-system-aarch64     0x0000000104e69bd8 qdev_realize_and_unref + 20
    12  qemu-system-aarch64     0x0000000104e258e0 mach_vmapple_init + 1728
    13  qemu-system-aarch64     0x000000010481b0ac machine_run_board_init + 1892
    14  qemu-system-aarch64     0x0000000104a4def8 qmp_x_exit_preconfig + 260
    15  qemu-system-aarch64     0x0000000104a51ba8 qemu_init + 14460
    16  qemu-system-aarch64     0x0000000104f7cef8 main + 36
    17  dyld                    0x000000019c25eb4c start + 6000
  )
  libc++abi: terminating due to uncaught exception of type NSException
  Abort trap: 6

Disable the machine so it isn't built by default.

This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2913

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250403203241.46692-6-philmd@linaro.org>
---
 configs/devices/aarch64-softmmu/default.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index 93f4022ad6..ad8028cfd4 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -9,3 +9,4 @@ include ../arm-softmmu/default.mak
 # CONFIG_XLNX_VERSAL=n
 # CONFIG_SBSA_REF=n
 # CONFIG_NPCM8XX=n
+CONFIG_VMAPPLE=n
-- 
2.43.0


