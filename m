Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A37BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gg9-0001oz-5L; Wed, 08 Oct 2025 22:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gg8-0001oi-0I
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:46:52 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gg5-0000zs-8F
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:46:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62fa062a1abso709980a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759978007; x=1760582807; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKTXiPY4GnlZcwIqDS+SADcveuQM/3ZgjoOaqICxzL4=;
 b=R+3HAJe/luipJSbOKuMfk8mHBSp1GN9BsRttBT2Gbetv+zMDvb5GuSILqQJkDxx/bG
 4axmaL+mO0bZPRHmSGpbFxJDMsSQ4U+T4p3TXId9XjxgPKOvmPwUNAPQ86Ck0RFBDzmY
 5JnBR3enR+VjwsmEBcT/Gbt/VN75pKTBlrTgfTj2IkdfOIF5tkJ+xkfznnlP6S5Kxh3z
 WQHjYsBF/tj0JwjfOsl4XqKF/9/+3YVRVudIpPiWJvOsurYc+uq2ELhDaoY9potfbLBD
 JnMYNqlPb+pehmM6FFc6kRvMPl13idoPPfwMOzYqj6g7/Nb7Wq24ToQAuhN42hX4Wswx
 +Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759978007; x=1760582807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKTXiPY4GnlZcwIqDS+SADcveuQM/3ZgjoOaqICxzL4=;
 b=c3f+esbX7lKYYXM4QMy6s6aViYkyc3s4d9btCFZiL5AIUqqQC12GKjZrRIqZQ7SP53
 YASRi7Ryojiv0FBW74cnsh6OcA1Cu8P3bFZ+1io3ZWJFkZgq3V5a94yVUrchV5lWb4/u
 U8WFhMzPHvajTyfqgTFwAA+9Z3h+iQiJN50d17Yya3RehQP+VwicjGnNMQsk2cVOjAEo
 FVcoK6J6DQKQtuqnyBFfc6CGCcoE9azU30/jH7AUDaPRrgFJQuwnhGA7/rI1nxCglioE
 oqqwMZyM7QhLt4LXiysqRDuYJKNhVq4omF18bfshhApcSAh6Cr+RVzgg0XB2ozkjxcWM
 PtFg==
X-Gm-Message-State: AOJu0Yzc+G9CSyvHvTl86T6cZg3FytJMSZPSiACkZUsvkFqsYVravoaN
 EeN98/eyfOn3B0O4i8pMGhlWlLTDyoMUi0r+XGpqtJ5PuRGnUw1GRPWSAJw/6VA2mKRxND9gKKJ
 YGRbsaBiDCdGpheUkq/nv1sWjlRGwTnI=
X-Gm-Gg: ASbGncv+QZ+FNlXUr7NUxqSSGhtoanAedHzIvaSq9rmcZO23T6b1tAQ6kyv/VI2VDEq
 O2flRhYtKvgsr1wTKXr4+xp2LRYV+MtxJX/ov3GoTUQ73g5B+yWzF4jE1wZnRe94j4/3OfQOpzZ
 Rda77/orv0wo3iG7Q3A3YPnkP/TG16IOdSVzg6AdRw+1Ixz7eDywufpCzN1WFQ+w2Z3fQdkJ0MS
 cmkajXE0dY12fbamsu3YKqsr66Nv4qir92hUMlOHTfXTujUvGKBP37OcHbRIg==
X-Google-Smtp-Source: AGHT+IFCog23SjySNL1yOLCSB7CC48DD7qndCT81baMPBvpaArPgZTvt/BpUGzo4uPM8fWSQbJ8byAR4KeUJXHC2LyM=
X-Received: by 2002:a05:6402:2747:b0:634:ab34:ed40 with SMTP id
 4fb4d7f45d1cf-639d597a7cfmr5478318a12.0.1759978006617; Wed, 08 Oct 2025
 19:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
 <29f3c19d-09fa-4b1d-ac92-65838cc69698@tls.msk.ru>
In-Reply-To: <29f3c19d-09fa-4b1d-ac92-65838cc69698@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Oct 2025 12:46:19 +1000
X-Gm-Features: AS18NWC-eAsj_YMVWk0yNho3kC6JcrnUUtwu44oHXmVyEsvA0EGmXuhzCt9m-yY
Message-ID: <CAKmqyKO8gHyKhO09WBMQWV5mV2Yc48DYWgb89sfzKK4e197BfA@mail.gmail.com>
Subject: Re: [PULL 00/26] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Frank Chang <frank.chang@sifive.com>, 
 Jim Shu <jim.shu@sifive.com>, Vladimir Isaev <vladimir.isaev@syntacore.com>, 
 stove <stove@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, Oct 9, 2025 at 12:13=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 10/3/25 06:26, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
>
> > First RISC-V PR for 10.2
> >
> > * Fix MSI table size limit
> > * Add riscv64 to FirmwareArchitecture
> > * Sync RISC-V hwprobe with Linux
> > * Implement MonitorDef HMP API
> > * Update OpenSBI to v1.7
> > * Fix SiFive UART character drop issue and minor refactors
> > * Fix RISC-V timer migration issues
> > * Use riscv_cpu_is_32bit() when handling SBI_DBCN reg
> > * Use riscv_csrr in riscv_csr_read
> > * Align memory allocations to 2M on RISC-V
> > * Do not use translator_ldl in opcode_at
> > * Minor fixes of RISC-V CFI
> > * Modify minimum VLEN rule
> > * Fix vslide1[up|down].vx unexpected result when XLEN=3D32 and SEW=3D64
> > * Fixup IOMMU PDT Nested Walk
> > * Fix endianness swap on compressed instructions
> > * Update status of IOMMU kernel support
>
> Hi!
>
> Is there anything in there which is worth picking up for the active
> stable releases of qemu, which are 10.0.x (lts) and 10.1.x?
>
>  From the patch descriptions, it seems like quite a few changes in
> there are worth to be back-ported.   For example:
>
>   - target/riscv: rvv: Fix vslide1[up|down].vx unexpected result
>     when XLEN=3D32 and SEW=3D64

Yes

>   - target/riscv: Fix ssamoswap error handling
>   - target/riscv: Fix SSP CSR error handling in VU/VS mode
>   - target/riscv: Fix the mepc when sspopchk triggers the exception

Yes

>   - target/riscv: use riscv_csrr in riscv_csr_read

Yes

>   - hw/char: sifive_uart: Raise IRQ according to the Tx/Rx
>     watermark thresholds

Yes

>
> This is just from reading the commit messages, - I haven't looked
> at the actual changes in the code.  Maybe some other changes should
> be picked up too.
>
> I already picked up VLEN fixes, "MSI table size limit" and
> "do not use translator_ldl in opcode_at" (and I'm still unsure
> about the latter).
>
> Some changes has been Cc'd qemu-stable before, so I picked these
> up too, eg "Fix endianness swap on compressed instructions" and
> "Fixup PDT Nested Walk".

Thank you. I think that's all that should be back ported

>
> Some other changes, like the timer array/time delta, does not look
> like possibilities for the older series due to incompatibility in
> migration they bring.

Agreed

Alistair

>
> Thanks,
>
> /mjt

