Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A04C48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 14:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdsoJ-0005g4-Ew; Sat, 24 Feb 2024 09:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdso7-0005W7-NX
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:15:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rdso4-0005hS-Ty
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 09:15:14 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41276a43dc3so12881075e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708784110; x=1709388910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QL98g+jdA4UYeVSxM1zfb4G5x62Ew6jGfwQjKPaZXhw=;
 b=nrOtHKRp/0aqW3riu4Wjmjs7DhFPurgoLIdBl8++5yWgmXaOsye2s/cTwdWTUaYwpi
 Gl4sA5eXKt36zaTqhopyvzVKQmEO+QE85D+V+TkKxxw6ED3D1EPYCA7wuSt1NTGKoUwd
 0ywCp0llxD2KJIO6Zkjaggjz83+J11/O5AwmIr6bhGwkBLdQUkoEHYVn5TLOO47VcXxY
 WoA7h9WGWhXOmzsppUjMREJeSqVDd+96xXOWMpKFs5Ich5dRXdr4ONqP1MYEe7+wuwaG
 0plr2Y7KtXiM7qxAO6a8U3tC2dPl9V7wIUlrDSBBR1jeBHn9w8XcgL18Ap+SJBqdYs5s
 xArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708784110; x=1709388910;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QL98g+jdA4UYeVSxM1zfb4G5x62Ew6jGfwQjKPaZXhw=;
 b=PFWomHnN7Vk1cEBu44oka14AXfVyV9gZTLzkr7phfg4jj7cHoqu+4S4CzXQWaJoP/e
 ydUzIb3RhJJiKkZi2uy8SN9EDUSfHed+kPHkzg16BpCAhCxJQddbfwI2ZrNvdIGL9EIz
 rN99l7O8hY8CwMEbM4KPbSPYCGg/oDAuT0N753S0Xq4TSF7wsPEiF2XLtgaO+ifbXbBR
 EDUX+W7sRxoE3iz26AOr32yApvQhzQiI+/BqLX4ICPslK0s6kUw6vxuIG3r3zTQgw7Wn
 MbCXUn6CTDqqmxSfL8+Kg9uo5r/NP8R/OVSYlC+Ybf4xZbfnTe5kRj34YuYQNO3TQD7t
 8ctA==
X-Gm-Message-State: AOJu0YxV7TVssGsJAejeOIAuws5nyjtXXa8JRGMEn6haXiStk6CEOcLO
 ttKq7noc1CnZuwYwZz8SX6X9bkQIr5aj3nrJfIQ/jIthqbmXpHfR1X7V6DVQ
X-Google-Smtp-Source: AGHT+IGYonOIe2x6Ez6PHg3DV9XJVlc4fmxH6lZOr7Z9TV9RH2neVp9gRz98JPj4+sNB3RhTZiiNzA==
X-Received: by 2002:a05:600c:3588:b0:40e:a569:3555 with SMTP id
 p8-20020a05600c358800b0040ea5693555mr2218026wmq.35.1708784110252; 
 Sat, 24 Feb 2024 06:15:10 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-138-060.89.12.pool.telefonica.de.
 [89.12.138.60]) by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c350c00b0041285ffec13sm2395968wmq.41.2024.02.24.06.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 06:15:09 -0800 (PST)
Date: Sat, 24 Feb 2024 14:15:08 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 0/6] Simplify initialization of PC machines
In-Reply-To: <20240224135851.100361-1-shentey@gmail.com>
References: <20240224135851.100361-1-shentey@gmail.com>
Message-ID: <B737FEF4-744F-4B91-8F31-08A6818F8612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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



Am 24=2E Februar 2024 13:58:45 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>The series aims to simplify the initialization process of all PC-based ma=
chines
>
>by streamlining redundant code=2E
>
>
>
>Since I haven't seen patches on the list so far for folding CMOS data
>
>generation into pc=2Ec, which frees all PC machines from performing this =
duty
>
>explicitly, I've appended this cleanup as the last two patches=2E
>
>
>
>Testing done:
>
>* `make check`
>

The `boot-order-test` actually fails=2E We'd have to ignore the last patch=
 for now=2E

Best regards,
Bernhard

>* `make check-avocado`
>
>* I'm sending this series from within a VM containing these changes=2E
>
>
>
>v2:
>
>* Rebase onto master, leaving only patches 1, 3, and 5
>
>* Patch 2: Rename "bus" attribute to "pcibus" (Phil)
>
>* Patch 4: Spotted while rebasing
>
>* Patch 6: New patch possible after [1]
>
>
>
>Best regards,
>
>Bernhard
>
>
>
>[1]
>
>https://patchew=2Eorg/QEMU/20240221211626=2E48190-1-philmd@linaro=2Eorg/2=
0240221211626
>
>=2E48190-10-philmd@linaro=2Eorg/
>
>
>
>Bernhard Beschow (6):
>
>  hw/i386/x86: Let ioapic_init_gsi() take parent as pointer
>
>  hw/i386/pc: Rename "bus" attribute to "pcibus"
>
>  hw/i386/pc_{piix,q35}: Eliminate local pci_bus/pci_host variables
>
>  hw/i386/pc: Remove unneeded class attribute "kvmclock_enabled"
>
>  hw/i386/pc: Populate RTC attribute directly
>
>  hw/i386/pc: Inline pc_cmos_init() into pc_cmos_init_late() and remove
>
>    it
>
>
>
> include/hw/i386/pc=2Eh     |  5 +----
>
> include/hw/i386/x86=2Eh    |  2 +-
>
> hw/i386/acpi-build=2Ec     |  2 +-
>
> hw/i386/amd_iommu=2Ec      |  2 +-
>
> hw/i386/intel_iommu=2Ec    |  2 +-
>
> hw/i386/kvm/xen_evtchn=2Ec |  2 +-
>
> hw/i386/microvm=2Ec        |  2 +-
>
> hw/i386/pc=2Ec             | 27 ++++----------------------
>
> hw/i386/pc_piix=2Ec        | 42 +++++++++++++++++-----------------------=

>
> hw/i386/pc_q35=2Ec         | 25 ++++++++++--------------
>
> hw/i386/x86-iommu=2Ec      |  2 +-
>
> hw/i386/x86=2Ec            |  7 +++----
>
> 12 files changed, 43 insertions(+), 77 deletions(-)
>
>
>
>-- >
>2=2E44=2E0
>
>
>

