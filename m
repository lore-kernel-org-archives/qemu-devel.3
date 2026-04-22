Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE71F9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUYh-0007FV-M2; Wed, 22 Apr 2026 06:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXq-0006tA-8Y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXn-0000lb-Cq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43fea39e066so4191940f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852654; x=1777457454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
 b=KjbfbogYcpf6qTcdklRrYvxYzMDzZxBy07M1RxngPW9F78pS7pAw1Y6Dv9CuEjt37+
 AmJ0N11HxBPJW7c8UXEYNnfDsJPCgF9o8tAggz3vZjES9jYwfHEr8czGowpwhfbnPWxm
 bL6Mjh9lDCvnNVLJmF5uQKoUj/tMjPdHsrm3KocdU1cBpLJ9TzydMZPc+HQEKwYgdtSP
 kwNLM+U3aB6svBNytnAlL2H2TzC/IRLvurHi6is4fuV66KUDc9N558OTrTpMH9yxfGSY
 P1ftnXdUgG3M0cygiFra2/Y3g1GGZfscYexM/fyCkB1khmbQZVvFwzG70i1vlrEsB+q+
 RWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852654; x=1777457454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qLD556mwBZN0FOjv6jT/HPan7Y0S6BW5g1K/GkaPB6k=;
 b=KDSF6vIKY/1T+SNFQBJUQbCu11yL5Yhl3CagprjbHtZGcLZqmimpH7xRr9Qgfqc5Mn
 CMMHJo8zEsHzYl22lJ/ZxjI4eouoc6mdsSAliRlzs9zYG7ERNUzJyIGv0Iz5k945gSQE
 PE1/kLAA92FXbqKMCOdOy5n0obRg7e/9Y12+Q6JzRrUknADccDKOStK2SKJGYFuJ3Oci
 1SxY9ennGkUp4VLPijPTyNkl0QLICmrkc9+Ewl6yAPCqLew3fDte6q23dgol7XDsQUgj
 tSSxF3I8VSi9fnDU31PlnbGU8sov1KisQttD8gNhf5STLoRPcQCtxZ0JxdDkF2/KMAB+
 c52Q==
X-Gm-Message-State: AOJu0Yw5gteUH8wtSBF0Wt0/TfgGoEhihfbNN5D0Vq9WoPnL/shFExqA
 n4n1+dSBO6ItWLOJEPHiXGirdFQSKtTbk5JPYcBv8jbqouQKNo59MhC6iZmpXlmf54s=
X-Gm-Gg: AeBDiet53tgHMXUQ54DqWwuJngmZxNSlIdQwc6n7umvZ4sx9YsffG73c5DjuvM09zQ6
 V6kxzq8hu6r++LCGcmJPmrLcWz//F3Kx0vLruAka8z4yS6JDQc24c5DByZIEBsTe9ptpmxWlyrb
 XpQZCtpIkIRA0guIkgz8itvKOzE+nTvve6VgELlqFHq82AEZaMwgrbbc7JjqPP0QUipEiQs9kdO
 axbsLDJRHl2SApGDLVbyolvsbWrtDGlJx+FPRrzzWkcb/Cc5KoItSEUpkw/JNOzkXPG30epWOVp
 e4ybjoDEeTEtHCH0068d6RFymLE163GmU+UeJaGffR6E4Wjpn0pneiZn5MQy18pNOvU6CNypgaf
 aHEl4lcKRd5Mi+4eCTT/meNQwXJ66VahkS3BlWbnGV5S7x522SKzkqb9tpjfokltno6FfB6qLc1
 AjVcQzQmwqymgfzf+2qdVcRlpG48zPdEdGDg==
X-Received: by 2002:a05:6000:186c:b0:43e:a703:3665 with SMTP id
 ffacd0b85a97d-43fe3e0c6femr33085614f8f.25.1776852653594; 
 Wed, 22 Apr 2026 03:10:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1405sm44247250f8f.4.2026.04.22.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7475C60F3D;
 Wed, 22 Apr 2026 11:10:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 13/31] target/arm: migrate gcs syndromes to registerfields
Date: Wed, 22 Apr 2026 11:10:24 +0100
Message-ID: <20260422101043.1234229-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tweak arg names to make it clear raddr is the data address register
number.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - rename ra->raddr to document things.
---
 target/arm/syndrome.h | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 65d0de63a83..7ff8c30e2bb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -690,21 +690,48 @@ static inline uint32_t syn_pcalignment(void)
     return res;
 }
 
+/*
+ * ISS encoding for a GCS exception
+ *
+ * Field validity depends on EXTYPE
+ */
+FIELD(GCS_ISS, IT, 0, 5)
+FIELD(GCS_ISS, RN, 5, 5) /* only for non EXLOCK exceptions */
+FIELD(GCS_ISS, RADDR, 10, 5) /* only for GCSSTR/GCSSTTR traps */
+FIELD(GCS_ISS, EXTYPE, 20, 4)
+
 static inline uint32_t syn_gcs_data_check(GCSInstructionType it, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_DataCheck << 20) | (rn << 5) | it);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_DataCheck);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+    res = FIELD_DP32(res, GCS_ISS, IT, it);
+
+    return res;
 }
 
 static inline uint32_t syn_gcs_exlock(void)
 {
-    return (EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL | (GCS_ET_EXLOCK << 20);
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_EXLOCK);
+
+    return res;
 }
 
-static inline uint32_t syn_gcs_gcsstr(int ra, int rn)
+static inline uint32_t syn_gcs_gcsstr(int raddr, int rn)
 {
-    return ((EC_GCS << ARM_EL_EC_SHIFT) | ARM_EL_IL |
-            (GCS_ET_GCSSTR_GCSSTTR << 20) | (ra << 10) | (rn << 5));
+    uint32_t res = syn_set_ec(0, EC_GCS);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, GCS_ISS, EXTYPE, GCS_ET_GCSSTR_GCSSTTR);
+    res = FIELD_DP32(res, GCS_ISS, RADDR, raddr);
+    res = FIELD_DP32(res, GCS_ISS, RN, rn);
+
+    return res;
 }
 
 static inline uint32_t syn_serror(uint32_t extra)
-- 
2.47.3


