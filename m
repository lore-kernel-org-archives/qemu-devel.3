Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B141098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYU-0002uH-S8; Fri, 20 Mar 2026 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYT-0002t7-Hp
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:21 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYR-00062O-FX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:21 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6674cba2c50so4140301a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011978; x=1774616778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsdtiykTnW0VjyAme87SkjxBD+RX78r+rOirb5jXuhA=;
 b=DciyGpdEL4wLt+nnEB/K8fQ9bBZ1J0Yc/2IfcJZrOm7A0780bOhEFOSZKNUDHa4FNt
 eF7laWU0bZpLCTotdSHiWXeJ8sC/CRW3Fr3b7DfWnggkazK7q8UvwxJVEC37wLBa6bPO
 nBa5HttgGBBxU0JGa3MRubsjA8PfumCD+7UK7356lU9trzMlAxKtZfWKJE8r41CDwHEa
 Ua8iJNOg/Vg6xR003AMaB74iQqkeoOCp07hcV4w1dW2BPHPfAQhK0MRZdYlsMOavRcjk
 W+3iYrTNGsP+5cMngkpV6KFKn6vatnFZUG1561h+UhaPmdFwVI4erkzGtE6ZOEZ364XU
 F+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011978; x=1774616778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fsdtiykTnW0VjyAme87SkjxBD+RX78r+rOirb5jXuhA=;
 b=agtIgGia+dnCtLbSPaoCNVFoSmVrE6s33Ciaiq7ZTOg3UtXe3rhSPXhSRzn1nFKFFl
 4awUyol5MNP1mwTSI6GTa5lzVS4hCPdZ0G9Sy2gc7WbN2y+36+/ljPA9Rz3/NPM2Qp78
 8FZKq1LaO9rB1bE1NxkgAaMXwXuefcMekHjGbyBt1GLBikBydBGNcsV3u/YS3tBWqc1h
 /x8I/yDvGTh9ryQck8s+pGZHHNB027lzOeG2nwS1HELoZ9LRyGGTNAJ9GJuTYCySqm2Y
 yE4Qv4Ehk/ktqrKNNAh+33P4na5B0ZJsCDlBHG0xfkBhG8P1VnG6Pinn+9bhoudb5W62
 U7bQ==
X-Gm-Message-State: AOJu0Yy4b0e4DI+EzjlEHY42kmRq0vuZa93yBX8sNwolfCyPpssMDkaK
 hhdUWivRR64Evd8sNXb3q0250u8NWxDeef9EbYIzlRWPJYOc/eITRgJ+OgGA18vBYgY=
X-Gm-Gg: ATEYQzwKlNXMdYJ9Nn6IlTi3jcSo3cbkuU2pTNpu4TgdBvxFhghxkKwEUUnp83zXm33
 pDA1366r1VSKvDwteChsdl/D6UOJ5YZ+qpqtgZB+9qWebyyVAf7Yp2vlLKVGiWpCJu3SR9/Mkbo
 aqUH4Cg7GDr+NTB2nIE7yPqym/N0OHFHlFS27GpwdCl+RjdHKKugplCQ+dOpbAIUqp1M2JE7aMj
 baeAP4VzCiKppE94mSKVfNe7/r5FOeIZ0NnTsW4gx/fTrEMtUO8rQomggufBjLeQmFRcupN3gzk
 EqGGI2VaLYfVgPQe98GGFYC67eQQNevb2irQNgixuBD3/qItA75Z0J0aPn2oAX3G+Okn0ZGN4dK
 AQ82NtI6UkiXDPEndPztOA/gStDMGtkAYf9ZHnOG0PsI3y8t+i/FjhwIN5Eq6eo3kIoup8B+Slt
 VEkf3VkVkQTcE7wG53J+B1zqQ=
X-Received: by 2002:a17:906:7947:b0:b97:9a7a:9d21 with SMTP id
 a640c23a62f3a-b980f8f9d4amr463136066b.4.1774011977762; 
 Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f88d02sm158124966b.14.2026.03.20.06.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 617645F9F8;
 Fri, 20 Mar 2026 13:06:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 21/35] target/arm: use syndrome helpers to query VNCR bit
Date: Fri, 20 Mar 2026 13:05:52 +0000
Message-ID: <20260320130607.2071996-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

These are only valid for data abort syndromes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index c74d8e785a6..bbe1e70bc43 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -48,7 +48,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
      * ST64BV, or ST64BV0 insns report syndrome info even for stage-1
      * faults and regardless of the target EL.
      */
-    if (template_syn & ARM_EL_VNCR) {
+    if (FIELD_EX32(template_syn, DABORT_ISS, VNCR)) {
         /*
          * FEAT_NV2 faults on accesses via VNCR_EL2 are a special case:
          * they are always reported as "same EL", even though we are going
@@ -190,7 +190,7 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
      * because we masked that out in disas_set_insn_syndrome())
      */
     bool is_vncr = (access_type != MMU_INST_FETCH) &&
-        (env->exception.syndrome & ARM_EL_VNCR);
+        FIELD_EX32(env->exception.syndrome, DABORT_ISS, VNCR);
 
     if (is_vncr) {
         /* FEAT_NV2 faults on accesses via VNCR_EL2 go to EL2 */
-- 
2.47.3


