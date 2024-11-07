Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F92D5D683
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t983R-000424-0u; Thu, 07 Nov 2024 14:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t983P-00041W-CT
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:20:27 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t983N-0006z0-Q9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:20:27 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so4266789a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731007223; x=1731612023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tnmv9SFJw1SUFlGYxGK1BED1KHIqRINi7Fka102FEDM=;
 b=BEOebeUd+Z2af4JO+YPpQaHxxlxLwoXvT2AKgZ0wjfZ5nFQda+npKGjciXUyMlabVV
 T+sHfsEcXQcApBHJrCkOnzaYLu2mFej2T3Yx3LrTFxs3cPq8pH4fSoVQSPHFRBgD47gf
 768xGhebwvP6ieCcbgQtU3FWZWGtuuPjhkMCPeR3ySuBdpTltr1qYA21vOsTluOsZQ8d
 Lu8csYGngML6zKoGbxqo1xh64xbTxVnZT7FY/pSDaC3BBLw0rZ7W+G0PCvEytA/3DDTO
 HjqKDhKlHDay0QcPbyFOmPGgNrcGBkeVfn62iXxZ9d/dYyR66/MN25w4/fYKZVloCkjg
 wfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731007223; x=1731612023;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tnmv9SFJw1SUFlGYxGK1BED1KHIqRINi7Fka102FEDM=;
 b=s7ToGbDLtF9V2fLI2rLGhNBKcNS3/osAfz2fo40R0ViNAU3oxWmJhhYAg9tpWDChnr
 2y9xVTKA93/Aemo2qOHPp7W80Q0EGemz3i9iuxceI9F+ba+gQTWzfzHskY5W3jXF/8ha
 Fn0f15fIyqSi6YD+EVhq8cIYMF8aolkJhDpWDCgFFiIadxnu7KLCVYS2+gZRXiVUVyXo
 L20dlRkrDXgtSzJ+ISbYeJhLwSxdDdPj1lyPdQC/Lh2u3RlMVQALJj7nAqF+2SJLtzIp
 oC+xZ7kf+103oUyTT6BaB2S7O1VIZ/GRSbajzM7gF/h7sDtJuIYiVMoJP7gAbGsCyJFD
 uwiQ==
X-Gm-Message-State: AOJu0YwvAoa3Yyejqu/08TRZlgQ6R4faug/d+50nsxpms9BSugu48wEu
 iWSzJEUffKv71eiwWiEloDfCi10VeX9kPewKmBJzRxRFEF+HoXe/zd1u4A==
X-Google-Smtp-Source: AGHT+IFYJA/crYi2Fjc6QNDW64l8sv4aDwY572GcD22ScduoVgPBFVSfOOctnavgDQO09fkR6djhBQ==
X-Received: by 2002:a17:907:3f86:b0:a9d:e1db:de8b with SMTP id
 a640c23a62f3a-a9eec9cf18bmr74323766b.16.1731007223209; 
 Thu, 07 Nov 2024 11:20:23 -0800 (PST)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4a7d3sm134876366b.70.2024.11.07.11.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 11:20:22 -0800 (PST)
Date: Thu, 07 Nov 2024 19:09:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=3A_Don=27t_try_to?=
 =?US-ASCII?Q?_init_PCI_NICs_if_there_is_no_PCI_bus?=
In-Reply-To: <20241105171813.3031969-1-peter.maydell@linaro.org>
References: <20241105171813.3031969-1-peter.maydell@linaro.org>
Message-ID: <BA0D6E03-7273-4707-8AE3-236FD0AF83AD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 5=2E November 2024 17:18:13 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>The 'isapc' machine type has no PCI bus, but pc_nic_init() still
>calls pci_init_nic_devices() passing it a NULL bus pointer=2E  This
>causes the clang sanitizer to complain:
>
>$ =2E/build/clang/qemu-system-i386 -M isapc
>=2E=2E/=2E=2E/hw/pci/pci=2Ec:1866:39: runtime error: member access within=
 null pointer of type 'PCIBus' (aka 'struct PCIBus')
>SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior =2E=2E/=2E=2E/hw/=
pci/pci=2Ec:1866:39 in
>
>This is because pci_init_nic_devices() does
> &bus->qbus
>which is undefined behaviour on a NULL pointer even though we're not
>actually dereferencing the pointer=2E (We don't actually crash as
>a result, so if you aren't running a sanitizer build then there
>are no user-visible effects=2E)
>
>Make pc_nic_init() avoid trying to initialize PCI NICs on a non-PCI
>system=2E
>
>Cc: qemu-stable@nongnu=2Eorg
>Fixes: 8d39f9ba14d64 ("hw/i386/pc: use qemu_get_nic_info() and pci_init_n=
ic_devices()")
>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>---
>This shows up if you run "make check" on a ubsan build=2E
>---
> hw/i386/pc=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index 2047633e4cf=2E=2E1af1a1a1823 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -1251,7 +1251,9 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_=
bus, PCIBus *pci_bus)
>     }
>=20
>     /* Anything remaining should be a PCI NIC */
>-    pci_init_nic_devices(pci_bus, mc->default_nic);
>+    if (pci_bus) {
>+        pci_init_nic_devices(pci_bus, mc->default_nic);
>+    }

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>=20
>     rom_reset_order_override();
> }

