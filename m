Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D934EFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1l-0001IT-6T; Mon, 27 Apr 2026 04:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1L-0000wQ-4v
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1I-0001hA-VU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso91137935e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277323; x=1777882123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+E+v9dwQEh1rdTkmhs/D+nnUCn7aDH8mDMozjNzzNdU=;
 b=nc35tCBeHr5oqD4SnbxRNFaW+/u4Jyzh6+y0Q8XUDMA9pMFtHmrfw++czLRuWLzM4C
 aQzSt4jkg9ApuQjJUErg8kPLGPwGr1ABgtrfxKDfdRGpT2t3zcZTLXG4Zx5GoRpo4oC2
 Cm7PRV0h68XgU7hw7BPlGSyNZtaHBEE4oiodjYbxd9DJLnnrl20AmDbc4586b6IQM59G
 iUwB3Lel0Tfkd6i/SZZZ+QqKacTUogPw7SVSNKIzqGucx3H5FqJ6D9LD8p725JwG6ugS
 1bTn5frdg1IYTqqA91oOtv5nHuCwj3XI8cdVWbMvqG5CmUI4wJRlx0wgxDQrWrUCfss0
 Ilng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277323; x=1777882123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+E+v9dwQEh1rdTkmhs/D+nnUCn7aDH8mDMozjNzzNdU=;
 b=QWe4YPvqoLEO3SUVOtYRME0/cmcUo5ZVeOUCJGx2gwCSOxGgxMo65dqq8/wR5i2yuE
 dQJdcZlEfddyaiRkSivBO13L1064eIhA48eGhKMatdttEtany236A/7/GPe15v0FTpJm
 smCR3hMlp4PNRTKjacghXCtFr7f4HStn1k0Jiewh20DmmfmeQfEj0pCswUmwvgQtuZlp
 Nm5n8GnDoCY5DZ8ZLDl8kPf2IA4qzrjmQXcE3zihcchnOmA19Vtkm/az3kM1uW9yEWFu
 gnYcnhx8Kr6L9bxrMbJxO2BgVHpfPlOxPOFyPL+5nD6f4GYmm4Jw8AL6KGX6LepCGf3n
 zIPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0F5JlrVITv+yO6eV0BDLwFZLa3FCk3H3xWgqhfzk3lUuIVgoLo/M23AL4AU0J1SFTXLMOlHSQpFVE@nongnu.org
X-Gm-Message-State: AOJu0YwC+aj4Hxu1b61JjCIUHfBzFQOfus0H5WrCm0c/Ls2lCcWi/vxE
 a+K1IzHfZ9b2/MUvToBkfBNOmsVgA+IN7p02XqaWhRxgV4fiCVNEx8RU+FcbaJCiXvtadkZp3Cs
 3iRMagiA=
X-Gm-Gg: AeBDievAdnqW4NoAZ5UC1tqWHv0vQXKwdgwB3mssJEQOmxfnfACjxtqFQLrFBCvMFbA
 oa3ybjphKtpUxQQKzuXCCYgH4I3PSbCtrRlpjVXs5DbWg6wEWO3m+5w8VGg2cdQ3tCzXlp743wh
 RbaeOfFqAXXCokVfarmyo4DgDlRh0qi2NgAG0BBjuMWPcbw4ijdhrJTQjXPMkXBwnH4UMD5g01y
 L5oVCM2oTTv8GYXadfTLTBTE4fOwbHYSymHO/cQqoWgumA+T8Q05Rp+SoHMvWKJOK7GLTcK+mGY
 WzLSBxUPcWBCa9xvGVEhjHn8mX6Paizi/EeZQhPh+Ptt8Quoi7bQFN0j++hb+Ka44L2HhhJ/JG4
 c6sV+7kx/DgferOou0G124sq9TrYwwa2nxKM2cAAlPB7WW2AVcLDT2Lax4fZiPPkAGllfHTdx2b
 oT3P9JiUjMAuZN+QVnzzugqkZ+fufhd8FbubAyikH225L14heVweaRE5UmIAHW84UFcvsfoQd6X
 xMBFtSJK54=
X-Received: by 2002:a05:600c:8592:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-488fb779acbmr423717295e9.15.1777277323158; 
 Mon, 27 Apr 2026 01:08:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489201cde98sm532876675e9.7.2026.04.27.01.08.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 09/32] monitor: Make Xen emulation commands generic ones
Date: Mon, 27 Apr 2026 10:07:15 +0200
Message-ID: <20260427080738.77138-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

In order to build hmp-commands.hx once we need to stop using
device target-specific check. Use the generic pattern to make
the command available on all targets, providing a stub with
kind error message when the feature is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/i386/kvm/xen-stubs.c | 12 ++++++++++++
 hmp-commands.hx         |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index ce73119ee7a..bf6ac28bef4 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 #include "xen_evtchn.h"
 #include "xen_primary_console.h"
@@ -37,3 +39,13 @@ void xen_primary_console_create(void)
 void xen_primary_console_set_be_port(uint16_t port)
 {
 }
+
+void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
+
+void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12d..06d7b17bf25 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1839,7 +1839,6 @@ SRST
 ERST
 #endif
 
-#if defined(CONFIG_XEN_EMU)
     {
         .name       = "xen-event-inject",
         .args_type  = "port:i",
@@ -1866,4 +1865,3 @@ SRST
 ``xen-event-list``
   List event channels in the guest
 ERST
-#endif
-- 
2.53.0


