Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB49CA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4iH-0001xX-8Z; Tue, 26 Aug 2025 21:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hW-0001Fd-Al
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hI-00008v-ND
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:11:45 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso2219204b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257090; x=1756861890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYMBiKJq8/lsK6z7ljr/lChjjHaZZY+QCsjrhv9wKe0=;
 b=teEkHtCBqjtIfzdKu+OgvCjfvEMBEyT4szeuTkgJF28uYsMqPhizCUmiYjTWu9W4p9
 McrRid9pNgAx0cH1F3abMp3EHYvnkqEYUGl089xdaY+YhwO3LL7bIgWBeHpz7WlUxx8t
 ZvcqK0P3EZ6WV+cwrejme8yw8dZD6PH02dihu960ThysaH4K7vUuH4s6Vxm4wKCulpbx
 GfMWY7L776Q/mxEW7oYzKZgFPZw2Cou6e/SKwYG7wQyU9uQVN+AqlIORhAqR0JeHgW34
 w0G9Wddga7qDrqdwTLfgAkcLvic5emh1TwsD2+tOUSh8oz56BJH5Tnsbos9Pekb4wLiA
 DX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257090; x=1756861890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYMBiKJq8/lsK6z7ljr/lChjjHaZZY+QCsjrhv9wKe0=;
 b=JR46wIfyuzxj6gVgaRbsAEXimdii3dB4+uqTm5dYyzDP8ARcZH8a/KASlrYO91loBR
 Di6SMzz4cf1atZ79N9XDMOJhdrEGM1wI7CvW/+sEofzOTPBbyG6ZEdDGUdS342tgiZZb
 UUDbhNM29NIvvHdtTkqEaMPODxj6jGkj5YVD8OPpTETuhUt7kB0AbmDVEUw0Y//9biDV
 vqmN87st9PD/0NeYE+rT+evW3S2RO08BMWIXp9yTH/aW1ptoOFpKsYzMD+Zb4eAehi+Z
 HPr0e92lPPkAjuQBPvUd5BeNojPWLUBqRuaYxyqtbnN3lbQ6JaBetVOrCF9xEoWnyYO1
 gZ1w==
X-Gm-Message-State: AOJu0Yz80WHpwCeZo3aQS0QpOyVaPZ+mOHOwD5H8DZftwdqBUe1ei5AV
 /EXkQJYv8f+q9SYiFdOBaXvbTGCLmvN0R6HrSj9SXhicksEEBGUEpmhgXAB9WHu4zxYmP5mO87Y
 HMSj6QWA=
X-Gm-Gg: ASbGnct4SPMr/5+qKq63r9c4OGfNQyArSNaiPT8fNFDNrjYTXRJbFGai9OEQSfWsRKm
 70QYYRC91YY7LWFTVHGiQP9MzmicTubzatT9PNPSkgEePYOR7Vvsg2IbxQkcTs3xVsb+A26S7fi
 Ni0U7G8Lflm61AZEY/WtFwpSpi+ZeP6DpamQSZx0pLeke7svv/UufBfP6qIm/afXcdY8DDt9DN7
 FzuxDGOPQiXQMLpBZembo3jN2UfrkPbvrDq5Mva8WlgPtT3bJ70qOPLskbOyzb6cPoa9UK1RMn+
 SAMnJhae0ueQu0AaK/+8okJidaRDPtIjmhXrDU6npbO6p+O/WCHmY+u1RzImQYrndggVPuV9r4d
 v8wEICEAci5l6UVfRskLmQ1CbSeVHDsIYwYe+
X-Google-Smtp-Source: AGHT+IFAFET7HGfCWqmGxJ2/bmvyMn8AvMthMTMaEMNA3B6bzAEknoU2pFoPRvS0a5T9c5T7UWSZ2Q==
X-Received: by 2002:a05:6a00:3d0f:b0:771:f520:f775 with SMTP id
 d2e1a72fcca58-771fd6329bamr4304075b3a.28.1756257089626; 
 Tue, 26 Aug 2025 18:11:29 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 46/61] target/arm/hvf: Assert no 128-bit sysregs in
 hvf_arch_init_vcpu
Date: Wed, 27 Aug 2025 11:04:37 +1000
Message-ID: <20250827010453.4059782-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

HVF has not yet enabled 128-bit system registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bda57614ed..c05e81b4e5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -896,6 +896,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     env->aarch64 = true;
     asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
 
+    /* No support yet for FEAT_D128 */
+    assert(arm_cpu->cpreg128_array_len == 0);
+
     /* Allocate enough space for our sysreg sync */
     arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
                                      sregs_match_len);
@@ -919,6 +922,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
+            assert(!(ri->type & ARM_CP_128BIT));
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         }
     }
-- 
2.43.0


