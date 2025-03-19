Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD41C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoPd-0000CH-IG; Wed, 19 Mar 2025 04:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOy-00083U-PS
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:49 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tuoOw-0004SB-SV
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:03:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22423adf751so115157535ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742371424; x=1742976224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nk46gytbFxIUMtZF+osZ4hsSwJ+YwCe1y9MoyWvsXsY=;
 b=NerZnh3mV/Z/U43RFw2wHFushHzTUlbGoqnpm/4fGDVkzpS6LfLqs0lXzMZZVGi1Jy
 ZWakA5sMZH5Q3IpQEsWneBNrc5u0mIFjkxgtkLyR8nEoyP87nnuI00xVcuVObrwFNqJ5
 n0bk36sDBOL1ZKF4EV7/CEyKufJhQ5kkZIywkwFO+SUx0qWWkhCwvOIxmNwturH5xykq
 UvkubGEeR5Sx5xDBhjAUCI/JfVnM0oJxsPS/V49gB+UaxrW+V/ijGUgJ9zRYqIrLnXba
 hrGeknjzhoUaXC9svtLOqndCTzYcly2AV+M9NTFJqqJW1bkF3QFR8a15XPhZAh3qJ1kd
 PL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742371424; x=1742976224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nk46gytbFxIUMtZF+osZ4hsSwJ+YwCe1y9MoyWvsXsY=;
 b=vzDuUxOmZKXdj3mEIH81RblYwlFoNzy61Z5DfLmdy4pq0lsYH/gq9WBeglE9Hc65nT
 TPpE6XpckgwmocI12TBDyCrDio7QM9I1Khmos7di67dMgIFuFBZYDHdFZKa4I1fu7qAA
 W3F8KL9QYzgbrPX7VvHnc2mk7fTygng3+H8pqTHZQZTDoYuC1YzvGz5w2JKv1hvXLaA5
 jGLoCHkAgQ2+M1X8rheghSwqzpe26cO8/r1pVS8EYe9ec9b5P5Sarkh76aCJ5ZDk4bQo
 pg7AOlYhwASgHUVrMOceNahTvO9O/FLuAsRpB+3OjpZLBabgsy7bk15KPWt4IP8f0c7Q
 IwMw==
X-Gm-Message-State: AOJu0YxeUWGxWrNxJN4MY9xYfNOApVPvw2kYujuqYGPAsQglznT8FKkG
 qKJjs+E9+u/suE+t3f2gtsnNN5oUtnkfi4uWxV+6SddVh1m2nqzIhFbeOQ==
X-Gm-Gg: ASbGncud+g0veMbuuM3oGoekhZW7ZEnYXr7N70lZ0PNnqp5y2IsUeK+i0InvZIZWmfj
 zEcHEf3WugtGjQXEayH9dl9mZmZoXIePF/dHLLhKFKHqqH8p08SSWrHgDguJcfMUU3FF5mUCS1M
 LKcp/iE36BApplglDb7VgKY3L+CEvbZ4OaXxnMZoPCvY1FMbWh8Cr1qCrzv2Mto6m6GY7P8hML4
 HfzX16AkQfdleQBChOFVdEKdw+kYZrGCCGnx99uabPluFoKRN8/QmoFC2R84f/WLjAceFnLmEee
 jqNDL1Ulv8qWVmQVq3i1NaUTVaocb6MCDEdi18cHdtotNToPwekca8x1SjYMszoQuYw+1XKDer9
 ydwjp7Ivx1eWJYloZH0XuGkVp7jaJTLST/E4yK3CJV2V3uTTE
X-Google-Smtp-Source: AGHT+IETKGTgtWdhTLBzOTanlaXh5w0XH2wuhyZWxVLUWU0IC/C5DShjOUG/xjq8UfhxQ2/Pu7jjRQ==
X-Received: by 2002:a17:903:2341:b0:223:7006:4db2 with SMTP id
 d9443c01a7336-226499399fbmr29298995ad.31.1742371423956; 
 Wed, 19 Mar 2025 01:03:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c8dsm107725255ad.156.2025.03.19.01.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 01:03:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Liu <lc00631@tecorigin.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/10] target/riscv: fix handling of nop for vstart >= vl in
 some vector instruction
Date: Wed, 19 Mar 2025 18:03:06 +1000
Message-ID: <20250319080308.609520-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319080308.609520-1-alistair.francis@wdc.com>
References: <20250319080308.609520-1-alistair.francis@wdc.com>
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

From: Chao Liu <lc00631@tecorigin.com>

Recently, when I was writing a RISCV test, I found that when VL is set to 0, the
instruction should be nop, but when I tested it, I found that QEMU will treat
all elements as tail elements, and in the case of VTA=1, write all elements
to 1.

After troubleshooting, it was found that the vext_vx_rm_1 function was called in
the vext_vx_rm_2, and then the vext_set_elems_1s function was called to process
the tail element, but only VSTART >= vl was checked in the vext_vx_rm_1
function, which caused the tail element to still be processed even if it was
returned in advance.

So I've made the following change:

Put VSTART_CHECK_EARLY_EXIT(env) at the beginning of the vext_vx_rm_2 function,
so that the VSTART register is checked correctly.

Fixes: df4252b2ec ("target/riscv/vector_helpers: do early exit when
vstart >= vl")
Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <b2649f14915150be4c602d63cd3ea4adf47e9d75.1741573286.git.lc00631@tecorigin.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 217d2f60a5..67b3bafebb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -2175,8 +2175,6 @@ vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivv2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env, vl);
-
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2200,6 +2198,8 @@ vext_vv_rm_2(void *vd, void *v0, void *vs1, void *vs2,
     uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vv_rm_1(vd, v0, vs1, vs2,
@@ -2302,8 +2302,6 @@ vext_vx_rm_1(void *vd, void *v0, target_long s1, void *vs2,
              uint32_t vl, uint32_t vm, int vxrm,
              opivx2_rm_fn *fn, uint32_t vma, uint32_t esz)
 {
-    VSTART_CHECK_EARLY_EXIT(env, vl);
-
     for (uint32_t i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -2327,6 +2325,8 @@ vext_vx_rm_2(void *vd, void *v0, target_long s1, void *vs2,
     uint32_t vta = vext_vta(desc);
     uint32_t vma = vext_vma(desc);
 
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
     switch (env->vxrm) {
     case 0: /* rnu */
         vext_vx_rm_1(vd, v0, s1, vs2,
@@ -4662,6 +4662,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
     uint32_t i;                                           \
     TD s1 =  *((TD *)vs1 + HD(0));                        \
                                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
+                                                          \
     for (i = env->vstart; i < vl; i++) {                  \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                  \
         if (!vm && !vext_elem_mask(v0, i)) {              \
@@ -4750,6 +4752,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
     uint32_t i;                                            \
     TD s1 =  *((TD *)vs1 + HD(0));                         \
                                                            \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                      \
+                                                           \
     for (i = env->vstart; i < vl; i++) {                   \
         TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
         if (!vm && !vext_elem_mask(v0, i)) {               \
@@ -4914,6 +4918,8 @@ static void vmsetm(void *vd, void *v0, void *vs2, CPURISCVState *env,
     int i;
     bool first_mask_bit = false;
 
+    VSTART_CHECK_EARLY_EXIT(env, vl);
+
     for (i = env->vstart; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, i)) {
             /* set masked-off elements to 1s */
@@ -4986,6 +4992,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs2, CPURISCVState *env,      \
     uint32_t sum = 0;                                                     \
     int i;                                                                \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vm && !vext_elem_mask(v0, i)) {                              \
             /* set masked-off elements to 1s */                           \
@@ -5344,6 +5352,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     uint32_t vta = vext_vta(desc);                                        \
     uint32_t num = 0, i;                                                  \
                                                                           \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                                     \
+                                                                          \
     for (i = env->vstart; i < vl; i++) {                                  \
         if (!vext_elem_mask(vs1, i)) {                                    \
             continue;                                                     \
-- 
2.48.1


