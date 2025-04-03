Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2B8C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RN5-0000Ui-9w; Thu, 03 Apr 2025 16:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RN1-0000UG-0L
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMz-00054g-1T
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso11711695e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712858; x=1744317658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=877Ft8S2r+Y3e5owHO3tHYlDGhoIjLwtX0511Fk5+so=;
 b=fU/VdtIOELqOhynYVKlhaAzreWU1Cxx5ASG3rnM6Uot5h9d/19qAo5MlMmpamS7NHG
 h0oKQ/1bcOBq0x2wbH2ez59979Uv6QPxluNk7GLdvSdDjr7hkAV1JISrmkoDCQnBcVdD
 7jMmvvSQfzKm8DvCBEN/nWMHZwM5JZjoM1xjn9NijvWOIaXpFaDKzyuVvmRREzbQ7x3F
 Wof8XLGCOQhxvd5sv4RZQjVKoO8hhyP6qIsjp831Yl6oRKz49m2G1Rgcrtre2Lhsqxua
 jRlczzBp80Su8ZxaXW7JTx7ZqNT5qZq8MzIRC2hlRguaVmBk3q3NbQrBJjVu2V83LWxu
 IptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712858; x=1744317658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=877Ft8S2r+Y3e5owHO3tHYlDGhoIjLwtX0511Fk5+so=;
 b=vdo9mir9jyd89RHxce9CdnAdxVUsmcOJSXF+gtcdzeSF2ERPcfIoXcOTbJC2LiuNTs
 55iASjcpmWuU7gxUu6oCU7Mpwk1vKWG38FBpZypRd/Lv2p7Yq8WUkVf9rNf4vRJqGmf2
 Hl0lPeSkwGErpOwPdEf3jkkKOdsY3sZIg9Il2/+c5JitRsGWG2sR5jlEsfDs5edlT0Ae
 uA9eGQTS0Cxw+RDe1nNPMLuRlT8zrrao/Lr8ygtGNRt++hNJ9jBJehpWzbCMmUPMp5UM
 +XAs5l3S8BrtTjSfpAmv6GvFjc/2milnJSzB4cIf39XGmY2dtXTGZ5DNNpw39SxmW2qE
 kaIg==
X-Gm-Message-State: AOJu0Yz16Hs3U3+XJNY41UlZclEtNZzkZogzLFKjSkdpd2G2GxzCYMvS
 pj/ddJHkQwEu50IDSLvIeDEz9k/dSbzYYJxezjvsQXhDYSd9IpjMPOIWHGLT7Ltob5KzNVl4qaY
 L
X-Gm-Gg: ASbGncscYk2mfixKpz+//6vdndcwwllERPoVuYcejuUBPIGjFAkU9brBGzsYE/6XWSh
 lOx5zTNrROnyHyphkD66oAmrrfo641K+luf6mvq4Pgj4Hnzc8Jw+qMyUe+XGVU6Df4CNy0C1nvu
 I7ILmdg0NOukFKN8p7g4ihK6365yKF/TSNcWxFr3jJqLPfLCvflscRwlY28kPq2Xr2oxBv19MQc
 YxMYGXVC1JFG3DUahJYiJX1hliwNUoV/eAhFACXmdz1DWIz4fwzMMjp/VKn2cGy2Q8G733bpQOn
 lcBC8d7/WTQXba2sA2WOcNh61PeIvge8ma8Buva+t3AWD/s122acX0bdJXuzi8+B2tCQLh2jIof
 U7ufFbD1cZma8Zuj/+QCHOiyn
X-Google-Smtp-Source: AGHT+IGfjUcJG9Fw7vR54jYQJL9/ZtCgzSobq42OEOH5Ba74HI3rkv7ic03mtQjOW5kojYSeYFTrzA==
X-Received: by 2002:a05:600c:4e05:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-43ecf90b278mr5431455e9.18.1743712858208; 
 Thu, 03 Apr 2025 13:40:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ecasm2751545f8f.18.2025.04.03.13.40.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:40:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v3 5/9] qtest/bios-tables-test: Add test for -M virt,
 its=off
Date: Thu,  3 Apr 2025 22:40:25 +0200
Message-ID: <20250403204029.47958-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Add the use case reported as issue #2886 [*]. The test
passes while it shouldn't. We are going to fix that in
the following commits.

[*] https://gitlab.com/qemu-project/qemu/-/issues/2886

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec4353..baaf199e01c 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2146,6 +2146,25 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_its_off(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    test_acpi_one("-cpu cortex-a57 "
+                  "-M virtualization=on,secure=off "
+                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
                            test_acpi_aarch64_virt_tcg_acpi_hmat);
             qtest_add_func("acpi/virt/topology",
                            test_acpi_aarch64_virt_tcg_topology);
+            qtest_add_func("acpi/virt/its_off",
+                           test_acpi_aarch64_virt_tcg_its_off);
             qtest_add_func("acpi/virt/numamem",
                            test_acpi_aarch64_virt_tcg_numamem);
             qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
-- 
2.47.1


