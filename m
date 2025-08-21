Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398A5CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7Mm-0005Y9-Nb; Thu, 21 Aug 2025 11:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1up7Mj-0005Xe-Uj; Thu, 21 Aug 2025 11:38:14 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1up7Mh-0006XG-FB; Thu, 21 Aug 2025 11:38:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e1ff326bbso1746725b3a.1; 
 Thu, 21 Aug 2025 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755790688; x=1756395488; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=nFz56e8utBP595P1f8WNuvE3xc+Fv/jEZxgUDV6xr2g=;
 b=mqqQcdpVgFrSA8lW6WGcvugixbztcc7E3bo2ZOPOXGPZ5Czk0OOrrVOUIf1yr4WdpG
 4H1I2ffyQHNS6fKgJLhV1h+0soZpPpl97DDHdCWU9LHljmYRZ5rLFfODqZg8RpeD3zkb
 VfIUZdH/GMHewdl3V2K/f9GgZKes69K8UbeAHA6rlOUUwa9zxlH4H6M1trZ+s3nweX7x
 McFpiTe+W3kUS87gQ1mjISVOibpaQ/MrM5rU1p3kcU9UlGvtOt3Rilb3GTovFyOfo9yX
 SyprpQm2SoEoCkrSwvuIH3FssO5TQOYPc9jCTA+CGFyKO4gs+FLKwX5lJCvywMlW58U/
 4HMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755790688; x=1756395488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFz56e8utBP595P1f8WNuvE3xc+Fv/jEZxgUDV6xr2g=;
 b=YM8m1LTIBRIEMH9v36k0tfju5aYh/GiEUEopxrzbkAyDMYBfGcBQmg89VEDKk3chXP
 nNGc79jcvM66wcbVK4TGTHXmBB/4tBR1tKy8uQ6FpQuZVl6a9uStAcx2JJTgICtDY6aK
 WqOBDLS0WVLQpJ5NDDQhkAklqgkDaGcyYvlXDqrmpcUbLLKtMwHJW6Z/UssT/+Nn32D+
 F/31LFlnGMIr2cxj5zcmpAIILHskwo18155EbtvgFk9D1QI/vCZKnV9iIbJWGgkk3mkL
 u96NLjMWT/cGOOs/9mr+hPe4hgX/pb7I1YlJgzL9Fn97ZXQ/2v4nqawlMjxFr29AAIEX
 +8Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmKQMLvdLMC/hCISjTCCPhTupwDJPDsBid5XuikxqFcnHX26cAMFzcg1ObeSbfpUnaIWbrLSIehg==@nongnu.org
X-Gm-Message-State: AOJu0Yz/M9kJnO/8+6pQ1YQRuC6V+2zu3P0ifaPli3ZG5uZcSMvXByyh
 bOHy4/7fvpdiT7zDAPDQH5HO6oG9u/Knlon3h0ZgWELKBNcZssVZc970
X-Gm-Gg: ASbGncskjyq+ngu6A0LAJtpMfATW7ZlqfbaSZXDcXmVNavay4e4O4vLFHjU9Us2XbNs
 8uOCtGYG7u62naVyHBe40MkjUTu6rz5V6yAYFXBfaKFU1MaJdXg3g0nugN/Bvb4uwrxvusGn3vz
 lozxhKUK4Nb0406St+jdd1TqU+UNtd4u6teMEyuCBx4o8zgPKkBONvt2Lyo1Vrjr1UWacwK5yd1
 LA1SMlPjvlzp6lJYjy4/pmZ87pgsA76AvfuIh2Lp8p/UP6PJbsvyvC7i5d9y33GYVVu2kHTRKHW
 HORytgn4ZsSg7QKXalVh0Gcbi0rCojt8uzxlngrzx3IecUQ74JCeH6aPp3qUUNyxrpmwE+78IZ2
 WUPCAYvAG1HquX4imG4vf+nv6j89FKsSkUakkUu7H6g1gKQ==
X-Google-Smtp-Source: AGHT+IF4PgyBFTDizi0d/oULfVTONEhqwLlffcQs02/Xv0cHYuQ/wdVrDuVdoX+bTWLvIa9hlQPW3g==
X-Received: by 2002:a05:6a20:6d17:b0:23f:f729:2e72 with SMTP id
 adf61e73a8af0-243306582c7mr2726989637.1.1755790687733; 
 Thu, 21 Aug 2025 08:38:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4764003537sm5115122a12.25.2025.08.21.08.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:38:07 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:38:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/10] Designware PCIe host fixes
Message-ID: <4968ffcd-20bf-4ad3-84d4-043e74b4e0b6@roeck-us.net>
References: <20250820211932.27302-1-shentey@gmail.com>
 <7804e625-2421-473f-9320-89fa0cc0d085@roeck-us.net>
 <D1762D97-2253-4503-9BD9-E4BF6BED1EAE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1762D97-2253-4503-9BD9-E4BF6BED1EAE@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.058, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 21, 2025 at 10:24:02AM +0000, Bernhard Beschow wrote:
> 
> 
> Am 21. August 2025 03:36:44 UTC schrieb Guenter Roeck <linux@roeck-us.net>:
> >On 8/20/25 14:19, Bernhard Beschow wrote:
> >> This series fixes the Designware PCIe host to work with cards other than
> >> virio-net-pci, e.g. e1000. It was tested on the imx8mp-evk machine.
> >> 
> >> The series is structured as follows: The first part refactors the device
> >> model to create memory regions for inbound/outbound PCI mappings on demand
> >> rather than upfront since this approach doesn't scale for adding I/O space
> >> support. The second part consists of fixing the memory mapping by adding I/O
> >> space support and fixing default inbound viewport mapping. The third part
> >> concludes the series by implementing device reset and cleaning up the imx8mp SoC
> >> implementation.
> >> 
> >> Testing done:
> >> * Boot imx8mp-evk machine with Buildroot while having an e1000 card attached.
> >> Observe that it gets an IP address via DHCP and allows for downloading an HTML
> >> file via HTTP.
> >> 
> >Crashing for me even if no PCIe card is attached. This is with the series applied
> >on top of 10.1.0-rc4 or 10.0.3. I have not tried to track down the problem.
> >
> >Guenter
> 
> Hi Guenther,
> 
> Thanks for testing this series! I can reproduce the issue with Buildroot while the functional test passes...
> 
> I guess that I was too optimistic in having resolved the issue mentioned in the last patch. Does it work for you if you omit it?
> 
I'll give it another try tonight.

Guenter

> Thanks,
> Bernhard
> 
> >
> >---
> >Build reference: v6.17-rc1-287-g685de850cabf
> >Compiler version: aarch64-linux-gcc (GCC) 13.4.0
> >Qemu version: 10.0.94 (v10.1.0-rc4-55-g320ed12bd9)
> >
> >[    7.748393] Internal error: synchronous external abort: 0000000096000010 [#1]  SMP
> >[    7.748917] Modules linked in:
> >[    7.749533] CPU: 3 UID: 0 PID: 12 Comm: kworker/u16:0 Tainted: G   M             N  6.17.0-rc2-g685de850cabf #1 PREEMPT
> >[    7.749689] Tainted: [M]=MACHINE_CHECK, [N]=TEST
> >[    7.749745] Hardware name: NXP i.MX8MPlus EVK board (DT)
> >[    7.750118]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> >[    7.749922] Workqueue: async async_run_entry_fn
> >[    7.751174] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >[    7.751267] pc : pci_generic_config_read+0x38/0xb8
> >[    7.751370] lr : pci_generic_config_read+0x24/0xb8
> >[    7.751474] sp : ffff8000845fb730
> >[    7.751532] x29: ffff8000845fb730 x28: 00000000000000ff x27: 0000000000000000
> >[    7.751686] x26: 0000000000000001 x25: ffff80008290c008 x24: ffff8000832cbe80
> >[    7.751770] x23: 0000000000000000 x22: ffff8000845fb844 x21: ffff000008a73800
> >[    7.751859] x20: ffff8000845fb7a4 x19: 0000000000000004 x18: 00000000ffffffff
> >[    7.751942] x17: ffff800080e2f918 x16: ffff800080e2f7ac x15: ffff800080e2e6d8
> >[    7.752027] x14: 0000000000000000 x13: 0000000000000000 x12: ffff80008427cab8
> >[    7.752120] x11: 0000000000000326 x10: 0000000000000326 x9 : 00000000000c0326
> >[    7.752225] x8 : 000000006973b6c5 x7 : ffff800085c00000 x6 : 0000000000000000
> >[    7.752320] x5 : ffff000007cc5080 x4 : 0000000000000000 x3 : 0000000000000000
> >[    7.752403] x2 : 0000000000000000 x1 : ffff000004bf5680 x0 : ffff800085900000
> >[    7.752577] Call trace:
> >[    7.752694]  pci_generic_config_read+0x38/0xb8 (P)
> >[    7.752794]  dw_pcie_rd_other_conf+0x38/0xb0
> >[    7.752851]  pci_bus_read_config_dword+0x80/0xe4
> >[    7.752903]  pci_bus_generic_read_dev_vendor_id+0x30/0x190
> >[    7.752964]  pci_scan_device+0xdc/0x184
> >[    7.753010]  pci_scan_slot+0xe0/0x23c
> >[    7.753056]  pci_scan_child_bus_extend+0x44/0x2cc
> >[    7.753110]  pci_scan_bridge_extend+0x514/0x598
> >[    7.753166]  pci_scan_child_bus_extend+0x104/0x2cc
> >[    7.753220]  pci_scan_root_bus_bridge+0x64/0xd8
> >[    7.753273]  pci_host_probe+0x34/0x10c
> >[    7.753328]  dw_pcie_host_init+0x2f0/0x4b0
> >[    7.753376]  imx_pcie_probe+0x33c/0x70c
> >[    7.753439]  platform_probe+0x5c/0x9c
> >[    7.753485]  really_probe+0xc0/0x390
> >[    7.753530]  __driver_probe_device+0x7c/0x15c
> >[    7.753581]  driver_probe_device+0x3c/0x110
> >[    7.753633]  __device_attach_driver+0xbc/0x158
> >

