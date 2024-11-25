Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC60D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFQ-0005NH-3P; Mon, 25 Nov 2024 14:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFH-0005Ab-Iz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:43 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFA-0004qv-SE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:43 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3824446d2bcso4300996f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564775; x=1733169575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DywAE1h0x8RJnjNb6ZyyKOUQTV8+QaXBhNrpy+I4lm8=;
 b=MuE9dgHEm5E3cWeO0m6XMqf+KqbUiGtMZMzxlQC/sVjcuQ1yNWkATGtqHgN+4alyr/
 hGRZCOzS17yR/dJzeHsCiCoMp9VObClkT821EIrpVPpa06LyzylG1FI+MwbebG9ldsix
 HmQ3wNggxZt35C8jJf+zCM1Pcovvz3u1/LPEmneNKPOzkhwvi3F7MgoftwdwD5ICJPxm
 R9IUUxmQAmoiFSEVryNxJqEZ9HURud4AR5valJcAu0TLI9Sh40tb/0ZVsISPwVbsuAyL
 49wpJCJTAQCYrTkzlBTIBppptRZdWpQblOEstNkzZRS8nSdR7k9Jyw7lO9RV6FYr+jy8
 tKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564775; x=1733169575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DywAE1h0x8RJnjNb6ZyyKOUQTV8+QaXBhNrpy+I4lm8=;
 b=FuaI6WflAXUjf9Rhv9CN13GRRg3kAoJa5+LOGlELlF/RaK7KJ4BhcqChtTsjewfYmD
 oNeQDaZKMx2c5axHhMauFO2LyC1A5RBdF+lcSrTblyLWIRN5z8D6c+N4X+rhU/B4Waux
 Hd503gqHmJOGR9TxA/TlZS/HusmwEkyt6KMWHMh/7PIVnYZbKU2vMSTi9Y7HLk8V22gS
 kuKiMK0aWp9Z85fL/VEPMfo+87FqdQA+SXUG1PO/pU/KPnyQW422rrgCuhEtu7OsTGjF
 cE/0RpatuOet/QOk8uINeBHNbZhuqlLdoaGXbohaGhx+aRpNM1btv25pEaAacuLijWou
 xaPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj7tXVNawtuAb7NHWWUbpTUJz14QEJjaKCEX5PdFUoOLy8DoeNUyHHYHllgS15i51pZbNI5mvZGag9@nongnu.org
X-Gm-Message-State: AOJu0YwXUnJjcSl/IOhTjZWe0asN8gR5/swBmOWy0tpjDwfWL5BJn/S7
 Fy7KyIMbuO8pdXbbgVxbCkzGVZbcBtr3QJ7vJlZJ0ZX7UQ4bCSCkOdDbAb3eXMM=
X-Gm-Gg: ASbGnctzS6hkZJAYlTo45qcb2RJtjjMiHoQLTiB837YSjtyr1hkiqGpM8VPxUM5o4ck
 37Agkrz4fDKLJSHO/6KsIL8rTAqwvBmUUYN9FkfPAO3Q+Az4P4vq1xmn6U21LMVNYGRQXHnrKrk
 UttI0rnyZavFeyw6Yi5yREiX2qpFxJ3+8+KwtsARIl7f6GscmqKSIv2hI+Utw9x7OXymsnYio73
 VGPFWNyIFspptbJBjDJktDHhWknF84XrG8/j5mlo/l2YzaGzUaMwqEw66Fm2NFmVcfW
X-Google-Smtp-Source: AGHT+IFcITnBM6NuekDsP94qupu4u1K65i9I9qgzFbjGkHe4n3FTfQzWMtxpGxczoDQxw6ewpdqeIQ==
X-Received: by 2002:a05:6000:1788:b0:382:51d7:a2e0 with SMTP id
 ffacd0b85a97d-38260b61f45mr13353893f8f.27.1732564775393; 
 Mon, 25 Nov 2024 11:59:35 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:35 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 19/26] hw/arm/virt: Move virt_flash_create() to
 machvirt_init()
Date: Mon, 25 Nov 2024 19:56:18 +0000
Message-ID: <20241125195626.856992-21-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x431.google.com
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

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eb94997914..c4cf69ea33 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2124,6 +2124,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -3359,8 +3361,6 @@ static void virt_instance_init(Object *obj)
 
     vms->irqmap = a15irqmap;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
 }
-- 
2.47.0


