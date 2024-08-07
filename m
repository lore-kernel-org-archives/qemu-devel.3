Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB18AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnGh-0001Ii-C9; Wed, 07 Aug 2024 16:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGe-0001GJ-K9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:21 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbnGc-0006sw-AA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:28:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f1798eaee6so2246591fa.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723062495; x=1723667295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIi2lHvDdEsZKrUItMJRcgJ0QP34OToUQAWwLAh7heE=;
 b=fMM8OGjpsm4XcmXoZCocQnq7ACgb3PZBlzFpDB6RhHe0MElC5qtTCa53i7rEuBoR3l
 obN8lontnvqoIYMo6SCqorCF/gQNjcIXjX096bzVci1QYKEV3BUvWBfdNtWMD5fpyZiw
 LANqMV4SsutJK6v4vzfBZFpDS7z1LhpDNW+qsAJ0uc4saFrbPQWWeSFe9WAg4ZpCrRma
 EE6MBdqHMH/8zCRQIV66bQ2a1a+wXZP5rFYI/hsLaki+CxfYtyHA/1ipkt/kQxTHSCxN
 12huhFwVU2INnaxMj00qlIi7ZWzqSbgsH3AF5zxUODYV1gB07FfdjDwOJbFxYzbu+eiZ
 is5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062495; x=1723667295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIi2lHvDdEsZKrUItMJRcgJ0QP34OToUQAWwLAh7heE=;
 b=cEilcZBKT1ABgtOwzu4gaagapUz1wluWmPsqNjDxtcrbjLaFRBklbDpVDovE05uA3O
 KPHh0EPl/aX7GX3sGqoYqq6yBuK8Vb6avhMfj2qlP+z1+2UAQPzK2qXZ9qwmk47mVidc
 AsqYhQ0qRVP3nwI5FLIIkxol1ajaluIXrVKmLA0EP5cjBGVaXgI+0a4dOnptxQtv3FqU
 jragTeIJ4X+QS0hKTi4EXVFGae9CLA2VV3L5cm7q4MsSqJIZGsBhfzMXA1O5z9OdsaBY
 1fmG9d4pIHwPzxdUWJzZYlKwpgnmBCrFMWbDvqRIcJdKgDVleGmkiROwE2O3w58cq78p
 nYBw==
X-Gm-Message-State: AOJu0YyQxgMUkZ32cg5GBlIrl7A/SZjPpoCOT6Peoo2Lw34QSFu3zq1U
 1YDx7oWkELRMcsSWlH8VtpYJQwE76ivOxRy0JUlXq0e5hTEAxMx2FexKz9uyuEDoIB9Sj/H4De4
 I
X-Google-Smtp-Source: AGHT+IG8mxjT3+WiO8rxjUomEIUQ0tcfydWJYxdop68T+WHyY/YaKAB2SipzgMCevNgDbSDPP5oFow==
X-Received: by 2002:a2e:a0c9:0:b0:2ee:8720:b4c3 with SMTP id
 38308e7fff4ca-2f15ab1c1a2mr125847111fa.43.1723062494955; 
 Wed, 07 Aug 2024 13:28:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290580cf79sm43019145e9.48.2024.08.07.13.28.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 13:28:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 1/4] MAINTAINERS: Cover PowerPC SPI model in
 PowerNV section
Date: Wed,  7 Aug 2024 22:28:01 +0200
Message-ID: <20240807202804.56038-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807202804.56038-1-philmd@linaro.org>
References: <20240807202804.56038-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

It is unfair to let the PowerNV SPI model to the SSI
maintainers. Also include the PowerNV ones.

Fixes: 29318db133 ("hw/ssi: Add SPI model")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 74a85360fd..52843876ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1542,8 +1542,10 @@ F: hw/ppc/pnv*
 F: hw/intc/pnv*
 F: hw/intc/xics_pnv.c
 F: hw/pci-host/pnv*
+F: hw/ssi/pnv_spi.c
 F: include/hw/ppc/pnv*
 F: include/hw/pci-host/pnv*
+F: hw/ssi/pnv_spi*
 F: pc-bios/skiboot.lid
 F: tests/qtest/pnv*
 
-- 
2.45.2


