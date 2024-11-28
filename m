Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5DBD690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc3C-0008St-2w; Thu, 28 Nov 2024 05:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGc01-0002Et-T0
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0000lA-N8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434aabd688fso3813885e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790617; x=1733395417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDBKL9MPqps6ny2XrO2kAvFlwZGolk654R0X02D8xvM=;
 b=Z8w6dXZekoU8/3XVSkKAY2rgGwM9fT7DgfoMzZDQ7l21xreEGz2OH1HGoQiC3sjhBf
 RhQ5Yb8XnB7g+KsM1BHX0g2p003M5NhQA4Cr3V9RcCzMa0NeFdxR6pg90wIvB+vEOxfp
 1BQH/LRZ3UXAqlURzjZTy8fuT9cOsxHqr0/OKY61n8hFBCkX+VN+7Yk5Ydgi4746KpQF
 jbGWN2awCtydFV50BYEfULtvXsdhvtMj/mu3gpPYB1+++DG5Qcr0QJQW1KluSC3bSde8
 +yYkGF6o3tzEVvejPJCJlConeJFJwdqT8QgtSeo9e6UbWfEXFrqrzeD98TbtiMTNd+Xz
 gvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790617; x=1733395417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDBKL9MPqps6ny2XrO2kAvFlwZGolk654R0X02D8xvM=;
 b=Q0Yt5X9Epc/Hp+Ual6iblgQv4mNzT2LPCeDBA5H1dvBr+ody1QUciJvRIhQy0qwlDf
 98oNzzAo57mECRfB63bmjN6VANNyp4z0ntGZXQUGkT17Cz6k+KP3aiLgKMBPHin+zhJt
 2gIFqn9DspLZdbT42DD1ezKvoySJFjm6ZQFlgeFexRBatE2wDr/5I61ERZIk6hnJ8hEV
 SWr9YcKJAd+u62egx+B10kBl7XdAIL3TzvSAddJZI4wHvif0qru8N5HUNjpaVwQPlY53
 D48W0Fx7ZQlu06CijJtuV7n5P6FClsnWqRLgBCRTEKPKCBAHvLIb0300uDILRVK4Xpvr
 W3NQ==
X-Gm-Message-State: AOJu0YyQ8aMIWdQF7slzMAGfY8B93CwD6w9zdLtm2GIrwC/4ZXpb5JCA
 8H6xdEZz1a1fNKovcFG8AfOfNm9Z6cJpp9LBxbVZ4mLSJCliZXWnyYx2I0ZZgeyA3VpNEDbKy+c
 e
X-Gm-Gg: ASbGncvuupZhk+mI59OU4ED58BH5dfu6ogLzIN5lKzkuE9kE9rfR8TD9sXzCRElkv6W
 hfhOWrniEGpCA0XhCMtbUqTzV30/aMp+Ajk6g/ssgzY9HhLGIDdJFOaithgzsxDtAxmgIUyqzdG
 005XdCR5Eu46cE9wdupFU8sYpDdCokUoM/0R3TOgM46CiNxY9IQh4jMzHSapE4uC4PKpDWTHbiy
 HnLv73srX1+/IjQZ1eq5l4t35h7u+VkzJTrDa+Num1Y1anyqGWeGrY=
X-Google-Smtp-Source: AGHT+IFPUDNHsVTbne3PyCSxDI1YCIQ5wGD0dfm48aH21lq3U8smxfK2qRR3l6+GuMUuCsLhh7mANA==
X-Received: by 2002:a05:6000:1545:b0:382:450c:2601 with SMTP id
 ffacd0b85a97d-385c6ebba39mr5425612f8f.24.1732790616845; 
 Thu, 28 Nov 2024 02:43:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:36 -0800 (PST)
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
Subject: [PATCH for-10.0 24/25] target/hppa: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:09 +0000
Message-Id: <20241128104310.3452934-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Set the Float3NaNPropRule explicitly for HPPA, and remove the
ifdef from pickNaNMulAdd().

HPPA is the only target that was using the default branch of the
ifdef ladder (other targets either do not use muladd or set
default_nan_mode), so we can remove the ifdef fallback entirely now
(allowing the "rule not set" case to fall into the default of the
switch statement and assert).

We add a TODO note that the HPPA rule is probably wrong; this is
not a behavioural change for this refactoring.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/hppa/fpu_helper.c       | 8 ++++++++
 fpu/softfloat-specialize.c.inc | 7 +------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 393cae33bf9..69c4ce37835 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -55,6 +55,14 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      * HPPA does note implement a CPU reset method at all...
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /*
+     * TODO: The HPPA architecture reference only documents its NaN
+     * propagation rule for 2-operand operations. Testing on real hardware
+     * might be necessary to confirm whether this order for muladd is correct.
+     * Not preferring the SNaN is almost certainly incorrect as it diverges
+     * from the documented rules for 2-operand operations.
+     */
+    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 60de68012e1..353b524d2de 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -475,7 +475,6 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
 static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
                          bool infzero, float_status *status)
 {
-    Float3NaNPropRule rule = status->float_3nan_prop_rule;
     /*
      * We guarantee not to require the target to tell us how to
      * pick a NaN if we're always returning the default NaN.
@@ -501,11 +500,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         }
     }
 
-    if (rule == float_3nan_prop_none) {
-        rule = float_3nan_prop_abc;
-    }
-
-    switch (rule) {
+    switch (status->float_3nan_prop_rule) {
     case float_3nan_prop_s_abc:
         if (is_snan(a_cls)) {
             return 0;
-- 
2.34.1


