Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88DFC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8g-0000ZC-DJ; Wed, 15 May 2024 05:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8J-0006Rs-NI
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8I-0001iG-3y
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41fc2f7fbb5so36454585e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766068; x=1716370868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QR5yb7F9XGohps2L09MGmPdjKhQ67DsiVbKjELjIFUE=;
 b=lMsVruP+ekUhEvUUn+5FE9DLU4qIKfJe8Ldt3YHtdzcVHJz5+4IRZr2lGQMUL6ejx0
 9iKprTmLkf1jzQ+F0x69s53UOVnMIlLOwjFz+ldH/SgeeKqnUieCHW5PXBWo0RA+aS0U
 2VORjoLCKV6Uzc0p9e3GoPOLJ03T6GX5vycNkSkREO62xj4rtsA9rRYNcpLZNfX22b+p
 bfzE2RAImEGrgyMM/qRT+cbG6NAKXRN9HZvtsjkQffG+fPgbKlYwPaEB83LOKwzjaRqH
 QDa31hohn1EnUTfDxiAVKDeZNsypLoZcYzABIiKVIsfom28FtC8UY8rjyhvY7hDYOU4B
 GBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766068; x=1716370868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QR5yb7F9XGohps2L09MGmPdjKhQ67DsiVbKjELjIFUE=;
 b=XD7d/tAkku3W6UsjAttqxtz2KuNAtx+Lv5PcV5ZisOZNNhZCyjH57KIqtffCW4DXB5
 ATaMcXjwWHBskWVJkMfTXDYwyuAHgCt8/AD78EWVbiugYKqYo7MRwcpPLw1OAbJRZfSF
 brLgpo7IfFS16IiDPy3JSbtFuignhIP46OiZ0jbniBCrw0vyFfv5N2G/p1DTjvyG2sJI
 j7RfjegDne6O+JSNx4IULqjsqimcmeduisuSxOf7GZXT/wJpLlgoqp2LTGm+vbTnvlDm
 Y+tMEJAbV3c8lKdxAiBEHjL2JlyQTn+cHS4KU25LasxJbCySM+NOFSpFaBjDEgIvQzCO
 Botg==
X-Gm-Message-State: AOJu0Yx619Do6SiohEOMtp1WOisXeHXc1NotuKFpexl8WgmVqqRxDqWe
 JSNAx/yXLhZ3fRpKR5A2uOoDW4I442vFmLDy7buYWwNS19nTexd0lePMlm/DsI1dtTPYCF1ftUq
 h+A0=
X-Google-Smtp-Source: AGHT+IF39BYVTVrjZ73gj4IZQcQoQwRrnkCMqlZBiP2GoUwraFNSrq0k4/oNhyxnAK6lRt2Px5dluQ==
X-Received: by 2002:a05:600c:3c83:b0:41b:8041:53c2 with SMTP id
 5b1f17b1804b1-41feac51e04mr151917855e9.15.1715766068691; 
 Wed, 15 May 2024 02:41:08 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 33/43] target/hppa: Do not mask in copy_iaoq_entry
Date: Wed, 15 May 2024 11:40:33 +0200
Message-Id: <20240515094043.82850-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

As with loads and stores, code offsets are kept intact until the
full gva is formed.  In qemu, this is in cpu_get_tb_cpu_state.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 70df42f558..ab8dd161ad 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -637,15 +637,10 @@ static DisasIAQE iaqe_next_absv(DisasContext *ctx, TCGv_i64 var)
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             const DisasIAQE *src)
 {
-    uint64_t mask = gva_offset_mask(ctx->tb_flags);
-
     if (src->base == NULL) {
-        tcg_gen_movi_i64(dest, (ctx->iaoq_first + src->disp) & mask);
-    } else if (src->disp == 0) {
-        tcg_gen_andi_i64(dest, src->base, mask);
+        tcg_gen_movi_i64(dest, ctx->iaoq_first + src->disp);
     } else {
         tcg_gen_addi_i64(dest, src->base, src->disp);
-        tcg_gen_andi_i64(dest, dest, mask);
     }
 }
 
-- 
2.34.1


