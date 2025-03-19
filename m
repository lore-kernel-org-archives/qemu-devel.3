Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6EEC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuyzh-0007Oq-Nd; Wed, 19 Mar 2025 15:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyzd-0007Ni-4O
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:21 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tuyza-0002Cn-TM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:22:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2239c066347so162645915ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1742412137; x=1743016937; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jtptQpawWvWvvPo7p+5ePzZbn/0qrX0uFQnRGLb5OR8=;
 b=Zkug5YZc8bbt/ncdJ3W9/o8AB+S4cv2n1xns/oUBXE1edBRpPJ6Dklkz9uSfutk8sr
 8QTAuU0kalBumShWsOgkAdohP4hN/PUER0kvkst0cSfnYWIE23gP+PdXoFmzCRw7OTnf
 OiV/U9yEshrdzY10UJlIUlgORKeecX6ZRL4CVFRiyxbyosZ6tT0efIeE1yA4hkI7NwHJ
 96yvzDnsygQuP57ymyJF+oQNvSxlpYrgxtX+fYx6ntbU8glRFjSpAwm0h4QA+WXliQki
 WFY3df0spa7RDHKkltYXF2kVn0wNwxfwC06hJeL0OeuVNEcxfyF3CvEPASlXaE15VmWZ
 st0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412137; x=1743016937;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtptQpawWvWvvPo7p+5ePzZbn/0qrX0uFQnRGLb5OR8=;
 b=FiVaCFGJogygfC2nNtyld/pf+dVPGMx16mI2xT6LTJrfvHuoApVpKPD+6gt3CztVx6
 JguH1P5sCMMSgh8SXE/rFO4OnYfj9kGtY3XU5Oyu2QEOyJuZH5O7UlPCv7gtN/BHxxhp
 r+hLZQwjyRm2J3kRwcxjDWHJ3bLK47M8HyMf9ttzs/476mjuph155afs5eJtems0RArg
 fKZ3Lj6pJbxs9+Z2m3B6/DqlJfmxFvwLtTBUrtfdAADnq1GRvA3HP59P9NUmzlcVS31f
 90p37++ddqcjZt/uDPPO+W9ulcRXlyRilmgwqMivewG0DrmlzkNjGdQ/WlJkrikDkMNk
 HI7g==
X-Gm-Message-State: AOJu0YywCIl3hlEBJ1VajPe++8R3ZlpyIB8HXvqkZ6UH+SPOZqAVVdiI
 x6aCZVcBDVx/bP7GpaKzTsMUJ2oRQxhJ2nPhGaf0E6pofG63H4j3IaCbbVz7GxOw78Ctd58KK8v
 +5+8u0DVUSc14dZLgvKj0AJp4hG4PxMHtm9mxuph+VROkaAMoGLMWVTN2U8x/Cn7arOVG27l4zu
 kxmrplbU/ks9tbf1hCrLaBV/sEOxkZtDaxVg==
X-Gm-Gg: ASbGncu4GllaamtmCJvwWwZ0V3CqGuX4k3rq4Nk3DvTRmWxOaekOR9xzqAE961X/Ed+
 InqEDXwZmf/Ky+7aWOiuHJHnjfNsTlX0vzFPWtluo1hAQ6tfVe+6/J2unI/AaPiLMBqczhfC4wz
 +YUb9SAKpgC7zX1tXZS3lw33v3WVD4TQ13uo+Kg6ASz+hG+bsD67nhCjlTdDs8GgJv3c2DK9jKB
 r7iUT3igkqvC9ZKNGZ51Ettg9He+IurWg/c0x7399jrA55AnotUg0j3707WEoMTl+bfaMTvZlVD
 frgov0WzTCSKW97twbNiuhQttWBpK511gPK/7sl3h99UAg3Vm9iskegnIE3B8HF0mZ8=
X-Google-Smtp-Source: AGHT+IGb80ZN540wcGAg63HcRJ/3dRkHokXskLkNnkc7mEboWtJIlDoyAxzX5p7HEECTnvoHIXOkCA==
X-Received: by 2002:a05:6a21:3989:b0:1f5:619a:8f73 with SMTP id
 adf61e73a8af0-1fbecd41923mr6058469637.26.1742412136668; 
 Wed, 19 Mar 2025 12:22:16 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea947a4sm11432175a12.70.2025.03.19.12.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:22:16 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 3/4] target/riscv: Fix VSTIP bit in sstc extension.
Date: Thu, 20 Mar 2025 03:21:52 +0800
Message-Id: <20250319192153.28549-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319192153.28549-1-jim.shu@sifive.com>
References: <20250319192153.28549-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x631.google.com
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

VSTIP is only writable when both [mh]envcfg.STCE is enabled, or it will
revert it's defined behavior as if sstc extension is not implemented.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/csr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 49566d3c08..ba026dfc8e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3630,7 +3630,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_sstc && (env->priv == PRV_M) &&
         get_field(env->menvcfg, MENVCFG_STCE)) {
         /* sstc extension forbids STIP & VSTIP to be writeable in mip */
-        mask = mask & ~(MIP_STIP | MIP_VSTIP);
+
+        /* STIP is not writable when menvcfg.STCE is enabled. */
+        mask = mask & ~MIP_STIP;
+
+        /* VSTIP is not writable when both [mh]envcfg.STCE are enabled. */
+        if (get_field(env->henvcfg, HENVCFG_STCE)) {
+            mask = mask & ~MIP_VSTIP;
+        }
     }
 
     if (mask) {
-- 
2.17.1


