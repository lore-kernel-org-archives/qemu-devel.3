Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A6CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHc-0004ku-A8; Mon, 11 May 2026 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHW-0004jB-FK
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:07 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHV-0002n5-1h
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:06 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcdaf06498so3253013a34.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523784; x=1779128584; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7LYD0+Gj4tjwx40OlV9ysdQpDSTlLZUgQ3DQLRj+lFM=;
 b=rtSzyG10JSMMzs9UDOMkQUKi31WdCiFIEUfhuWtCJ1yw1GgSTbDI1aqw0YxB9Ryhcs
 aI3KFs4INoi7q7fnzAmbVImlymyJQjOQcHtRNqkSxcR8D/1rBKGIRlma5Jss2/Z5YgLc
 03xQs0hB+cOfZiM1oVfyn6owd6irsllB7F753w+EzsZKHRUCcMyVx53ocbDfjFjWeTJ7
 Mqb8JIQ23HmiUQs8NjQ38hMtsjXQlbEVYmtIrx7TYTFMKXaC10Tv+RvsZJQQMWL8gNzR
 NNP6+aQXtoiyd3civxEsItggh0nC2NY+/05mVri2Zt//dPHP3i+ClBkGlmuPZiAvE/YX
 nQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523784; x=1779128584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7LYD0+Gj4tjwx40OlV9ysdQpDSTlLZUgQ3DQLRj+lFM=;
 b=gtoeMS0GJwRJ6vKehtuTCJL7OHKcEQjrl66x7qVvQgDzMRH020D3P7Sk1MhcDyL686
 DMqKdYALImzEr/gaetey6R1FjnSNnJ4wqjwGCaahf8EHrLMZ8uCp6YVCvDxsnaPNdhSQ
 Zm7DvUCCyjNyEGCjhLUNC2BywI7DfUiAxTn2PU6pVa0ccAp0hvP9xnTc526O5WuxGMW0
 +uULvCjCiRNSldCOmh8V9H7opLjg83hu28JTvJc9M8Ul49gGHQP716u1kPvfHOPeYxWe
 KnPIBB6r0LEgTFTEPm4zxLxVp188DqmMN/YgpLatFxeSJlIZp+Uk/1rvFGxBgVBot12c
 Y0Yg==
X-Gm-Message-State: AOJu0Yzy6ncWuiBsXohNg5TlzYy+2FC3bD8JY7LFWPD6zKRLtiWnlBZu
 ntBHsjC0XO0xjGC+pwaTIcOBybxjWeEe3Silz21osY5p/u/P+4RIHnO1
X-Gm-Gg: Acq92OGe9+BKfWkJGaK6qLkzPE6bIcJe8ExPK1lnPll6Flr1lQVvM4BzEt7+K3W/1Pg
 iyGrahQxlUeDkGq5fEIOSQcQC5v+oM3ZWQnuadEZVZyz7ZYxqibbB6HYv1mEQSYMyG0eCqe4ZZy
 /vUF3tbhSGIVZSQj9mqLwJMKS2l2Ep3wcsNb5toYvI/mrDGJcjil5DbyfUSE9PMvDdkaqQa3+Bg
 01QwVgGiR1S8gvt8kkWG1hYHfrbWCq0kMRjed8tOGb+X98uhbee+ugHYCm8gNXH5t0tWGlmYQU3
 GmAt7EkMpKzGU6KpC43AyDt3UimNC3JK4roI3SqX21EZiNJPqvCQxS8/xKD6m3oggKiFBbeEG6C
 dbUEaWMz64dPsUPuch2vWBJicsPs1ghvrD7cFtx/1SZ5ypDKsF4er2Iq7Zzh3i9z7H5/6pEPsuS
 7wCUfnAX8fmgcOJmfgKDEiAJY35ES5PvuRJdjwUb+9xV6wzkM6i/zEW10TX1C7X2wZYaeqsrkNd
 ZdIcJYthDG561DPd0SmlEgMRbxSpyNMa8gCmEFJfR7uC6Yz0RMvesZk00T87RORZYQt
X-Received: by 2002:a05:6830:8089:b0:7e3:7f84:4cf9 with SMTP id
 46e09a7af769-7e37f8497bamr5291204a34.11.1778523783941; 
 Mon, 11 May 2026 11:23:03 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:44 -0600
Subject: [PATCH v6 13/35] target/mips: add Octeon ZCB instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-13-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

ZCB zeros the 128-byte cache block containing the base address.

Model the user-mode-visible effect by aligning the address down to a
128-byte line and storing sixteen zero doublewords to guest memory.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCB out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  3 +++
 target/mips/tcg/octeon_translate.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d77717cd50..d8a1bfce77 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&zcb         base
+ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index daeaf07072..75b28c4338 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -174,6 +174,30 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 line = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+
+    /*
+     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache line
+     * in guest memory.
+     */
+    tcg_gen_andi_i64(line, addr, ~0x7fULL);
+
+    for (int i = 0; i < 16; i++) {
+        TCGv_i64 slot = tcg_temp_new_i64();
+
+        tcg_gen_addi_i64(slot, line, i * 8);
+        tcg_gen_qemu_st_i64(zero, slot, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
+    }
+
+    return true;
+}
+
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);

-- 
2.54.0


