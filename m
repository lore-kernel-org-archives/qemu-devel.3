Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BFDC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 07:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Jdu-0001kj-9c; Tue, 21 May 2024 03:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s9Jds-0001kJ-MA
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:10:36 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s9Jdr-0008Os-0b
 for qemu-devel@nongnu.org; Tue, 21 May 2024 03:10:36 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e3fa13f018so45139671fa.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 00:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716275431; x=1716880231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DhHkbgwvQImqj/TyXbrJlOs9m84RBlKGQq7hVsOVxw=;
 b=bbjv9iHo6BsxVgR33opSizj+xhunjirEtaIJK3h7E+Q8DvOgRy7dKwGm7+krK9j8Yx
 SoJumGcnpZItYbBz6PS+TpTLEqCj5XCfxGWX3DBYmPHWLgw1JubGzpKCBqpNY2z/6/M6
 86blB0+R6vKI9y9y+Zlt8pisiuHwhjFLk7j75ooN1KpKvT/mBZ/Hv1DbUwtdTRMZq3DL
 cQxYJqsCqyxqwdcOk5W7mXRphF7dHzE0yJxtsSCTDhGG4UF4x9ZvXBw3m7vBKYaefw00
 4cLJ3kX8DDm4VjVt61FxJk5rVNtlDzwXeq0tCaWLXffBwWrhBglwhnkb+ooiPZt6mjer
 b5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716275431; x=1716880231;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DhHkbgwvQImqj/TyXbrJlOs9m84RBlKGQq7hVsOVxw=;
 b=tZ8SPpTjZWme3txjEQDbEiAnqYlD9wKqqisRP8SWjybuYbgsv1mFMlfi8V/1nfUvwq
 NidhWHpD4KvaCzX1GkYN3NMFyV4gfY0vHlMZNXXEm8fGc9U+Z9myu6VDzX7auJmfBlKE
 RO2ABIQy5lRQiuyVuCBefz8lMSZtVZ/l1fcZBgI5zqFdObroTMu9cj1zZzNCdqqpZhd5
 HQ00Yjq+1t3Lw2748ElPOLcdI+8aq3hBe64ar/iASYNAEugjUas3UGDC/d3YQyyM21m3
 TMbmJzPTbsow5ColmJaGcO1XUtAftflazwILm88EzgEtMJ1QIxzekse5rExewXfC8ste
 cx6Q==
X-Gm-Message-State: AOJu0YyEy02B5zLtl+QO3hImWJS5sUdKVlB1x5CYBAjKahLxWD1lczIe
 mnJ8rg+h7Y7U31tUlsyBvCK3LdYcqbaJLAvnF8cIxT4qfpFx+d9WOm3Vcg==
X-Google-Smtp-Source: AGHT+IE4w3s6GnYOZ6Fo2fcHW25l3iqxsBR3EWrQwtfAx15HF06c9AJfFIX++q9ol4iVLJUio1OD/Q==
X-Received: by 2002:ac2:4831:0:b0:51d:38ee:ddda with SMTP id
 2adb3069b0e04-5221057932amr18664697e87.52.1716275430854; 
 Tue, 21 May 2024 00:10:30 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-014-182-088.89.14.pool.telefonica.de.
 [89.14.182.88]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57421480d99sm14294489a12.8.2024.05.21.00.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 00:10:30 -0700 (PDT)
Date: Tue, 21 May 2024 07:10:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_6/6=5D_hw/i386/pc=5Fsysfw=3A_?=
 =?US-ASCII?Q?Alias_rather_than_copy_isa-bios_region?=
In-Reply-To: <20240508175507.22270-7-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
 <20240508175507.22270-7-shentey@gmail.com>
Message-ID: <4A8C51D4-D809-474F-8E6C-DCCEDCBD3857@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x22b.google.com
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



Am 8=2E Mai 2024 17:55:07 UTC schrieb Bernhard Beschow <shentey@gmail=2Eco=
m>:
>In the -bios case the "isa-bios" memory region is an alias to the BIOS ma=
pped
>to the top of the 4G memory boundary=2E Do the same in the -pflash case, =
but only
>for new machine versions for migration compatibility=2E This establishes =
common
>behavior and makes pflash commands work in the "isa-bios" region which so=
me
>real-world legacy bioses rely on=2E
>
>Note that in the sev_enabled() case, the "isa-bios" memory region in the =
-pflash
>case will now also point to encrypted memory, just like it already does i=
n the
>-bios case=2E
>
>When running `info mtree` before and after this commit with
>`qemu-system-x86_64 -S -drive \
>if=3Dpflash,format=3Draw,readonly=3Don,file=3D/usr/share/qemu/bios-256k=
=2Ebin` and running
>`diff -u before=2Emtree after=2Emtree` results in the following changes i=
n the
>memory tree:
>
>   --- before=2Emtree
>   +++ after=2Emtree
>   @@ -71,7 +71,7 @@
>        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>        00000000000c0000-00000000000dffff (prio 1, rom): pc=2Erom
>   -      00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>   +      00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bio=
s @system=2Eflash0 0000000000020000-000000000003ffff
>        00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-regi=
on @pci 00000000000a0000-00000000000bffff
>        00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @p=
ci 00000000000c0000-00000000000c3fff
>        00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @p=
ci 00000000000c4000-00000000000c7fff
>   @@ -108,7 +108,7 @@
>        0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>        00000000000c0000-00000000000dffff (prio 1, rom): pc=2Erom
>   -      00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>   +      00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bio=
s @system=2Eflash0 0000000000020000-000000000003ffff
>        00000000000a0000-00000000000bffff (prio 1, i/o): alias smram-regi=
on @pci 00000000000a0000-00000000000bffff
>        00000000000c0000-00000000000c3fff (prio 1, i/o): alias pam-pci @p=
ci 00000000000c0000-00000000000c3fff
>        00000000000c4000-00000000000c7fff (prio 1, i/o): alias pam-pci @p=
ci 00000000000c4000-00000000000c7fff
>   @@ -131,11 +131,14 @@
>   memory-region: pc=2Eram
>   0000000000000000-0000000007ffffff (prio 0, ram): pc=2Eram
>
>   +memory-region: system=2Eflash0
>   +  00000000fffc0000-00000000ffffffff (prio 0, romd): system=2Eflash0
>   +
>   memory-region: pci
>   0000000000000000-ffffffffffffffff (prio -1, i/o): pci
>        00000000000a0000-00000000000bffff (prio 1, i/o): vga-lowmem
>        00000000000c0000-00000000000dffff (prio 1, rom): pc=2Erom
>   -    00000000000e0000-00000000000fffff (prio 1, rom): isa-bios
>   +    00000000000e0000-00000000000fffff (prio 1, romd): alias isa-bios =
@system=2Eflash0 0000000000020000-000000000003ffff
>
>   memory-region: smram
>        00000000000a0000-00000000000bffff (prio 0, ram): alias smram-low =
@pc=2Eram 00000000000a0000-00000000000bffff
>
>Note that in both cases the "system" memory region contains the entry
>
>  00000000fffc0000-00000000ffffffff (prio 0, romd): system=2Eflash0
>
>but the "system=2Eflash0" memory region only appears standalone when "isa=
-bios" is
>an alias=2E
>
>Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>

Ping

This is the only patch in this series which hasn't got an R-b tag yet (the=
 others are already in master) and I'm not aware of any open issues=2E

Best regards,
Bernhard

