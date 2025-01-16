Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32809C02188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRLl-00020Y-IQ; Thu, 16 Jan 2025 10:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLk-0001zG-4S
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:00 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRLi-0008H9-HI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:59:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so6717425e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039596; x=1737644396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzaMM/optD2vwl9fO9YSInAfvs4juuVTuQgymT75y4I=;
 b=JCjwccNk/UcRx0aa8OWOARQBLyjFjuJlMDkdAMtgbRlC2WmHnBw+k8tr/6HhdaiNiB
 4Y3HygaE5E5iCo74ef/Hv3zLzP1KtDMCtUeGLC/buXxwr70M8SBnu6eY4v98oT9xj/Dk
 +hz/QNDdXL5X5LEYX/MaY8VbKYamHo3aYYeAtDypU2q83cU/XExQbzowDFG0YvPGZHZC
 xO9gbxxjpIJE7BAi0lxrbAzWBKQFJnM1F7MHekeWrV7kurc6Le9mupiDkC9vemTdTKOk
 mCIxGWrk50oXmU2VMHnhHbCANdboFODZQ530WuWyE50VFPoxwcIa2QqujenuGhWZANnl
 EgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039596; x=1737644396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzaMM/optD2vwl9fO9YSInAfvs4juuVTuQgymT75y4I=;
 b=bikoMzO8rVrXb4cHPCkhuJ/l7lAeZQJG1v0W71lKRzdyPap8pPrUkl1nrpX9R5lqBj
 MVKfMBgFyXZsNUP/vyi0v4uz9EVOszCdW04fMh2TCu6+iYW2thLEDDYbqztZ6DWlkUNR
 HL479yKbQtJOvcd6U/kHfGGNefnz6V3T/J6MM29AGEatTtnaZr9CA+/OsoHxKT0B0p09
 Rt+rgNYDkv0Q6I1j5Hi3htz7IkhPgvVMHbLAMZ0JvYjFsZtSTNLfLQyWSGblho7nMYhx
 bVW51fbJKRfe0UTJzZIT/8hgSeFxNeQAUzwz5NQNJ4UMN1+Wuzi44iN2zS9m8sx9L6wo
 9H3g==
X-Gm-Message-State: AOJu0Yw+Ls1alX/D2VWxghi/H1/WEPhTCNuGJY3/gCwL4vW9xlb2UPMv
 c/2k/BgrjYIqzTh1LhI+Y2Rzbhbr2A2tXn9334WpPyNjTHU4WPv/ZVwNWQN8s9bzf2h9pOk3DMB
 ZNag=
X-Gm-Gg: ASbGncunFXQS8iQoc70kR1TrjcCWExH3c/rotUo+0swcew+XAaRspChGkqLVwo6DGDe
 7G0JaIAUqcaN6WG480l8747L5awkM1mVd5CrcjUxFij30DdZJtIOg9yLXb7rDSTi3EAyJ63PpxI
 v7Fh2UD+GAz8SbCIkXHlHVTbnLmDluqEHh17VMI7loHUd+HIrwpD7hSRbml7yewKpS5tGXUf9TK
 Pl9JVlwp/WMez4a66GFhIhvj28JjE4zfHLN7UjnGtunerS/DwjDmwz+cX6Bjmd63g1Df7u3fg6H
 RjGAk/kh0umn2HHLeaDLiOCbKNDFix0=
X-Google-Smtp-Source: AGHT+IHQirEthn86XzGlYZw9mjU+NipwmN1Ye2Jl/4cEP7IpNFjZ510pKkVPTnQlsiD1qtrmei915A==
X-Received: by 2002:a05:6000:18a2:b0:382:49f9:74bb with SMTP id
 ffacd0b85a97d-38a872f3202mr33624267f8f.35.1737039596605; 
 Thu, 16 Jan 2025 06:59:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327e1fdsm64753f8f.94.2025.01.16.06.59.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 06:59:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 02/13] hw/arm/virt: Remove
 VirtMachineClass::no_pmu field
Date: Thu, 16 Jan 2025 15:59:33 +0100
Message-ID: <20250116145944.38028-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


