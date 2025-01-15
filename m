Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B507C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uW-0007L2-Gq; Wed, 15 Jan 2025 12:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uG-0007Bx-T1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:18 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uD-0006V9-Cg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:15 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436249df846so48727195e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961011; x=1737565811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mucUZndHbSnQ/NqiIKIUnUVH/0ghWJZPNVfuuMeVrDw=;
 b=oO03FN0Nmg/DTf9vdeUo4bmZc1hFUWGPlCo0rdGef28WvfEoWdMAP/x45U2a4UMvj9
 Vd497WSnMR/miQtptIks8zFaPRUMNxOUcvOQIiJ47F35Yb+tE1X7/qYD5bdQYt0xBis7
 qhI4aN6SpxIcbXHYXlEvSRN8rzEP8oGl81WhFt9bSHpI4i9KQ82+5+NNXobRrbYiMzgx
 TZQXiAbwNyIyJjYogzpXeO70tYci6mNOve7COZJPTaCmSUBEvrDEVN4X2wrS5RilfWvw
 0pI9rEvFVZhclbTlhrRra4sIP8IJG7vDeP4gH0dmC5DjGT/SSSY8/gGU5f1w9QUXNXeu
 1Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961011; x=1737565811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mucUZndHbSnQ/NqiIKIUnUVH/0ghWJZPNVfuuMeVrDw=;
 b=eaIqOtRzpHR/qwl1bQ9vzM9xN1GhlG/AC2XLVnWoE9fPMnHm9bQA8GZH+/WFKSxQj9
 o3QPNQb94xrNciv2Rlrx/xXEs6C0xyNIiGBkkuJIL59uCNkOq/J6GtaZnA/vIrSESsro
 RkH5IejzsftVubDj4oDNVZxfTZppYooJ9eoWWVztz0dnYJjaZSnmC0lxXqd8UydZOk2l
 GheeHmzVT40G5g/GOcy/YxcAst90qXojBRSqXlY63rQeSYgu9cgAZGiHJtJt004ak4Lx
 Qki/xMIo9ziJKb+fTXidO6Nz0DifyVMayozmJ7je9cZx/dlVKZMPHX58MUE2IsCQ/sVj
 fMGA==
X-Gm-Message-State: AOJu0Yyi3A/EPRlw383IAoCBLSx7hZ4JeTtrH5xMtFRABSnGr+MT1N+Q
 i2z2c0QVprbuQ4mlzdiKare3AK5urN4i4xjL0bhuorle6hGvShwtmAQfEne+JvFr6ghiivWb7ME
 W60w=
X-Gm-Gg: ASbGncvem0ufXtckZiIeE3gx+nsvo2mD5RR1LDltuu2V61ebV8q5XBABYXfvbxQlenD
 TWOC/fNfaJHNa/UTTZbHXuc6pq6WzfSrWMq8xz+MCDxDvN5e/r2XqbodPNTCHlHKj824aaWo715
 n1nBDNCvRGUrmVZBGTuCSn3IfgdC4u6HynJeWhtz1fUoeUOnN+UJZuk2N9WiEt9fHbMqIvs1doS
 Lho3zkIYtbvGubHvFFgxWnIhFeqEY4JDVHc/rLZeGYvJr4CrbZO8nltitddiPEMOxpjPVlkwQ/O
 iBHXGv2FOJG2Uu/ef1pNfyYLyhhWhrW6B6Co
X-Google-Smtp-Source: AGHT+IHVBHgS0HEnaIBo9mwYOPQzmhF5qaZQt4YPB2ckq5syKJHaI+iD9xmr5qA7dq0kimYBHaLyJQ==
X-Received: by 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-436e2699dfbmr308360395e9.14.1736961011248; 
 Wed, 15 Jan 2025 09:10:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499878sm30894735e9.6.2025.01.15.09.10.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/13] hw/arm: Remove virt-2.6 up to virt-2.12 machines
Date: Wed, 15 Jan 2025 18:09:56 +0100
Message-ID: <20250115171009.19302-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

The versioned 'virt' machines up to 2.12 been marked as deprecated
two releases ago, and are older than 6 years, so according to our
support policy we can remove them. Remove associated dead code.

Philippe Mathieu-Daudé (13):
  hw/arm/virt: Remove deprecated virt-2.6 machine
  hw/arm/virt: Remove VirtMachineClass::no_pmu field
  hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
  hw/arm/virt: Remove deprecated virt-2.7 machine
  hw/arm/virt: Remove VirtMachineClass::no_its field
  hw/arm/virt: Remove deprecated virt-2.8 machine
  hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
    field
  hw/arm/virt: Remove deprecated virt-2.9 machine
  hw/arm/virt: Remove deprecated virt-2.10 machine
  hw/arm/virt: Remove deprecated virt-2.11 machine
  hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
  hw/arm/virt: Remove deprecated virt-2.12 machine
  hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field

 docs/about/removed-features.rst    |   4 +
 include/hw/arm/virt.h              |   6 --
 include/hw/intc/arm_gic.h          |   1 -
 include/hw/intc/arm_gicv3_common.h |   3 -
 hw/arm/virt-acpi-build.c           |  10 +--
 hw/arm/virt.c                      | 122 ++---------------------------
 6 files changed, 15 insertions(+), 131 deletions(-)

-- 
2.47.1


