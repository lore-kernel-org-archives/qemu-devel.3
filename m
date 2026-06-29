Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E54C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9hS-0001Y1-WF; Mon, 29 Jun 2026 06:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1we9hR-0001Xo-EK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:58:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1we9hP-0000tf-PO
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 06:58:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493ad116e05so5423805e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782730725; x=1783335525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nlVFu+vghXYRA8+TWIE8jJIhLBygLV0wbuey3RcLvOc=;
 b=M2aMr0cgoD17fjy7cMHl8dkBmUdMwJ956gfPgf78IMce66uohqLtHlDiria+vJL76K
 7Gm9YYjr7F0jtk9b5MnkUMrkQNPyDO7cWypGiN5NGReqoZWSMYhAoDttXob1QgPU2GYg
 TBgpqgk5gepntKBvrAG5p3GUIfWT4JHwSz0brvJAPtke9Ew69eKCuvwoGGtM/spU44gd
 epq7aDrySVNcTknQzab3za+QtzTCV5l2FE1kft1yb1gi7nFF86E8uWFI6mZDuLoE/ea6
 Wzx2Qs2WDFccc46d4kZ19c9YTroO2quMvjLPGPcaxBHaPlk2G+Lyk3Xe3AIhm/okdlV4
 csQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782730725; x=1783335525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlVFu+vghXYRA8+TWIE8jJIhLBygLV0wbuey3RcLvOc=;
 b=oI+MPmOL70T/tb8sL26bgLKlTDhnTO0Egs8p/9VMBMUwEWtb6EE8mKc7j5zTl7BWSB
 NmINK/NNvrPOXzWeHxXdD6/AUtfOA89k1J49y5doXxIPEAGFDbV8jsq9kYvmF5x/NtDA
 YY1UnCndLE/NZTNq1KyjsbWovRLPimYLpQgPC9AAs0sgUDYL3ghekxzfurtZ3mYfKHfo
 VUSHyMCZ48Cbn9e0tm2lDQ4At8IVNg+tLaKhzk49902K/xxI9mSwDOK5XYzNkGU07nOs
 fV07hdcIbus4LHcsRvRDqRfyq9F1OwhTf3Nb9kznFIE4unLjcZX3b5hM/6wca0E7fJZw
 eQnw==
X-Gm-Message-State: AOJu0YyFhI+iTCd0DyKNotxcvWki7unNyYuW9O+lkRmLG7Hio97KR+rC
 qtEvC+4AnrXqzIallTvIG/aWhvES2r0mHFK2lFKdLIvW+vJUOJwORW6yAsbNns0Ndtg=
X-Gm-Gg: AfdE7cnFpyajDih8PkJ+bhsQJX7JRT3S9JHOpNuxpsOkxDDBM0bXtLTJl60sJPcjaJ0
 3yteMfqoYwGmZ9xvJoNXB5LadbeZB2EicBoyotTN5xJANzifufdA0h+sfAW/OwKWRWHf6aoUr8j
 zJhh8RKRPg7pZnx7Z9aJT92I7ob1rJOmvMy2lE6s0UnL/VL5LDQcSkVIxQzWfXpyWeiYoYfwoyI
 nw+Nu3GV8c7DGhJe0fGiSxdassJ2IzMR2BJm88VJCEykDWGxF4PMh5PlBU8d1QPhDSY72kfEad8
 /Nq4HY7BV/kJHqpyAI/rLKOpxRQXEqWrTPE9l52eVcrLjg+/1CSRBM2O6zH5AutQhf7GSJGm2XO
 vPyN1fzYr5Ep6fqhxoptSg2L95+47yeS4vv5DcTUpbTIjOmSPrWHv5IIE02GYtfo/lhk/hgw+Ly
 3QL8nGrK3eso6EChpD9VmoTes=
X-Received: by 2002:a05:600c:4691:b0:492:4636:87ae with SMTP id
 5b1f17b1804b1-49266880f9cmr243775305e9.17.1782730725168; 
 Mon, 29 Jun 2026 03:58:45 -0700 (PDT)
Received: from draig.lan ([185.124.3.118]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473563c2df7sm10642422f8f.24.2026.06.29.03.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 03:58:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 338185F864;
 Mon, 29 Jun 2026 11:58:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2] docs/system: rewrite gdb breakpoint and watchpoint
 explanation
Date: Mon, 29 Jun 2026 11:58:37 +0100
Message-ID: <20260629105837.71103-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
in a note and warning sections.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3596
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - made the soft breakpoint section a warning
  - moved discussion about TCG's unlimited break and watchpoints to a
  new note
---
 docs/system/gdb.rst | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
index d50470b135e..15233372c01 100644
--- a/docs/system/gdb.rst
+++ b/docs/system/gdb.rst
@@ -49,15 +49,34 @@ Here are some useful tips in order to use gdb on system code:
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
+.. warning::
+
+  Software breakpoints may fail if the memory is not yet accessible,
+  or the guest code is not yet at that address, for example during
+  early Linux kernel boot before the MMU is enabled or before the
+  kernel has relocated itself. In such cases, you should use
+  hardware-assisted breakpoints (e.g., ``hbreak`` in GDB) which do not
+  require memory access.
+
+Watchpoints allow the debugger to watch for reads and writes to
+various memory locations. The number of watchpoints available will be
+a depend on the architecture and support of the accelerator.
+
+.. note::
+
+  If you are using the TCG accelerator, there is no limit on the
+  number of hardware breakpoints or watchpoints, and QEMU handles
+  requests for both software and hardware breakpoints identically,
+  as if they were hardware breakpoints.
+
 
 Relocating code
 ===============
-- 
2.47.3


