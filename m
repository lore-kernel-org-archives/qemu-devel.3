Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA11ECCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 08:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lrv-0004Za-2b; Thu, 09 Oct 2025 04:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrt-0004Vd-AA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:21 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6lrp-000864-9V
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 04:19:21 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso791123f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 01:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759997955; x=1760602755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRrTRs7WoVTfIvsVIS3uf213phlt7Hh6/hCzWrLKURg=;
 b=uUclbX+HefDPKWmhZ5rsw/jK1A0vdRD26JL0+Hk4WNKcTMXjJiBQXL47bbHZqez+c9
 SrEe+sAmMjAHcVliaHjF9hJKwWiapSAkqHAjLzGSZdykk+VoMKLNUk5oW7qvyaWxg8dq
 Lcpkdq55wGZ8onijNxzD/D0EMH5N6g1MjF5BpOlIeGcbcjDFT6LE/lum5e3NSBPIr4Jx
 UhdAnXqJmllfFgF4zuWcAyLarbIEcQitMczx+J/O0uk24tqU2GXumEHPvoS9sUXbk/eU
 nFHgIeRfXE9n6nC9I7XA3KdDel8KKQDUB5WV7ztCBQJdOpNArDgvMBBRjzF5GWJGssw/
 xGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997955; x=1760602755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRrTRs7WoVTfIvsVIS3uf213phlt7Hh6/hCzWrLKURg=;
 b=qWnwl+z8dNohUof0W3QdEYlhhF5Yy5GmVnNy69OF3ijH8Mc8ucOoEN4yqgPwXoMT69
 +A8xMhiFLX9Ex4GsN8d/YgGssWKVFaYzJjr977mheyo8y5/zWQnxW9zAshzMZtdzkSgW
 mf8BIsdu66QLuDOK9VTS0SOOIY1WjoZoO3Wf47DGOuHygDvdIqLfbaHd/TUBGcic6WUO
 XfAmvODudDRO0lOlPc0U82GznuH0Ap2xOJGsMhi/xE2sxu11FqBVUTrpYOAciuHiLm5t
 5lhqFTpT2h4cvOjqjWQWfnyfikANbm0/E6Zz8/dxw3BY3TixGe+JT87VnkYCyLTxhRUU
 gWMQ==
X-Gm-Message-State: AOJu0YzOapge7aIz8pVJqqNP3Pz2079aQBOvA7PMxUvcg3Ft/4zJ1Bxs
 EsprlnTgmhe0T34PqLthbHGOM6HYJ+xHJJKro279o3rzbwRRsPmjluSUcjwd1tunp2A+FatG0bv
 HcL5HRnnC7Q==
X-Gm-Gg: ASbGnct39wW6N19OI+q9YPjVd+N6qX5yvmUiTr6OO+9KmPdHY+16kF5I2UOoY7erwLK
 Gwqlc19E229s7uGXaMBOsx64ZYKECCAy0BJ8+9ZXeetJc6qJAAsDRb+NVxz48qU8DqUzGakKYd/
 5+l5Nr0nSSzNRFBdw0/1inxszbFSGpw+CL0diznMglihGWdeVBjP1cJ0q5lGRY+Kaeh+KezNsCG
 gqzgWLwEC4VpWsUDzaU8Wb81U7XlqK2r1MJgGXzYrWSsvBi9lUdjhTo2cdyIr+BVKZWkktZG+xW
 8EfxQvLYLC0QGXf6A7KqLa7ztIfueeytpsZywCzj768+8CUA7RDA5GNHG0OD48Ycit1kdA0a3UF
 biWhKs8+tOEFOeInYqrsup+DrRNhF53aRk2E6Tv5XiD4HqLGsz+PyY3H/Z/mzdrVcx9jFcUSYfP
 9M6G9BBiOozYSWyyO+2H3OrIBX
X-Google-Smtp-Source: AGHT+IHbkEwhcb0a+SxV83eovWwSRB/gCUymshoKelixtahLyqlfX5oepAUef/HPKZilMTN6Mdu8vA==
X-Received: by 2002:a05:6000:4382:b0:404:ac77:6598 with SMTP id
 ffacd0b85a97d-42666ac3fc9mr4728779f8f.11.1759997954689; 
 Thu, 09 Oct 2025 01:19:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c54sm33859572f8f.11.2025.10.09.01.19.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 01:19:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/10] target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
Date: Thu,  9 Oct 2025 10:18:54 +0200
Message-ID: <20251009081903.13426-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009081903.13426-1-philmd@linaro.org>
References: <20251009081903.13426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Extract the implicit MO_TE definition in order to replace
it in the next commit.

Mechanical change using:

  $ for n in UW UL UQ UO SW SL SQ; do \
      sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
           $(git grep -l MO_TE$n target/openrisc); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 5ab3bc7021d..df0ebcd3138 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -647,7 +647,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
-    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TE | MO_UL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
     tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     return true;
@@ -665,13 +665,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 
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
 
@@ -689,13 +689,13 @@ static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 
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
 
@@ -713,7 +713,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R(dc, a->b), dc->mem_idx, MO_TEUL);
+                              cpu_R(dc, a->b), dc->mem_idx, MO_TE | MO_UL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
 
     tcg_gen_br(lab_done);
@@ -735,7 +735,7 @@ static void do_store(DisasContext *dc, arg_store *a, MemOp mop)
 
 static bool trans_l_sw(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TEUL);
+    do_store(dc, a, MO_TE | MO_UL);
     return true;
 }
 
@@ -747,7 +747,7 @@ static bool trans_l_sb(DisasContext *dc, arg_store *a)
 
 static bool trans_l_sh(DisasContext *dc, arg_store *a)
 {
-    do_store(dc, a, MO_TEUW);
+    do_store(dc, a, MO_TE | MO_UW);
     return true;
 }
 
-- 
2.51.0


