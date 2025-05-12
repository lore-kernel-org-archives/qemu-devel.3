Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C35C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXdP-00059I-97; Mon, 12 May 2025 14:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaG-0001aF-De
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaE-0000Ta-1g
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso3974562b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073336; x=1747678136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9pY26zaQMqZMR17IM27tzI2vbhn1j1ig8REcOyHb8s=;
 b=fMS/j54WjuFfY+QmkRLJD1GHWqBX7WKDrdAed8LB7kgUPEYieWRpfIiXlT0YLSJYtC
 2mjDHo8L1NxGVb7EiJN+Gzt3nQpoB++7ehTX9u//Bk7aSdC2mR3oIJSVco2X2Sb30L/0
 iobCijvtO5Jv8Z2Y6LHYZxEskrPJb1i0B1U4+IndPtOVJmuIZ+tML+Wf7pTjjOmF3C3K
 xRh3Uuxf9MtWBv+WNKQra2PkhDhwdOf+qRWChz4aHtGw8jqLiLMB1LsLchxSKMWyqaO6
 TXvPqkogW+yku7+bXjjH6bDJDISE/vVszubUicujaJmnxyL8Z+BcfKiPA4vuBRNaC/5G
 Qhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073336; x=1747678136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9pY26zaQMqZMR17IM27tzI2vbhn1j1ig8REcOyHb8s=;
 b=YiX3MPE6twp8egXQehaplOzdJzNZolBrPuOkaNlszkivkeISeGAnG8nnocLgQgVopn
 WAqBJK2TTKcJykuBEzZesnB5w7asLOES1BLYKQrMxPSOwLb3TiVACs3Db95xZ6V5rck5
 F9fHyY21nDX/1dqLaNNy86V7Oj92XlMEhzYfcg3YCWG56EjdcW5+D/h7DVaS4QemTIJR
 CjHtiX5tJShU6cg566gqBgmsUDUMjO7Yach5ILrsCzfgfImWs8TB+QpgZh4xq59WyHRG
 knDeElZtQToWFkHYBUwCKMQSXzzy9jiD02XWL58ejlOwhV4fTOU5d34tYro411i5xfDe
 m79A==
X-Gm-Message-State: AOJu0YypMa4sQbJwXbX3+n3Rn+k8GSQRfCtl+Z1G4LNSoRMtOhJiz0oU
 W2hTboMCWpqBVDBRq5AkIGFROm9OydDEDsfr7Nlfh5r+8YFlEMjWFJvuqiJPj3MleM4pP1fggTh
 k
X-Gm-Gg: ASbGncsKP3vj/lTFxuJ4qanrJ9gt9tSLGOz/tjOdVAKVQs8eDBHQmQ+GgZPnAFIq3ac
 CLz6y/uVnkgysRMLj85S9CTUUJsz/8sImf6RJPLfhUcwh3cIJK7laxLojN4jUOC/gl/0vSueu1U
 9syccKycCSAid8wJXTuhQQgaEbkyH4ai87DIu1mz2di9f9T2eojh35feKfoYmyS05su5aexodtp
 noCYayvj23RxuyM3+DFshP5aqqP59x6/nqT+MMDo6whIr2x/2CvW8nUruPvirP57GMXoPB5lWu7
 ia9zMJoawSpmO+KE9Ms+PmtHsJ9ZuS1Ir65/Q7QBhunUx+hMShw=
X-Google-Smtp-Source: AGHT+IEpgv+2XV0Zbgxq0jroyNZr0Hhc8tUXZJKtGzmiJs+oD+973KGXRHevMub/LwmkpCtxJP8WNw==
X-Received: by 2002:a05:6a00:4d8f:b0:732:706c:c4ff with SMTP id
 d2e1a72fcca58-742791784dbmr459306b3a.7.1747073336612; 
 Mon, 12 May 2025 11:08:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 45/48] target/arm/helper: restrict define_tlb_insn_regs to
 system target
Date: Mon, 12 May 2025 11:04:59 -0700
Message-ID: <20250512180502.2395029-46-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Allows to include target/arm/tcg/tlb-insns.c only for system targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae8554e8f2..76312102879 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7764,7 +7764,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, not_v8_cp_reginfo);
     }
 
+#ifndef CONFIG_USER_ONLY
     define_tlb_insn_regs(cpu);
+#endif
 
     if (arm_feature(env, ARM_FEATURE_V6)) {
         /* The ID registers all have impdef reset values */
-- 
2.47.2


