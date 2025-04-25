Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15521C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCl-000066-AR; Fri, 25 Apr 2025 18:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAw-0003hf-Lk
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAu-0001re-0g
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:37 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso2732980b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618734; x=1746223534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8LzgiH6o+jgmOJTogSuDgijqaL98PW8+VDrGt69bqk=;
 b=VR05XxwR99j4Mw1IcbT8WavR/rA+Gpvrpc3oVScAY5dqKKjw7qeLO1D1aDDqQW8z4O
 4fcG7ywv8U08GH8BqauJInEP8M7qvbO63p5e7Vuk+t/lrfcLWduonGHT9NYN/ZnekF1c
 9rDNBQ3YKIznh9C8jXQzK1FRlOQro1C5c51/iDj92tnifxOp8Pf2+8d7/GZlxHgxKGzB
 j9iIs/RUf+Wk8iOFFIHLBmGVPIqfhopZGaSmfGhozsdH6lghdl6v5N6I71nK6TBE45Uq
 TU9u9/0dZwi8Hqhk78Yg/ww3qp4WSwUlAOR8ACS0AJSODPlpDrADTsEjj0qaaBrkMt22
 AHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618734; x=1746223534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8LzgiH6o+jgmOJTogSuDgijqaL98PW8+VDrGt69bqk=;
 b=gzQnDEgzFebmKeoXNqBY/pQKDIaZf13BGA65L0JTWn6oQ8bs+IbtgQZOptlVL+mum2
 vqhzgIBOfolbKUW3+sm8CrOImnmDIArjXcP3RcjcvI2kbDoYuq5sELWkR6QwSEr0AU5L
 YKPIELBJz4X4gt17WN8r/8DW274x+mJdvojKNySyZcxvDNktVFAESg8V9Rf4ioy6D7p0
 bfldt7Jh5Ppx/4PFMcAojym2KMfX/lEKIHBWiREVPofBZeEY9dPhqsxe3VcGBeb3dBFN
 lWLBChHp3i0+JGUdeGAkEiny43OHJfsDWGGtUu7rS4AmwK/tSzLiYJilLG8PeQxDXDBe
 Q1sg==
X-Gm-Message-State: AOJu0YxhQb4NgE3QU1R1gb6bxwhWsL0cc5x1t8WJ98zyw7GjSwIKyNZx
 MCgA+CwF8WbLnvTeRuNA1i9umeD1TmFvIFAedyxt53ucnTYP8+yFBFVZ4uYskeqeZTPp1MgJ2GL
 I
X-Gm-Gg: ASbGncsMho0ZQMUomXLwN71YmsuSONVAmZz2QkB7E5Jh5G6dpnaMe+vuayxnzPNb5j2
 zJdGvNLFgZGethvZLiwjJbNdYbOckrZr+37eMDBBID6qHzq6qsh5XI1La7rMSQlPQnG69EMTMKF
 m+TDYZxAOWdYjn2W3ReEfSQCtrA3QREBSqXiolcGsKD8XSK/8lcloJadyW5ZjFs5eGdApItd9KT
 TkSR/1KFoyE0vGGzymo8DRwoDYsTG0PNwPUuOI3AbMdeMM/ZnUTAZS1yTDhRoDuIfGXLm6IjEdf
 JmSffczxij5/+V3BrMVR2/Ya4OYaZQNxMOVVak4tJi2iWQv7Q05Jt41XU2pNejwWx1AclXiWwO8
 =
X-Google-Smtp-Source: AGHT+IGsVW+qYnR9Vq242NBbtkU33MBO622kXYPrIyD/hv9ZoIU3+tiG5B97PQWPRc99WErAfA1nIQ==
X-Received: by 2002:a05:6a20:6f0a:b0:1f5:8e33:c417 with SMTP id
 adf61e73a8af0-2046a3ed572mr1285903637.2.1745618734333; 
 Fri, 25 Apr 2025 15:05:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 134/159] target/sparc: Use tcg_gen_addcio_tl for
 gen_op_addcc_int
Date: Fri, 25 Apr 2025 14:54:28 -0700
Message-ID: <20250425215454.886111-135-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index adebddf27b..63dd90447b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -396,8 +396,7 @@ static void gen_op_addcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
     TCGv z = tcg_constant_tl(0);
 
     if (cin) {
-        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
-        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+        tcg_gen_addcio_tl(cpu_cc_N, cpu_cc_C, src1, src2, cin);
     } else {
         tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
     }
-- 
2.43.0


