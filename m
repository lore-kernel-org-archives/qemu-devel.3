Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8AEC369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LXl-0000ue-1P; Tue, 08 Apr 2025 22:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXj-0000tn-Ml
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:59 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LXi-0001AS-9G
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:51:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224191d92e4so59533755ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 19:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744167116; x=1744771916; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RnrAzFeyhhVN5kCbVsK0iZFX3OvBg6SXh0USMwim+O0=;
 b=d9N1b0AgY+5F1dC8PCFIB+G/fLe9Bmh0NWGzbCRipHjbgy520vrUKmOetjNNN9Q7le
 OSO+cLhBVaEt3F3R546STP8e/HMuiiuU89DEYb+MHI7EjTWv7Sm2ZbxroTr3TUfPpHUX
 1Yne+jCKk3cDNzc3kj7onfDdU/0vgb1wpjvC4yuCd67BBkmh1GyzJ1ROtHH0WdyRy7y5
 ikxLvlgtNxRTM4fo12+8h7dLm2Rjks09aKAkABeBZ/e6JnEpalfkQV4VzCvAePmJ2htK
 ng5H/rHy8Hadw0xicKamxxq2ozIegGdg9wzEw7rBanbB/l/DE8FIUkrvywYzJHs/knLC
 ap0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744167116; x=1744771916;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RnrAzFeyhhVN5kCbVsK0iZFX3OvBg6SXh0USMwim+O0=;
 b=IH6g0HiY32j0mnAboBo890mGFBAlSNV6f6PSi20N8O2f6V2AMr0Xi+x530kePgmvjF
 CmrKek86UoNEWvCUBPabGS0Y7esSbg5RYgZZMZIbyjMnddnK/1wj9YDiE5trWZ/U2HWs
 xU/PcJBrpCSSRzkT5VaZ3DojMWHiXg90JOB1pubn8ACn9fmrpBXUrCY5L+TrU5vUhl41
 sONCH2p5gFbDtOJpvbX+bANHT7l0Da2x2fu909BKcofsPs2hVnJuj6KJntQzmn2DMO17
 iFZHo5K+dlXAdcHLYQT9fmoSJhYxaRKvOqAeojako2hpQn1z3ydpO2u7/8C0JmbhkMk0
 2pYA==
X-Gm-Message-State: AOJu0Yy50GL4j2EcVN/UouU1EKjIYzmw7Ftrr82y/tmUD4Wm0O46cud/
 gslsWfRbfq+Kd+Ipw1XLCALK3Uf9Gtun5EJEKHGTcsm6RZE0Q140g+F8a0dmcXD91QklTMJVsbw
 8JY/ggVhSwLxWraerYyxgiGxJjRMfJV0iOqw+iH1Y1+N0xHRYgpZtbj3l3UYedpUnTZaK5dBfCb
 I4mhsyGkiA2sih6BV9y0CKcqG++mSs//+pnA==
X-Gm-Gg: ASbGncvrAMifqub+arrKrxWTD33ysHlCrgUcCI3h629ePvw51ScLUPjjq5KVsGEtKzz
 ZSQ31LHqSYQRWSZt/q67SS7slW4/ZxIVR4lB6DztV0IzFoGKVgtoo4epdOuYsTiBinHaGboFJzY
 1LZbgpwTdqQjUNVuKyfc6GhuS2IE8x6AxfkoA4znoiL/m4OtBp05Xt5v09XiK9BWoA6k4xvwCsP
 Wyj7sJxDfl6zkAdWcVKYkFcI0bvM4bahXwv07muQslBTtUVFubSXnEk7UrVKMEfy77mf5lo8id2
 hIOuZ72lIZNBM3l0WYLE73ySidzepKRpTgc3DykyCLUNU3PIE3vie2aiMITipQAY0/k=
X-Google-Smtp-Source: AGHT+IGGslaLVHdpyphTNDAohz50hEJQ7oHY0FFaQInvSilIa5TeeVkxwn7/ot1LzImsN4zpjqYVvg==
X-Received: by 2002:a17:903:3b4e:b0:229:1717:882a with SMTP id
 d9443c01a7336-22ac3f321e2mr12042385ad.4.1744167115812; 
 Tue, 08 Apr 2025 19:51:55 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7cb5463sm665725ad.195.2025.04.08.19.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 19:51:55 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 3/4] target/riscv: Fix VSTIP bit in sstc extension.
Date: Wed,  9 Apr 2025 10:51:30 +0800
Message-Id: <20250409025131.3670-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250409025131.3670-1-jim.shu@sifive.com>
References: <20250409025131.3670-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x62a.google.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7948188356..e86808fd98 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3635,7 +3635,14 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
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


