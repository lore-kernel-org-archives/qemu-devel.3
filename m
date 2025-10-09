Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56E4CCD18F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rgE-0002M3-9O; Thu, 09 Oct 2025 10:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rfx-0002HC-3D
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rfn-00030K-Vf
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so1142258f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020273; x=1760625073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnUlApX+7h7Kk05znUtWIMQVcOTxmH3EZMk7MU+Bn4g=;
 b=fXPRJ6DJRyP5AO2+IcCWTwQTYcHl3CgqQdW70kF38alxorHnRaAuX1xS/l3iC/Sm5X
 gqbaKU/Ks+svxkt0H+8C5+uwugAjZZTC1H0wKoSul4cMkezmnmYfAEQmwQaA5lpyM7Hn
 vkx73ArWAUgjuC/Z/kk2Jd/YD9Y/I8V1DJHRGkW2jBruIkIt3pNFr6HYGi8FapP6ICyr
 31vOdwWPmVXg1qCqTW36FMCgfYL186jScpR37K/joCNhC5jL9kijnSyDkzxhJxZYz3M/
 MhLjXSaH2c5n9BXSGZumn/9lXaYTc8+HGErsQy6E5JfpDgu/QvWPPvgCnuABhGarn1MZ
 8mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020273; x=1760625073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnUlApX+7h7Kk05znUtWIMQVcOTxmH3EZMk7MU+Bn4g=;
 b=LZEs/ztwvmPbI1RKMmBFmMUnoWMf0p+6kW1sqze1IBxx6iUSdLv/yBGhpBdXXQkJ3p
 3uzQ4izYt7VwKtp57jOl2LzbSOFoccakmDxe8UMDItlZki3O/Cmd4yFFtmUL4FsMivCk
 mk8gmDajmwpZloICwtYcpDMkdl6Ftz71AgKnAXsr5ywlgZTB4iNlR3LHAi9KWeBHU7dd
 mBsShPw659bzEY64Q84In7MCV1pLNxoZKxY4JopoLukvXnnW4BYvLYPUQtzctnZgMwTm
 kNfEyKvr2tV41JYCyzE2q/BAuCDkeESs0eueOqBgwujac+s/LUF3lUJS1R9AizE+f0kW
 oP9g==
X-Gm-Message-State: AOJu0YyVJb2IwfUm6eQtrenK2S3ASQ8PMFlHNPQWtj7CPY+VRfIlAiKj
 Dr4F1l2VsQ0/HIsK5m/m66MJObe9wY8Pcsp71YLTgD9cPbyDTDZrDogWyjYPDk6jf5j9R2zyWfV
 U3lDg8zAhkQ==
X-Gm-Gg: ASbGncs2xHuN6bibk94MJTVAtH4CcbxpSIbn2L0oXKf83eudINFUDByxAHnIFp3i/Mx
 kB9Zr5T5Ub3fKvNRCSzglnLztotjtYwpcaqU+HLjO9dcBmkw671DGK8I+X8P+EXcbVN1q0epMfC
 zsKIyc7F+h+mWreT/KuyhH//5qIZdyF2rdd7InELUETFlYSOPB5V7NkMZrKvrRHwE58WnOUYrkT
 5eWcS80ATm+ojgDww9G08puHGY1tJq4EqoD+0gtvdhaDcVv+wnhmqeaPzosDxjdqh0vNmQ2zd4D
 oZ8G/IqQNBG8YKmvNmwuE8ul3lPSUNTCa9Pnfne8Wi/nGK7ziPOkd6xV6vz01++aFcY1VJd3sGd
 jdwnAczBrJ8hg+FvfB6EKYxZMFnFuQdigr0qYWLyh9Lb9/fF1PcpmbqdVRoirUNwzYxDAHsZow2
 /6/TFXRJdEed1RD1xT7NJhAjJj
X-Google-Smtp-Source: AGHT+IFdAnyIk1GYu1RZARP9Y3YLUwJfJqGDexlvlnAAzrPXNCHgn4iio8tKbh8NSaokHBfxOypOyQ==
X-Received: by 2002:a05:6000:2504:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-4266e8e66a4mr4804740f8f.57.1760020273143; 
 Thu, 09 Oct 2025 07:31:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482624fsm396965e9.6.2025.10.09.07.31.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/hppa: Use the machine default boot order at reset
Date: Thu,  9 Oct 2025 16:31:01 +0200
Message-ID: <20251009143106.22724-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009143106.22724-1-philmd@linaro.org>
References: <20251009143106.22724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since new machines might be added with different boot order
than 'c', take the machine default one at reset.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index dacedc5409c..1cce5c47b91 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -640,6 +640,7 @@ static void machine_HP_C3700_init(MachineState *machine)
 
 static void hppa_machine_reset(MachineState *ms, ResetType type)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     unsigned int smp_cpus = ms->smp.cpus;
     int i;
 
@@ -671,7 +672,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.kernel_entry = 0;
     cpu[0]->env.initrd_base = 0;
     cpu[0]->env.initrd_end = 0;
-    cpu[0]->env.cmdline_or_bootorder = 'c';
+    cpu[0]->env.cmdline_or_bootorder = mc->default_boot_order[0];
 }
 
 static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.51.0


