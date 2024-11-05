Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F73D40D08
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8TJh-0005oX-8O; Tue, 05 Nov 2024 18:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TJf-0005nR-Oo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:50:31 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8TJb-0000tA-LL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:50:30 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-513de4267d8so225428e0c.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730850626; x=1731455426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Lq1FhnDsaKYdsDXablbEjgdqiBWfyrgkvJK8xe8rMM=;
 b=ArPdJTW8ZQUDDhQb/4vZIXTmIillmKB19nUO+eZnRYL2RvdGK5hPmLqO0WkdqYQfa0
 MDsm16KoCtaaztUsji3dUqJ5qZm/z/QN0sJ5G6HCB1AzYbfzfQ5FnnNLbM+N8E5to/3F
 t8C3zaKoJFAagelYBMl3ER0E/WaQ5PmKqYLbYvq97exYZ/hZJL/8fznhspO5UFsi+XcH
 SE6xyrc+vWk+ZvP3UzUDwlOgX2OdJyV9f7IBqgRrsZKRjLYer7hFf7s72bDCvuJKplfd
 2bSG/qUYMKECQhpP4AtZ639PmmOsGOyO/gujQriYnCvP+2z1wDVp2xRrCRmab65PLY1O
 OVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730850626; x=1731455426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Lq1FhnDsaKYdsDXablbEjgdqiBWfyrgkvJK8xe8rMM=;
 b=OGWZQaz799HOwL+x7kTeH6h02FcVNW0dT+uXEv3ax4/AHXwQ5X5nMagp5nZOHZiDch
 k5EEl7YHbLVpeaA7t6a1lI2dsiauwTiIX7v1RWrgeG/OucfcMHC5m1cmRRV0XJNymrXM
 R0fQ7wTvZ03n6/drIONC8/YmX/Goh/vWNV9QnibJsbZroV7rqxwWH606mdvyimPiIKpq
 /Ht+BkJ7kqbplW9ZPrwDJZNvoIU6ay+KRwlOR6Gt5oAU5eiY7oPL26c7jgoFEdKmX+9d
 rGgqFqo+Z10vs5RG02KWp9zngBGEPmu3pV484OifH++gQPRpQD3/i18gSsSXPPlkhApN
 v/NA==
X-Gm-Message-State: AOJu0Yx+1GRmcwYeiN7hCU3NmZpDV1UpkQKnc21K+PM7Gdiq7SrEqddM
 qh08YwrPtyXaKQplnaUZN0MwzjyE2lk7GA40tmy8+Bh7aBy6eDcFkYhBIixaGHMmefvtNgUldsr
 WCryOtvtwpROOIteaL5V1jlnv2hk=
X-Google-Smtp-Source: AGHT+IF3zwwAK9P2nTDiTMRnVfARWiHEUQ0zY1xrtt/Ll8Pp167MEaRa97wZz9auBw/Qtm24YMOEIJLJ0NwbnMW0NK8=
X-Received: by 2002:a05:6102:cc9:b0:493:c3b2:b5ba with SMTP id
 ada2fe7eead31-4a962d70769mr17223067137.6.1730850626185; Tue, 05 Nov 2024
 15:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <a6fdfd2c-c8e5-4594-88ac-1976cf39537d@tls.msk.ru>
 <CAKmqyKO58CqEqcFH61Tq=wW3xU0wLsyZmG68RRHfbCOLLPqMYg@mail.gmail.com>
 <19ff8e5f-077c-4487-b9c8-52abe92840ba@tls.msk.ru>
In-Reply-To: <19ff8e5f-077c-4487-b9c8-52abe92840ba@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 09:50:00 +1000
Message-ID: <CAKmqyKN+fWDizwFhDKapKuEbir5oWZzcKCfJdA8y16PJriC9wg@mail.gmail.com>
Subject: Re: [PULL 00/50] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Deepak Gupta <debug@rivosinc.com>,
 Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>, 
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anton Blanchard <antonb@tenstorrent.com>, 
 Rob Bradford <rbradford@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Nov 5, 2024 at 5:45=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 05.11.2024 01:57, Alistair Francis wrote:
>
> >>> RISC-V PR for 9.2
> >>>
> >>> * Fix an access to VXSAT
> >>> * Expose RV32 cpu to RV64 QEMU
> >>> * Don't clear PLIC pending bits on IRQ lowering
> >>> * Make PLIC zeroth priority register read-only
> >>> * Set vtype.vill on CPU reset
> >>> * Check and update APLIC pending when write sourcecfg
> >>> * Avoid dropping charecters with HTIF
> >>> * Apply FIFO backpressure to guests using SiFive UART
> >>> * Support for control flow integrity extensions
> >>> * Support for the IOMMU with the virt machine
> >>> * set 'aia_mode' to default in error path
> >>> * clarify how 'riscv-aia' default works
> >>
> >> Is there anything in there which is worth picking up for qemu-stable?
> >
> > Sorry, I forgot to CC the patches
> >
> > I think these are all worth backporting, but aren't critical fixes so
> > if there are any issues applying them just skip them:
> >
> > target/riscv/csr.c: Fix an access to VXSAT
> > hw/intc: Don't clear pending bits on IRQ lowering
> > target/riscv: Set vtype.vill on CPU reset
> > hw/intc/riscv_aplic: Check and update pending when write sourcecfg
> > target/riscv/kvm: set 'aia_mode' to default in error path
> > target/riscv/kvm: clarify how 'riscv-aia' default works
> > target/riscv: Fix vcompress with rvv_ta_all_1s
>
> So I picked up all the above for 9.1.x & 9.0.x.

Thanks!

>
> For 2ae6cca1d33898 "hw/intc/riscv_aplic: Check and update pending when
> write sourcecfg", for 8.2.x and 7.2.x, an additional patch were needed,
> 0678e9f29c2301 "hw/intc/riscv_aplic: Fix in_clrip[x] read emulation"
> (both applies cleanly) - hopefully this one is also okay, though it is
> a bit old(ish) already.
>
> And the aia changes are not relevant for 7.2.x.
>
> I'm now running tests, but it looks like the whole thing is quite good
> now.
>
> Does it look ok?

That sounds fine to me.

Alistair

>
> I pushed current staging-7.2, staging-8.2, staging-9.0 and staging-9.1
> branches to https://gitlab.com/mjt0k/qemu.git/
>
> Thank you for the comments!
>
> BTW, tangtiancheng.ttc@alibaba-inc.com bounces: host mx1.alibaba-inc.com[=
47.246.137.48]
>      said: 553 "RCPT TO" mailbox unavailable (in reply to RCPT TO command=
)
>
> /mjt

