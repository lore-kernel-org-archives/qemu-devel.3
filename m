Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B492D11197
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 20:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOM23-0002Ks-Sb; Wed, 26 Nov 2025 15:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM22-0002J7-8F
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOM1z-0002Bb-IC
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 15:22:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477632b0621so521745e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764188544; x=1764793344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsPausPqrloQrq508COV9bsRJTugcYSClY5k0EJlLQQ=;
 b=Khq+C0+cLiTHahGJ0aX4qdOz4XDaVBkOU6Q7WoecYa9/9GbZO1URqADxhL6hnku/zx
 4+8EuN6gqsNuHs8o6dj68W7Lc8oxICJy5FDVojIEx8eWvNFvJ5qbe4VGCcF/uiuqHuJj
 r3bI2DlnuZbQvlKYgYYt+Zf3XkYpR8dDDpRdv2HxiEMQn/XbMu9VE/0KOhESFkEz0mzr
 eMZfTV/we2azxdJHdqaXQn0rBqMM2Fs/vVXOejGKPz3ny1YCAbUIWHVsjHWdexXIjZvm
 d7Ju+lshaf5vn2J12VH6JcvipdMGrS24c6wURbUH5GjwRRP84g33lqGYnq7L70AZElzU
 tAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764188544; x=1764793344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hsPausPqrloQrq508COV9bsRJTugcYSClY5k0EJlLQQ=;
 b=DsPm3LhbmEHt5aRZ63EXLD2rzHiPOWOmYAovhUf0Eo4lReVlZqvHyCe1wCBJy03bpB
 2/SIIzD18wbC6MZl7PIIVwiHI7L4hOS+SjPrybfmLL8M6Pdr29WNntipGXAcVSyDWe1f
 CPkyKQWIi4ECKAaiviOZcxqOjkmpxkUNNsmyDSPUeuC/01dCXWEcorlrIfjV3eex0g0d
 y1UX2VxB54c05FRQ1PfiDGPdu9WApJOgsKbBgdZiCASt8caJof2+BNMEp4Zpgn2nHpR5
 eK+bv+vseiefh7SidGI9hsC/U3KLlFSFzz7ucgDmkZaD4CeKe03w3Y0bEBrPOebr8Eq9
 ziyA==
X-Gm-Message-State: AOJu0Yygrzz+GhoYJNCocvTF127bBCuu7gky3G7Y7uVxsn8TL14+7oXP
 hMPVZ938aN3zfH40nmCo1h87H8knXufdnrOgF78nlPU4Rt9Ju8fbFi1qDAJ4zYo5+1uO/668vAK
 ZntlIEri0dvhU
X-Gm-Gg: ASbGncvsNWUnnT98ShpuYAheBRxZBJ2BnvMjZn1XBDCg+4CjMR7NKvMypjdEL0rUW6A
 ylFsKB9jtgufFKUXW6KLYQE36mkDDH73SySYJRXywXAcjsVXU1WasLWMJAH4l+CkV2IIHYgXRIq
 swQYUn8v/pntPvnewSa4+s6y1zssUR/lbrz69n2b+V5k49RWYdJ9cwUDilmbHUa5j0jfA5tEdPD
 2VE6P1HQ93Nr3FKDAXA+I2U5MtAcaGx2HXHT/TBui4kD+lnxF3lVzKQH/AShr53W8lDOofOitHx
 BjVJKyIiNeDSZTXxo/WG8GTdq2eVzr5aKqQKiJsWss9uHGFPb/7cECnqU84P50XqvbAc7BnsRGS
 frBpGoHDVBUg+5k/e6xo4wLV63uHR2GfCJ62V89/cQZausMfhR8EnUZXjC54A3S5A4eC1XM82PX
 d+n12Owi7sf2CIXMc3a2Q/z/d6xWsepParfikySUEp8nAsO0hU+KSQeZM2ZOWY
X-Google-Smtp-Source: AGHT+IEEcq6KnjXQD50q2Oay0zYykpyi+HvAy//RCkYtkxmEperdPSJ6HBsmoQ/ZA7TfXyDkIjPKRA==
X-Received: by 2002:a05:600c:4ec7:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-477c1138445mr205257405e9.35.1764188544031; 
 Wed, 26 Nov 2025 12:22:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790add2648sm65344925e9.4.2025.11.26.12.22.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 26 Nov 2025 12:22:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH-for-11.0 v3 03/22] target/riscv: Use little-endian variant of
 cpu_ld/st_data*() for vector
Date: Wed, 26 Nov 2025 21:21:39 +0100
Message-ID: <20251126202200.23100-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126202200.23100-1-philmd@linaro.org>
References: <20251126202200.23100-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

RISC-V vector "elements are simply packed in order from
the least-signicant to most-signicant bits of the vector
register" [*] which is little endianness, therefore the
cpu_ld/st_data*() definitions expand to the little endian
declarations. Use the explicit little-endian variants.

[*] RISC-V "V" Vector Extension v1.0

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/vector_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2de3358ee86..caa8dd9c125 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -193,9 +193,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_LD_ELEM(lde_b, uint8_t,  H1, ldub)
-GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw)
-GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl)
-GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(lde_h, uint16_t, H2, lduw_le)
+GEN_VEXT_LD_ELEM(lde_w, uint32_t, H4, ldl_le)
+GEN_VEXT_LD_ELEM(lde_d, uint64_t, H8, ldq_le)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)             \
 static inline QEMU_ALWAYS_INLINE                            \
@@ -214,9 +214,9 @@ void NAME##_host(void *vd, uint32_t idx, void *host)        \
 }
 
 GEN_VEXT_ST_ELEM(ste_b, uint8_t,  H1, stb)
-GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw)
-GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
-GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
+GEN_VEXT_ST_ELEM(ste_h, uint16_t, H2, stw_le)
+GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl_le)
+GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq_le)
 
 static inline QEMU_ALWAYS_INLINE void
 vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
-- 
2.51.0


