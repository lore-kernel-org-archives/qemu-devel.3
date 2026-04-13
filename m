Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFB2F34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJIR-0006W4-Ua; Mon, 13 Apr 2026 11:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHT-0006GA-9E
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:33:01 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHQ-0002xr-2D
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:53 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dbe437b072so2473192a34.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776094371; x=1776699171;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GM+VfAUDmtSj8y4orryZtYG1iLpOEqhbXeQi5rkOvMM=;
 b=Bs7tn0YZ/5QhyRG6Lb6A3jVP/N+FSDeFZ9vLkOqSLSCC5oA+nG02FQkcbNMIC8zffx
 254TAQcJpBP0PUoDt5o+PCs4fO8mpmzhUiDRqdsyXBJnBip17UvBuwE6748fptERKIla
 0KlaCiBUNNpU8QMYz2hkqqAzLtRLXCvoCWDHaWsVNLA6kg+r3KT+yVYDosxy3ZYvEkgf
 0nVl+UUejtgvA+HzL1kjCztBH//AEIFiKBmmiAJClhiXOo9SeBtIF8Wb9x4FPvH38w86
 fyIxu8GxrjFRhJzTtSjfVFYzHbpbo+X++1F5oia4hDr/ixNHz6Ghv0JRnVWR7M5I6vuB
 m9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094371; x=1776699171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GM+VfAUDmtSj8y4orryZtYG1iLpOEqhbXeQi5rkOvMM=;
 b=S9MkFi+q+1tE4r9+tsJVznw/ALij3vdgqW9BK87odjUyQPnB5FV5MUqXtafj8Lb/Zs
 SbCc9n6+GqZ59IKIYis5if+4Hvyae5EV3aSRvTjcxdZv5YxPUcK6/wCPo3ceqJ+tLp95
 qE7jnPFdEJA23CgpOja5oXVSYwiN+b4nAGUGGpoHt/l5Nsr79/J98zRJ53vgvFzYcJ9p
 26PN7E++rz2COfgXi5iZv0dDlUd8dNhVbzoCQQc0F2GST/JD6B6WivXbglx0eU/ceJe4
 JcPmsjpavBnzNC9xyjqTA1TVXz50kLCe23BM3f0/a+OoXIe2yb9f8SKw6leiuM5+gydP
 8Wxw==
X-Gm-Message-State: AOJu0YyyRx6EB5HYReHyIiU5hnKKd9ZNtbt9uYP+TmNp+KzEmDdIPbyd
 9LUfajOHOd+HtvY4bgYfmG6qwuUJze4TJVHbSnu/CLpDIy8CviU59tviVnNpxmI3ljbFsVWq9OV
 MNnz9WTs=
X-Gm-Gg: AeBDietnVLxrO5vfKIAwVrH6+zSu3G7vECZAIpPzVaVb/EhZc8XV2+YMReBYSPxTCA8
 A4qp0dsDuY35G15KrKvsaOgIdS4uzhFw6ZmJ1K0AvndiIrD4+1j6GkxTlYtl4fCOsgqdgN+Ppj1
 Vpe/czzD6x/jwHMyDS+jv1LvRDBIoATEAsD6GH5iVG2IASPLli9Bw8/Da7ziOmYzuy5A16lvfx7
 xIHT+JTU5OKgXdPh7sDF/vivd3msAR3Vf+GvUWpBCVSmu2zpiRIcLMUTkp7tSpPnOg/dghMEFpC
 X2dt0o6J/foz8tJUinoTEDMtDQiNZttFwJwaWy2jWjxifqbNhckcj6F8OzcFLNGREiANaVHAxXi
 Ek9iRGHJu4qR/IyQIeA0F06oRwxiMSfTpKoNVFBSJb+KqqWEVVg64CL4zOGumOBPSsYly6apeaM
 oOrXBZ/lfOrg==
X-Received: by 2002:a05:6830:388a:b0:7d7:f623:680a with SMTP id
 46e09a7af769-7dc27c63d71mr7687555a34.2.1776094370817; 
 Mon, 13 Apr 2026 08:32:50 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696c463sm8659192a34.23.2026.04.13.08.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:32:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 13 Apr 2026 09:31:46 -0600
Subject: [PATCH 4/5] bsd-user: Create os-syscall.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-syscall-nr-v1-4-f70408d042ea@bsdimp.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
In-Reply-To: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=XrvB42cdUbjGT/6e9K7hXwzF5dDYegII6Ryw8dKYaiU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp3Qxp9bNhU+oM/BKuX73NakEF06mgh/Z+u0wJ0
 va9iLqjXOWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCad0MaQAKCRBsHNEofbAR
 AGQ5D/4nIffE5t1txzeETY+Wr3v3xZBr8nmc5iH1esiwua80qDQBGDWRnZvPIjls//dp9/TO4lV
 NMuHamoz1RxcSJwQN9Kx7EFx/Pi9ikgd2YkwSgFr+TnXCU0PBW0hxMgDrWjRVWCV9O9ATeG02Xj
 Hm+iqnrBRlURQBDj/EQew+twV2PsrqpLFrEruJhmUvJWtPu92d1VBFm+XwP+F9OppoXOaU92h+Z
 Z4sBdtsBPb+Ab0eQ5xCq0nz5AJOQ2GkCxu4FmisZUCTB+5QNNT930vcEa/EUZjcP1V5EWCPhgFp
 KXN+3P8stWWam1B1iFx0vS2Mq774zCX722imy14fHUwJdmIUsCpuGuHVgfSI8gk1J3mop/qyTVA
 oSSzJyQwnOBvgK86G7SPRDl8ffMG9OIbXj8iCRZ+Sf+oWPr1ABAOhZJQ5t5cRiOpW7QIlS8x5qy
 HmjSVqh6ieWt/3X9fbLKTNuXdBamjM5XtGfIxWnFshZa1KVtDqvf3DmWzs45AXPAlnVp0AOeXXj
 oIH8ZKu4PwlX8bHerUFrRvVwcZPzgGUT/50Ttcy6cTg81GKmmGIurlhgnNKV+XosbJAMluAq6E0
 yQrd/gArHyaageZ4SRsZMiANjI8pMdEAsk26GEmrO8xbMb3gxZbaqRmpap4lmrw5Q3P03KZ0f3W
 tTncED97jamto5A==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Create os-syscall.h. The purpose of this file is to define anything
that's different among the BSDs, like system call numbers and
time_t. While there's a lot more different between the BSDs, this is at
least a start at capturing it.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.h b/bsd-user/freebsd/os-syscall.h
new file mode 100644
index 0000000000..962adfa91a
--- /dev/null
+++ b/bsd-user/freebsd/os-syscall.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2023 Warner Losh <imp@bsdimp.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * OS-Specific portion of syscall_defs.h
+ */
+
+#include "syscall_nr.h"
+
+/*
+ * FreeBSD uses a 64bits time_t except on i386 so we have to add a special case
+ * here.
+ */
+#if defined(TARGET_I386) && !defined(TARGET_X86_64)
+typedef int32_t target_time_t;
+#else
+typedef int64_t target_time_t;
+#endif
+
+typedef abi_long target_suseconds_t;

-- 
2.52.0


