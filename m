Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62E0F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAt9C-0008R9-PQ; Thu, 09 Apr 2026 13:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wArho-0000Ob-6v
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:54:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wArhm-0001Zh-R0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:54:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cf73bbfbdso660560f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775750045; x=1776354845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uNRjVzBrfQNBjxA8Suax0mc4RuGUSF8x1sHTO0A3nY=;
 b=KbvZJwFOURByk9ME58wsPt6iV36LaKvgpsKikptm+v69i1eREDyMHBnIesCW+VDf99
 qgFaSQyp33TIcxaVmWoClHII/LZ4V0ASP+Zh5hK2NDocMixgxEO+XsgivwH/MTyKHL1l
 cDOXZ1CWh8po6Ngl7kk3SZYMhQFq5LIfDalDRVEsI8nE1QdS7NCJsAM3bHAewL/PoMTO
 Ysr1aUmtFFVDdSKvJvx/6zmo3eJ410+kW+4tpsdbALGPCfu4cc4n/kbcAca121QNBNnn
 KlR38xtnGTVx10SFKRTKYIGEYEtre+SIuJ/hxbki38QHvyS6P838Lmcq/9Vhx+QMCMeL
 uMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750045; x=1776354845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4uNRjVzBrfQNBjxA8Suax0mc4RuGUSF8x1sHTO0A3nY=;
 b=NG+Papdo/YSaHtBPSMIdDAqaEA2Uhnxr9/ujmcQC0NMueZZWnkCLe8pBhVg8uvx7+S
 r3kFDKFHijzvsksAKuT8febU52kEPqA3G2rUne3bRO2iWf4kHBsXpB3vHqKno45Br+8s
 ACB/5SZBo9yP1gfLMctTztau6a42n6gJPeTkJBU8QnLk1uVyIc2erBxHY4m4Xt1o81v2
 yXxkUGfF08NKlYys2rKU0hTh9ATiPPT9UTczOVkCwC2qZmSoBCQ6x7dSFcMn15dqPd8C
 EiAueFb0VButvXDni5c50CvMsJjYgWQ/hOXIo9lqUexPVXTuWbXYzPQigK5aP3AjV1ZB
 xdKQ==
X-Gm-Message-State: AOJu0YwSDILslu/OOswogJ6QMNQWzKOio7cXjhAP4258BBTdBUH2vDKu
 AbM9LC/Ou6zBoGF4JYeQbBYyrY3HaT2y2OxWI6d4qTdSZY+z2WXmfzy5L986mUGu+yY9YQ==
X-Gm-Gg: AeBDievPgYqJljTia4Cl31L3pBqOF5j/A8AIK7b7eUP5UgSBjb0n9KHW3NXc76lq266
 wE+SYxmKz4y57PM/OXv5X1/wnaTh0SBVpQXfSORMDiiKyyaH9uOLCZF6Cz8Gce+HQViT0aWz4k0
 pmjbAcuXdnOZj8Cr1a6d3nFzGbGKo35gKCag2Z3IkTL2SOJ9jGxI1EUQ0wTOzmhW4ueneQYQaHi
 ykiOHO2g/BswNFr73ukcnvElpHOjaolj+irMJKvWlfSo43o17QlfKC1KvBTwETi9LKELWBtEQ9K
 bXar+aBllI9yd3R4utxKvSY5v1wuHRghFOqdq0oom9l1Kcf1pG48mDUg52BbXspFTD8RsjZo92x
 eAIn+NlMkr1RNsg8uHEKw2n6bm6sl/VwbsyN6dhMvBnfUVzUef+MCB5+XvnCUPWV96aBiHOpgV/
 M62FRpSytB9r1ufI8ExuAXR8f2s3P5fGrJ2SRoW4L54l4H5e2TKLazQTnm3Aa31y180cOP
X-Received: by 2002:a05:6000:228a:b0:43d:4e2e:368b with SMTP id
 ffacd0b85a97d-43d5a1a28e0mr5380211f8f.40.1775750044995; 
 Thu, 09 Apr 2026 08:54:04 -0700 (PDT)
Received: from ninolomata-AERO-15-KC.. (89-181-36-85.net.novis.pt.
 [89.181.36.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c5468sm67259292f8f.13.2026.04.09.08.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:54:04 -0700 (PDT)
From: Bruno Sa <bruno.vilaca.sa@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Bruno Sa <bruno.vilaca.sa@gmail.com>
Subject: [PATCH 1/2] target/riscv: preserve RV32 henvcfgh on henvcfg writes
Date: Thu,  9 Apr 2026 16:53:42 +0100
Message-ID: <20260409155344.2849233-2-bruno.vilaca.sa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
References: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=bruno.vilaca.sa@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 13:26:29 -0400
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

On RV32, STCE/ADUE/PBMTE/DTE are implemented in henvcfgh. A write to
henvcfg should therefore only update the low 32 bits of env->henvcfg.

The current write_henvcfg() path overwrites env->henvcfg with the
low-half value and clears any bits previously written via henvcfgh.

Preserve the upper 32 bits on RV32 henvcfg writes and keep the existing
RV64 behaviour unchanged.

Signed-off-by: Bruno Sa <bruno.vilaca.sa@gmail.com>
---
 target/riscv/csr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7948188356..d322bdbd47 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3326,7 +3326,15 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
-    env->henvcfg = val & mask;
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        /*
+         * RV32 stores STCE/ADUE/PBMTE/DTE in henvcfgh, so a low-half henvcfg
+         * write must not clobber the upper 32 bits.
+         */
+        env->henvcfg = (env->henvcfg & ~0xFFFFFFFFULL) | (val & mask);
+    } else {
+        env->henvcfg = val & mask;
+    }
     if ((env->henvcfg & HENVCFG_DTE) == 0) {
         env->vsstatus &= ~MSTATUS_SDT;
     }
-- 
2.43.0


