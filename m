Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0FD690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc2g-0006V3-CK; Thu, 28 Nov 2024 05:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0002A7-PN
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzk-0000gd-2B
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434aa222d96so7431095e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790613; x=1733395413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHFYmwmnqcmAvgEMbarhecchly8CdIQ7oYTdDVFhVcI=;
 b=YbXEve57aOvZ5W0ozEJ/bACYhxz5jmq0Mmj31yAJH1ZrdC5dy3zRt34/YfN+u3RxQl
 8gcZRDCr/I/1VFdGpyrDcS+Hzla2o5VhVZEFrDDksoShP7PdTj3SedFlyKiuyzw7nY96
 Rq/19HnG8CNHpE+qH4X14+CrGILwacRLhGPa0lAW9aM3QMHMmoxw5ajKKGStiMEzWAEN
 QXrEtivva1wOIGAgg6+dZFWxu+P+jG3wXxGamW8N4cnYxWTnaoXJb0cP7kO9aPIsgOQf
 8SP69dAWXoOIj4/EteK5Bt6SFuDQch2I2fzxT4uZBJ7hyBF7Muqx+ypT7ly0SCRl7GSt
 UcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790613; x=1733395413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHFYmwmnqcmAvgEMbarhecchly8CdIQ7oYTdDVFhVcI=;
 b=FJgM/GfXHJm1TxGj+TLbhR6pMOSZBVhONVmMOVzjtsi9uso1kPhNQaWIDsVhrBOh94
 8KHKHWR8xWpe1kXjIQR5WRR5XOn0x3h2eRgIUrGTh5EGLqCRJgBUWoKokDKRurw2U3c3
 h7lDO+bWehDyCH0zxSiRTPu+qnGcorhyJYQnoSwYOdEQ5P2KxQuXkRYwR7hggVdmEJSr
 PwnUspT9WCGCItYXSWKUQJJPxye2lWAyofS6vMh7Xtt58UgMsZ5f6vxfnM9IV24KnK37
 o0J5k7jMexr6P0GnORBmtHKrFpRBYwuG55xrd9FNaPHqxhK2r0jaaGY4HAIgMwS6VK1u
 HWyw==
X-Gm-Message-State: AOJu0YzRZn+Oor3xGbkJCs9TJV3yw2pM+kw19TBEOQErJoUkfe1Oq/iV
 TYlzipTYT1OcTEA6UYSzhYiIyvWsrBg5J/19FnduNDteRq6WyEaIrY+BAOXsju+rkElQM/pJrTD
 i
X-Gm-Gg: ASbGnctB7uJVcGiNC2YA2h5/fudt87MzjFXsKAk+bYZP9DVt3D/Jcn1N9ahWzwfAgQZ
 fb09/O73sg5ZduAAkkG+gk1UXuntltCH45p1B09+/P1lHDyuxxs2YWdUkw2nLIpV57q2Dxvy9IO
 JgMQDn8U0sXwmvvnmB/jRVjhEW6pn32WuaFi+ZH56LoZuowxZbILKqRUoVsF4LFK4LsUuaHQGwD
 VIBgesulKlrujbntc1xv0kKipd3vLv/avakgbib8EI+r3Qt990PSWk=
X-Google-Smtp-Source: AGHT+IHD8Eop3Sl1nLVu2mVi+S7Bbn0D0QOlNKeDuqEmug+IgUvyzvvZweODFgWcNmvnV9fee/YCpg==
X-Received: by 2002:a05:6000:1449:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-385c6ed97f5mr6117943f8f.41.1732790609207; 
 Thu, 28 Nov 2024 02:43:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:28 -0800 (PST)
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
Subject: [PATCH for-10.0 18/25] target/ppc: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:03 +0000
Message-Id: <20241128104310.3452934-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Set the Float3NaNPropRule explicitly for PPC, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/ppc/cpu_init.c          | 8 ++++++++
 fpu/softfloat-specialize.c.inc | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f18908a643a..eb9d7b13701 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7270,6 +7270,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
+    /*
+     * NaN propagation for fused multiply-add:
+     * if fRA is a NaN return it; otherwise if fRB is a NaN return it;
+     * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
+     * whereas QEMU labels the operands as (a * b) + c.
+     */
+    set_float_3nan_prop_rule(float_3nan_prop_acb, &env->fp_status);
+    set_float_3nan_prop_rule(float_3nan_prop_acb, &env->vec_status);
     /*
      * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
      * to return an input NaN if we have one (ie c) rather than generating
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 32edb493776..d89ef62b38a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -508,12 +508,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         } else {
             rule = float_3nan_prop_s_cab;
         }
-#elif defined(TARGET_PPC)
-        /*
-         * If fRA is a NaN return it; otherwise if fRB is a NaN return it;
-         * otherwise return fRC. Note that muladd on PPC is (fRA * fRC) + frB
-         */
-        rule = float_3nan_prop_acb;
 #elif defined(TARGET_S390X)
         rule = float_3nan_prop_s_abc;
 #elif defined(TARGET_SPARC)
-- 
2.34.1


