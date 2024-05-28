Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A7EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUi-0001W9-Dj; Tue, 28 May 2024 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUg-0001Um-FK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUe-00070Z-Cc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-357d533b744so813748f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905279; x=1717510079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cix61aPqu8KvNLcJRTXQi8LmaQzXhkWR11FG/+cNvi0=;
 b=LMDnWw8JnxOoRF2pqsijhJnw717kJke9xP83Z1Vn0AE2pVdNuZ+/tn5/+6PxfTvPMY
 LTxIf1LGWjBUgYUXwNpCe2THaG9Ewxco3sDLhv0TqAGvoVFRMSYtchV2rbd29+o1LEFf
 9ynpQharuWnIa9qXHOFvF+bZdPDWoZ5sTPQ2N8OrdMFhW9O6CNl0xhBtDGYaNXzo4zOc
 ur43O1Z05eEbad2zank4QbUn3/pxBpfgeXc9VWQOENwovp+AxiqqBwjY6giW5JbL4tXW
 mLNkI82AjA5ps1b6gKrcKhCQOB/3mrcyxCJWdU3Wvhwk+ey/a5gsoJNnlrRiBjCuQ4+P
 dD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905279; x=1717510079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cix61aPqu8KvNLcJRTXQi8LmaQzXhkWR11FG/+cNvi0=;
 b=jdBh8wZ2blerELxIdwqdpNQ8MW4WqOpSFDgyFh1Z1y+BRAY1C3VRuOXCjIasr2XY5X
 gGi7TZX1Bf4aZ44PIwlcwXzuZg3BwUQrZgeJU/IgvbercOFlzyDKxj0+hdFdkxXgo32D
 DcwacZBIzhSmur62liCOKTOHE7zgt8htu5Db9f172V0q9EndibOPO5Nrwr48xB+xoVNR
 mVtA9Axn+dAL7P7mMOlJMxLIJWcr+9I29Yz2YKfRmojOBMAuqTPKp7PSQvfIc3qSm8wP
 3Rly5dsd/T/6hdPmoNoeWMZ8kjmugXyfwhRIVYemBItcQu7HjMtOi7NbD3oqXUuwDgJ4
 Kq6w==
X-Gm-Message-State: AOJu0Yww/UQImn+m955+cl3cm/Z6mogwL15cWJI8W3tVRzrV+/1twEcF
 S4/RhAFgmh9cFfB7FLxrCNjO1LzuylHxQ222AWb20VB3X103BK/3ukgtqhJhTLyOF/tr+Qev7iL
 y
X-Google-Smtp-Source: AGHT+IG5zdJy7zjm6sDaJHWYSG3nZshYG0orQbSzDa6KcjSmQGny9P2ulGojgBXnYzRoh6iaz8+HtA==
X-Received: by 2002:a5d:6911:0:b0:354:fb2a:7daf with SMTP id
 ffacd0b85a97d-3552fdef9cbmr9002016f8f.57.1716905279101; 
 Tue, 28 May 2024 07:07:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:07:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/42] hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
Date: Tue, 28 May 2024 15:07:16 +0100
Message-Id: <20240528140753.3620597-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andrey Shumilin <shum.sdl@nppct.ru>

In gic_cpu_read() and gic_cpu_write(), we delegate the handling of
reading and writing the Non-Secure view of the GICC_APR<n> registers
to functions gic_apr_ns_view() and gic_apr_write_ns_view().
Unfortunately we got the order of the arguments wrong, swapping the
CPU number and the register number (which the compiler doesn't catch
because they're both integers).

Most guests probably didn't notice this bug because directly
accessing the APR registers is typically something only done by
firmware when it is doing state save for going into a sleep mode.

Correct the mismatched call arguments.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: 51fd06e0ee ("hw/intc/arm_gic: Fix handling of GICC_APR<n>, GICC_NSAPR<n> registers")
Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
[PMM: Rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
---
 hw/intc/arm_gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 074cf50af25..e4b8437f8b8 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
             *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            *data = gic_apr_ns_view(s, regno, cpu);
+            *data = gic_apr_ns_view(s, cpu, regno);
         } else {
             *data = s->apr[regno][cpu];
         }
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
-            gic_apr_write_ns_view(s, regno, cpu, value);
+            gic_apr_write_ns_view(s, cpu, regno, value);
         } else {
             s->apr[regno][cpu] = value;
         }
-- 
2.34.1


