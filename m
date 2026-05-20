Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA704CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaXt-0007km-9a; Wed, 20 May 2026 02:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wPaXs-0007ju-39
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:36:44 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wPaXp-0006ZE-OW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:36:43 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so4647321a91.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779259000; x=1779863800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKdfc2h7NZHnOgY1DbVORnQopa5dghHu9Jngv8uC+5Y=;
 b=OPaHgAo05oog7K9yeDNZzQDHSyMURCsYJJKhSSyZLCcc7rf8rHgMf+WxEOGyEmTi0s
 HRkH11vl+wKvJa4KEbCDGdFWR7ceJaLJth4q07mYMI11tY9a7lxX2pX4izvSIOhEIk9g
 6ENF6Iw2g/ovtKiLAJeudfV1ADEr3yFEmxfFxkKbaFY9hfEf9uFJQ6qWzWx6LMPYfhu5
 0l0kqciVDVFd0XPIRTUMbjY9jfp/4JxBtt9W+QcK999SU1escN5hvv7EBnosxqo2cos4
 7xkwRWMQfFHvkTAoRCqNLnY2dwYTigQ9bp16PDexbcV9jATgkl3wzWyDEnuXkUbX0E32
 +F4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259000; x=1779863800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aKdfc2h7NZHnOgY1DbVORnQopa5dghHu9Jngv8uC+5Y=;
 b=P5v70eZxgTZP7rZa8Me3uJYuC30ZOTrdMaoce+DNz/8COsJ/WClXYwKpn9DT/cW49l
 h88AaQ7bQncqxLVR9AIwIcmiXGq3kcz9q8E7VwfmXJoqSTzSrS5E/npb//GiYDJsHSZI
 x1TKLcMQZ51RtDv6/ySCifWC0I4iqcLJdi4fKrOHIO1147MwnpH/vxosHKABvN9g31Ar
 WhcGxDH2PTMEPQ9a7X0RFsFagiEN7HfnLulB72PB07hdiCwaLDPqowcVoi4svSoZQl+e
 PnIuIDiaiVBpfWXZ8FDvxlR3Wk3TK9gpbtpPON3qmokcIyav/JPgNorJp+0B8/Vocq8r
 o/EQ==
X-Gm-Message-State: AOJu0Ywyku06S/GE8qx/OSbcEbGBMEwNOM9GxYjIsqQjeahRBXsy72Zt
 uQEFNSEdGxFpWraUUiLQOcOWfPzKkXorCzGWgvuteQp/nwUaT+mK6zsEn7Kk4Y1ENwPypyWi5ZY
 nM7Cznws+6enbwVIMPHGf9o1NNxwqAKIVi6x3DgCpKtRA3urRyyoT3H7BXpeMhUnnd/gte//5u2
 qITEaSrCaTcQcJ853EJ+Ukex1DyEkOsDOAXLZb1i7e9Pt7ng==
X-Gm-Gg: Acq92OE0DMn5c/70EGIOI6vFZMTZhES2ciMAXO8W+DgitNPjUrs7C2HNZyPf3n/FMvj
 5/5ZJ8yBMN3OUBgKe9BvrYoXXekURUDuYCUnl4sqkWyDrTPSEyoj+FH3FNLg0/BnQNH8abf5mo3
 hozWotqOn6UFmdFNQHOpc8PItLgTarHTpTBbizz7bhtXZXERM0+OFsGmcP+kswzG+I4+DFdF+Ld
 ExFx4KHx7upVLRCM0jhL58Yep/saEgCqx8tpxR2QsUuKm/gcGWmO5Pnv0U2UWMbKzVmXxo7ukRS
 tBtRZi7vpToV80Zsnt3XCyGOf9Nr7o9C+lBQc8Dj1GLwXysQInzk+XKnUw11tR0HNI7W+VaMkh0
 vPZcSDf9IhEnAszbhH7wSvEC388wys6t1MoWbzOGFXPe2mEGE5OopPnhdAf78YIVW5/5RTdCzfg
 lAyvTkliEItbYzCmX3z60j263YIVD33YU9nBlr+Nwj3vLHK7OqH1c3sI5Avs05/FHFB+WBX9+X
X-Received: by 2002:a17:90b:5385:b0:369:de03:29c8 with SMTP id
 98e67ed59e1d1-369de033084mr10009537a91.23.1779258999873; 
 Tue, 19 May 2026 23:36:39 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36959ca0fa5sm8364342a91.3.2026.05.19.23.36.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 23:36:39 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v5 1/2] target/riscv: Align pmp size to pmp-granularity
Date: Wed, 20 May 2026 14:36:05 +0800
Message-ID: <20260520063606.36600-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260520063606.36600-1-jay.chang@sifive.com>
References: <20260520063606.36600-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102a.google.com
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
index a71091a316..8adf7c9719 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -179,11 +179,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
             }
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
@@ -263,6 +264,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
         break;
 
     case PMP_AMATCH_NAPOT:
+        /* Bits [g-2:0] need to be all one to align pmp granularity */
+        if (g >= 2) {
+            this_addr = deposit64(this_addr, 0, g - 1, -1ULL);
+        }
+
         pmp_decode_napot(this_addr, &sa, &ea);
         break;
 
-- 
2.48.1


