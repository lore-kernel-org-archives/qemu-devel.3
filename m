Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6416CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy9K-0003ez-Uo; Fri, 29 May 2026 10:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy93-0003SS-59
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSy91-0002L3-CL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:25:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso93447345e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064701; x=1780669501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jW2zG1X8bHmlXnWN82TlCGxlIo9/KiyZAvhHEyZQIgo=;
 b=QUDskZt5d+2OuKFbLcILoHSaTuymCcwXf+j15qlvwh1TpM4dfolyFYlJCT6b9bXlBO
 30nLmCs4qDKaHc72BzlpnjeLbyU21Cz8SPwJWAg53WKK2GhZUL9s87jMSrfrY/wDquEe
 kUehVUNQ3kvNnO4SLwsSxYT8PBSqXcydDPmWpDSzrFHd+bh5vx//aBJwZ13QOkx2vq1b
 E8ThxZci1cLnpB1+1QJjZLnaNIBNlOrEu6lE9kr6G3Nh1+6iDc4IgCzZArjO6NIV1+8i
 oqU3R+/2YLga6V8Dq74ZevPfTFZWPfmk9zd9fCS0bILbuW53SPLZnmSMbMDtyMoxkGiv
 nfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064701; x=1780669501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jW2zG1X8bHmlXnWN82TlCGxlIo9/KiyZAvhHEyZQIgo=;
 b=XgFN+QDD/a1P9gftfK2ZQV4dVfT5EqT7Fs6CMnOhYOlULYMO5Tf+3IhFKBwBA2bYxj
 aewjfWyvqWFrH3+OPaWLlXdHuPqcd4Snlxax/Bp+WQ5QsXtSA7pcLKgBP/WYrWaOexXC
 Jl4yQldNmx01vR10Sfu05U2S9SF+BzGNhSnKB/iZlu+ZOrTfjxhTSTkypwLiBAh7/Xrp
 Jjx6JZB2giPSMdZbWrpDqY3nVIga5tGJOTQg8Etxw/gKX3zKo1Z1ea6kDJSbmLcIG+/4
 x7GjXPcpkJWLmDCvKScX2NTZ4uCAcib3vO/q7P2ZPn+c0EyRHGFFtHcrO00R0NZzaLt6
 bQHQ==
X-Gm-Message-State: AOJu0Yy2PH/Vdj77OX5if1jRY+5vxSZhJ7syxgcHZYeiYy+mQXsefHC7
 3DHeu3Q2H1yg4C1k5CqfI3zOWqshCOBat7g1wB0yL/GVKlmvj4buRQm14NLO/RtPmU2NcA+5Mnn
 aLlzuX1LMSA==
X-Gm-Gg: Acq92OEvuF1Ic5qcxBnB6KJn87CUEGKY/q71rWO7ebfOLOabK/k5Wri7RFZ+Y6+knwB
 7LnNBwr7aDhOJbW5+MMEDHvIJOpzqkSb678Rh7zkS5IvaKgcSD7YNpP5EXPm75xTG1nToxKVQix
 cW4cDFceJf37Ar+o4cQmu/DUw369vAKvnG8saJlgR3rtxs6wuZG8VwKU/Y26Ibfjno0LEVGVJE6
 twCN94CYvj8Q9IC+XxYENO6VQn2KH+jeCwwzKPcb0nnmBgfQ6jlSHF+cAI8XnYoaG+AQPCr0JFX
 V6M9OMKT/4C0HaA4hjVO7ZppbUrrLdJhXR4S1biGeJ8jRrGv5L4nB94RHuhTuih2yxYW5qLZxVt
 UhkH2xmGfmlffC+MJHO4i+mbiCVhxoQGEanL4kkop1GjvJQpVjbxsOZ8AzlbDuh5O9zGuv2pP0O
 3Z3t6BEXXe4p9U8+lK2cNzDyLNqKRPCmdXUamF88bBhvaD+qWw3DlPDkxFlWUC3u1aRQ==
X-Received: by 2002:a05:600c:1453:b0:490:9536:c513 with SMTP id
 5b1f17b1804b1-4909c0b0012mr40361385e9.19.1780064701417; 
 Fri, 29 May 2026 07:25:01 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d696f25sm60774685e9.5.2026.05.29.07.24.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:25:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 03/17] accel: Rename AccelOpsClass::cpu_target_realize() ->
 cpu_realize()
Date: Fri, 29 May 2026 16:24:19 +0200
Message-ID: <20260529142434.87880-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

cpu_target_realize() is misleading, we simply want the host
accelerator to realize its things on a vCPU. Rename more
generically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-ops.h | 2 +-
 accel/accel-common.c          | 5 +++--
 accel/hvf/hvf-accel-ops.c     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea0..fd1307dad6d 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,7 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index ebc103053dc..176b03e0e90 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -60,9 +60,10 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+
+    /* specialize with target specific realization */
     if (acc->ops
-        && acc->ops->cpu_target_realize
-        && !acc->ops->cpu_target_realize(cpu, errp)) {
+        && acc->ops->cpu_realize && !acc->ops->cpu_realize(cpu, errp)) {
         return false;
     }
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..6edc2242ed9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,7 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->cpu_target_realize = hvf_arch_cpu_realize;
+    ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
-- 
2.53.0


