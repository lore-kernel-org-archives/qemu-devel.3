Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16065CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmNy-0002mJ-Ii; Mon, 20 Oct 2025 05:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNk-0002fe-5r
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNi-0000Qu-2V
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so1998963f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953243; x=1761558043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMr/2c1ZyUR1WtFjcqaeRtpWLOfNiCEfccz8VtRx1vQ=;
 b=n/JB+rQ1UAOMZIFewfzxMlB1UyiKXv0Wn2ERiBQpyoqywpU6AL381cy/IbLgtVJj/P
 eBCa9STnuJCiDqzuzdsmdmwINvcpPOWnEx5wA4/PADu192bTU/su0yUaufDmYKCVdDNy
 o6oMSNEkP+OyCDZtlMVYJ5/pHFnDSMBuHGOwQEhNpBJxIlo3oHI1aaMZEurDSDp97XXK
 xPwIZyRIvYzFHw31X9oN4HsIPSu6BLdgDmIFPkQz/HETPMl/d9WK0p0ltGxoa/aTDN0x
 7rcrkQNUGP0PZ4Om21KXeGd8dvFhf3b1FuBzoob/d7kAXfwFYeJGLsV1hrkaSdIjGBDP
 QS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953243; x=1761558043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMr/2c1ZyUR1WtFjcqaeRtpWLOfNiCEfccz8VtRx1vQ=;
 b=OsBRJJiWWDoKkAtyt/yluqMlCntH7Y9xA+k/Ad2YikObwdHSIJq/z3CI3mFOesleUc
 hO8vWexbptTPcE6/zn6I8G+Yc/caQYW2ByphWNE5dLZcOJhCvhTiMU9Q61Xp/ktvbVG/
 l7KnnfOpR1fv2PuYwCZt5U+Ubdtfp/zeh30cH1MuAEBeDZ1Ynxc7ExX+UVGwDXRlclgZ
 UykzdkUD4TBcsnW93VhEhfV9ERScqphAYZd+cfkxCUs7hLotakSUWqqHnB4kOUzLNYkL
 YGuw08jhJK5AazfCT9Elqqhorg0glK0MszCGlb07FjCM2m8FOdf8qzZ95vKIb+Irk18u
 bLgA==
X-Gm-Message-State: AOJu0Yw6L1pLQ1ZfaVsnA3e5MhwZtoCZ9rkOyliys6vgEF1E1KNsit7P
 a12tbh2HHSymMQPV3AJKPhQsjKLlmpUcsOe1Eg0nfrQxnEt6ZcYNdO1UJs19uNpZEFfHJBx5p5u
 JnK+GpM8=
X-Gm-Gg: ASbGncubZT6KUiu8yZos6pb6qtp+cqbYoxafaRncF2RbU8YjJDcRLwe446xmEH+nwWu
 ap9BDMNtFFgGe54QQdTSxwr7kQdcWkBUHWNjby6QYeqJunt3wcVscD3rt6T65VyPWc3ZKuK9rgj
 Tx/WE4NO0gnoFQXUs2RSHhZPPr8HNy7DgPqQrymPE3e4fdtsHuop8TeZaNNK9v8pRhMlZbv2Nlp
 TYqYifcmgYmXNFlHlHPBR24WMilPTzhiqbP2a26mbjCC+CkYYy864K8kGPOpHO8FaGU/2yaYSzV
 wTMUvjA4VPw6hm7AU/MAKsv2YMaWfTtW/FLSBYM2H+wB3CehhCnEMotSvofFNJvOw31+U00nClN
 eRTw4HmwMmkAKoqbzBD9OnnBZLULT6i6CfHlM4Fu5g4I342EmnrPEcIsJEhMqfyeUAykM7y6t/l
 6AkKDyNKiv9LksCICurxAsTtcNYT9jJvYtCTzHrPiiV0fhay0XKw==
X-Google-Smtp-Source: AGHT+IHkQFTpufhlxjKPrnjzCXFxoLRZB1IEBis6PFrnN3gCSv7nSwGq6v4fBKieHtwlVRQiAUSdRw==
X-Received: by 2002:a05:6000:26d1:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-42704d5219emr9111256f8f.16.1760953243462; 
 Mon, 20 Oct 2025 02:40:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5bbc50sm14565615f8f.21.2025.10.20.02.40.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:40:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime
 field
Date: Mon, 20 Oct 2025 11:40:21 +0200
Message-ID: <20251020094022.68768-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020094022.68768-1-philmd@linaro.org>
References: <20251020094022.68768-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The VirtMachineClass::kvm_no_adjvtime field was only used by the
virt-4.2 machine, which got removed. Remove it as now unused, but
keep the ARMCPU homonym property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 993872bb680..c77a33f6df2 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -123,7 +123,6 @@ struct VirtMachineClass {
     MachineClass parent;
     bool no_tcg_its;
     bool no_highmem_compact;
-    bool kvm_no_adjvtime;
     bool no_kvm_steal_time;
     bool acpi_expose_flash;
     bool no_secure_gpio;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b781a218019..ffbddb711f6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2362,11 +2362,6 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
-        if (vmc->kvm_no_adjvtime &&
-            object_property_find(cpuobj, "kvm-no-adjvtime")) {
-            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
-        }
-
         if (vmc->no_kvm_steal_time &&
             object_property_find(cpuobj, "kvm-steal-time")) {
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
-- 
2.51.0


