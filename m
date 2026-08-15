Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F625C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKm-0007OD-94; Sat, 15 Aug 2026 15:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKj-0007L0-NP
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKi-0008M6-96
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so20040305ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823178; x=1787427978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A0aLKOztLw78X0OgZcDJCRDvYWBytKazqo7YQ2T67oc=;
 b=QDtStq+FgM+3/MUf7syK6CrTyWckeeD/IZuLSXXzIsPBSihsZXODa7Vs1bDzB87WBV
 O/Nc75y+4BnRQzoP1HnXEfh4IOONPFwWMcvkTzgtDU3nrEPudPovK2Dq3E3a+dVeg9vf
 Tp9sXrwdV7il0gfZvinRXf++x+JvTMMX4rTZkulANBGgjgMj8g1DEhwr14CsvJ2/EwAh
 f6xDAlZlVNr023ix84hjG+NtTLFqCzKNlm0L/7jILPAN4lQTrZt9P8zC1jm/xsW/wP4b
 GFyB7y9i+j4zv02KlvNIJkX8b9dvbRgx+EFJpTXvqMtKFoIc4QMc6ElxCGl2S772fAah
 zJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823178; x=1787427978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A0aLKOztLw78X0OgZcDJCRDvYWBytKazqo7YQ2T67oc=;
 b=Hsx0Gk1/c+jS2Sxub8eb+1VhJnPbwr0aaqu8nJWwO/ZSqPaPFtCdIyH4Aryq+uYSZb
 JHABS0aPq4xlFvP1JZGmTtHsxT/NbDMZHNdzs1krjwuRLINbK32NTUfOR+nmfsMIYRS7
 nHebTw7oHmUe+PaukammCCCsrihTABFNhVrLfosDQqTVIfaTO0MouYFfMxdGhZn+lOId
 NNmNHu4cZ9wQkb9W12+W5+9PDBKXlxq/NTmF0v6bhauoRcbfWihzaLlEW24wH/cXJFK9
 6VT+UhTqRENpsmO0ZD6QshV5Jp1FMmYy4qT9KeuAEi/P1y+cgSNsbzINxJAus/0KDEd6
 HzLw==
X-Gm-Message-State: AOJu0YxNlCcHbEPu3BOtvKUSvnl2lqm7vaUBklH5jm6ta0DCCDaRJ8Vo
 wKVkSU+tILDGVXOQ543nL2PI50tGnaRcKDT3bvSzwbPjByW834WwmA63ouHhzBiThTktBp5M84A
 dunUX
X-Gm-Gg: AR+sD11z6d+wWVcfuVbs853NYX0gKG39iuOJKgvRw4RdPXw3GapWC9jw5lMMsz9qC79
 rYRqx0Wfl5f4R0MPjr4fLtFavRSWBiIDUMAR0yVW3clSC8S96Tn+o2l1NsxNrUCaA/H5QhY8mAM
 p5h0ccaZwTPnWFqJ6njuHkH5TUpCuRsJAjTY4H3uIJN5BZustRzgU0Hb1O7233p5LYvlcbpSWpb
 mTNBIN859wj3KN+uc369oTCzNubb6FcReh6wPFPA98NFfd2F7JpR/bDY1B5YW1MApvjWbbrPTYc
 eXrxqGfRycRaR/GPLNICb23S0BfywaEi1sMGoPpLJ4Yhm89lNuL8GxACjzosiPRgSgxP2CEgOjh
 kEblx82k4M64u+GK/1oZvZdLYfl9RjRXOpwrDEZpGSVZpOKTDF3pW3JbZZH6lc0ho0vOQ1RBVJi
 Lw/rO9vvfI3F6HF2r1B05laEeXtpJuhY2SvtL7diBXlcKeXHoagP45dYkBVDxIX5GW8JoTIHzwq
 UFYdQjocgl63ykrkkdl
X-Received: by 2002:a17:903:1b46:b0:2cf:7db9:e13e with SMTP id
 d9443c01a7336-2d3afdaf598mr128004755ad.3.1786823178266; 
 Sat, 15 Aug 2026 12:46:18 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 18/23] target/riscv: Build MemOpIdx to vext_ldff
Date: Sat, 15 Aug 2026 12:45:43 -0700
Message-ID: <20260815194549.1377505-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Use mmu data passed in with VDATA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/tcg/vector_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index 5ead4cd6fe..9c643f60ec 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -720,7 +720,8 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
     target_ulong addr, last, last_in_page, page_split, elems;
-    int mmu_index = riscv_env_mmu_index(env, false);
+    MemOpIdx oi = vext_oi(desc, log2_esz);
+    int mmu_index = get_mmuidx(oi);
     bool first_active;
     int flags;
     void *host;
-- 
2.43.0


