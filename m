Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340ECCD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIe9F-0001Ff-07; Thu, 30 Apr 2026 23:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe9D-0001FB-LH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:35 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe9C-0005Xy-A6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:35 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-662efd1bdd4so983236eaf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604553; x=1778209353;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m9XwErfiZQHdUZ8oppNNL3O8ab6JouMqBY+QIuvsbso=;
 b=Iy8NIpxO7/jddQkh+Q+1ysDbHsF5TKzSxF9EWt1Fo4gOk0uQZQ37Gty5J42pAVw+8B
 JJ3LNjaxcBlwtDcoQGov2b6DKKQm7KDWJSBGuV4nDOh3IAWrG2/LlaaqnmVpDJAlu/Pl
 Qiaz+QdCp7vyiBsOHipLOeBI5cjoc060Xet+JowGXP0inGb4J02AGEdyvT+a9VHzm5Pn
 cFpMTI46IVTg9bCVr/QKyoNGubHODECr4PKuwbZaXKXtXLUtyw5sftbqrIHgKIOZ0AP9
 +bYgcF7LcGEaszCeRR71WOHch2DO/Oi8DOMk4tTEa0FPwTqsFivh8w9KA8tCfzOKmg1z
 wKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604553; x=1778209353;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m9XwErfiZQHdUZ8oppNNL3O8ab6JouMqBY+QIuvsbso=;
 b=C43z7qiJtyOmwGBuIAsP9q72i3WQqEHI8fjCTcRdHbAbeDsXlgr6GwhBzaBVNWTvR+
 aMq+rjhK+2QbhSwoIc198R31ctTpCgQy2wSi/Yj4duKkoxH6bJdPCmdAYQWw7yxsTMGi
 pHG2vwdLVHBAx2WJTibyymMR5IUL9aJDzFQV9Dnxg0azNbj7RtOsPrCQEVHIs553Tn58
 4AOGQOpyzKejUl65wR326KWvrIplklVGdLfbxbuE4MA4cDI4g8HysZrgmNpFWhT/M4Zw
 RqC+KCxPD4KmAr5OuM7i0SUdQhxDECqePffJ6MQ+zYI3NWuIrXwPnZrj6NGUtddxM3GL
 gmgQ==
X-Gm-Message-State: AOJu0Yxj/GzCIOUDDrTI9vQXSJ+dd+WYy7LitYOmYsaEbImdt+jhhQ+9
 CS7vfw0bxkEVV0lvf9DZr6iU3slk9795yfRwbzmysjdWLzLJNPMHE8M28SSlQSoG9Iw=
X-Gm-Gg: AeBDieunG5hN/K/upcIDc1VK++DBcrlXdzaLREZUw5xoGQ3MSNgSoXzvUXs24y03YKU
 JlrGuX9dsbVTh8Ws+6+J4V8bAHnIxQMBWdaejD6ofNkR3sQ/z0rIyE+DI62H0fy2M/jVTnRRqn8
 zbJzlMAHoYufgs0rAceshewMkVqsugrgMMzGljJRxco7Qg6hVbY0gfrzgxoFVAnayI/STQ4K5hr
 vTOhAB9cT5/+mCshCviEnJxD2drg1zM+noB3WVR7/PfacNzZT5fn+/xstfS5BmBaRtMqplhm5Qb
 0LAyM+9OjaBtzntILSXiIsdh5Xq2EFgvxiamypJOb9aqylAm6GB6ALm2Y06w2T9C5Te4JKSg7td
 XRmftL4K/bGFJ1RRVcM/6DM4K/s5yuL/r2YgFRQKxMolU+0FGaErs9P7vqVEHhf97FT1TnLDQGZ
 7ZoSHNEvPsaPgEytqqvjjA
X-Received: by 2002:a05:6820:2229:b0:696:2225:d70d with SMTP id
 006d021491bc7-6967bd1bce5mr2285759eaf.8.1777604552816; 
 Thu, 30 Apr 2026 20:02:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbc3c7sm1550875fac.12.2026.04.30.20.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:02:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 20:59:32 -0600
Subject: [PATCH v3 3/4] bsd-user: Create os-syscall.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-syscall-nr-v3-3-4b1b2445e28f@bsdimp.com>
References: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
In-Reply-To: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
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
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BdiO3MVSY1TfY/5xcZZZof8pxJYQqfK8cXRu
 VMLaIqt1RyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQXYgAKCRBsHNEofbAR
 AARQEADgZXApaVNSHJCi15mLFwRtc7FVH+G8SW5TQOtbhq5Sww/JDfoAJAjbdLHTWnAmYuWhoFT
 lZ0FQTxdm5bjnzNWQpXU2FMdnoC9JgwCPYpUXGnzM/GcEQnkERul4IdNnlxXmK9CRjseVnYME0x
 BLVu108VmE06qEdQvYInIoXchw4VVd52+opA8dP3nHk1/QT7B7FBz2rvzbWAj2w3DaUDc+rVM0K
 0dHx+/ArT68MsI/VPT/tWt00e1gUeGEIb/Gk/qsFw8HIJ2hKM6Xm2LVp1lPuJYCOeyBUefsCngR
 2IDFuXhqJIimdPmFEck2kvGVR9Psn9UUiwo88OmtwiL2PipC5WcDN8M63dYHQ3dZRYRNO9Dozyy
 aEE1wA4lgh+nJCG95IO54ptugx6mhS6Yf2ljyx+YkLOW4v3ELUIpLv2/RRQuYJNlevsVeXd6zaY
 jM334tnx7r4qz9Bi4jxTK2D7PAQOJqJDztI0qK7pv9GSRt/v3G8cI/yJtwLJVoCe0gmHukKu2lS
 Q3F3JSIkLeRLibQU+zqWkG301bwNirk3KZGIYx4KgBkWv5kb4XxTRjDFBwHdDmp2SaLbBGx4vh7
 bRpKikv5pGze7fRuASgDStFYFKnRV0ZDg3b5T9UymdLYt+1fRa1CPkAM0x9z4Wok/DQJysvDKVk
 OlM2GqrysGGEb3g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2f.google.com
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


