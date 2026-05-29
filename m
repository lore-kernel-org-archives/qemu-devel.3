Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB5CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3DS-0004Uf-SN; Fri, 29 May 2026 15:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3DP-0004Na-Ao
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3DN-0004DB-Jd
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:49:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so510612f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084192; x=1780688992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gToO07btHAw940X+sVMcM9/aOH/ZnEfIGi+vwCzDH2o=;
 b=ftecYP1bdSgAOPkDuxRVrwKJ08i182es8gZlL5VM6JlbNo/t4j6DQDRcbOeftqCQ46
 I0N7NVGkUukK/RVh7Ak33947uAHgqSUbuABslUfcyDXskOncYzhBCdtMKuxM8zV6ZBEO
 3KHTgvC0g3B69VMRxM/7ANnnvnedhwpzsQR6w2DLvXp2oQyj8pLtB+ykJQiPlbxvdFOX
 hjOVUupxsm+pQvL/RhMNiIIfjxYeLlmoxYGI0sozUb8uobPMdGivk5lNv/x+wfXa64Dj
 DNbhdTw5VFYa7srzLz0G/+x9Q7w1AZlI/BngtqSk9Hb/mRE6u26vuVjY+3fgKQ+WUeRM
 sx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084192; x=1780688992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gToO07btHAw940X+sVMcM9/aOH/ZnEfIGi+vwCzDH2o=;
 b=n3HB1b+g51wX/17ijIjPc8qRFSDCbmAbWPzEHUmusX7O3PB40BkK4koQKDRvbf5a22
 bCUjv0XJazUW8C3ZdMyE5ji4n/sFRnYoJtkq6HqRWHLkCDsYdfNkr2lmZSYc8/2D9Sap
 JxWNZHp7js37OS1Fgvf+yeo/DQR2e95LMGkm1eJVW2BNvFppz/iuoGU2qYn4A0cggH7c
 3jKvHiyus14Sxe2hYyvdSbPZq8buyBBCN/4JBfZJ+fAavQxU/gevXJd+7K0JPzdsX2Y+
 K3doC6kxJYCFpPBueppdDaaDfio89ODhWLcOhWO14dFG9zaTFNRLVxfCMcfxm4ZcFw/d
 7D/Q==
X-Gm-Message-State: AOJu0YxpR1P1qcnfM2grP367w8YXJjul50DvuYg9JLjp7iuQq3P1DjQC
 5QtoBkgMDsudWLTjPmTJa/UJkOHSSpt3HwkKmZ8/qv/PA/jpD6vNayZEo6Phpv93WrpMjfmYVsc
 uGTVB4N+ndw==
X-Gm-Gg: Acq92OHsjWimTWMQ555M+ADXilt79yk46aspqqZOO6VfhU8rsPvMim6wgKex5VXTUr9
 vZAP0dLUeaJj6O3Jw16+xAOPp3qLKjm9fwf/CnESeL/pMJHw9oXvgBR3q0VzbvzsgZriQeuuQSG
 MU/iNvv1xHqn1NM8rFc/VCPf+gAFlpp5Xd5HOP9bQ3dV7D1hZfxcn4jQx9iDRyp3vfK42bc54Yi
 2kApmOcTLPRdhRl2K3cIHklQxauLMQX1TGUx8p+RtW7YGxmkXsF0TPl63PEKBTt2GAA0oWnj6MF
 LZeiuA8+wmWrFAt+Vbqc7fWbfpVKqzOCRkzT9s3mMufZz/J76zpuecIJJ1uTdnhKHuf2lCMHVah
 9thqhpxD3kQYgtkoPDXzSWmFWy38BurL4Q4wH3TMLsUvmHu7OKR99MNreWEKH2p55nDy652gvZN
 JqWaAl1kPlAM3FA/Svj5yiEyG9XYStYSyYLv5aMhbcVJiKeAcOuCC9bOP33BKpOjskfg==
X-Received: by 2002:a05:6000:11d2:b0:45e:f295:33cd with SMTP id
 ffacd0b85a97d-45ef6ea9417mr918738f8f.11.1780084192037; 
 Fri, 29 May 2026 12:49:52 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c50f6sm6471508f8f.16.2026.05.29.12.49.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:49:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/17] target/loongarch: Remove unused
 'accel/accel-cpu-target.h' header
Date: Fri, 29 May 2026 21:49:23 +0200
Message-ID: <20260529194940.97143-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

"accel/accel-cpu-target.h" is to register accelerator target
specific hooks via TypeInfo::ACCEL_CPU_NAME(), which LoongArch
TCG frontend does not. Remove as unused header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/tcg/tcg_cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 31d3db6e8e1..2bb1feaa66f 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -9,7 +9,6 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/plugin.h"
-#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "exec/translation-block.h"
-- 
2.53.0


