Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C696DE7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn144-00045F-Jk; Mon, 02 Feb 2026 16:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn138-0001cy-0y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn136-0004S7-F5
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:33 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso45129205e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066089; x=1770670889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjJS4F+ZR9UGuvJkYdHrYT9RQW3X7FVg+IiasIqKI/c=;
 b=sZZ8IOwYVIYGl0sHb6hh2nJYx3Y1nJ8p1BqdvSLIpiWd3VqxFqMIdXhAEQEDQ3FLva
 MrwzVmveKlKI6o6719NmnbFmf//+Y7KRNNZkMRExkMTyX4qIpaWeBzGNgjeCCwMMD9ta
 HTILkPnsCBVLSNWByMSt8KVCTLnPGQd3j4tEPwFuWLIAPwFPx5mbv52bSR8S27PMdkBT
 c8Er010vIjKSV+zr9/7cLaz5wc9/Bne/79RSGFzzSp46XBf9f112+LlcP1yo90IqHSIX
 4hAuHrjv3C1BIwylXePIEqFrZmelf81hnDmSP7lbxlghKQIRA8lq5Wr9JWJjklwMEPmG
 MVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066089; x=1770670889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QjJS4F+ZR9UGuvJkYdHrYT9RQW3X7FVg+IiasIqKI/c=;
 b=JLNYzbLirjg12lj0q2KqLrEzS9gWwH3s1ny0xxh/VRiR5k6oNI/xfXBd7HGFeX3PpJ
 sl50misDV5FDRt5i+SKv3x3+ZIjS0WajntgPNq6QxxE+OUD7dprhvRLZLY8+k5WeiegX
 oJfg/uYy/oIHRw+l/Ze9hmW22kthSje32+gK0kaaP1T4b28+EbtUO+GpcfKeZR8dlnPU
 rhcrAvW4MnMXJ88QaixsV695yF+PQnRdRSQ/NsLQChEyKL+R8nJwTUU5tUFjdrFlpF+z
 3iMhmq0FZPiXJxZyi1QmgPlbSFAF/MDpD2fH7y6TxPSuuT54Bjuy6KIOlWRW40NPzgCp
 stzQ==
X-Gm-Message-State: AOJu0Yz3fp+E7ftEij2xf4UH3bhXm94e5BFLSu2MX8BuaFldPqfnM4aT
 XyiNTQdJLEsgteOeVva6LF4I4FoHBXwBKLPiCMDLPgNUwZlushs65M89mZb7BdHTmcykWWBiavJ
 slVbA1IQ=
X-Gm-Gg: AZuq6aJun3UXUR7XJE1m1pR541bmF51BOpJTJ3uus2NaaFMRaqhX/y2FYkg7cBid6+w
 wH5NvzsGKIpNtbrpN5yWRSvfjSMVrkg2Bi5XVSot5EqMib8+TKXLziIWWu10FD5GJAIbVvZU+JG
 HnBp2m5f4bYhbQo5YXujXw7NRoPmJxcAcCTJthBQXngIc0G/ne4U+oJPDEa9dIFcJfcfkk78Ths
 QA99TKkNyTPph+UuhMz/k65oIvzWAHZ2l/EZBpujUMhTjrsjGTXuhkZ6IgQJglPQNR4B5L5KUCF
 zAcCQc27Eif4YnUt/BKS5qelbnwJAAD3TRXLWmk8wCdnlrvkBxCDASZTpingKN6Dvi6aJepiriT
 wocvlenlCCNZpaQT62OTtbxJIPFXV0N9Le0nvxmzfV+EW/GPyMrxx5zPLWzN0F2v1nCZym2oQyL
 zLpsP3TJPsUsSe0QoSA8P0Rqz0ZFnwpRLxqmvbxAVAGzAJfO5ZZRVZI5ij+zODpqR5ipvpYlA=
X-Received: by 2002:a05:600c:1c26:b0:47e:c562:a41f with SMTP id
 5b1f17b1804b1-482db481c92mr175084185e9.18.1770066089552; 
 Mon, 02 Feb 2026 13:01:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482e047d863sm107044645e9.1.2026.02.02.13.01.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 03/11] target/ppc: Inline cpu_ld/st_data_ra() calls in
 do_hash()
Date: Mon,  2 Feb 2026 22:00:57 +0100
Message-ID: <20260202210106.93257-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

In preparation of removing the cpu_ld*_data_ra() and
cpu_st*_data_ra() calls, inline them. No logical change
intended.

We note the page translation hash address is expected to
be aligned, so the MO_UNALN flag is misleading. Next commit
will remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/tcg-excp_helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index edecfb85725..6f5d82af636 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -160,14 +160,18 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
                     target_ulong rb, uint64_t key, bool store)
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOpIdx oi = make_memop_idx(op, mmu_idx);
+    uintptr_t retaddr = GETPC();
 
     if (store) {
-        cpu_stq_data_ra(env, ea, calculated_hash, GETPC());
+        cpu_stq_mmu(env, ea, calculated_hash, oi, retaddr);
     } else {
-        loaded_hash = cpu_ldq_data_ra(env, ea, GETPC());
+        loaded_hash = cpu_ldq_mmu(env, ea, oi, retaddr);
         if (loaded_hash != calculated_hash) {
             raise_exception_err_ra(env, POWERPC_EXCP_PROGRAM,
-                POWERPC_EXCP_TRAP, GETPC());
+                                   POWERPC_EXCP_TRAP, retaddr);
         }
     }
 }
-- 
2.52.0


