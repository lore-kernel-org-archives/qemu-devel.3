Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E81EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQfU-0007FF-SR; Fri, 06 Feb 2026 13:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQfS-0007EU-HS
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:34:58 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQfP-0007ML-93
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:34:58 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-658b6757f7fso3690070a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402893; x=1771007693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=or4MIqj01ebWDLk/04DUDe3fu6MplZ94apo++74gx/E=;
 b=mZwnpv8wVEpOFlbg4E35FR7xjj+ptdlNi9LKgyunzT8WjEWpCEsz+r/ixitEcyLk0A
 H/uhYw7Qt+h8Xyld47rylTDEjkebAJwb1D+7OW+PEhdoEwCYTthAnukEX5ZXWOGCL2rd
 xzGkQgGWpvmHITMKQO7Zf38DBbgX2cYwMAtGY82cIDXj1J4hn9KqeC9wjA5D2qrv3kO+
 AYvvSBha/h9wT9aGmNYyZm1EP8pmcpwfWSf0H/vXDdz/lKHiczDx1Exf3J/wBcX5HAIp
 VPJa7dYcdNk/4EhxORgw3gtDsd4WWwa0xEHTS3+HqUL+bYpR1dWRec9EfXwaiSIXnSje
 epLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402893; x=1771007693;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=or4MIqj01ebWDLk/04DUDe3fu6MplZ94apo++74gx/E=;
 b=cLSAh3p6T2C2sAtwZsMzKBmGEPv4MZkrmm/Yp/KOfRRf7pAK6ORzJXRP80SC7n2OON
 vLF782c298qqGgIjV5bDm1SrK8a14JLMW2ZnJ5JHV9HDZgVooOEN7De38jftOC2Gt5u3
 +sr/3FLStNIsXO/Py8UqbTPnSXmm+Z3CYpCXk0TMtcCXI4znim4UjSO5AHRejwR6jpDb
 rIm1R1L4U6/2/2D7MFpHxQA0eSHrg+07quTPkMP321rk3oRFbd3DLLybcu1Bz7KEI5M6
 fync2wA3NLbi1w4bIMC8VMHY+lSXTzv63uKHt5R1FmanYO/QwdBlTUOhuWA8RcnDxcn0
 ecUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7dvzTKZ7aOy329h5iiNKWxWU0+mOjpIUPilOjVe4PyaBnAUBLiOnU9uCxgyIu0sQBPvSr+NOFJM2E@nongnu.org
X-Gm-Message-State: AOJu0YxwQD2sphIC0ZhuUaFQuOxa14XjoxVyHgL48VJdwmAKAliGQpNb
 mZxljTUwIRkJQPM0rFMYJ1sY4NqsBsWA9i5x7T40NDYYkk8e8Q09gDofO84d4nC+xm4=
X-Gm-Gg: AZuq6aKiGkKNBHaPxgS1y/v9Scvu+oFw64aHdplaDw6oYXbj4zZkngSouk6vaZLxK37
 Jib5iLHhSutBlEgrPyRPe2B4em4Hr9QaH63gIbyGvV3XMAn9vx6rkXV3RjRmDRPNwdxm4VcEF8u
 euKyV1IwLIiClD7OjLfw2+in+KOSygMEVewWIv1spuMIeCWIO/DrhcLgEdWEhzfV8JCGvvnlX7a
 Mm46WPHF+zm6SeTWkdaQz9w8ODhAtKx0EyoqazVnwJ3+VytIIIdeBHRM36eaVtoQTE5q3HqxQPB
 +uQ5MzvOKu3DzgBb2AiAhvCj6t2DW88C/9z2WpovLwkKo2+Cu5LJR6S09FLWDKXGfzvSVjUtpG4
 qHQBwu9RbuaJ3GQRpunNFjPXnb+MnHI+fl6eKbmdVpMkQd89HuPaL6BBRMi4LtqiGSrhhsEUXfF
 uVOoovElRRXztt0VD/r9LDPmB6vNX+05coIQ==
X-Received: by 2002:a17:907:2d0e:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b8eb9e5500cmr555738766b.0.1770402893116; 
 Fri, 06 Feb 2026 10:34:53 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda74c415sm102179166b.7.2026.02.06.10.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:34:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 997735FA07;
 Fri, 06 Feb 2026 18:34:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 artem_mygaiev@epam.com,  volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,  "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>,  Ruslan_Ruslichenko@epam.com
Subject: Re: [PATCH 00/27] hw/arm: Add generic FDT-based machine and
 infrastructure
In-Reply-To: <CAN-aV1F5SjqBw-OP7v68mOAy=3+53HgqjBCrCOUAwTMHUUJAHw@mail.gmail.com>
 (Ruslan Ruslichenko's message of "Thu, 29 Jan 2026 16:39:27 +0100")
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
 <CAFEAcA9NEjaUBX19sdw9TRCKcKn8CQfvoVNZ+VaXOcNZ8kf24g@mail.gmail.com>
 <CAN-aV1EjYwSRfV87YQdtfqU5CH8Bsssr3EvStPWL2_VFOs4N4w@mail.gmail.com>
 <87ecn9aas7.fsf@draig.linaro.org>
 <c2224358-ed7e-1bb9-5eaa-7ae1bafdb37a@eik.bme.hu>
 <87zf5w8v6h.fsf@draig.linaro.org>
 <CAN-aV1F5SjqBw-OP7v68mOAy=3+53HgqjBCrCOUAwTMHUUJAHw@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 06 Feb 2026 18:34:51 +0000
Message-ID: <87h5rtn2k4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:

> On Thu, Jan 29, 2026 at 1:23=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>> > On Wed, 28 Jan 2026, Alex Benn=C3=A9e wrote:
>> >> Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
>> >>> On Tue, Jan 27, 2026 at 11:03=E2=80=AFAM Peter Maydell <peter.maydel=
l@linaro.org> wrote:
>> >>>> On Mon, 26 Jan 2026 at 17:43, Ruslan Ruslichenko
>> >>>> <ruslichenko.r@gmail.com> wrote:
>> >>>>>
>> >>>>> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>> >>>>>
>> >>>>> This patch series introduces new ARM machine model, arm-generic-fd=
t, and the underlying infrastructure required to instantiate a QEMU machine=
 from a Device Tree.
>> >>>>
>> >>>> I'm afraid this has been a feature that has been suggested from
>> >>>> time to time, but which I don't think is workable in general.
>> >>>>
>> >>>> Device tree files are designed to provide enough information to
>> >>>> the guest kernel to allow it to find non-probeable hardware. They
>> >>>> are not designed to provide enough information to QEMU to allow
>> >>>> it to create and wire up all the hardware present on the system.
>> >>>>
>> >>>> There are specific niches where it can be made to work -- I think
>> >>>> Xilinx have or had a setup where they were generating an FPGA
>> >>>> model and a device tree and a guest kernel all from the same
>> >>>> single data source, so they could put everything necessary into
>> >>>> the dtb, for example -- but I don't think it works in the
>> >>>> general case. As one simple example, the DTB doesn't generally
>> >>>> have any information about how the Secure world works in an Arm
>> >>>> system, because Linux doesn't care about the Secure world. It
>> >>>> also doesn't usually have information that the guest OS can
>> >>>> probe for itself at runtime.
>> >>>>
>> >>>> There has been periodic discussion of more flexible user-driven
>> >>>> board creation, but that has generally been with the idea of using
>> >>>> the QMP monitor to orchestrate creation and connection of device
>> >>>> models.
>> >>>>
>> >>> I agree that a guest Device Tree is insufficient for describing a
>> >>> complete QEMU machine model.
>> >>> However, we separate the guest configuration from the machine
>> >>> definition. The -hw-dtb option allows the user to provide a
>> >>> QEMU-specific system description.
>> >>> Those hw-dtb would not be passed to Linux Guest VM.
>> >>>
>> >>> The fact that this workflow has been successfully used in production
>> >>> by AMD/Xilinx demonstrates that FDT is a feasible format.
>> >>
>> >> Where are the extensions to the FDT used for hw-dtb documented? How d=
oes
>> >> it deal with PCI devices and the Secure world?
>> >
>> > PCI devices don't need to be included in a machine description as they
>> > are not part of the machine only the PCI host is. PCI devices are
>> > plugged into the host with -device as with boards defined in C.
>>
>> But if we are talking about a general purpose HW description DSL then we
>> do need to describe systems with embedded PCI busses and soldered on PCI
>> devices.
>>
>> > For
>> > PCI devices that are instantiated by default on some machines
>> > including a node below the PCI host should likely work. I know nothing
>> > about secure world, that may need some extensions but fdt is basically
>> > describing objects and their properties so if it's one or a hierarchy
>> > of QOM objects that needs to be instantiated with defined properties
>> > it should be possible to describe it in fdt.
>>
>> OK - hence I was asking for the documentation for how this is done. You
>> can't just assert that anything can be described in DTB because its
>> original use case is purely for OS descriptions. If we want to explore
>> this series further then I would suggest including some hw-dtb's in the
>> series to replicate some of our more embedded machines in the next
>> revision.
>>
>
> Sure, we can consider more functional examples for the v2 patch series.
> Would you like to see some specific machine constructed with hw-dtb?
>
> Also answering the previous question regarding Secure world.
> We can define parent nodes in the FDT that represent Memory Region
> containers, which are then mapped into the CPU's Secure Address Space.
>
> Any child devices defined under these nodes in the FDT are automatically
> instantiated as subregions of that parent container. This ensures they
> are only visible to the Secure World.

I would suggest we pick a representative sample of non-virt machine
types to model in hw-dtb and extend the functional tests to run both. We
have these tests (trimmed of virt, pc, and q35 machines):

  riscv64/test_boston.py:36:        self.set_machine('boston-aia')
  riscv64/test_sifive_u.py:30:        self.set_machine('sifive_u')
  riscv64/test_migration.py:17:        self.set_machine('spike')
  riscv64/test_opensbi.py:24:        self.set_machine('spike')
  riscv64/test_opensbi.py:28:        self.set_machine('sifive_u')
  sparc64/test_tuxrun.py:27:        self.set_machine('sun4u')
  sparc64/test_sun4u.py:28:        self.set_machine('sun4u')
  sparc64/test_migration.py:13:        self.set_machine('sun4u')
  sparc64/test_migration.py:17:        self.set_machine('sun4u')
  sparc64/test_migration.py:21:        self.set_machine('sun4u')
  mipsel/test_malta.py:41:        self.set_machine('malta')
  mipsel/test_malta.py:97:        self.set_machine('malta')
  ppc/test_74xx.py:19:        self.set_machine('g3beige')
  ppc/test_74xx.py:28:        self.set_machine('g3beige')
  ppc/test_74xx.py:37:        self.set_machine('g3beige')
  ppc/test_74xx.py:46:        self.set_machine('g3beige')
  ppc/test_74xx.py:55:        self.set_machine('g3beige')
  ppc/test_74xx.py:64:        self.set_machine('g3beige')
  ppc/test_74xx.py:73:        self.set_machine('g3beige')
  ppc/test_74xx.py:82:        self.set_machine('g3beige')
  ppc/test_74xx.py:91:        self.set_machine('g3beige')
  ppc/test_74xx.py:100:        self.set_machine('g3beige')
  ppc/test_74xx.py:109:        self.set_machine('g3beige')
  ppc/test_74xx.py:118:        self.set_machine('g3beige')
  mips64el/test_malta.py:46:        self.set_machine('malta')
  mips64el/test_malta.py:72:        self.set_machine('malta')
  mips64el/test_malta.py:145:        self.set_machine('malta')
  ppc/test_tuxrun.py:27:        self.set_machine('ppce500')
  mipsel/test_tuxrun.py:27:        self.set_machine('malta')
  ppc/test_bamboo.py:29:        self.set_machine('bamboo')
  sparc/test_sun4m.py:18:        self.set_machine('SS-20')
  ppc/test_replay.py:25:        self.set_machine('g3beige')
  ppc/test_replay.py:29:        self.set_machine('mac99')
  mipsel/test_replay.py:30:        self.set_machine('malta')
  sparc/test_replay.py:19:        self.set_machine('SS-10')
  mips64el/test_tuxrun.py:27:        self.set_machine('malta')
  mips64/test_tuxrun.py:27:        self.set_machine('malta')
  ppc/test_40p.py:40:        self.set_machine('40p')
  ppc/test_40p.py:55:        self.set_machine('40p')
  ppc/test_40p.py:66:        self.set_machine('40p')
  ppc/test_40p.py:81:        self.set_machine('40p')
  sparc/test_migration.py:13:        self.set_machine('SS-4')
  sparc/test_migration.py:17:        self.set_machine('SS-5')
  sparc/test_migration.py:21:        self.set_machine('SS-4')
  mips64el/test_replay.py:22:        self.set_machine('malta')
  mips64el/test_replay.py:45:        self.set_machine('malta')
  ppc/test_amiga.py:25:        self.set_machine('amigaone')
  avr/test_uno.py:21:        self.set_machine('arduino-uno')
  ppc/test_ppe42.py:68:        self.set_machine('ppe42_machine')
  avr/test_mega2560.py:38:        self.set_machine('arduino-mega-2560-v3')
  mips64el/test_fuloong2e.py:33:        self.set_machine('fuloong2e')
  mips64el/test_fuloong2e.py:54:        self.set_machine('fuloong2e')
  ppc/test_migration.py:13:        self.set_machine('sam460ex')
  ppc/test_migration.py:17:        self.set_machine('sam460ex')
  ppc/test_migration.py:21:        self.set_machine('sam460ex')
  ppc/test_mpc8544ds.py:27:        self.set_machine('mpc8544ds')
  ppc/test_sam460ex.py:19:        self.set_machine('sam460ex')
  ppc/test_mac.py:28:        self.set_machine('g3beige')
  ppc/test_mac.py:32:        self.set_machine('mac99')
  ppc/test_virtex_ml507.py:27:        self.set_machine('virtex-ml507')
  riscv32/test_migration.py:13:        self.set_machine('spike')
  riscv32/test_migration.py:21:        self.set_machine('spike')
  mips/test_malta.py:57:    test.set_machine('malta')
  mips/test_malta.py:108:        self.set_machine('malta')
  mips/test_malta.py:131:        self.set_machine('malta')
  sh4eb/test_r2d.py:18:        self.set_machine('r2d')
  or1k/test_sim.py:18:        self.set_machine('or1k-sim')
  alpha/test_replay.py:20:        self.set_machine('clipper')
  mips/test_tuxrun.py:27:        self.set_machine('malta')
  or1k/test_replay.py:19:        self.set_machine('or1k-sim')
  alpha/test_clipper.py:19:        self.set_machine('clipper')
  mips/test_replay.py:22:        self.set_machine('malta')
  mips/test_replay.py:43:        self.set_machine('malta')
  arm/test_tuxrun.py:30:        self.set_machine('versatilepb')
  alpha/test_migration.py:13:        self.set_machine('clipper')
  alpha/test_migration.py:17:        self.set_machine('clipper')
  alpha/test_migration.py:21:        self.set_machine('clipper')
  m68k/test_mcf5208evb.py:18:        self.set_machine('mcf5208evb')
  m68k/test_replay.py:21:        self.set_machine('q800')
  m68k/test_replay.py:35:        self.set_machine('mcf5208evb')
  arm/test_bpim2u.py:40:        self.set_machine('bpim2u')
  arm/test_bpim2u.py:61:        self.set_machine('bpim2u')
  arm/test_bpim2u.py:94:        self.set_machine('bpim2u')
  arm/test_bpim2u.py:142:        self.set_machine('bpim2u')
  rx/test_gdbsim.py:37:        self.set_machine('gdbsim-r5f562n8')
  rx/test_gdbsim.py:57:        self.set_machine('gdbsim-r5f562n7')
  m68k/test_nextcube.py:49:        self.set_machine('next-cube')
  m68k/test_nextcube.py:61:        self.set_machine('next-cube')
  s390x/test_reverse_debug.py:15:        self.set_machine('s390-ccw-virtio')
  arm/test_integratorcp.py:45:        self.set_machine('integratorcp')
  hppa/test_cdboot.py:19:        self.set_machine('B160L')
  m68k/test_q800.py:19:        self.set_machine('q800')
  hppa/test_seabios.py:27:        self.set_machine('B160L')
  hppa/test_seabios.py:31:        self.set_machine('C3700')
  arm/test_cubieboard.py:38:        self.set_machine('cubieboard')
  arm/test_cubieboard.py:69:        self.set_machine('cubieboard')
  arm/test_cubieboard.py:107:        self.set_machine('cubieboard')
  arm/test_realview.py:21:        self.set_machine('realview-eb-mpcore')
  s390x/test_pxelinux.py:56:        self.set_machine('s390-ccw-virtio')
  arm/test_sx1.py:40:        self.set_machine('sx1')
  arm/test_sx1.py:51:        self.set_machine('sx1')
  arm/test_sx1.py:62:        self.set_machine('sx1')
  arm/test_replay.py:38:        self.set_machine('cubieboard')
  arm/test_replay.py:60:        self.set_machine('vexpress-a9')
  arm/test_aspeed_ast2600_buildroot.py:25:        self.set_machine('ast2600=
-evb')
  arm/test_aspeed_ast2600_buildroot.py:99:        self.set_machine('ast2600=
-evb')
  arm/test_canona1100.py:27:        self.set_machine('canon-a1100')
  sh4/test_r2d.py:21:        self.set_machine('r2d')
  xtensa/test_replay.py:19:        self.set_machine('lx60')
  arm/test_max78000fthr.py:19:        self.set_machine('max78000fthr')
  arm/test_raspi2.py:42:        self.set_machine('raspi2b')
  arm/test_raspi2.py:68:        self.set_machine('raspi2b')
  microblaze/test_replay.py:20:        self.set_machine('petalogix-s3adsp18=
00')
  sh4/test_tuxrun.py:27:        self.set_machine('r2d')
  xtensa/test_lx60.py:18:        self.set_machine('lx60')
  arm/test_smdkc210.py:24:        self.set_machine('smdkc210')
  arm/test_microbit.py:19:        self.set_machine('microbit')
  arm/test_collie.py:22:        self.set_machine('collie')
  arm/test_quanta_gsj.py:35:        self.set_machine('quanta-gsj')
  arm/test_quanta_gsj.py:71:        self.set_machine('quanta-gsj')
  arm/test_vexpress.py:18:        self.set_machine('vexpress-a9')
  microblaze/test_s3adsp1800.py:29:        self.set_machine('petalogix-s3ad=
sp1800')
  microblaze/test_s3adsp1800.py:46:        self.set_machine('petalogix-s3ad=
sp1800')
  arm/test_emcraft_sf2.py:26:        self.set_machine('emcraft-sf2')
  arm/test_aspeed_ast1060.py:21:        self.set_machine('ast1060-evb')
  arm/test_aspeed_ast1060.py:35:        self.vm.set_machine("ast1060-evb")
  arm/test_aspeed_rainier.py:16:        self.set_machine('rainier-bmc')
  arm/test_aspeed_rainier.py:42:        self.set_machine('rainier-bmc')
  arm/test_aspeed_ast1030.py:21:        self.set_machine('ast1030-evb')
  arm/test_aspeed_ast1030.py:40:        self.set_machine('ast1030-evb')
  arm/test_aspeed_ast1030.py:72:        self.vm.set_machine("ast1030-evb")
  arm/test_aspeed_ast2600_sdk.py:35:        self.set_machine('ast2600-evb')
  arm/test_aspeed_ast2600_sdk.py:74:        self.vm.set_machine("ast2600-ev=
b")
  arm/test_stellaris.py:18:        self.set_machine('lm3s6965evb')
  arm/test_stellaris.py:32:        self.set_machine('lm3s811evb')
  arm/test_migration.py:13:        self.set_machine('npcm750-evb')
  arm/test_migration.py:17:        self.set_machine('npcm750-evb')
  arm/test_migration.py:21:        self.set_machine('npcm750-evb')
  arm/test_aspeed_ast2500.py:19:        self.set_machine('ast2500-evb')
  arm/test_aspeed_ast2500.py:45:        self.set_machine('ast2500-evb')
  aarch64/test_raspi4.py:37:        self.set_machine('raspi4b')
  aarch64/test_raspi4.py:67:        self.set_machine('raspi4b')
  arm/test_orangepi.py:51:        self.set_machine('orangepi-pc')
  arm/test_orangepi.py:72:        self.set_machine('orangepi-pc')
  arm/test_orangepi.py:105:        self.set_machine('orangepi-pc')
  arm/test_orangepi.py:149:        self.set_machine('orangepi-pc')
  arm/test_orangepi.py:185:        self.set_machine('orangepi-pc')
  ppc64/test_reverse_debug.py:25:        self.set_machine('pseries')
  ppc64/test_reverse_debug.py:33:        self.set_machine('powernv')
  aarch64/test_imx8mp_evk.py:53:        self.set_machine('imx8mp-evk')
  ppc64/test_migration.py:14:        self.set_machine('mac99')
  ppc64/test_migration.py:18:        self.set_machine('mac99')
  ppc64/test_migration.py:22:        self.set_machine('mac99')
  ppc64/test_e500.py:22:        self.set_machine('ppce500')
  aarch64/test_raspi3.py:24:        self.set_machine('raspi3b')
  ppc64/test_mac99.py:23:        self.set_machine('mac99')
  ppc64/test_replay.py:21:        self.set_machine('ppce500')
  ppc64/test_replay.py:34:        self.set_machine('pseries')
  aarch64/test_aspeed_ast2700.py:151:        self.set_machine('ast2700a1-ev=
b')
  aarch64/test_aspeed_ast2700.py:163:        self.set_machine('ast2700a1-ev=
b')
  aarch64/test_aspeed_ast2700.py:174:        self.set_machine('ast2700a1-ev=
b')
  aarch64/test_aspeed_ast2700.py:178:        self.vm.set_machine('ast2700a1=
-evb,fmc-model=3Dw25q512jv')
  aarch64/test_migration.py:13:        self.set_machine('quanta-gsj')
  aarch64/test_migration.py:17:        self.set_machine('quanta-gsj')
  aarch64/test_migration.py:21:        self.set_machine('quanta-gsj')
  aarch64/test_aspeed_ast2700fc.py:152:        self.set_machine('ast2700fc')
  aarch64/test_aspeed_ast2700fc.py:164:        self.set_machine('ast2700fc')


Thinking about it Arm's sbsa-ref would be an interesting one to check
for fidelity as the firmware stack targets an explicit HW platform.

>
>> >>> In contrast, QMP usage may end up even more complex and less
>> >>> maintainable for the task of full system modeling.
>> >>> To my understanding, this would need to generate too long configs,
>> >>> which may eventually require some intermediate format by itself.
>> >>>
>> >>> I am proposing to use FDT as a serialization format to describe a
>> >>> machine configuration. Theoretically we can use other formats, like
>> >>> XML, but in my opinion FDT perfectly matches the requirements.
>> >>
>> >> The QMP interface is self-documenting and introspectable and used for
>> >> the management of QEMU including things like hotplug. It is also QOM
>> >> aware so a natural fit for dealing with the underlying QOM machinery.
>> >
>> > QOM seems to be more about operating a machine rather than defining it
>> > for which fdt is an already established common way.
>> >
>> >> Previous discussions have entertained the idea of making the parsing =
of
>> >> hw-dtb an external script which would then translate into QMP commands
>> >> to build up the machine.
>> >
>> > That would be possible but it seems that directly parsing fdt in QEMU
>> > could be done with very few code and with some additional support from
>> > devices the latter of which is probably also needed when trying to
>> > interactively define a machine from command line, monitor or QMP.
>>
>> I agree QMP would need some new APIs to support this - and also have
>> some examples of how to replicate the existing machines over a pure QMP
>> interface.
>>
>> >
>> > Regards,
>> > BALATON Zoltan
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

