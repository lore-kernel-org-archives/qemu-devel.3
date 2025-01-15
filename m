Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEF3C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uY-0007N2-Rb; Wed, 15 Jan 2025 12:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uO-0007En-Vz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uN-0006Wp-DP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so50095675e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961021; x=1737565821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ6BBYQDvZ7gZ5xmu7ZLpmPZjx7/EtZQE26i+5oao3w=;
 b=NFZ+9t/lvyR5wHBtZc/Vgx8NmuChbuOH5YgHmTPErawSpCJpE932V5944AMzYSH+RH
 5fUCiM8Jyy2lHVdggxvpwLHzOILNkgm1FvkG5Dlxh+YcpEd5qrJ+BLyaDvZyEH4YdmA9
 avhOTY5Czypta714qoPW6ut4tfNmnuEFKXOtMdXL00zzDCQjknDOgE2m9cGpvqCv4PTU
 Fj6k9PosUBIvfeYsj3xiCoOajprmtk4Tm9xef7Ih/WxHQaqeY5Qf44pLBlnS1ch1dyi+
 jHg0mq13n9FtTdBHX/CPwXhg6O9c+QsqTovgay7Mytdvxh9NJL4uR5CDD6n2vPjWI2hj
 W0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961021; x=1737565821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJ6BBYQDvZ7gZ5xmu7ZLpmPZjx7/EtZQE26i+5oao3w=;
 b=t+0d+IqtCkUmfH1OKybJyszqQoYxmduLG+HRX1rb7Q0pVA7LxTCGVqj652nkiqigny
 gVHi9RAmt81k/RoqZ99GzIHBF2CNDsB8diP0w3w6aHfmSoGWlsa4Ek5dHPQu38Vhmq0+
 +tgGLYK/joKPK8m7vy7dfBdlBE5EomcVUgq7d4nqme0DftkPF96puUwnjWJ/yv+eWUDQ
 JcY23t6Yn5HRH5VtCvD6wqHN4ersTL/pzUu7TWiBIVPe1AzPU50Up0DUdt21cPh5qBwr
 1CUpfL/OI3DhVS4BEV8oHSDXJ2Gqcn0oK32nP5110Syy8eMu0FJlr056/0P1sgD7wMtF
 jCew==
X-Gm-Message-State: AOJu0YzEtZb06oNihvCHlAwbwJ7kRgG9ct+LK2xlosnXb9AXFiOdtnVE
 63/XanWWZLkXiekgLNjUE961Ve5/KsrkYTjxrAJs5lcnlxDAu5/PSZ23dBQUhZYCk6wssSuJVP0
 eaVI=
X-Gm-Gg: ASbGnct54TTFc5wzo+0wV02+YjRIcn1SqbEK6Vn+c23A55f4K5+iXdHNGEPvjCaQYfx
 Ul0th+/AhHM0j3APbf6OC9k4zgHJZwH3mqzVRul6zVnttFb+cK1UciDF7xkYTVXno+PuI9WBDOW
 v+q4sx5yeCf77MgclMVyWaaj8U1a9FIrZGH254NjZyVgejpHffwiLgr6eZ9uDKjRARuFtP60YAN
 XscstZUSvtQHZLMkFmT/gaKrx5fUeCVbZKky7LKtsuniC9ZCAaRVejY1tIhvLrTtyjTs45xLyJp
 LG4tS810KYN/2oU1q1vI7pltpwv8SGRCWekN
X-Google-Smtp-Source: AGHT+IFdwR2V+vQPPucU2EZivG4J7Eb3Bpl1K+qUNUrrw+/AMe+lhzD1LKKd71s4yVkGQ4K//lVNRg==
X-Received: by 2002:a05:600c:3b8a:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-436e26dda80mr229248135e9.21.1736961020558; 
 Wed, 15 Jan 2025 09:10:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c75290a2sm30508755e9.29.2025.01.15.09.10.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/13] hw/arm/virt: Remove VirtMachineClass::no_pmu field
Date: Wed, 15 Jan 2025 18:09:58 +0100
Message-ID: <20250115171009.19302-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The VirtMachineClass::no_pmu field was only used by
virt-2.6 machine, which got removed. Remove it and
simplify machvirt_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c8e94e6aedc..27c5bb585cb 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -120,7 +120,6 @@ struct VirtMachineClass {
     bool disallow_affinity_adjustment;
     bool no_its;
     bool no_tcg_its;
-    bool no_pmu;
     bool claim_edge_triggered_timers;
     bool smbios_old_sys_ver;
     bool no_highmem_compact;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bb8a9c7bd6..0080577e1a9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2262,10 +2262,6 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "kvm-steal-time", false, NULL);
         }
 
-        if (vmc->no_pmu && object_property_find(cpuobj, "pmu")) {
-            object_property_set_bool(cpuobj, "pmu", false, NULL);
-        }
-
         if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
-- 
2.47.1


