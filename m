Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A9FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtns-0000Sc-P5; Thu, 23 Oct 2025 07:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtn0-0006Yg-3V
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmx-000241-Ky
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:29 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso482635f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220045; x=1761824845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h63K7KJw7fL2qe3qT9jwFp5KsLmsyTaO/eJCwYKGslM=;
 b=wHcW0hHyPxQOfE1uS8EoAiOzB70GBDFhtjp55TCqSYmyW+bOO1216e3jY48cR3hk9S
 pOmKvObeCdAwGA2WlrPIbooFa4hGaOAZkFbkAvWIlYjMXj39iOIF/yLRm7F3HA1oHJ5y
 CJT4B7rQgo3W557dohw20PY7fKEB8E8zSzlRdXw2PfHEzDJQ2iqDKfGDAFPoN+eGSZsJ
 Va6b4vDqEHvVD8GzUSRBLxmYAncTbBuZJ18y35g1HkhRDED/hbUVWv82kRofNsG+CP2u
 QfkBlHkabKLCO3tJ/1WrJ5/fbgAC+vyvH3BeWDynzH/H9+5V8AKmbUl1NvJ5tSeXAiIL
 A23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220045; x=1761824845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h63K7KJw7fL2qe3qT9jwFp5KsLmsyTaO/eJCwYKGslM=;
 b=jN5EX3VLufngjcC3RX1TOHx7T9m+6wd/WAh2ZlMwXXVQZIUtAc65yYxz50ztT5AfU3
 2xaWi4FF4Bf4WNipKMtfKwSdQ+V4LU/YS+ZjTeWbbwjMVOrw1GLTO2PPm4X3y+hGMYzX
 eSAnPpYiQ85JCXv48J4lNUIhZaVCJj/gbH3AxnnhL0nxi04zkilmVQvvTgxLfrzd0LPT
 j6Say/04JYjCAfO+2lSpB9+ZvsZ+000HJwAlA1azkYYSI6KvvTjH0OLy/r7NFRMNObFF
 XvJ8Qb1RXOS2K/c7YTkW3n2JcVaP8BWp+dRxQUtC2RLTO+WEaDXrnBth4df2tzjwT7Qc
 SdHQ==
X-Gm-Message-State: AOJu0YwolUwYt1hoUitJNFT57+CglOYtWGHsVrvEUgo0OjojLGYBGY/6
 r67XQLEfepGQ1YWsIpDLEfkTNQfM0vQJg9fE5WeUSrd0uLDRCFeI6aj7lqTETdcGO68gDtThPTh
 DAlSMlVA=
X-Gm-Gg: ASbGnctJGZhq7U34vfgS1h+bKEM5r8Pwg/LLAVhmd/pdWdloGakopiQvGhqpQ+1OJgG
 ZkJgLTjPMmMbf/Wh9hfXtW3l0EcZ5HY0Wi5lTuY0C7v9d/KZVS8/K3K1PvNHDBSc5uEIecZ61PA
 g+JwykTXx+ZBovwGJTYDKOoAXWmJjxeOVQ60dTWzNvbyb2tLDkuSRToxVLlC1lo6X2v7+JmY/nU
 oIj8Yqx1mG6mBsc8Ucvhj3HABYl3NGehA1iGGiqhVSFIoNhQq0lzUP3KxDqU0xKOzQq7sLOfHC7
 3rz5ayFEQlkLNH2DjVRq2bwvOROcBU8GlFDDPrEm1RFJTmru6vVlZnmk8Qr//903BGB0ljjOpjC
 GF6LkD7YNTMObG0NgoELP4L6aAPdH7rdi/+vQntXdWQ5Y6cVACe88GUIOp7vOQyV1UIFD4ueLLg
 LmgFB0kcNx5c56c9rtQk8ZPF8NrzpezbwPPg90v4hdpyq+eGgmCnZEd0Rf6XDQ
X-Google-Smtp-Source: AGHT+IH0JlxvZ9Ihmy0v6t2EA57oaNt6DUR1PpvSghdctPnkjO4L4AcRnlPzRxr4t9cbHTlxQ0VS2A==
X-Received: by 2002:a05:6000:2409:b0:428:5673:11c5 with SMTP id
 ffacd0b85a97d-4298a0e94b0mr1607432f8f.61.1761220045357; 
 Thu, 23 Oct 2025 04:47:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898eb549sm3504059f8f.41.2025.10.23.04.47.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:47:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 09/58] target/arm/hvf: Mention hvf_sync_vtimer() must run
 on vCPU thread
Date: Thu, 23 Oct 2025 13:45:46 +0200
Message-ID: <20251023114638.5667-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since hvf_sync_vtimer() calls hv_vcpu_get_sys_reg(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8095cb0805a..bfccf5e9a2a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1764,6 +1764,7 @@ static void hvf_wfi(CPUState *cpu)
     hvf_wait_for_ipi(cpu, &ts);
 }
 
+/* Must be called by the owning thread */
 static void hvf_sync_vtimer(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.51.0


