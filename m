Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3A6EE57D3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 04:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaoA1-0001FI-GF; Tue, 30 Dec 2025 23:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vao9z-0001Eu-ID
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 23:50:11 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vao9x-0004J7-UA
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 23:50:11 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso12423702b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 20:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767156608; x=1767761408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyEBQI9fudLZA6hp/64GGbEj5D+LdOyrIGJqk0OSFBY=;
 b=HSakyuzxYpxkKIM7E1dGrUgA/sRS4snCdAIS60vNpVvv88QAHyDI8o7lgukYEJBN3O
 QI2DahyKCsEG32L5zeFCALz37cRwBNzNiGvKaawFBLX4WJH7xwulHzl9SpD9PKNX3sSM
 DuxymVpi3RdhRmRaRuVr9KUcXpiNvLkm71Qn4mKUOOCynTYLnlYimJjLb2yRwY1FAVCP
 8pjUhIRb0s88kiAPk4A14pRQCK5pqxZD6n4uVIJD2KZBf/V8RM7iNn1cB0NIHwXP6w8x
 Pz2GlArJQL8V+s2UigbUwR9QiefA1r71Eu19HtAe5k8Ni+84rABQXqnlz8n4mR9wFgl1
 LW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767156608; x=1767761408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lyEBQI9fudLZA6hp/64GGbEj5D+LdOyrIGJqk0OSFBY=;
 b=uM37jq0H9AH7LpAffKIOiYWfCeYZ/cJfaN2AMu/uBJ2oQ0ohCLwWKKP/3YKbRED58g
 iXeyM8lQSAYnmEUT4NXT3OMdMh8qgIKbAJ4i+UTHiDIvjXP/zcDxFDkkWXN1ch91sUFy
 nFmBwNSFCrsbLexhbdg+vTj3/QA4KW7CA90+Jl2WTKy4qQmWmI3Ix3tCAZ3xHtWpKqeQ
 dtmk786YaA+ZR0o7DvqNSYLHeLmCqno8uImhNyCPwtkjy2ynRserKEDZYKWocNmzBe/i
 TbTC4RbFgeSr7y8iLhu5d9N72Wzr2M8i1Qz3vJSjMCkl7OJQc9Yf+TEuHL2Fu9KDIQxV
 jX8A==
X-Gm-Message-State: AOJu0YzlNAe04nOkDpECfXeMo8oHYLVLJvS+rMphp/gjUtID0mPo8jyu
 xJS/AimZcIdrqQx2xKcAJzyaqj6nYF9zvhafSks9TNdbXnigxCALOrTVRlWEB1EG14teM/wUNUO
 rtOoT/unAUUQlgYsbgMIk4zBhJbx0D098YpQ3Xy4UzOhEpAuQMN+IBoaSHzda9mdOj8w/EN7fKd
 fQQiCMO5TyAh0vMh49Wy4Og+JvvnTKL8MRNjABs4XqKF8=
X-Gm-Gg: AY/fxX6J5W9LSOaJN1U4enz/+UP6fa2BiRePx2gUti0hT0mlUrtbd3ei/tZCLK9u1Uo
 3xtplqbniY9YNkJkwaQOHG6nMeNyx8NsvmO2yg0hdgWO7kMG6z9PSk7/C6zxnuyIJawFHkS36Ju
 AjrtTv5OQVTlVbfgyxBoFlXwxrLm9HTyZk/o4xnbMpj33iCT/fwCZ9H1iVBl3xSDe0/ntfFJfZ9
 BFeN45XeuDTaUbUtSX6PSUimuZigyhbNLv5dfVFTGhAQdpV24eMRSLei6nYhA8lZEOgWFE5zWDH
 8LovQsftyjxVoqisoLaRTsOFXMFwrrAh52UzOdMStPP0aCgYfM5NSMYkMG+L+X4w0ayxA/5ugkL
 6Maz8rzYL1IXPPTw2EoRoYRnH1n7f5nFCFpsB6fUBEImOWFjfF5eg/ATFAsA4gV6P3Sf+CYrYxB
 Hmo0DskYcmkkO3zuh9ME68bNJjKrdn6AGQy8x32TQ8I3kEkqNqRw==
X-Google-Smtp-Source: AGHT+IHTcQHWKFvGgGXfVRmkLKeTEUayZIJi1WNZL6u8uR5KNjh5guh3smPOl4UDGNwYhACjcJZGNg==
X-Received: by 2002:a05:6a00:4406:b0:7e8:4471:ae58 with SMTP id
 d2e1a72fcca58-7ff67456ce0mr27232366b3a.36.1767156607834; 
 Tue, 30 Dec 2025 20:50:07 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7a8442edsm33981945b3a.12.2025.12.30.20.50.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 20:50:07 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 1/2] target/riscv: Align pmp size to pmp-granularity
Date: Wed, 31 Dec 2025 12:49:59 +0800
Message-ID: <20251231045000.30120-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251231045000.30120-1-jay.chang@sifive.com>
References: <20251231045000.30120-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x42a.google.com
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

When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
value is smaller than the PMP granularity, it needs to be aligned
to the PMP granularity.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/pmp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3ef62d26ad..c88e86cb11 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -167,11 +167,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             uint8_t a_field = pmp_get_a_field(val);
             /*
              * When granularity g >= 1 (i.e., granularity > 4 bytes),
-             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
+             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
+             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
              */
             if ((riscv_cpu_cfg(env)->pmp_granularity >
                 MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
-                    return false;
+                    val |= PMP_AMATCH;
             }
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
@@ -251,6 +252,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_NAPOT:
+        /* Bits [g-2:0] need to be all one to align pmp granularity */
+        if (g >= 2) {
+            this_addr |= ((1ULL << (g - 1ULL)) - 1ULL);
+        }
+
         pmp_decode_napot(this_addr, &sa, &ea);
         break;
 
-- 
2.48.1


