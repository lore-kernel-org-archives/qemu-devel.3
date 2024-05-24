Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F7EC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAOD9-0002QC-PJ; Fri, 24 May 2024 02:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOCs-0002Ka-NH
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sAOCo-0001J3-C8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:15:10 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f8eba8dcfcso485645b3a.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716531304; x=1717136104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmC8D9o+fAiPYXnVFbz467CphNAhGrEphnV1tOUAsZg=;
 b=jLNi6ldZuJJq3vrvVjIK/lE1nUmYeFHWdP2W1EgGraUGhB7Df4nhnrnu1jsauStOZS
 fcUu6MK00GqWdrdC1VfkFXo/qh+siN5SwE2c+HhfLazzKXnsUt4/1IFyVc0IKa3MSoFh
 r25z9KtcXsoeQTdySlhCxokbG+et/5TwS0v5zql6t5Fy4tNfCG6QBourYbfyct1S0BVp
 GmgbLHZPQPN9nVZVMllg/M/DFLkg/6g2GXckAhMmDPPRXqX4+LX5VZlL+xhrlw6dYsP9
 MkW/LzN7yGOSnvoBhkjTkmxc8pT9U3LUbAecLffP7MYCqShG8bQxJ1Z0i21ApVmijddR
 86nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716531304; x=1717136104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmC8D9o+fAiPYXnVFbz467CphNAhGrEphnV1tOUAsZg=;
 b=ORP0OOl7hzOmFGQ2hYM4/ruYlqCLKn1FLQiVRjEqhlKwGehtHor+HZKt5HjIwh4d3a
 qX+6vEEGTEIQOPJIHPC8ngKCMyFBkHuwjfGwmJInoEAQsm8sS9EBBvVlmBnjPQxjG8wm
 ncDprbDtfcUYKBavmtIa/qfE6tcuEd0j5T2HJM31P3/UX8VHrblqUI0ZHfN0CRpGIaLj
 K7BjvQjHpNsZvm6wINguXcHCkOw5wRwCJPy6+hCmKpo7UskIYzRYIHYL4Idjy9s8F3NT
 DqcOScG2b/UiOOcTYhn9He4czS8ykXpzYKu/+xuLSvU89A4v3YEBDAqBQuTwWX6dEaD3
 5XBw==
X-Gm-Message-State: AOJu0YzvQ78K4btKtK0oJ8MZeBhyXVv0M9Z6j3FPIUCLAy6FJkKsDNJU
 8jvelje1rj2KS8Xm0J2V5qemgzCVOcI3DFMIS5AudpeagEuuu2/UZ5TMOLoRxU+ntCugNVh/Sqg
 o0Gg=
X-Google-Smtp-Source: AGHT+IG6kzfU7kaTy/IAXrfeZEC59WrH3mAsakr6CbyvhT68pgnKE9fEllCE6/tburZHG069vOB0BQ==
X-Received: by 2002:a05:6a00:4c12:b0:6f0:c79f:cd7e with SMTP id
 d2e1a72fcca58-6f8f1960325mr1593406b3a.0.1716531303777; 
 Thu, 23 May 2024 23:15:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcbea487sm516106b3a.107.2024.05.23.23.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:15:03 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Haibo1 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 06/12] tests/data/acpi/virt: Move ACPI tables under aarch64
Date: Fri, 24 May 2024 11:44:05 +0530
Message-Id: <20240524061411.341599-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524061411.341599-1-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x436.google.com
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

Since virt is a common machine name across architectures like ARM64 and
RISC-V, move existing ARM64 ACPI tables under aarch64 folder so that
RISC-V tables can be added under riscv64 folder in future.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/data/acpi/virt/{ => aarch64}/APIC             | Bin
 .../data/acpi/virt/{ => aarch64}/APIC.acpihmatvirt  | Bin
 tests/data/acpi/virt/{ => aarch64}/APIC.topology    | Bin
 tests/data/acpi/virt/{ => aarch64}/DBG2             | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT             | Bin
 .../data/acpi/virt/{ => aarch64}/DSDT.acpihmatvirt  | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT.memhp       | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT.pxb         | Bin
 tests/data/acpi/virt/{ => aarch64}/DSDT.topology    | Bin
 tests/data/acpi/virt/{ => aarch64}/FACP             | Bin
 tests/data/acpi/virt/{ => aarch64}/GTDT             | Bin
 .../data/acpi/virt/{ => aarch64}/HMAT.acpihmatvirt  | Bin
 tests/data/acpi/virt/{ => aarch64}/IORT             | Bin
 tests/data/acpi/virt/{ => aarch64}/MCFG             | Bin
 tests/data/acpi/virt/{ => aarch64}/NFIT.memhp       | Bin
 tests/data/acpi/virt/{ => aarch64}/PPTT             | Bin
 .../data/acpi/virt/{ => aarch64}/PPTT.acpihmatvirt  | Bin
 tests/data/acpi/virt/{ => aarch64}/PPTT.topology    | Bin
 tests/data/acpi/virt/{ => aarch64}/SLIT.memhp       | Bin
 tests/data/acpi/virt/{ => aarch64}/SPCR             | Bin
 .../data/acpi/virt/{ => aarch64}/SRAT.acpihmatvirt  | Bin
 tests/data/acpi/virt/{ => aarch64}/SRAT.memhp       | Bin
 tests/data/acpi/virt/{ => aarch64}/SRAT.numamem     | Bin
 tests/data/acpi/virt/{ => aarch64}/SSDT.memhp       | Bin
 tests/data/acpi/virt/{ => aarch64}/VIOT             | Bin
 25 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/data/acpi/virt/{ => aarch64}/APIC (100%)
 rename tests/data/acpi/virt/{ => aarch64}/APIC.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/APIC.topology (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DBG2 (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.pxb (100%)
 rename tests/data/acpi/virt/{ => aarch64}/DSDT.topology (100%)
 rename tests/data/acpi/virt/{ => aarch64}/FACP (100%)
 rename tests/data/acpi/virt/{ => aarch64}/GTDT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/HMAT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/IORT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/MCFG (100%)
 rename tests/data/acpi/virt/{ => aarch64}/NFIT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/PPTT (100%)
 rename tests/data/acpi/virt/{ => aarch64}/PPTT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/PPTT.topology (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SLIT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SPCR (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SRAT.acpihmatvirt (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SRAT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SRAT.numamem (100%)
 rename tests/data/acpi/virt/{ => aarch64}/SSDT.memhp (100%)
 rename tests/data/acpi/virt/{ => aarch64}/VIOT (100%)

diff --git a/tests/data/acpi/virt/APIC b/tests/data/acpi/virt/aarch64/APIC
similarity index 100%
rename from tests/data/acpi/virt/APIC
rename to tests/data/acpi/virt/aarch64/APIC
diff --git a/tests/data/acpi/virt/APIC.acpihmatvirt b/tests/data/acpi/virt/aarch64/APIC.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/APIC.acpihmatvirt
rename to tests/data/acpi/virt/aarch64/APIC.acpihmatvirt
diff --git a/tests/data/acpi/virt/APIC.topology b/tests/data/acpi/virt/aarch64/APIC.topology
similarity index 100%
rename from tests/data/acpi/virt/APIC.topology
rename to tests/data/acpi/virt/aarch64/APIC.topology
diff --git a/tests/data/acpi/virt/DBG2 b/tests/data/acpi/virt/aarch64/DBG2
similarity index 100%
rename from tests/data/acpi/virt/DBG2
rename to tests/data/acpi/virt/aarch64/DBG2
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/aarch64/DSDT
similarity index 100%
rename from tests/data/acpi/virt/DSDT
rename to tests/data/acpi/virt/aarch64/DSDT
diff --git a/tests/data/acpi/virt/DSDT.acpihmatvirt b/tests/data/acpi/virt/aarch64/DSDT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/DSDT.acpihmatvirt
rename to tests/data/acpi/virt/aarch64/DSDT.acpihmatvirt
diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/aarch64/DSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/DSDT.memhp
rename to tests/data/acpi/virt/aarch64/DSDT.memhp
diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/aarch64/DSDT.pxb
similarity index 100%
rename from tests/data/acpi/virt/DSDT.pxb
rename to tests/data/acpi/virt/aarch64/DSDT.pxb
diff --git a/tests/data/acpi/virt/DSDT.topology b/tests/data/acpi/virt/aarch64/DSDT.topology
similarity index 100%
rename from tests/data/acpi/virt/DSDT.topology
rename to tests/data/acpi/virt/aarch64/DSDT.topology
diff --git a/tests/data/acpi/virt/FACP b/tests/data/acpi/virt/aarch64/FACP
similarity index 100%
rename from tests/data/acpi/virt/FACP
rename to tests/data/acpi/virt/aarch64/FACP
diff --git a/tests/data/acpi/virt/GTDT b/tests/data/acpi/virt/aarch64/GTDT
similarity index 100%
rename from tests/data/acpi/virt/GTDT
rename to tests/data/acpi/virt/aarch64/GTDT
diff --git a/tests/data/acpi/virt/HMAT.acpihmatvirt b/tests/data/acpi/virt/aarch64/HMAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/HMAT.acpihmatvirt
rename to tests/data/acpi/virt/aarch64/HMAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/IORT b/tests/data/acpi/virt/aarch64/IORT
similarity index 100%
rename from tests/data/acpi/virt/IORT
rename to tests/data/acpi/virt/aarch64/IORT
diff --git a/tests/data/acpi/virt/MCFG b/tests/data/acpi/virt/aarch64/MCFG
similarity index 100%
rename from tests/data/acpi/virt/MCFG
rename to tests/data/acpi/virt/aarch64/MCFG
diff --git a/tests/data/acpi/virt/NFIT.memhp b/tests/data/acpi/virt/aarch64/NFIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/NFIT.memhp
rename to tests/data/acpi/virt/aarch64/NFIT.memhp
diff --git a/tests/data/acpi/virt/PPTT b/tests/data/acpi/virt/aarch64/PPTT
similarity index 100%
rename from tests/data/acpi/virt/PPTT
rename to tests/data/acpi/virt/aarch64/PPTT
diff --git a/tests/data/acpi/virt/PPTT.acpihmatvirt b/tests/data/acpi/virt/aarch64/PPTT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/PPTT.acpihmatvirt
rename to tests/data/acpi/virt/aarch64/PPTT.acpihmatvirt
diff --git a/tests/data/acpi/virt/PPTT.topology b/tests/data/acpi/virt/aarch64/PPTT.topology
similarity index 100%
rename from tests/data/acpi/virt/PPTT.topology
rename to tests/data/acpi/virt/aarch64/PPTT.topology
diff --git a/tests/data/acpi/virt/SLIT.memhp b/tests/data/acpi/virt/aarch64/SLIT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SLIT.memhp
rename to tests/data/acpi/virt/aarch64/SLIT.memhp
diff --git a/tests/data/acpi/virt/SPCR b/tests/data/acpi/virt/aarch64/SPCR
similarity index 100%
rename from tests/data/acpi/virt/SPCR
rename to tests/data/acpi/virt/aarch64/SPCR
diff --git a/tests/data/acpi/virt/SRAT.acpihmatvirt b/tests/data/acpi/virt/aarch64/SRAT.acpihmatvirt
similarity index 100%
rename from tests/data/acpi/virt/SRAT.acpihmatvirt
rename to tests/data/acpi/virt/aarch64/SRAT.acpihmatvirt
diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/aarch64/SRAT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SRAT.memhp
rename to tests/data/acpi/virt/aarch64/SRAT.memhp
diff --git a/tests/data/acpi/virt/SRAT.numamem b/tests/data/acpi/virt/aarch64/SRAT.numamem
similarity index 100%
rename from tests/data/acpi/virt/SRAT.numamem
rename to tests/data/acpi/virt/aarch64/SRAT.numamem
diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/aarch64/SSDT.memhp
similarity index 100%
rename from tests/data/acpi/virt/SSDT.memhp
rename to tests/data/acpi/virt/aarch64/SSDT.memhp
diff --git a/tests/data/acpi/virt/VIOT b/tests/data/acpi/virt/aarch64/VIOT
similarity index 100%
rename from tests/data/acpi/virt/VIOT
rename to tests/data/acpi/virt/aarch64/VIOT
-- 
2.40.1


