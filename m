Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80E8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2IL-0006yI-T0; Mon, 19 May 2025 11:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2IC-0006tn-4Q
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:40 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uH2I7-0005TG-4H
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:20:39 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 59F64180E82
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 17:20:24 +0200 (CEST)
Received: (qmail 1438 invoked by uid 990); 19 May 2025 15:20:24 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 19 May 2025 17:20:24 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v5 07/25] target/avr: call plugin trap callbacks
Date: Mon, 19 May 2025 17:19:47 +0200
Message-ID: <57905b1779684c65f526b7554df14483aff58494.1747666625.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747666625.git.neither@nut.email>
References: <cover.1747666625.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.994489) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.594489
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=uFv4wgxu+WxZG2jJrkSSQ5VTa7ZJ5m7C8K8D/fGnRDA=;
 b=ElLA07NcYYX7uV6KEdizJSq2d3e54CorP5nDiGEfi0b9xJjRpyjzVrL4T/thpJK1ks7OriGkvG
 QKifj16vIWYRzOgNjONZXqpWlQLZq+VquATkXcVU5kKFZ3P3NmV0dJFICDpmYjqoC+z4hYXBqcM1
 JiPj/gJtfPAHF8VgK5qjwQOxHRIWDulX+fmWZ58FMdcw2j7+MSzIL2PpZgwsekRxmXw8yR02R9D+
 XQnJ/iwtboMt4nbnAJFxxK7MNEpqCnXRePc9A18+kZ8b6daWIY2HGgXbVRYHU4iPnFj3M+d8pnT8
 du2ZVJX5DAbUemhhZvumYSKEOHcXl/AJNjCwtm8emyWPBwyf/xyK9cLsH59vUGmhBCa2u0AEiDuw
 Z561CNf5AbiRIri8bGWNxPiDXHmXgmlv4mWtkmcU8Ox6Ez7tPKmEXGcdb543AmW4Gw26eBTkpfcm
 FntuCrlLQXzMQmc7eL5nh8FIt6yxbFUd3uZGKy8mhGDjm4o+dHorqMDpITMch7nUvvg9yt9LLjml
 rP9WDe51qWwhdurI+qg9ti/EiLwnQfxdZJuSUHoFOU3tns57ReTVCMdULVTntuZUy7rRvQKdQxEc
 SYC7XzHAGtkPU2D6FRptWTIfs8VxajkfaANtEr9j6jMatg5iOEyhf/MVqPUipRI3t+QlmV0uIbDu
 o=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for AVR targets. That architecture appears
to only know interrupts.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/avr/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index b9cd6d5ef2..f28cc08637 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -28,6 +28,7 @@
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -102,6 +103,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
     env->sregI = 0; /* clear Global Interrupt Flag */
 
     cs->exception_index = -1;
+
+    qemu_plugin_vcpu_interrupt_cb(cs, ret);
 }
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.49.0


