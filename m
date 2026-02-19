Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F7E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 05:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vswUx-0002iq-6j; Thu, 19 Feb 2026 00:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUv-0002iH-L3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:45 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vswUt-0001XD-QO
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 00:22:45 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4138136f02eso427797fac.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 21:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771478562; x=1772083362;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NJxocUqXTT7QeMisQeTRzyeyHRAwhOt7frlLYccIkys=;
 b=vpb28lurK4Wzwz/KVMHMAzgAGB11OrBSE9DOCVo87523bWZt4jTGeIgOgWenjhhxuD
 EvfFOOaFUtpb/4cp1FBzqgYtLP8cV1NbxBqo7Q3y6iwnTxlOubJKEJjiDrmHbvINDP3J
 33ebBqAIi+z+rWB2B8ENWP2M1UZ8Qh00xRdqrtxMNhMye845LmBjvIP0XlMvWvcWi9TO
 5conQxeXfebvAmJRpvBFmT5veAfXDqzMJ8UW2PkrqCJTyUgSXqbwYNjQsT7feH+GjN1V
 UX8Am/NiUeiXdpGgdfCbmfOV3LQwNRnYd38RakbxMgw55GQ/Cwx/UlaAIWoE/N5yM5vO
 09+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771478562; x=1772083362;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NJxocUqXTT7QeMisQeTRzyeyHRAwhOt7frlLYccIkys=;
 b=eHCP6/iigdikp3Ecq5IiYa+blU+NwX1b33z8QyRhEuv1BuAFZUPhZugFq5hYCavJ9u
 GJX12MJjfSFmEBl4N073E1XySxJUx2/2MT9aNhUlls2hrCaXCd9eSuEe+wfFaA6Bs6Ya
 yHuj1DZ2C6I10aRX+yEwUYkKzhsvF70kSGZmBD5Yw/ee+DJ1iGuIbXZ4qj8zDWMXLGbK
 McSWermH7a1DKFERZN+p8t/Tv48eET6838OSkY/R62zvHih/PXpMw6fcyBZUEKLbUEPD
 i67Yf902IMiUnWoBc2nIKeAWxaiJk3QiZ0ndOKUtMq0qrI8c1v6lqytroNdcK1dzgvLp
 7H6w==
X-Gm-Message-State: AOJu0YxqYHfFW1qroUV4+lWLypdC775vgvJuKn9892iiEGTn/4yhIjxH
 uz0rVTaVX2RbLXorkJXzoKTbV1tNsyKm8NMqksk0UdohoWsuzS7TqXvqc9x3RT48Pqs=
X-Gm-Gg: AZuq6aJ4vPFxHrM06tLC4VZ/pahP/26FERoNqmNbB3dMpfPnbdflhrtfzbTXMOBxoWW
 0ggFLtBDNUiYQzLpfo+IvGccv/i+IStVLOat2DDI279oNmQCLgosbOLbtxOJmhsk1D/a4+8045a
 XTzsyBk5TixXcTJ3bY7KNn4zt4KYtS82lSd5sofVnQoEoQKu4ZzweEL4mH/cmbggoWCyfwdul9d
 Fz9OWmtZOYXdKNogTvvDZwzkHBcXApPyPr3qvghLDeFn8L33z0ih+wKqqablyvx+fcSfhWzLciM
 SDTKekuVfZUZIWb/SM/q7n22RDlHkocJA2QjTNFibdXpYdaQCCgTGobuoxPD2ENeZOaXduJEbJx
 zjmEGXKV+c/NuFxgRIrbHn+O7yugaI9hpBESxGVZBBrbC8xqBUH6XwuMnSZFMR0wzXbZirDFCMi
 d7nhn9t1Ko5Q==
X-Received: by 2002:a05:6820:4b12:b0:66e:61cc:80e9 with SMTP id
 006d021491bc7-679a742d318mr2306455eaf.47.1771478562495; 
 Wed, 18 Feb 2026 21:22:42 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674758eb709sm14215326eaf.12.2026.02.18.21.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 21:22:41 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 18 Feb 2026 22:22:29 -0700
Subject: [PATCH v3 06/24] bsd-user: Add host_to_target_uuid for uuidgen(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-bsd-user-claude-v3-6-0137b37b221e@bsdimp.com>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
In-Reply-To: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xKJk3b3JTdaNoZfGVMupFKiv5n9kwceqv8tWNt1MXEw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBplp4ruvV5/x+6BmOM4tBebmdJl6ij2ujfH+Sti
 F8a8p2YGryJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaZaeKwAKCRBsHNEofbAR
 AFIpEADqBXRmNVHHjcHuj8MuVdBQsug3PdysK4L/MVaWy4nLGgLAArksy1USrylJXZ2ugaVVPsb
 DfkL+8l/o8kFny/uyAAcaWS9aso+x27UVungmFlIvtzwLBrengZDM9U6rmOmpNHJsPq6QawsPXM
 AXG3gwbqgvY5Bb3gVGTNR8nZ02P0FyVmFLRyWn3zPTPr5Bwz5FxmLmAgS9XhauHVPWhWGw80414
 0arvcEhLH/zgGu4ACBizdF3SYf21ROkhsqm9rkNqtR3AYqF3wsyGvBvmWraHKUiGE+i8koQWpNF
 fxd4WKdK+RcQif34W7YbhnxGYO9UAL/qRtQl3f9HomVDKfJIrtyMiNgfd9XnZBlUMxP7bf9xR+m
 /lfJ10ONkMwsnOh3x64lhhasQ0SZv4k4cWJiq2zU1h9+xg0PznerEPGigg78DmUje0lUzuA5mnO
 0CWnKeipcTfHF+uHl3uUmCSFWxxUqecZFBGN1FjdldCEDjrOr8ULw4frsWTuOqrtZ0XwXk/LpUW
 EDtstafdB3BXzuKLvKIjLNIVsdZJcAp2RLRzkz7nT6nNFm8U8gmpwb+fEpoI+otdqhdklr8YDfs
 84nP4zPJUK/WdvbrGPPLqxFgbcS6Tfu/UvK1kCuRelEKw4vTHZtP2IPbsVbfMThzElb4N87OYkO
 PA8Kt8rAUj6n6TA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::35;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x35.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Add host_to_target_uuid() to convert host struct uuid to target ABI
for the uuidgen(2) syscall.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-misc.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
new file mode 100644
index 0000000000..68b67f37ba
--- /dev/null
+++ b/bsd-user/bsd-misc.c
@@ -0,0 +1,35 @@
+/*
+ * BSD misc system call conversions routines
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/uuid.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+/*
+ * BSD uuidgen(2) struct uuid conversion
+ */
+abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid)
+{
+    struct target_uuid *target_uuid;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_uuid, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_uuid->time_low, &target_uuid->time_low);
+    __put_user(host_uuid->time_mid, &target_uuid->time_mid);
+    __put_user(host_uuid->time_hi_and_version,
+        &target_uuid->time_hi_and_version);
+    host_uuid->clock_seq_hi_and_reserved =
+        target_uuid->clock_seq_hi_and_reserved;
+    host_uuid->clock_seq_low = target_uuid->clock_seq_low;
+    memcpy(host_uuid->node, target_uuid->node, TARGET_UUID_NODE_LEN);
+    unlock_user_struct(target_uuid, target_addr, 1);
+    return 0;
+}

-- 
2.52.0


