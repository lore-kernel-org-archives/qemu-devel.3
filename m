Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C903C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 19:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVbgL-0003Dv-5y; Sat, 28 Jun 2025 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgI-0003De-6X
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:46 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uVbgG-0000Hq-3U
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 15:57:45 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7d20f799fe9so358479585a.2
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751140662; x=1751745462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ptTNUf3MqV0dY0n+f5mCHE1pEKvGfWfAJOT7fbj05o=;
 b=FDr6FCQfYCH+luioQuesM+wQo4kVaFOGVnBGOUGvpAhSBfeMgWwzHenbSQNaSuwpil
 1sbL/akyI26a7u4DiEYAs5K9rVdKf0jJ5jxRwFT9ZtDMVTcoX+OUQd0A798cdmrfvCKv
 gp9yRbcotL59js8Und9Z5wH09GMSHM/p2woDAaxsGD+PTVzG5YJSn8dxhxrw/KxpPWV4
 N2VESkD1HLQlI0urWPyYSrQH7awxwpZ9FnnDMjyPfPNFF759XAZ3O9nc+AQbbAdpfgP5
 gvqpGr88mvFzz/LR/in+N44tLNHF7cEgeYAL4o+BNuygZejzeQE6ol37LoQac0X+uVkl
 OLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751140662; x=1751745462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ptTNUf3MqV0dY0n+f5mCHE1pEKvGfWfAJOT7fbj05o=;
 b=NZGLJgXDl8jk4E9Qd5HA8VapmhHCDs7a3fCumJlRZeOdQsUMBGqTVnyYOUmCNZjsCW
 Y/5nTet7OpIwwV0u2j1FI22WPAsEIBTZiYkQDakbYp9b9Ejy76bzQ6aP//doB08haeSk
 D6xvdbq6O+eTA7n144Y1h5qp0dndJlVsDum2uSWMADS+OmCyQMpepnRR1yHVxWIU8gfR
 +wjFCrmmVYikkeHatQw8VUUk15z8waUWiU6yns+7nXw8c8Y/5Uu1y6Uxw9qjvxtNsaM6
 tsKf/rXFw4RhPq0mCmb4vPsR29jIVBTPKfdh8Iw21R0ot2ehswCpa4IijBpLXSypR5df
 5Iew==
X-Gm-Message-State: AOJu0YyToDTAL3THVq5EDnfNwzIcxEhAvFnRIjuQa7kqYAQr+WPH6h2q
 rpcsBPxrsTkvH09FoqeO5fjStSD4C18qv6VXMsZxFmbv9KsFpMbVZGbvU0pk84UeZzbncDnxQOO
 1nHE9
X-Gm-Gg: ASbGnctcbWdOOEDOf6xL/p+zJstXqzc4RkStcFuQvPSIcW0uxAgw6RqJlupqMlIRbqM
 ztiwH6WwHYpXcz8+Tv+ZX9XjnXuFQLQkf8KREF59e5d7Dmm7uUgrqD/W7XVKz8F1r1YXlAw2qCX
 ai7BoeYdUGYMam0jTsm345gkRFa4BwQQ3Kr6IDaDEZJ+h+rOgEW5zGukCfn6LxZf4aJzLAUk72z
 x08O34ZqrshX5VfD+v6FS2Qc4kmZB7pNG//MBIc2kIa9Lgnu1p7MPPYNwtk7mZgcmGHJu+0Mu3Q
 pmNSsiQv/YC/V2klZrYhNtooc5Eq9Cgupui0AtEngF/+eX55tmQx7unEEjJLFFnGNiGr47X8DU0
 69A==
X-Google-Smtp-Source: AGHT+IGQX2xxBYGsEtonccz56QYgD19pU7I6oPxcweH7n31jdk4R9NOrLlWkDh7zMvsJ7ibe7k+wPw==
X-Received: by 2002:a05:620a:1a89:b0:7d3:db44:86c3 with SMTP id
 af79cd13be357-7d4439a6fe6mr1492007985a.54.1751140662573; 
 Sat, 28 Jun 2025 12:57:42 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d443136907sm334395585a.14.2025.06.28.12.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 12:57:42 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, eric.auger@redhat.com, philmd@linaro.org,
 mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org,
 udo@hypervisor.org, ajones@ventanamicro.com, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off' ACPI table fixes
Date: Sat, 28 Jun 2025 19:57:13 +0000
Message-Id: <20250628195722.977078-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qk1-x72a.google.com
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

Since v2:
- Fixed no_tcg_its inverted logic (rth)

Since v3:
- Fixed remappings in the IORT table when ITS is no present
- Rebased on master and resoled conflics, like no more "no_its"
  flag in VirtMachineClass
- Dropped patch 1/9 because we actually want the instance flags,
  not only the class flags, and the instance flags are the ones
  to be used often when deciding about the presence/absence of a
  machine feature, instead of the negated class flags ("no_*")
- Adapted the other patches that depended on 1/9
- Dropped patch 4/9 in favor of using the instance flag for
  checking if ITS is on or off
- Simplified VM options for the new "its=off" test

Since v4:
- Fixed/restored commit authorship and author tags (philmd)
- Factored out create_its_idmaps to clarify how ID ranges that
  go direct to ITS Group node are created (eauger)
- Addressed all remaining minor review comments (eauger)

Since v5:
- Use of "directed to" in comments and commit messages (eauger)
- Renaming of variables num_id_mappings, smmu_idmaps, and its_idmaps
  to make code clearer (eauger) 

v1: https://lists.gnu.org/archive/html/qemu-devel/2025-03/msg07080.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00495.html (Patches 6/14 -> 14/14 in the series)
v3: https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg00567.html
v4: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg02583.html
v5: https://mail.gnu.org/archive/html/qemu-devel/2025-06/msg03793.html

Fix ACPI tables for '-M its=off' CLI option and resolve the issue:

https://gitlab.com/qemu-project/qemu/-/issues/2886


Cheers,
Gustavo

Gustavo Romero (6):
  hw/arm/virt: Simplify logic for setting instance's 'tcg_its' variable
  hw/arm/virt-acpi-build: Improve comment in build_iort
  hw/arm/virt-acpi-build: Factor out create_its_idmaps
  qtest/bios-tables-test: Add blobs for its=off test on aarch64
  hw/arm/virt-acpi-build: Fix ACPI IORT and MADT tables when its=off
  qtest/bios-tables-test: Update blobs for its=off test on aarch64

Philippe Mathieu-Daudé (3):
  hw/intc/gicv3_its: Do not check its_class_name()
  hw/arm/virt: Simplify create_its()
  qtest/bios-tables-test: Add test for when ITS is off on aarch64

 hw/arm/virt-acpi-build.c                  | 190 ++++++++++++++--------
 hw/arm/virt.c                             |  25 +--
 include/hw/intc/arm_gicv3_its_common.h    |   2 +-
 tests/data/acpi/aarch64/virt/APIC.its_off | Bin 0 -> 164 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off | Bin 0 -> 172 bytes
 tests/qtest/bios-tables-test.c            |  21 +++
 6 files changed, 157 insertions(+), 81 deletions(-)
 create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
 create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off

-- 
2.34.1


