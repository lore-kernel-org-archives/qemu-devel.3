Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812CBCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkPP-00083h-JS; Wed, 03 Sep 2025 06:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkPB-00081b-W1
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:07:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkP8-00088E-S7
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:07:52 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e18aso4041747f8f.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894068; x=1757498868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dc577sdHNizEE5xrXzfqcyEguN+DMomdpbX0f6y4H38=;
 b=ACMWP+i1B3e75/nCjWSLkw+5Ra7b4C27mh0yuS9Usx1Jh0Yst2yHdSd/EOF5BDWjT0
 nM4VdPOtJtqxOyNe3Xc8itpb+LPQibuCY2vkevMJ4AvLfm1JIV/hthksKLMbm7D8bcLE
 2Is0RoF/odZZgda8+f5jnJEizrp+blYqGabLoockiC72AtYsPrIdRT56/K1ar9KP2/Gk
 7KGEXZbH/q1udVQnCETS9f7FcYbRprZMR0xfPoXcvLvQnDN2QPNSnX4v7DxcBDFHCgRy
 RAXztHUuHSf1WpqnNvYUdiTP8MpMFJsKDpl0noRASE8l/GdP15q2a2+jh2yf7G7uou/8
 ZQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894068; x=1757498868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dc577sdHNizEE5xrXzfqcyEguN+DMomdpbX0f6y4H38=;
 b=iLG3BSCY5LoUyX8DpB4zvQdE2Xn6mXeUXYApuSyuT42d+NPa0zTsvy5FCmhoeWl437
 0my+a/S2qj4fxHtDv9KUsLcOIgwwXe6JRiN3YYHuhrliIIm4HE7WYKU4rLIajOzDHObx
 I/nDJ9UN1JN+B1oRSG5S78Xzy/TXjX9U7wLVvYnrMdQcm8Ml4Dgh3DWlZAUsdnDSgK7Z
 HNEDtfOFV+omjls4q87IdpVoprTIvGdiBIIFtyXAvPsx9eeUFfy1sED7801ZxMcILuOj
 cYOZl00fvEP3/+VG9u+EDQ+o8038ju77uWSy/uT6KOd2Os7L2CXGY5gaemzbcJ8FPzNM
 IHHQ==
X-Gm-Message-State: AOJu0YyPgrmJsYslhrs58+q2+zSuTthrHQeKl9gz0tT+Gb+aD2BUk0Km
 zmWbwiDxWr/Vy9gW0IZ2Xc6asXihH/6HBtJxOsvkjSnENr8JQF6YHTVhPVnJa9knVl60j9MOnMl
 mmGORdPE=
X-Gm-Gg: ASbGncul3jb8IWQfbB1eQzrOgdxjM7p3oP4q7V+usBunF7vlLdlGticiqB+uqAmbAEq
 f9Eth5CKUnjTyQoTl4hgiHJvIfkMa+dEICKozqwRpQSOnsCR2P49UIYD0PSA5QKXk6O4CHPh7+R
 goOSbHfz7HabT4n9TEFgYlA1Q18lSfBuYQVJKB/rtPlKytawMDij+D2p+pONiQGuwpGvBAg4EK3
 sY0zu2t0Ml8A9KZo+achh/qDwivh3A6g45Hw0sMUWYg+11/xaMMTveh/YfEw3q9fs8zdBWwrMtm
 DUz3HkReqSv1fIJhLRJIFnH1nwS22FBWX4TUwz9awl1FLYC6AJujz4NI1g264ZWi+cmIAcV7B+V
 AoGf8kLHyRI8qD2pAZHwfurwxWPmRv2CUjB6tKWGVlFp879FDqalsxLi7/w146dkjqin4G8tyor
 3WW5SBIPRFROZaV97p
X-Google-Smtp-Source: AGHT+IFtIgdxUByXzHWLwVWdk0EAygLsYu1MsTlpkiKO8Q9Fkx/wwDOhAL23xtp051NyXFX4+RQazQ==
X-Received: by 2002:a05:6000:2dc2:b0:3d1:1328:450c with SMTP id
 ffacd0b85a97d-3d1def6a59emr10272671f8f.49.1756894068595; 
 Wed, 03 Sep 2025 03:07:48 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a1f807f9sm22209678f8f.38.2025.09.03.03.07.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:07:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 01/24] target/arm/hvf: Release memory allocated by
 hv_vcpu_config_create()
Date: Wed,  3 Sep 2025 12:06:37 +0200
Message-ID: <20250903100702.16726-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

hv_vcpu_config_create() is documented in <Hypervisor/hv_vcpu_config.h>
as:

  /*!
   @abstract Creates a vcpu configuration object.
   @result A new vcpu configuration object. This should be released with os_release when no longer used.
   */
  OS_OBJECT_RETURNS_RETAINED OS_WARN_RESULT
  hv_vcpu_config_t hv_vcpu_config_create(void);

Release the memory allocated by hv_vcpu_config_create() with
os_release().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b77db99079e..d67372218de 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -150,6 +150,8 @@ void hvf_arm_init_debug(void)
     max_hw_wps = hvf_arm_num_wrps(config);
     hw_watchpoints =
         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
+
+    os_release(config);
 }
 
 #define HVF_SYSREG(crn, crm, op0, op1, op2) \
-- 
2.51.0


