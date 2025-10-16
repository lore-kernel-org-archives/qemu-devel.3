Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E77CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MwN-0002A6-TM; Thu, 16 Oct 2025 08:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mw8-0001kg-09
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mvy-0008QN-00
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so7670195e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617088; x=1761221888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J4wq07+UEHSfilyQtPFB1V8Co4Tp2jvFryHC4mc42l0=;
 b=aWnJXGrjfsvcUuSx96JaklK4LHBq+UNQqvVAia/Ek4pXBJhL7wI4gA+R6U83ikIjjZ
 pny3v8reCo91N+FpWzhjRGUpzcfBq4ASJGfccped08sNSycm65hS6bqqyQWEeywYYXIk
 4UpZIwDbhdrhTda8vOAuvoqStWuRm7tCa64PWhsnKmXT0KZiT1LAIY20nV07bbD/oF0Y
 Tka1KVc9bfVQfeoy/+S9gOMWw5Dm4AyedK6yf6qrCc0BkoCPJXEs1wxKj70jsUbHXztE
 QmTf5E0bYcDlmthc4JiSjS5EO045Sev7s8yyWYB+9qz5oB01dPuRzSdzQPSe64hGdgr3
 iHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617088; x=1761221888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4wq07+UEHSfilyQtPFB1V8Co4Tp2jvFryHC4mc42l0=;
 b=IZ153Z7PPjAC70gYugMV4V2sDXK7lVgUSKZnBKPlQIWHvu0SUDo5dqwm6ry+5R+k3Q
 Z6lSvEEA0u2OYeP3QFeMhSZH2Z4c7EEtnjjxBCSFcZrJJjyOdVCyQt7iDgDGDOeYHzlY
 6C2KB1tPJidlhE/0jGwWRa2OfqyiKFRO1zyyyZZZoXc7XpflfBCadd2CQidD/85Ekmq5
 gTW9rvf1G43O1TapG/PTJNB7XycROWRAsiFEQyBPEe9Ff6MmbeEjd3u/ixm1HZ3hPWwR
 VPu7qGup/VO2EoOiW/BdXBGGE8BdUMvIcfLVzPfw3DI6DcnIWXrTnR2BCtbSltPV07UR
 2Izg==
X-Gm-Message-State: AOJu0YyyV7HiUPPQ8H+DbSKKvB4KhTx1wYFeM01qbtKASYwgLiJkqPND
 0wztMU7EtVE6udQoANYq0FjM09fVqYPojSHPTCMwO9aXLfNIessv3iZofh5CRqpWqALbTbAZw/F
 XAsgxxOM=
X-Gm-Gg: ASbGncvUbRZu+E7qbsm0EOUKypSj5+A+pyacch+ev5PLIyfTjAff5qpYlvd1NTZUbAO
 OsTuYqpaaCGzTXSxG+AKR2n0/sKBtwLDvWXXm9oLIYmhbDuKRmftYLT6lCweyOavEGyubp5rIKT
 2GDC5BoQEW9SEl3Ewlu4yyhoarf6KjPOHFCLrqUGfXrM/R8tcRL/2+T71l/XScS21v06nCEHG89
 qHZrE5qsMwHWGgiq+Iunr1y7BChmOS99bpp9/yCLdTl6DhRTKjw5XzT4VUQB8ASRVqVUaEVVwm8
 Itq2GPngDYECyE224v0an6wgWO5WnINBaMaRHTH17Oo2MV808MNLcL8T5iM1jHxfyONNww+VRfQ
 Gp8bkgHdV6yxCWmHWzGr8a0VojuafLWKm15SBTj3s1b5MhoICfVtMJimmOn1XBcfOAgHYHLmIbP
 DBtLykvULBhNDqj7RIZB65eRt93uaLSHr6ST+9FdBQb+r0OXbjL6gcYw==
X-Google-Smtp-Source: AGHT+IFpHnQT45HiLQnwxLgna/VIWcC5XkZS4BhhcLUlVsWwL55gfZU4wDq8ZcMDa8DT2fh8b6BPfA==
X-Received: by 2002:a05:600c:c4a4:b0:46e:1d01:11dd with SMTP id
 5b1f17b1804b1-46fa9a89444mr227013155e9.2.1760617087872; 
 Thu, 16 Oct 2025 05:18:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f776sm25633575e9.3.2025.10.16.05.18.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/75] target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
Date: Thu, 16 Oct 2025 14:14:49 +0200
Message-ID: <20251016121532.14042-34-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Extract the implicit MO_TE definition in order to replace
it in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/openrisc); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010070702.51484-8-philmd@linaro.org>
---
 target/openrisc/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 29e6b51a930..52d51313f77 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -622,7 +622,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
     tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     return true;
@@ -640,13 +640,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TEUL);
+    do_load(dc, a, MO_TE | MO_UL);
     return true;
 }
 
 static bool trans_l_lws(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TESL);
+    do_load(dc, a, MO_TE | MO_SL);
     return true;
 }
 
@@ -664,13 +664,13 @@ static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_lhz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TEUW);
+    do_load(dc, a, MO_TE | MO_UW);
     return true;
 }
 
 static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TESW);
+    do_load(dc, a, MO_TE | MO_SW);
     return true;
 }
 
@@ -688,7 +688,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R(dc, a->b), dc->mem_idx, MO_TEUL);
+                              cpu_R(dc, a->b), dc->mem_idx, MO_TE | MO_UL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
@@ -710,7 +710,7 @@ static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TEUL);
+    do_store(dc, a, MO_TE | MO_UL);
     return true;
 }
 
@@ -722,7 +722,7 @@ static bool trans_l_sb(DisasContext *dc, arg_store *a)
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TEUW);
+    do_store(dc, a, MO_TE | MO_UW);
     return true;
 }
 
-- 
2.51.0


