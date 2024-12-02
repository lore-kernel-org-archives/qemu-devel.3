Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AAFE69E81
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC58-0005lf-6Y; Mon, 02 Dec 2024 14:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4t-0005jL-Gx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:28 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4r-0001xA-66
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:27 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 5618B180BEB
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:14 +0100 (CET)
Received: (qmail 7211 invoked by uid 990); 2 Dec 2024 19:27:14 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:14 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH v3 07/11] target/avr: call plugin trap callbacks
Date: Mon,  2 Dec 2024 20:26:48 +0100
Message-ID: <0ae13652185055396331a25ead6153a8a0ccd505.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733063076.git.neither@nut.email>
References: <cover.1733063076.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.983021) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.583021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=XAuE3s6qJPdddn1nfG6DGmf8hukkjU3RTPMm/BzvJLU=;
 b=huSyqV1HGzwUja/LzPpzNrBG+oZMZsk7OJlyyWVtWpgdcaXtWptLdC5b6t9dqRGWlyRrWG0dwj
 Qevoxz3EqC3ut5Pr6gJyC0al+ZOwdta3bpuW/Nc2hDAi/pBCc5DWm/jI3ZzXSZWbr5+1cnBd+KSR
 GBd0qB1TS8tuRngz8fTlg0ULppWtIwR6titrhFA9C39kL10cEHBPw/nVS96Nc9EQfItuVDAmXQYC
 InNdd9cFg5uExf8oLn8Ksde2DjfRzqdss+dflMzEG6XAC0jAdXdGIx1a5AhI5DgIz4ZRqdjBKZek
 kdvNCTWJQB8oGUWAytmcw+UyhHCh+YVJ0NIaVl0fmgQCAf6qxALt8CrWJ3Lj16c5VzLtYOSmghhu
 VYy+/9DPVpyYqO47AlH3wiTXSPVSM5Jm6zK7/Y5yrkY3f3p+P5nUFsZq9CfeBH5BEifllibxghBw
 W5zh3kt3ajkcWQK4ttU1fm/vYHP1EEfc8th9DtmhD/X/tXQgQ3y3BNgqc5+T60mw0jtrxq4mL5EP
 Im1rIrYmqst7jqba9wGXTs41d3wizst127hBhdgOixBndsFIAm+05RDJUaYB6XleDODUjQkBiUVP
 ECBUDsDBU/fTZDPo4msnZsRVqB/ImyT9FbuO4KmZRbkgn8mizrtS7vrNAP+0byOjzytN434Yydie
 o=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for AVR targets. That architecture appears
to only know interrupts.
---
 target/avr/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 345708a1b3..ba7704f2f1 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -28,6 +28,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
+#include "qemu/plugin.h"
 
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
@@ -97,6 +98,8 @@ void avr_cpu_do_interrupt(CPUState *cs)
     env->sregI = 0; /* clear Global Interrupt Flag */
 
     cs->exception_index = -1;
+
+    qemu_plugin_vcpu_interrupt_cb(cs, ret, env->pc_w);
 }
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.45.2


