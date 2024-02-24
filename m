Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B36BC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsYb-00049h-9n; Sat, 24 Feb 2024 08:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYV-000488-M9
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:07 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdsYT-0002ji-5Q
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 08:59:07 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4129e8bc6c8so2234575e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 05:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708783141; x=1709387941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x1ZhPUucBt8tj+BiCJh7QcDke4xVu6ZuPC0kVaaXLwQ=;
 b=K6lA0bNlHu4LFghlu27hTTAormIJKJMt5Ab0b0q/N+ka7+XJc6ESt7B6m4K6Cwa82J
 OUEWMPtDfc7nSoAfA1Ol+s4PVhJ+R9cRebBDc7PWLWTTEjwrscs0FNBqicCJCdFqPXq0
 JRTjtF+QLZ/B3FJ7XuKBvEOtUDk2ihB1wohtonE9nfmeRlNE9+UrWlTaFrI53cK4Rb8d
 lFg4iqltwz8r+bE0wjjObDvsY4+e5gXEnHO/SC534rQMQ/w0RDFmdROcm0WK/mk1+tP0
 cOJInWlGvXM4cV1m1njGfa0fN0ds5d6WyOcoSHaML000ZlXDmAWZ/6q7gEC7rpf8h2I/
 Qqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708783141; x=1709387941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1ZhPUucBt8tj+BiCJh7QcDke4xVu6ZuPC0kVaaXLwQ=;
 b=X9PkzAb/gjcQvBuT6Onvx7sSPdUs7/Z1AshTrWkcFyMi520jxm5OA3phC1lEhk3FmG
 nywGaULKuLQuz0fN/YVYSAe/xm3yiUmr/AOf8L+OQXcROawARScmJMuC9ZBwqGeClrvI
 lsDfBoW/xHPOaXgVQSZpJLIDNJwxfUXtprv2rqFQjyY1F0h5LWFpDG34YhKB31AHi6vP
 y+wNSPM63doqSb/jUr0psurgxZOmxWWmfeF72a+EkBgET7/nkKULQvQF5FIVDUEeoSxP
 XDE62N4ROJFG3DqJr9ca1gvbxiOAdiRhcNxb7GiPhP2b1zI24aSDVNVdWpob8hYqDKGs
 36KQ==
X-Gm-Message-State: AOJu0Yzpzvndr5P1rwWo2flqFcFw3JgbTPAwAst3P3BSTZcWVHb4QVDE
 YXvBt0/K8jizPyYQfCXDW4G3UebT8uStUtZvNfHq+Pm6kk1oCosl3Nbf/XXU
X-Google-Smtp-Source: AGHT+IHEmhFSOhZGIrJNhqRwkUOVhcCTOBgw4zIQ6P85IZ4VX+rZysi9QaV5qbFEdfA/8ADsfFrYhg==
X-Received: by 2002:adf:f884:0:b0:33d:bb3f:e2b5 with SMTP id
 u4-20020adff884000000b0033dbb3fe2b5mr1002323wrp.40.1708783140857; 
 Sat, 24 Feb 2024 05:59:00 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 n8-20020a056000170800b0033d817eddd3sm2285542wrc.13.2024.02.24.05.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Feb 2024 05:59:00 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/6] Simplify initialization of PC machines
Date: Sat, 24 Feb 2024 14:58:45 +0100
Message-ID: <20240224135851.100361-1-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The series aims to simplify the initialization process of all PC-based mach=
ines=0D
by streamlining redundant code.=0D
=0D
Since I haven't seen patches on the list so far for folding CMOS data=0D
generation into pc.c, which frees all PC machines from performing this duty=
=0D
explicitly, I've appended this cleanup as the last two patches.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
* I'm sending this series from within a VM containing these changes.=0D
=0D
v2:=0D
* Rebase onto master, leaving only patches 1, 3, and 5=0D
* Patch 2: Rename "bus" attribute to "pcibus" (Phil)=0D
* Patch 4: Spotted while rebasing=0D
* Patch 6: New patch possible after [1]=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
[1]=0D
https://patchew.org/QEMU/20240221211626.48190-1-philmd@linaro.org/202402212=
11626=0D
.48190-10-philmd@linaro.org/=0D
=0D
Bernhard Beschow (6):=0D
  hw/i386/x86: Let ioapic_init_gsi() take parent as pointer=0D
  hw/i386/pc: Rename "bus" attribute to "pcibus"=0D
  hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables=0D
  hw/i386/pc: Remove unneeded class attribute "kvmclock_enabled"=0D
  hw/i386/pc: Populate RTC attribute directly=0D
  hw/i386/pc: Inline pc_cmos_init() into pc_cmos_init_late() and remove=0D
    it=0D
=0D
 include/hw/i386/pc.h     |  5 +----=0D
 include/hw/i386/x86.h    |  2 +-=0D
 hw/i386/acpi-build.c     |  2 +-=0D
 hw/i386/amd_iommu.c      |  2 +-=0D
 hw/i386/intel_iommu.c    |  2 +-=0D
 hw/i386/kvm/xen_evtchn.c |  2 +-=0D
 hw/i386/microvm.c        |  2 +-=0D
 hw/i386/pc.c             | 27 ++++----------------------=0D
 hw/i386/pc_piix.c        | 42 +++++++++++++++++-----------------------=0D
 hw/i386/pc_q35.c         | 25 ++++++++++--------------=0D
 hw/i386/x86-iommu.c      |  2 +-=0D
 hw/i386/x86.c            |  7 +++----=0D
 12 files changed, 43 insertions(+), 77 deletions(-)=0D
=0D
-- =0D
2.44.0=0D
=0D

