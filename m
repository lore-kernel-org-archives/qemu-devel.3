Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A56C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnalE-0001Tj-Ps; Fri, 22 Mar 2024 05:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnalD-0001TW-7N
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:23 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnalB-00029J-PS
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:00:22 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-609ff069a40so21235917b3.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098020; x=1711702820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFOwsLoUeHy61UpIhgty+6bsINYXEMHB7YYoX+Io5XM=;
 b=VHfce5NwZBw8a8vzgkYOjL8DvrrOQ4IhUk4TyIJug4xrwbMMK+YwWQiC9ZMzX5o6Ve
 yk9+4Ue9UIzGP87JM6M1R4sHAyeHuf0TqF9FZX6ZS1LQhzVPstNhAhNMuolJF9hb7Med
 UqPG120PTbQHe+29LsVvyjJM7F+9q79OKIIuePkEXMrIY82Kx/z3PcEVk9A2xPNh6ajl
 MzsRog1Bw3S9kIRAhRkfO4aGlXogOKZ39Pu99+iDzJzFQBYCO7eQ8bSASBGIau+znW1k
 3QmEUukKxsVrNfQVxxaU02UAyDhZjxuqy713CaIY13WU0hUGM3AX1duCvxoP/n8UAZ5f
 zlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098020; x=1711702820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFOwsLoUeHy61UpIhgty+6bsINYXEMHB7YYoX+Io5XM=;
 b=GzenIBGhg2zDYCldva4ieoye3G1HD71JLl3DVO57zDrS052AI/9IxOwoE1GqIhiw+u
 yeYJvN2QOb8jgfv2nMAaLX4QBvpFcsfYEVT5pDf+yZaEkbjJA/hYfNZmaduSCWf+J+31
 27jge9hmhiG0p5kKBp7xMu0YWD2D3l0lwrtybN0qWTP5dl0D/IOHjUiqecknBDAWasJy
 YtI4BKCCMYuEXTycIzBLQZhzqyGY9n6cFnCTovasRc7+2JfD3XZbpvTw+J1rVlAA7kYg
 HSirlZhdsp0KdX1triowvdK532Arta5kcFksRnl9gwT1/tLP1ZIQ3Lqr1TGi10IJFeCO
 FuMw==
X-Gm-Message-State: AOJu0YwhKYe7563coj9AiIQvY0KSnl4W1/Rw3mWQla+2n6dEeWL54FYl
 G19cgCY4ajbWhMjoTQX7ffROoWFG09y8Gm05dlHOj809iH+Z5jEkQeIrEHawcjZ5Mw==
X-Google-Smtp-Source: AGHT+IHn+f5j/qhYtuThW/7TrxJMVc2tQJ+O8bbPdtZkUWg3N127WYAui4gWoCGx+Sp68QXw545H/g==
X-Received: by 2002:a05:6a20:2587:b0:1a3:a9ee:853a with SMTP id
 k7-20020a056a20258700b001a3a9ee853amr308102pzd.40.1711097647260; 
 Fri, 22 Mar 2024 01:54:07 -0700 (PDT)
Received: from toolbox.wdc.com ([129.253.180.114])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a170902680500b001ddde07af12sm1369048plk.143.2024.03.22.01.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 01:54:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/15] target/riscv/vector_helper.c: optimize loops in ldst
 helpers
Date: Fri, 22 Mar 2024 18:53:15 +1000
Message-ID: <20240322085319.1758843-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=alistair23@gmail.com; helo=mail-yw1-x1131.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Change the for loops in ldst helpers to do a single increment in the
counter, and assign it env->vstart, to avoid re-reading from vstart
every time.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240314175704.478276-11-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 63a1083f03..fa139040f8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -209,7 +209,7 @@ vext_ldst_stride(void *vd, void *v0, target_ulong base,
 
     VSTART_CHECK_EARLY_EXIT(env);
 
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
@@ -277,7 +277,7 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     VSTART_CHECK_EARLY_EXIT(env);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < evl; i++, env->vstart++) {
+    for (i = env->vstart; i < evl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             target_ulong addr = base + ((i * nf + k) << log2_esz);
@@ -393,7 +393,7 @@ vext_ldst_index(void *vd, void *v0, target_ulong base,
     VSTART_CHECK_EARLY_EXIT(env);
 
     /* load bytes from guest memory */
-    for (i = env->vstart; i < env->vl; i++, env->vstart++) {
+    for (i = env->vstart; i < env->vl; env->vstart = ++i) {
         k = 0;
         while (k < nf) {
             if (!vm && !vext_elem_mask(v0, i)) {
-- 
2.44.0


