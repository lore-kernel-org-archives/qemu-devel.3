Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F09FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwh-0002d5-MC; Thu, 16 Oct 2025 08:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwX-0002LZ-CP
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwU-0008TF-Qh
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso5141135e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617120; x=1761221920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jkpIB9jVoYkyVuwo6rPqTXTnxZbZPHzXN+SQOqmnfE=;
 b=k2kIkafz1O5lkoJ2ce+3CVCU5Q6a1l49t/6x2+iimjSBYoK84HP73S3mC/JBHKb4S9
 MR9hIFCC1w23YQTUeCpu27Qlwev0zpEqht6cHpt/zrVptXiFtu3pmPGNAjdz61J2yFGM
 96OgkxgGMv52weg/U9fpYvl9hr2M08qjVOPOJqJ3eWdz/l8m+kezcv10jkEz4+L2fXXF
 vsBbe8IVLpjXzSVaOK58ZtyCrIQbG09RY6XwzfNM/D3ndpJngLscbQjm8rBae7SAtYta
 iB5u0c+6JliF8d9lEzDtVTlOKmcwXjl7+F1b/aGStyR31DsRUMjsc4UI9uprkkE8MS99
 juXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617120; x=1761221920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jkpIB9jVoYkyVuwo6rPqTXTnxZbZPHzXN+SQOqmnfE=;
 b=I91Wv0maEhdC7eMfl9HHqtGaba8pAx7h3+U0e/WjQBM0qQ0+SQGr4xiMw+vg64nmgu
 LmFoqPe1IWGIfCSyFMcksN4I6F92qpT5WMV9oRnjeMW0xSY4Co1pZTBBwsO9ePzCRnSj
 dfeNLPGjQULJ4nNZkvFfSyaheIspIyBZEHPnrPSmSwXu8aHMlrg4jwTPblwxJpiLQG+1
 AyTbtq1pGE851wEJQ8KwRV/JYSCHpPt3Y4g6rbV755zBOgAJztlixiWuBh6BTu2cLi1+
 UyJZU1qmVfGTyBBgCIX/DlA90My7lmER6GzslOMoBdB5hqgaCAsO/JTDpAyWurggTMcF
 fiPw==
X-Gm-Message-State: AOJu0Yx0089jF1Ouf0jo6s85Ibz1p93fDzpnDESBqBOeh0pZsiWW0I6N
 EDG1Ptg9aYR0cYXJGzYor6/YW6ne3vnMlDdPK9Uj8dfrq6aIFvCRlZwdNwIk0JcPkGgspnUnAdw
 biWSyGM4=
X-Gm-Gg: ASbGncvsBSEaKqHuMeyUygvq9ZOnYmlkebRfTgGr6AOKdXo2l/YNgmeV8D5oFMZag/U
 /N+piSRLDA/vxvzpLY0wpMRTp47cID+GQtjy/GKz4sUVGCyUSrxQpdMLn2tx5sw6q2ErfPgra/z
 GIiTb/EhGJCMMD8D41A44FzqZCHWltLCHD9W2Qlak5LmPfY7yZWOgeM7d9qRucmaRRMpR86umxF
 vS7BE3A4MgQNXAL0ZEZYDF1rC+EoUSv6kzfmF2/jgGvqDXsYB+TZZiRpzCRt0D/MCV+IBIxMbEs
 +GqrmQMBNeecipfWEEJtuKsLjIIAXCHAiPP/dgsth0VMMjBBwXsbHsYvjgzMAnCLgB2/KFCIQv0
 Os+CLmYcosI7zUH19UhnGNDMlloVBpCSJiLRLfRZ6Z7444jJzS3PdpQo/Zi6U8iZ598x3el4EZj
 tuownNjEDZ+ROxZjTpmyMnO0+fLQ626JHZ8nnUv07dsNrCPLT4DUOB/VMGN6fvDlPt
X-Google-Smtp-Source: AGHT+IGsacMRdYjP83FH/OKfHRzwI3PWPvASBlQiED89W619Pd/CbExnVvWq1uNoelpxJuvA3eCzBA==
X-Received: by 2002:a05:600c:4f95:b0:471:3b5:aeac with SMTP id
 5b1f17b1804b1-47103b5b630mr47031095e9.15.1760617120336; 
 Thu, 16 Oct 2025 05:18:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710eeaa236sm18773265e9.4.2025.10.16.05.18.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/75] target/riscv: Use 32 bits for misa extensions
Date: Thu, 16 Oct 2025 14:14:56 +0200
Message-ID: <20251016121532.14042-41-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Anton Johansson <anjo@rev.ng>

uint32_t is already in use in most places storing misa extensions such
as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
RISCVImpliedExtsRule::implied_misa_exts.  Additionally. the field is
already migrated as uint32_t.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251001073306.28573-2-anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2c2266415ec..4c13012442d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -50,7 +50,7 @@ typedef struct CPUArchState CPURISCVState;
  */
 #define RISCV_UW2_ALWAYS_STORE_AMO 1
 
-#define RV(x) ((target_ulong)1 << (x - 'A'))
+#define RV(x) BIT(x - 'A')
 
 /*
  * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
@@ -582,7 +582,7 @@ struct RISCVCPUClass {
     RISCVCPUDef *def;
 };
 
-static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
+static inline int riscv_has_ext(CPURISCVState *env, uint32_t ext)
 {
     return (env->misa_ext & ext) != 0;
 }
-- 
2.51.0


