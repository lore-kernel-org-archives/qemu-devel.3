Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C01F327CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSZi-0005F8-GL; Wed, 22 Apr 2026 04:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZf-0005EP-B9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFSZd-0001Bh-Ua
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:04:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d6fbd0954so4089608f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776845080; x=1777449880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPz0HXS2jfx7mdnonDT4NSN5t6aFfr7KGsJhvT91t+Y=;
 b=vqU3qHEzU05/ZMrWJro5tvZACMq4xdHQPUyWKtuldXMk7OTEQ9YoIrFOFx5ywG8yZH
 p+BBUR6F6EZGuxpBQyuR/MMy20B/kvfy0w2Wbe27vDpRST+FDnV1xdUzMRefEJyopKiQ
 JB0p7+3mfTNUrl6c++ytop281rtYOoGmnEQJ2bukQ0l6eqLHNrsEBtjeSTRQqZOm6fAr
 A4KPiCnoivVraBeQhs93BCyHLicb7PKWviydztLsCAkDtQ120Bbf1kEFYezkdH/1FwRz
 PAMxhP7JY5kYcklVzi9ApqcICYf64g2GEQHdLbCKkCNWJ9SocBL0e9wFE+zK3KGlAWZi
 HPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776845080; x=1777449880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KPz0HXS2jfx7mdnonDT4NSN5t6aFfr7KGsJhvT91t+Y=;
 b=p24bGDnMwyavwyNDRKIdiHln0MCZDE1t3uzV9L2upoL7ttPER9C3aHY81/MOf7pS2H
 YIroSQmKKI/VX+tpTuLO/mzxwEz6wPsgvPc4I4oV+Ed33jHqvIN2phYOqjqGTncJ4sE/
 r79uDceiJgWOP1c6wDAlMqLemWESL5iMv2RhGOH/iwWMBD1rw6CPAY3Slth2NXBvOOG9
 ZE/XOmoLjDhCroLnW7hCtSQo6+aWQXdBWbIe+ZRelKwHB3HQqgnTtyLCqBKXMXVUyc7P
 CuYmCjz5+kvOq+YGsp/3ri+fvztQBOZ1XBa3ab4OwYvE0tIJny63y/KzF4b5lbTAbCDU
 8Jfg==
X-Gm-Message-State: AOJu0YyUXUuiZcWTguNo9F1NK8i5sSkx6JBEYg41OmtVJDireVtMAZEY
 klKdbvzNSbl8Nz1hBaG92R7kDSHsa2K0XvgwiKa46d7RFmj25BntfZRnQ+kdP7I+vazwFeKqUx1
 wkgFUNFI=
X-Gm-Gg: AeBDievjBlgFKWUSAyv+DdYdZOHU/ns3zbOrFdq5kh6mGhZ8+zTY32vR8z6nNaOgfh3
 oU4rml0wp0JmwnBDAtjQpSXIzuv4LEphoOU4UYOFccfp/j5qjIejdRCenZSOcI0qqBmkO/IJ7nx
 Wwcta6Uld3kPW3nxUOXGkO/MvgWUjRbZUKIZaumbV7xzNBpypR+ECHibhnQxQSWBMTb87ffMBl9
 pmuRpSyHGWQTnRFV8USxgKn57GjgMrY70YbOJj6kEMWQ/wsmlsiHC6ZuXMDv5tT+ZpO7k8Wnbn0
 ja8w0c3w4NTABcAgsBDLsl19VVvW11stV1J6ipEvMt5EkJW0WOtg33Cskbixa0bU/UlGNgngMzN
 Xx/qBL0v30T//7k/P1094jNEhGl844fDfC+yzsmnicsIKw5U7O7kGiqEjRs8g1FdqXW4gHG+Vg4
 khozRCbVbuEY02joPzXGUCnyhn2ToAcxDl+1nf/wqfcy8nTI8uzkAR5P4h7hZbDdZkR+RrjNs6F
 vOSBS34YDH73kDzE/H/5A==
X-Received: by 2002:a5d:5d05:0:b0:43f:e7c4:a36e with SMTP id
 ffacd0b85a97d-43fe7c4a3damr28391720f8f.16.1776845079642; 
 Wed, 22 Apr 2026 01:04:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc09b1sm44241846f8f.9.2026.04.22.01.04.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 01:04:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/10] MAINTAINERS: Step up to maintain core machine code
Date: Wed, 22 Apr 2026 10:03:59 +0200
Message-ID: <20260422080406.62638-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422080406.62638-1-philmd@linaro.org>
References: <20260422080406.62638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The 'Machine core' section is orphan. Being acquainted
with the code, step up to maintain it.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520b92826a2..d4dac985b5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2016,9 +2016,9 @@ F: include/hw/i386/nitro_enclave.h
 F: docs/system/i386/nitro-enclave.rst
 
 Machine core
-R: Philippe Mathieu-Daudé <philmd@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Zhao Liu <zhao1.liu@intel.com>
-S: Supported
+S: Maintained
 F: hw/core/cpu-common.c
 F: hw/core/cpu-system.c
 F: hw/core/machine-qmp-cmds.c
-- 
2.53.0


