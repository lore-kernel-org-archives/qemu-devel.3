Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AB9C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MOT-0002RP-8p; Thu, 03 Apr 2025 11:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MM1-000807-IC
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLz-0000ag-Mn
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:19:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso7857865e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693578; x=1744298378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=877Ft8S2r+Y3e5owHO3tHYlDGhoIjLwtX0511Fk5+so=;
 b=bMH6ZeojYfJUxZnwDbKvB3IB4B8N4TEJ8pTVWSGr3QPTeEQxkPt2dj0NAsHcEYvSaY
 dwPpCOTPlBWR30HRtCXhMKNW/+NiY7n/Jf+H7Bt9szR3p3mpnLXc7fTJsY8q4gz9WReN
 k0gtbyi8snFFDSkv+3Dm0gMoNLc9ySEELscAKPfn1iCiedl39mgncBeRnSk4pC3pIF/i
 CTvtnGGnmlKbn3PVPSf9OJBoNjthPIeYCxCFM1E6RFIUiZsZ3L5C5MpR+0cwmzwKotnB
 rO+WbkG2+kJ467zi5ovITMUsZoyOoyX9sTdYaD4SQRW7TZ3p9LipCMIQWRBCOGUgVSVq
 YwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693578; x=1744298378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=877Ft8S2r+Y3e5owHO3tHYlDGhoIjLwtX0511Fk5+so=;
 b=bvx6FLXWKnz/jqjN+XeaWLxLDGBXxSmjxfT8QrbN8RuErn3sp2fyYQBJ3rzmWJ1Lon
 VrW9qVSC6NDlvezgBuIe309X7EBu2U46/jeWvYVYKOV0HjLf0aiPYvNgFXyXbSP79k4l
 8LVfz48SE9TroEwCzlUfBnE6afAA8YsAs+TYnelTCcXhrwlVyw22PnefV3b7CL3DRJty
 6iyK74wIOFv+xHOp64/fxSXyOOnI8IaZxJDkMqzs0e3xqaGdMhP7wgr/2VA9cnB/9EdD
 nXet3uT345KVG3Xngx+NCb0xPWvWcCLmLxxCD84qrHQa0wtZ7QYT9xJXgk8E7BV1PCZS
 t4VQ==
X-Gm-Message-State: AOJu0YxeXOd6d6V8H0JGkmUIHEWBOvo/2rMqKdPKh1za+CyfAIfZLBm6
 bw48ENhmSFxq664Kj4cozaSPJoGeKKtCv6QKCH+vE0XPZEvPm1oMqrN4Uq1DheiAko8EADIfDI1
 z
X-Gm-Gg: ASbGncuLE3YXEwghECYxwO3OAZAo0uMgxdkg5WCllZU2WhiM9gR1HJ54D/pJI7jcE0s
 IHJmXFjDAoLtr/cge/ituGHs6XuRRZZGC0TTDI37Oc9XdE97L7hwdTP0W7tWCm5DdcKpYWcQx8c
 29JTci0swLrPMQsqya4mBsxgTIzO9H2/EPJLNRssUiEKCXyUzuXhUWHldJonaqcH0/hH4qN/t83
 daY/OmxJpPwt+DjPawpI7kZEe0dxpMzS/6I8PjT5r8E12w+koOj4gupVavzuGN8wIs8DDu1xVn3
 RgPBOH3Mt8qLxgWhm1wp5QOa3FyvGL5YQ5pGrmkkDAD2C586miGa2SQUn9wXVGz6ax7QHYtbIPm
 mJxnYp2oAWTdIxUy+Xig=
X-Google-Smtp-Source: AGHT+IGDUdyJ7Y8Jlqpb4UolknqM0gQl0QwhPEtcpspj4SROqYp5bu7UpbwJqlHMRdCbPezOjVIzzg==
X-Received: by 2002:a05:600c:4f85:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-43eb5c95ab8mr67541505e9.26.1743693577813; 
 Thu, 03 Apr 2025 08:19:37 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663053sm24538415e9.15.2025.04.03.08.19.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:19:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0? v2 10/14] qtest/bios-tables-test: Add test for -M
 virt, its=off
Date: Thu,  3 Apr 2025 17:18:25 +0200
Message-ID: <20250403151829.44858-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


