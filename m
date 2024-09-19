Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27BACDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwL-0004i7-3I; Thu, 19 Sep 2024 09:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwE-0004T0-PV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwC-00010B-3d
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so7125165e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751470; x=1727356270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PwISEcabRGvIN2Ug75sruZUxfeshtkeh7kv+0zeczuo=;
 b=cplLOTvdKS7F8EPDN089sY8dKjW9FEnj7HFjTWuzuizsiEs2tQd/XP5orltteiuhFd
 yvM7r4i0GlVsx5P3c2cX9CnZOGrO6Fnh/d0o0pD5VWU+WYj7cmlELI5NADaZDwj6oqdI
 P+AldwP+zJ/IbhNTwhKb/U7H6uhzUKcOFjRMt23FoQP7QmDkCSWXWBQgNWDYwAVpEd2M
 AhBRRbKFgJsxcNRqTt+BiWuvKX3q2kOTPZlMo76l7wyRgUMA5YWqqSC2C4yJXV3WuhUk
 Y9jbXb1qK+6NLiKuqhyyTRqMCIGl+d87HWvuPXuurGQoSv+4kj8SmhmPKxTL3/YPKv5Q
 C8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751470; x=1727356270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwISEcabRGvIN2Ug75sruZUxfeshtkeh7kv+0zeczuo=;
 b=roGpvKXmLdztKv6/eNhrUDK9ZGy9ZGXsZv9HFXHGOJoynjaUbLeQteWufog6ew6j2O
 XUpnNaOMBcUyoI3E1yeE6pXYexuT0VkrvjvZdcf8xmVdSmtjTgxtqA+joF0vcOJcwKSD
 4WoDCip10QHDGAM5/1Gbh/hUfzHAnNhBjKLMo7EAbAfzRcRMhFWg7Bfi9tU8PHX/aHji
 gkYLXedPHkDr6bTRNvaAo02MUfQOrqzp+ZHIgwrJtInJYcGQkTelf1saDS7AF2iYFqhm
 s5xhFHWTNcZG2n9nkUuni/YZXY0vZkaE1sLCHBX0/om4qDkm4v61EAIcqY/KeXPlIHdH
 747Q==
X-Gm-Message-State: AOJu0YzMTqoNGuvmK4TPTIRrsXuBu30vr2d696wUD/VhesYRyhUX8ATB
 5alAMBCkYH60y12WRDClg3vtG0QU0sKYCIrKda0ZUF88cK5iMv7jgKu5UVmpfeaCc2RNhDQ4QtL
 n
X-Google-Smtp-Source: AGHT+IFKkI3yU+QS4RPnD6kGGbKD833TqkEwGZ5UlYS0jw3jqY55aC96jqgXXP6dfKZbjA9067q+Ew==
X-Received: by 2002:a05:600c:470d:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-42cdb56fa94mr170560335e9.31.1726751470486; 
 Thu, 19 Sep 2024 06:11:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] target/arm: Use tcg_gen_extract2_i64 for EXT
Date: Thu, 19 Sep 2024 14:10:33 +0100
Message-Id: <20240919131106.3362543-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The extract2 tcg op performs the same operation
as the do_ext64 function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6d5f12e8f55..1a0b2bb33b6 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8890,23 +8890,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-static void do_ext64(DisasContext *s, TCGv_i64 tcg_left, TCGv_i64 tcg_right,
-                     int pos)
-{
-    /* Extract 64 bits from the middle of two concatenated 64 bit
-     * vector register slices left:right. The extracted bits start
-     * at 'pos' bits into the right (least significant) side.
-     * We return the result in tcg_right, and guarantee not to
-     * trash tcg_left.
-     */
-    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-    assert(pos > 0 && pos < 64);
-
-    tcg_gen_shri_i64(tcg_right, tcg_right, pos);
-    tcg_gen_shli_i64(tcg_tmp, tcg_left, 64 - pos);
-    tcg_gen_or_i64(tcg_right, tcg_right, tcg_tmp);
-}
-
 /* EXT
  *   31  30 29         24 23 22  21 20  16 15  14  11 10  9    5 4    0
  * +---+---+-------------+-----+---+------+---+------+---+------+------+
@@ -8944,7 +8927,7 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         read_vec_element(s, tcg_resl, rn, 0, MO_64);
         if (pos != 0) {
             read_vec_element(s, tcg_resh, rm, 0, MO_64);
-            do_ext64(s, tcg_resh, tcg_resl, pos);
+            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
         }
     } else {
         TCGv_i64 tcg_hh;
@@ -8965,10 +8948,10 @@ static void disas_simd_ext(DisasContext *s, uint32_t insn)
         read_vec_element(s, tcg_resh, elt->reg, elt->elt, MO_64);
         elt++;
         if (pos != 0) {
-            do_ext64(s, tcg_resh, tcg_resl, pos);
+            tcg_gen_extract2_i64(tcg_resl, tcg_resl, tcg_resh, pos);
             tcg_hh = tcg_temp_new_i64();
             read_vec_element(s, tcg_hh, elt->reg, elt->elt, MO_64);
-            do_ext64(s, tcg_hh, tcg_resh, pos);
+            tcg_gen_extract2_i64(tcg_resh, tcg_resh, tcg_hh, pos);
         }
     }
 
-- 
2.34.1


