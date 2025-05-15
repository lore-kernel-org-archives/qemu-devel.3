Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF1BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmz-0004PN-DS; Thu, 15 May 2025 06:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmy-0004P8-O0
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmw-00088i-NT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8368895e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304765; x=1747909565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=45OXTNzjwjDe6TE6ZCe7ioq6XmOCBuiCA+I7gKEs7n0=;
 b=uN0htnB7mWJPnPhW0XXlk9f1lisd/MLd6cY7+XW+oGnIcF5Grqj9KPcTFGBMdfToYU
 B9Jvw2Q+GPV1Sop9PmEI/jtu1eH/0JaYT5Uq4XjNsifirbF+SKsGbNgE5CoMPTgCiubV
 pVcGhEczA1XFIEEFyNo4Ufoi87r66TSnjGyADa32Zhe6Dy/CuC0uvKD5V417mG+3jQUX
 AuNyS6D/uij94NWL9eKRIYyhNcscx2jOqssDRQYS6MdvzOV7lAy/ec/uJb0NPRUEXS4H
 +t32fLmYbIkP1UtoOTpv8giFUUqicKxXTAUEhveXECCCbABHbFUqccFE3OmGpF5sYUWZ
 X7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304765; x=1747909565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45OXTNzjwjDe6TE6ZCe7ioq6XmOCBuiCA+I7gKEs7n0=;
 b=b4i3WFfajl5LoDZvuf/XapVzfAjQTKkZG0+xgXmpSR3ZNsbV2I2tsOxnBYCIzpF6NN
 y5gTo5PMTRFjHfygW53P+Hoxo1Ljk1PMEdREKVW0D+UkimvjHdCsPB93lQpVmZAwWYR9
 yLjznCNKGmLggTz2MZ1a3AayBK55Tn6ivKpsKK1h2hWwYuuiU1qKhW1KkuwEhrNbfy+r
 LJjTPrm7VIZkMBxl001yXrtd14yNAvAz9HXB10pifJV9ZEudB01S77RORI1XL38XDZcU
 AaTGtfP1tcrGTbFUrhuEi62fpw2ZSi+TdAZtVeden75ccn/lcq/7/84yrfT8O7Bmbtu4
 TBMA==
X-Gm-Message-State: AOJu0Yz4VgY5JcSKmshFoVJn79pUV8xvkcERzi7/3d9BiG/MRCrsn81d
 Re6JNYDjIRcenbycKrpfxAiOY4MgBQrdRee0qUo8Ma08m/jDaVUXGkGrrAGXeyf+Gimpwl3Gusy
 M0Rc=
X-Gm-Gg: ASbGncv9jLGe+96rf06TnKSiRz49TAzAx2jmSDhJ7jhOAA/McKYrJAciNQAxyJSG8na
 vFjE721JwDlTqnA365vA8mfB2u8xruwOvF+G01F3yY+iFVzlrF5GbSGYKKmzTxjeUxn8ESR/xBO
 2UB6AS7vL816DNdVpotbF4QxWbNnntcYUndPtKQSlngFgK5QPl0w6hYVX13pZhPBzNO7v7z2s6U
 O9dsNS63MW+S8WO7jfDBtzwb0UzQ9VqcjmTkdCcHl9r//NH2Mtc5Vio7brCdV+X71rY40hPlQqM
 VPfRscJQhxg8gtR34gEANOIcJQ6RSlrnateN/AgIcdNFCDKdZIFGSVdsUA==
X-Google-Smtp-Source: AGHT+IEf6MQhfgnURfV23gSAlxvPhJWZ/sHg9rGRSIToQe0mwoTWtm+CjUPk+trxa40OzXzVsxT9xA==
X-Received: by 2002:a05:600c:698c:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-442fbbdd46dmr5380835e9.20.1747304765129; 
 Thu, 15 May 2025 03:26:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/58] target/arm: Replace target_ulong -> vaddr for
 HWBreakpoint
Date: Thu, 15 May 2025 11:24:59 +0100
Message-ID: <20250515102546.2149601-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-2-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 702eb1a5483..3360de9150f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1948,9 +1948,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, vaddr pc);
+int insert_hw_breakpoint(vaddr pc);
+int delete_hw_breakpoint(vaddr pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..bb5969720ce 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(vaddr addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(vaddr pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, vaddr pc)
 {
     int i;
 
-- 
2.43.0


