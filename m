Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1148BF55126
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Py-0006sC-Or; Sun, 08 Mar 2026 03:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Px-0006re-SP
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:13 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Pv-0001cF-DG
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:13 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2be27fa54feso7435714eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954350; x=1773559150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lqy3ttK62KbJsNvTyksmw8JT4cUz9wtpaOy468A04s=;
 b=F4VutP3wyrMJHbC0srd4dTDzkacwT8NPiJRbVHnPS/gFXjBvv40c40+i0CKhCPwKY0
 x7kNjstiN8ZDTwhOdCxHtN0T6GK8ZGe6e32/U3Db9gqtrbd3U2N3gbIzFdUnRjCT4gHL
 zECWEAzYkK3DfxjM/rWnh8sUAZK2G9pLjdl6lEDjHosxum1ZTmp1sD8Ebj8dpiWrn0JM
 lBA6HGwCvGUTiZY593hEcwQLa1Sdg6nB6XRZ1uEcemmPpkOZyO5hQX+4PyL/z1pAxCHI
 VkIo95CMxc4CCweWnNnjiZKThbD8VmIcn7+5dAICgJJ+/zO1NwLpjB0EUoMllOEa4Zoy
 pFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954350; x=1773559150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3lqy3ttK62KbJsNvTyksmw8JT4cUz9wtpaOy468A04s=;
 b=Ku/KGO6cqD6HqUG+pSaFYj1fYIxUsy6gsbBtfJbgNaEjiRey2uHN5sWAEi2tnPxAw4
 T1m3pdya2TEt7o9EyyTwD9/CVuJEbeNSf7WhLiFOdVL7y+BP3iloXSQ81Xtk5cfMV9+w
 iE/nvv2lZPn41tafgCXNpJMPGX3gYnc08vn7vdxlwuYG4pfdLvFvxf88m4XnoE4HBgFO
 5DrUU/81QN/1e39o9/tf7RHxs9Sq/FEtI42sg5BSgtpi79kpT5aJWOdj4HPPxoSL+DmE
 s4ywUm7bouQXMDNnTf6kfpirG9w/qXr3ZHbN3g//pzc/XwB35Q8008DbIW15U5M+2OZ3
 REgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkChAlsKNU5kjE6UQcqZ9zRHUAZqn3+uFl8NvSQK65oPeHvJphH0d2W7kyfPcO/XORMM95tYRBeWtF@nongnu.org
X-Gm-Message-State: AOJu0YzzraHYElh9PnKx/N3bZiybbcBAhu6g0pLrV/RGfhewhC9V5nU7
 wqm/GLXUV5DBn0gfJhr8crj54oRSWfB24PU+/f69n47tWalbCp9dtfEL
X-Gm-Gg: ATEYQzwai+Lt4q/mdBn9xxpsxHx0c7Whp27cRTDdkPSmK7VNwqMwbeh6PMDtugDLeK+
 LWpUlhbv+0fPJsiYliyc7PEqwe6SVSdAs0N1/CC4TVubYK51EOl1XdOoSj57abjq8sD+J6PdZeR
 +KlZovy6X/NOrhI2SaYdGfrMBNcVpvFxlr98gysfR9eeVLesuHYTxJ9jkw58b7Kg3rTWZyWz+13
 BwqBQ3P9C3sUj6B3k1kyuaSK3mnHbR5TKG61rO/Be8wxfpMqxCDE+FkJbeVwPhae0RHaYqlvyfm
 WUex1grKh+gaWezGaOYmvqhNVbjGx/r+6oPnpvuIUD+8hYEOSW/b0FHnJ0pCdN7aWR1Q1wErXwU
 2Kt+hwt2I8TfOEAY29ZWOmFW8ljre1fNa7ZA10HhHW9wWJpiMYf5lPW+xfThEhYHu9GNVnYZ+gT
 9yNJ3Y1XbEzexdBVeYvfT7YDChR9wiGeuBKn+uh7zGc9pXMaKKdJSGTMWn+VH1OGQ5YMO9FFBFe
 WAZQpYDHg8SmhFYrPHwG+7cTSM=
X-Received: by 2002:a05:7300:d517:b0:2ae:51fa:b7ec with SMTP id
 5a478bee46e88-2be4e055db2mr2871681eec.25.1772954349994; 
 Sat, 07 Mar 2026 23:19:09 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:09 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 07/28] target/riscv: restart the DM ROM on debug-mode ebreak
Date: Sun,  8 Mar 2026 15:17:10 +0800
Message-ID: <bb02f01144f6afab42973f24961f9398386b92d9.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

If ebreak executes while the hart is already in Debug Mode,
restart the Debug Module ROM from its halt entry rather than
falling back to the normal breakpoint exception path.

This matches the ROM-based debug flow used by hardware debuggers
that place an ebreak in Program Buffer code.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/op_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 7f2769f444..406fe2ecd0 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -495,6 +495,13 @@ void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
     CPUState *cs = env_cpu(env);
     bool enter_debug = false;
 
+    /* ebreak in debug mode: re-enter DM ROM at halt address */
+    if (riscv_cpu_cfg(env)->ext_sdext &&
+        env->debug_mode && env->dm_rom_present) {
+        env->pc = env->dm_halt_addr;
+        cpu_loop_exit(cs);
+    }
+
     if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode) {
         if (env->virt_enabled) {
             if (env->priv == PRV_S) {
-- 
2.53.0


