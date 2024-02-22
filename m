Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD008C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cT-0006Lx-0t; Thu, 22 Feb 2024 07:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cE-00067f-Ed
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cB-00053I-C8
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41279488d3cso10238915e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606550; x=1709211350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haz8xWPEOIi2z03nhQKaHcW8uQbVkLIuqEbGOCYseVA=;
 b=JPxg0jzhI9/K6/rPTOvkP0+Ah1sEWIgSt2xOIm3ww73x8I7SsEDR7cOz22aqS073HV
 h28IaWaRSRHJW5iaw8PLKC+yJG9FIMSZMfVonPZ7dmHhT//GYkWobl2oCjdOIDJBt69A
 lTt30vrxUgGAE43JMQnP3E5o8LnwY4KR3fQSkzNWPkyIoJ3pS11gSTrOCP5ZioY5yowm
 ir063k0+5gC8bjfNdgLHPnA1lO2oujLw97GwOI3YLAlgUopB56mRXFIEN06UbZhkrw8W
 QHJHhhJqiy6WWMJA+bBsqhsRZM3Oz3rg2WKZAJVpsjRtSv3oYPnzdXj8mr80FSeN0LHv
 5NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606550; x=1709211350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haz8xWPEOIi2z03nhQKaHcW8uQbVkLIuqEbGOCYseVA=;
 b=HDuJ5q6l0dBWH0ZUN7qVUzd64dK4WCLcP6p9NhmCo2aysEtC2wLLgSNmsJbWo7MbK0
 fd+pyVEJHSDAmIyFuKH46eJQQdEEfIHkSKfBZdroEOB9j0YaaCchoMFX+qeZQuJ5lukO
 dlqtzIMeFsdkmjAhfARH0eDz1vX+bQweaciTzoROB2tCcbOfjDMjMWtpMXDnC7oWF1Lm
 znXbuAkTe1N2UUNt3zjCzdNaPLvxcpXyddIYyr4xzncQXcOFn8CaDF8SZo/Upms+o2sq
 jFVf4/5euTsZVm0E0ofBuQsFx6rZWsUuWQkICyw0E62qw/MLr4UviAKnpVUGITV+MdX1
 s9rg==
X-Gm-Message-State: AOJu0YxnOzbi/qnoxt9bzJV55OCWk1XOXXfhAwcKuZXXNJls1MtzzpCO
 EDrXQH+jJiDF3mYMVhDk1f4vY1CVj740DZ2gnESFB7sMheweCfmCDS97ewPlLDeRLaxt2Scq3Gh
 PUyg=
X-Google-Smtp-Source: AGHT+IGvFODj/yr1I9Iw7wICafwh6VhUyzSkOWiiJy9Bhjhf3R/9ZfFWycYyXqZ5WaVRJ/QStgmYnw==
X-Received: by 2002:a05:600c:1384:b0:410:c128:2bed with SMTP id
 u4-20020a05600c138400b00410c1282bedmr16176314wmf.20.1708606549802; 
 Thu, 22 Feb 2024 04:55:49 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a05600c21ce00b00412704a0e4asm5983207wmj.2.2024.02.22.04.55.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:55:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/32] hw/acpi: Include missing 'qapi/qapi-types-acpi.h'
 generated header
Date: Thu, 22 Feb 2024 13:55:13 +0100
Message-ID: <20240222125517.67131-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

ACPIOSTInfo is a QAPI generated structure:

  $ git grep -w ACPIOSTInfo
  qapi/acpi.json:81:# @ACPIOSTInfo:
  qapi/acpi.json:99:{ 'struct': 'ACPIOSTInfo',
  qapi/acpi.json:109:# Return a list of ACPIOSTInfo for devices that support status

Include the "qapi/qapi-types-acpi.h" header to avoid the following
errors when including "hw/acpi/cpu.h" or "hw/acpi/memory_hotplug.h"
elsewhere:

  include/hw/acpi/cpu.h:67:52: error: unknown type name 'ACPIOSTInfoList'
  void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
                                                     ^
  include/hw/acpi/memory_hotplug.h:51:55: error: unknown type name 'ACPIOSTInfoList'
  void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
                                                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240219141412.71418-2-philmd@linaro.org>
---
 include/hw/acpi/cpu.h            | 1 +
 include/hw/acpi/memory_hotplug.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index bc901660fb..e011d01adf 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -12,6 +12,7 @@
 #ifndef ACPI_CPU_H
 #define ACPI_CPU_H
 
+#include "qapi/qapi-types-acpi.h"
 #include "hw/qdev-core.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index dfe9cf3fde..38841d7b06 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_HW_ACPI_MEMORY_HOTPLUG_H
 #define QEMU_HW_ACPI_MEMORY_HOTPLUG_H
 
+#include "qapi/qapi-types-acpi.h"
 #include "hw/qdev-core.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
-- 
2.41.0


