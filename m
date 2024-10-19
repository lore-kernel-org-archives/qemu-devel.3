Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE80D3C920
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 16:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2CUx-0001zm-6H; Sat, 19 Oct 2024 12:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUt-0001wV-JJ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:11 -0400
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1t2CUs-0003xC-3q
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 12:40:11 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 904C917F838
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 18:39:59 +0200 (CEST)
Received: (qmail 9787 invoked by uid 990); 19 Oct 2024 16:39:59 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 19 Oct 2024 18:39:59 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH v2 5/7] target/avr: call plugin trap callbacks
Date: Sat, 19 Oct 2024 18:39:38 +0200
Message-ID: <5807fbae77440ce091c1480a173e371a72142952.1729355735.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729355735.git.neither@nut.email>
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.955061) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.555061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=3kEDEfs2NK+O76NkQpJ9J9wdE/Guadg1wnJP/wNvu24=;
 b=oL2YfM2sk5MpdnW86mImRU62igmM9MjOSYjboKOGIu1YkkUy7wFrnxDLp7m9lpwf3pclQ/wpE7
 wtrnF4hWQkb5y5HTD4NMxxrdx3LoAU7MXIvU9SWXsDjQEbJDK0GppXrnyFb2i6oVfNcWXWEU5Dlg
 MdzR3ho/AaU9BnwTNKz7vMyTjCFdxcQDkUtq4Lo+ZZNX0yMLZcN4Jmrc9XwBQnyHPA5HpjjQm7OO
 P1pKedCoI/Rr0XEUaX/KspdT4EwEvosqizSUwfupWiJB1Ai3+W6EH6CXVjHnO6jyrLv9aQTANqHS
 OV8Ob2MReoHawOJg5fQmkx18EKzfwZzpqEfC2b2mZoyP6qmBdLVlk+ftesPyLNDZ6kBrTQCezO19
 zGO8GQfFZVIHI7pX1CndzZ2AUgUrTUNnDz/0FbOCS2wSkqPXK55zdTrEoV35xQtfXqPQVqkpcEPe
 ThXSz9i0QecFaIe/c4BJHCOxY765f4/uMZrCe5FaLC+FL2YnITG+mMInQXdrecEgJCtE6i3lxnMy
 z+kRKN6xSuRdDbBOyauCozvR8m8yI6bb8cBlGOe/xu5UOrvdlwTxSLnmXWPJlR7jAlWJmoPCLFT+
 zD3jZa+wgIjRA5Fdf2mdPsurVvt/5AOgwL9/Q6VegPh4U6AtX6H5WrxzILzCGkua/PJKgjdpFue6
 k=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 345708a1b3..be94552674 100644
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
+    qemu_plugin_vcpu_interrupt_cb(cs);
 }
 
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
-- 
2.45.2


