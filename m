Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306E7FF886F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeFx-0004D5-Ly; Thu, 30 Apr 2026 23:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFv-0004CR-I1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:31 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFu-0008UQ-3e
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:31 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso1392391a34.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604969; x=1778209769;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m9XwErfiZQHdUZ8oppNNL3O8ab6JouMqBY+QIuvsbso=;
 b=inTY8zLo1wQXh4lkTJBgk56BKCENpiN+R+gkETZ8UhFkxbE29SBG/z0vaU46XewfZe
 I6B86n4ctC1HaAXXF3OZ0xts0SxvXaj/Q1RKj3GC93TrCRakXGkNdp1y4rsop3ZLSygA
 yP57ohF/vQiAxSubHX4DghABSBycoAjWI+qEi5+qtNuYe3PtdNAmTtLzWQsv5YEanoYR
 f0qOeB4GsAOnxL9VAr5BqECdaJBQjQl04iJ6ajZNRgK6mKH/t9Vc0F8fxtxY83fmmDSH
 cgrMLVIk4GyDs1SCgFLKqQlG4nthyFNaphT0cJzksfIMScxjAp42FG5EYdPfmblhsPfO
 V6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604969; x=1778209769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m9XwErfiZQHdUZ8oppNNL3O8ab6JouMqBY+QIuvsbso=;
 b=XnhnpGVMwjcg2k5BM47ArnU1BVmC4NQQNNPgsXir/55FzAZGTCLWzD2Qe1dvijgg/X
 mhX1CpqKmwWBFuzdzDRBQ4k/istb4iDG2uFsGiR7aTh35J1A/dy9SrJDGvu1b8lgczV0
 /Tg5T0kylkhTDVCPAKv+OOwkwKvFeM4s0VlhmRvafj/qMNytzfMiuhdv+agEDSrteV3M
 yer1m7fosa3athmm1VnAExSM8lO+afRr07NuVyvcxqwcZpN9lpX/0nixfmJBNwKSY5iH
 ZqHJ65Q0ZNyaGUIgGdAYYMLs6EXp7hy3OAMOFnjYH8cHKvcH8RagHx30xrB6RxMlRI/s
 eI2g==
X-Gm-Message-State: AOJu0Yz+bxxAuROXOEpa9ULJaDSh14lqkjraa58S4WhVsSVztIlXX2uz
 U3Xp1dw5x9/L1oq/aFd3SMqAHyFyx8jjkbLj4rj7KpYQPzEtC5Atnw2ZzyY3zkgeZHo=
X-Gm-Gg: AeBDiesqR2rEnqeWpNlikAkqmSCa2t0UXsUEitil1OOCdc4cgQvN09QAiJGzFYT7iMR
 ANdkx1XH0BXzTuxmOjLrwwrIeymzZrW8AOl95equGwAmESMc8ru3mU6m+k9t2+HyFROXN0OqkyL
 A3cDecHFdBL7DIB8xvO4ouZZj97xNpTYybPf0hRviDDhYL56jGlspjcAi2xmGroxXbjNYEoQqdC
 ppDMXIW1aoBKVsFj04T1ngHO4QSOm5XrQY5jR+NhTxWm/zlS4yrQ4EB1DHeNDWoNA4c5Y+EunsW
 yVMv9t6eVW117n2V/xxJBrCZyUHpHnyoFPZBDjzwVUk0Zgu0amnl3wO3xZG8YJFLQ8eCdW/gbCe
 KSkzMtyGaZik7CKAHY1mJwzLx2+83lyntfwPNecbrJQPnvBn1lRkEm57nHAzEbkgKszAOt7XTZb
 whQhw2ktsT5ftodm1RYzmz
X-Received: by 2002:a05:6830:7308:b0:7dc:cba3:e8f2 with SMTP id
 46e09a7af769-7debde0dcaemr2903154a34.19.1777604969026; 
 Thu, 30 Apr 2026 20:09:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca278d0bsm1238476a34.0.2026.04.30.20.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:09:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 21:07:38 -0600
Subject: [PATCH v4 3/4] bsd-user: Create os-syscall.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-syscall-nr-v4-3-80f512079a16@bsdimp.com>
References: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
In-Reply-To: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=uCV1VOv1XBSO7FkvHX+XqSDoeCNUcHfhnLIQTYjRcZM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BkERWTITcWUv50B2o1TSjh2+f6eUAl7+SjEj
 +iOr/YxLCmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQZBAAKCRBsHNEofbAR
 APP/EACcFPHyqf0cEmrxa9+lGDlSUm6YynjVTQbiuHNbigqn4CMoKA75VfWxL+1oz8U4X+SwBXb
 jJDLb4bnDfh1OEcUDne98KUCGi0vuW7Z70P/48WyGf0hwCbAE1sIxJBK3An/GmraY0uqiB4zeHr
 1XljSrigPMjj8iqA5LLOGVtgthJL+rpvFjRrIseNfz5m/gy2DX2jlQhpiJnhfgc3Jd6UaDd5Pb7
 tmMl5R3RuDHbxxvz8Ed7b4aZ8Ftv5y08ZDGHyZKxaaCHEapGoq5b/ClWr/dlyqYjiaT+Vevyde3
 aGnWmqrea/lVOzuZ1TBe+TRsQ/kEC9L5pHX78wZlUBpBQJoBs5NICktdrd44Aqpoe8iSCRHo1S0
 xFm4j9RkwpARwJKVenuC3WubThYW1g2Luh0mBFps+cdOEse34Xw3Jcvo/WVJ9FNdQLXyJW3C1vP
 lpZAdfY6Rit5lOBxcTEjuJ91RT6IKnhunX6q6HuuOZtly6wgFcFECiLGw+XOdZ6fQxpIU0qgV+i
 z4qLDPyE22lnwfqpqmDt/I7HtZMin+4rD5d45gpe4g23vd0LZ6vtyViIvfrXV/iJqVJcytbrTif
 h23p9DLnuUtRTKyQAQuiK/m/X+sFORPUtBJef/eXRyt3MxTBEonFdhGgJD8c1h01343SrF/hVRy
 mQY6SOcx5itzPqg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


