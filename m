Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0453D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Ha-0003Yb-Le; Mon, 02 Dec 2024 08:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Fw-0001nq-KX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Fn-0003Af-2p
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:24 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e5db74d3so1326535f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145240; x=1733750040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfpQEPdfErqnjNX6r5VLZdc7V0ZgOPNgi8c10TCw4Tg=;
 b=X7A1roEwuJIJdXCeDNcZiuaX3BjjFszTFtIWYu5CI5OnZdMgHlVyKcFhqP0kn9kEzo
 AfF6PNmqtYATLIn7ggUJJsS6zaxqgKn5KV+J42h7JBuy/YN34QIiHm49+3yKWalHNfNM
 GExd7hkWKjzRpcB4IG9PLIHy5GbLH+gm5yKdCSQ+Zwn4aedX+qnScFJ2aZ6qpmP3gTwa
 ItSMfKRCZ2hFevyfIov0Dh3RnNnlT/e+NsoSZFm3nDn3w30JW60v9THe36UID3pkSXoz
 o2tCKGthsNTqRDcy8G4NAsd1PdIc+V0vNtECjgBgfezgPE10o/6fDVapCNGBYEtvj3G1
 NAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145240; x=1733750040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfpQEPdfErqnjNX6r5VLZdc7V0ZgOPNgi8c10TCw4Tg=;
 b=bRYTCTW2rRJs4KWWLylwr2NPbt/oEoMVZ9G2APFfdKDfKyV5ObK//AVZxMiEwtZGF0
 wlQ3U7I/xecQdCkA5VJp1vDbRu6jhOKIywWfggxIckGTtn72RNbXedVbpmBVmNPG7twP
 fpq5/fvEKQBFNQOd4JK9YHa6tuL2pi7cmYo9K2KG9H1mWiHrb5OldWXJx3v40AkVYJvT
 SJjtojoG6k+nyDSgEf9aF1LXwSPNZBe7ceLGwlIpyhrb8bTPMPSkzXmjXodU/pxAJO+i
 C5/wEYOCBXaC+4vcky3PDD+rOs1PK0xEQT7yt5jCESpMSo/kWsg4yEjSmn6STfuv2wGz
 72Tg==
X-Gm-Message-State: AOJu0Yw5EQ52fsTm0vEmLhi7J1bH/6GHQ688Onf3mkEnbzUsK2fjfNol
 ve3oK8eXvLYsnxbGkArjLX9tzTsHUhm6E8kjHYqOzqa1MZEeYwnwK6Zd/1mJ87KOBtMzXrvaJOR
 K
X-Gm-Gg: ASbGncuncpEk/Ra7RWpwvXWDDVDs+oTDEtJWLZaXwUma42i4xEbNaPxku6Dvt2LdyrP
 du8bttSDXpmBGOHl8OZl43iyFfZwm04vXa0zRWo5g9H+NHTkJDqQbDUdARMUG33BV+PRz6/1Mhw
 CX0/+XdzHmEfw9Hz8aGrnqnOU8zktFZh0pCU/06uwJF5IiS0mY1M4Eo4xA3JqJfBQb2bHh0prcg
 DiTrP9447cA6DzVg7QSfp38ekjYml22J34RMZ1lsBkCWgRVeIStqnc=
X-Google-Smtp-Source: AGHT+IH1SwiyqgNnO1jb8Mg4+qV0wNNNfAhUqYCw2B1qbD7zW+iE5bOTeMcRWbkK/6Xj+0nABql66Q==
X-Received: by 2002:a05:6000:184e:b0:382:6f2:df7a with SMTP id
 ffacd0b85a97d-385c6ec117emr19208264f8f.34.1733145238862; 
 Mon, 02 Dec 2024 05:13:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:58 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 07/54] target/ppc: Set FloatInfZeroNaNRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:00 +0000
Message-Id: <20241202131347.498124-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Set the FloatInfZeroNaNRule explicitly for the PPC target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c          | 7 +++++++
 fpu/softfloat-specialize.c.inc | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c25..f18908a643a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7270,6 +7270,13 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
+    /*
+     * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
+     * to return an input NaN if we have one (ie c) rather than generating
+     * a default NaN
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->vec_status);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index db914ddbb1c..2023b2bd632 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -503,18 +503,13 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
              */
             rule = float_infzeronan_dnan_never;
         }
-#elif defined(TARGET_PPC) || defined(TARGET_SPARC) || \
+#elif defined(TARGET_SPARC) || \
     defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
          */
-        /*
-         * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
-         * to return an input NaN if we have one (ie c) rather than generating
-         * a default NaN
-         */
         rule = float_infzeronan_dnan_never;
 #endif
     }
-- 
2.34.1


