Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD74C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 06:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUKhi-0002lr-S6; Mon, 29 Jan 2024 01:01:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rUKhg-0002kn-79; Mon, 29 Jan 2024 01:01:08 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rUKhY-0001EA-Hy; Mon, 29 Jan 2024 01:01:07 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so2211520a12.0; 
 Sun, 28 Jan 2024 22:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706508058; x=1707112858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=sWsfdFbRJAmiDN0sId7GqNUIh6lAf5QQKJnr5TjAy/g=;
 b=hoMshuNYG9UeJTkNgNaLI2pfNO/3TqV7Vjcf8l4Dr3pzb85NkZZzyKVRmN8nkHWgiE
 CIHVAXN3vIZJUn7R32OkGyfCQwJo7T+Ytl/53GgwdbYW5o8JQ0mOgwoVLZeqLx1T1Wmt
 +laUAHgsIJnAMRtMcrQh9ozC3UAaREUk5mQ6+nzYSkhUI/mT4GSaMqb9KEMWVtzJFZQV
 0LlYb4Ol264b+zEsWcdoJLrYte0OM7552LGC4tzovGf2aJMHA7rB2Mpz0ed5NoY0bolT
 zMoftLRLn2UJFXHS8KwCnMSHCA4y81Z5fITzQllc30fp5ksNAbdrWjyIuTITXC0lznij
 t7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706508058; x=1707112858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWsfdFbRJAmiDN0sId7GqNUIh6lAf5QQKJnr5TjAy/g=;
 b=Arfl0FiBU/JNZ9Nd9Y7ouSTD/umtBCvjEiqy867lvI+bb+b08g7qnMQhaLsoN2cHyL
 quhB9Q6bCRauYbZaUm11XnRqeAcA2buiKOW4aH3ke5d+HZ3MggNLlGA3Cd6jTD7lVM9I
 7Wl6YHVMPwSCCICwmv1smZJvvssj6irX1PRwHltZRyuiE2xf60qcKgiUdWG1AZOZnRKG
 FyoWXuft5GWdU4Y0eHlkWAarDqSBAcJ6eJ0GahNnNnI6bNfQPAOjzGmT9/+9j14ygAOl
 I+2E8+UK4Z2VQ2c5SJXHyucqiox+doNr4lqSZk2b4hWh17WFkxuFYagWFnh4l1VSaCDp
 xd3Q==
X-Gm-Message-State: AOJu0YxnWbfUjJbi79AaeDEiixpK15Q8GsDON6borkkbayPdcFcD3MHy
 /TUmnUHipHKhm7EcvRR+C3x7Uea+9ws/lO1irzN+TP0E0ZI3/6XX
X-Google-Smtp-Source: AGHT+IF7BEKxEx3Hk4yiyJf494uQINb/A9B3zleDTo6uuC4X4f8aBJbiVisDcQ7VRNJAoWYPN7yo7A==
X-Received: by 2002:a05:6a20:94c8:b0:19c:7e9f:44c1 with SMTP id
 ht8-20020a056a2094c800b0019c7e9f44c1mr6521884pzb.30.1706508058488; 
 Sun, 28 Jan 2024 22:00:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170902708200b001d89ed2d651sm4498357plk.102.2024.01.28.22.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 22:00:57 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH] pci-host: designware: Limit value range of iATU viewport
 register
Date: Sun, 28 Jan 2024 22:00:55 -0800
Message-Id: <20240129060055.2616989-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The latest version of qemu (v8.2.0-869-g7a1dc45af5) crashes when booting
the mcimx7d-sabre emulation with Linux v5.11 and later.

qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.

Problem is that the Designware PCIe emulation accepts the full value range
for the iATU Viewport Register. However, both hardware and emulation only
support four inbound and four outbound viewports.

The Linux kernel determines the number of supported viewports by writing
0xff into the viewport register and reading the value back. The expected
value when reading the register is the highest supported viewport index.
Match that code by masking the supported viewport value range when the
register is written. With this change, the Linux kernel reports

imx6q-pcie 33800000.pcie: iATU: unroll F, 4 ob, 4 ib, align 0K, limit 4G

as expected and supported.

Fixes: d64e5eabc4c7 ("pci: Add support for Designware IP block")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/pci-host/designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index dd9e389c07..c25d50f1c6 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -340,6 +340,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         break;
 
     case DESIGNWARE_PCIE_ATU_VIEWPORT:
+        val &= DESIGNWARE_PCIE_ATU_REGION_INBOUND |
+                (DESIGNWARE_PCIE_NUM_VIEWPORTS - 1);
         root->atu_viewport = val;
         break;
 
-- 
2.39.2


