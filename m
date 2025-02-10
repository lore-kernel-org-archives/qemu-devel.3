Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4C9C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacz-0008Ju-9v; Mon, 10 Feb 2025 15:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacx-00086E-HD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacu-0003i3-Ql
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dc9eba8a1so2960001f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220210; x=1739825010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlCwGl9a0Wn+Waa2w2Ewq41sfDqQZGhbhfbBayKi8KM=;
 b=fo6a6gh3zZGLz3p/aMTH52JnHEhQddgu+ScHtJKmhxMg/EbvD7csUesQoAmHxmPQP1
 3FY62X/WlE9AjnRcGx04JPn8ddjksySiXfzqaqJ7nkyp8N0hmTN+Gdxunjgz09Oyswcd
 +rZ4bj0mjth/5uWuUvYM4XuyvMNy3x6GtMXPGf2lVCU3oC3vNFwfg/V2BSktuN05yYo1
 0LWglYaxhd6twsFvj7g0+LDRRsiZc9eQk/TlAfgSP+v7FroQEcQlRHj2v+4tNbfYhoka
 272Pt1P22rkuzivdX2TOknTBbIEefR8iaaMaawJ68X5mmWcoEBMFL61U5DgpGBLmJNiO
 GT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220210; x=1739825010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlCwGl9a0Wn+Waa2w2Ewq41sfDqQZGhbhfbBayKi8KM=;
 b=KLfSD9bbQUwvGKj2sGgA9rJblmboob2ZdVWwe+oM6i7Ryc3NYANuC2Aw7x/T9oxrDy
 HKrzZLFPK82a2yB45kbKPGPu0npOtIkZ35KLCkxOFWsg+hSOnZ1S5msmzFkpt3uNHslA
 flwCYqeqOgnLjffQCeSeEIOp7kX3RxPHhe1hwJ5Ui0xyBJGkM3L4/ilo+PpRrwmWJmcS
 UZT3B2x9c83PhSNdvhXbSLpb/08Yr30l6oeOfn17Y9IL5h3SvAxeXKgnZC9q5QGEuW50
 UpfXsRdz/oVyH23/lVe7Jf/INPNX9zplPhJbe5YkmQ6IpoWhPYgIfT0ye9smP1d7YSUd
 50dQ==
X-Gm-Message-State: AOJu0YxCVeSN3LVK4T5JXlG6Ae9yP2oBiHfSWViSxcdUT03zEVpfQZg+
 QPWfn5/zRxNXh42L8xaw6LzmoJN44rui8GSbnnilwucOQgc7S8T6bTsrrAO+Y4Dqmav9BQRhvR7
 30kg=
X-Gm-Gg: ASbGncuvHIKCiYyrSAur1bWW0wvKbKdDRMq+SJ8vnUszjfhVUj9oPqOFsgh0yi7+p8k
 F90fJGQLk5dqRl7E7ZwlVAfm2ad/y0yHnjJHyOyG0Sd1MPkNNQks+ksydpCxdSs7BAWZaTZ0+M4
 LzdZDV25UB/R3gJiH/G/I2x/XsdiPKxRLsewEAL8u514QOUDOSMWUc4tVtrqlwmdKGycq7FjrsQ
 heQgt4TGPOIhT2/qvMv+y6TyJWbt7+aE3/3xZaS8CdeRxeJ8ye7oUG0j/OKCG/HSJpph8jKGG+r
 HbCAyziUsPtD+VeuSbmFg0KUp7rU+T3FLeUg7ObDV7zGH/Rktnjpy1N5EbF9c0LwuQ==
X-Google-Smtp-Source: AGHT+IF+WS+y6upoHrlyoJD+cE1lj0c9LPmNepAqWvs7ZfD7lYit6kIlFiU6GsdGEN30xApPmHPuzg==
X-Received: by 2002:adf:e6cb:0:b0:385:f72a:a3b0 with SMTP id
 ffacd0b85a97d-38dc9357796mr8459637f8f.55.1739220210461; 
 Mon, 10 Feb 2025 12:43:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11264sm187851455e9.35.2025.02.10.12.43.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 16/32] hw/net: Have eTSEC device inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:48 +0100
Message-ID: <20250210204204.54407-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Because the network eTSEC device can be optionally plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250125181343.59151-8-philmd@linaro.org>
---
 hw/net/fsl_etsec/etsec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 781b9003954..3ce4fa2662d 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -425,14 +425,12 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->realize = etsec_realize;
     device_class_set_legacy_reset(dc, etsec_reset);
     device_class_set_props(dc, etsec_properties);
-    /* Supported by ppce500 machine */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo etsec_types[] = {
     {
         .name          = TYPE_ETSEC_COMMON,
-        .parent        = TYPE_SYS_BUS_DEVICE,
+        .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
         .instance_size = sizeof(eTSEC),
         .class_init    = etsec_class_init,
         .instance_init = etsec_instance_init,
-- 
2.47.1


