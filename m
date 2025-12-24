Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FC4E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWo-0002Rs-Vd; Wed, 24 Dec 2025 11:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWY-0002Ne-8x
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:43 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWU-0001Y0-Kf
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:41 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4334949f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592937; x=1767197737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq12UYI6z2j/QZYJlD5UndJRZx0WIakI1WkzO0Y3r8E=;
 b=qaM/pYAF2ecsfcNTHbkaapYxksi5nJaHf8U2pKIDOkDP505Qn13ZDPGwRlpe7DOPGx
 vYsmNWnR5Fwi7WJnLTwI+cd/8BrJ1n+c43d22+V6fmcfsgK+yUV3B0oZ3f2tQfDa2b8E
 7DDOH4hpN7Goi9+m9VQ4Y4JU1YkKkRqOAWnKMJwvVgz/yU24VqkIA8O3X5p+z3C3H/6Y
 eYqJR1gYz5riFfkbKOaM/slLJUuR/F0zabDQtLrzl0Y3I2NVxilk4tFpLLa0kh9TuBoT
 2kXYEM8NmAL8+l+ek0L5F2Mu+S+RmKaRNTNWWhSwkweaEw/jpIbRn5HNhslCVyAgbA9k
 QrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592937; x=1767197737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gq12UYI6z2j/QZYJlD5UndJRZx0WIakI1WkzO0Y3r8E=;
 b=FozEZesizjQLAFMDAkVKJopGUU5YCDOi6wZKwjBNCVaQSfZjXy8iSKlNSCsXM1gm2s
 HEo0viS3K7RD/604maey4vWpwJPfMssJNh5y7wnjgBL+3cCCmXRB0IiEjPBUhstKwTOX
 qJuj8nv1u5muEFNOUtezK2LQM5NQ9PVav7biwEu7ZpoUBjNaEHALIT5hYnIaYanpZn/c
 mVeDN1AwpY/F/TUiwABiP65kXjxJbqf0Lxsfo9Q9CyTXKeO+DWiL+QkR/8nTEuti9jeK
 hspC7lKMCHB21w89CCzfUBh8aH2Y5IIWUSemHgjqfbDsh8IAzdfQvrJoOkP+Om0hTgQ7
 ckhQ==
X-Gm-Message-State: AOJu0YzdzGK+rWtmYbJ0iDWSUZp+6bBCdAoGDPV9/XClr0/K86aMNmy5
 /hUphsQHW/YTxoPe+tdDGdo9VvoMc2aOFWezBb3mtozYA1wvvXVI/X4lLB44Z927Y2XBOhxnOLE
 7Os4lp2k=
X-Gm-Gg: AY/fxX4roXhXA2nMcFBRjS8T9vVGKSlPfsl7MZ5vE203fKdM0Qrt/CJn0Q4pb1rpdqS
 NfbY3M2R8LpmfHbMf+7T1c3VcwOcqOFJKNJ0ro1FOgmnMDcQUutZHzn2JoZOnNQNxfR1B5Pq1wZ
 4QgVVJ1hR84alnFKSpmL9fDOQvacil3SeFnUR4MKjHqInoot8FZDvT1TA92mbKTAW+G4ePXWSm7
 DCn4BpQqISyQjFhlz1vw2Tdp2NzIP1JR8ukft+bVAqgp5E5a7qkuDTTSi5yowYQyqSZD2I0UxzM
 N8BTtSycZzj7yKLxKeX/8q0gWx8xk5TUvd8InmwAA0sq8BwFrWuUnvy4NjRXsqC5mretq7Wmefs
 f47yAJ+WLzKsD78TzT8jCjoaop3hdnfxKePHG7YKyvLP6vQxGiTTCybOmfn52/KgjLt+PIKQe5w
 G35mCMw93mCCmxcalUwI3jmFYiErGcGEy6UL0NrbQ5hIDIAIGhGsGAC5U=
X-Google-Smtp-Source: AGHT+IHchR3B3f7+cmMMyp7CZrhFTiqMB24ZA3UipJ72/skYkXU7I/yKklrYuHahvY6OMDxGd29M4Q==
X-Received: by 2002:a5d:5847:0:b0:431:266:d14d with SMTP id
 ffacd0b85a97d-4324e5103c0mr24153717f8f.47.1766592936666; 
 Wed, 24 Dec 2025 08:15:36 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1afbfsm35407968f8f.9.2025.12.24.08.15.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/8] target/loongarch: Replace MO_TE -> MO_LE
Date: Wed, 24 Dec 2025 17:14:52 +0100
Message-ID: <20251224161456.89707-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

We only build the LoongArch target using little endianness
order, therefore the MO_TE definitions expand to the little
endian one. Use the latter which is more explicit.

Mechanical change running:

  $ sed -i -e s/MO_TE/MO_LE/ \
        $(git grep -wl MO_TE target/loongarch/)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .../tcg/insn_trans/trans_atomic.c.inc         | 80 +++++++++----------
 .../tcg/insn_trans/trans_fmemory.c.inc        | 32 ++++----
 .../tcg/insn_trans/trans_memory.c.inc         | 64 +++++++--------
 .../loongarch/tcg/insn_trans/trans_vec.c.inc  | 16 ++--
 4 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
index 77eeedbc42b..a1de389e51b 100644
--- a/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_atomic.c.inc
@@ -69,43 +69,43 @@ static bool gen_am(DisasContext *ctx, arg_rrr *a,
     return true;
 }
 
-TRANS(ll_w, ALL, gen_ll, MO_TESL)
-TRANS(sc_w, ALL, gen_sc, MO_TESL)
-TRANS(ll_d, 64, gen_ll, MO_TEUQ)
-TRANS(sc_d, 64, gen_sc, MO_TEUQ)
-TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
-TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TESL)
-TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_TEUQ)
-TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TESL)
-TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_TEUQ)
-TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TESL)
-TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_TEUQ)
-TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TESL)
-TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_TEUQ)
-TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TESL)
-TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_TEUQ)
-TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TESL)
-TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_TEUQ)
-TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TESL)
-TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_TEUQ)
-TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TESL)
-TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_TEUQ)
-TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TESL)
-TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_TEUQ)
+TRANS(ll_w, ALL, gen_ll, MO_LESL)
+TRANS(sc_w, ALL, gen_sc, MO_LESL)
+TRANS(ll_d, 64, gen_ll, MO_LEUQ)
+TRANS(sc_d, 64, gen_sc, MO_LEUQ)
+TRANS(amswap_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LESL)
+TRANS64(amswap_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LEUQ)
+TRANS(amadd_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESL)
+TRANS64(amadd_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LEUQ)
+TRANS(amand_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LESL)
+TRANS64(amand_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LEUQ)
+TRANS(amor_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LESL)
+TRANS64(amor_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LEUQ)
+TRANS(amxor_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LESL)
+TRANS64(amxor_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LEUQ)
+TRANS(ammax_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LESL)
+TRANS64(ammax_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LEUQ)
+TRANS(ammin_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LESL)
+TRANS64(ammin_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LEUQ)
+TRANS(ammax_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LESL)
+TRANS64(ammax_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LEUQ)
+TRANS(ammin_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LESL)
+TRANS64(ammin_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LEUQ)
+TRANS(amswap_db_w, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LESL)
+TRANS64(amswap_db_d, LAM, gen_am, tcg_gen_atomic_xchg_tl, MO_LEUQ)
+TRANS(amadd_db_w, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LESL)
+TRANS64(amadd_db_d, LAM, gen_am, tcg_gen_atomic_fetch_add_tl, MO_LEUQ)
+TRANS(amand_db_w, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LESL)
+TRANS64(amand_db_d, LAM, gen_am, tcg_gen_atomic_fetch_and_tl, MO_LEUQ)
+TRANS(amor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LESL)
+TRANS64(amor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_or_tl, MO_LEUQ)
+TRANS(amxor_db_w, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LESL)
+TRANS64(amxor_db_d, LAM, gen_am, tcg_gen_atomic_fetch_xor_tl, MO_LEUQ)
+TRANS(ammax_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LESL)
+TRANS64(ammax_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smax_tl, MO_LEUQ)
+TRANS(ammin_db_w, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LESL)
+TRANS64(ammin_db_d, LAM, gen_am, tcg_gen_atomic_fetch_smin_tl, MO_LEUQ)
+TRANS(ammax_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LESL)
+TRANS64(ammax_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umax_tl, MO_LEUQ)
+TRANS(ammin_db_wu, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LESL)
+TRANS64(ammin_db_du, LAM, gen_am, tcg_gen_atomic_fetch_umin_tl, MO_LEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
index 79da4718a56..b863ba1dc21 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -140,19 +140,19 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     return true;
 }
 
-TRANS(fld_s, FP_SP, gen_fload_i, MO_TEUL)
-TRANS(fst_s, FP_SP, gen_fstore_i, MO_TEUL)
-TRANS(fld_d, FP_DP, gen_fload_i, MO_TEUQ)
-TRANS(fst_d, FP_DP, gen_fstore_i, MO_TEUQ)
-TRANS(fldx_s, FP_SP, gen_floadx, MO_TEUL)
-TRANS(fldx_d, FP_DP, gen_floadx, MO_TEUQ)
-TRANS(fstx_s, FP_SP, gen_fstorex, MO_TEUL)
-TRANS(fstx_d, FP_DP, gen_fstorex, MO_TEUQ)
-TRANS64(fldgt_s, FP_SP, gen_fload_gt, MO_TEUL)
-TRANS64(fldgt_d, FP_DP, gen_fload_gt, MO_TEUQ)
-TRANS64(fldle_s, FP_SP, gen_fload_le, MO_TEUL)
-TRANS64(fldle_d, FP_DP, gen_fload_le, MO_TEUQ)
-TRANS64(fstgt_s, FP_SP, gen_fstore_gt, MO_TEUL)
-TRANS64(fstgt_d, FP_DP, gen_fstore_gt, MO_TEUQ)
-TRANS64(fstle_s, FP_SP, gen_fstore_le, MO_TEUL)
-TRANS64(fstle_d, FP_DP, gen_fstore_le, MO_TEUQ)
+TRANS(fld_s, FP_SP, gen_fload_i, MO_LEUL)
+TRANS(fst_s, FP_SP, gen_fstore_i, MO_LEUL)
+TRANS(fld_d, FP_DP, gen_fload_i, MO_LEUQ)
+TRANS(fst_d, FP_DP, gen_fstore_i, MO_LEUQ)
+TRANS(fldx_s, FP_SP, gen_floadx, MO_LEUL)
+TRANS(fldx_d, FP_DP, gen_floadx, MO_LEUQ)
+TRANS(fstx_s, FP_SP, gen_fstorex, MO_LEUL)
+TRANS(fstx_d, FP_DP, gen_fstorex, MO_LEUQ)
+TRANS64(fldgt_s, FP_SP, gen_fload_gt, MO_LEUL)
+TRANS64(fldgt_d, FP_DP, gen_fload_gt, MO_LEUQ)
+TRANS64(fldle_s, FP_SP, gen_fload_le, MO_LEUL)
+TRANS64(fldle_d, FP_DP, gen_fload_le, MO_LEUQ)
+TRANS64(fstgt_s, FP_SP, gen_fstore_gt, MO_LEUL)
+TRANS64(fstgt_d, FP_DP, gen_fstore_gt, MO_LEUQ)
+TRANS64(fstle_s, FP_SP, gen_fstore_le, MO_LEUL)
+TRANS64(fstle_d, FP_DP, gen_fstore_le, MO_LEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
index 42f4e740126..90bb0815ff3 100644
--- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
@@ -151,44 +151,44 @@ static bool gen_stptr(DisasContext *ctx, arg_rr_i *a, MemOp mop)
 }
 
 TRANS(ld_b, ALL, gen_load, MO_SB)
-TRANS(ld_h, ALL, gen_load, MO_TESW)
-TRANS(ld_w, ALL, gen_load, MO_TESL)
-TRANS(ld_d, 64, gen_load, MO_TEUQ)
+TRANS(ld_h, ALL, gen_load, MO_LESW)
+TRANS(ld_w, ALL, gen_load, MO_LESL)
+TRANS(ld_d, 64, gen_load, MO_LEUQ)
 TRANS(st_b, ALL, gen_store, MO_UB)
-TRANS(st_h, ALL, gen_store, MO_TEUW)
-TRANS(st_w, ALL, gen_store, MO_TEUL)
-TRANS(st_d, 64, gen_store, MO_TEUQ)
+TRANS(st_h, ALL, gen_store, MO_LEUW)
+TRANS(st_w, ALL, gen_store, MO_LEUL)
+TRANS(st_d, 64, gen_store, MO_LEUQ)
 TRANS(ld_bu, ALL, gen_load, MO_UB)
-TRANS(ld_hu, ALL, gen_load, MO_TEUW)
-TRANS(ld_wu, 64, gen_load, MO_TEUL)
+TRANS(ld_hu, ALL, gen_load, MO_LEUW)
+TRANS(ld_wu, 64, gen_load, MO_LEUL)
 TRANS(ldx_b, 64, gen_loadx, MO_SB)
-TRANS(ldx_h, 64, gen_loadx, MO_TESW)
-TRANS(ldx_w, 64, gen_loadx, MO_TESL)
-TRANS(ldx_d, 64, gen_loadx, MO_TEUQ)
+TRANS(ldx_h, 64, gen_loadx, MO_LESW)
+TRANS(ldx_w, 64, gen_loadx, MO_LESL)
+TRANS(ldx_d, 64, gen_loadx, MO_LEUQ)
 TRANS(stx_b, 64, gen_storex, MO_UB)
-TRANS(stx_h, 64, gen_storex, MO_TEUW)
-TRANS(stx_w, 64, gen_storex, MO_TEUL)
-TRANS(stx_d, 64, gen_storex, MO_TEUQ)
+TRANS(stx_h, 64, gen_storex, MO_LEUW)
+TRANS(stx_w, 64, gen_storex, MO_LEUL)
+TRANS(stx_d, 64, gen_storex, MO_LEUQ)
 TRANS(ldx_bu, 64, gen_loadx, MO_UB)
-TRANS(ldx_hu, 64, gen_loadx, MO_TEUW)
-TRANS(ldx_wu, 64, gen_loadx, MO_TEUL)
-TRANS(ldptr_w, 64, gen_ldptr, MO_TESL)
-TRANS(stptr_w, 64, gen_stptr, MO_TEUL)
-TRANS(ldptr_d, 64, gen_ldptr, MO_TEUQ)
-TRANS(stptr_d, 64, gen_stptr, MO_TEUQ)
+TRANS(ldx_hu, 64, gen_loadx, MO_LEUW)
+TRANS(ldx_wu, 64, gen_loadx, MO_LEUL)
+TRANS(ldptr_w, 64, gen_ldptr, MO_LESL)
+TRANS(stptr_w, 64, gen_stptr, MO_LEUL)
+TRANS(ldptr_d, 64, gen_ldptr, MO_LEUQ)
+TRANS(stptr_d, 64, gen_stptr, MO_LEUQ)
 TRANS(ldgt_b, 64, gen_load_gt, MO_SB)
-TRANS(ldgt_h, 64, gen_load_gt, MO_TESW)
-TRANS(ldgt_w, 64, gen_load_gt, MO_TESL)
-TRANS(ldgt_d, 64, gen_load_gt, MO_TEUQ)
+TRANS(ldgt_h, 64, gen_load_gt, MO_LESW)
+TRANS(ldgt_w, 64, gen_load_gt, MO_LESL)
+TRANS(ldgt_d, 64, gen_load_gt, MO_LEUQ)
 TRANS(ldle_b, 64, gen_load_le, MO_SB)
-TRANS(ldle_h, 64, gen_load_le, MO_TESW)
-TRANS(ldle_w, 64, gen_load_le, MO_TESL)
-TRANS(ldle_d, 64, gen_load_le, MO_TEUQ)
+TRANS(ldle_h, 64, gen_load_le, MO_LESW)
+TRANS(ldle_w, 64, gen_load_le, MO_LESL)
+TRANS(ldle_d, 64, gen_load_le, MO_LEUQ)
 TRANS(stgt_b, 64, gen_store_gt, MO_UB)
-TRANS(stgt_h, 64, gen_store_gt, MO_TEUW)
-TRANS(stgt_w, 64, gen_store_gt, MO_TEUL)
-TRANS(stgt_d, 64, gen_store_gt, MO_TEUQ)
+TRANS(stgt_h, 64, gen_store_gt, MO_LEUW)
+TRANS(stgt_w, 64, gen_store_gt, MO_LEUL)
+TRANS(stgt_d, 64, gen_store_gt, MO_LEUQ)
 TRANS(stle_b, 64, gen_store_le, MO_UB)
-TRANS(stle_h, 64, gen_store_le, MO_TEUW)
-TRANS(stle_w, 64, gen_store_le, MO_TEUL)
-TRANS(stle_d, 64, gen_store_le, MO_TEUQ)
+TRANS(stle_h, 64, gen_store_le, MO_LEUW)
+TRANS(stle_w, 64, gen_store_le, MO_LEUL)
+TRANS(stle_d, 64, gen_store_le, MO_LEUQ)
diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 38bccf28386..ea7e705bab4 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -5279,7 +5279,7 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 
     addr = make_address_i(ctx, addr, a->imm);
 
-    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
     set_vreg64(rl, a->vd, 0);
@@ -5311,7 +5311,7 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
-    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
 
     return true;
 }
@@ -5337,7 +5337,7 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     rh = tcg_temp_new_i64();
 
     addr = make_address_x(ctx, src1, src2);
-    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
     set_vreg64(rl, a->vd, 0);
@@ -5369,7 +5369,7 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
-    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
+    tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_LE);
 
     return true;
 }
@@ -5478,12 +5478,12 @@ static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
     TCGv temp = tcg_temp_new();
     TCGv dest = tcg_temp_new();
 
-    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_ld_i64(dest, addr, ctx->mem_idx, MO_LEUQ);
     set_vreg64(dest, vreg, 0);
 
     for (i = 1; i < 4; i++) {
         tcg_gen_addi_tl(temp, addr, 8 * i);
-        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_ld_i64(dest, temp, ctx->mem_idx, MO_LEUQ);
         set_vreg64(dest, vreg, i);
     }
 }
@@ -5495,12 +5495,12 @@ static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)
     TCGv dest = tcg_temp_new();
 
     get_vreg64(dest, vreg, 0);
-    tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+    tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_LEUQ);
 
     for (i = 1; i < 4; i++) {
         tcg_gen_addi_tl(temp, addr, 8 * i);
         get_vreg64(dest, vreg, i);
-        tcg_gen_qemu_st_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
+        tcg_gen_qemu_st_i64(dest, temp, ctx->mem_idx, MO_LEUQ);
     }
 }
 
-- 
2.52.0


