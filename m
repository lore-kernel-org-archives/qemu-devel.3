Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EDFCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Muf-0006Vi-Mi; Thu, 16 Oct 2025 08:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuC-0006QA-Hs
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mu4-0008Be-N7
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so5285905e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616973; x=1761221773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mBsbZISc6ACBLfoOceQyvet/QCIN6Cqv+Hdz2oKRlHk=;
 b=k8w1Lh5Ae7rLiiSpzgClEcuKIKgKtDTg9It5MYZg+KarJ0FUw5u1OQaH4nihf3Z8ZE
 eivtus8EVpssR2WvZLuCuStwbOyJn81/yWnqPunkDqGfREVjoUidatg/xLkOLscYKQk8
 DY/+qu2RXFjZFjJXhcx7cgo599Ec1xLlJWSov4DMe68XBqxDwrNTWia6eDPUfKtRpGA2
 ZTx0YV3kFNSSPt47crFLfsEOpKmi2PNlDpc3O1LkrdscXkE6piwjtr2DHJX6CwGhuXoi
 E8e8zLmyW1SWzUGCsTb00vZc1/arBr2uDqaUe4LLChJAga5va896PZFVcCu2twEirr4K
 AcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616973; x=1761221773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBsbZISc6ACBLfoOceQyvet/QCIN6Cqv+Hdz2oKRlHk=;
 b=vO0XnGIkeuma/5JItkkJ1qUh/IHpMY6oMGnVF3ozoDpJgpZ10AUTB/NXgH5QFWYJ7D
 j0XJ1ckMYdncprVye7zeit6/EesPpIT7L4wwUNV6no/uAMolvD1RXRbYKuGs81OBxqPc
 GFWtFQXLmfYCaky07BC9s8WTuowzuMZqV3+yy2DAkIrzsApVlL2RVfLi9drG6YBNCiyD
 Zh0zDY1xjePbYaV+vUqd3eMKV3RQf5VCHYJ/v//cZ6mARPiMC6kohfL/0eL5RXWgPR+H
 o+jjb6+NAC4D2Ci3li9rPWwz6aUk/D1LlNdXkzPVSC2k9XAK5TbXoHdMbDrzQ2mlzIdF
 FE3g==
X-Gm-Message-State: AOJu0YxKHP9/pwOLSXpxiPgjDdXQtitqqS5VI6pzQ4ZaUDIcQSwVVDk+
 1J75zDa0Hwk36g8H9ahHfrGiYeLM/lsKk3Y5viVtdgMYzC/8x9gTJa7QAt3kzekOiNQr/J/uYOD
 Vt+XQmu8=
X-Gm-Gg: ASbGncvZsiwKPv68U7Njzc76Uot+yOVzM5+ie5rxufUpmvWFmzwi1dAInp5dlpydkdO
 iXE92nVAIsFDIWvZ8R9N6FyIaozS9tCgqTOZxlAk17aAmSCk/215s3u9tJ7DAWymQWgAYPMrctD
 5aqcI6ZH192nrs/WQH+yUZMR+9WZNb6bbnSMQx9vMNkzH0ZF86XriPuotnHVnwClEEsIRfqBgEj
 D90vBAT2WZaORUPnNlCNqZUlOWr+oYZjxHIKaV+NLye3C8solmtM8wE07roIFXD5XkX0bh9g4x6
 2/Y16B30vLVpM6EFJW3cIGT3Ox0XNQGCnZfQ5GbrwpT17PNL6mRRwT0EomnDtigjr0I5qLmTFgm
 Ney5QUgWOBKBxR/j1TzWZ4x6aUnWSaD03XITa/2NabcPn/Y+cl/bQbEcTnRIpemr6IFdx03WNUo
 h2HVkdIHGgcY12/ZBN3r3u/nj73MYV+FmHAULRvNFS6LrxHTTIIBK128nWln5zgLUK
X-Google-Smtp-Source: AGHT+IGVU0yctHcR9d48/QJuers3QKVRtbcTge6zUFLgzuKUoIhWk1/JIy7I5vQcpelPVtMi+92AFw==
X-Received: by 2002:a05:600c:1f06:b0:46e:384f:bd86 with SMTP id
 5b1f17b1804b1-46fa9a9443fmr206268535e9.5.1760616973277; 
 Thu, 16 Oct 2025 05:16:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114423862sm23646235e9.1.2025.10.16.05.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/75] target/hppa: Conceal MO_TE within do_load_32/64()
Date: Thu, 16 Oct 2025 14:14:24 +0200
Message-ID: <20251016121532.14042-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-6-philmd@linaro.org>
---
 target/hppa/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ee0c874342c..4680d826345 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1599,6 +1599,7 @@ static void do_load_32(DisasContext *ctx, TCGv_i32 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i32(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1617,6 +1618,7 @@ static void do_load_64(DisasContext *ctx, TCGv_i64 dest, unsigned rb,
     /* Caller uses nullify_over/nullify_end.  */
     assert(ctx->null_cond.c == TCG_COND_NEVER);
 
+    mop |= MO_TE;
     form_gva(ctx, &addr, &ofs, rb, rx, scale, disp, sp, modify,
              MMU_DISABLED(ctx));
     tcg_gen_qemu_ld_i64(dest, addr, ctx->mmu_idx, mop | UNALIGN(ctx));
@@ -1676,7 +1678,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = tcg_temp_new_i64();
     }
-    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, MO_TE | mop);
+    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx);
@@ -1691,7 +1693,7 @@ static bool do_floadw(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i32();
-    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UL);
+    do_load_32(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UL);
     save_frw_i32(rt, tmp);
 
     if (rt == 0) {
@@ -1716,7 +1718,7 @@ static bool do_floadd(DisasContext *ctx, unsigned rt, unsigned rb,
     nullify_over(ctx);
 
     tmp = tcg_temp_new_i64();
-    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_TE | MO_UQ);
+    do_load_64(ctx, tmp, rb, rx, scale, disp, sp, modify, MO_UQ);
     save_frd(rt, tmp);
 
     if (rt == 0) {
-- 
2.51.0


