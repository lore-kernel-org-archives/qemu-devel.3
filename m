Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C59CF34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHuW-0000xg-4r; Mon, 13 Apr 2026 10:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1wCHuR-0000ww-4L
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:05:03 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1wCHuP-0005rr-77
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 10:05:02 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso3074662fac.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 07:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776089099; cv=none;
 d=google.com; s=arc-20240605;
 b=P71UYQX3xbu/1NvqDuqrmLA9bGsw6Tz1n1sQuKM7XrYfFBKJpi0/dYrz9g1NLgLxr9
 YoDI83FCaBstDEZxkLO9aZNy/ppxHn3KFjPw2wmoLVVmI4nYmA2W6Byneq+CZh+hb2O4
 E0FMXfXj88bm5Q4RleqjYHEvK6B180wR+X3rLxsUmfTYMHkhbS0I8cXe8OXJfbc/a1Xw
 561NGa6D/QVGjs2wul4xiAyNfF/2MYJeN/N9Fe7UEhRKPsvIdXVhwPJFmgWGAe3NS2a/
 NMMSGokZdBLvaXS/L0A1NHnc5YSiVos5Mwpx75xIhWdFO8OFHZZd1Dw5WCOBxUy4z7X0
 Hj0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ORftdB5gkOWjlzXsD9l9ePX5TMD5588+G1Spu+rxPvM=;
 fh=aanhhsDZTnRjNFO3zk3hYWwug1kw07jijXkDz3YiQC4=;
 b=V8MCWJZ/ImnVDdDuBumuiij751HGp0GfAq77Yrzm70yWJhlkXorghU0BIHCItdXUoW
 2FOtTYrWaSju5BScE/SnUkUVezyArA6YmuL2JEN6RNJmDJ5iDunpsqO9ys4315PqXn+5
 Jer+D4r2w+qwbfOducVDTW04Idsztq4j7BArqowQqpePY9VNPcJy5Qt9MlvaI21hqKwW
 AdHxbnp9LvfsphanPJpj1n/6IltI41Ser5FTVEXn4DZMa/OupevL82J1VWGwrvzvRudW
 Oscfk1dr37E6fegaAT0Qq9QmzXWoVPhIIBdr/fIp6/iO6MeH5JD8GNKxfZSn2dtVT2sB
 lWWw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776089099; x=1776693899; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORftdB5gkOWjlzXsD9l9ePX5TMD5588+G1Spu+rxPvM=;
 b=IazjfkCmqpM4qr84iJCdYP4hIuFBKP+alqNcg02N3c25rVfvz7dOb8bUs2o4kCRj6e
 UGcxA80rg6fK6c+pMSqwsmem0FFPxqM0blgGJpOZp2ANQj6g/vjE8/F9mi16TCQt9cwj
 SgQiu8dHQ3XaDkloWYQHsKv0we/MtBH9GCj4xs860s3TChsaFCNf9WY3/ut5Q3wIJd10
 Orvn3hICa8ratxz/ciFuT/8h1i9OwY7lZskxEahCn9+BsiVMB5JoteMTaHq3EAK3alxN
 uKXzIodBVFkvVkJaaUg8qCTmol8c3JezaPDff3ATG5Si6NBMsON4Mob/xM5MhXp2lPSK
 Doxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089099; x=1776693899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ORftdB5gkOWjlzXsD9l9ePX5TMD5588+G1Spu+rxPvM=;
 b=Q9ZMC9TDrre32joRqu1Aubf8q9j46E5sPscPSmJewnNng2SRGcGfLXyK/g9LohDN6f
 XpLLygHJh/vZIszUnlZRxFyOxJ8aT2cn96ydqWIJwlveWyiHwzlqLwUnl4BCQGXrUCdb
 NoS4R4Tw3Eg3xUv1GdFhyw8KTbrBNP1ZgtrrDRxxswNpsQqOIy/yTPAyyz33IQh/lYYr
 WYEvu7mrAx7tCcvGLd/l17Ypq/mOBOy7kTDkCno26oOdoMFX/sc7lYm3Zn3tK8pw2wPo
 oGjXUZAFKSk0iPPF6Qy10Z9rHmmkSeSoZLBcVVNtzJ3URmq9T1LiqUXguRuh2zFw4uJF
 Od2Q==
X-Gm-Message-State: AOJu0YxCxY83KGwj2KinQbAps2yGLdr+G7uJenqwDXU9XADw177S4nKw
 37YFs0vPgA8sylUdOmio2dbYJgnrvxC5Mec5bjwUufvXByrD3OhLW232KeXnPf40ISptPCux0IK
 x8RfmUZ9TU6oPCaPYJ5dc8j1eNIYrDrE=
X-Gm-Gg: AeBDiesYN7OU1I1HeYOsBQ80rID9MzCI3QekPCdMNDZDXmdpOCO+w1VPSokmzp7JaRj
 i3pjS0pL12jU9/SJTxyVDKIzokWhk5oJ8mlr6+W9ZWL6RdwoljEyuSvugvSJ68nTiXRVNNP2z8b
 +KkQbzR7Z7cefs2+kCmisWCgqXTj9/bgjgQKKGnmY8/P/ClLq2pjodyy2JEHSV7j9RD078B9GPz
 HV95kDwEghYumELTkwdeb/9YjkPMXDEJVMNBYMaae/43orAt9xMWmxrTsZrhSeu43gSCTvan4py
 7zibLik=
X-Received: by 2002:a05:6871:5d17:b0:423:b2de:3b45 with SMTP id
 586e51a60fabf-423e10dc0b3mr7134330fac.28.1776089098875; Mon, 13 Apr 2026
 07:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-aV1EiKRh-Zpb9=77rXYPD2uT7HZmeNfvVW-wAToT+gaVC=A@mail.gmail.com>
 <87v7dvgw58.fsf@pond.sub.org>
In-Reply-To: <87v7dvgw58.fsf@pond.sub.org>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Mon, 13 Apr 2026 16:04:47 +0200
X-Gm-Features: AQROBzD4gCPWf0gMjGQUHjOzq-XK8MeupF9pWb37Xd9D5xsY91v0dwdR-FLqLug
Message-ID: <CAN-aV1ERB-vdvMyRuNo2tog9-EPPyCunXJkk-kC=DkX-kU6VCQ@mail.gmail.com>
Subject: Re: Question on preferred location for QEMU sample projects
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, artem_mygaiev@epam.com, 
 takahiro.nakata.wr@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oa1-x31.google.com
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

On Mon, Apr 13, 2026 at 9:25=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Ruslan Ruslichenko <ruslichenko.r@gmail.com> writes:
>
> > Hi everyone,
> >
> > We are currently preparing the v2 patch series for the Remote-Port
> > Co-simulation protocol for interfacing with SystemC modules. The first
> > revision was here:
> > https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg01760.html.
> >
> > As part of this submission, we would like to publish a sample project
> > serving as a demonstration of how to connect a QEMU Remote-Port
> > frontend to a SystemC backend.
> >
> > The sample project implements a standard SystemC IP core and uses
> > several external components such as:
> > - libsystemctlm-soc: https://github.com/Xilinx/libsystemctlm-soc
> > - VCML Library: https://github.com/machineware-gmbh/vcml
> > - SystemC Library: https://github.com/accellera-official/systemc
> >
> > We have a question regarding the location for this kind of project.
> > Could you please suggest if there is a preferred location or some
> > standard practice for hosting such a sample project?
>
> Location within the QEMU source tree?
>

Hello Markus,

Yes, it would be good to include this project within the QEMU source tree.
To build the project, the mentioned SystemC, libsystemctlm-soc and
VCML libraries and their specific dependencies need to be built and
installed separately.
Would this approach be acceptable?

Alternatively, is there an auxiliary repository within the QEMU
infrastructure that is better suited for these types of sample
projects,
perhaps somewhere under https://gitlab.com/qemu-project?

--
BR,
Ruslan

