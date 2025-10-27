Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AAFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL1z-000111-KW; Mon, 27 Oct 2025 07:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1O-0000cz-Uz
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:19 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1B-0005gm-N5
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so848540466b.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563038; x=1762167838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YUrkZOEiVqgaskj8vySb8u4ZvfCCqWGczqDOfAD8J8=;
 b=clBjQ/C7Tjkmy1ME334uPcGKyGtH61pdLPeItkAVus8T8mMDJ/wwTK+fZO/64LsVs6
 BSpdW+GKPmhcYMSmhBNNk7XjJlrG3yNlM0VysM31evp3QLUCyukov4lh649ERnbaBjOO
 AEK6SKNuAL0bcphbx+665LXTbji7jxe2fAwWF4JODAGmtLUWfkZX6W9dLKHZ1nwuu5jm
 gTcOo81qgwadhIRccvVSqiQxRT/lI3nCKCb++bk8fSe9fXoZ5a30Kt9LwQKwlMmTNBhT
 hZj2TviG2n9EHIkQZNv0DhiYamd4ROreHYp85rIDhQd098US/HZITtC9o/r8wHRHLBJl
 bQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563038; x=1762167838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YUrkZOEiVqgaskj8vySb8u4ZvfCCqWGczqDOfAD8J8=;
 b=F8cOWQvFtS8NRrdUM78e6dkrLkP6Qy/9rYUUhbOA802FTf2Eh07zFInzHhTd8uOjqP
 Mi82rrHBTrbCDDg05NqJWXtjGrE5MOBsKmNsNmum1QTyuBdBvdY2/9SJYUiRaUXFNNMx
 o5RrEeP3FT540Rw4FrL/7SIRrhFcYCnV+nf2cQ8PzYyeR+Jel9P9UOllE6JsAXWJyZlN
 R5x9YD+qRPlhbs9iqhheBUjtmFSJZVyuYzy7Vlj7uJ5hyIN+2+qcD+KeVq++9SmUBwiR
 Hml8qTcLU/2OOgeNWggll1p6PYHCSEo8roJe4ciaiOXIZ7BGHbqNHuaA1W1bHMT1428G
 XjYA==
X-Gm-Message-State: AOJu0Yy70Lpl3/njW7OweGCZERL1WSSk6EQOEO5MRBHNzDOAQgc9vgKb
 Ps9+umzEDJmFYpOf7sWcael5UlqJE0xqdn4Qsqeyaxt/wJHNKtDHzPOHFlOX95AcQAU=
X-Gm-Gg: ASbGnctTeh3/A7raGjVlA0GBhXq6CMIaD0zx24LWS2bRUgt9/wTD5IdjIZJ4X57tyUy
 JAk2bXc49co7559zcgdzYicNzRdlWiPp8XXrjTqGun2ObnLfUBGmMygp4TcbkAQMLxD7ZWcqkg3
 MhzL89XxulMQBr4nmzHKLBFX+X1OBfjCkn/Z4fI0Ws+pgSzvHA85FsfvS77IXmoqxpV2zIFEL+y
 9oaSl0M63t7pfdlyfb7ctBbRzx72VrRQFNTC7L8bNcVmHRDqXeQk45soh0LohCFnCuIqxu2XsuP
 fNFJ9uH3c1V7dY+Enaud8PfsTPtIVdud5q9+azlIxJNemWpVBiYj7xX6wIGHvEL4nf8mzvqg88p
 s0Xlju0+R5w2AnW2eLT2XwINFEpaM0pXTbwMDTG5fdb4EoYbIqNMS54W5/7cVyAIIldCZrFks59
 Qi
X-Google-Smtp-Source: AGHT+IHwrtYRvdWMuVy2AMsMT1ZRJwpgRqGp0QvPKkCoaQSEbVYP8oZ9QpyiS2d9CfCH1xzbuKIyJQ==
X-Received: by 2002:a17:907:3f0e:b0:b6d:3e23:b68f with SMTP id
 a640c23a62f3a-b6d6b7e401bmr1405286066b.0.1761563037918; 
 Mon, 27 Oct 2025 04:03:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d9b536710sm407933666b.57.2025.10.27.04.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6681A60A76;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 14/35] target/hppa: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:21 +0000
Message-ID: <20251027110344.2289945-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Julian Ganz <neither@nut.email>

We identified a number of exceptions as interrupts, and we assume every
other exception is a (syncroneous) exceptions. PA-RISC appears to not
have any form of host-call.

This change places the hook for PA-RISC targets.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/hppa/int_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 191ae19404b..4e4869285b5 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "hw/core/cpu.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "qemu/plugin.h"
 
 static void eval_interrupt(HPPACPU *cpu)
 {
@@ -95,6 +96,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     CPUHPPAState *env = &cpu->env;
     int i = cs->exception_index;
     uint64_t old_psw, old_gva_offset_mask;
+    uint64_t last_pc = cs->cc->get_pc(cs);
 
     /* As documented in pa2.0 -- interruption handling.  */
     /* step 1 */
@@ -212,6 +214,21 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     env->iasq_f = 0;
     env->iasq_b = 0;
 
+    switch (i) {
+    case EXCP_HPMC:
+    case EXCP_POWER_FAIL:
+    case EXCP_RC:
+    case EXCP_EXT_INTERRUPT:
+    case EXCP_LPMC:
+    case EXCP_PER_INTERRUPT:
+    case EXCP_TOC:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
+
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static const char * const names[] = {
             [EXCP_HPMC]          = "high priority machine check",
-- 
2.47.3


