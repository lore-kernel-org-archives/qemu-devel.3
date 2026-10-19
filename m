Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44811CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xInDz-0002Y0-QN; Mon, 19 Oct 2026 09:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xInDr-0002XY-9D
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:16:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xInDo-0007Th-4D
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:16:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so15834745e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792415770; x=1793020570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlNdWmKSPZ+DE91bVIS7bFXurCASPtfjAJrPA3jfpe8=;
 b=JCVfy/zBtIRYiXCsHY5bihxNLr/sLsl7xCudZceViswv2ZX+t+1BtTaf87UEGU2yod
 mwBkB67hzx+R19JCn5uY3h7ttox0ELT19l+wqubyuEHqSwc6a7OEldsLSLwsoty3I97Z
 IzNuqIGGfOD1ECe9CwtuVmPEa+RUoc7nD4nPUuhy5i9MRrzxnIvofH9pax0AUBXXlndU
 428e6yHdeVGhhrKHC7F7d7LxGiFXXFmbed5lcWJUp4t8cCN1heeDRlTc4AL3madn71Dz
 kXeJDo0/PMhJnZHHkk3kTS/cGNIFvd6gB8omqJlm7TPyBSAq6yXFzblZcXjrvTUQVEdO
 25iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415770; x=1793020570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlNdWmKSPZ+DE91bVIS7bFXurCASPtfjAJrPA3jfpe8=;
 b=Kb1XD0ASEZuHGn1YTpIbumQrKi4l/QPGVx+9X/iYeZHEQzc+RD9YqXgVn6Y8EES8L2
 UA+xOAJ9SGBxliShX8Iy1tBPrCRjpGA5x6bihlDCx75furBWO+IHiJQvYbdDVAbI9fu6
 ljreodYNPxR6SGX8XJyJX2R2GVHtRgaFR3gas5z/xf57y1qRcb6OzRc2sN3GEgwcEr5Q
 kiJSrwsqicHxDukJu78aOjLyZG/58d7bmwiJK7eR9UOeZ36WoBd2nf95PkTOFCJHBhuJ
 JGE6FyLcCZMAE2Equv0IzfkgAgAqdbZwKM/wqTnlMLL7N/3eCG8pPC1tPsxrXuE/JX09
 XVPA==
X-Gm-Message-State: AFq9FYIapEV1JwhI1FGX5AK+Lzkh3DqjHut/EbyXzckXTvu8Mmal7sJG
 1xQNZUdnBUFKiwnFWdvWwF8ZHONG+7JI5c551dhlVfRriDEbXKDQ1mYli+o4QFOJg78xmzD5/vi
 vQ+3rF8c=
X-Gm-Gg: AYBFou0nvx7cgPp7ln1sa9SWLy0GHkjGRjtgAtYcgxYLRh+QYKMgS726tO8zFIGBWhf
 FIjhEaUBPpPJeDYtZTJDqXT8LHqXyUb381psk9M1+iKgIILG1ZZ6sBQRuZb5lSaa+r/1lPsxsQz
 LLVM/rRt/DYZVEbNPIpZBHbSoPEqtyOe9BDSEREFNyEt/JRv63ThtjY9+kQlpnw5nkmg4tYhQm8
 3AgMPAL8xr+ZC6J3XarUxpLQ0IdcRdyE6JBNk2qRBQmNUMlgmz9r27TU2HzrgPNBmGMHi2XC8iQ
 9v8qpK1hxgei79DjVz+npi8FoNRWiEtnO7ukZWrLA9jbf05Iu/cmDM+zgSYEAj2WjvHIYMU301i
 pTwVYpk6ZWGkt5w4Byumk0mQY4t/Zbhdyp+O5mYoKG7xoBMkH9BvASf0OA5wx9H1PJQvfRSuO6d
 mmeZcVdD40K/C99bdEriR1mR5CbK6IpA+KVC+S6yH+69xiGb+YAHZfj7o+EDEshoV4meegBYcv4
 amya22i8/Fdq915/Yi1ScYrT4wkGvxaUW3O5k3QgBnx3IUckXqwViRD/iOD2VqaUgGa0tq+SGcq
 8TM=
X-Received: by 2002:a05:600c:621b:b0:4a1:dfd4:9429 with SMTP id
 5b1f17b1804b1-4a1dfd49552mr113004125e9.31.1792415769692; 
 Mon, 19 Oct 2026 06:16:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dda881f0sm167628605e9.15.2026.10.19.06.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:16:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] include/hw/core/ptimer.h: Fix 'version' argument of
 VMSTATE_PTIMER
Date: Mon, 19 Oct 2026 14:16:08 +0100
Message-ID: <20261019131608.3155474-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
to VMSTATE_STRUCT_POINTER_TEST_V.  This means that the field will
only be used in migration when the vmstate struct that uses
VMSTATE_PTIMER has a version_id of at least 1.  This doesn't match
how we define other VMSTATE_FOO which don't take an explicit
version_id, which is to use a version argument of 0 (e.g. all the
common macros like VMSTATE_UINT32 are written to pass 0 to their
VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
how we define VMSTATE_PTIMER_ARRAY.

The practical effect of this is that users of VMSTATE_PTIMER in
vmstate structs which explicitly or implicitly have a version_id of 0
were actually not getting their ptimers migrated.

This affects:
 vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
 vmstate_k230_wdt in hw/watchdog/k230_wdt.c
 vmstate_imx2_wdt in hw/watchdog/wdt_imx2.c

which are used in:
 * Arm imx-based machines
 * Arm Xilinx versal and zynq machines
 * RISC-V K230 machine

Most ptimer users are unaffected because they took the usual approach
of explicitly setting their starting version_id to 1.

Fix the version_id in this field.  This is a migration compatibility
break for all the above listed devices/machines.  Since the timers
involved are in devices where the timer is usually stopped (e.g.  the
watchdogs only have the timer active when the watchdog is enabled and
counting down), the consequences of the bug are likely not visible to
most users.

We could perhaps attempt to preserve migration compatibility here,
but none of the affected machine types are versioned and so we do not
promise cross-version compatibility, so do the simple thing.

Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not cc: stable because it's a migration format change and we
don't generally backport those.

As an aside, is the expected way to write a new vmstate to give it
an explicit version_id of 1? If so, maybe we should look at the
vmstate structs which don't define one and so get the default 0.
Or is that just some odd quirk I've picked up because lots of
existing code uses 1 as its first version ID value?

---
 include/hw/core/ptimer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/ptimer.h b/include/hw/core/ptimer.h
index 4dc02b0de47..8513f8917e3 100644
--- a/include/hw/core/ptimer.h
+++ b/include/hw/core/ptimer.h
@@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
 extern const VMStateDescription vmstate_ptimer;
 
 #define VMSTATE_PTIMER(_field, _state) \
-    VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_ptimer, ptimer_state)
+    VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_ptimer, ptimer_state)
 
 #define VMSTATE_PTIMER_ARRAY(_f, _s, _n)                                \
     VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n, 0,                   \
-- 
2.43.0


