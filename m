Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F382EF46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVo-0003AC-EJ; Mon, 06 Apr 2026 11:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVk-00036D-JZ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVj-00045K-0l
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2adff872068so18073365ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487905; x=1776092705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=EsZXNnpbQpvwM0X+DcUtg9YfPnW3WSx47Ay0FSdhUp3+B0BGN46bnbk4hHnMA6ETg1
 TIuJq+Wovr9JhjonC/XXg43i2MN6gjSsJslciLRWjijBq7+i6JxLXd/lw840voRM7zBH
 nUQZD/pDom3xdh+X1rjkFv854ZcTIRkaTeU6r/t06MBPz5Sszm87PElUbxmftH14xnTK
 3qx0lYWtTzCheJmf7x8xcaqOE4j2uhQ2L9T/G6XzXVMiZde9vPL4M/57FRz0d6iaieKq
 Te1UyqZy93RBVX4m8/w5fzoyyrBYSxKbwWkvGJpaa0iSXt0cTbEVTO23aNpELu36Sp5y
 OLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487905; x=1776092705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=be1mOmatF+jJJ4tZR0EdqQk4cW6r5K9A56AMmO11joFu9HSWUparKhHPvPEHVloeEB
 cAZ+L3kfHh2ZXcWbbmxfv9y9UQfxPrcJ07JzNT69HmUPepW7Km4Jk+Nfm3oeQuWcAc/I
 eu9hVJ0mbi15x25Bmp37jmQiNXNdcE/X75inW/sIX2+hy8+MwQJkS1EH90wxBWtLupHd
 AQ7z0qo9qRGTcE2060agnS0Vf0aDs5moQyXxY/0C3lVcXdv0C+PoEuWU4YKNn140rGXj
 GW3JiPawQgCxvlgPEkoSncJn0QwJnrrE0v1nSIbb5j3vd3uRMxWLZO2fblPKRA6owqVZ
 BzcA==
X-Gm-Message-State: AOJu0YxJLTOfPT2gV48dp8bcg4L2HkaVjsTkKGmsMEIYq5ERC2e8P4zB
 NIZ5UM+S8bJktqtDvE/NLyCdDPGdIC3oBnvnFXW9nZDbnz6Z0CQLPxo8UdjfIkJjPVV8qIvoQkx
 3v+/ic02w7g==
X-Gm-Gg: AeBDievIiWY8E+OxPLkpHLmCNXj1gJYfWx80rwiHM7vRKDa4a0SPYi7jwNfXxbTNIg8
 XqTnbUiLB6cqWk8NXMaV0PJKrKynhfJNsl5dj/D7x32fvgYQcBoMp9M5VKfzSVy/DPNKWXshwvI
 N7vsl7JT4D9SzKxNbDkkaO66j3PFLFrDohBB6ss7fjV3xMRyLUvOrr9oGfIU/RIkgozBRPkEzgV
 5QsOB6lmO+dJ6ZbYVu5aZdt4pODCjemG2OYAY+6c8s4jtSj9qw5+hhmcIhuygIOq2AX4kDlRJNT
 FIcLOCplUI26/K1QwQh2OCE+5VdextQwBVAhKAV/+3pKNPqj+pH/3oLzlgh1Ch9BphKHjnuvrmA
 NdGGHS0jqOwLcF07oEjhpMnZvXDrUc37qAm3kXxnXpgMzrftSuInKArsbGndNRsobVR48A7QHS1
 geWTYpJVyXdmV9PQ3dZYJBxgsxpOsOjBXZBsjBfV44AbtxcFsiv8l7TrWcVUYc8ES48TPs0APix
 4DV
X-Received: by 2002:a17:902:ef08:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2b281818ac9mr142415495ad.17.1775487905256; 
 Mon, 06 Apr 2026 08:05:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 12/14] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Mon,  6 Apr 2026 08:04:32 -0700
Message-ID: <20260406150434.407201-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


