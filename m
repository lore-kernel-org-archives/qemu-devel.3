Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9C2E77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtJx-0002ci-GT; Mon, 06 Jan 2025 15:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJv-0002bY-60
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:27 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJs-0003Bi-Hj
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso106049105e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193803; x=1736798603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEstRp4e2Qb00qEl2/J4TP29Zm1C+ONgiSLe4ofc5Fw=;
 b=hzfaOnrnEYyw/2oiK8Y6o3uzZVjK/UGRAGLtu//IDwuBZ2YPrF8wqZGZPnQg0Xqrc7
 1mSLEVB1FUHymds5xfAVeZdw5RaRTXJJYFdBcKGXAaNo1sjJ+KGYNe76hLTVUmIuZ3Gx
 F5FV42/SOoKhJ2mH0qDNfwvb609WL9u9CU9/tNCVW+5rW8TL68BzrL1WB0V0Rf3qZ32t
 G3VtjpVnepmHoNB6Tf7+iI6Yk4/r8553/nZ0H9P/Ijp+wv1Fm2EnbPq+/e6m5DvNKgWq
 Nhy90QfE0GPsUhtCjliXIkYbFC9/GBHuY4tiyvxxX974SPDj/8jOzISxnRjv2Np0hwn1
 rF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193803; x=1736798603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEstRp4e2Qb00qEl2/J4TP29Zm1C+ONgiSLe4ofc5Fw=;
 b=Y/hsfW0M8+7BtbqHcjdCQyXtJYKlwDvJr66pyI4QTVZfVnKtjfTp2KDy0UNEWahNiN
 jyeU2icSSWoMdEEqnrs6i6H7bOKLupGv9SZxYZJPvzKaaL2J7swL+z3luaD3J8bejpms
 hymbmbEM9Lfb19bKEQ+ARLpE0jyyb7+JRn50RT7eHDPJYpGjjJ3ZQ5Fp7W0vRJR+GJUB
 8ZpF3S6ogbtxPCG4qYBbDMWDDgKurfiLIx5wh/4kRLriKmrHmdZdF0SFGxUCXytON3PA
 3hq56nrrIznEJ34PWPUmZ/OnwwXGplyNQGoFhVBBtIViAHKbkXbDY8Ul1Hk1V8BfXvsm
 CLjg==
X-Gm-Message-State: AOJu0YySV2ILOOiZ8WbZ/rvrtGHPQOFk+bKvC2Tu6z884gtJWMz5Cjug
 mOFw5pGSdVExnSsot8+x5QzGZpD1orqRpJvPXQEqONvUAnlFZFizLlI/fALk8nG0eIfW6XeWOTx
 BEQ8=
X-Gm-Gg: ASbGncuxq/yvsu46jpIA5UevwBY4SA9kd7Jk4xbTCl7ckD9tzYWL5G30T1g/iP+ZLYj
 3uvE1noGI4Cv6Aqc836kzruGDUlHAQ7KV1BiSEk9R1mTnqp7NONLtI4yJEoLOvbUZZ2MJQAwWU2
 IJVJtLCk855CCJpuI9ySvQwzTCaLjs9fE6Jt7qrn7FNmdkGWR6d9qnUi4j7vZBXqJGsGrB1XQfG
 mEuJ+sXfcRIibijKyFl3IHKrqoYPryAdMVH9ZTwwMs4w805LmOke1pQ2fbqYsL8asdXjoLecYmM
 m9cEOsrLZj0+1sF98ZKvZbDk9JQWHTg=
X-Google-Smtp-Source: AGHT+IHMet/slV/sVRHbkbSGWWghuJnC++0pCmETj2WxsmX+/fk8W7s4g7KNnMtjYH7DDkOzwohlVQ==
X-Received: by 2002:a05:600c:4f84:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-43668643743mr497181795e9.14.1736193801273; 
 Mon, 06 Jan 2025 12:03:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4365c08afcbsm586765365e9.21.2025.01.06.12.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 3/7] accel/tcg: Implement tcg_get_cpus_queue()
Date: Mon,  6 Jan 2025 21:02:54 +0100
Message-ID: <20250106200258.37008-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Use a specific vCPUs queue for our unique software accelerator.
Register the AccelOpsClass::get_cpus_queue() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.h | 10 ++++++++++
 accel/tcg/tcg-accel-ops.c |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..7b1d6288742 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -13,10 +13,20 @@
 #define TCG_ACCEL_OPS_H
 
 #include "system/cpus.h"
+#include "hw/core/cpu.h"
 
 void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
 
+#ifdef CONFIG_USER_ONLY
+#define tcg_cpus_queue cpus_queue
+#else
+/* Guard with qemu_cpu_list_lock */
+extern CPUTailQ tcg_cpus_queue;
+#endif
+
+#define CPU_FOREACH_TCG(cpu) QTAILQ_FOREACH_RCU(cpu, &tcg_cpus_queue, node)
+
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b2..1fb077f7b38 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -47,6 +47,13 @@
 
 /* common functionality among all TCG variants */
 
+CPUTailQ tcg_cpus_queue = QTAILQ_HEAD_INITIALIZER(tcg_cpus_queue);
+
+static CPUTailQ *tcg_get_cpus_queue(void)
+{
+    return &tcg_cpus_queue;
+}
+
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
 {
     uint32_t cflags;
@@ -199,6 +206,7 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
 
 static void tcg_accel_ops_init(AccelOpsClass *ops)
 {
+    ops->get_cpus_queue = tcg_get_cpus_queue;
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
-- 
2.47.1


