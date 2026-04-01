Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD05B10FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w821R-0004DT-GE; Wed, 01 Apr 2026 16:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w821P-000416-9V
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:18:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w821N-0001d1-1h
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 16:18:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so1118245e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775074715; x=1775679515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
 b=HqOik3hFvXDZukBtOdi1x/HZaat//ypQPKLNCswgBVHZz481azJiY5wka08atAqcq1
 c85jeSFQpSw8UCiVw97Slkyouam9hvKCqLkO4QZqS7YNg56Sgcl1tS1NT9djKNDzLeA3
 OMPHxOfWQAUriDrmybw0Fc8OmgOiPNjnFGlNpUxWgEvfgH79eeELQjORPx4uWH9WfQv4
 KAl218CEkaXs3mhiI7KuSmTatQyG314htAu2VDHWhUhLwYkxXaE8RtOzyo9hAEisDoKD
 PTjU0nk3ovdix6CDQMgSHJFFb0tjpBt87p7+416X8o2msqjyMImlKRAJq7sy2Cw80ZgB
 z7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775074715; x=1775679515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
 b=hFCZ38DdePw6qIuL8/pbwhINvETsfmsmgOQlIah3JPX8XDtQXrrgj15jNeTmJECI5x
 6q7CBMg6POmuDfdl0B1HaHUfxp00MJz/RLYXbwCVppklagSNrFK8t1FiFHbczWFohQdm
 QVOVB3dZEhk0HTZpbJSq5mbxnaWacGfGBR3liYuLMjnD7MV2OYFj2DBW4d/Xiz9Ql9wg
 g2isXileNQrQXUxGpN8Yi1eQnz++dEMUsYvyrN8XGiRk6RM8FwK11Xf7eC8gzAiJMzka
 S1h0MwME8DN4+FD+8UydwDwzxln7MFppDi8FYQkrpWE+zAcDcTTjehV1favt9uE0qCLN
 VMBg==
X-Gm-Message-State: AOJu0YyHIAwPMS7/rse+Ze4w8r2LThFRu0Clmk28g+9fNpF4+RC7+z5w
 qT8xwGBR6pbvaJBsIlYD/CwKQz5zCLxReJo+zLK2MaVpkRpThsenYGIuvugqlmG84Ok8oTeWI97
 GW2lp0x8=
X-Gm-Gg: ATEYQzxs8Ut+eqmHkRoD+gf5vumfCaFmknFuSiUNBHKOKK0R6YBBCHY13+yug6T3ke/
 6nPUuyOUt2VVCiC/OToqzGPhwkGh0HoViRin2m9Fxd/KbaqvSDBueg1XM2mZkVg4zz//Uk1ycxU
 a4HIQFVHGwSrXpb0W0rKWH3NLFmnpVIgAlrGCqcyEl5oLCVMifdksdL5XeaAEswshHmvdfmDWRl
 7h5AgP0sA6Cew/Ba9DTo+zREo7JQre9lhGn9PzVTD9gzPBXGctBbf2utBhYt7RqtULOfl5h58Hs
 4JoxmAl4myWC8DhMYB0QyhsLSwKGCFwUOW5swZLQFxPg5SFbLEw90kO+3tH7lVuqf4Z7TCBnJCw
 tYSpupl6ccAAxQTkF9MPmGgP23q/xIcwLMfnkBcWGaZrjpsv9vJCXDd838XMQ85HW7TdFsdeNZA
 b7SW9ff7vP+o8z44e7QYUo69p8pEWCGN27AJCHe01DctBgmgOgQFxEdPv/7LI4y/gYELLLaPYx
X-Received: by 2002:a05:600c:8b77:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488835bc362mr82737355e9.13.1775074715204; 
 Wed, 01 Apr 2026 13:18:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f5294sm1938072f8f.35.2026.04.01.13.18.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Apr 2026 13:18:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 5/8] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
Date: Wed,  1 Apr 2026 22:17:49 +0200
Message-ID: <20260401201753.92290-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
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

Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
compilation unit common") which replaced the target_ulong use in
arm_handle_psci_call(), replace the one in hvf_handle_psci_call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..678afe5c8e1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     bool target_aarch64 = true;
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
-    target_ulong entry;
+    uint64_t entry;
     int target_el = 1;
     int32_t ret = 0;
 
-- 
2.53.0


