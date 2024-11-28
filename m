Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5480ED690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0U-0002gh-HE; Thu, 28 Nov 2024 05:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzY-00020U-TH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzU-0000TH-1Y
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434aafd68e9so6030135e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790598; x=1733395398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CN209ow1u88/SvecQPZ/3IUJ9A/OS7lKONjS1X1zVa4=;
 b=fCA8luC89qJZGogZcW5oTfOClX25gvuqauKBPLzikLROeF9ISmyVOm/Ia9TueGK0pQ
 kh2nHJ4b5PorfXDmp5hmXsXF7r1eEo9RQP/tfrcB9vig/vk/TdqDGBB02sDNA3AuoqJw
 g1xam1orGCz8s0Z8u8QO8lZ6mRazJTqGYosw+j1Q7nQGUZABy7GBn1KM1UJ1wluG6PGg
 YwchUZVYopFdM0e316Re+npIzveU3Qg0FIiRHeDH8VnyKv2zt3MSVbH+MUdYicfhCtgK
 SfZS1Mgux95mxovAxJTVOtDbTub0+KPo0rfnG0UFM0x/gbfiwPES+509j3ujFD1kK0VQ
 08zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790598; x=1733395398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CN209ow1u88/SvecQPZ/3IUJ9A/OS7lKONjS1X1zVa4=;
 b=i1GT2JCdoNyakAog4kMoNgak5YGGIdSVPqo7q2rBJDdpkrUbQeMXv7YscrfiUgK+FM
 4nzmgc2pKzkQThxAfKSWiCCgb1jR27gHp0NUHgv5rPoNZqFhWhmJOE8xHveihZvvS9bR
 x04oG/fL9HOWnq65TYnzrk209+8sJucvw3lrn1NSHiEiksOeo8wurBzIT+5jFy0C3jyE
 N6kerz1u9F3wDw0KYsSEN//8LtE+7TnMxfcmatlCE4CKwaGhGxtiiZEKZyD7+nGvFHZB
 i4r4jRk6Qd1JE9qmPTBC5+OciW11LWb48lz4al766+a7xneQQ6hRzSPKgsPqQeH/vFMU
 ytGw==
X-Gm-Message-State: AOJu0YyGt6PWcbxQYZrmgYh5W2hqQBYG8eruWqc56mfBR6W+mBb2MMxy
 qEBRNU3SrEqZimAfpk4uS27FDObd8K2t1xZ2LUYzvTiIffJXcTAfCknyCiFquM2tJ5MpX//X6lN
 D
X-Gm-Gg: ASbGncvv2iMBvlgIseukN1jN671tolfPjl0UEP08fYm5jHLf/T30+i1PQBy9+D4V9ey
 +9U/C8fp2fFNLTk82FZ/m1U6pPAdH1ui++nH7UjgGPZduvvTn0strrRcVxqKxlwZjtr0zDNcETx
 wWlhKvtQ29bbo51qGx8LNWjaGkP305BgUYKsPRgibdU/VBaZKQQgenIDrQaNfikdMguYhpSXdym
 utL8fC77yJ2Y5yypdFwh6HsTt7KxbfQhDMFfOvRT0cz59q8pH1kDrk=
X-Google-Smtp-Source: AGHT+IEO1+yaqAG0WEQQ3aJywsZ4ugi2GG41LKAVgzk9zB7hp56n63EPXyCDGvevvW/FlBUvnmIY0A==
X-Received: by 2002:a05:600c:3587:b0:434:9da3:602f with SMTP id
 5b1f17b1804b1-434a9dc6765mr66825315e9.16.1732790598368; 
 Thu, 28 Nov 2024 02:43:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:18 -0800 (PST)
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
Subject: [PATCH for-10.0 06/25] target/s390: Set FloatInfZeroNaNRule explicitly
Date: Thu, 28 Nov 2024 10:42:51 +0000
Message-Id: <20241128104310.3452934-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the FloatInfZeroNaNRule explicitly for s390, so we
can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/s390x/cpu.c             | 2 ++
 fpu/softfloat-specialize.c.inc | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 514c70f3010..d5941b5b9df 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -206,6 +206,8 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
         set_float_detect_tininess(float_tininess_before_rounding,
                                   &env->fpu_status);
         set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fpu_status);
+        set_float_infzeronan_rule(float_infzeronan_dnan_always,
+                                  &env->fpu_status);
        /* fall through */
     case RESET_TYPE_S390_CPU_NORMAL:
         env->psw.mask &= ~PSW_MASK_RI;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index b3ffa54f368..db914ddbb1c 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -516,8 +516,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
          * a default NaN
          */
         rule = float_infzeronan_dnan_never;
-#elif defined(TARGET_S390X)
-        rule = float_infzeronan_dnan_always;
 #endif
     }
 
-- 
2.34.1


