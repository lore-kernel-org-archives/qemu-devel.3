Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B7FC3ABBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl14-0004B4-QZ; Sun, 04 May 2025 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0i-0003ur-6C
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:49 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0Y-0002VL-I3
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:47 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso1023965b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409957; x=1747014757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+98FJCPUkZxLytRMJNRmc7jhTB2VJSy0tbuhiYCP08=;
 b=K1OYHCZU1j9hr706aK+ae04cXExG+9YOvwvVFtN8m2mLP8UaMoSd2EX70mhd2Evm5N
 S1JPRuIXllA90XfNYeEpKuarbO1wd9kq0lqqcj52rtpgefcmL3KXgf6itbx58sDf2UvG
 J1o0TKZ2rpLf5X53dCTdEPYtoEnhsldQ7SOxnXJEXQL5pixUcKM2YRY9A9cyAXXGgbss
 pRf/FoQsTFFW1+tpHf8kySi5S08+ZzCaMd2Xmcm1riSwZieh5ViKDw2Q05KQZ8eiM3bP
 qCVFWMEp2lQxss3RqAng2EF2+9n6Lt7Qnf17RYPRBvM3EEl0AMLHBWVnOR9oFwDjt6h1
 GuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409957; x=1747014757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+98FJCPUkZxLytRMJNRmc7jhTB2VJSy0tbuhiYCP08=;
 b=NUxC3QyL4re2YQxpNvlCeHSUteeaNC2PVhWrTJu+FWZtSoO/gk0RFyCl72hZa9AMQ9
 UHv288cS1uBE9A9wWDgKZY7eAhD9pyjrPSmXyluvnbvD/s5MeCfrUI3SrLPylz/pN0Yo
 Gsd35PuMaSfEwo+D9jOxbo5ggSwgd8XcZL/vasOGx/nqNC1YdlGThwySydwBAwLyLRbe
 IAtftFZkTAdmPImlakU6+imkRH8IKXW2YBmhBFpkVNMjfqfUv9R0Mb8wNCHyy7J7dP+u
 xKWc+jsHN1/dvl6g9KMTFOwRx82sG1OQ1zD+5Xb7HWIp10ZM/+U2lPNBLwXVCQQKa1xq
 rb5Q==
X-Gm-Message-State: AOJu0YwdFgNzxTbXMCpofyFzArubsxuTqMFGjbsLsm2hD1EwGs1IWopw
 PNKbHbonTdPZ7sXAirpRSduCaVB/FyLKm3fDRdPzORaqY9os30ptKsJl7L2NY8uyB5H/Hbk3CBl
 1Ts4=
X-Gm-Gg: ASbGnct75AaIf1+PWlC7K/rETl9vM+u33f1/l4aJds0Ym83gr7oHxfqVbiFttO9JABy
 i6y5ln/Lsxo7yawFXFuHZvLvS5ONllNNhA7yY7Z8anI91YMBLiQIoRbit29PcFXZvu+QS4vCSCb
 IzUHN4yf7qQanpnH651m/SqPaqWLE09mFNVGw3qpaveLMmFnJ56xL5AdIYpXonJLdIl0AMV4t51
 uG9XF8x/FE9ymgE55PZ9tOHQ9cgCTQXOrQ0TfWD3wxT2ImEViODoaT7XphHiWeWNFK3GFQeIt6W
 rdCrU5UYPl9dEIF8iTwxNS3bw1/zpp5I1DRfIZcV
X-Google-Smtp-Source: AGHT+IGTUMuWkiXDF+7B4A5RoXeueVtcJqUBJGl4G++uLi5Bx9kadv1aMwlRDeZ/N40AZk3TB+EU+g==
X-Received: by 2002:a05:6a21:918b:b0:1f5:85f9:4ce6 with SMTP id
 adf61e73a8af0-20e966058bdmr6970804637.11.1746409957268; 
 Sun, 04 May 2025 18:52:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 10/48] target/arm/cpu: remove TARGET_AARCH64 around
 aarch64_cpu_dump_state common
Date: Sun,  4 May 2025 18:51:45 -0700
Message-ID: <20250505015223.3895275-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Call is guarded by is_a64(env), so it's safe to expose without needing
to assert anything.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 37b11e8866f..00ae2778058 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1183,8 +1183,6 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-#ifdef TARGET_AARCH64
-
 static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1342,15 +1340,6 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#else
-
-static inline void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-{
-    g_assert_not_reached();
-}
-
-#endif
-
 static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     ARMCPU *cpu = ARM_CPU(cs);
-- 
2.47.2


