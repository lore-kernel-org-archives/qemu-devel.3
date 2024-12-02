Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E28D7831E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Rz-0005q9-ST; Mon, 02 Dec 2024 08:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GV-0002Ho-2M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-0003R0-CT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:01 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so26680735e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145284; x=1733750084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3RxyO1FT5e89Qph7T+rokhc4ELopzGup08oCLW4wD4=;
 b=jorZy3HOYx2Ct7ZBr7GRmEY5qyA2sEHqp7uwZmyIbIKyywoXx/RD/Eoi9OegRtsTlU
 fzUFpNa9rAEgTELd3+azC2Si2+Ctvl7zn32LjEiurHpDIK7sJ/WsxZLlEVM5cU19uN64
 LrWw70aAF3rmpJt4PfQsyCF/xkH7A5+YKM3k593Pdios8VchUO8HsyfRgJSvMTfFbzxX
 x8rThsJOuvfBgdw25c6R5LD0xvxfegGVQ3OyuxLEK1YCVaj0tzQIbmlGNjPZ4jvk4CpB
 3lfH9nlJF82JwcC5X0Eg8b89/qSbvvytrPpvDeYcoNQ2YkRgnBIRfosOJAYj5+ZIFBDm
 bTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145284; x=1733750084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3RxyO1FT5e89Qph7T+rokhc4ELopzGup08oCLW4wD4=;
 b=Uj+xZywQZnxPsDYC/kOrMjP/RS9tHLrUN9SfVX0jiCeBFTF56qsJfdDWEh7IIe/Z8c
 u5oL1JERXtY8vuIccrraYH5wo8QmK//ElogwB9e5xcNpC9qG8TBDyKmvoo3FlYwDhP90
 aIadpFtfovBM67CavLemnc9Ee6sn5a3riqzOGH8om83DiCdH27ObemTpLht5zteaTYuB
 4j/qJMqqpeB3MzARD/g8whgtCm8C/x/Lz1cfMfKBOywoHZs3rAShn1VaXYvAh2QEMclI
 ieqmW/sgfmy/xyUXTpuqTPr6eRVHYhzml1FQuVYMVVhQyWpLc1hQX5YnT0Bh2E5rLDml
 0K5w==
X-Gm-Message-State: AOJu0YxjqQq8UJ39YqzI4pLIbf5wSGtCPNhDQtaAWxQvXsIipdMVcJcr
 XjPwAhUYJQrNWoFuZF2XMEKCFo+UW3A7VkZEgUFB/Lk3xE/ak+yYdZK5zPrvDStcJaI2p1U8q0S
 x
X-Gm-Gg: ASbGncuklCXQq6VHK0FiEWVkIfZQR3hdjRkcch8D//iXAaNnJ7KgyGBKxIRR7BR7JU5
 NtMpUf5UnTpdD4vGRiiryH303sHfYux937eCiHdMr/5snZLtmVzgPnOtooTgRv/nQY2wdiu552n
 xF6auI0lGOOaaLQENwlKmgsyioc+9/XBwT5rxl/MMg/VPh2nETPpWPImHUCcx2Zu8xoH58onO58
 1+TNKr6uQDJ6on8SU4L/hCkX4gs9Oq/Bq/70zAtCgQrMxdsPf3xeYs=
X-Google-Smtp-Source: AGHT+IEA90ND8eTV2giPp+MwkpvqJJK38DP4tDMh/u88DHbZNoiGJzMtroz6wvzk5/iNtqmnHykbYA==
X-Received: by 2002:a05:600c:4686:b0:434:882c:f740 with SMTP id
 5b1f17b1804b1-434a9df79e2mr192275555e9.32.1733145284279; 
 Mon, 02 Dec 2024 05:14:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 38/54] target/hppa: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:31 +0000
Message-Id: <20241202131347.498124-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Set the default NaN pattern explicitly, and remove the ifdef from
parts64_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/fpu_helper.c       | 2 ++
 fpu/softfloat-specialize.c.inc | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 69c4ce37835..239c027ec52 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -65,6 +65,8 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
     set_float_3nan_prop_rule(float_3nan_prop_abc, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    /* Default NaN: sign bit clear, msb-1 frac bit set */
+    set_float_default_nan_pattern(0b00100000, &env->fp_status);
 }
 
 void cpu_hppa_loaded_fr0(CPUHPPAState *env)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 452fe378cd2..b5ec1944d15 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -139,9 +139,6 @@ static void parts64_default_nan(FloatParts64 *p, float_status *status)
 #if defined(TARGET_SPARC) || defined(TARGET_M68K)
         /* Sign bit clear, all frac bits set */
         dnan_pattern = 0b01111111;
-#elif defined(TARGET_HPPA)
-        /* Sign bit clear, msb-1 frac bit set */
-        dnan_pattern = 0b00100000;
 #elif defined(TARGET_HEXAGON)
         /* Sign bit set, all frac bits set. */
         dnan_pattern = 0b11111111;
-- 
2.34.1


