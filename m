Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B08CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuM-00045h-U6; Fri, 01 May 2026 06:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuF-000416-C8
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuB-0000C6-Ft
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so29040645e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630530; x=1778235330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fMdZfrrkzecJWCuD5PoaO2/5BTBAqtW4a8Hufi0KypM=;
 b=I1GvvExkjV+ZCD4nz7qgbEzVpUUMZVKrCY1PjcaEfOHfdOW9nQbrw2JdvnGUWj2QmC
 POpSB7Xf+ohWhdZjVsHfVxUvBXGI47z/u2xo7dnr0qanmO2oy1+PAVrq/87pexKvnrSS
 yrQG3ejtWuRlgFfmy7U84U3q+oD97l/uokHojUe+rBt8Cp0VpIe3yl1f6RsWVUHnyhMW
 ubCP4fql5Q4NAQr+zttbvc/nIY8umdWoj7f/ht2g5MDtwn/FvwnTkNQY+vMj8b/Leufk
 k4UyqpUDsmZ/u0T/5gc6y1VlP7yVvBbjd6AawQipmnPpsd6NjvaOA2jR4TM6+ms8B1EP
 VTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630530; x=1778235330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fMdZfrrkzecJWCuD5PoaO2/5BTBAqtW4a8Hufi0KypM=;
 b=qg/txRrnrWNJxGVI7PQONKi+TnJOuN5zpWDFy+p12wL/M8hlzbRc77HkJLV4llnoYZ
 gJ6X856IA5Kz5NPs33/NlNT1qyOOpqwChvSxxBBEndKQgatnUmymyZPVFXVE9ZdbwebQ
 mCTZXmZqFRZhaPuFamqUl/CgeRBOnhNDBggjkhSWot6oWyf/5fYmCSFL7Afcme8eUmfG
 nJsCeaSK0hNYKtzRTalSbfM2avr+IWKKprai2cWSWZMil8WWzruF1R68a4Pns4tetiwd
 uuc/VDi/Jg5Wno3HWxYVlwxjTP5vjTdqChpoKAA6kPAY9oWF4LQbZx3zNKlksGAKy5ai
 hWHg==
X-Gm-Message-State: AOJu0Yx10sWK9Fru2LU01LxdlLoRqaRewGMvV+RNJ2+0Cb9nQP812eAn
 FQ6+Kvbr8VJVq6vXpfmX6r09ZHrKQfvSJEF5eLLNKbahUAg9ukyrod/q5NL2vGw5Vyedeey4HG3
 v/142
X-Gm-Gg: AeBDietHCwFOPG652V3UryEKHztTC6eqVT1swzFTLApVHLg+Fx5+66Y6OopfikXIQKo
 dvM7e8EIlCM7gHzoqQOvt634f9yUWJM/QQlfK62zwyzz/NJGhM0Cs13+iE8VfOzXgBDPEZ6YAI6
 8Ma8nMV+3wVAKC+f6CAkmoXlKApJ3CteomMxV4EDJRq4YFGzc4KfD/ozfGv4B1F3RcYJMxPdrcL
 9roxvQRUuWIlv9u58+/TC3X/PnIaKrMhg4DwVgJL4Ojt3M8e8Y2u+qbBnO533HHDB1HSwUTMJp0
 nAaqoM/1OLJPHUNj4jKgmrkTlci/UAAYsdA9qu1ocmKjBTR2v9MUD88qEhk3gcwrhxCsz8ZnSlw
 Zvr6GUgetsMqoKodlgufEp80DOz83BWejXzEi3nFBOL9Uu9XFbfXvyZxvZrcPWdjHmdA4J9VJ8f
 eCvDRkKYv+55aoqBiFWdwxMs/c9B5R/w3yWypol72CDmM1HO3MPLB3TAoQfCKZLUtsIumS1bU31
 sJ1474tWyX/tQ1WcXSDJFwigOUN9ITB1dKsHZsp/T5yL+cw0b2+
X-Received: by 2002:a05:600c:699b:b0:488:ab26:8fe0 with SMTP id
 5b1f17b1804b1-48a8446d81emr112810375e9.15.1777630529991; 
 Fri, 01 May 2026 03:15:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/28] target/arm: hvf: instantiate GIC early
Date: Fri,  1 May 2026 11:14:54 +0100
Message-ID: <20260501101505.3485916-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

While figuring out a better spot for it, put it in hv_arch_vm_create().

After hv_vcpu_create is documented as too late, and deferring
vCPU initialization isn't enough either.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260429190532.26538-5-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef4c3671e9..a028c99e24 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1230,6 +1230,28 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
     chosen_ipa_bit_size = pa_range;
 
     ret = hv_vm_create(config);
+    if (hvf_irqchip_in_kernel()) {
+        if (__builtin_available(macOS 15.0, *)) {
+            /*
+             * Instantiate GIC.
+             * This must be done prior to the creation of any vCPU
+             * but past hv_vm_create()
+             */
+            hv_gic_config_t cfg = hv_gic_config_create();
+            hv_gic_config_set_distributor_base(cfg, 0x08000000);
+            hv_gic_config_set_redistributor_base(cfg, 0x080A0000);
+            ret = hv_gic_create(cfg);
+            if (ret != HV_SUCCESS) {
+                error_report("error creating platform VGIC");
+                goto cleanup;
+            }
+            os_release(cfg);
+        } else {
+            error_report("HVF: Unsupported OS for platform vGIC.");
+            ret = HV_UNSUPPORTED;
+            goto cleanup;
+        }
+    }
 
 cleanup:
     os_release(config);
-- 
2.43.0


