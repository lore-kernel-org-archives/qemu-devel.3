Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AFFC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 01:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcZ4U-0000DI-9H; Sun, 04 Jan 2026 20:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4P-0000C8-RS
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:07:42 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1vcZ4O-00042n-Ef
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:07:41 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7533dbd87so10132663a34.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 17:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1767575259; x=1768180059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1B5t5DaUp4CnXBEDQrkMmBFKohaaqMbt7ayc/y3yKhI=;
 b=SyXGlOvAWwDxqWuyORdJR5uQboMz4h5rDeK/M/vqjhgu5qIVmFjaCmOfkHLGj5QhZI
 2qiPccDc/jZYU2k7wLt8/sXOJwR3horp7mT/kFQppeqKzjF7/JfM7jSagBgXc805qjR7
 902ImmGnT4H8WAXE7fnefI8tCDhOggpCRCkUWrS5DF8miV/GT8sSZ5T7vkXkKLr4tXjV
 LJyJkK5fmYXevyFEHoSCmV9oNGDh2qc/IzPN0Sf95AscQgXnaVJVn3gEnSn7AVEVmZMt
 clI7MpPGYL8ddosfTubN2l6ZHBQg3cdaacA+juqKpSv1XxUb19Qo8492S9uLCajXCP+p
 9juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767575259; x=1768180059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1B5t5DaUp4CnXBEDQrkMmBFKohaaqMbt7ayc/y3yKhI=;
 b=IeDwFOtClFs+hbMk/2IKuyoUTiFGPq1G31WU44f0TxMb3tVaLs3ajdJtW4b7G4q5K7
 W96SvgdMW7iSV5kPTmDtaat/lqhNoOZDar8njGolpm9TuoQjSru++vZsh1Xzo7huvXhW
 g3DbxBaqLa3xoVqHvaLrUkZ8gjKgc/3EK5Q9W5nV55L+HcB1ztzwlGkbSZiG9OtRBl6+
 SeIgeJ2HxGr8v+DgcX46XRbW7HQJvwFZxHsTEfEWkp0Se2hsWkHWNnIuXwBs9i6+h6Vd
 /jPE+o+hevDwpeMx3YHTwdthBg/8wkIXF7PdsKChchUfdHC8FNjXhzeR05fEfYeAfEr9
 rFIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHYhhLABizg+vEEYN2QMe58hwQKLo5LHxzxituV+ixZzJd7P562617xZlciBOjVel4rbX0kpYnNDJO@nongnu.org
X-Gm-Message-State: AOJu0YwmBLenn1tjwMdSn2s5Mlrt8hsSuSWAEDgXpp3EixcIAl+DS6AP
 C3nLMvNa+G8lUcw57IH1QPIim1z8AykYUuXNq/p+3Oonre8vLd82w55kpNBZ1DuW/xU=
X-Gm-Gg: AY/fxX5oPl4ES5rcIEpjvusuaf5wrX4oCVZ69MeRxubCl7ks7gQoxE0rWfT/n5Kp0/1
 pRJJrLnA8uhAWjLfTrwq/eLhmE/LcVN2F4BZMM0LMSIGSX0mRnoHWyF/ZLK+46oEssYkyTIbYpn
 zM/+4//hrFRcIs+dLkaZxOzhBX7plfLkkajfoxI8h8fi4fNxYUDIuUHTtKNvvfy5eyVhlDaw+hL
 GYbddzyjrGmS96iNWG07g8U94DqrKi6Adj4dRSZIMTI/hzvPJulagj4dmzkAFETRk42H7UxGhC5
 H6O1DN3n6sA9lpNi1roh2UgF75VTxSFvxXzSW579YK91AaiJ2PDCi95wos7G9W/swiYg8rg7MKp
 Jp5Rix61uZMCsws/DLiZs+ljILNccA3YKyS9nMgU9Pz6r1luaCvr/xXExmQmt3Ou/KWeCyOsvEF
 fPwVny3vOn3eqVSvsnBC02JsBdKCCb4XFY6crUlc3GyWzz
X-Google-Smtp-Source: AGHT+IHP6dAmK3Kp1UmFGkujeGGDFW0vB5G3g2v9vf83Bul+f6FI3t+Td4/6pPH5kOf+LXBo+eeixQ==
X-Received: by 2002:a05:6830:264a:b0:7c5:3045:6c79 with SMTP id
 46e09a7af769-7cc668bdd63mr26207319a34.1.1767575258809; 
 Sun, 04 Jan 2026 17:07:38 -0800 (PST)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cdf600885asm15962364a34.21.2026.01.04.17.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jan 2026 17:07:37 -0800 (PST)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 2/4] target/riscv: rvv: Add mask_reg_full_update to
 mask-logical instructions
Date: Mon,  5 Jan 2026 01:05:55 +0000
Message-Id: <20260105010557.318635-2-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105010557.318635-1-antonb@tenstorrent.com>
References: <20260105010557.318635-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x329.google.com
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

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/vector_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 9c627544e4..5bec75edf6 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4980,11 +4980,17 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t vl = env->vl;                                \
     uint32_t total_elems = riscv_cpu_cfg(env)->vlenb << 3;\
     uint32_t vta_all_1s = vext_vta_all_1s(desc);          \
+    uint32_t mask_reg_full_update =                       \
+                 vext_mask_reg_full_update(desc);         \
     uint32_t i;                                           \
     int a, b;                                             \
                                                           \
     VSTART_CHECK_EARLY_EXIT(env, vl);                     \
                                                           \
+    if (mask_reg_full_update) {                           \
+        vl = total_elems;                                 \
+    }                                                     \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         a = vext_elem_mask(vs1, i);                       \
         b = vext_elem_mask(vs2, i);                       \
-- 
2.34.1


