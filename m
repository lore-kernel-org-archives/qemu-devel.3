Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26992CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd35K-0005UH-L9; Fri, 26 Jun 2026 05:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wd35I-0005Td-QK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:42:52 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wd35H-0005fv-2C
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:42:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4629051c9d1so369182f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782466969; x=1783071769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JAcrBdE7XDCtWnqI+6BOneuvCaawMssbObuGpAdgsX8=;
 b=sm11AWgOaJwG1igFidiTIktYv2n1ncXqe5D6W1/PsuXGb1+Hc+HTQLujYEIyijlDGL
 GZ/muZ4N+YaPUA1tkRl7Z4p9XCcDjf+7Hq6CMUAGadolQkhts9WJKxEuDMqol1KJB3jk
 2BsWkZrbFPR/gCXHHNGM/ORuXi1/ZwMeXazwZGld94AtQso71/G7alrLfaMsnTXNc31J
 EZ056frpbYYW6/WwCuia7s23e7L5ItO4j0561b74DxTnn6UIE0FpLc9x/BGvdoPstZ4l
 88klHQ+ziUzij5nW3fTPhZ1P0xRlhw10bhUKIOeuEdbyqOG/iSVY7qnshzAEXvRWnCQo
 PX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782466969; x=1783071769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAcrBdE7XDCtWnqI+6BOneuvCaawMssbObuGpAdgsX8=;
 b=LTiBz3g/sblUAuDE07hgyYYcPxslcbDUs1Nzcsle1pp+LoN6sN/tkd5hYp7YiCMZJl
 NKL43jxgmN6KDfFkhMkoqmAGp4S5nQsP2oialRRxqDANapm2ewY7Tj/r5ofh6UuxSVNR
 7vO9LE8WDP9lofbbDqhAqI4V83krJrtSsRH7eqGe70rX49UPg9BhArHwnyFQpHjVVEit
 05c/dDsqxbd+forVvpWQEJHyTx/8IGw3pQhd6j9CrQtq4Jh1d6WTxmM/VPpcMQBJ8p14
 25Hh0nhN2stQBaO+nRePstWSZIJn/E77MAR6ofGva2VhLvLlMCyVz28HZdPMQ53fL2SK
 nAJw==
X-Gm-Message-State: AOJu0Yxd/qu8h9y3li+1hXJL9rIAmB2xiNXo+0G7nB4gSGhcRp+gSZmh
 2FcxQmRMT4XhzTFF0XCuCSTbyn/kLsS8XegB+XXVSoVh2wQy6dFYcXucqRIySbg7+WI=
X-Gm-Gg: AfdE7cnxmq0l1rfKz15nyv2/FIviyrsijjQx71QyhNvYT0MOwSgPP0S90wVX1HXoHwR
 hxGrIj1yoPr7+LRcEUilL7iA6R/AYpFHnToCKzwf2TpIvB/iazLth6azW35qNdivdfsgxMnTFFh
 kD+xNF8qwqPaNfSmrq6eLy4cFHTCUyk4wSTURsUnDJFHhs7gGTHj4L8vA5YWGaOLtfigkwSM/c3
 4yPWDqA1dq3yo4Hyq29CqzCIiWd9MIHBwpPEjdpajn7xK/7feTahRMfkATIsQd6Io9jXd2UFBKA
 4bvwttSwzb611MU/nVdw5PrKTIG2iNer6timKev/mn7jL5ZoMAvb3ymaD2GQ9f16P4kRsEujJBO
 xd19Lp8mAUy83RSuKem0AhfT8IQ+MWWOFN7lY2zXdfoQ++8lZpvSBbYqsoLNQIMUvfpsZsqiRxu
 i1YD2jMpB6JF99
X-Received: by 2002:a05:600c:8518:b0:492:62d8:2da8 with SMTP id
 5b1f17b1804b1-49266884adfmr90023585e9.29.1782466968935; 
 Fri, 26 Jun 2026 02:42:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46caa798f43sm20983633f8f.8.2026.06.26.02.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 02:42:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 60C855F867;
 Fri, 26 Jun 2026 10:42:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [RFC PATCH] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
Date: Fri, 26 Jun 2026 10:42:37 +0100
Message-ID: <20260626094237.3788189-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

There are a couple of gotchas we should point out:

  - software breakpoints can fail on early boot
  - TCG treats all breakpoints as "hardware" breakpoints

Rewrite the text to explain this more clearly and call out the gotchas
in a Note! section.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/gdb.rst | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index d50470b135e..f7878ca8606 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -49,15 +49,32 @@ Here are some useful tips in order to use gdb on system code:
 Breakpoint and Watchpoint support
 =================================
 
-While GDB can always fall back to inserting breakpoints into memory
-(if writable) other features are very much dependent on support of the
-accelerator. For TCG system emulation we advertise an infinite number
-of hardware assisted breakpoints and watchpoints. For other
-accelerators it will depend on if support has been added (see
-supports_guest_debug and related hooks in AccelOpsClass).
-
-As TCG cannot track all memory accesses in user-mode there is no
-support for watchpoints.
+GDB supports two types of breakpoint - software and hardware. Software
+breakpoints are simply implemented by writing the architecture's
+breakpoint instruction into memory. Hardware breakpoints are less
+invasive but rely on the support from the architecture which will
+usually only be able to track a limited number of breakpoints at once.
+Each accelerator will also need to specifically support enabling these
+hardware features.
+
+.. note::
+
+  Software breakpoints may fail if the memory is not yet accessible,
+  for example during early kernel boot before the MMU is enabled or
+  before the kernel has relocated itself. In such cases, prefer
+  hardware-assisted breakpoints (e.g., ``hbreak`` in GDB) which do not
+  require memory access. Due to the TCG accelerators complete control
+  of the system all breakpoints are treated as hardware breakpoints
+  and the number of them available is for all intents and purposes
+  infinite.
+
+Watchpoints allow the debugger to watch for reads and writes to
+various memory locations. The number of watchpoints available will be
+a factor of the architecture and support of the accelerator. For the
+TCG accelerator running system emulation we can support as many
+watchpoints as memory allows. As TCG cannot track all memory accesses
+in user-mode there is no support for watchpoints in that mode.
+
 
 Relocating code
 ===============
-- 
2.47.3


