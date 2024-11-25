Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B73D58D4C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 14:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZkK-0003Cr-Ud; Mon, 25 Nov 2024 09:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZk5-0002j9-6u
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:07:10 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFZk2-0006ik-Mn
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 09:07:08 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53dd0cb9ce3so4089502e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732543624; x=1733148424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEkIR2vBaISG4rMjnIPuSSQYyM7zelGC+1W4S9oVQCo=;
 b=rrKyp7u7YICai8X3vlghwFPBOkED+jmkXZAbNNLDG3uavXYgfoko0ILw0r2RCu28c3
 L/bXqoB4HphOJB00tQqolx/jNuosXUrnCLf9Qcdi++0SEaXx3w34WXGGvaZEAb6Jd0/I
 VdblJew4XS5P95wg4NOq8SxrvRQIhuqnavxlPln5y8BGICW4SRX9DhACqAMxugvd4KMQ
 pirRxCiU8HvXhIcw5Hwjqsaj38YlWPado7HVRw7LGLK2WmOd3eloXUcRi2fw0nbuIUHt
 EuDkbZXZznenVF6kNzu89dB2ObKBiZMvFIwwLqbegjdZWpxp8Tt7ayRqPRoOCiZcFVgJ
 Hj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732543624; x=1733148424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEkIR2vBaISG4rMjnIPuSSQYyM7zelGC+1W4S9oVQCo=;
 b=McChcKkw+5T5zbGiMQ+Yxrh0ySynDQQjiq/yy1Goep3324zkjn0vYeJwlwbAQmm/Jh
 6COqsm9dLOG7Fp0WPGSxB/1iu7Y670SnLr+keJKjl4yICHHP0cdkJp65iYV62auOU06K
 MBYIZ2+NWi7lbAKQ40FhXEuM8i1PyjY25BdVitH5IPbPnOHhxb8V5J4XjjUVYdyFUaCZ
 aY4aL+Tf1YVYt17HcLNb94vDFb/Qr2WE/qKgWUkKDTKGPaNCKlFsDZgm5WaJMgIGTN7l
 qJUiCyKyr/v2gZXXyn4Bj/oGjSd1gEn+zbT8t3BinSqZn8RDyb14HqiTUnSCeXwha+g/
 dfsA==
X-Gm-Message-State: AOJu0YzszOq4WF0C9Zagf16WWSLDn4tulbqHirJoBpb4H+3qXv22F/oc
 Qqn21VEgn9Tj7xaUI01lS5ySMcgfmA6ih/bNDvqQT+T4CxtlKz1n7//pqoO5/T2qXWO4BdRs4fY
 c
X-Gm-Gg: ASbGncssyzBn9UDeEkLKepyMlMqrJbt9X2nKkKt7XvKehVwqowjdD/ymHCW0dPMeL9T
 wum1AVE6mhh7CC6vF4ShR7gEaBlXVFkPv2OvmLXRbFXClXx3IdhQfQhB5//1oSXHyHitZaIxzCk
 ztAiE9fuBE+T7UtebSQjTrV8NieTvV+MRrWtxDJxFtzpwGNg3vYkMDOQvJ4mqFKV/PspGSEZuEv
 SKNCqrj60TZwqDkND+8QQ5EeO+uYAVfH0kdBRl4N+mbNAyVT8SVExahCklSGEWTx4pXBRSM
X-Google-Smtp-Source: AGHT+IFL9b08/2sB7lpIlsx+WOKML5g57kEkneZkhfRmHVvCJsZQUyqUW8XUhBzB/6deDUzkrl500Q==
X-Received: by 2002:a05:6512:3b0a:b0:53d:de48:7409 with SMTP id
 2adb3069b0e04-53dde48744cmr2788380e87.0.1732543624453; 
 Mon, 25 Nov 2024 06:07:04 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4348e272094sm84910365e9.7.2024.11.25.06.07.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 06:07:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 5/8] hw/arm/sbsa-ref: Set PCI_BUS_IO_ADDR0_ALLOWED
 flag on GPEX host bridge
Date: Mon, 25 Nov 2024 15:05:32 +0100
Message-ID: <20241125140535.4526-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125140535.4526-1-philmd@linaro.org>
References: <20241125140535.4526-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

All SBSA-Ref machines set this flag in MachineClass.
Directly set it to the GPEX bridge.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..988a0a236e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -647,6 +647,8 @@ static void create_pcie(SBSAMachineState *sms)
     int i;
 
     dev = qdev_new(TYPE_GPEX_HOST);
+    object_property_set_bool(OBJECT(dev), "allow-io-addr0-accesses",
+                             true, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space */
@@ -896,7 +898,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("neoverse-n2");
     mc->valid_cpu_types = valid_cpu_types;
     mc->max_cpus = 512;
-    mc->pci_allow_0_address = true;
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
-- 
2.45.2


