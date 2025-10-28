Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0A7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcbO-0001Yk-3b; Tue, 28 Oct 2025 01:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcbM-0001Y7-B7
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:50:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcbK-00047w-Cr
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:50:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso4071607f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630632; x=1762235432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bn2C92Ox23h5s0IuScw63a4Ihrbd//B4afSM1bgktqo=;
 b=RkRxdODHQLzOEQ5oodl8Ukk5TFGZI1vtbQVsxzDKZ1x04ez/lHM2dgZtCztzbzWKst
 EL3m1lIin7MdY4MDfVQhvL/t2BJjR5jRjGedqRvK1ENTj6UOjCEbQwc1iinUTTmXlqs8
 MEZbuMxU6Fs2zW5nCGaNd4NryZS5iSXzqO1ovdLQ2xHWNy4ahcV98E+ScBvA5w0qEsTS
 xAdNu07Zp4Xr+J80qqmi0LamggkMG0b3ZoEzYhInzPE1L1P6+owmEP+GfYTyNG/qG2Xd
 PowwTeqs6D5AlOhrDGQ2CG7KSnjsH2iAEa83VFsGhANMGTODgsZ8/0yQCD2FByINa1tN
 ZcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630632; x=1762235432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bn2C92Ox23h5s0IuScw63a4Ihrbd//B4afSM1bgktqo=;
 b=XJW8jeLNvz1BtyHUhP4gcUVTbd85Ajz03OYR/ojbKTy0xtEIhFkI7Sx8QbbR5wJGpb
 bULZ9cXE0A/aRv5N+QKsO5A+WfS2TZYuSWVqg9wczj0snOvXAwI/4YAMpvaWfYIJ4VW9
 5iZh06iqw3byFRZA/+wklUpFgcqPFcwTPsU8KMGXS6l6fqn0NdT7K1Tq4jYu6Hdq0I7V
 qJUwBy+0BpHJgYbr7f8NWLV7N/HCvk7/OSY0rdkcMiThehclvx5elbBWKazZb5qcOslM
 RZMrKX4Wd+9SQ8zV0O6IqwECAPl23AeK65f2C8dIqiAr3oGPKEo4flRr8yMvO5Y63Tve
 7BFQ==
X-Gm-Message-State: AOJu0YxulOfBMCQDCxHJQb4qLTHVdmz75r0arv5Laj5bdQuuyO/IhhuX
 45zcdBiH6RPWBkpGuIwS91NyNhRZqRrMfHpys7dSPZxlgyE0zqH1HpqT5beFjaagFscA0TeE4DU
 HIGaLdVg=
X-Gm-Gg: ASbGncvHQ79MKhflfVESvmGW23Q6TZzT3WD+mmwcukDp1Is5ivnyY8oFuePDHpnJHu8
 0EovN18eMkRNTn3gAOtkGtOLPg6e6LHgxfrnqEel05AAB/tZiZfWgbqu3uv7qK0oj+SvTSR0n5d
 RFDpxfIO1KrmtD3toJ7dNjRjOpDQrx05H68mBDqLy/5TYKe4xupeLX8rVc8GpoUau2uPwA67RTL
 ytkKb4RDr+QZIhlFFrroH+4z9+CrqI7VdI5pmwEwmIoLfde0/OcI1vZ2Eg+ueytcM34fv+1uYt5
 2PGemrx6Yo1pASwHiDPlQVLklEn0s/mKeIP/65MLset66iDKeCHRYwF/RSexp9xEBRnIoE6wQIJ
 2621gH1mAL8dSE21Mm/CAaGGiDfYnMiI2pgangICOI+MaKW+cvMezzuRxzR2qILO1YeNsncv8hq
 9/HRbFNX43tdjex0wnozNk+AiLCM2+Ax0kP2thxQfS1Y3ak/tcc2J9pk2Jj6hQVZNPpQ==
X-Google-Smtp-Source: AGHT+IGSglBN+lTnjgmy3R4hdyxRvhXy8vCf+1szzhrxs7W2rxaBTq0xanpi+n18Rxek2tCaqHX32g==
X-Received: by 2002:a05:6000:2c0e:b0:427:9a9:462b with SMTP id
 ffacd0b85a97d-429a7e52ed8mr1550126f8f.18.1761630631830; 
 Mon, 27 Oct 2025 22:50:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb2bsm18324137f8f.13.2025.10.27.22.50.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:50:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/59] accel/hvf: Mention hvf_arch_update_guest_debug()
 must run on vCPU
Date: Tue, 28 Oct 2025 06:41:47 +0100
Message-ID: <20251028054238.14949-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since hvf_arch_update_guest_debug() calls hvf_arch_set_traps()
and hvf_arch_update_guest_debug(), which must run on a vCPU, it
also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 include/system/hvf_int.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 0c335facc3b..241c668795e 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -83,6 +83,8 @@ int hvf_arch_vcpu_exec(CPUState *);
 int hvf_arch_put_registers(CPUState *);
 /* Must be called by the owning thread */
 int hvf_arch_get_registers(CPUState *);
+/* Must be called by the owning thread */
+void hvf_arch_update_guest_debug(CPUState *cpu);
 
 struct hvf_sw_breakpoint {
     vaddr pc;
@@ -109,7 +111,6 @@ void hvf_arch_remove_all_hw_breakpoints(void);
  * handled by calling down to hvf_arch_update_guest_debug.
  */
 int hvf_update_guest_debug(CPUState *cpu);
-void hvf_arch_update_guest_debug(CPUState *cpu);
 
 /*
  * Return whether the guest supports debugging.
-- 
2.51.0


