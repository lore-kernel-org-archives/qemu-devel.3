Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACBCCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SM-0004W7-Ru; Wed, 29 Oct 2025 11:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SG-0004M3-Jo
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:21 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S0-0002uA-VM
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:20 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso16634966b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753058; x=1762357858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+ln+dG2wKaF7Yw5cmZbQoKlVg9Z7JYXIwQU5UuyNBg=;
 b=GtMsZsnqj/vBDJplgNTIINcwMHXTLyWZxWfevUCJAjA/pONxNUcZELOOc/5+qq6N0z
 qxrXguU2b5CLhUMzeYAJzHE/I99NyQYR9TP79a5KMX3HyyyjlrZ6qJ26nEn36e8m7GxL
 EPGXwOL9DCGFkuZVWsQKdMP/kKBmiT0u68uXGWdHu/t4QyG7+boaH5O7a/yTJSDP6wt0
 /m+kf2gll+ai5MvcxHfT0+zhikbENeA87TvoIIFtC06AZOTuag6vpV0xTj8ghOiUaSie
 USdOh6TzMEpPMNTpSZkOaRfpaASpu1Rf+/9cvrFe3jLjHpMxANt01J+QyEQDOT5/WTgk
 OX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753058; x=1762357858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+ln+dG2wKaF7Yw5cmZbQoKlVg9Z7JYXIwQU5UuyNBg=;
 b=kOQgnYZJfDDco7T8OcF7bs+Q+3ezRaKbDMbBA20uQ6461yZuIVw1QusEGeRFlHj4kt
 g17linsNBmOspvrokYSpm3WW5aklD5I5FyTiUBdiODERVsFWeIbmEd1H/UkSJG5d3QPB
 4NDk6kaZaeaaAmqF5VESc5Ugozaw0ho4ark2mG0r5LVQh5xfHkk9ttJtqkXqeyxsqiRW
 aCFbd0I2uoyAGM+9R57YjmhA8SxjRl8cq4OxC8Nmz1vaA5AXh4ME4GGY/jG8NZSIB0fX
 KO8DSqLFjzHOTMFIHR4ZWLpdB28j1ModsIipxpqmgT7GTcnR/30YaHLYcm1bz1LA24Ch
 rzOg==
X-Gm-Message-State: AOJu0Ywk+gVY4wDCDQ8uzAUQJCruWpNkq+v/fCPBH2nPu7RVXSOFE/JE
 2r6CKmUUPi7lJiVxOjcCQ7JyDwS0E+XocLoBcuXSR/YvMd9w+D4GMwbTu15iiRfJhlQ=
X-Gm-Gg: ASbGnct5jAi8yMoAzY2vLDNR0bj+JkpyEC7TJz0FFliG3zQbxGeNTf3IpGn9XyuvTyw
 ZwApTckMpbkbVcQQCHee9WegFSSaL/+re3SVK3/ZbEo+fq5aVXfqunQHRSZX3DeGlUYd0MDulHm
 yK6iYJgTOPdhuBlJX+l6Ng53pdaq5c+iizmYXwSQgDyW+SHlryGOI1SBknP5ulBOV2xdwj6F3Mk
 GIFQEuLzQXOrFY0XZD6gomFErU5ahDGd3NuJgyUI4HwuSRJ0XqA8KVqane48Ni/DQNSCgTWvwfU
 QPUKdwbzuR8N9CEs3BsDhm5wlGoXHz0v27+PmyjPXBn4I/qcu4lAsTB5L/BtcLOcyj18fTEDfui
 +547RQR+i24nXizEZCNAtgq7fhdp8DRN2QnXXQi5IEZur5xE+SA6N6AohxWupxs/iz/tXnSEYPi
 Kl
X-Google-Smtp-Source: AGHT+IE7fNRKVHFhU42Qa+DYrRxvU564A9e6wdbDkcv5KG7BLGz2/w5HaBW7C1n6aXfKBMZDZ6J76A==
X-Received: by 2002:a17:907:6d1c:b0:b6d:6650:c3cd with SMTP id
 a640c23a62f3a-b705212b084mr6520066b.21.1761753058400; 
 Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8ceeaffasm1483828566b.45.2025.10.29.08.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D84C60A0F;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 14/35] target/hppa: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:23 +0000
Message-ID: <20251029155045.257802-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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
Message-ID: <20251027110344.2289945-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


