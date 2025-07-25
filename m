Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A996C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 17:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLp4-0004p2-G3; Fri, 25 Jul 2025 13:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLk5-0003Dj-H2
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:57:57 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufLk3-0001pv-5t
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:57:56 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3139027b825so2047672a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753462673; x=1754067473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MBsnQtK/MSVuSA8COT22mwmsED90jexli3qzsr1fS4Q=;
 b=zyO+UoTQKjO3Jnpj5epBprhb2ovbHdiHm9fxBUJifyIGfqPumZ371YSEpWzFG4r7Oi
 lR07H5BRwrHp4JXoExo2L8M8DfXyM0r2vjnYuCcYpmfir2V67GrmPtFoOUFKIHa9F6bI
 OubSIZpSqQuKrErCfMR9PenZ9fGa14AOZVUqYL2WbDkpK1W0E82O/uCxqBHvvClrQdbF
 FSA8ZhrlZ0xvdjcUK2e0MnSeSLQQ3/WRJiXVdBdKdr+HE/9vYVjq/EtOqBX6sWpb8ix7
 fAUBktzP4W+60m8EzAqR2bgbyw+AnH2I0ORwe24pDs+HBlDV17LzmMfQPOlAAvJtUYfo
 Wadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753462673; x=1754067473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBsnQtK/MSVuSA8COT22mwmsED90jexli3qzsr1fS4Q=;
 b=qPRCIDTwuOqnp5Vkfm4zTM3FQV0QwGaSEn+nq1uOvuiBArttP4pwEfSmhOfLZGXNyi
 t+edTMSOVQRVbhEhm5vWE0DvVsUUqrFnqecekR9SHLqpFre5bSDCyUYDuPks/l1Con6e
 WNYfIE/q9Kn2EYT2y7P1xmUspH8jrkG9XrEufEU4LOWndiLDA8TV6mxFqkV/jSEsBkz1
 soA03etbClmMRHnyJxsAY/lY1nMOGnRSF2PgyeH4cOrFkF3XMaQhdgcjshwVNyC7plhT
 yhlqMav1FEJeWEf5/7DAVtWd1wJJp90GdFuBSUr7CZbt7s4juizr07anq7YKNr7B2jQm
 3hDg==
X-Gm-Message-State: AOJu0YzQuLiYDso3AZsdOdbCcfCFXfn6ep3gIm20vQDYVCokmeWvCOL4
 em3cm900DsOkBNonD3elPy3oeL4x3Y74oQl8V/mTNKpxJsqAOWP5Tc6RFDEzDmRYTbLYUeU6G7B
 XSZjI
X-Gm-Gg: ASbGncv4nx0YEnq/TSUGZOoa14GUo5+u5nvlXSiCrI+QcSSni4LH0cCYMzclfQ0Lg23
 T2kMN1uI56YahPCPkEM3s1W4evxotxcR6/G4E2NzQy6vsk90gTD93Rkc8/AOTugYQaB9HudrvII
 qlFirbfRNU1vRW/fTeCdHfNmyOEgzZUimHu1Ho+9w114KFFTLtX7vzlWfGzmhM4OcjxqJxIfwqw
 83yPyaWSHwz33Oc412/CVuHv4JDXTcMcGRVjFUjRrJqBi8CwFo4Arrsk+KyL+Vm2m0ZnHU/fhsq
 E1s8f3JIm0DqXmNTFh2lljj0A7A5e3uHUV7lMEPgwFFgMTxjD2LjPOn8JJYBs9OSE4IEUUUl3jy
 ycThdW4a3mpVzIyRio4uH7w==
X-Google-Smtp-Source: AGHT+IHXA/JVUDtZuI+n60b2WNaVrkPRhJ89RBAHgHSbhERFjM884v+v86/0ijkq1TId3c4loFM7rw==
X-Received: by 2002:a17:90b:2809:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-31e77a1a3b7mr3789784a91.35.1753462672937; 
 Fri, 25 Jul 2025 09:57:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e63a766d9sm3021487a91.2.2025.07.25.09.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 09:57:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] hw/xen/xen_pt: fix missing include
Date: Fri, 25 Jul 2025 09:57:49 -0700
Message-ID: <20250725165749.3893240-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

FAILED: libqemu-i386-softmmu.a.p/hw_xen_xen_pt.c.o
...
/home/user/.work/qemu/hw/xen/xen_pt.c: In function ‘xen_pt_need_gsi’:
/home/user/.work/qemu/hw/xen/xen_pt.c:783:9: error: implicit declaration of function ‘error_report’; did you mean ‘error_report_err’? [-Wimplicit-function-declaration]
  783 |         error_report("Cannot open %s: %s", guest_type, strerror(errno));
      |         ^~~~~~~~~~~~
      |         error_report_err
/home/user/.work/qemu/hw/xen/xen_pt.c:783:9: error: nested extern declaration of ‘error_report’ [-Werror=nested-externs]
cc1: all warnings being treated as errors

Fixes: 012842c ("log: make '-msg timestamp=on' apply to all qemu_log usage")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/xen/xen_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 9d16644d82e..006b5b55f24 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -54,6 +54,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include <sys/ioctl.h>
 
 #include "hw/pci/pci.h"
-- 
2.47.2


