Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D464D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6OJ-0002kd-Kv; Mon, 02 Dec 2024 08:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GZ-0002Iq-EB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GQ-0003LG-U5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:07 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so38146825e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145273; x=1733750073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZmEjYqAtBnicHjPyhH8ft0gcTQribvPLCBufh/En/c=;
 b=GU37X9LjbCvpcV6NrKLuGIywsSS2Fipi5dQ5KopTUxLchOTk1BCey2tn4v9t7fRTK2
 pAdqTYog5LFfMH6olgyNzeib/oOE554znHJ5dN13v6+3maNawtDnfXiedasBXKucHp4d
 hxUQVlZQTs4AatGFLsDzXGMup8AWhNkDw9+ES4ddH0mRJ4aurapqd9ZMKEUQJBQqFWfa
 4eULiXGfTsuLukVcq07RMwA3ka5dTCDGNzR0mgBZL0sxZ5ap3Z9gysVq7rkdOCt202ll
 eIi0TBmytPBnerQtvrIpqFasoKH6iTGQG2Z8m9bWlPzsVV7IgPEECiuOqE71Ex5ihypS
 qJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145273; x=1733750073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZmEjYqAtBnicHjPyhH8ft0gcTQribvPLCBufh/En/c=;
 b=Q/Xm2PTrEFbIE1g0LbFyIcNT53X4D56M5AMtB+cUvFG3yhzdoMIowx5p9PqMOvjy6a
 AWeil8VSUU/4MpdJgLq3tRwjiitVngNKbaHw4czFm5S1xqqLM3pm8eGl7NBld20KqEFM
 SpA/Uk1Zk0RssGhsDpILhhKSkH0JH7oydrcXD0EO/DyYwPjKck7WBUg8eESz2oG2PT0g
 +u4n2b+O/y8f9KGW7nXY6hgVD1AW1sVgvq9CWPODW8r/yORUtswBmJ9zV7Pz+IvFbv+y
 5KGZtaJNEbarn85eA5xbiRsGEVPA/FbLVqeGGwYUgK76yktQoeCZv01LhPoMasfwNGkM
 MrSQ==
X-Gm-Message-State: AOJu0Yy1LSXfI58nJlp3sfJQH4DU6d17iUKgn/i5JVftziSLsB8n1/3D
 QOpVrEJVF506Eg6pPs1HoC8Bw0sr/VDt9ai2i8Gy07+QlY+8Poci/bEIWYUttHJyGvvz9egzHXH
 /
X-Gm-Gg: ASbGncsMreBR4jK5/GB4EqtssVE/Tf3BdecYf19IQV1Ic7jBcYBjucir5+3eHuoG72A
 0YUYMLsMBrId8Eb6lB65ciwfDeqBa4AAKpNqF5zcZhCB4alEVYCCFKi1WBCYUIII/D2KvHvn6UN
 4Vh8SO1uRRX4SOy5M6R/z1pbmd2KeWZmgjkOemXhN5erOOJKk1lgLMU9nij5IUAqL7M4oXcXA8f
 VQeot6JaYzulABpT13CgPCezuNrYlF+zUs3IeC8wiINJXlmfpdvDBk=
X-Google-Smtp-Source: AGHT+IH/PALsVo0VAyGUiocqZee2rofdapY0wf4INzIl5OJmdj81XrthiF1qwqcuydvHdNVegxmu1A==
X-Received: by 2002:a5d:588f:0:b0:382:51d7:39a8 with SMTP id
 ffacd0b85a97d-385c6ebdbdamr19785353f8f.27.1733145273268; 
 Mon, 02 Dec 2024 05:14:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:32 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 26/54] fpu: Remove use_first_nan field from
 float_status
Date: Mon,  2 Dec 2024 13:13:19 +0000
Message-Id: <20241202131347.498124-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
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

The use_first_nan field in float_status was an xtensa-specific way to
select at runtime from two different NaN propagation rules.  Now that
xtensa is using the target-agnostic NaN propagation rule selection
that we've just added, we can remove use_first_nan, because there is
no longer any code that reads it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 include/fpu/softfloat-types.h   | 1 -
 target/xtensa/fpu_helper.c      | 1 -
 3 files changed, 7 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index cf06b4e16bf..10a6763532c 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -113,11 +113,6 @@ static inline void set_snan_bit_is_one(bool val, float_status *status)
     status->snan_bit_is_one = val;
 }
 
-static inline void set_use_first_nan(bool val, float_status *status)
-{
-    status->use_first_nan = val;
-}
-
 static inline void set_no_signaling_nans(bool val, float_status *status)
 {
     status->no_signaling_nans = val;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index d9f0797edaf..84ba4ed20e6 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -309,7 +309,6 @@ typedef struct float_status {
      * softfloat-specialize.inc.c)
      */
     bool snan_bit_is_one;
-    bool use_first_nan;
     bool no_signaling_nans;
     /* should overflowed results subtract re_bias to its exponent? */
     bool rebias_overflow;
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index 4b1b021d824..53fc7cfd2af 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -59,7 +59,6 @@ static const struct {
 
 void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
 {
-    set_use_first_nan(use_first, &env->fp_status);
     set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
                              &env->fp_status);
     set_float_3nan_prop_rule(use_first ? float_3nan_prop_abc : float_3nan_prop_cba,
-- 
2.34.1


