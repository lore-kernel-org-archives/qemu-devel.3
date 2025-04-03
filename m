Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECDFC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RNB-0000WD-3L; Thu, 03 Apr 2025 16:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RN7-0000VS-1W
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:09 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RN3-00055Z-R2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:41:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1174856f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712864; x=1744317664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLYRdVVgThynsCkkZUPojC5QmxuF1gOqeLFrpCloSHE=;
 b=xq/grt//rjkCSrHHgRRorlsHP0+4zw95I1KhE3Q8XUnN8EiZQW6UdXpE63YSZ3pXp/
 HCq8K5EhEqliHt9OYVnK52I0Ql/kEttUOxRNclBluaAWSaV71Q04GwCBlTVl/kApu2W8
 3USH+U9l63pHRS4mKFW5Cobnhe6kmL8piFkxbGiqte8i8bxPqDTVumZRyYAPliprOPJt
 j1pcWmGpSdWbdrtpd0ReFgjqKloh7ef3TEIyemi4AjQ0uduaDFY9xNv89jTxNf+pPe/o
 a6POsiaF/0Ih8T09qeItrICB4HgGFAfyS0vexGrEYTX+lbFStW8cn2pF8OA5/0HNjuyS
 d7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712864; x=1744317664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLYRdVVgThynsCkkZUPojC5QmxuF1gOqeLFrpCloSHE=;
 b=sL9kGK+jxlBgE37nqyWZs5KMgoZL267HRtR1NZFEpHCEW/NZf8uKmew9XHxpD7GosT
 gBuH0PMd1vxIKjKwpYtHV1aO3BQOnZEhVwlidGNaisrs0aDg178IC/+mC6zlyQfV2AF5
 Y/Ra+v6kbFraptFHsMsT1RGgoilJt3FCLqFxV+Zi8KXaKuj8nq/S1RX5qTerQ1mkk2BO
 j+9qn2bgzHKLbwz//tEPpZH75PlnMOIdstpjLjDQqIdQiNSHO7QN0fEzWBERSPnk9jjW
 mDDElCCvxwVZRWtURaIqmnhZepk31Yob4UfaT0pSogYhEt2D10LPHhmaHCtYcn0EL0r/
 TmJw==
X-Gm-Message-State: AOJu0YxXdPyMTX1CbEz+nxgSVQ4KlzWSQoZ1v/Ib6ctTA//Pn5NFTcwe
 XklFQqNdKA/hVuwnh0JQBpbImz1HVt4tEQo8V8ziWlE7b9kogGhF+0I+GO/YjRDCGm8kwQzm2Z8
 b
X-Gm-Gg: ASbGnctSvpD3qv/FiauJ04/tzZVk1zFkjljYPIYAtW7nVxBSx5HKUsEpvUfQtG4d2ub
 YNWVbtIM+7hvFT/iQgXRsLWSe08I85FybK0mKjGDxxJXKz5v0L8Cm3hSdg8dzEAJKEdsG+JOxLM
 bJRMf2UQgktnDtBPiv1Z1ENfuW9QgDkPWKBV+K8UXJsZiaHLLwSP7rGZZRbG1Sxw0WxhFe1LhTl
 Hx3kBsJoeNdXcTETOQ1Ndx5KMpYObbABs6ZD7U262xuDNVnJ+9zF0HOCTIWIL3BmFIuV8alzksR
 KIkTh04LXL57jKUYNPlMVT9IcZlx+tUMCFi/CkVnohd/ssyG8uwAAcleJ4v6jmADaMKTQ8TRgaO
 6oNReV9oF1sMdjiOU/uNp/9/e
X-Google-Smtp-Source: AGHT+IHojbYMTI2SxjbDhqL1jep68YzCCoAPzFjtnoNR9EhzKBd3AcnPJyCUlbk4mdyAKPNG58yR5A==
X-Received: by 2002:a05:6000:270e:b0:39b:fa24:9519 with SMTP id
 ffacd0b85a97d-39d0de2d383mr130133f8f.35.1743712863777; 
 Thu, 03 Apr 2025 13:41:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1662feesm30696335e9.12.2025.04.03.13.41.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:41:03 -0700 (PDT)
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
Subject: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
Date: Thu,  3 Apr 2025 22:40:26 +0200
Message-ID: <20250403204029.47958-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
test. In preparation, copy the ACPI tables which will be
altered as 'its_off' variants, and whitelist them.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
 tests/qtest/bios-tables-test.c              |   1 +
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
 tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..3421dd5adf3 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
+"tests/data/acpi/aarch64/virt/FACP.its_off",
+"tests/data/acpi/aarch64/virt/IORT.its_off",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index baaf199e01c..55366bf4956 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
     test_data data = {
         .machine = "virt",
         .arch = "aarch64",
+        .variant = ".its_off",
         .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
new file mode 100644
index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
GIT binary patch
literal 184
zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acpi/aarch64/virt/FACP.its_off
new file mode 100644
index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
GIT binary patch
literal 276
zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
CVg~^L

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
new file mode 100644
index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
GIT binary patch
literal 236
zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
R!2`+%Dg6Hr$N|zYvjDIZ5CH%H

literal 0
HcmV?d00001

-- 
2.47.1


