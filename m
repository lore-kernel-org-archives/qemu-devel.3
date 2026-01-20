Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C21CCA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG5D-0006w2-KT; Tue, 20 Jan 2026 13:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4w-0006bF-T1
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4v-0000TH-BJ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4359019da8cso888790f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768932223; x=1769537023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BF7xLPclhWg7q/XkOOlfgy3QCXWSt8lM7mLCvyOa55I=;
 b=JhfceZXn8d1kXLEK5gEuYfQIQH2lMYjmUMVr9p8AA2y0weOcesx/yAk5jSs3T8axqu
 moIy7yKUhsAJCJu6B+/Tq68XLUTT7KxgVL9Q335UQryeu4JQH6iHElyyslrjw8ArwSrD
 S9i4RdlaoCZtK6UmKgwrLCEO8NshsS56WGM4wBVrKxm9hUjwwiUQQIHj7RNUoaRB6H2O
 6HA+nGGfrDrgO9HylPzOHEZSVdFOa8YfQo6rSqWBX98FIjhT1jGm16Pj0D5+M55rUipa
 sTNZ95sR+tSvR83b3i0771HwMp9SCmqKibvCL1fjlNu/+MTSo9F0ESQzXjnYdCV+9aQL
 u1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932223; x=1769537023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BF7xLPclhWg7q/XkOOlfgy3QCXWSt8lM7mLCvyOa55I=;
 b=g8BBl7gesmWPrWXdM29F9YTnGbbv8SfhWqVyY1M6JBb1qlRtNZabAP/hiM4f9DX9+s
 D+kuZ5HGouOsNQtNOSMVF32hkMoCeTJVWN5JGCorMk5ncAfGYW3sOEa7Qsx5A3tNIRJz
 Gj8XkZytrJ6ZeRIlb5xO/nbtW/Nt6pQAuLf84OfKS1+NyonF+AkSqpJxcyZ42MECSblh
 CVqIdVyC6/CtJ6XkdVzOz4/WOW70K/yaCwDkExvwJ+atDesDPw3gC90zIan7svmAJ+qQ
 guoUprYl+AcnOyv+wwknQp/tnGQSwxX129/cZHcsD8IS2P7/r6+ZHEfwZ5LGZAZYuWzd
 C1+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWke0Pu0EwxHKuEZrHkx7/XJJv56rB8/SGizL4As+dOPVK6pGstcHy7lNOrEcJgWnV7t2UL/zPUj1Lu@nongnu.org
X-Gm-Message-State: AOJu0YzkIPusWcHd4K883CKiBtzXLuhftC3mcKjIqbcbeKMF/JBxsCFJ
 W23bUmNKUydCRn1fefBrEoH49BeRj5su3DcRGbd9V/mT+JXC9JOIDGZH8QkjVRdxO3y+4AUB6Qs
 Y/w4+J9c=
X-Gm-Gg: AZuq6aJgIpXQS19bvbWZToEOsHoymNcpq9DhmXL0Nh1+O7ek20ZnMtWZ8VD9g2lEkKp
 pipC2mYI+AakkM5cqNc89zv9mBzU+GqOrWlUQEuSOMwX8dTavlchlTkwEkwrlUqziup89p8BoHo
 F1SWz0g7OgcQSeQGzJ+G1U5FVD1DhA827elC6JYyMXmGF2y6Hw6m9is8A1ytjDIQgsaoCCQTDIm
 3fc+pQ/S4EttRU4xgreOR+yUhn75IkfkeHGJepjh1OMXFG3g/DaVZNOjZz32xV9ZketKDlQRu0Z
 7g8tZ48Vbc5EdGLPttuMVvxb+rID5iDrM82kVJb7yTRbX+dSH/sFi5oAYe9iR5qUoSX/K4UYBWU
 rcsx91lcpHB97lerZbtBA/VevaMdCFc0rWLhKDfgQW3yzEVH0xTGlUWma/chHt9zmdScHTizwFb
 gJoQlHBSdOcjw7HUdfXFKihFZnL6JrfMuFA3oeWccgSpiciAf7esge
X-Received: by 2002:adf:e884:0:b0:435:729a:eb6f with SMTP id
 ffacd0b85a97d-435729aeb94mr13832875f8f.19.1768932223189; 
 Tue, 20 Jan 2026 10:03:43 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm31310889f8f.22.2026.01.20.10.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:03:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 2/4] hw/arm/virt: Don't use vms->tcg_its in create_gic()
Date: Tue, 20 Jan 2026 18:03:37 +0000
Message-ID: <20260120180339.1416328-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120180339.1416328-1-peter.maydell@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The create_gic() function needs to know whether the GIC
has a TCG ITS attached, as it should set the "sysmem" and
"has-lpi" properties of the GICv3 only in that case.
Currently it does this with
 (!kvm_irqchip_in_kernel() && vms->tcg_its)
which implicitly relies on knowing that the only case
where we aren't using a KVM GIC and we don't have an ITS
is where we suppressed the TCG ITS because of the
board-version-compatibility no_tcg_its setting.

We can avoid direct use of vms->tcg_its now that we
can identify what MSI controller we are using from the
vms->msi_controller field.

This means that the only use of vms->tcg_its is in
the logic in finalize_msi_controller().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b55297455f..a231aef268 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -851,7 +851,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                             redist_region_count);
 
         if (!kvm_irqchip_in_kernel()) {
-            if (vms->tcg_its) {
+            if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
                 object_property_set_link(OBJECT(vms->gic), "sysmem",
                                          OBJECT(mem), &error_fatal);
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
-- 
2.47.3


