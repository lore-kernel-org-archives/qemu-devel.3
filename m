Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7949ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AL-0001Ko-8F; Fri, 26 Sep 2025 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299Y-0000Ij-Nb
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298g-0005nn-35
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso13722505e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895769; x=1759500569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IHG8pw94kQh9rgj79VlxQY7WE57C9ajUY74LgQzgrVQ=;
 b=MHA+TdDmZIes2gaySRbx3SiyGpm7VV+x1n435fZ8qDHwZL44yAv1eZ67UXYO5gVBfq
 v9vSgVuHFFPMFYt94OmTMsH9VyWbxet8l0ItS2c2iIzq6Mv7koHptAM05Q/u1+KYpPx3
 sCgOSkFVC9xoiSYx/K0hrn7yhl5QnjCl0dUwSsOQDwBd3cNfzU9h2SdsTxlsSzsVljJX
 D4qQ/O7RROxlheqUM/JKrqonLsd2p9VBz/Q30kultvyuMqE71NwGNH7vZsoYF62YNh/l
 eMsF7vMVEC+QavJwJoRoZNfLaHvLPizUFvgPOFvcpS5aq2yWYNfy1IixYQUHAHuxmr99
 Pvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895769; x=1759500569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHG8pw94kQh9rgj79VlxQY7WE57C9ajUY74LgQzgrVQ=;
 b=tj84V3acjg4Q0KtaId2PI1ymRGC8ny8bhgwXP/cVTXJs0tOwPhaBsm9aD/RRAmmKC4
 Ap4MQ5K8eO+iOImCcrsNaRzBMAZCghD2sMb6sbrboIn//Pf3h1zEyV5rT3XpDFdsXvVn
 I/tY+hw7Bl8Ho2ZHEmFFS6LQ1JGXD6/vNpDKnfDJpnTSQfJTtlvYJbMGc6iqqD8Bx+6B
 7pI7kFSVCVvOR7eXhElA8xy6Mdcy72rhMEivrJqsmoq+S5JM9u95yL6T35vwKX6yF6Ot
 3aNI2RGs430plxbmJhfUhjnpio90O/5YCtf/49burAwVfGIdcAJLeK4W1/c6TTm1s2Ae
 BTRA==
X-Gm-Message-State: AOJu0Ywc17nAaInWlk1cfH2Nnrv0C1O3SLdxE8Sv4n7x4vfQJTqPfFTd
 BIYTXHYMIxwvdGlWVUsJlDL3wiG/TeoWfTHc58SX3MTHMdROlWPge+hAPTYX2kRiFjzh68LbUKk
 fr41+
X-Gm-Gg: ASbGncuLXgcK/bMsw/3D5onQsNlsPWtEBEDrQjzF9XKTjmHejSgV2qNEP3WOt2btIyy
 IxqncEzg17KuJ3gzKLsOP49pd7Fzn0HSnEO62ynV+UDywDgb08s2i0yCRJowmXaUW978ta1R6nO
 MA3wTYJQVBMVXJ3wxudvQuMJvRBAoC1m0M6PyB6LVNsuqJZaH0tfyPASOvOAO5pisvRdYVi9ILM
 HjuMX8oZM1c5Xw2dU3RaizImipH14Ca3CaF7kICXp1L9j4hUO5UOYqoGEpDQsdLmX6odbBc/AHw
 xPXxPK1XzMjRpaOwEHAbR9l643siyw0RFNkCxhdmHh3TN61Iy5vk4i9GB6xgkoj1N66plEEu2l5
 DExuE1NgDV3dPtFOdojrTv3FI2Op8
X-Google-Smtp-Source: AGHT+IEarU7dMmoTdBTYVwqRcU6FkUY0PyembsqnOgr5Ne2ceeu52ot/fj9gxiFs0i4knOmHY/0BQQ==
X-Received: by 2002:a05:600c:64c4:b0:46e:36f2:2a62 with SMTP id
 5b1f17b1804b1-46e36f22d9fmr51261705e9.27.1758895768841; 
 Fri, 26 Sep 2025 07:09:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/44] target/arm: Trace vCPU reset call
Date: Fri, 26 Sep 2025 15:08:42 +0100
Message-ID: <20250926140844.1493020-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c        | 2 ++
 target/arm/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f8e6749ff99..30e29fd3153 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -227,6 +227,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(obj);
     CPUARMState *env = &cpu->env;
 
+    trace_arm_cpu_reset(arm_cpu_mp_affinity(cpu));
+
     if (acc->parent_phases.hold) {
         acc->parent_phases.hold(obj, type);
     }
diff --git a/target/arm/trace-events b/target/arm/trace-events
index badff2b2e46..72a2c7d0969 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -15,6 +15,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 
 # cpu.c
+arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
 arm_emulate_firmware_reset(uint64_t mp_aff, unsigned target_el) "cpu %" PRIu64 " @EL%u"
 
 # arm-powerctl.c
-- 
2.43.0


