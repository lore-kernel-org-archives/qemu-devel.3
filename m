Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557FFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQP-00076p-Eh; Fri, 12 Apr 2024 03:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQM-00075t-0K
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:15 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQJ-0007Di-5Y
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:34:13 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e424bd30fbso5372505ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907248; x=1713512048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYC/ppUfzbE2OTFde4QzYfLBrlyxo0ZotFcSEeLzOeA=;
 b=E9qaUephsaRJywbRSBnjfLIYMfTX8068vuSeuVDnoL6h5cbdSB2HlVBIXk1ElXsZ1w
 Kh1CWxeH2GFs89QTCFwzup+NSgEaNPjjhu+yYheHX9oOXNXlFDwrfUJF87lxGnyCxDWT
 kHFJnvAQ7lEpqKduizTQA61v41gxMDnqC/naoSGTJwY8yYKNVlI6/kPLBdbzqJU+JbuA
 F6/GAlnFmfzTvTboyj+zA+78LpMbsIPQtguyaRk20lNcVvigRbLPdo66NtzalYccXJRv
 7MZSts1aUeDSmiQHr1H/Eg2BvYLbHgaFDZ+tl0JorODKTNraDFLSYbwtfaG/G0vywT+v
 LTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907248; x=1713512048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYC/ppUfzbE2OTFde4QzYfLBrlyxo0ZotFcSEeLzOeA=;
 b=o0Vyef+86dVdDiGtnH56r7xgjAuV+4/LLZtiZ6f2Gajuz3xkNz1gkXDi7bGr2lCsHo
 fmqsGLyDLa2E0TXSGM1fmtgauZ9TbTfl2Jaxou+p6F6qaBHdH6In37Qqikz+UPyHVz5G
 +xjvp7WsIYtdMyYtzQPyY85pymJ5bEiEbpeRITwF9OsUPpP1YKAtg72yfjPjJatfEap3
 EzZfsS3ZAPePQ1wEDjhnVpNfaL/260DhkXsh75o1fjV1nFWknb8R0vox6b2OuMo+e4e1
 +oveI3SxqSqx1TEaq0mqCyusv1qVbJol7+dQHB1NGY6l1hi2FO6X512d/kOxZuUVDAnT
 razQ==
X-Gm-Message-State: AOJu0Yz+9KswDaSAFO0cNX7Ji2W4SsXYBRheb82grzfST5t4fGTDz1fi
 dwHeLwiaEsZJmiGGewl++XLJ6VPhPbf23W1AfnQyTz6jl4g3g6SmaX3OHNHbHud08cIpLokR6zX
 P
X-Google-Smtp-Source: AGHT+IEt571N9TEentdL6d3VO8DyRx5v6HP0TKv6LTupAt+6BKEpjzNqHI94hQj+FZEx6GFctKY69A==
X-Received: by 2002:a17:903:230b:b0:1e2:9676:c326 with SMTP id
 d11-20020a170903230b00b001e29676c326mr2221309plh.29.1712907248262; 
 Fri, 12 Apr 2024 00:34:08 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:34:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 26/27] target/arm: Replace sprintf() by snprintf()
Date: Fri, 12 Apr 2024 00:33:45 -0700
Message-Id: <20240412073346.458116-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240411104340.6617-9-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 985b1efe16..f0f4fe6714 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -433,7 +433,7 @@ void aarch64_add_sve_properties(Object *obj)
 
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
-        sprintf(name, "sve%d", vq * 128);
+        snprintf(name, sizeof(name), "sve%d", vq * 128);
         object_property_add(obj, name, "bool", cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sve_vq);
     }
@@ -458,7 +458,7 @@ void aarch64_add_sme_properties(Object *obj)
 
     for (vq = 1; vq <= ARM_MAX_VQ; vq <<= 1) {
         char name[8];
-        sprintf(name, "sme%d", vq * 128);
+        snprintf(name, sizeof(name), "sme%d", vq * 128);
         object_property_add(obj, name, "bool", cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sme_vq);
     }
-- 
2.34.1


