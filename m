Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF44CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDk-0004pi-Oj; Fri, 17 Oct 2025 09:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDV-0003xG-7W
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:10:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDO-0004eC-Vk
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47109187c32so9921435e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706582; x=1761311382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqZvHOn07DkcN1hM5TgN0Mo/k+1lQdqmWA6ozj/h18E=;
 b=uiHU0XxdnOsrQu/Pv81QbyjbLEqPZD9eajY2KfWyxnZ7lD8yPpIWtDxjelCa5q88z0
 3Du51rWDlurl7UKDL7SVT0toH3jvWL+h0SrvbhG6Uj0Kl2HDRyA31on3WpWfrAu3GEPt
 7uNen3MOJL17piTKCAnWY5ARgkb2wBaNg4RCsJ5ca0rx9SHhLUEf/dFhfQY22ttwEWcZ
 O4LsPvfjfyDJBUmpH7bxuNncZ3SS9ldO1r7tjsIVTmKGWep4zxXwNVCigVgb1mdpXEvm
 KPtNCNqHpny4Um+ikNBADKCq9KmfbpxU+pCPF9ANhAo53mhg9YFKGDT1UULJGr/Q6dFN
 Rn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706582; x=1761311382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqZvHOn07DkcN1hM5TgN0Mo/k+1lQdqmWA6ozj/h18E=;
 b=EayucJbM4JtDUdn5EGAJ/oO9+LgrDwNWOEaUl/xpztQwfMHVWcfXUFnPDj45Bufpas
 BBuSBUBTiquJlKx86qQ5jXFUt9my4TybhbRkHeMQqTfiIhLMrO+mBtZbcuTB6UcZGWwn
 bBDnq0D28NaMzKjLklX+PS2duD+07PW64SK+mIto5+QdnJevOV9lyIVJGM11xB9Hwqet
 tzxQU97geMBi+WxOEOj/NdEqAv5QMCVzTV7gDq/2cDNkMQE5A0p1MvDbDObHFwWbSP5U
 o1yrhXQY1BWQI2eL9aS8VWaqlZwMbuzOs5dd7cUbGzq2JLCrUml2ume5gm1M0SI4fgeI
 EvEg==
X-Gm-Message-State: AOJu0YzD9Zk971cz+c/3tFyGgEmDJNv03xLZvWqGjXtuluXFWvtUvfx2
 e7eaZY59oSizDNlg96cqYNAxXgdwSxmXOgVZueKdqsR7JNi6xVgPXnX+gNwYOooMzFHTO9dKSFO
 emGNLUPg=
X-Gm-Gg: ASbGncsf6gue0XCVctez9NxEZDJKyhnxQo7W9HniYu2SR5fWvIuocgZXN55GAOZ4QXq
 ovMoylLt1qIjhlEq8JeOYYJeb6NUNNF7cYgjUhbDGAu417W17ZBlP5NuxAnfLb8gqQvvmVCtcvP
 pVT1Wnmag74lEFKjxjz6ouJLSlzjSFifd32u5xwOeWUmLMCcQztUWtwu0OUPVFB8zbnMMgXwCm+
 l85too5xn+7WZJq2ev1D+gEfbPhePkfyxqvJRDTf4gS6pb9g19MfJiGtLdvHinXsqZ7YWyD1zjA
 xGfkc9KVpYKA1eUe+Of9v5w7tmo3TWxElDo8E7s1WgPSxS9C56nnWn7FTLqUH0kqvGy7CWOXh/G
 bhUbDq6HGraolVYTJTXRfa4TOUl3ja/l+UKaaHM0Br5r8CeOzP7zTb3GkQRC7E5ZLZSTc9LJVhn
 u7wx9WjdDIXkWi/ByyezHpDJSHyZl+p3ZWT28H4DlcO/N+C9PoPWujflrs7QK1
X-Google-Smtp-Source: AGHT+IErk1H3Uz2OQcj2tx4t4Ui2XV3s3oek1yyPvPrLTYbX/X+ZHZ5KPM+3ywNHAM+7XoLnU7xU1w==
X-Received: by 2002:a05:600c:3e86:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-471178a3a94mr28480705e9.10.1760706581890; 
 Fri, 17 Oct 2025 06:09:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471143663afsm81871395e9.0.2025.10.17.06.09.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/20] hw/arm/virt: Remove VirtMachineClass::no_tcg_lpa2 field
Date: Fri, 17 Oct 2025 15:08:15 +0200
Message-ID: <20251017130821.58388-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The VirtMachineClass::no_tcg_lpa2 field was
only used by virt-7.1 machine, which got removed.
Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h | 1 -
 hw/arm/virt.c         | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ca2e59ec569..ddbd2d78209 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -122,7 +122,6 @@ typedef enum VirtGICType {
 struct VirtMachineClass {
     MachineClass parent;
     bool no_highmem_compact;
-    bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
     bool no_nested_smmu;
 };
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d9ec61e7354..eb0e0e1bee3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2355,10 +2355,6 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
-        if (vmc->no_tcg_lpa2 && object_property_find(cpuobj, "lpa2")) {
-            object_property_set_bool(cpuobj, "lpa2", false, NULL);
-        }
-
         if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
-- 
2.51.0


