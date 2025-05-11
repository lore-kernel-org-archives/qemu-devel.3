Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3A9C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WH-0006Uk-NX; Sun, 11 May 2025 09:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WD-0006Q9-7b
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:01 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WB-0006p4-En
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:00 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 4569F180058
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:48 +0200 (CEST)
Received: (qmail 25999 invoked by uid 990); 11 May 2025 13:14:48 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:48 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
	Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v4 07/23] target/avr: call plugin trap callbacks
Date: Sun, 11 May 2025 15:13:59 +0200
Message-ID: <14eda53c7aa554a2bfc566931d99819adf2ece74.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.995075) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.595075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=uFv4wgxu+WxZG2jJrkSSQ5VTa7ZJ5m7C8K8D/fGnRDA=;
 b=yUHl0ePZFWUMjlWs+w993j0Fe3nUNPbZHuaU/D3X3XHjrmYZZzxuSljrAzQP31kkxdWurxPukU
 /Wz1OMng+GKkbjPTB0sUBea2IUAZ6rnvxjR8Ogae+og8V82xjhLPivHIfGUGIrL0qA44xuWPh1mz
 PASesKzxXAVUcPQRQNIcFkZS3NzcUVlRrEo0kQ4Oj7L1oupn6VJA3ggqS0PlkA9boBtdxOziJ8rd
 9104NHofjYkFqdH16vlN48/4JrLssRv3qv2CKX+5D4tHG9meR4XLUxSEqNoSu6yUjNbVK5Ok07Ki
 i4PPr4NyhRfME4I38rQP8NVu5HFXfzzz2+gSH2126WdghRoh1IcxsDJLUuFUe6A+AcDLm5t8gfmZ
 6OIgVqKSP2Fau7gaQdvqfKdaXEu6TKXYed7ZTojPn2qgDXr5D8ZAEsNhOZmXatTYrE5+0uLGIq+q
 erFchZtkIIZAJTFsuYVEespcScAM3UJ+4mddNUfEsXdJ2jvY3kBJQhv77LKj+DiW4LKa/ZS53sG/
 Xn94IFkNDSwbM6kErknMg9jiyr1sRFWfSt+8xquvzBX878m8eORpNJHFPLm0KVk3tvK8DhtEHBP9
 9dOqaa+sg9NZ5rKHDmzfDeK8HaWp2FDriI9+/KTA8S/EUHFhKENJEuRxUl1VuU6AJ3k2skbYX6dC
 I=
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


