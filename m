Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90CBC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE09J-0004Mf-HF; Mon, 03 Jun 2024 01:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sE09F-0004Lr-RI; Mon, 03 Jun 2024 01:22:21 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sE09D-0000ox-ML; Mon, 03 Jun 2024 01:22:21 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c1b45206abso2599372a91.1; 
 Sun, 02 Jun 2024 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717392138; x=1717996938; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50PsFvdLF7bdSbuNtcJy1+VFwwSBLbidgP4uHWniyt8=;
 b=PGLF5JRWBw+9AkRUtdMqEf/XhNFT7FFAtmk0e4qJC66wFsOwfmhIRyYGDeWckoLVP0
 fIdji4QjyAjvkDPV3XcLY9LMNKavgW89cIAD2vARbfb2eFdDY4ZRnMfvp7gv7Dkph3tI
 RjSL1zeI3z53GfD2+v5xsDetkUbMxWMXb4m9T/1JFHS571RiMt4DsFzIy5H0UNpWRC2M
 H5oZ0U2624xt2JVmHWpLrZgCobIFIBmwkQ5iV0QSlSMOibcoQ5vL7n+vkWRfCsUyjHPP
 PNLsd8pCh06jUcEq83OpjgUgyCHaerjWLQb8wMBpxqY7rPWewou822mkOUKKYb0zwm4Z
 p6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717392138; x=1717996938;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=50PsFvdLF7bdSbuNtcJy1+VFwwSBLbidgP4uHWniyt8=;
 b=chY82U1abXvlZhM8WCZw5VdiO4AcUBiMq+E3cwaDVwDKaBv8Ne+a53NKRrjW4Vzt+p
 kS2pEH2mKDX4f2LXujCXcrDT50xArDhnMFGRvDN0d+jgxg5mR6EQ8YMv+fff5tEjHCnV
 zegDDu7yxT6sXY/MUB2N7bmGKgrja+/l95uafljexRKvOvqS3XUkswKUhdVnYaWCHWV1
 1PknKegjnmjDljnQ5ik7pQpVN91m5cKOgUTQvjBluoIGajpvfv3q1jP/3EZrzTYhZcRr
 y9YcbsEJU/E2qoq1zeN0n2aO3pTs9rPsV1XAOCO3hDfS/x8lLd+/8fu6G/wGZkElZK+E
 5IbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Tf16kFNcjl+YtdABK/IlBjtzy+6eqSfsRiZw7BlpCk1/dBpptaGxHOxozh3ov5O2rS8d4/AUe5/Hq1skK0TPZKXhUphghY4GPpLacyARhVlAdV46DgxQjaU=
X-Gm-Message-State: AOJu0YyWjpSSIAyf1HbuvX9tw8oDkdlLIEZ7gnWkUCnbjFbT2fWgZjnw
 2XX+zezXP0kVk3/puXGb6qSY6opy2MTFrOuDzjVIlVaV/Lw8vAEkTMc5YQ==
X-Google-Smtp-Source: AGHT+IFOP5drahW5TZermHLBfmYkYFktFkyJsKNpnT9/1P0mhvITG/LkYTM2oUFq69Rsx6gV+MNFIg==
X-Received: by 2002:a17:90a:c305:b0:2c0:17b4:85aa with SMTP id
 98e67ed59e1d1-2c1dc58f906mr6846764a91.22.1717392137616; 
 Sun, 02 Jun 2024 22:22:17 -0700 (PDT)
Received: from localhost ([1.128.202.37]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1c25e0775sm5261263a91.0.2024.06.02.22.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 22:22:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Jun 2024 15:22:09 +1000
Message-Id: <D1Q4P8RRPIBQ.5ZLVIGLV532L@gmail.com>
Cc: "Caleb Schlossin" <calebs@linux.vnet.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 08/10] ppc/pnv: Invert the design for big-core
 machine modelling
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240526122612.473476-1-npiggin@gmail.com>
 <20240526122612.473476-9-npiggin@gmail.com>
 <eb04e4c8-26ca-4330-ae32-a58737d2a78b@kaod.org>
 <D1MS4B4OOMP2.URZ3Y2R98BC8@gmail.com>
 <a124af35-7ff0-487c-9a9d-ae352e9f359f@kaod.org>
In-Reply-To: <a124af35-7ff0-487c-9a9d-ae352e9f359f@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1031.google.com
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

On Thu May 30, 2024 at 5:46 PM AEST, C=C3=A9dric Le Goater wrote:
>
> >>> @@ -157,6 +157,14 @@ static int pnv_dt_core(PnvChip *chip, PnvCore *p=
c, void *fdt)
> >>>   =20
> >>>        pnv_cc->processor_id(chip, pc->hwid, 0, &pir, &tir);
> >>>   =20
> >>> +    /* Only one DT node per (big) core */
> >>> +    if (tir !=3D 0) {
> >>> +        g_assert(pc->big_core);
> >>> +        g_assert(tir =3D=3D 1);
> >>> +        g_assert(pc->hwid & 1);
> >>> +        return -1;
> >>
> >> return is -1 but it's not an error. right ?
> >=20
> > Not an error just a "no CPU node to insert".
> >=20
> > It's a bit ugly. Could return bool for yes/no and take a *offset
> > maybe?
>
> or we could pass the pa_features array  ?

That might work better. I'll try it.

> >>> +        if (machine->smp.threads > 8) {
> >>> +            error_report("Cannot support more than 8 threads/core "
> >>> +                         "on a powernv9/10  machine");
> >>> +            exit(1);
> >>> +        }
> >>> +        if (machine->smp.threads % 2 =3D=3D 1) {
> >>
> >> is_power_of_2()
> >=20
> > It does have that check later in pnv_init(), but I wanted
> > to be careful that we're dividing by 2 below I think it makes
> > it more obvious (and big-core can't have 1 thread per big core).
>
> ok
>
>
> >=20
> >>> @@ -1099,6 +1157,8 @@ static void pnv_power9_init(MachineState *machi=
ne)
> >>>   =20
> >>>    static void pnv_power10_init(MachineState *machine)
> >>>    {
> >>> +    PnvMachineState *pnv =3D PNV_MACHINE(machine);
> >>> +    pnv->big_core_tbst_quirk =3D true;
> >>>        pnv_power9_init(machine);
> >>>    }
> >>>   =20
> >>> @@ -1169,9 +1229,15 @@ static void pnv_processor_id_p9(PnvChip *chip,
> >>>                                    uint32_t core_id, uint32_t thread_=
id,
> >>>                                    uint32_t *pir, uint32_t *tir)
> >>>    {
> >>> -    if (chip->nr_threads =3D=3D 8) {
> >>> -        *pir =3D (chip->chip_id << 8) | ((thread_id & 1) << 2) | (co=
re_id << 3) |
> >>> -               (thread_id >> 1);
> >>> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> >>
> >> arg. We should avoid these qdev_get_machine() calls. Could big_core be=
 a
> >> chip property instead ?
> >=20
> > We could, but per machine probably makes more sense. It's
> > funny there seems to be no good way to get machine from CPU.
> > Maybe we can just add a machine pointer in PnvChip?
>
>
> It would be easier/cleaner to propagate the machine settings to
> the chip unit and subunits. If I remember correctly, real HW has a
> scan init sequence doing something similar.

Sure. There wll be logic inside the core and chip that controls the
switch so it is not incorrect to model that way.

>
> > I'l probably leave that for another series and try to convert
> > most things.
> >=20
> >>> +static bool pnv_machine_get_hb(Object *obj, Error **errp)
> >>> +{
> >>> +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> >>> +
> >>> +    return !!pnv->fw_load_addr;
> >>> +}
> >>> +
> >>> +static void pnv_machine_set_hb(Object *obj, bool value, Error **errp=
)
> >>> +{
> >>> +    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> >>> +
> >>> +    if (value) {
> >>> +        pnv->fw_load_addr =3D 0x8000000;
> >>> +    }
> >>> +}
> >>
> >> we might want to get rid of the hostboot mode oneday. This was really
> >> experimental stuff.
> >=20
> > Okay sure, I don't use it. Although we may want to run the
> > open source hostboot part of the firmware on QEMU one day,
> > we can always add back some options for it.
>
> It's not invasive either. Let's keep it. It use to work with a
> trimdown Linux image.

We'll keep it for now.

Thanks,
Nick

