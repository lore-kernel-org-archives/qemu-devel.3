Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4348DD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kp2-0007Ke-9w; Sun, 03 Nov 2024 19:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kp0-0007Ip-HF; Sun, 03 Nov 2024 19:19:54 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koy-0002Ji-TO; Sun, 03 Nov 2024 19:19:54 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e467c3996so3013871b3a.2; 
 Sun, 03 Nov 2024 16:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679591; x=1731284391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8AvT/FnW3aX5+LIUAhqePEJ/QWevxFxm8Hw+y35nEs=;
 b=IEq1C9J3Ar2vDg/6/EPH7fu9nQ0ixl29ogpayZJhCPAD2ZmXs4723K8St1naRkJKbI
 PFlSXmVg+ehmduC8AuFNSUXKHcA94xaQnL+sPTYTy2GNY8g5jZ3Jyvi8Dq8pzJ5RJks2
 WW0i61JuLlesrj9tEXfgBk4zD3iUSUwzQJq19KTrCG1W62cyxjdJ7h12LeIwa+8XopY+
 /WeuUvAOk3BAlonFmRo9UFfAUv32AwauIYCOIfad0ePGylMdw+9HB64QN3HzxWEhS6S+
 S0IJ53yAsvZo0++U2Ese1CqIrgF4V9LttcgUR/eH/IDxV4N3xksB1JhR8+Ce7fPbObTN
 c6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679591; x=1731284391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8AvT/FnW3aX5+LIUAhqePEJ/QWevxFxm8Hw+y35nEs=;
 b=bDqwb7uHMhWt6I5G/aFGLTW7MaCmJow0jo5bKysehYgHqL2XPlnURKpMmS4uvn+45J
 /P7Bq1tjLxtdYkpiBTGu6z9ElC2PBDrb53OTV38zr3LVUa5Jyi41kXf4XJrrI4/nLGx2
 q7vAV9ALRZIthq+eiXfcb0iRolX259SI+ScIcV8t0rpa+PRzg1YNTBfvC4HVkW55dm8h
 rM1Ai97DtMYysq95DG09Pc9WtoS7w8HwfEIym15dO18edZVOsnlLZPmBYqyU9cbuCCv8
 FwB41FtMiq89P/iW1gLQqBYVaBrEDiP5X2eynMUe5tF8j0Dl+6jSoVKRYc27QH3g1gF1
 ScqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlENpfzqO9b28ZZbtMNi5vgrw4xgC6PODracQPDHa3ogDmX8oeZGmuLmq3N+y4qjdPrzyjr1RKYA==@nongnu.org
X-Gm-Message-State: AOJu0YyllIBWC9h5Pk0t2IaQIcQe4ohIPXUE+06pbWNKl/vjPgG5AWzO
 4QKQ6cP6aPVt0nxcjLAcaBXL7rDsmonbui3v7PMnoo3FtVRQ39dhtUSufw==
X-Google-Smtp-Source: AGHT+IFQSYNsZB2s0veQmbJmGelb6Jh6JBFQWQmm3zie2qMit4AoaOo1F5r8pbg2y/4QgykPIZ5CxA==
X-Received: by 2002:a05:6a20:2d1f:b0:1d9:18af:d150 with SMTP id
 adf61e73a8af0-1d9a840a299mr42497310637.21.1730679590897; 
 Sun, 03 Nov 2024 16:19:50 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:50 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/67] MAINTAINERS: Cover PowerPC SPI model in PowerNV section
Date: Mon,  4 Nov 2024 10:18:00 +1000
Message-ID: <20241104001900.682660-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

It is unfair to let the PowerNV SPI model to the SSI
maintainers. Also include the PowerNV ones.

Fixes: 29318db133 ("hw/ssi: Add SPI model")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e88b5738c..cf39ad4b7c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1505,8 +1505,10 @@ F: hw/ppc/pnv*
 F: hw/intc/pnv*
 F: hw/intc/xics_pnv.c
 F: hw/pci-host/pnv*
+F: hw/ssi/pnv_spi.c
 F: include/hw/ppc/pnv*
 F: include/hw/pci-host/pnv*
+F: include/hw/ssi/pnv_spi*
 F: pc-bios/skiboot.lid
 F: tests/qtest/pnv*
 F: tests/functional/test_ppc64_powernv.py
-- 
2.45.2


