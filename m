Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A231CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kCV-0002za-7m; Fri, 17 Oct 2025 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCT-0002yY-0C
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCL-0004TZ-Qg
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so8336045e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706522; x=1761311322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMr/2c1ZyUR1WtFjcqaeRtpWLOfNiCEfccz8VtRx1vQ=;
 b=wSsPwnEA29L1P8MsvjLpF8yR5K5LginK9OEhbCZL+WJpk41UJK0jIPimnFMH7AGAvc
 Z5ahcj8e+mvkFWFl4IXAbB/fkers21W2iu3s1JrH87YzlfAUKqLzXesoQDGN0H8umiSY
 F/polZ9W4hi8iPUJ+P6WD17551u3jSz7nSKX78RnziBBeju+f/zSvgTk4KPA4TBX31cA
 unxjRG0IE9ERTdo2vhWWe2W5h9YpijGRVHHmnKejdQw9hXtXSHlpM6sNyHSisLHKESvu
 hhC6mGTO08i6vUpZuwjUgKasaD7Gp/PVk6aMiNLZOP2ZWbR/T/2oi1VzfdQkMyjzq5Bs
 v34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706522; x=1761311322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMr/2c1ZyUR1WtFjcqaeRtpWLOfNiCEfccz8VtRx1vQ=;
 b=l+osVGrohLzPdvu66UZ2Ku3jq94qCDjrwCauYaL/U6gQkojG45ftrGaL3MCuEpdaCU
 SHHJtztS5ue2gvGksoq1mVp17QaA8beem5ts1aHOP9HM3EW0cTR6E2GfgmYnB8TkAnp9
 NwQBXxCPBi6mYTeL5zKpbWDOZC4pUIJqNQqXDMrKOVsWl6/1NTOHNWb4HP22whSAve5d
 sLRMBft05UqKKp++9lUE79gnJtZ5g2OrgWf6YGBRTkvIrCL9Vvqdqm7v9VBQ2g/EqofE
 Arj0Box1FdDpBifbJL1ACmlm3yLi3lCzZSCz22AJ5F+J1vI2UChM/f9tg1mcZAENuy+w
 aQdQ==
X-Gm-Message-State: AOJu0Yzj6vsbjXN3OcqRCBPYTAgkVT3OVJF6oTle5hgdcnMEGyvKbdUO
 pdnlnmk+56TxSbM8mvoAdU8WA888j48mec4G7GZRchwcWiHlN5UEq89p/GiQey1r4ZnS8SyLjxk
 DXroKoeM=
X-Gm-Gg: ASbGnct0kxhmVPEXNhDtWkpHGliQ4DzAGn36NL/OBQNV1Uv6b7LwYeq4pZdIiE/mtN1
 SVsrOHoVYkEfXDBD1kmIU0goDT3ULLBKADgB6PebI/dJFsEL1jkbtnJpTpk0FUWfIgwxJ+/wR6D
 FjUX1uXgcOQ5aBZoUBncGM1tnfINKtm4++1ImKWWdqrwvif24oZ03Pl1JEChtG/FB7D8o4Ql/Lm
 ccyIdtynGreYCzUag6WQRLXBvX68qDnJdUyNVmJCxJw/CJVMeI+YqMVjtBEPZyLsVc5bA/WyW/g
 kXY5fq152XV08yYLSeGJz4NwxPESiJWelglbhxcafDNTc0iiXRJNiZBmEHgiJpgdtsUmwe3SLe4
 J4gTdPiqWm9xgrT0mXTaVR3AmKVpT2HlnwhMJIKXoPGzmuXGHehqLtFT9L3gVjwKTYGQ+vRh4WE
 CpJH877zUoqD4td/N72nkUxu19oQZixvMR7J1oo9o+TvyXxjjapA==
X-Google-Smtp-Source: AGHT+IEzqMZQO9uN7eVD6cRn1TCm0ymzUhC0f00xNCKJ6M9hqkNJ/FbPg4i2NvlkzlrXe9fJG4FKeA==
X-Received: by 2002:a05:600c:8b0c:b0:471:1717:41c with SMTP id
 5b1f17b1804b1-471179121f4mr23658115e9.24.1760706522091; 
 Fri, 17 Oct 2025 06:08:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f6afsm83736665e9.1.2025.10.17.06.08.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:08:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/20] hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime
 field
Date: Fri, 17 Oct 2025 15:08:03 +0200
Message-ID: <20251017130821.58388-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


