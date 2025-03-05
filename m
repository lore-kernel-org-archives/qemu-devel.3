Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56559C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyW-000643-Nt; Tue, 04 Mar 2025 20:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyF-0005Cr-7d
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:54 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyD-00008N-L4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223cc017ef5so40561775ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139688; x=1741744488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGFBC54uGrka6BKNJV2LE5BwEafI9r/taUzH7CwogWE=;
 b=A6A/eJreC686lP1fQazHE7yD3u4Pu2qG672cVFIeXV7rYMLM6y7cmtC4d4XXAtjy6Q
 Mbh4J3YK6oWAS8Qk8cW9n7ZyUJ5GkdsmAP9FXWSCsiVCR6K20aaEKGi1Oy6SBDXsvX5x
 cY4aCE6bVnXOu0UvBYaBZSqeTcV9HwIlpTmwvQoOpuMV0HK9+wvshN072HdiEYcaINox
 NrGIa+ISouGX0XNY9yZkffy1edV8QoyRepULGdemaUdHtdZzhHEh5PLoWChPpyz/87d+
 GssXAm4UpI1PdXCqKGNcMqGmGGu++D99xhES+eCubBzGYYQixFWEWffRDsv7ht6ypQhR
 15hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139688; x=1741744488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGFBC54uGrka6BKNJV2LE5BwEafI9r/taUzH7CwogWE=;
 b=kFyUVgjB4qkVqMP2FWo6hZ1OZcDKscr+2Bn28rDZSJfV6hbjsyzsZVRVTpYfK42eH5
 7xxfwAiETu3gKMkTPZqyE1hFd4pjZzYMDudf9bZTLZUSMaUCyONi6dwOIpp37d4N/G9a
 tHsl8Khj8NfgQxAt0dSjZjV2Z2+WZibbcBKb9O9ON80rAIrMZ8gTYjIpuhZ0opSY+tuI
 3SWwvP40Tq9T++kV0WVUPRwBAnN94oYEwb4YiUox/OJ25b74/UvoCfQAB/YZyLoWlbnX
 dNufkv5FhE7r2VcmcJdJTIERUgZ2PVLsYIhW+JFL+fZ8ytEB9tXZTioVRbDfnLk2rsuP
 sKng==
X-Gm-Message-State: AOJu0YxOZdFeV3DW2Xh8lkBmYSky0gl0+nm6SfVKb51XMG8emNvOs2Dh
 fjq86KFbLN4HOjU2IuI+bnR2atLFLZMvdtw0uZy4mmjzDKcBgHBJVOxeuofw8Tg=
X-Gm-Gg: ASbGncsJ4AxKa2I0kwRChxDZq7ehG/fQsAuWAjxdNPcTcy8sZLliPhr/dGIx4PN33Ow
 o03pyiOmOISRm5qAeNcFwVHLSX74WovOYWmIHqcBiu/7j/YMeSKUgO75o0ELHVp42jaspN5fsEE
 LYhkvxgQqNCOKNT+LWPCWhiOy1kvcouTsSX8HM8zCIXoDZpwvv/T62dFzsbuAxSa/5/FhjAbaRf
 G/T1PsBBPWBOHv/qFLTr3/lBJ75PE2n5UJdyz+jJzXz9MORAp1txKFLRCkBysf/LZX3GuGK080o
 cuCt17djarkrJ1ihDOKybbKBUG+XyzkLdPG05IMffRJDpMWfDKqTxTnFZB9JqOYxDoNZc1YuGvl
 qfINcfiC1nJ+wc5F1lPkDAaACyodVdjnDjAAKCCvWPsdY//A4V1s=
X-Google-Smtp-Source: AGHT+IHk3w5Iv/CU4r96wBkZ3HuEl6kJQJAws+ZMowqkRhZalmkkI07LoTVHEeW2mBLfRuy5mZ5uDg==
X-Received: by 2002:a17:902:f682:b0:223:37b8:c213 with SMTP id
 d9443c01a7336-223f1d359fdmr18115805ad.52.1741139688023; 
 Tue, 04 Mar 2025 17:54:48 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:47 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/59] target/riscv: Mask out upper sscofpmf bits during
 validation
Date: Wed,  5 Mar 2025 11:52:40 +1000
Message-ID: <20250305015307.1463560-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

From: Atish Patra <atishp@rivosinc.com>

As per the ISA definition, the upper 8 bits in hpmevent are defined
by Sscofpmf for privilege mode filtering and overflow bits while the
lower 56 bits are desginated for platform specific hpmevent values.
For the reset case, mhpmevent value should have zero in lower 56 bits.
Software may set the OF bit to indicate disable interrupt.

Ensure that correct value is checked after masking while clearing the
event encodings.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250206-pmu_minor_fixes-v2-2-1bb0f4aeb8b4@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index cf713663ee..0408f96e6a 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -390,7 +390,7 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
      * Expected mhpmevent value is zero for reset case. Remove the current
      * mapping.
      */
-    if (!value) {
+    if (!(value & MHPMEVENT_IDX_MASK)) {
         g_hash_table_foreach_remove(cpu->pmu_event_ctr_map,
                                     pmu_remove_event_map,
                                     GUINT_TO_POINTER(ctr_idx));
-- 
2.48.1


