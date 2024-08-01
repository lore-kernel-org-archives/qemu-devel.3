Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0921C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 01:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZgee-0003yd-Eg; Thu, 01 Aug 2024 21:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NAasZg4KCi0JUNgaRLQJaMbXWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--alexrichardson.bounces.google.com>)
 id 1sZdtX-0000s4-RP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 18:03:36 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NAasZg4KCi0JUNgaRLQJaMbXWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--alexrichardson.bounces.google.com>)
 id 1sZdtW-0007J9-7o
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 18:03:35 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-64c3f08ca52so148017047b3.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722549812; x=1723154612; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zM7C0L6Fvwie9kg4zGf+RjPnTtCxOnj1yUYBOTGzzXo=;
 b=GXczwTEAhVhy0QKHm2pd10sypFGWAhKXV+jVBYbHRflqU1oIDS2pI0szmdf5ohFgw3
 YokGjfAMFAUaoawO0YbCd6AlND9mhaS2atWjPSd+PVr0m3BUf4/jyYBPy5+egVd4p+xL
 N4fQhZ/+442hFKz8tpRQ6m1C0CHjZxDz8G6Vs/Jd9ZH+WuLGFs1nUkx5mmnJW/yPf7d9
 S0wCqAVk5LGbPPgkYVU9kQJbtuez1jDDJLDvQWihrsDgFRAPM0hXBagoCnYkhc5zft6C
 UNZuoZYBM6T8NPyOxZgyHd43z6UG+ojtwhuxZHrxGWGYZGGlmN8gzWmjCQm4ZTb+IazQ
 Vbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722549812; x=1723154612;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zM7C0L6Fvwie9kg4zGf+RjPnTtCxOnj1yUYBOTGzzXo=;
 b=j4RwSqPYs2TX/kmwdz/f5Dj4Dnf/Rm5M9bG2YIpz6TpwBpYSyw57wA9j1XgCRBXfbq
 3hjxYSn9JUX2J7DoyDqJOFagDHGKQvW4mxjTNuXb5a+2iLpiWq3WqMyhmuzozCI+CyiV
 sdiaSqFabosmvo2JDRAoMiwUKdtEfgyauc29YVtBP1ZW2H2on0X8e7OlOhObnYbb7grk
 PIVVIomBnywfbCOPu/DK8z6EYF1ECtv96e77l2TjS+N6Q5rEoCubBxvoupXaemqBSOZ/
 jWKhuMG28uB3lOUcZLDkh6hhdpDrzup26fFapZLNEzCCQ75LS0ciwI2GN1z0ss5m7oi5
 RzQQ==
X-Gm-Message-State: AOJu0YxlzI1PwdtiCuxFHr0KBsFvUOgCrNwavR07vBj9ovh+0aqds3kx
 UoIth/W4mUOzOT8itMu+0pajRgt4itug7ePotiXgv8U3HDigAyamNqTnA7KV8q1K0XuJnK3AaBs
 rXV3gJ4gudxYGZ3j3LEw0PDPOeBjp+D7Z9houfhXBPD0FPOAwPwzNICSG+rTE31fBk+ttrxg8iT
 Xcl39str0gle68e3qjfOEp9zuDT6tVNHGNZdCBOaT3qAGDPu/qA2VWvzfgJ8URsskQ3stQFH5ZN
 g==
X-Google-Smtp-Source: AGHT+IECB0eynnBH6XHH8uy+3S/vNaF32tWAs+DzMW8+BnPO0bhutzOr6cpqKQbBXwBmvNBgjBB0DI8yMupy61otVGJ+Iw==
X-Received: from alexrichardson.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2c0d])
 (user=alexrichardson job=sendgmr) by 2002:a05:690c:113:b0:62c:ff73:83f with
 SMTP id 00721157ae682-68964b5ad18mr223807b3.8.1722549812058; Thu, 01 Aug 2024
 15:03:32 -0700 (PDT)
Date: Thu,  1 Aug 2024 15:03:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801220328.941866-1-alexrichardson@google.com>
Subject: [PATCH] target/arm: add support for 64-bit PMCCNTR in AArch32 mode
From: Alex Richardson <alexrichardson@google.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Alex Richardson <alexrichardson@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3NAasZg4KCi0JUNgaRLQJaMbXWPXXPUN.LXVZNVd-MNeNUWXWPWd.XaP@flex--alexrichardson.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Aug 2024 21:00:22 -0400
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

See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en

Signed-off-by: Alex Richardson <alexrichardson@google.com>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8fb4b474e8..94900667c3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
       .writefn = sdcr_write,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
+    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
+      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
+      .cp = 15, .crm = 9, .opc1 = 0,
+      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
+      .readfn = pmccntr_read, .writefn = pmccntr_write,
+      .accessfn = pmreg_access_ccntr },
 };
 
 /* These are present only when EL1 supports AArch32 */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


