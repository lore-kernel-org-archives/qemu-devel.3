Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3ABE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRWr-0002WW-N3; Wed, 24 Dec 2025 11:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWg-0002Rj-Ox
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRWf-0001ZV-BD
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:15:50 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so48059515e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766592947; x=1767197747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CBlE/inrx6/FOhCae9oAIEbt4PYuKHkk2kjDE/lSfQ=;
 b=SYWxx2X9A0L71+ru5X9dITgaQ5LoAJ9PVjGL119rL/A/DpqqTqTp3EFwk9wnVIgzxS
 F8rVSHDrD+Iv2wCKhEb+xVWoin7fbkIhRerpNub1PHnM8g7XaAAeUYe3Q7yQ/iYtrYAB
 xSF6NITSxlkwRcpSg4Czmo2lEDvr9/0HYcm2w15quzeZcylKdU1fzkm4aNOctJgGRpZM
 yPyXUM7nGoIY29CiFh+ftu40a8wODLe7H7gNHmE5DFbD6Rktvn+YTnRuc+iur4g03weF
 vTLp+dQBlbPYjYjatbY7sY4bJe3GteFKvl2ryzxoum7XmcLsEmPWFtW7F3Qvt1Tw8rkl
 sq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766592947; x=1767197747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0CBlE/inrx6/FOhCae9oAIEbt4PYuKHkk2kjDE/lSfQ=;
 b=FLhypCe6+mI4BXj6gUDojbPvIguKH/aGMPVureL+K6U9rV0gSG3w84aU5BtbW/4d2w
 Pgoa06SUtbqi4OXiLFPiA3goAR0XvTBa90hcqE2AHr31j/zTORSLm1WDi2H0753wirNT
 xFaeSEj9wUllSaAJArx0AMXs15F/jN4kW4nRW3e3ZrpneeULQfdpqrd+6lZjV54SnqFN
 NWZ4PqlYNxnL+tiyclrta+wzKhj1xSXbkz1I6R1iXKP2I4cweuJ1v/CWJUvEzoEALz6Z
 Hp1h84N+IjfjgORZYtUnIT/a5vX41G6+LwIOfHdMITCqWaObiEQgfT+ORuKlJef57VhW
 TKyw==
X-Gm-Message-State: AOJu0YzhPxc9v+mnpvvFp9nOwT0zIlb2g93Qh6Zs8U+cECyw0WdJ/+XZ
 yz11Wy63BXmWK3AOaA9C1kErE33S6Oo568nzvSoh5BaTecC8tf3GD+svBgJ+WfmPjeWFylwJbtR
 tIINXazs=
X-Gm-Gg: AY/fxX7ZkiCe4kcEEnLDv60C9GVSe0QyikcAl/FI38rWEtnx3tFFLswXzxQxtgiiW9y
 EJ1f4Z22n6ROLRLQOv2jzP3T6GHESar5z94DDySjZlHtPMnIswuRkOE5UbR5I8lNAE8ZpVOmoZM
 MTBD65yJOGedc+gaM1UHYSwd0KPRSP20Hrld9iNE4x4p03dcXY5FylD6ny2iIv+67DVQjxfl00J
 AdiT5iVE7WcBpW2+d9c9PUIJ9EUsdnMbuJyzTkLORZa2h4EbCa2YV8B9BaJjDoVdXvBd75qwXLq
 awIIFZcjQ9HmMu0wt3duds/vo59ZeeiXCY7poccmsNj7aX7P3XO5ND7xc5SaSXm3vZMpGIpRLUw
 DJwjOMPNtor0k2PXLBTjFTcpnca0NLIR+v/foQV4zungBe9TG75gOGi8rCh2wmVgeMc/+Rxf7DR
 oKN3I6W9mW+LEdNQaArKnFZVLPoOhsf4+aUiwX9Vzx2Svhs5K7PLzv0Gw=
X-Google-Smtp-Source: AGHT+IFcFt7hMW3IBF8hNDmk0VRPO7sMCivGdVTefiWJAW4dRm6AoiqrEZlSyX4LZ+LoRe4uHo0Tiw==
X-Received: by 2002:a05:600c:3e0b:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-47d19555af8mr183276925e9.10.1766592947505; 
 Wed, 24 Dec 2025 08:15:47 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a49315sm148095105e9.2.2025.12.24.08.15.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:15:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Anton Johansson <anjo@rev.ng>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/loongarch: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
Date: Wed, 24 Dec 2025 17:14:53 +0100
Message-ID: <20251224161456.89707-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161456.89707-1-philmd@linaro.org>
References: <20251224161456.89707-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Since LoongArch instructions are always stored in little-endian
order, replace MO_TE -> MO_LE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/tcg/tcg_cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9d..cb70692ace4 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -140,7 +140,9 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     }
 
     if (update_badinstr) {
-        env->CSR_BADI = cpu_ldl_code(env, env->pc);
+        MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
+
+        env->CSR_BADI = cpu_ldl_code_mmu(env, env->pc, oi, 0);
     }
 
     /* Save PLV and IE */
-- 
2.52.0


