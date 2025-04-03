Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EDCC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RMe-0000O1-M5; Thu, 03 Apr 2025 16:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMc-0000Mv-Bh
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:38 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMY-000501-HE
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:36 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so907077f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712832; x=1744317632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pxply8yIkySJTvDNIEdcC/CzMn2EFpNjcgIvnBNgm5s=;
 b=Jnwt0ftHsUm2j9zJ6JUeCiwv4DKD34xciacak3FwpzIXDh/P5e+feicUKMchI7tGmW
 sZccDl82CmO0mmq4tvGzkux8poJHcHFyh4PcegkMbrTcC1q1+qO/AeVhmYd4JQeeFJ+O
 WuEqV94zgA0aLBrRUI9lfGnSNP51YuG/0OrqC243lwnbCoJY67wUcwPpU91xv1wJOAv+
 KwyL7CXgTkG7n56F2Xt+HXQQVsDctvyrPUFW2VtlZjiVO5N8P3yNTaT+D7j26NsOyORn
 S6/u5qYBXcTRqhUBzS1g4W/UArN5bRZgEzdhQbmywxIqA9DpJ15VGSKQyoMTToI2pbv6
 So4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712832; x=1744317632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pxply8yIkySJTvDNIEdcC/CzMn2EFpNjcgIvnBNgm5s=;
 b=wqsfJd4aytSKPpgTNTzbdDKUDv/ALXkCurcNLJviTBQY7heocjw3yLQN0hDVqA9z33
 BGn856HlVWJPM+isn7CX2sj673mhiYrWCaSwI4vBN8JaC1sf1uGWcAP+XJG62G0anJ3i
 vcruy+r8rbifQ2uzLh1sgfdmG+Drw2sSbZsrFzNlrxYXzmrsjxwO+IVuVtamvqISz3VZ
 /VBNsydB6LKGfP1I84PtgpJThXAldTvexupIezoM650GVjaB/sxLHZCV2StVV/1qnZZu
 nJO0YC9kUlUH8KCYC1h/6bRul+4cEZuts1v5GtObW7rfCKUeB/K82EjTjr6ooS1gbJEv
 huzQ==
X-Gm-Message-State: AOJu0YwLaht+GoBEbT3zUQVMZjCOdxmhAnjX4duKfaJJHFtBtNvazyQ4
 M18s6+cJmorPo2gcWIfR7WcpdcTYqNrkI+Ve2pfdil5wTt0tIF/4iypCmd6CEf3LI3JqIL2fStC
 9
X-Gm-Gg: ASbGncueYlWpUDi4mmfAKsco91EZQhdBDOFijqf8efRkKgx6tpIHXFOisHX9h9p5L9W
 nufGqgWh4KshI8Z1CkfTr663VapJij16tuaivEZoSj4iPQqZTpl0bw5LubrVJB/kijE01TYzDPv
 bfssc121b5YnvoPA/flhaYkAvbtX/ztQw9dWkCC7xwVTK1e8reSyTgyXeWdOs408jLetjMfa4OQ
 x1RLIe/q1nh6HDv4UQBLpLsFmynWaaWBr7kcDqTHRlHfOXwGwfStyCelsbBe+z9kTtshvz/Djuh
 E/+ugn5MgCDpe4nWLQORwDOZ4FuN7L+R0TLsXBKFLhR5wGiTRSnLd/Gj6TGNs3o9Iehsfyb2Mpe
 p4IG8j/M5On3j1msZlXav5wKs
X-Google-Smtp-Source: AGHT+IEKRM+FhD1Ucca4TbxYi2jjwLUiasMIXpkB19F4cdRVuiVoRIDblnHtZtj9Vm1gZoe4WdThGQ==
X-Received: by 2002:a05:6000:186e:b0:391:304f:34e7 with SMTP id
 ffacd0b85a97d-39d0de61c1amr174803f8f.44.1743712832023; 
 Thu, 03 Apr 2025 13:40:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b18easm30640115e9.38.2025.04.03.13.40.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:40:31 -0700 (PDT)
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
Subject: [PATCH-for-10.1 v3 0/9] hw/arm: GIC ITS=off ACPI tables fixes
Date: Thu,  3 Apr 2025 22:40:20 +0200
Message-ID: <20250403204029.47958-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since v2:
- Fixed no_tcg_its inverted logic (rth)

Fix ACPI tables for '-M its=off' CLI option.

Regards,

Phil.

Philippe Mathieu-Daudé (9):
  hw/arm/virt: Remove pointless VirtMachineState::tcg_its field
  hw/intc/gicv3_its: Do not check its_class_name() for NULL
  hw/arm/virt: Simplify create_its()
  hw/arm/virt-acpi: Factor its_enabled() helper out
  qtest/bios-tables-test: Add test for -M virt,its=off
  qtest/bios-tables-test: Whitelist aarch64/virt 'its_off' variant blobs
  hw/arm/virt-acpi: Always build IORT table (even with GIC ITS disabled)
  hw/arm/virt-acpi: Do not advertise disabled GIC ITS
  qtest/bios-tables-test: Update aarch64/virt 'its_off' variant blobs

 include/hw/arm/virt.h                     |   1 -
 include/hw/intc/arm_gicv3_its_common.h    |   2 +-
 hw/arm/virt-acpi-build.c                  |  48 +++++++++++++---------
 hw/arm/virt.c                             |  23 ++++-------
 tests/qtest/bios-tables-test.c            |  22 ++++++++++
 tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/FACP.its_off | Bin 0 -> 276 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 212 bytes
 8 files changed, 59 insertions(+), 37 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

-- 
2.47.1


