Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DD6C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmd5-00015P-IR; Fri, 17 Jan 2025 08:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000x1-Fn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002DH-98
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:07 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso3968588a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121382; x=1737726182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmjVABPbnCsJ8Mr6h+L49GfrK8//sgmPrYPBbRhvLAY=;
 b=Ibuq4YfcqznUg/DbVMmsb8+I75Hqd+4yySzd6UyvJnt1dy5msd2bAEJDGIu2gjr77P
 7kv4E57YFLAt5TGS4EDm6FO2v1u8m+4a7rQti4CG0kv1gdrXPttuVMMuCt2cNm0s2WsQ
 gLw3x/+iDI/wPl9il2MLwX12gP4Fwe8C8Pjx1Eaktd5wAUjC3teY8pMDIsxubdGepbHA
 7NIj+f83kmSDXzLb21rO75NRe1lwv5MgYsmuPDSARvE75qwjelGlz4eGRnvmWAl0jyzy
 FES5UrBFi9Z40NnbidD6U45t4oGJCIlZk0NB6RGUT+K09AONywiUOrOwCkD1g7qORTLQ
 PO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121382; x=1737726182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmjVABPbnCsJ8Mr6h+L49GfrK8//sgmPrYPBbRhvLAY=;
 b=a0wfKc170NznYUlm6Gqmiqw4ItE5XYjrKZdYpB10yyLH97KLvP/7Zxx+ZkSf5UMixm
 ZVfUEF6IJfgHhe0CzoeX3ftKT3ZNWq0Zf251/VXTPQwdMxTKOCUkjHL3KcWISpWja6GB
 Weq406CrPy0SR7iAd9oyXB3borBcALYfHDrW6JZvX2pf7hB6rarLvPMMpodlmR3GrZuF
 YLjBtb5pCht+X/lFa8cg4nDhVtf2USdIrxSrtmGUXJKISjzEyFdVqbxTo3eiaYjt7Giy
 GHVcpGgjB/NCsco7mcqxMLBSjSma2h1cjIzYiIT6A+NAMzjiUYlCbpHUEQe7DgT+QFv5
 TQPg==
X-Gm-Message-State: AOJu0Yzl0J0BDXpYMjRk56YTzhw5WWQBMYi8yn0Nzn3iF/uNqyvlhEav
 pbmGlJWqRqExQ1DnJhOc+DVTLFY9Q2JAo9xcCtk2sHf58zPHD7IpJv5ioiw0b3g=
X-Gm-Gg: ASbGncsRTTBNmkghaR7xN1PxzAgMmUNle/nIA5MWh4HNdPh9Kk32IU6daMeKPKH5wEm
 B1B9I50aBrzbV8ILuG9e+ygkCT0KuhQWoDpB4HsoDbb94sOyWw4fL7AY0b64inEyZyaI8RuwOoz
 lPKJz08GEsjI3AiHLurmaI9cOR9iNiG+q2xJRgYsKss523ZKeZLfKLXtBQuKHleQSK3KEWY9dUL
 w1Xoz3FHmLwwn7gq8BItlFOKYSxZY1UuypAzaErh0VOsMORNB5OvEA=
X-Google-Smtp-Source: AGHT+IGrp2uYlWu3xihGxu1xfJOH4DM4k10hWHqLaKkKD0ubckw9XXlY9MDMC+XAadbbDjRL6Y0K6g==
X-Received: by 2002:a05:6402:2692:b0:5d0:e73c:b7f2 with SMTP id
 4fb4d7f45d1cf-5db7d2d2ffdmr2654110a12.7.1737121382176; 
 Fri, 17 Jan 2025 05:43:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db736428e3sm1486362a12.14.2025.01.17.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC3CF60884;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 11/37] tests/tcg/plugins/insn: remove unused callback parameter
Date: Fri, 17 Jan 2025 13:42:30 +0000
Message-Id: <20250117134256.2079356-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-12-alex.bennee@linaro.org>

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index baf2d07205..0c723cb9ed 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
-            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
-                GUINT_TO_POINTER(vaddr));
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
         }
 
         if (do_size) {
-- 
2.39.5


