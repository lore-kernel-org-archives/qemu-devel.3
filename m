Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517F1CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4mZ-00083q-7x; Mon, 15 Sep 2025 04:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4mG-0007sC-ND
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lw-0002Qt-Nn
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-25d44908648so34162935ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925674; x=1758530474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BVrxaNeAS1M9ADfzi+MmUWFVyXqRi+QXF60svhLpeY=;
 b=enOZGui6/oY0VIEDBNt3hgNGSvzN8qRAsCqvkYpZ6Wmz1Se8Je0Z92C8asR2k+36z8
 LFo8KGnE/Y26X10vL1irynzB6ulwgcezHmBs/ZxvUviF2KiTjVxaduw07i9/Fuzp8Zmw
 tZMsNNvK0E6PXEmz/ZvuIfUBU/kdbg2AqjbJha15gVd/GewqJdwkS8E9zMGvTGQPZ237
 UoBAiRQVkeevMwIjjUYi+DhhtKVba1oNVXLQNh3i4YysuCcZo5pNxNetuEmoAooOAH05
 BY8Breh8+0gts8I0N0RCbQCZhj0dac/RldRpHhrGvv4hApev2ygFku0+91BALA/bhV8y
 rK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925674; x=1758530474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6BVrxaNeAS1M9ADfzi+MmUWFVyXqRi+QXF60svhLpeY=;
 b=sLSsgt99QsWPV7kMvLLjAGs3OuhH+KsNxye4F54dz9XIlx8nGw7ucwWFIbcRw4gEzi
 ViuEUJo2m6nmcQp2jvvktOEhNeWMKfB9Jt4cFKgcqJPv4dl/Aeu06mkvDq9cILUBvnID
 ueQHLB36Iy/A03WK0Vnh2xoG0rFQw4WP0vQxN24EnNlOXgFk3UD011VLoRaS84otwFQ9
 ae4bO/Y5fBpX0OUsSDFtClszbOZwu+DjZw/NJ48lgv+zj0OckD8zE1TpmJD7lPGwUGGJ
 Pbuv7ZLoYbLglsBziDzDiYT5IK3nmJhkBzb8wRjajJBKHQLFm4Zz2pdZbLDMXvC+WwP8
 vlPg==
X-Gm-Message-State: AOJu0YyYenZj8jNrUCbejqI3BN74Sk2GkFLFApYIypNWwHH6kZyM8irI
 uE5PTr8eBS35JDgAlBr0KD45PApZ9R1PfxID/hyy4VFDKRvzkM4tJdfl7KcGcNs/FsyXkf5o5H8
 hgxRbK3P2asKyi7LhhXaF2CgtTTXDN5CnZZw4xBR+niFrKywb9i0hMtNKrfYecQnqFx1XlS+xUV
 IvrvZCCvRebn41DHv1vkgrHMBO+yHj5OVEoQZD6uq7og==
X-Gm-Gg: ASbGncvCiZiffuhUdDjEBrAsCtV8zufluz+BOhty3hVavnjyBSSU4alkvjrJWl/8ToS
 5dXoX0hPb2lbNl0ZQqFYPv9HQ/In+gOXNqjgwy/RFhzKNHyUq4t8j8SDhcO4WC5oAbRw9ZdWbJ0
 jL/x9aUtLZ5elDroQfhiPkcJVEitcO4FUMJJgKqbc75GTAG5q4kMDyqizLMTcCOn434XVf1KOVS
 Y1NieSiIWBMlmgAFJf0GPemlrvEPF5rprLOkUMLwC8EtpWqNWF5JWJMcbwfrpCwRTlTf5/fy8au
 eBlxZQEHbpqXmycIOJ6zBKD1GJZ9gVeT4i05NoKPF+QI6OkOfWSoXy2RgyRjG+87AlWMmRreLXM
 VFGklLvDWyzE9PwYzX5z+gAjtP/qDz4jArKp4m2iWf0a3QNssLRSteZF0+JpE5zvU3EO70a1mM3
 RxIA==
X-Google-Smtp-Source: AGHT+IHKGRr8+5y5XdCxHlvbV32qvJahRE7W9qbHh5gGZgarbOYF2/HyeROStHjOmVBzVdXU6SKuWw==
X-Received: by 2002:a17:903:b0b:b0:25c:d4b6:f119 with SMTP id
 d9443c01a7336-25d245db32emr151874435ad.12.1757925672551; 
 Mon, 15 Sep 2025 01:41:12 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:41:12 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 7/8] target/riscv: rvv: Support Zvfbfa vector bf16
 operations
Date: Mon, 15 Sep 2025 16:40:35 +0800
Message-ID: <20250915084037.1816893-8-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

According to the Zvfbfa ISA spec v0.1, the following vector floating
point instructions have different bahaviors depend on the ALTFMT and
VSEW fields of VTYPE CSR.

When altfmt=1 and SEW=8, all vector floating-point instructions become
reserved, except for the following, which are redefined to use the
BF16 format for any operand that would otherwise have used the FP16
format:
- vfwcvt.f.x[u].v, vfncvt.x[u].f.w, vfncvt.rtz.x[u].f.w

When altfmt=1 and SEW=16, all vector floating-point instructions become
reserved, except for the following, which are redefined to use the
BF16 format for any operand that would otherwise have used the FP16
format:
- vfadd.v[vf], vfsub.v[vf], vfmin.v[vf], vfmax.v[vf], vmfeq.v[vf],
  vmfle.v[vf], vmflt.v[vf], vmfne.v[vf], vmfgt.vf, vmfge.vf,
  vfmul.v[vf], vfrsub.vf, vfmadd.v[vf], vfnmadd.v[vf], vfmsub.v[vf],
  vfnmsub.v[vf], vfmacc.v[vf], vfnmacc.v[vf], vfmsac.v[vf],
  vfnmsac.v[vf], vfwadd.v[vf], vfwsub.v[vf], vfwadd.w[vf],
  vfwsub.w[vf], vfwmul.v[vf], vfwmacc.v[vf], vfwnmacc.v[vf],
  vfwmsac.v[vf], vfwnmsac.v[vf], vfwcvt.f.f.v, vfncvt.f.f.w,
  vfncvt.rod.f.f.w, vfrsqrt7.v, vfrec7.v, vfclass.v

The following instructions marked with * have the same semantics
regardless of altfmt.
*- vfmv.f.s,
   vfwmaccbf16.v[vf] (only if Zvfbfwma is implemented)
   vfwcvtbf16.f.f.v (only if Zvfbfmin is implemented)
   vfncvtbf16.f.f.w (only if Zvfbfmin is implemented)

The following instructions marked with ** differ only in that
improperly NaN-boxed f-register operands must substitute the BF16
canonical NaN instead of the FP16 canonical NaN.
**- vfsgnj.v[vf], vfsgnjn.v[vf], vfsgnjx.v[vf], vfslide1up.vf,
    vfslide1down.vf, vfmv.v.f, vfmerge.vfm, vfmv.s.f

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/helper.h                      |  60 ++
 target/riscv/insn_trans/trans_rvbf16.c.inc |   2 +-
 target/riscv/insn_trans/trans_rvv.c.inc    | 976 +++++++++++++--------
 target/riscv/internals.h                   |   1 +
 target/riscv/vector_helper.c               | 329 +++++++
 5 files changed, 989 insertions(+), 379 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f712b1c368e..ed5478cc62f 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -766,45 +766,60 @@ DEF_HELPER_6(vnclip_wx_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnclip_wx_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vnclip_wx_w, void, ptr, ptr, tl, ptr, env, i32)
 
+DEF_HELPER_6(vfadd_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfsub_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfadd_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfsub_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfrsub_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 
+DEF_HELPER_6(vfwadd_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwadd_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwadd_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwsub_wv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwsub_wv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwadd_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwadd_wf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwadd_wf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwadd_wf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwsub_wf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwsub_wf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwsub_wf_w, void, ptr, ptr, i64, ptr, env, i32)
 
+DEF_HELPER_6(vfmul_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmul_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfdiv_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfdiv_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfdiv_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmul_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmul_vf_d, void, ptr, ptr, i64, ptr, env, i32)
@@ -815,74 +830,98 @@ DEF_HELPER_6(vfrdiv_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfrdiv_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 
+DEF_HELPER_6(vfwmul_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmul_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmul_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 
+DEF_HELPER_6(vfmacc_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmacc_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmsac_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmadd_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmadd_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmadd_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmacc_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmacc_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmacc_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsac_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsac_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsac_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmadd_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmadd_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmadd_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmadd_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmadd_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmsub_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfnmsub_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfnmsub_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 
 DEF_HELPER_6(vfwmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwnmacc_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwnmacc_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwnmacc_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwmsac_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfwnmsac_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfwmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwnmacc_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmacc_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmacc_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwmsac_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfwnmsac_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfwnmsac_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 
@@ -890,23 +929,29 @@ DEF_HELPER_5(vfsqrt_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfsqrt_v_d, void, ptr, ptr, ptr, env, i32)
 
+DEF_HELPER_5(vfrsqrt7_v_h_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfrsqrt7_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfrsqrt7_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfrsqrt7_v_d, void, ptr, ptr, ptr, env, i32)
 
+DEF_HELPER_5(vfrec7_v_h_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfrec7_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfrec7_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfrec7_v_d, void, ptr, ptr, ptr, env, i32)
 
+DEF_HELPER_6(vfmin_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmin_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmin_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmin_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmax_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmax_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmax_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vfmax_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vfmin_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmin_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmin_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmin_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vfmax_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfmax_vf_d, void, ptr, ptr, i64, ptr, env, i32)
@@ -930,37 +975,48 @@ DEF_HELPER_6(vfsgnjx_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vfsgnjx_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 
+DEF_HELPER_6(vmfeq_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfeq_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfeq_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfeq_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfne_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfne_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfne_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfne_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmflt_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmflt_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmflt_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmflt_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfle_vv_h_bf16, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfle_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfle_vv_w, void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_6(vmfle_vv_d, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_6(vmfeq_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfeq_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfeq_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfeq_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfne_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfne_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfne_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfne_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmflt_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmflt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmflt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmflt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfle_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfle_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfle_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfle_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfgt_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfgt_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfgt_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfgt_vf_d, void, ptr, ptr, i64, ptr, env, i32)
+DEF_HELPER_6(vmfge_vf_h_bf16, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfge_vf_h, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfge_vf_w, void, ptr, ptr, i64, ptr, env, i32)
 DEF_HELPER_6(vmfge_vf_d, void, ptr, ptr, i64, ptr, env, i32)
 
+DEF_HELPER_5(vfclass_v_h_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfclass_v_d, void, ptr, ptr, ptr, env, i32)
@@ -987,18 +1043,22 @@ DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_xu_v_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_xu_v_b_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfwcvt_f_x_v_b_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_5(vfncvt_xu_f_w_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_xu_f_w_b_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_xu_f_w_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_xu_f_w_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_x_f_w_b, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_5(vfncvt_x_f_w_b_bf16, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_x_f_w_h, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_x_f_w_w, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(vfncvt_f_xu_w_h, void, ptr, ptr, ptr, env, i32)
diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 066dc364c5b..6cfda03d2ec 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -161,7 +161,7 @@ static bool trans_vfwmaccbf16_vf(DisasContext *ctx, arg_vfwmaccbf16_vf *a)
         data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
         data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
         return opfvf_trans(a->rd, a->rs1, a->rs2, data,
-                           gen_helper_vfwmaccbf16_vf, ctx);
+                           gen_helper_vfwmaccbf16_vf, ctx, false);
     }
 
     return false;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 62cc03784cb..d2f9db67fbe 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2345,10 +2345,11 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  * NaN-boxed value, in which case the least-significant SEW bits
  * of the f register are used, else the canonical NaN value is used.
  */
-static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
+static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in,
+                      bool do_bf16_nanbox)
 {
     if (s->sew == MO_16) {
-        if (s->altfmt) {
+        if (s->altfmt && do_bf16_nanbox) {
             gen_check_nanbox_h_bf16(out, in);
         } else {
             gen_check_nanbox_h(out, in);
@@ -2362,25 +2363,39 @@ static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
     }
 }
 
+/*
+ * Check altfmt & sew combinations when Zvfbfa extension is enabled.
+ */
+static bool vext_check_altfmt(DisasContext *s, int8_t valid_vsew)
+{
+    if (s->cfg_ptr->ext_zvfbfa) {
+        if (s->altfmt && (valid_vsew == -1 || s->sew != valid_vsew)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 /* Vector Single-Width Floating-Point Add/Subtract Instructions */
 
 /*
  * If the current SEW does not correspond to a supported IEEE floating-point
  * type, an illegal instruction exception is raised.
  */
-static bool opfvv_check(DisasContext *s, arg_rmrr *a)
+static bool opfvv_check(DisasContext *s, arg_rmrr *a, int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm);
+           vext_check_sss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 /* OPFVV without GVEC IR */
 #define GEN_OPFVV_TRANS(NAME, CHECK)                               \
 static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
 {                                                                  \
-    if (CHECK(s, a)) {                                             \
+    if (CHECK(s, a, -1)) {                                         \
         uint32_t data = 0;                                         \
         static gen_helper_gvec_4_ptr * const fns[3] = {            \
             gen_helper_##NAME##_h,                                 \
@@ -2406,14 +2421,48 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
     }                                                              \
     return false;                                                  \
 }
-GEN_OPFVV_TRANS(vfadd_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfsub_vv, opfvv_check)
+
+#define GEN_OPFVV_BFA_TRANS(NAME, CHECK, BFA_HELPER)                    \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (CHECK(s, a, MO_16)) {                                           \
+        uint32_t data = 0;                                              \
+        static gen_helper_gvec_4_ptr * const fns[3] = {                 \
+            gen_helper_##NAME##_h,                                      \
+            gen_helper_##NAME##_w,                                      \
+            gen_helper_##NAME##_d                                       \
+        };                                                              \
+        gen_set_rm(s, RISCV_FRM_DYN);                                   \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),          \
+                           vreg_ofs(s, a->rs1),                         \
+                           vreg_ofs(s, a->rs2), tcg_env,                \
+                           s->cfg_ptr->vlenb,                           \
+                           s->cfg_ptr->vlenb, data,                     \
+                           (s->altfmt ? gen_helper_##BFA_HELPER :       \
+                                        fns[s->sew - 1]));              \
+        tcg_gen_movi_tl(cpu_vstart, 0);                                 \
+        finalize_rvv_inst(s);                                           \
+                                                                        \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_OPFVV_BFA_TRANS(vfadd_vv, opfvv_check, vfadd_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfsub_vv, opfvv_check, vfsub_vv_h_bf16)
 
 typedef void gen_helper_opfvf(TCGv_ptr, TCGv_ptr, TCGv_i64, TCGv_ptr,
                               TCGv_env, TCGv_i32);
 
 static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
-                        uint32_t data, gen_helper_opfvf *fn, DisasContext *s)
+                        uint32_t data, gen_helper_opfvf *fn, DisasContext *s,
+                        bool do_bf16_nanbox)
 {
     TCGv_ptr dest, src2, mask;
     TCGv_i32 desc;
@@ -2431,7 +2480,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     /* NaN-box f[rs1] */
     t1 = tcg_temp_new_i64();
-    do_nanbox(s, t1, cpu_fpr[rs1]);
+    do_nanbox(s, t1, cpu_fpr[rs1], do_bf16_nanbox);
 
     fn(dest, mask, t1, src2, tcg_env, desc);
 
@@ -2443,244 +2492,316 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
  * If the current SEW does not correspond to a supported IEEE floating-point
  * type, an illegal instruction exception is raised
  */
-static bool opfvf_check(DisasContext *s, arg_rmrr *a)
+static bool opfvf_check(DisasContext *s, arg_rmrr *a, int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_ss(s, a->rd, a->rs2, a->vm);
+           vext_check_ss(s, a->rd, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 /* OPFVF without GVEC IR */
-#define GEN_OPFVF_TRANS(NAME, CHECK)                              \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)            \
-{                                                                 \
-    if (CHECK(s, a)) {                                            \
-        uint32_t data = 0;                                        \
-        static gen_helper_opfvf *const fns[3] = {                 \
-            gen_helper_##NAME##_h,                                \
-            gen_helper_##NAME##_w,                                \
-            gen_helper_##NAME##_d,                                \
-        };                                                        \
-        gen_set_rm(s, RISCV_FRM_DYN);                             \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);            \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);              \
-        data = FIELD_DP32(data, VDATA, VTA_ALL_1S,                \
-                          s->cfg_vta_all_1s);                     \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);              \
-        return opfvf_trans(a->rd, a->rs1, a->rs2, data,           \
-                           fns[s->sew - 1], s);                   \
-    }                                                             \
-    return false;                                                 \
-}
-
-GEN_OPFVF_TRANS(vfadd_vf,  opfvf_check)
-GEN_OPFVF_TRANS(vfsub_vf,  opfvf_check)
-GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
+#define GEN_OPFVF_TRANS(NAME, CHECK)                    \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)  \
+{                                                       \
+    if (CHECK(s, a, -1)) {                              \
+        uint32_t data = 0;                              \
+        static gen_helper_opfvf *const fns[3] = {       \
+            gen_helper_##NAME##_h,                      \
+            gen_helper_##NAME##_w,                      \
+            gen_helper_##NAME##_d,                      \
+        };                                              \
+        gen_set_rm(s, RISCV_FRM_DYN);                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);    \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S,      \
+                          s->cfg_vta_all_1s);           \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);    \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data, \
+                           fns[s->sew - 1], s, false);  \
+    }                                                   \
+    return false;                                       \
+}
+
+#define GEN_OPFVF_BFA_TRANS(NAME, CHECK, BFA_HELPER, BF16_NANBOX)   \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)              \
+{                                                                   \
+    if (CHECK(s, a, MO_16)) {                                       \
+        uint32_t data = 0;                                          \
+        static gen_helper_opfvf *const fns[3] = {                   \
+            gen_helper_##NAME##_h,                                  \
+            gen_helper_##NAME##_w,                                  \
+            gen_helper_##NAME##_d,                                  \
+        };                                                          \
+        gen_set_rm(s, RISCV_FRM_DYN);                               \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                  \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);              \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                \
+        data = FIELD_DP32(data, VDATA, VTA_ALL_1S,                  \
+                          s->cfg_vta_all_1s);                       \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,             \
+                           (s->altfmt ? gen_helper_##BFA_HELPER :   \
+                                        fns[s->sew - 1]),           \
+                           s, BF16_NANBOX);                         \
+    }                                                               \
+    return false;                                                   \
+}
+
+GEN_OPFVF_BFA_TRANS(vfadd_vf,  opfvf_check, vfadd_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfsub_vf,  opfvf_check, vfsub_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfrsub_vf,  opfvf_check, vfrsub_vf_h_bf16, false)
 
 /* Vector Widening Floating-Point Add/Subtract Instructions */
-static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
+static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a,
+                              int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
+           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-static bool opfvv_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+static bool opfvv_overwrite_widen_check(DisasContext *s, arg_rmrr *a,
+                                        int8_t valid_bfa_vsew)
 {
-    return require_rvv(s) &&
-           require_rvf(s) &&
-           require_scale_rvf(s) &&
-           vext_check_isa_ill(s) &&
-           vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm) &&
+    return opfvv_widen_check(s, a, valid_bfa_vsew) &&
            vext_check_input_eew(s, a->rd, s->sew + 1, a->rs1, s->sew, a->vm) &&
            vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
 }
 
 /* OPFVV with WIDEN */
-#define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                       \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
-{                                                                \
-    if (CHECK(s, a)) {                                           \
-        uint32_t data = 0;                                       \
-        static gen_helper_gvec_4_ptr * const fns[2] = {          \
-            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
-        };                                                       \
-        gen_set_rm(s, RISCV_FRM_DYN);                            \
-                                                                 \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
-        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),   \
-                           vreg_ofs(s, a->rs1),                  \
-                           vreg_ofs(s, a->rs2), tcg_env,         \
-                           s->cfg_ptr->vlenb,                    \
-                           s->cfg_ptr->vlenb, data,              \
-                           fns[s->sew - 1]);                     \
-        finalize_rvv_inst(s);                                    \
-        return true;                                             \
-    }                                                            \
-    return false;                                                \
-}
-
-GEN_OPFVV_WIDEN_TRANS(vfwadd_vv, opfvv_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
-
-static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
+#define GEN_OPFVV_WIDEN_TRANS(NAME, CHECK)                      \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)          \
+{                                                               \
+    if (CHECK(s, a, -1)) {                                      \
+        uint32_t data = 0;                                      \
+        static gen_helper_gvec_4_ptr * const fns[2] = {         \
+            gen_helper_##NAME##_h, gen_helper_##NAME##_w,       \
+        };                                                      \
+        gen_set_rm(s, RISCV_FRM_DYN);                           \
+                                                                \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);          \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);            \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);            \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),  \
+                           vreg_ofs(s, a->rs1),                 \
+                           vreg_ofs(s, a->rs2), tcg_env,        \
+                           s->cfg_ptr->vlenb,                   \
+                           s->cfg_ptr->vlenb, data,             \
+                           fns[s->sew - 1]);                    \
+        finalize_rvv_inst(s);                                   \
+        return true;                                            \
+    }                                                           \
+    return false;                                               \
+}
+
+#define GEN_OPFVV_WIDEN_BFA_TRANS(NAME, CHECK, BFA_HELPER)          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)              \
+{                                                                   \
+    if (CHECK(s, a, MO_16)) {                                       \
+        uint32_t data = 0;                                          \
+        static gen_helper_gvec_4_ptr * const fns[2] = {             \
+            gen_helper_##NAME##_h,                                  \
+            gen_helper_##NAME##_w                                   \
+        };                                                          \
+        gen_set_rm(s, RISCV_FRM_DYN);                               \
+                                                                    \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                  \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);              \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),      \
+                           vreg_ofs(s, a->rs1),                     \
+                           vreg_ofs(s, a->rs2), tcg_env,            \
+                           s->cfg_ptr->vlenb,                       \
+                           s->cfg_ptr->vlenb, data,                 \
+                           (s->altfmt ? gen_helper_##BFA_HELPER :   \
+                                        fns[s->sew - 1]));          \
+        finalize_rvv_inst(s);                                       \
+        return true;                                                \
+    }                                                               \
+    return false;                                                   \
+}
+
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwadd_vv, opfvv_widen_check, vfwadd_vv_h_bf16)
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwsub_vv, opfvv_widen_check, vfwsub_vv_h_bf16)
+
+static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a,
+                              int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_ds(s, a->rd, a->rs2, a->vm);
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-static bool opfvf_overwrite_widen_check(DisasContext *s, arg_rmrr *a)
+static bool opfvf_overwrite_widen_check(DisasContext *s, arg_rmrr *a,
+                                        int8_t valid_bfa_vsew)
 {
-    return require_rvv(s) &&
-           require_rvf(s) &&
-           require_scale_rvf(s) &&
-           vext_check_isa_ill(s) &&
-           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+    return opfvf_widen_check(s, a, valid_bfa_vsew) &&
            vext_check_input_eew(s, a->rd, s->sew + 1, a->rs2, s->sew, a->vm);
 }
 
 /* OPFVF with WIDEN */
-#define GEN_OPFVF_WIDEN_TRANS(NAME, CHECK)                       \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
-{                                                                \
-    if (CHECK(s, a)) {                                           \
-        uint32_t data = 0;                                       \
-        static gen_helper_opfvf *const fns[2] = {                \
-            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
-        };                                                       \
-        gen_set_rm(s, RISCV_FRM_DYN);                            \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
-        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
-                           fns[s->sew - 1], s);                  \
-    }                                                            \
-    return false;                                                \
-}
-
-GEN_OPFVF_WIDEN_TRANS(vfwadd_vf, opfvf_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwsub_vf, opfvf_widen_check)
-
-static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
+#define GEN_OPFVF_WIDEN_BFA_TRANS(NAME, CHECK, BFA_HELPER)          \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)              \
+{                                                                   \
+    if (CHECK(s, a, MO_16)) {                                       \
+        uint32_t data = 0;                                          \
+        static gen_helper_opfvf *const fns[2] = {                   \
+            gen_helper_##NAME##_h,                                  \
+            gen_helper_##NAME##_w,                                  \
+        };                                                          \
+        gen_set_rm(s, RISCV_FRM_DYN);                               \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                  \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);              \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,             \
+                           (s->altfmt ? gen_helper_##BFA_HELPER :   \
+                                        fns[s->sew - 1]),           \
+                           s, false);                               \
+    }                                                               \
+    return false;                                                   \
+}
+
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwadd_vf, opfvf_widen_check, vfwadd_vf_h_bf16)
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwsub_vf, opfvf_widen_check, vfwsub_vf_h_bf16)
+
+static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a,
+                              int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm);
+           vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 /* WIDEN OPFVV with WIDEN */
-#define GEN_OPFWV_WIDEN_TRANS(NAME)                                \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
-{                                                                  \
-    if (opfwv_widen_check(s, a)) {                                 \
-        uint32_t data = 0;                                         \
-        static gen_helper_gvec_4_ptr * const fns[2] = {            \
-            gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
-        };                                                         \
-        gen_set_rm(s, RISCV_FRM_DYN);                              \
-                                                                   \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
-                           vreg_ofs(s, a->rs1),                    \
-                           vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlenb,                      \
-                           s->cfg_ptr->vlenb, data,                \
-                           fns[s->sew - 1]);                       \
-        finalize_rvv_inst(s);                                      \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+#define GEN_OPFWV_WIDEN_BFA_TRANS(NAME)                                 \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (opfwv_widen_check(s, a, MO_16)) {                               \
+        uint32_t data = 0;                                              \
+        static gen_helper_gvec_4_ptr * const fns[2] = {                 \
+            gen_helper_##NAME##_h,                                      \
+            gen_helper_##NAME##_w                                       \
+        };                                                              \
+        gen_set_rm(s, RISCV_FRM_DYN);                                   \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),          \
+                           vreg_ofs(s, a->rs1),                         \
+                           vreg_ofs(s, a->rs2), tcg_env,                \
+                           s->cfg_ptr->vlenb,                           \
+                           s->cfg_ptr->vlenb, data,                     \
+                           (s->altfmt ? gen_helper_##NAME##_h_bf16 :    \
+                                        fns[s->sew - 1]));              \
+        finalize_rvv_inst(s);                                           \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
 }
 
-GEN_OPFWV_WIDEN_TRANS(vfwadd_wv)
-GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
+GEN_OPFWV_WIDEN_BFA_TRANS(vfwadd_wv)
+GEN_OPFWV_WIDEN_BFA_TRANS(vfwsub_wv)
 
-static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
+static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a,
+                              int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_dd(s, a->rd, a->rs2, a->vm);
+           vext_check_dd(s, a->rd, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 /* WIDEN OPFVF with WIDEN */
-#define GEN_OPFWF_WIDEN_TRANS(NAME)                              \
-static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
-{                                                                \
-    if (opfwf_widen_check(s, a)) {                               \
-        uint32_t data = 0;                                       \
-        static gen_helper_opfvf *const fns[2] = {                \
-            gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
-        };                                                       \
-        gen_set_rm(s, RISCV_FRM_DYN);                            \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);               \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);             \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);             \
-        return opfvf_trans(a->rd, a->rs1, a->rs2, data,          \
-                           fns[s->sew - 1], s);                  \
-    }                                                            \
-    return false;                                                \
-}
-
-GEN_OPFWF_WIDEN_TRANS(vfwadd_wf)
-GEN_OPFWF_WIDEN_TRANS(vfwsub_wf)
+#define GEN_OPFWF_WIDEN_BFA_TRANS(NAME)                                 \
+static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
+{                                                                       \
+    if (opfwf_widen_check(s, a, MO_16)) {                               \
+        uint32_t data = 0;                                              \
+        static gen_helper_opfvf *const fns[2] = {                       \
+            gen_helper_##NAME##_h,                                      \
+            gen_helper_##NAME##_w                                       \
+        };                                                              \
+        gen_set_rm(s, RISCV_FRM_DYN);                                   \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        return opfvf_trans(a->rd, a->rs1, a->rs2, data,                 \
+                           (s->altfmt ? gen_helper_##NAME##_h_bf16 :    \
+                                        fns[s->sew - 1]),               \
+                           s, false);                                   \
+    }                                                                   \
+    return false;                                                       \
+}
+
+GEN_OPFWF_WIDEN_BFA_TRANS(vfwadd_wf)
+GEN_OPFWF_WIDEN_BFA_TRANS(vfwsub_wf)
 
 /* Vector Single-Width Floating-Point Multiply/Divide Instructions */
-GEN_OPFVV_TRANS(vfmul_vv, opfvv_check)
+GEN_OPFVV_BFA_TRANS(vfmul_vv, opfvv_check, vfmul_vv_h_bf16)
 GEN_OPFVV_TRANS(vfdiv_vv, opfvv_check)
-GEN_OPFVF_TRANS(vfmul_vf,  opfvf_check)
+GEN_OPFVF_BFA_TRANS(vfmul_vf,  opfvf_check, vfmul_vf_h_bf16, false)
 GEN_OPFVF_TRANS(vfdiv_vf,  opfvf_check)
 GEN_OPFVF_TRANS(vfrdiv_vf,  opfvf_check)
 
 /* Vector Widening Floating-Point Multiply */
-GEN_OPFVV_WIDEN_TRANS(vfwmul_vv, opfvv_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmul_vf, opfvf_widen_check)
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwmul_vv, opfvv_widen_check, vfwmul_vv_h_bf16)
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwmul_vf, opfvf_widen_check, vfwmul_vf_h_bf16)
 
 /* Vector Single-Width Floating-Point Fused Multiply-Add Instructions */
-GEN_OPFVV_TRANS(vfmacc_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfnmacc_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfmsac_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfnmsac_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfmadd_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfnmadd_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfmsub_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfnmsub_vv, opfvv_check)
-GEN_OPFVF_TRANS(vfmacc_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfnmacc_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfmsac_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfnmsac_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfmadd_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfnmadd_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfmsub_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfnmsub_vf, opfvf_check)
+GEN_OPFVV_BFA_TRANS(vfmacc_vv, opfvv_check, vfmacc_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfnmacc_vv, opfvv_check, vfnmacc_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfmsac_vv, opfvv_check, vfmsac_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfnmsac_vv, opfvv_check, vfnmsac_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfmadd_vv, opfvv_check, vfmadd_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfnmadd_vv, opfvv_check, vfnmadd_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfmsub_vv, opfvv_check, vfmsub_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfnmsub_vv, opfvv_check, vfnmsub_vv_h_bf16)
+GEN_OPFVF_BFA_TRANS(vfmacc_vf, opfvf_check, vfmacc_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfnmacc_vf, opfvf_check, vfnmacc_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfmsac_vf, opfvf_check, vfmsac_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfnmsac_vf, opfvf_check, vfnmsac_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfmadd_vf, opfvf_check, vfmadd_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfnmadd_vf, opfvf_check, vfnmadd_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfmsub_vf, opfvf_check, vfmsub_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfnmsub_vf, opfvf_check, vfnmsub_vf_h_bf16, false)
 
 /* Vector Widening Floating-Point Fused Multiply-Add Instructions */
-GEN_OPFVV_WIDEN_TRANS(vfwmacc_vv, opfvv_overwrite_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmacc_vv, opfvv_overwrite_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwmsac_vv, opfvv_overwrite_widen_check)
-GEN_OPFVV_WIDEN_TRANS(vfwnmsac_vv, opfvv_overwrite_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmacc_vf, opfvf_overwrite_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmacc_vf, opfvf_overwrite_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwmsac_vf, opfvf_overwrite_widen_check)
-GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_overwrite_widen_check)
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwmacc_vv, opfvv_overwrite_widen_check,
+                          vfwmaccbf16_vv)
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwnmacc_vv, opfvv_overwrite_widen_check,
+                          vfwnmacc_vv_h_bf16)
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwmsac_vv, opfvv_overwrite_widen_check,
+                          vfwmsac_vv_h_bf16)
+GEN_OPFVV_WIDEN_BFA_TRANS(vfwnmsac_vv, opfvv_overwrite_widen_check,
+                          vfwnmsac_vv_h_bf16)
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwmacc_vf, opfvf_overwrite_widen_check,
+                          vfwmaccbf16_vf)
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwnmacc_vf, opfvf_overwrite_widen_check,
+                          vfwnmacc_vf_h_bf16)
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwmsac_vf, opfvf_overwrite_widen_check,
+                          vfwmsac_vf_h_bf16)
+GEN_OPFVF_WIDEN_BFA_TRANS(vfwnmsac_vf, opfvf_overwrite_widen_check,
+                          vfwnmsac_vf_h_bf16)
 
 /* Vector Floating-Point Square-Root Instruction */
 
@@ -2688,21 +2809,23 @@ GEN_OPFVF_WIDEN_TRANS(vfwnmsac_vf, opfvf_overwrite_widen_check)
  * If the current SEW does not correspond to a supported IEEE floating-point
  * type, an illegal instruction exception is raised
  */
-static bool opfv_check(DisasContext *s, arg_rmr *a)
+static bool opfv_check(DisasContext *s, arg_rmr *a, int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            vext_check_isa_ill(s) &&
            /* OPFV instructions ignore vs1 check */
-           vext_check_ss(s, a->rd, a->rs2, a->vm);
+           vext_check_ss(s, a->rd, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 static bool do_opfv(DisasContext *s, arg_rmr *a,
                     gen_helper_gvec_3_ptr *fn,
-                    bool (*checkfn)(DisasContext *, arg_rmr *),
-                    int rm)
+                    bool (*checkfn)(DisasContext *, arg_rmr *, int8_t),
+                    int rm,
+                    int8_t valid_bfa_vsew)
 {
-    if (checkfn(s, a)) {
+    if (checkfn(s, a, valid_bfa_vsew)) {
         uint32_t data = 0;
         gen_set_rm_chkfrm(s, rm);
 
@@ -2720,76 +2843,95 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
     return false;
 }
 
-#define GEN_OPFV_TRANS(NAME, CHECK, FRM)               \
-static bool trans_##NAME(DisasContext *s, arg_rmr *a)  \
-{                                                      \
-    static gen_helper_gvec_3_ptr * const fns[3] = {    \
-        gen_helper_##NAME##_h,                         \
-        gen_helper_##NAME##_w,                         \
-        gen_helper_##NAME##_d                          \
-    };                                                 \
-    return do_opfv(s, a, fns[s->sew - 1], CHECK, FRM); \
+#define GEN_OPFV_TRANS(NAME, CHECK, FRM)                    \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)       \
+{                                                           \
+    static gen_helper_gvec_3_ptr * const fns[3] = {         \
+        gen_helper_##NAME##_h,                              \
+        gen_helper_##NAME##_w,                              \
+        gen_helper_##NAME##_d                               \
+    };                                                      \
+    return do_opfv(s, a, fns[s->sew - 1], CHECK, FRM, -1);  \
+}
+
+#define GEN_OPFV_BFA_TRANS(NAME, CHECK, FRM)                    \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)           \
+{                                                               \
+    static gen_helper_gvec_3_ptr * const fns[3] = {             \
+        gen_helper_##NAME##_h,                                  \
+        gen_helper_##NAME##_w,                                  \
+        gen_helper_##NAME##_d                                   \
+    };                                                          \
+    return do_opfv(s, a,                                        \
+                   (s->altfmt ? gen_helper_##NAME##_h_bf16 :    \
+                                fns[s->sew - 1]),               \
+                   CHECK, FRM, MO_16);                          \
 }
 
 GEN_OPFV_TRANS(vfsqrt_v, opfv_check, RISCV_FRM_DYN)
-GEN_OPFV_TRANS(vfrsqrt7_v, opfv_check, RISCV_FRM_DYN)
-GEN_OPFV_TRANS(vfrec7_v, opfv_check, RISCV_FRM_DYN)
+GEN_OPFV_BFA_TRANS(vfrsqrt7_v, opfv_check, RISCV_FRM_DYN)
+GEN_OPFV_BFA_TRANS(vfrec7_v, opfv_check, RISCV_FRM_DYN)
 
 /* Vector Floating-Point MIN/MAX Instructions */
-GEN_OPFVV_TRANS(vfmin_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfmax_vv, opfvv_check)
-GEN_OPFVF_TRANS(vfmin_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfmax_vf, opfvf_check)
+GEN_OPFVV_BFA_TRANS(vfmin_vv, opfvv_check, vfmin_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vfmax_vv, opfvv_check, vfmax_vv_h_bf16)
+GEN_OPFVF_BFA_TRANS(vfmin_vf, opfvf_check, vfmin_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vfmax_vf, opfvf_check, vfmax_vf_h_bf16, false)
 
 /* Vector Floating-Point Sign-Injection Instructions */
-GEN_OPFVV_TRANS(vfsgnj_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfsgnjn_vv, opfvv_check)
-GEN_OPFVV_TRANS(vfsgnjx_vv, opfvv_check)
-GEN_OPFVF_TRANS(vfsgnj_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfsgnjn_vf, opfvf_check)
-GEN_OPFVF_TRANS(vfsgnjx_vf, opfvf_check)
+GEN_OPFVV_BFA_TRANS(vfsgnj_vv, opfvv_check, vfsgnj_vv_h)
+GEN_OPFVV_BFA_TRANS(vfsgnjn_vv, opfvv_check, vfsgnjn_vv_h)
+GEN_OPFVV_BFA_TRANS(vfsgnjx_vv, opfvv_check, vfsgnjx_vv_h)
+GEN_OPFVF_BFA_TRANS(vfsgnj_vf, opfvf_check, vfsgnj_vf_h, true)
+GEN_OPFVF_BFA_TRANS(vfsgnjn_vf, opfvf_check, vfsgnjn_vf_h, true)
+GEN_OPFVF_BFA_TRANS(vfsgnjx_vf, opfvf_check, vfsgnjx_vf_h, true)
 
 /* Vector Floating-Point Compare Instructions */
-static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a)
+static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a,
+                            int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_mss(s, a->rd, a->rs1, a->rs2);
+           vext_check_mss(s, a->rd, a->rs1, a->rs2) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
-GEN_OPFVV_TRANS(vmfne_vv, opfvv_cmp_check)
-GEN_OPFVV_TRANS(vmflt_vv, opfvv_cmp_check)
-GEN_OPFVV_TRANS(vmfle_vv, opfvv_cmp_check)
+GEN_OPFVV_BFA_TRANS(vmfeq_vv, opfvv_cmp_check, vmfeq_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vmfne_vv, opfvv_cmp_check, vmfne_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vmflt_vv, opfvv_cmp_check, vmflt_vv_h_bf16)
+GEN_OPFVV_BFA_TRANS(vmfle_vv, opfvv_cmp_check, vmfle_vv_h_bf16)
 
-static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
+static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a,
+                            int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_rvf(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_ms(s, a->rd, a->rs2);
+           vext_check_ms(s, a->rd, a->rs2) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)
-GEN_OPFVF_TRANS(vmfne_vf, opfvf_cmp_check)
-GEN_OPFVF_TRANS(vmflt_vf, opfvf_cmp_check)
-GEN_OPFVF_TRANS(vmfle_vf, opfvf_cmp_check)
-GEN_OPFVF_TRANS(vmfgt_vf, opfvf_cmp_check)
-GEN_OPFVF_TRANS(vmfge_vf, opfvf_cmp_check)
+GEN_OPFVF_BFA_TRANS(vmfeq_vf, opfvf_cmp_check, vmfeq_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vmfne_vf, opfvf_cmp_check, vmfne_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vmflt_vf, opfvf_cmp_check, vmflt_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vmfle_vf, opfvf_cmp_check, vmfle_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vmfgt_vf, opfvf_cmp_check, vmfgt_vf_h_bf16, false)
+GEN_OPFVF_BFA_TRANS(vmfge_vf, opfvf_cmp_check, vmfge_vf_h_bf16, false)
 
 /* Vector Floating-Point Classify Instruction */
-GEN_OPFV_TRANS(vfclass_v, opfv_check, RISCV_FRM_DYN)
+GEN_OPFV_BFA_TRANS(vfclass_v, opfv_check, RISCV_FRM_DYN)
 
 /* Vector Floating-Point Merge Instruction */
-GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
+GEN_OPFVF_BFA_TRANS(vfmerge_vfm,  opfvf_check, vfmerge_vfm_h, true)
 
 static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 {
     if (require_rvv(s) &&
         require_rvf(s) &&
         vext_check_isa_ill(s) &&
-        require_align(a->rd, s->lmul)) {
+        require_align(a->rd, s->lmul) &&
+        vext_check_altfmt(s, MO_16)) {
         gen_set_rm(s, RISCV_FRM_DYN);
 
         TCGv_i64 t1;
@@ -2797,7 +2939,7 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
         if (s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
             t1 = tcg_temp_new_i64();
             /* NaN-box f[rs1] */
-            do_nanbox(s, t1, cpu_fpr[a->rs1]);
+            do_nanbox(s, t1, cpu_fpr[a->rs1], true);
 
             tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                  MAXSZ(s), MAXSZ(s), t1);
@@ -2810,12 +2952,12 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             static gen_helper_vmv_vx * const fns[3] = {
                 gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w,
-                gen_helper_vmv_v_x_d,
+                gen_helper_vmv_v_x_d
             };
 
             t1 = tcg_temp_new_i64();
             /* NaN-box f[rs1] */
-            do_nanbox(s, t1, cpu_fpr[a->rs1]);
+            do_nanbox(s, t1, cpu_fpr[a->rs1], true);
 
             dest = tcg_temp_new_ptr();
             desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
@@ -2831,15 +2973,15 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
 }
 
 /* Single-Width Floating-Point/Integer Type-Convert Instructions */
-#define GEN_OPFV_CVT_TRANS(NAME, HELPER, FRM)               \
-static bool trans_##NAME(DisasContext *s, arg_rmr *a)       \
-{                                                           \
-    static gen_helper_gvec_3_ptr * const fns[3] = {         \
-        gen_helper_##HELPER##_h,                            \
-        gen_helper_##HELPER##_w,                            \
-        gen_helper_##HELPER##_d                             \
-    };                                                      \
-    return do_opfv(s, a, fns[s->sew - 1], opfv_check, FRM); \
+#define GEN_OPFV_CVT_TRANS(NAME, HELPER, FRM)                   \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)           \
+{                                                               \
+    static gen_helper_gvec_3_ptr * const fns[3] = {             \
+        gen_helper_##HELPER##_h,                                \
+        gen_helper_##HELPER##_w,                                \
+        gen_helper_##HELPER##_d                                 \
+    };                                                          \
+    return do_opfv(s, a, fns[s->sew - 1], opfv_check, FRM, -1); \
 }
 
 GEN_OPFV_CVT_TRANS(vfcvt_xu_f_v, vfcvt_xu_f_v, RISCV_FRM_DYN)
@@ -2863,95 +3005,129 @@ static bool opfv_widen_check(DisasContext *s, arg_rmr *a)
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
 
-static bool opxfv_widen_check(DisasContext *s, arg_rmr *a)
+static bool opxfv_widen_check(DisasContext *s, arg_rmr *a,
+                              int8_t valid_bfa_vsew)
 {
     return opfv_widen_check(s, a) &&
-           require_rvf(s);
+           require_rvf(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-static bool opffv_widen_check(DisasContext *s, arg_rmr *a)
+static bool opffv_widen_check(DisasContext *s, arg_rmr *a,
+                              int8_t valid_bfa_vsew)
 {
     return opfv_widen_check(s, a) &&
            require_rvfmin(s) &&
-           require_scale_rvfmin(s);
-}
-
-#define GEN_OPFV_WIDEN_TRANS(NAME, CHECK, HELPER, FRM)             \
-static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
-{                                                                  \
-    if (CHECK(s, a)) {                                             \
-        uint32_t data = 0;                                         \
-        static gen_helper_gvec_3_ptr * const fns[2] = {            \
-            gen_helper_##HELPER##_h,                               \
-            gen_helper_##HELPER##_w,                               \
-        };                                                         \
-        gen_set_rm_chkfrm(s, FRM);                                 \
-                                                                   \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
-                           vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlenb,                      \
-                           s->cfg_ptr->vlenb, data,                \
-                           fns[s->sew - 1]);                       \
-        finalize_rvv_inst(s);                                      \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+           require_scale_rvfmin(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
+}
+
+#define GEN_OPFV_WIDEN_TRANS(NAME, CHECK, HELPER, FRM)          \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)           \
+{                                                               \
+    if (CHECK(s, a, -1)) {                                      \
+        uint32_t data = 0;                                      \
+        static gen_helper_gvec_3_ptr * const fns[2] = {         \
+            gen_helper_##HELPER##_h,                            \
+            gen_helper_##HELPER##_w,                            \
+        };                                                      \
+        gen_set_rm_chkfrm(s, FRM);                              \
+                                                                \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);          \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);            \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);            \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),  \
+                           vreg_ofs(s, a->rs2), tcg_env,        \
+                           s->cfg_ptr->vlenb,                   \
+                           s->cfg_ptr->vlenb, data,             \
+                           fns[s->sew - 1]);                    \
+        finalize_rvv_inst(s);                                   \
+        return true;                                            \
+    }                                                           \
+    return false;                                               \
+}
+
+#define GEN_OPFV_WIDEN_BFA_TRANS(NAME, CHECK, HELPER, FRM, BFA_HELPER)  \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)                   \
+{                                                                       \
+    if (CHECK(s, a, MO_16)) {                                           \
+        uint32_t data = 0;                                              \
+        static gen_helper_gvec_3_ptr * const fns[2] = {                 \
+            gen_helper_##HELPER##_h,                                    \
+            gen_helper_##HELPER##_w,                                    \
+        };                                                              \
+        gen_set_rm_chkfrm(s, FRM);                                      \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),          \
+                           vreg_ofs(s, a->rs2), tcg_env,                \
+                           s->cfg_ptr->vlenb,                           \
+                           s->cfg_ptr->vlenb, data,                     \
+                           (s->altfmt ? gen_helper_##BFA_HELPER :       \
+                                        fns[s->sew - 1]));              \
+        finalize_rvv_inst(s);                                           \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
 }
 
 GEN_OPFV_WIDEN_TRANS(vfwcvt_xu_f_v, opxfv_widen_check, vfwcvt_xu_f_v,
                      RISCV_FRM_DYN)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_x_f_v, opxfv_widen_check, vfwcvt_x_f_v,
                      RISCV_FRM_DYN)
-GEN_OPFV_WIDEN_TRANS(vfwcvt_f_f_v, opffv_widen_check, vfwcvt_f_f_v,
-                     RISCV_FRM_DYN)
+GEN_OPFV_WIDEN_BFA_TRANS(vfwcvt_f_f_v, opffv_widen_check, vfwcvt_f_f_v,
+                         RISCV_FRM_DYN, vfwcvtbf16_f_f_v)
 /* Reuse the helper functions from vfwcvt.xu.f.v and vfwcvt.x.f.v */
 GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_xu_f_v, opxfv_widen_check, vfwcvt_xu_f_v,
                      RISCV_FRM_RTZ)
 GEN_OPFV_WIDEN_TRANS(vfwcvt_rtz_x_f_v, opxfv_widen_check, vfwcvt_x_f_v,
                      RISCV_FRM_RTZ)
 
-static bool opfxv_widen_check(DisasContext *s, arg_rmr *a)
+static bool opfxv_widen_check(DisasContext *s, arg_rmr *a,
+                              int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_scale_rvf(s) &&
            vext_check_isa_ill(s) &&
            /* OPFV widening instructions ignore vs1 check */
-           vext_check_ds(s, a->rd, a->rs2, a->vm);
+           vext_check_ds(s, a->rd, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-#define GEN_OPFXV_WIDEN_TRANS(NAME)                                \
-static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
-{                                                                  \
-    if (opfxv_widen_check(s, a)) {                                 \
-        uint32_t data = 0;                                         \
-        static gen_helper_gvec_3_ptr * const fns[3] = {            \
-            gen_helper_##NAME##_b,                                 \
-            gen_helper_##NAME##_h,                                 \
-            gen_helper_##NAME##_w,                                 \
-        };                                                         \
-        gen_set_rm(s, RISCV_FRM_DYN);                              \
-                                                                   \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
-                           vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlenb,                      \
-                           s->cfg_ptr->vlenb, data,                \
-                           fns[s->sew]);                           \
-        finalize_rvv_inst(s);                                      \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+#define GEN_OPFXV_WIDEN_BFA_TRANS(NAME)                                 \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)                   \
+{                                                                       \
+    if (opfxv_widen_check(s, a, MO_8)) {                                \
+        uint32_t data = 0;                                              \
+        static gen_helper_gvec_3_ptr * const fns[3] = {                 \
+            gen_helper_##NAME##_b,                                      \
+            gen_helper_##NAME##_h,                                      \
+            gen_helper_##NAME##_w                                       \
+        };                                                              \
+        gen_set_rm(s, RISCV_FRM_DYN);                                   \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),          \
+                           vreg_ofs(s, a->rs2), tcg_env,                \
+                           s->cfg_ptr->vlenb,                           \
+                           s->cfg_ptr->vlenb, data,                     \
+                           (s->altfmt ? gen_helper_##NAME##_b_bf16 :    \
+                                        fns[s->sew]));                  \
+        finalize_rvv_inst(s);                                           \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
 }
 
-GEN_OPFXV_WIDEN_TRANS(vfwcvt_f_xu_v)
-GEN_OPFXV_WIDEN_TRANS(vfwcvt_f_x_v)
+GEN_OPFXV_WIDEN_BFA_TRANS(vfwcvt_f_xu_v)
+GEN_OPFXV_WIDEN_BFA_TRANS(vfwcvt_f_x_v)
 
 /* Narrowing Floating-Point/Integer Type-Convert Instructions */
 
@@ -2967,104 +3143,140 @@ static bool opfv_narrow_check(DisasContext *s, arg_rmr *a)
            vext_check_sd(s, a->rd, a->rs2, a->vm);
 }
 
-static bool opfxv_narrow_check(DisasContext *s, arg_rmr *a)
+static bool opfxv_narrow_check(DisasContext *s, arg_rmr *a,
+                               int8_t valid_bfa_vsew)
 {
     return opfv_narrow_check(s, a) &&
            require_rvf(s) &&
-           (s->sew != MO_64);
+           (s->sew != MO_64) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
+static bool opffv_narrow_check(DisasContext *s, arg_rmr *a,
+                               int8_t valid_bfa_vsew)
 {
     return opfv_narrow_check(s, a) &&
            require_rvfmin(s) &&
-           require_scale_rvfmin(s);
+           require_scale_rvfmin(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
+static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a,
+                                   int8_t valid_bfa_vsew)
 {
     return opfv_narrow_check(s, a) &&
            require_rvf(s) &&
-           require_scale_rvf(s);
-}
-
-#define GEN_OPFV_NARROW_TRANS(NAME, CHECK, HELPER, FRM)            \
-static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
-{                                                                  \
-    if (CHECK(s, a)) {                                             \
-        uint32_t data = 0;                                         \
-        static gen_helper_gvec_3_ptr * const fns[2] = {            \
-            gen_helper_##HELPER##_h,                               \
-            gen_helper_##HELPER##_w,                               \
-        };                                                         \
-        gen_set_rm_chkfrm(s, FRM);                                 \
-                                                                   \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
-                           vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlenb,                      \
-                           s->cfg_ptr->vlenb, data,                \
-                           fns[s->sew - 1]);                       \
-        finalize_rvv_inst(s);                                      \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+           require_scale_rvf(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
+}
+
+#define GEN_OPFV_NARROW_TRANS(NAME, CHECK, HELPER, FRM)         \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)           \
+{                                                               \
+    if (CHECK(s, a, -1)) {                                      \
+        uint32_t data = 0;                                      \
+        static gen_helper_gvec_3_ptr * const fns[2] = {         \
+            gen_helper_##HELPER##_h,                            \
+            gen_helper_##HELPER##_w,                            \
+        };                                                      \
+        gen_set_rm_chkfrm(s, FRM);                              \
+                                                                \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);              \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);          \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);            \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);            \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),  \
+                           vreg_ofs(s, a->rs2), tcg_env,        \
+                           s->cfg_ptr->vlenb,                   \
+                           s->cfg_ptr->vlenb, data,             \
+                           fns[s->sew - 1]);                    \
+        finalize_rvv_inst(s);                                   \
+        return true;                                            \
+    }                                                           \
+    return false;                                               \
+}
+
+#define GEN_OPFV_NARROW_BFA_TRANS(NAME, CHECK, HELPER, FRM, BFA_HELPER) \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)                   \
+{                                                                       \
+    if (CHECK(s, a, MO_16)) {                                           \
+        uint32_t data = 0;                                              \
+        static gen_helper_gvec_3_ptr * const fns[2] = {                 \
+            gen_helper_##HELPER##_h,                                    \
+            gen_helper_##HELPER##_w,                                    \
+        };                                                              \
+        gen_set_rm_chkfrm(s, FRM);                                      \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),          \
+                           vreg_ofs(s, a->rs2), tcg_env,                \
+                           s->cfg_ptr->vlenb,                           \
+                           s->cfg_ptr->vlenb, data,                     \
+                           (s->altfmt ? gen_helper_##BFA_HELPER :       \
+                                        fns[s->sew - 1]));              \
+        finalize_rvv_inst(s);                                           \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
 }
 
 GEN_OPFV_NARROW_TRANS(vfncvt_f_xu_w, opfxv_narrow_check, vfncvt_f_xu_w,
                       RISCV_FRM_DYN)
 GEN_OPFV_NARROW_TRANS(vfncvt_f_x_w, opfxv_narrow_check, vfncvt_f_x_w,
                       RISCV_FRM_DYN)
-GEN_OPFV_NARROW_TRANS(vfncvt_f_f_w, opffv_narrow_check, vfncvt_f_f_w,
-                      RISCV_FRM_DYN)
+GEN_OPFV_NARROW_BFA_TRANS(vfncvt_f_f_w, opffv_narrow_check, vfncvt_f_f_w,
+                          RISCV_FRM_DYN, vfncvtbf16_f_f_w)
 /* Reuse the helper function from vfncvt.f.f.w */
-GEN_OPFV_NARROW_TRANS(vfncvt_rod_f_f_w, opffv_rod_narrow_check, vfncvt_f_f_w,
-                      RISCV_FRM_ROD)
+GEN_OPFV_NARROW_BFA_TRANS(vfncvt_rod_f_f_w, opffv_rod_narrow_check,
+                          vfncvt_f_f_w, RISCV_FRM_ROD, vfncvtbf16_f_f_w)
 
-static bool opxfv_narrow_check(DisasContext *s, arg_rmr *a)
+static bool opxfv_narrow_check(DisasContext *s, arg_rmr *a,
+                               int8_t valid_bfa_vsew)
 {
     return require_rvv(s) &&
            require_scale_rvf(s) &&
            vext_check_isa_ill(s) &&
            /* OPFV narrowing instructions ignore vs1 check */
-           vext_check_sd(s, a->rd, a->rs2, a->vm);
+           vext_check_sd(s, a->rd, a->rs2, a->vm) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-#define GEN_OPXFV_NARROW_TRANS(NAME, HELPER, FRM)                  \
-static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
-{                                                                  \
-    if (opxfv_narrow_check(s, a)) {                                \
-        uint32_t data = 0;                                         \
-        static gen_helper_gvec_3_ptr * const fns[3] = {            \
-            gen_helper_##HELPER##_b,                               \
-            gen_helper_##HELPER##_h,                               \
-            gen_helper_##HELPER##_w,                               \
-        };                                                         \
-        gen_set_rm_chkfrm(s, FRM);                                 \
-                                                                   \
-        data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
-        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
-        data = FIELD_DP32(data, VDATA, VTA, s->vta);               \
-        data = FIELD_DP32(data, VDATA, VMA, s->vma);               \
-        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
-                           vreg_ofs(s, a->rs2), tcg_env,           \
-                           s->cfg_ptr->vlenb,                      \
-                           s->cfg_ptr->vlenb, data,                \
-                           fns[s->sew]);                           \
-        finalize_rvv_inst(s);                                      \
-        return true;                                               \
-    }                                                              \
-    return false;                                                  \
+#define GEN_OPXFV_NARROW_BFA_TRANS(NAME, HELPER, FRM)                   \
+static bool trans_##NAME(DisasContext *s, arg_rmr *a)                   \
+{                                                                       \
+    if (opxfv_narrow_check(s, a, MO_8)) {                               \
+        uint32_t data = 0;                                              \
+        static gen_helper_gvec_3_ptr * const fns[3] = {                 \
+            gen_helper_##HELPER##_b,                                    \
+            gen_helper_##HELPER##_h,                                    \
+            gen_helper_##HELPER##_w                                     \
+        };                                                              \
+        gen_set_rm_chkfrm(s, FRM);                                      \
+                                                                        \
+        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
+        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
+        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
+        data = FIELD_DP32(data, VDATA, VMA, s->vma);                    \
+        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),          \
+                           vreg_ofs(s, a->rs2), tcg_env,                \
+                           s->cfg_ptr->vlenb,                           \
+                           s->cfg_ptr->vlenb, data,                     \
+                           (s->altfmt ? gen_helper_##HELPER##_b_bf16 :  \
+                                        fns[s->sew]));                  \
+        finalize_rvv_inst(s);                                           \
+        return true;                                                    \
+    }                                                                   \
+    return false;                                                       \
 }
 
-GEN_OPXFV_NARROW_TRANS(vfncvt_xu_f_w, vfncvt_xu_f_w, RISCV_FRM_DYN)
-GEN_OPXFV_NARROW_TRANS(vfncvt_x_f_w, vfncvt_x_f_w, RISCV_FRM_DYN)
+GEN_OPXFV_NARROW_BFA_TRANS(vfncvt_xu_f_w, vfncvt_xu_f_w, RISCV_FRM_DYN)
+GEN_OPXFV_NARROW_BFA_TRANS(vfncvt_x_f_w, vfncvt_x_f_w, RISCV_FRM_DYN)
 /* Reuse the helper functions from vfncvt.xu.f.w and vfncvt.x.f.w */
-GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_xu_f_w, vfncvt_xu_f_w, RISCV_FRM_RTZ)
-GEN_OPXFV_NARROW_TRANS(vfncvt_rtz_x_f_w, vfncvt_x_f_w, RISCV_FRM_RTZ)
+GEN_OPXFV_NARROW_BFA_TRANS(vfncvt_rtz_xu_f_w, vfncvt_xu_f_w, RISCV_FRM_RTZ)
+GEN_OPXFV_NARROW_BFA_TRANS(vfncvt_rtz_x_f_w, vfncvt_x_f_w, RISCV_FRM_RTZ)
 
 /*
  *** Vector Reduction Operations
@@ -3097,10 +3309,12 @@ GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)
 GEN_OPIVV_WIDEN_TRANS(vwredsumu_vs, reduction_widen_check)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
-static bool freduction_check(DisasContext *s, arg_rmrr *a)
+static bool freduction_check(DisasContext *s, arg_rmrr *a,
+                             int8_t valid_bfa_vsew)
 {
     return reduction_check(s, a) &&
-           require_rvf(s);
+           require_rvf(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 GEN_OPFVV_TRANS(vfredusum_vs, freduction_check)
@@ -3109,11 +3323,13 @@ GEN_OPFVV_TRANS(vfredmax_vs, freduction_check)
 GEN_OPFVV_TRANS(vfredmin_vs, freduction_check)
 
 /* Vector Widening Floating-Point Reduction Instructions */
-static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
+static bool freduction_widen_check(DisasContext *s, arg_rmrr *a,
+                                   int8_t valid_bfa_vsew)
 {
     return reduction_widen_check(s, a) &&
            require_rvf(s) &&
-           require_scale_rvf(s);
+           require_scale_rvf(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
 GEN_OPFVV_WIDEN_TRANS(vfwredusum_vs, freduction_widen_check)
@@ -3528,7 +3744,8 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 {
     if (require_rvv(s) &&
         require_rvf(s) &&
-        vext_check_isa_ill(s)) {
+        vext_check_isa_ill(s) &&
+        vext_check_altfmt(s, MO_16)) {
         gen_set_rm(s, RISCV_FRM_DYN);
 
         /* The instructions ignore LMUL and vector register group. */
@@ -3540,7 +3757,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
-        do_nanbox(s, t1, cpu_fpr[a->rs1]);
+        do_nanbox(s, t1, cpu_fpr[a->rs1], true);
 
         vec_element_storei(s, a->rd, 0, t1);
 
@@ -3576,20 +3793,23 @@ GEN_OPIVX_TRANS(vslide1down_vx, slidedown_check)
 GEN_OPIVI_TRANS(vslidedown_vi, IMM_ZX, vslidedown_vx, slidedown_check)
 
 /* Vector Floating-Point Slide Instructions */
-static bool fslideup_check(DisasContext *s, arg_rmrr *a)
+static bool fslideup_check(DisasContext *s, arg_rmrr *a, int8_t valid_bfa_vsew)
 {
     return slideup_check(s, a) &&
-           require_rvf(s);
+           require_rvf(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-static bool fslidedown_check(DisasContext *s, arg_rmrr *a)
+static bool fslidedown_check(DisasContext *s, arg_rmrr *a,
+                             int8_t valid_bfa_vsew)
 {
     return slidedown_check(s, a) &&
-           require_rvf(s);
+           require_rvf(s) &&
+           vext_check_altfmt(s, valid_bfa_vsew);
 }
 
-GEN_OPFVF_TRANS(vfslide1up_vf, fslideup_check)
-GEN_OPFVF_TRANS(vfslide1down_vf, fslidedown_check)
+GEN_OPFVF_BFA_TRANS(vfslide1up_vf, fslideup_check, vfslide1up_vf_h, true)
+GEN_OPFVF_BFA_TRANS(vfslide1down_vf, fslidedown_check, vfslide1down_vf_h, true)
 
 /* Vector Register Gather Instruction */
 static bool vrgather_vv_check(DisasContext *s, arg_rmrr *a)
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 172296f12e2..6343ad6826d 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -72,6 +72,7 @@ FIELD(VDATA, NF, 7, 4)
 FIELD(VDATA, WD, 7, 1)
 
 /* float point classify helpers */
+target_ulong fclass_h_bf16(uint64_t frs1);
 target_ulong fclass_h(uint64_t frs1);
 target_ulong fclass_s(uint64_t frs1);
 target_ulong fclass_d(uint64_t frs1);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 603d0731ae1..6445f63e3d0 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3166,9 +3166,11 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                       total_elems * ESZ);                 \
 }
 
+RVVCALL(OPFVV2, vfadd_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_add)
 RVVCALL(OPFVV2, vfadd_vv_h, OP_UUU_H, H2, H2, H2, float16_add)
 RVVCALL(OPFVV2, vfadd_vv_w, OP_UUU_W, H4, H4, H4, float32_add)
 RVVCALL(OPFVV2, vfadd_vv_d, OP_UUU_D, H8, H8, H8, float64_add)
+GEN_VEXT_VV_ENV(vfadd_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfadd_vv_h, 2)
 GEN_VEXT_VV_ENV(vfadd_vv_w, 4)
 GEN_VEXT_VV_ENV(vfadd_vv_d, 8)
@@ -3211,26 +3213,37 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
                       total_elems * ESZ);                 \
 }
 
+RVVCALL(OPFVF2, vfadd_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_add)
 RVVCALL(OPFVF2, vfadd_vf_h, OP_UUU_H, H2, H2, float16_add)
 RVVCALL(OPFVF2, vfadd_vf_w, OP_UUU_W, H4, H4, float32_add)
 RVVCALL(OPFVF2, vfadd_vf_d, OP_UUU_D, H8, H8, float64_add)
+GEN_VEXT_VF(vfadd_vf_h_bf16, 2)
 GEN_VEXT_VF(vfadd_vf_h, 2)
 GEN_VEXT_VF(vfadd_vf_w, 4)
 GEN_VEXT_VF(vfadd_vf_d, 8)
 
+RVVCALL(OPFVV2, vfsub_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_sub)
 RVVCALL(OPFVV2, vfsub_vv_h, OP_UUU_H, H2, H2, H2, float16_sub)
 RVVCALL(OPFVV2, vfsub_vv_w, OP_UUU_W, H4, H4, H4, float32_sub)
 RVVCALL(OPFVV2, vfsub_vv_d, OP_UUU_D, H8, H8, H8, float64_sub)
+GEN_VEXT_VV_ENV(vfsub_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfsub_vv_h, 2)
 GEN_VEXT_VV_ENV(vfsub_vv_w, 4)
 GEN_VEXT_VV_ENV(vfsub_vv_d, 8)
+RVVCALL(OPFVF2, vfsub_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_sub)
 RVVCALL(OPFVF2, vfsub_vf_h, OP_UUU_H, H2, H2, float16_sub)
 RVVCALL(OPFVF2, vfsub_vf_w, OP_UUU_W, H4, H4, float32_sub)
 RVVCALL(OPFVF2, vfsub_vf_d, OP_UUU_D, H8, H8, float64_sub)
+GEN_VEXT_VF(vfsub_vf_h_bf16, 2)
 GEN_VEXT_VF(vfsub_vf_h, 2)
 GEN_VEXT_VF(vfsub_vf_w, 4)
 GEN_VEXT_VF(vfsub_vf_d, 8)
 
+static uint16_t bfloat16_rsub(uint16_t a, uint16_t b, float_status * s)
+{
+    return bfloat16_sub(b, a, s);
+}
+
 static uint16_t float16_rsub(uint16_t a, uint16_t b, float_status *s)
 {
     return float16_sub(b, a, s);
@@ -3246,14 +3259,22 @@ static uint64_t float64_rsub(uint64_t a, uint64_t b, float_status *s)
     return float64_sub(b, a, s);
 }
 
+RVVCALL(OPFVF2, vfrsub_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_rsub)
 RVVCALL(OPFVF2, vfrsub_vf_h, OP_UUU_H, H2, H2, float16_rsub)
 RVVCALL(OPFVF2, vfrsub_vf_w, OP_UUU_W, H4, H4, float32_rsub)
 RVVCALL(OPFVF2, vfrsub_vf_d, OP_UUU_D, H8, H8, float64_rsub)
+GEN_VEXT_VF(vfrsub_vf_h_bf16, 2)
 GEN_VEXT_VF(vfrsub_vf_h, 2)
 GEN_VEXT_VF(vfrsub_vf_w, 4)
 GEN_VEXT_VF(vfrsub_vf_d, 8)
 
 /* Vector Widening Floating-Point Add/Subtract Instructions */
+static uint32_t vfwadd16_bf16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_add(bfloat16_to_float32(a, s),
+                       bfloat16_to_float32(b, s), s);
+}
+
 static uint32_t vfwadd16(uint16_t a, uint16_t b, float_status *s)
 {
     return float32_add(float16_to_float32(a, true, s),
@@ -3267,15 +3288,25 @@ static uint64_t vfwadd32(uint32_t a, uint32_t b, float_status *s)
 
 }
 
+RVVCALL(OPFVV2, vfwadd_vv_h_bf16, WOP_UUU_H, H4, H2, H2, vfwadd16_bf16)
 RVVCALL(OPFVV2, vfwadd_vv_h, WOP_UUU_H, H4, H2, H2, vfwadd16)
 RVVCALL(OPFVV2, vfwadd_vv_w, WOP_UUU_W, H8, H4, H4, vfwadd32)
+GEN_VEXT_VV_ENV(vfwadd_vv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwadd_vv_h, 4)
 GEN_VEXT_VV_ENV(vfwadd_vv_w, 8)
+RVVCALL(OPFVF2, vfwadd_vf_h_bf16, WOP_UUU_H, H4, H2, vfwadd16_bf16)
 RVVCALL(OPFVF2, vfwadd_vf_h, WOP_UUU_H, H4, H2, vfwadd16)
 RVVCALL(OPFVF2, vfwadd_vf_w, WOP_UUU_W, H8, H4, vfwadd32)
+GEN_VEXT_VF(vfwadd_vf_h_bf16, 4)
 GEN_VEXT_VF(vfwadd_vf_h, 4)
 GEN_VEXT_VF(vfwadd_vf_w, 8)
 
+static uint32_t vfwsub16_bf16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_sub(bfloat16_to_float32(a, s),
+                       bfloat16_to_float32(b, s), s);
+}
+
 static uint32_t vfwsub16(uint16_t a, uint16_t b, float_status *s)
 {
     return float32_sub(float16_to_float32(a, true, s),
@@ -3289,15 +3320,24 @@ static uint64_t vfwsub32(uint32_t a, uint32_t b, float_status *s)
 
 }
 
+RVVCALL(OPFVV2, vfwsub_vv_h_bf16, WOP_UUU_H, H4, H2, H2, vfwsub16_bf16)
 RVVCALL(OPFVV2, vfwsub_vv_h, WOP_UUU_H, H4, H2, H2, vfwsub16)
 RVVCALL(OPFVV2, vfwsub_vv_w, WOP_UUU_W, H8, H4, H4, vfwsub32)
+GEN_VEXT_VV_ENV(vfwsub_vv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwsub_vv_h, 4)
 GEN_VEXT_VV_ENV(vfwsub_vv_w, 8)
+RVVCALL(OPFVF2, vfwsub_vf_h_bf16, WOP_UUU_H, H4, H2, vfwsub16_bf16)
 RVVCALL(OPFVF2, vfwsub_vf_h, WOP_UUU_H, H4, H2, vfwsub16)
 RVVCALL(OPFVF2, vfwsub_vf_w, WOP_UUU_W, H8, H4, vfwsub32)
+GEN_VEXT_VF(vfwsub_vf_h_bf16, 4)
 GEN_VEXT_VF(vfwsub_vf_h, 4)
 GEN_VEXT_VF(vfwsub_vf_w, 8)
 
+static uint32_t vfwaddw16_bf16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_add(a, bfloat16_to_float32(b, s), s);
+}
+
 static uint32_t vfwaddw16(uint32_t a, uint16_t b, float_status *s)
 {
     return float32_add(a, float16_to_float32(b, true, s), s);
@@ -3308,15 +3348,24 @@ static uint64_t vfwaddw32(uint64_t a, uint32_t b, float_status *s)
     return float64_add(a, float32_to_float64(b, s), s);
 }
 
+RVVCALL(OPFVV2, vfwadd_wv_h_bf16, WOP_WUUU_H, H4, H2, H2, vfwaddw16_bf16)
 RVVCALL(OPFVV2, vfwadd_wv_h, WOP_WUUU_H, H4, H2, H2, vfwaddw16)
 RVVCALL(OPFVV2, vfwadd_wv_w, WOP_WUUU_W, H8, H4, H4, vfwaddw32)
+GEN_VEXT_VV_ENV(vfwadd_wv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwadd_wv_h, 4)
 GEN_VEXT_VV_ENV(vfwadd_wv_w, 8)
+RVVCALL(OPFVF2, vfwadd_wf_h_bf16, WOP_WUUU_H, H4, H2, vfwaddw16_bf16)
 RVVCALL(OPFVF2, vfwadd_wf_h, WOP_WUUU_H, H4, H2, vfwaddw16)
 RVVCALL(OPFVF2, vfwadd_wf_w, WOP_WUUU_W, H8, H4, vfwaddw32)
+GEN_VEXT_VF(vfwadd_wf_h_bf16, 4)
 GEN_VEXT_VF(vfwadd_wf_h, 4)
 GEN_VEXT_VF(vfwadd_wf_w, 8)
 
+static uint32_t vfwsubw16_bf16(uint32_t a, uint16_t b, float_status *s)
+{
+    return float32_sub(a, bfloat16_to_float32(b, s), s);
+}
+
 static uint32_t vfwsubw16(uint32_t a, uint16_t b, float_status *s)
 {
     return float32_sub(a, float16_to_float32(b, true, s), s);
@@ -3327,25 +3376,33 @@ static uint64_t vfwsubw32(uint64_t a, uint32_t b, float_status *s)
     return float64_sub(a, float32_to_float64(b, s), s);
 }
 
+RVVCALL(OPFVV2, vfwsub_wv_h_bf16, WOP_WUUU_H, H4, H2, H2, vfwsubw16_bf16)
 RVVCALL(OPFVV2, vfwsub_wv_h, WOP_WUUU_H, H4, H2, H2, vfwsubw16)
 RVVCALL(OPFVV2, vfwsub_wv_w, WOP_WUUU_W, H8, H4, H4, vfwsubw32)
+GEN_VEXT_VV_ENV(vfwsub_wv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwsub_wv_h, 4)
 GEN_VEXT_VV_ENV(vfwsub_wv_w, 8)
+RVVCALL(OPFVF2, vfwsub_wf_h_bf16, WOP_WUUU_H, H4, H2, vfwsubw16_bf16)
 RVVCALL(OPFVF2, vfwsub_wf_h, WOP_WUUU_H, H4, H2, vfwsubw16)
 RVVCALL(OPFVF2, vfwsub_wf_w, WOP_WUUU_W, H8, H4, vfwsubw32)
+GEN_VEXT_VF(vfwsub_wf_h_bf16, 4)
 GEN_VEXT_VF(vfwsub_wf_h, 4)
 GEN_VEXT_VF(vfwsub_wf_w, 8)
 
 /* Vector Single-Width Floating-Point Multiply/Divide Instructions */
+RVVCALL(OPFVV2, vfmul_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_mul)
 RVVCALL(OPFVV2, vfmul_vv_h, OP_UUU_H, H2, H2, H2, float16_mul)
 RVVCALL(OPFVV2, vfmul_vv_w, OP_UUU_W, H4, H4, H4, float32_mul)
 RVVCALL(OPFVV2, vfmul_vv_d, OP_UUU_D, H8, H8, H8, float64_mul)
+GEN_VEXT_VV_ENV(vfmul_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmul_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmul_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmul_vv_d, 8)
+RVVCALL(OPFVF2, vfmul_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_mul)
 RVVCALL(OPFVF2, vfmul_vf_h, OP_UUU_H, H2, H2, float16_mul)
 RVVCALL(OPFVF2, vfmul_vf_w, OP_UUU_W, H4, H4, float32_mul)
 RVVCALL(OPFVF2, vfmul_vf_d, OP_UUU_D, H8, H8, float64_mul)
+GEN_VEXT_VF(vfmul_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmul_vf_h, 2)
 GEN_VEXT_VF(vfmul_vf_w, 4)
 GEN_VEXT_VF(vfmul_vf_d, 8)
@@ -3386,6 +3443,12 @@ GEN_VEXT_VF(vfrdiv_vf_w, 4)
 GEN_VEXT_VF(vfrdiv_vf_d, 8)
 
 /* Vector Widening Floating-Point Multiply */
+static uint32_t vfwmul16_bf16(uint16_t a, uint16_t b, float_status *s)
+{
+    return float32_mul(bfloat16_to_float32(a, s),
+                       bfloat16_to_float32(b, s), s);
+}
+
 static uint32_t vfwmul16(uint16_t a, uint16_t b, float_status *s)
 {
     return float32_mul(float16_to_float32(a, true, s),
@@ -3398,12 +3461,17 @@ static uint64_t vfwmul32(uint32_t a, uint32_t b, float_status *s)
                        float32_to_float64(b, s), s);
 
 }
+
+RVVCALL(OPFVV2, vfwmul_vv_h_bf16, WOP_UUU_H, H4, H2, H2, vfwmul16_bf16)
 RVVCALL(OPFVV2, vfwmul_vv_h, WOP_UUU_H, H4, H2, H2, vfwmul16)
 RVVCALL(OPFVV2, vfwmul_vv_w, WOP_UUU_W, H8, H4, H4, vfwmul32)
+GEN_VEXT_VV_ENV(vfwmul_vv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwmul_vv_h, 4)
 GEN_VEXT_VV_ENV(vfwmul_vv_w, 8)
+RVVCALL(OPFVF2, vfwmul_vf_h_bf16, WOP_UUU_H, H4, H2, vfwmul16_bf16)
 RVVCALL(OPFVF2, vfwmul_vf_h, WOP_UUU_H, H4, H2, vfwmul16)
 RVVCALL(OPFVF2, vfwmul_vf_w, WOP_UUU_W, H8, H4, vfwmul32)
+GEN_VEXT_VF(vfwmul_vf_h_bf16, 4)
 GEN_VEXT_VF(vfwmul_vf_h, 4)
 GEN_VEXT_VF(vfwmul_vf_w, 8)
 
@@ -3418,6 +3486,12 @@ static void do_##NAME(void *vd, void *vs1, void *vs2, int i,       \
     *((TD *)vd + HD(i)) = OP(s2, s1, d, &env->fp_status);          \
 }
 
+static uint16_t fmacc16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                             float_status *s)
+{
+    return bfloat16_muladd(a, b, d, 0, s);
+}
+
 static uint16_t fmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, 0, s);
@@ -3433,9 +3507,11 @@ static uint64_t fmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
     return float64_muladd(a, b, d, 0, s);
 }
 
+RVVCALL(OPFVV3, vfmacc_vv_h_bf16, OP_UUU_H, H2, H2, H2, fmacc16_bf16)
 RVVCALL(OPFVV3, vfmacc_vv_h, OP_UUU_H, H2, H2, H2, fmacc16)
 RVVCALL(OPFVV3, vfmacc_vv_w, OP_UUU_W, H4, H4, H4, fmacc32)
 RVVCALL(OPFVV3, vfmacc_vv_d, OP_UUU_D, H8, H8, H8, fmacc64)
+GEN_VEXT_VV_ENV(vfmacc_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmacc_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmacc_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmacc_vv_d, 8)
@@ -3449,13 +3525,22 @@ static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i,    \
     *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, d, &env->fp_status);\
 }
 
+RVVCALL(OPFVF3, vfmacc_vf_h_bf16, OP_UUU_H, H2, H2, fmacc16_bf16)
 RVVCALL(OPFVF3, vfmacc_vf_h, OP_UUU_H, H2, H2, fmacc16)
 RVVCALL(OPFVF3, vfmacc_vf_w, OP_UUU_W, H4, H4, fmacc32)
 RVVCALL(OPFVF3, vfmacc_vf_d, OP_UUU_D, H8, H8, fmacc64)
+GEN_VEXT_VF(vfmacc_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmacc_vf_h, 2)
 GEN_VEXT_VF(vfmacc_vf_w, 4)
 GEN_VEXT_VF(vfmacc_vf_d, 8)
 
+static uint16_t fnmacc16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                              float_status *s)
+{
+    return bfloat16_muladd(a, b, d, float_muladd_negate_c |
+                                    float_muladd_negate_product, s);
+}
+
 static uint16_t fnmacc16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, float_muladd_negate_c |
@@ -3474,19 +3559,29 @@ static uint64_t fnmacc64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
                                    float_muladd_negate_product, s);
 }
 
+RVVCALL(OPFVV3, vfnmacc_vv_h_bf16, OP_UUU_H, H2, H2, H2, fnmacc16_bf16)
 RVVCALL(OPFVV3, vfnmacc_vv_h, OP_UUU_H, H2, H2, H2, fnmacc16)
 RVVCALL(OPFVV3, vfnmacc_vv_w, OP_UUU_W, H4, H4, H4, fnmacc32)
 RVVCALL(OPFVV3, vfnmacc_vv_d, OP_UUU_D, H8, H8, H8, fnmacc64)
+GEN_VEXT_VV_ENV(vfnmacc_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfnmacc_vv_h, 2)
 GEN_VEXT_VV_ENV(vfnmacc_vv_w, 4)
 GEN_VEXT_VV_ENV(vfnmacc_vv_d, 8)
+RVVCALL(OPFVF3, vfnmacc_vf_h_bf16, OP_UUU_H, H2, H2, fnmacc16_bf16)
 RVVCALL(OPFVF3, vfnmacc_vf_h, OP_UUU_H, H2, H2, fnmacc16)
 RVVCALL(OPFVF3, vfnmacc_vf_w, OP_UUU_W, H4, H4, fnmacc32)
 RVVCALL(OPFVF3, vfnmacc_vf_d, OP_UUU_D, H8, H8, fnmacc64)
+GEN_VEXT_VF(vfnmacc_vf_h_bf16, 2)
 GEN_VEXT_VF(vfnmacc_vf_h, 2)
 GEN_VEXT_VF(vfnmacc_vf_w, 4)
 GEN_VEXT_VF(vfnmacc_vf_d, 8)
 
+static uint16_t fmsac16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                             float_status *s)
+{
+    return bfloat16_muladd(a, b, d, float_muladd_negate_c, s);
+}
+
 static uint16_t fmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, float_muladd_negate_c, s);
@@ -3502,19 +3597,29 @@ static uint64_t fmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
     return float64_muladd(a, b, d, float_muladd_negate_c, s);
 }
 
+RVVCALL(OPFVV3, vfmsac_vv_h_bf16, OP_UUU_H, H2, H2, H2, fmsac16_bf16)
 RVVCALL(OPFVV3, vfmsac_vv_h, OP_UUU_H, H2, H2, H2, fmsac16)
 RVVCALL(OPFVV3, vfmsac_vv_w, OP_UUU_W, H4, H4, H4, fmsac32)
 RVVCALL(OPFVV3, vfmsac_vv_d, OP_UUU_D, H8, H8, H8, fmsac64)
+GEN_VEXT_VV_ENV(vfmsac_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmsac_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmsac_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmsac_vv_d, 8)
+RVVCALL(OPFVF3, vfmsac_vf_h_bf16, OP_UUU_H, H2, H2, fmsac16_bf16)
 RVVCALL(OPFVF3, vfmsac_vf_h, OP_UUU_H, H2, H2, fmsac16)
 RVVCALL(OPFVF3, vfmsac_vf_w, OP_UUU_W, H4, H4, fmsac32)
 RVVCALL(OPFVF3, vfmsac_vf_d, OP_UUU_D, H8, H8, fmsac64)
+GEN_VEXT_VF(vfmsac_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmsac_vf_h, 2)
 GEN_VEXT_VF(vfmsac_vf_w, 4)
 GEN_VEXT_VF(vfmsac_vf_d, 8)
 
+static uint16_t fnmsac16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                              float_status *s)
+{
+    return bfloat16_muladd(a, b, d, float_muladd_negate_product, s);
+}
+
 static uint16_t fnmsac16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(a, b, d, float_muladd_negate_product, s);
@@ -3530,19 +3635,29 @@ static uint64_t fnmsac64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
     return float64_muladd(a, b, d, float_muladd_negate_product, s);
 }
 
+RVVCALL(OPFVV3, vfnmsac_vv_h_bf16, OP_UUU_H, H2, H2, H2, fnmsac16_bf16)
 RVVCALL(OPFVV3, vfnmsac_vv_h, OP_UUU_H, H2, H2, H2, fnmsac16)
 RVVCALL(OPFVV3, vfnmsac_vv_w, OP_UUU_W, H4, H4, H4, fnmsac32)
 RVVCALL(OPFVV3, vfnmsac_vv_d, OP_UUU_D, H8, H8, H8, fnmsac64)
+GEN_VEXT_VV_ENV(vfnmsac_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfnmsac_vv_h, 2)
 GEN_VEXT_VV_ENV(vfnmsac_vv_w, 4)
 GEN_VEXT_VV_ENV(vfnmsac_vv_d, 8)
+RVVCALL(OPFVF3, vfnmsac_vf_h_bf16, OP_UUU_H, H2, H2, fnmsac16_bf16)
 RVVCALL(OPFVF3, vfnmsac_vf_h, OP_UUU_H, H2, H2, fnmsac16)
 RVVCALL(OPFVF3, vfnmsac_vf_w, OP_UUU_W, H4, H4, fnmsac32)
 RVVCALL(OPFVF3, vfnmsac_vf_d, OP_UUU_D, H8, H8, fnmsac64)
+GEN_VEXT_VF(vfnmsac_vf_h_bf16, 2)
 GEN_VEXT_VF(vfnmsac_vf_h, 2)
 GEN_VEXT_VF(vfnmsac_vf_w, 4)
 GEN_VEXT_VF(vfnmsac_vf_d, 8)
 
+static uint16_t fmadd16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                             float_status *s)
+{
+    return bfloat16_muladd(d, b, a, 0, s);
+}
+
 static uint16_t fmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, 0, s);
@@ -3558,19 +3673,30 @@ static uint64_t fmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
     return float64_muladd(d, b, a, 0, s);
 }
 
+RVVCALL(OPFVV3, vfmadd_vv_h_bf16, OP_UUU_H, H2, H2, H2, fmadd16_bf16)
 RVVCALL(OPFVV3, vfmadd_vv_h, OP_UUU_H, H2, H2, H2, fmadd16)
 RVVCALL(OPFVV3, vfmadd_vv_w, OP_UUU_W, H4, H4, H4, fmadd32)
 RVVCALL(OPFVV3, vfmadd_vv_d, OP_UUU_D, H8, H8, H8, fmadd64)
+GEN_VEXT_VV_ENV(vfmadd_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmadd_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmadd_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmadd_vv_d, 8)
+RVVCALL(OPFVF3, vfmadd_vf_h_bf16, OP_UUU_H, H2, H2, fmadd16_bf16)
 RVVCALL(OPFVF3, vfmadd_vf_h, OP_UUU_H, H2, H2, fmadd16)
 RVVCALL(OPFVF3, vfmadd_vf_w, OP_UUU_W, H4, H4, fmadd32)
 RVVCALL(OPFVF3, vfmadd_vf_d, OP_UUU_D, H8, H8, fmadd64)
+GEN_VEXT_VF(vfmadd_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmadd_vf_h, 2)
 GEN_VEXT_VF(vfmadd_vf_w, 4)
 GEN_VEXT_VF(vfmadd_vf_d, 8)
 
+static uint16_t fnmadd16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                              float_status *s)
+{
+    return bfloat16_muladd(d, b, a, float_muladd_negate_c |
+                                    float_muladd_negate_product, s);
+}
+
 static uint16_t fnmadd16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, float_muladd_negate_c |
@@ -3589,19 +3715,29 @@ static uint64_t fnmadd64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
                                    float_muladd_negate_product, s);
 }
 
+RVVCALL(OPFVV3, vfnmadd_vv_h_bf16, OP_UUU_H, H2, H2, H2, fnmadd16_bf16)
 RVVCALL(OPFVV3, vfnmadd_vv_h, OP_UUU_H, H2, H2, H2, fnmadd16)
 RVVCALL(OPFVV3, vfnmadd_vv_w, OP_UUU_W, H4, H4, H4, fnmadd32)
 RVVCALL(OPFVV3, vfnmadd_vv_d, OP_UUU_D, H8, H8, H8, fnmadd64)
+GEN_VEXT_VV_ENV(vfnmadd_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfnmadd_vv_h, 2)
 GEN_VEXT_VV_ENV(vfnmadd_vv_w, 4)
 GEN_VEXT_VV_ENV(vfnmadd_vv_d, 8)
+RVVCALL(OPFVF3, vfnmadd_vf_h_bf16, OP_UUU_H, H2, H2, fnmadd16_bf16)
 RVVCALL(OPFVF3, vfnmadd_vf_h, OP_UUU_H, H2, H2, fnmadd16)
 RVVCALL(OPFVF3, vfnmadd_vf_w, OP_UUU_W, H4, H4, fnmadd32)
 RVVCALL(OPFVF3, vfnmadd_vf_d, OP_UUU_D, H8, H8, fnmadd64)
+GEN_VEXT_VF(vfnmadd_vf_h_bf16, 2)
 GEN_VEXT_VF(vfnmadd_vf_h, 2)
 GEN_VEXT_VF(vfnmadd_vf_w, 4)
 GEN_VEXT_VF(vfnmadd_vf_d, 8)
 
+static uint16_t fmsub16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                             float_status *s)
+{
+    return bfloat16_muladd(d, b, a, float_muladd_negate_c, s);
+}
+
 static uint16_t fmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, float_muladd_negate_c, s);
@@ -3617,19 +3753,29 @@ static uint64_t fmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
     return float64_muladd(d, b, a, float_muladd_negate_c, s);
 }
 
+RVVCALL(OPFVV3, vfmsub_vv_h_bf16, OP_UUU_H, H2, H2, H2, fmsub16_bf16)
 RVVCALL(OPFVV3, vfmsub_vv_h, OP_UUU_H, H2, H2, H2, fmsub16)
 RVVCALL(OPFVV3, vfmsub_vv_w, OP_UUU_W, H4, H4, H4, fmsub32)
 RVVCALL(OPFVV3, vfmsub_vv_d, OP_UUU_D, H8, H8, H8, fmsub64)
+GEN_VEXT_VV_ENV(vfmsub_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmsub_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmsub_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmsub_vv_d, 8)
+RVVCALL(OPFVF3, vfmsub_vf_h_bf16, OP_UUU_H, H2, H2, fmsub16_bf16)
 RVVCALL(OPFVF3, vfmsub_vf_h, OP_UUU_H, H2, H2, fmsub16)
 RVVCALL(OPFVF3, vfmsub_vf_w, OP_UUU_W, H4, H4, fmsub32)
 RVVCALL(OPFVF3, vfmsub_vf_d, OP_UUU_D, H8, H8, fmsub64)
+GEN_VEXT_VF(vfmsub_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmsub_vf_h, 2)
 GEN_VEXT_VF(vfmsub_vf_w, 4)
 GEN_VEXT_VF(vfmsub_vf_d, 8)
 
+static uint16_t fnmsub16_bf16(uint16_t a, uint16_t b, uint16_t d,
+                              float_status *s)
+{
+    return bfloat16_muladd(d, b, a, float_muladd_negate_product, s);
+}
+
 static uint16_t fnmsub16(uint16_t a, uint16_t b, uint16_t d, float_status *s)
 {
     return float16_muladd(d, b, a, float_muladd_negate_product, s);
@@ -3645,15 +3791,19 @@ static uint64_t fnmsub64(uint64_t a, uint64_t b, uint64_t d, float_status *s)
     return float64_muladd(d, b, a, float_muladd_negate_product, s);
 }
 
+RVVCALL(OPFVV3, vfnmsub_vv_h_bf16, OP_UUU_H, H2, H2, H2, fnmsub16_bf16)
 RVVCALL(OPFVV3, vfnmsub_vv_h, OP_UUU_H, H2, H2, H2, fnmsub16)
 RVVCALL(OPFVV3, vfnmsub_vv_w, OP_UUU_W, H4, H4, H4, fnmsub32)
 RVVCALL(OPFVV3, vfnmsub_vv_d, OP_UUU_D, H8, H8, H8, fnmsub64)
+GEN_VEXT_VV_ENV(vfnmsub_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfnmsub_vv_h, 2)
 GEN_VEXT_VV_ENV(vfnmsub_vv_w, 4)
 GEN_VEXT_VV_ENV(vfnmsub_vv_d, 8)
+RVVCALL(OPFVF3, vfnmsub_vf_h_bf16, OP_UUU_H, H2, H2, fnmsub16_bf16)
 RVVCALL(OPFVF3, vfnmsub_vf_h, OP_UUU_H, H2, H2, fnmsub16)
 RVVCALL(OPFVF3, vfnmsub_vf_w, OP_UUU_W, H4, H4, fnmsub32)
 RVVCALL(OPFVF3, vfnmsub_vf_d, OP_UUU_D, H8, H8, fnmsub64)
+GEN_VEXT_VF(vfnmsub_vf_h_bf16, 2)
 GEN_VEXT_VF(vfnmsub_vf_h, 2)
 GEN_VEXT_VF(vfnmsub_vf_w, 4)
 GEN_VEXT_VF(vfnmsub_vf_d, 8)
@@ -3691,6 +3841,15 @@ GEN_VEXT_VV_ENV(vfwmaccbf16_vv, 4)
 RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmaccbf16)
 GEN_VEXT_VF(vfwmaccbf16_vf, 4)
 
+static uint32_t fwnmacc16_bf16(uint16_t a, uint16_t b, uint32_t d,
+                               float_status *s)
+{
+    return float32_muladd(bfloat16_to_float32(a, s),
+                          bfloat16_to_float32(b, s), d,
+                          float_muladd_negate_c | float_muladd_negate_product,
+                          s);
+}
+
 static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
@@ -3706,15 +3865,27 @@ static uint64_t fwnmacc32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
                              float_muladd_negate_product, s);
 }
 
+RVVCALL(OPFVV3, vfwnmacc_vv_h_bf16, WOP_UUU_H, H4, H2, H2, fwnmacc16_bf16)
 RVVCALL(OPFVV3, vfwnmacc_vv_h, WOP_UUU_H, H4, H2, H2, fwnmacc16)
 RVVCALL(OPFVV3, vfwnmacc_vv_w, WOP_UUU_W, H8, H4, H4, fwnmacc32)
+GEN_VEXT_VV_ENV(vfwnmacc_vv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwnmacc_vv_h, 4)
 GEN_VEXT_VV_ENV(vfwnmacc_vv_w, 8)
+RVVCALL(OPFVF3, vfwnmacc_vf_h_bf16, WOP_UUU_H, H4, H2, fwnmacc16_bf16)
 RVVCALL(OPFVF3, vfwnmacc_vf_h, WOP_UUU_H, H4, H2, fwnmacc16)
 RVVCALL(OPFVF3, vfwnmacc_vf_w, WOP_UUU_W, H8, H4, fwnmacc32)
+GEN_VEXT_VF(vfwnmacc_vf_h_bf16, 4)
 GEN_VEXT_VF(vfwnmacc_vf_h, 4)
 GEN_VEXT_VF(vfwnmacc_vf_w, 8)
 
+static uint32_t fwmsac16_bf16(uint16_t a, uint16_t b, uint32_t d,
+                              float_status *s)
+{
+    return float32_muladd(bfloat16_to_float32(a, s),
+                          bfloat16_to_float32(b, s), d,
+                          float_muladd_negate_c, s);
+}
+
 static uint32_t fwmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
@@ -3729,15 +3900,27 @@ static uint64_t fwmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
                           float_muladd_negate_c, s);
 }
 
+RVVCALL(OPFVV3, vfwmsac_vv_h_bf16, WOP_UUU_H, H4, H2, H2, fwmsac16_bf16)
 RVVCALL(OPFVV3, vfwmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwmsac16)
 RVVCALL(OPFVV3, vfwmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwmsac32)
+GEN_VEXT_VV_ENV(vfwmsac_vv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwmsac_vv_h, 4)
 GEN_VEXT_VV_ENV(vfwmsac_vv_w, 8)
+RVVCALL(OPFVF3, vfwmsac_vf_h_bf16, WOP_UUU_H, H4, H2, fwmsac16_bf16)
 RVVCALL(OPFVF3, vfwmsac_vf_h, WOP_UUU_H, H4, H2, fwmsac16)
 RVVCALL(OPFVF3, vfwmsac_vf_w, WOP_UUU_W, H8, H4, fwmsac32)
+GEN_VEXT_VF(vfwmsac_vf_h_bf16, 4)
 GEN_VEXT_VF(vfwmsac_vf_h, 4)
 GEN_VEXT_VF(vfwmsac_vf_w, 8)
 
+static uint32_t fwnmsac16_bf16(uint16_t a, uint16_t b, uint32_t d,
+                               float_status *s)
+{
+    return float32_muladd(bfloat16_to_float32(a, s),
+                          bfloat16_to_float32(b, s), d,
+                          float_muladd_negate_product, s);
+}
+
 static uint32_t fwnmsac16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
 {
     return float32_muladd(float16_to_float32(a, true, s),
@@ -3752,12 +3935,16 @@ static uint64_t fwnmsac32(uint32_t a, uint32_t b, uint64_t d, float_status *s)
                           float_muladd_negate_product, s);
 }
 
+RVVCALL(OPFVV3, vfwnmsac_vv_h_bf16, WOP_UUU_H, H4, H2, H2, fwnmsac16_bf16)
 RVVCALL(OPFVV3, vfwnmsac_vv_h, WOP_UUU_H, H4, H2, H2, fwnmsac16)
 RVVCALL(OPFVV3, vfwnmsac_vv_w, WOP_UUU_W, H8, H4, H4, fwnmsac32)
+GEN_VEXT_VV_ENV(vfwnmsac_vv_h_bf16, 4)
 GEN_VEXT_VV_ENV(vfwnmsac_vv_h, 4)
 GEN_VEXT_VV_ENV(vfwnmsac_vv_w, 8)
+RVVCALL(OPFVF3, vfwnmsac_vf_h_bf16, WOP_UUU_H, H4, H2, fwnmsac16_bf16)
 RVVCALL(OPFVF3, vfwnmsac_vf_h, WOP_UUU_H, H4, H2, fwnmsac16)
 RVVCALL(OPFVF3, vfwnmsac_vf_w, WOP_UUU_W, H8, H4, fwnmsac32)
+GEN_VEXT_VF(vfwnmsac_vf_h_bf16, 4)
 GEN_VEXT_VF(vfwnmsac_vf_h, 4)
 GEN_VEXT_VF(vfwnmsac_vf_w, 8)
 
@@ -3863,6 +4050,46 @@ static uint64_t frsqrt7(uint64_t f, int exp_size, int frac_size)
     return val;
 }
 
+static bfloat16 frsqrt7_h_bf16(bfloat16 f, float_status *s)
+{
+    int exp_size = 8, frac_size = 7;
+    bool sign = bfloat16_is_neg(f);
+
+    /*
+     * frsqrt7(sNaN) = canonical NaN
+     * frsqrt7(-inf) = canonical NaN
+     * frsqrt7(-normal) = canonical NaN
+     * frsqrt7(-subnormal) = canonical NaN
+     */
+    if (bfloat16_is_signaling_nan(f, s) ||
+        (bfloat16_is_infinity(f) && sign) ||
+        (bfloat16_is_normal(f) && sign) ||
+        (bfloat16_is_zero_or_denormal(f) && !bfloat16_is_zero(f) && sign)) {
+        s->float_exception_flags |= float_flag_invalid;
+        return bfloat16_default_nan(s);
+    }
+
+    /* frsqrt7(qNaN) = canonical NaN */
+    if (bfloat16_is_quiet_nan(f, s)) {
+        return bfloat16_default_nan(s);
+    }
+
+    /* frsqrt7(+-0) = +-inf */
+    if (bfloat16_is_zero(f)) {
+        s->float_exception_flags |= float_flag_divbyzero;
+        return bfloat16_set_sign(bfloat16_infinity, sign);
+    }
+
+    /* frsqrt7(+inf) = +0 */
+    if (bfloat16_is_infinity(f) && !sign) {
+        return bfloat16_set_sign(bfloat16_zero, sign);
+    }
+
+    /* +normal, +subnormal */
+    uint64_t val = frsqrt7(f, exp_size, frac_size);
+    return make_float16(val);
+}
+
 static float16 frsqrt7_h(float16 f, float_status *s)
 {
     int exp_size = 5, frac_size = 10;
@@ -3983,9 +4210,11 @@ static float64 frsqrt7_d(float64 f, float_status *s)
     return make_float64(val);
 }
 
+RVVCALL(OPFVV1, vfrsqrt7_v_h_bf16, OP_UU_H, H2, H2, frsqrt7_h_bf16)
 RVVCALL(OPFVV1, vfrsqrt7_v_h, OP_UU_H, H2, H2, frsqrt7_h)
 RVVCALL(OPFVV1, vfrsqrt7_v_w, OP_UU_W, H4, H4, frsqrt7_s)
 RVVCALL(OPFVV1, vfrsqrt7_v_d, OP_UU_D, H8, H8, frsqrt7_d)
+GEN_VEXT_V_ENV(vfrsqrt7_v_h_bf16, 2)
 GEN_VEXT_V_ENV(vfrsqrt7_v_h, 2)
 GEN_VEXT_V_ENV(vfrsqrt7_v_w, 4)
 GEN_VEXT_V_ENV(vfrsqrt7_v_d, 8)
@@ -4078,6 +4307,38 @@ static uint64_t frec7(uint64_t f, int exp_size, int frac_size,
     return val;
 }
 
+static bfloat16 frec7_h_bf16(bfloat16 f, float_status *s)
+{
+    int exp_size = 8, frac_size = 7;
+    bool sign = bfloat16_is_neg(f);
+
+    /* frec7(+-inf) = +-0 */
+    if (bfloat16_is_infinity(f)) {
+        return bfloat16_set_sign(bfloat16_zero, sign);
+    }
+
+    /* frec7(+-0) = +-inf */
+    if (bfloat16_is_zero(f)) {
+        s->float_exception_flags |= float_flag_divbyzero;
+        return bfloat16_set_sign(bfloat16_infinity, sign);
+    }
+
+    /* frec7(sNaN) = canonical NaN */
+    if (bfloat16_is_signaling_nan(f, s)) {
+        s->float_exception_flags |= float_flag_invalid;
+        return bfloat16_default_nan(s);
+    }
+
+    /* frec7(qNaN) = canonical NaN */
+    if (bfloat16_is_quiet_nan(f, s)) {
+        return bfloat16_default_nan(s);
+    }
+
+    /* +-normal, +-subnormal */
+    uint64_t val = frec7(f, exp_size, frac_size, s);
+    return make_float16(val);
+}
+
 static float16 frec7_h(float16 f, float_status *s)
 {
     int exp_size = 5, frac_size = 10;
@@ -4174,36 +4435,46 @@ static float64 frec7_d(float64 f, float_status *s)
     return make_float64(val);
 }
 
+RVVCALL(OPFVV1, vfrec7_v_h_bf16, OP_UU_H, H2, H2, frec7_h_bf16)
 RVVCALL(OPFVV1, vfrec7_v_h, OP_UU_H, H2, H2, frec7_h)
 RVVCALL(OPFVV1, vfrec7_v_w, OP_UU_W, H4, H4, frec7_s)
 RVVCALL(OPFVV1, vfrec7_v_d, OP_UU_D, H8, H8, frec7_d)
+GEN_VEXT_V_ENV(vfrec7_v_h_bf16, 2)
 GEN_VEXT_V_ENV(vfrec7_v_h, 2)
 GEN_VEXT_V_ENV(vfrec7_v_w, 4)
 GEN_VEXT_V_ENV(vfrec7_v_d, 8)
 
 /* Vector Floating-Point MIN/MAX Instructions */
+RVVCALL(OPFVV2, vfmin_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_minimum_number)
 RVVCALL(OPFVV2, vfmin_vv_h, OP_UUU_H, H2, H2, H2, float16_minimum_number)
 RVVCALL(OPFVV2, vfmin_vv_w, OP_UUU_W, H4, H4, H4, float32_minimum_number)
 RVVCALL(OPFVV2, vfmin_vv_d, OP_UUU_D, H8, H8, H8, float64_minimum_number)
+GEN_VEXT_VV_ENV(vfmin_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmin_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmin_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmin_vv_d, 8)
+RVVCALL(OPFVF2, vfmin_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_minimum_number)
 RVVCALL(OPFVF2, vfmin_vf_h, OP_UUU_H, H2, H2, float16_minimum_number)
 RVVCALL(OPFVF2, vfmin_vf_w, OP_UUU_W, H4, H4, float32_minimum_number)
 RVVCALL(OPFVF2, vfmin_vf_d, OP_UUU_D, H8, H8, float64_minimum_number)
+GEN_VEXT_VF(vfmin_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmin_vf_h, 2)
 GEN_VEXT_VF(vfmin_vf_w, 4)
 GEN_VEXT_VF(vfmin_vf_d, 8)
 
+RVVCALL(OPFVV2, vfmax_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_maximum_number)
 RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_maximum_number)
 RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_maximum_number)
 RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_maximum_number)
+GEN_VEXT_VV_ENV(vfmax_vv_h_bf16, 2)
 GEN_VEXT_VV_ENV(vfmax_vv_h, 2)
 GEN_VEXT_VV_ENV(vfmax_vv_w, 4)
 GEN_VEXT_VV_ENV(vfmax_vv_d, 8)
+RVVCALL(OPFVF2, vfmax_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_maximum_number)
 RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_maximum_number)
 RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_maximum_number)
 RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_maximum_number)
+GEN_VEXT_VF(vfmax_vf_h_bf16, 2)
 GEN_VEXT_VF(vfmax_vf_h, 2)
 GEN_VEXT_VF(vfmax_vf_w, 4)
 GEN_VEXT_VF(vfmax_vf_d, 8)
@@ -4332,6 +4603,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     }                                                         \
 }
 
+GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h_bf16, uint16_t, H2, bfloat16_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
@@ -4373,10 +4645,17 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     }                                                               \
 }
 
+GEN_VEXT_CMP_VF(vmfeq_vf_h_bf16, uint16_t, H2, bfloat16_eq_quiet)
 GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
 GEN_VEXT_CMP_VF(vmfeq_vf_w, uint32_t, H4, float32_eq_quiet)
 GEN_VEXT_CMP_VF(vmfeq_vf_d, uint64_t, H8, float64_eq_quiet)
 
+static bool vmfne16_bf16(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = bfloat16_compare_quiet(a, b, s);
+    return compare != float_relation_equal;
+}
+
 static bool vmfne16(uint16_t a, uint16_t b, float_status *s)
 {
     FloatRelation compare = float16_compare_quiet(a, b, s);
@@ -4395,27 +4674,39 @@ static bool vmfne64(uint64_t a, uint64_t b, float_status *s)
     return compare != float_relation_equal;
 }
 
+GEN_VEXT_CMP_VV_ENV(vmfne_vv_h_bf16, uint16_t, H2, vmfne16_bf16)
 GEN_VEXT_CMP_VV_ENV(vmfne_vv_h, uint16_t, H2, vmfne16)
 GEN_VEXT_CMP_VV_ENV(vmfne_vv_w, uint32_t, H4, vmfne32)
 GEN_VEXT_CMP_VV_ENV(vmfne_vv_d, uint64_t, H8, vmfne64)
+GEN_VEXT_CMP_VF(vmfne_vf_h_bf16, uint16_t, H2, vmfne16_bf16)
 GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
 GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
 GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
 
+GEN_VEXT_CMP_VV_ENV(vmflt_vv_h_bf16, uint16_t, H2, bfloat16_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
+GEN_VEXT_CMP_VF(vmflt_vf_h_bf16, uint16_t, H2, bfloat16_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
 GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
 
+GEN_VEXT_CMP_VV_ENV(vmfle_vv_h_bf16, uint16_t, H2, bfloat16_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
 GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
+GEN_VEXT_CMP_VF(vmfle_vf_h_bf16, uint16_t, H2, bfloat16_le)
 GEN_VEXT_CMP_VF(vmfle_vf_h, uint16_t, H2, float16_le)
 GEN_VEXT_CMP_VF(vmfle_vf_w, uint32_t, H4, float32_le)
 GEN_VEXT_CMP_VF(vmfle_vf_d, uint64_t, H8, float64_le)
 
+static bool vmfgt16_bf16(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = bfloat16_compare(a, b, s);
+    return compare == float_relation_greater;
+}
+
 static bool vmfgt16(uint16_t a, uint16_t b, float_status *s)
 {
     FloatRelation compare = float16_compare(a, b, s);
@@ -4434,10 +4725,18 @@ static bool vmfgt64(uint64_t a, uint64_t b, float_status *s)
     return compare == float_relation_greater;
 }
 
+GEN_VEXT_CMP_VF(vmfgt_vf_h_bf16, uint16_t, H2, vmfgt16_bf16)
 GEN_VEXT_CMP_VF(vmfgt_vf_h, uint16_t, H2, vmfgt16)
 GEN_VEXT_CMP_VF(vmfgt_vf_w, uint32_t, H4, vmfgt32)
 GEN_VEXT_CMP_VF(vmfgt_vf_d, uint64_t, H8, vmfgt64)
 
+static bool vmfge16_bf16(uint16_t a, uint16_t b, float_status *s)
+{
+    FloatRelation compare = bfloat16_compare(a, b, s);
+    return compare == float_relation_greater ||
+           compare == float_relation_equal;
+}
+
 static bool vmfge16(uint16_t a, uint16_t b, float_status *s)
 {
     FloatRelation compare = float16_compare(a, b, s);
@@ -4459,11 +4758,31 @@ static bool vmfge64(uint64_t a, uint64_t b, float_status *s)
            compare == float_relation_equal;
 }
 
+GEN_VEXT_CMP_VF(vmfge_vf_h_bf16, uint16_t, H2, vmfge16_bf16)
 GEN_VEXT_CMP_VF(vmfge_vf_h, uint16_t, H2, vmfge16)
 GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
 GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
 
 /* Vector Floating-Point Classify Instruction */
+target_ulong fclass_h_bf16(uint64_t frs1)
+{
+    bfloat16 f = frs1;
+    bool sign = bfloat16_is_neg(f);
+
+    if (bfloat16_is_infinity(f)) {
+        return sign ? 1 << 0 : 1 << 7;
+    } else if (bfloat16_is_zero(f)) {
+        return sign ? 1 << 3 : 1 << 4;
+    } else if (bfloat16_is_zero_or_denormal(f)) {
+        return sign ? 1 << 2 : 1 << 5;
+    } else if (bfloat16_is_any_nan(f)) {
+        float_status s = { }; /* for snan_bit_is_one */
+        return bfloat16_is_quiet_nan(f, &s) ? 1 << 9 : 1 << 8;
+    } else {
+        return sign ? 1 << 1 : 1 << 6;
+    }
+}
+
 target_ulong fclass_h(uint64_t frs1)
 {
     float16 f = frs1;
@@ -4521,9 +4840,11 @@ target_ulong fclass_d(uint64_t frs1)
     }
 }
 
+RVVCALL(OPIVV1, vfclass_v_h_bf16, OP_UU_H, H2, H2, fclass_h_bf16)
 RVVCALL(OPIVV1, vfclass_v_h, OP_UU_H, H2, H2, fclass_h)
 RVVCALL(OPIVV1, vfclass_v_w, OP_UU_W, H4, H4, fclass_s)
 RVVCALL(OPIVV1, vfclass_v_d, OP_UU_D, H8, H8, fclass_d)
+GEN_VEXT_V(vfclass_v_h_bf16, 2)
 GEN_VEXT_V(vfclass_v_h, 2)
 GEN_VEXT_V(vfclass_v_w, 4)
 GEN_VEXT_V(vfclass_v_d, 8)
@@ -4614,17 +4935,21 @@ GEN_VEXT_V_ENV(vfwcvt_x_f_v_w, 8)
  * vfwcvt.f.xu.v vd, vs2, vm # Convert unsigned integer to double-width float.
  */
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_b, WOP_UU_B, H2, H1, uint8_to_float16)
+RVVCALL(OPFVV1, vfwcvt_f_xu_v_b_bf16, WOP_UU_B, H2, H1, uint8_to_bfloat16)
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_h, WOP_UU_H, H4, H2, uint16_to_float32)
 RVVCALL(OPFVV1, vfwcvt_f_xu_v_w, WOP_UU_W, H8, H4, uint32_to_float64)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_b, 2)
+GEN_VEXT_V_ENV(vfwcvt_f_xu_v_b_bf16, 2)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_h, 4)
 GEN_VEXT_V_ENV(vfwcvt_f_xu_v_w, 8)
 
 /* vfwcvt.f.x.v vd, vs2, vm # Convert integer to double-width float. */
 RVVCALL(OPFVV1, vfwcvt_f_x_v_b, WOP_UU_B, H2, H1, int8_to_float16)
+RVVCALL(OPFVV1, vfwcvt_f_x_v_b_bf16, WOP_UU_B, H2, H1, int8_to_bfloat16)
 RVVCALL(OPFVV1, vfwcvt_f_x_v_h, WOP_UU_H, H4, H2, int16_to_float32)
 RVVCALL(OPFVV1, vfwcvt_f_x_v_w, WOP_UU_W, H8, H4, int32_to_float64)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_b, 2)
+GEN_VEXT_V_ENV(vfwcvt_f_x_v_b_bf16, 2)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_h, 4)
 GEN_VEXT_V_ENV(vfwcvt_f_x_v_w, 8)
 
@@ -4651,17 +4976,21 @@ GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v, 4)
 #define NOP_UU_W uint32_t, uint64_t, uint64_t
 /* vfncvt.xu.f.v vd, vs2, vm # Convert float to unsigned integer. */
 RVVCALL(OPFVV1, vfncvt_xu_f_w_b, NOP_UU_B, H1, H2, float16_to_uint8)
+RVVCALL(OPFVV1, vfncvt_xu_f_w_b_bf16, NOP_UU_B, H1, H2, bfloat16_to_uint8)
 RVVCALL(OPFVV1, vfncvt_xu_f_w_h, NOP_UU_H, H2, H4, float32_to_uint16)
 RVVCALL(OPFVV1, vfncvt_xu_f_w_w, NOP_UU_W, H4, H8, float64_to_uint32)
 GEN_VEXT_V_ENV(vfncvt_xu_f_w_b, 1)
+GEN_VEXT_V_ENV(vfncvt_xu_f_w_b_bf16, 1)
 GEN_VEXT_V_ENV(vfncvt_xu_f_w_h, 2)
 GEN_VEXT_V_ENV(vfncvt_xu_f_w_w, 4)
 
 /* vfncvt.x.f.v vd, vs2, vm # Convert double-width float to signed integer. */
 RVVCALL(OPFVV1, vfncvt_x_f_w_b, NOP_UU_B, H1, H2, float16_to_int8)
+RVVCALL(OPFVV1, vfncvt_x_f_w_b_bf16, NOP_UU_B, H1, H2, bfloat16_to_int8)
 RVVCALL(OPFVV1, vfncvt_x_f_w_h, NOP_UU_H, H2, H4, float32_to_int16)
 RVVCALL(OPFVV1, vfncvt_x_f_w_w, NOP_UU_W, H4, H8, float64_to_int32)
 GEN_VEXT_V_ENV(vfncvt_x_f_w_b, 1)
+GEN_VEXT_V_ENV(vfncvt_x_f_w_b_bf16, 1)
 GEN_VEXT_V_ENV(vfncvt_x_f_w_h, 2)
 GEN_VEXT_V_ENV(vfncvt_x_f_w_w, 4)
 
-- 
2.43.0


