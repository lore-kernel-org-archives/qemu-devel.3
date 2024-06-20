Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772B8C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJci-0006B6-Br; Thu, 20 Jun 2024 11:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJca-00065z-QE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:44 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcX-00082t-M3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:44 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6ef46d25efso118102966b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896960; x=1719501760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97cycViE9OQK6SdY90/SywB1oI0H0vp7Y3hsl3HXbfM=;
 b=tRgGGgEoQAPPranslMuJkrxERNVKM4LbFwoJjPjOGAyBDshZJOhoO1/t7YNLPbzkIs
 71QE062moNcbGO+9BCSE6z2yC+VvpnSax30w38Kap1BOG6J6XGneKPwqREoQ3i4+1oXm
 eAq7d4nfO5RVhBNQvZVD/+n0NV1iDw4bNKTSi+uLJ9IQ33UzFK3cXUGlwfrYbfOaVC8G
 r3DFnwtzq0kicQX8JATzqreOIiVzZ373w4nN5j2vnDpRYU2Rxzzv2uxLlatJtvUDOhoa
 KfrYDDgAA5oemJBM1LN4U6O4px1rJ4TjbVfinHUyJOD8rn2EfUGj67SihAJZ7gVy6Ja1
 h3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896960; x=1719501760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97cycViE9OQK6SdY90/SywB1oI0H0vp7Y3hsl3HXbfM=;
 b=YZtKT+vaK6bUhibqv8FPc8ezIDTW2CuzOnKwoU+xZ7Ax2U9+LZRqHBfwQ39qywCFGB
 LmGV6U5JZGOWKSg8nNxZpV0YSmoYrWBa3QysJkCEWXsj6A8hwrelcMkfFqg7d24ewdzE
 +URaZHfb5Gj1xvuI5izkF0Ltqjsb5d/vAcn5Y+s0DwfcRbHmCXB+qukpbbvDfUX4Kgv1
 n4hcMxCWQ7JeZr0X7yX+y7393b9MHxsXxdtrmCkDKOoY/NW0M/SUIUJ170h0nQxQ0OQN
 +pUSJnQ9tAohlsjnGHa77qytqEPDoqFVlsxDRZ8GVMfer+bhTivEoPzSZFwIK+/0B3Zt
 Evqw==
X-Gm-Message-State: AOJu0YyKeg3wR0mDrdFQ7kVMJRG0htS5F2fuGO2xr9fAVmaSj5hf7DYX
 vW0nDD6q5AwvbhnWexFnJ5b2AWRfrxEUqSj/kKFT73m1JeZOKA1lZ2VElchB7zU=
X-Google-Smtp-Source: AGHT+IHWqQ+U5RDCXqQGFMJSuSV70/qn1Ko7rwj6FST0rE/66lYbJ0eLG09x1vJsHqa3Ib9AVn4fpA==
X-Received: by 2002:a17:906:c1d1:b0:a6f:b9d3:343a with SMTP id
 a640c23a62f3a-a6fb9d3383cmr198180066b.71.1718896960112; 
 Thu, 20 Jun 2024 08:22:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed369bsm771539666b.100.2024.06.20.08.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 259085FA0C;
 Thu, 20 Jun 2024 16:22:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/12] plugins: fix inject_mem_cb rw masking
Date: Thu, 20 Jun 2024 16:22:19 +0100
Message-Id: <20240620152220.2192768-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

These are not booleans, but masks.
Issue found by Richard Henderson.

Fixes: f86fd4d8721 ("plugins: distinct types for callbacks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240612195147.93121-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/plugin-gen.c | 4 ++--
 plugins/core.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cc1634e7a6..b6bae32b99 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -240,13 +240,13 @@ static void inject_mem_cb(struct qemu_plugin_dyn_cb *cb,
 {
     switch (cb->type) {
     case PLUGIN_CB_MEM_REGULAR:
-        if (rw && cb->regular.rw) {
+        if (rw & cb->regular.rw) {
             gen_mem_cb(&cb->regular, meminfo, addr);
         }
         break;
     case PLUGIN_CB_INLINE_ADD_U64:
     case PLUGIN_CB_INLINE_STORE_U64:
-        if (rw && cb->inline_insn.rw) {
+        if (rw & cb->inline_insn.rw) {
             inject_cb(cb);
         }
         break;
diff --git a/plugins/core.c b/plugins/core.c
index badede28cf..9d737d8278 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -589,7 +589,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
 
         switch (cb->type) {
         case PLUGIN_CB_MEM_REGULAR:
-            if (rw && cb->regular.rw) {
+            if (rw & cb->regular.rw) {
                 cb->regular.f.vcpu_mem(cpu->cpu_index,
                                        make_plugin_meminfo(oi, rw),
                                        vaddr, cb->regular.userp);
@@ -597,7 +597,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
         case PLUGIN_CB_INLINE_STORE_U64:
-            if (rw && cb->inline_insn.rw) {
+            if (rw & cb->inline_insn.rw) {
                 exec_inline_op(cb->type, &cb->inline_insn, cpu->cpu_index);
             }
             break;
-- 
2.39.2


