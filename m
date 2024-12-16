Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B61E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28t-0007GE-MU; Sun, 15 Dec 2024 22:51:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28o-0007Ez-Ps
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:31 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28m-0005xV-Me
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:30 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5f2efbc31deso1914113eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321086; x=1734925886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/N1O6+KdnI0Nthc0qwwbnzGBocJ9psam8as1orMligo=;
 b=kDg4Hem8fcHOQv+0inKtV9f2Oa6LspJi0VJswYYkKdIyli5icGc0qWZHbu1Ywxd/mK
 xBg+jCd/orzjPpNEhVh2bRtMqXtK4kI7Remn9evaPxfDRvxT5OEDEtBRX+y8FNCTqMvq
 74W7wilUc+ZhMb8NO42FktI5oqJQTDXoVYFt+7oApQ2vLAmxVZzjH67xBhkcuoO+GmmS
 0GfNU0h4BqBLeGzOKkt2DOg6vuhmPuJammN9Z8RpMAVIvcx1S5hO/ZmkhQvTV9OU2c5+
 cbZoMCYGvkdcAgfExgxJZTAbfOLlKfc+K209auNzbVSMcwHKfly+8r58UWw1tdaKdtpq
 uYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321086; x=1734925886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/N1O6+KdnI0Nthc0qwwbnzGBocJ9psam8as1orMligo=;
 b=IHDuOaRPXe58JJdexl9imDNHHqqkYOOHjo/Yw/w9W8tNBPqzxqdVsWa2fFdXxg2VlH
 cwOQRTUIrTwOuK9DyVfOlH8TyeL+rLNV29Vk9IWt/19ltknYSOYDCJsL+DP5pWwkGeqL
 R8WW6l2RDkabrAo0UP4WNo0gUB9FlRffnGGd78PuKdft/mmVMmSIF0PfeWxlSA2OAAA+
 peLcP8r0rK7cYW3IU/abi0pBJ8R61wbI6OoJScECridnCoa/3kHkpf8X9lrTqzqtP1DR
 N+zJKP/tVid09u6APcyGidnW/jPuZiX3mjlsSCE32utWM1bEhPuxiUwvvlo4NbhvZyr0
 OBhg==
X-Gm-Message-State: AOJu0YwIwR+a3Xk0JZH1ICfpMLbpyApwrxTK24lHq9OqRLyzUc1SnN94
 mDzgUNIfWJcbEKRfEw3S8Zp6dMy6rmuaI9ZmJ5bVyHt3YnnFdscKXpcYUTmWsb5lEBh63obCpBb
 pbBDof5Cn
X-Gm-Gg: ASbGnctOfaWgr9txtPjhY9n+qzfnQJyUzxzJ6NXM5riMhwy5J5E4k8mCYshb74t6MyU
 8FNUJKeJxANqN6mpA8Q2DwMp6rQkkwxohdV6lCyLh/HqgTGfKYejHiVUYwHW/u1rLZoSuRDFQBJ
 cFMBjWfUq9pF7gp3mVo9MuvAaGwxTcxmWRYFXLoQOlwGrEk2bHylLce2dFQJQG745c07ZzkD21Q
 C59H/j7qBA3cPlzrWbRA9CW5UCKwyao+khOWiKV3gNnfyKIzPlHhOEqqkgcJw9YDrPI11OyNQFu
 v1jtp+erTcLecI7xkzPZJJbTIcFwg9U0l9KutwMhvy8=
X-Google-Smtp-Source: AGHT+IHSgrafdxT9a0I1t13r1xMjDdKxgTuPo6lcfigmCjcEnHNbiVwdf66H0BAd/0aTDnFQor3TMw==
X-Received: by 2002:a05:6820:2086:b0:5f2:b981:fcdf with SMTP id
 006d021491bc7-5f32947fa3amr5910224eaf.5.1734321086672; 
 Sun, 15 Dec 2024 19:51:26 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/24] target/ppc: Remove empty property list
Date: Sun, 15 Dec 2024 21:50:48 -0600
Message-ID: <20241216035109.3486070-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 1253dbf622..5e95790def 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7414,11 +7414,6 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #endif
 }
 
-static Property ppc_cpu_properties[] = {
-    /* add default property here */
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -7468,7 +7463,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_unrealize(dc, ppc_cpu_unrealize,
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
-    device_class_set_props(dc, ppc_cpu_properties);
 
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
-- 
2.43.0


