Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7E5CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5n-0004k8-CF; Tue, 16 Sep 2025 14:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya51-0003ET-ER
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0001eN-0u
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45f29d2357aso22259015e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046011; x=1758650811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g04gXkzqDwaTf/HMFL3z5yBF259ksFa2ePPUMCg8ocI=;
 b=LFv7UTbKt6+1geUJ2E2opgb84nAHpBuKYT+a8+eX3Ua+/sewJuNjWcpZJVSwlA2FW8
 7vMekg/7CSL033cvI66TQAyJHYCJPVezfeW/IurwjzlJuIP4Z0ZpsJDyWjdAoqKPULxe
 VNUjFtfPiC+AUaYm2vSE1s6pqs6yiL93x8cn6gouj19bH0Qk/Wwcgt27D9Fk/iBEoh2N
 xdZlaUPGhITC72cugoK4/l9FoIv1dnda7imvjTulsJ0npcXuhTxmuIPZf6rrcaocvjf5
 XofNTWuP7DKQ0kxJ+UVyAPKcQprpRchSJMr/JaKFCimpt391HTbdc7KElEcMFlbtUL19
 gMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046011; x=1758650811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g04gXkzqDwaTf/HMFL3z5yBF259ksFa2ePPUMCg8ocI=;
 b=nNobDsm6/sk+iaMtD+cJOwjIMzua0aW2h74jrYk2I4o5R3ophjZTtU4dIJMw6vo/sM
 /CeLXEGdr4jbFRuMUkY3ri3yXz8v16z3A2WmmBjcxvewCj8e22w5MoHt/o9Kc34SP0eY
 IRmgpiNIORoaAskTAYoNZNHI/3fQzuLunPocvsgKN2q/yyy0P2JgED2NCpB/MlxjNKsF
 //u3/h0rcMwGL0Z21tYlpU93fNREte8m4y17JjHCm22Tr/L3obF0R3PxkoD1ci5PsoV+
 B1u69hw0a9Vy7annSon/Fcrxgf2iilvvS6nRifv0xQopfvaarUIUDxigrwwTgd4JQb8J
 GK/A==
X-Gm-Message-State: AOJu0Yy1E708vf9fRy37ELcUPce9dc46OOzk8spwrWKekSX0cbwytLNp
 xCfvjRzvAuxqVxQ69GgX1kYg/XFwhAviFRdu1TYpCDuxeezHHET6lpu/wmVQGAJywvGy1Nk7Nq1
 Yj1we
X-Gm-Gg: ASbGncuX5cVmYDcdIJSbTplvf2IPvjk8kSVqIpxzX3eIGZBgQ9Boby0tqcmfqr7ABz+
 Aj9Jrt/jC9xH8Ljt2HSzz1w9+a6Ah1eZnIIvhG5SQAZSIUazxswwL7ZL2Vy9+CtpfjHl1mjsatw
 27PgSXClAnoDPAZNXJpEDSQvUhhbeRiai0cw9Xapc3MIChvxniCtaOERAmKEWkxxyGbmgyr5v2A
 zGtdzqeY6wZhqbbLl75aetFfaEz+VM8iMx1W0fS5X/Ft2X9OpbTyUAKngnWDXEMZ8qrX+R7165r
 o9Exe0bf4Njy3N5vPdnTM9O2GyfNAZoJCE4I8OxNT2Qg8W+K+wBbG4h/5Zdwp1YHjoM4DN5a6+1
 aj9wuKtRzsGMU62s7oDDg6xIyAd3N
X-Google-Smtp-Source: AGHT+IFfqxlrCXqOuWFAW5+8yS0nIQ3nrosZhM7H/7dTtDigUVzdaaNYcmjBjEvf3zahSrtOMyVXIg==
X-Received: by 2002:a05:600c:c1c8:10b0:45b:43cc:e557 with SMTP id
 5b1f17b1804b1-45f212067efmr125240225e9.34.1758046010864; 
 Tue, 16 Sep 2025 11:06:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/36] bios-tables-test: Allow for smmuv3 test data.
Date: Tue, 16 Sep 2025 19:06:07 +0100
Message-ID: <20250916180611.1481266-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

The tests to be added exercise both legacy(iommu=smmuv3) and new
-device arm-smmuv3,.. cases.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20250829082543.7680-10-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h     | 4 ++++
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev    | 0
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy | 0
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | 0
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | 0
 5 files changed, 4 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf..2e3e3ccdcec 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,5 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
+"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev b/tests/data/acpi/aarch64/virt/IORT.smmuv3-dev
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy b/tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy
new file mode 100644
index 00000000000..e69de29bb2d
-- 
2.43.0


