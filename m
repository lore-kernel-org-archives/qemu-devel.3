Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AFFC02190
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCQ-0003xZ-UX; Thu, 30 Jan 2025 13:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCC-0003rX-GR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZC8-0000Tc-0u
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:20 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so667018f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261391; x=1738866191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LiTob6eVO3/nTRL2jXJ4ehBWxJYYOLR6mf/DNOwkNQk=;
 b=g3GJIW6R2aBGGIsRpXzYc4P1aM3MkIfNytWCycnN/3qhBVXnEKSqw5EKruI73x6D4j
 TFZrpeQU3ygF94oIB3xQW0qWvi3BUnCPy6aNHn5R0fZ8x/WLDWwVjkAcpAVBfF1m+O/b
 u+ZjZlSkZdpN6aWTaddjglQpjnLzkFnRGQRQEhFZNrrI/k1k4vHkj+SGHd3yX3L5V6bm
 Fy3SQvlq5iBeZlcYoCToaEGT/A9+iGtxYmVQlZHbryuxWX6g/si3HZXTD+fm8QkRGIuk
 B2ANs3oBEP7iXz3WDwne/dTL88knkLu66Xc/R2ur9jetnZASzQRReOWjIzmOgDRdXWAc
 AWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261391; x=1738866191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LiTob6eVO3/nTRL2jXJ4ehBWxJYYOLR6mf/DNOwkNQk=;
 b=g3IuGcKYuJcTk2KQq4MxubBUItEnISABt1/ro+H0d0lPMe/4k4Hdca42cX3OGYBcpg
 J9jTkALiLQbpBKqSlOwtK5mTFP23GobITtr0z0RIppf8DLXLZoA5azxWZDHFVdC8C4Q6
 RgmLoFziFk4nbCmzgbymM0dGQX/uI3lg42WVN7W8dDt2cG1/euuERSVP/RjIBzVtvigJ
 /8n2p4NwhtyAKAbTCGqnByfp8jAsHLNawTiwLrejzIHP7c6L5IMKjIMXfsb7+cfQ9pKN
 0QHy78t//f/7AC+1BYaTMV41aiZvjRTzXq2Lo/kxmq/JykHc+a2K1vy+sTI7XooWueWN
 1q/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXExUcJtwxBG+lSh1bHDWY2952SdD0Ir3e1Vh1z+gtp4MzB5grJRU46aNMHUKjIu82SVLn8P6aw6z9L@nongnu.org
X-Gm-Message-State: AOJu0YwqLy/y/RJdVZBELPAkGaypexD6fUZuI+ur7x4CNGl3xwf4G348
 XjtcTEsM93D0+N3SagdwWOzWpJVQhw1FCJBy3t5/XGxaMOnqmtmxqk8oLY4gZ4Q=
X-Gm-Gg: ASbGnct39V5U0+VSEmqSD05shcEhg8TJKMVjqHDx875NDA9pwiurlk32iYd7hSRv43Z
 IC16a0V1YAo2s38OwYbIew/W+kjQd8LJveiml4OXmszMP9Kp/BERw+9kjLdY0Pcv2S27lNJDbs8
 9MQXCZQvFy5kH9hvbndq67V29CjVvkiVOTvq7aOJy0kG+TOQ015nQR8Czjv9twfawrjpTWk9CJd
 VlXOGMKjK8DzpnuPe75HFWp8wKIVoEAiXxxsLgMf2D7cCArerctLiQ4F1oyW4EqkDPEbyFdg1Wz
 os2e5prXtF0WDucy0mMcOQ==
X-Google-Smtp-Source: AGHT+IGD9JikmYxLrxdEHhCKfC/JKg4qUSVgE4ZzgaMQIiGe+xzVUCFdOFH2xg//iRtdmAzcwRmylA==
X-Received: by 2002:a05:6000:1567:b0:38c:5bb2:b91a with SMTP id
 ffacd0b85a97d-38c5bb2bd03mr2815729f8f.17.1738261391471; 
 Thu, 30 Jan 2025 10:23:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/14] target/arm: Clean up some corner cases of sysreg traps
Date: Thu, 30 Jan 2025 18:22:55 +0000
Message-Id: <20250130182309.717346-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

While reviewing Alex's recent secure timer patchset, I noticed a
bug where it was using CP_ACCESS_TRAP when CP_ACCESS_TRAP_UNCATEGORIZED
was wanted, and that we were making the same mistake elsewhere in
our existing code. This series started out as an attempt to fix
that and also rearrange the API so that it's harder to introduce
other instances of this bug in future. In the process I noticed
a different bug, where we weren't handling traps to AArch32
Monitor mode correctly, so the series fixes those as well.

The first four patches are fixes for the places where we were
using CP_ACCESS_TRAP when we wanted CP_ACCESS_TRAP_UNCATEGORIZED.
These are all situations where an attempt to access a sysreg
should UNDEF and we were incorrectly reporting it with a
syndrome value for a system register access trap. I've cc'd
these to stable as they are technically bugs, but really the impact
s very limited because I can't see a reason why any code except
test code would deliberately attempt a sysreg access that they
knew would take an exception and then look at the syndrome
value for it.

Patches 5, 6 and 7 together fix bugs in our handling of sysreg
traps that should go to AArch32 Monitor mode:
 * we were incorrectly triggering an UNDEF exception for these
   rather than a Monitor Trap, so the exception would go to
   the wrong vector table and the wrong CPU mode
 * in most cases we weren't trapping accesses from EL3
   non-Monitor modes to Monitor mode
This affects only:
 * trapping of ERRIDR via SCR.TERR
 * trapping of the debug channel registers via SDCR.TDCC
 * trapping of GICv3 registers via SCR.IRQ and SCR.FIQ
because most "trap sysreg access to EL3" situations are either for
AArch64 only registers or for trap bits that are AArch64 only.

Patch 8 is a trivial one removing an unnecessary clause in
an if() condition in the GIC cpuif access functions.

Patches 9-13 are the API change that tries to make the bug harder to
write: we add CP_ACCESS_TRAP_EL1 for "trap a sysreg access direct to
EL1". After all the bugfixes in the first half of the series, the
remaining uses of CP_ACCESS_TRAP are all in contexts where we know the
current EL is 0, so we can directly replace them with
CP_ACCESS_TRAP_EL1, and remove CP_ACCESS_TRAP entirely. We also rename
CP_ACCESS_TRAP_UNCATEGORIZED to CP_ACCESS_UNDEFINED, to be a clearer
parallel with the pseudocode's use of "UNDEFINED" in this situation.
The resulting
API is that an accessfn can only return:
 CP_ACCESS_OK for a success
 CP_ACCESS_UNDEFINED for an UNDEF
 CP_ACCESS_TRAP_EL{1,2,3} for a sysreg trap direct to an EL
and everything else is invalid. UNCATEGORIZED traps never go to a
specified target EL, and sysreg-traps always go to a specified target
EL, matching the pseudocode which either uses "UNDEFINED" or some kind
of SystemAccessTrap(ELx, ...).

Patch 14 fixes some issues with the WFI/WFX trap code, some of
which are like the above sysreg access check bugs (not using
Monitor Trap, not honouring traps in EL3 not-Monitor-mode),
plus one which I noticed while working on the code (it doesn't
use arm_sctlr() so will look at the wrong SCTLR when in EL2&0).

I've cc'd the relevant patches to stable, but I don't think
it's very likely that anybody ever ran into these bugs, because
they're all cases of "we did the wrong thing if code at an EL
below EL3 tried to do something it shouldn't". I don't think that
EL3 code generally uses the trap bits for trap-and-emulate
of functionality, only to prevent the lower ELs messing with
state it should not, and everything here with the exception of
SCR.IRQ and SCR.FIQ is pretty obscure anyway.

(Tested somewhat lightly, because I don't have any test images
that test AArch32 EL3 really.)

thanks
-- PMM

Peter Maydell (14):
  target/arm: Report correct syndrome for UNDEFINED CNTPS_*_EL1 from EL2
    and NS EL1
  target/arm: Report correct syndrome for UNDEFINED AT ops with wrong
    NSE,NS
  target/arm: Report correct syndrome for UNDEFINED S1E2 AT ops at EL3
  target/arm: Report correct syndrome for UNDEFINED LOR sysregs when
    NS=0
  target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be Monitor traps
  hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps for AArch32 EL3
  target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32 EL3 non-Monitor
    modes
  hw/intc/arm_gicv3_cpuif(): Remove redundant tests of is_a64()
  target/arm: Support CP_ACCESS_TRAP_EL1 as a CPAccessResult
  target/arm: Use CP_ACCESS_TRAP_EL1 for traps that are always to EL1
  target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR traps
  target/arm: Remove CP_ACCESS_TRAP handling
  target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to CP_ACCESS_UNDEFINED
  target/arm: Correct errors in WFI/WFE trapping

 target/arm/cpregs.h        | 15 +++++---
 target/arm/cpu.h           |  6 +++
 hw/intc/arm_gicv3_cpuif.c  | 15 ++------
 target/arm/debug_helper.c  |  5 ++-
 target/arm/helper.c        | 75 ++++++++++++++++++++++----------------
 target/arm/tcg/op_helper.c | 71 ++++++++++++++++++++++--------------
 6 files changed, 107 insertions(+), 80 deletions(-)

-- 
2.34.1


