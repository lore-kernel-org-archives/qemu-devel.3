Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE654E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 12:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLMCF-0003JT-II; Wed, 11 Dec 2024 07:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLMBm-00035m-2H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:51:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLMBj-0001sR-RX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 07:51:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd730so2714945e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 04:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1733921493; x=1734526293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Y7B5PzMIQAYWoZxCx+iKjiN9AyJgktzWgwoHucsn1I=;
 b=Kt/s/BvTqj10g8H5ynLwe5k12VxJ8hBP5otmZ8Bt0dCC+74Mf5Id+HdywWBKTgtr7/
 QZlJyFCXCSA7beiHp71K9zZqCy7Zfstn0353fGwcT4MFxocsfGCtGvXAofAHMNAJtYR6
 kCOwtlWhNMGmceE0oV+pKdC5eu2hap+UHhoYvGYabBXwSMrFkYX5LCcICMNa0EwceYpB
 MIQTf52ZXMkw4WsdR/lhtwdffWK5tb4we3Bgo4PtXb56v0aMmccYgSQM/Mro+dcFhPYH
 sZi1nkd5zlZ+sgMcGg/39uBQdlIYpO17m26v0NvCuxWtI3TFfu1YVl2qUyr4O3rsVHJn
 nXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733921493; x=1734526293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Y7B5PzMIQAYWoZxCx+iKjiN9AyJgktzWgwoHucsn1I=;
 b=BaQeg/KaOgHybBp0eloJDYlcLaYOlu957pBCKTypPPquEQZENMjt3zExOvO3vIHmU7
 4vBlDV9s1xbXvQN9ASMMjp2BMsQ+7gh8CZOBE4Ccc10sbUsmgeEAsaxbqh+6PghsMXAY
 RFL0qTuLDwcl9PJ/D88gwyTF5q28Yw8mf+cSbNeMhqHf0GW6/jXjDI9gpv35XhGhr5bY
 W2/HCEzw9O8YrWL/fFhsFuoeBtGj2w3oMZsdrFEdfATu5oA29J9vqcSTPp9vFuP/ZNzR
 g5+rtYPB51cYqvuulpoheBgnqgfzfiDub2ytn+1jYvjFeGE5MrRJQUVx+gKX4ksZpXKL
 ClGQ==
X-Gm-Message-State: AOJu0Yzs3bB/6VDwhpBGWkL8NF9UrzQw2Q8k3M0o9N8Fo1qKTzLGl3be
 fTK1eTjWYj27f9UUP31yD2mA5SxPNsuU3PDILk/a0RtQKHhoUdEzVHelAP6ruaOIJRfa6lh3C1h
 4YNs=
X-Gm-Gg: ASbGnctZB4vytFdie9syk2TGu7YYlT0IPhoaMwsLxEoSbgKICjzBu0IKAqmLjl49ltm
 kod2qltZY3mZRvMcaU6RFFd++nkuLIppFBtUrsYsGt87Y8LNArKOrjJ/p/rAQDhsKLyg4FK9Pz9
 z2Ltju0PgljOkb54OT/BVUH+ALbsEJjtJrecEPeYeVBKkMbziG4nsCB1OxC7tTyssRj5JMXX2kQ
 tpTAnUYoMyJoSlRoywBJ/9FqWltVLMrUmu9NGVnr4Uq7Jv2o4xhwaUSkxslWImAlrP1EBWEXyHK
 s+YBvTlY7aw7VN3GrbebydQ7kk2UR1eNFFjc02XerfpMZA==
X-Google-Smtp-Source: AGHT+IGSV22Sp0UpqWCivzYJ62N2BPIj4wQob2CB2Jl0h9W1M3qrvolGrTFj0/F+M1q9eLaLKjmA2w==
X-Received: by 2002:a05:600c:1c1c:b0:436:1c0c:bfb6 with SMTP id
 5b1f17b1804b1-4361c43ca9bmr18253475e9.27.1733921492774; 
 Wed, 11 Dec 2024 04:51:32 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f44eaac7sm120542125e9.42.2024.12.11.04.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:51:32 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
Subject: [PATCH v7 1/2] target/riscv: rvv: fix typo in vext continuous ldst
 function names
Date: Wed, 11 Dec 2024 12:51:12 +0000
Message-ID: <20241211125113.583902-2-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211125113.583902-1-craig.blackmore@embecosm.com>
References: <20241211125113.583902-1-craig.blackmore@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x32c.google.com
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

Replace `continus` with `continuous`.

Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
---
 target/riscv/vector_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a85dd1d200..0f57e48cc5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -195,7 +195,7 @@ GEN_VEXT_ST_ELEM(ste_w, uint32_t, H4, stl)
 GEN_VEXT_ST_ELEM(ste_d, uint64_t, H8, stq)
 
 static inline QEMU_ALWAYS_INLINE void
-vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
+vext_continuous_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
                        void *vd, uint32_t evl, target_ulong addr,
                        uint32_t reg_start, uintptr_t ra, uint32_t esz,
                        bool is_load)
@@ -207,7 +207,7 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
 }
 
 static inline QEMU_ALWAYS_INLINE void
-vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
+vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
                         uint32_t esz, bool is_load)
 {
@@ -342,8 +342,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
 
     if (flags == 0) {
         if (nf == 1) {
-            vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
-                                    esz, is_load);
+            vext_continuous_ldst_host(env, ldst_host, vd, evl, env->vstart,
+                                      host, esz, is_load);
         } else {
             for (i = env->vstart; i < evl; ++i) {
                 k = 0;
@@ -357,7 +357,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
         env->vstart += elems;
     } else {
         if (nf == 1) {
-            vext_continus_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
+            vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart,
                                    ra, esz, is_load);
         } else {
             /* load bytes from guest memory */
-- 
2.43.0


