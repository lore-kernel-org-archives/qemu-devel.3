Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ABFC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 04:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDzMw-0007KL-Ub; Mon, 03 Jun 2024 00:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sDzMv-0007IN-S4; Mon, 03 Jun 2024 00:32:25 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sDzMu-0006X3-8s; Mon, 03 Jun 2024 00:32:25 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-627ebbe7720so36330617b3.0; 
 Sun, 02 Jun 2024 21:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717389142; x=1717993942; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frMU1SG/dvwjn4JSrlVCcOXAzJO+1GSSJ7QQ8JQ+5tg=;
 b=UVGZrhT+14iQ9OGErwKhkpDF3+fOOFe/f/cd3Jd3NQ8cz4Wr5NOWhfCyEHNeZ5izHm
 ByzO2AlNybVWTnjGV55wRHZpd+cMBl34lT8ct5nRUa9HkxfFL9GP48BzkmsRXQHZLZeo
 lI5XgOmWZMeSiwQiNWNJNLwJRvjTIbCqYhev0E9W9IyAkREDATIyd8dufuIaUvgVF6p2
 Ej1RBVOsrUg7vVV9xBefqu/BCJ/iUreMCQAKPYh2el3uMY3mJachEq5KesdwG5XiBiHw
 PPaPSrhAg7o23FutTfrDE1V0UrADXuiLS2VFKTJ630PNIWwMt/w3UQZUgLQfcDaYrgpN
 KFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717389142; x=1717993942;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=frMU1SG/dvwjn4JSrlVCcOXAzJO+1GSSJ7QQ8JQ+5tg=;
 b=mbLOmFGCux8UrXOaB7bACwJfGbY01GJD0hh3B8U7tpm/IFS09Fdo6lFkJam0wD5NJh
 TCY5ZGYHoStrdnJBOD4cq5jF6MPArOXzDnpld7AmtBKS4O+xB0b2K/yLpYRUlaVREajw
 5ueEgn/Kr5xzcQzGiCPTDcMA22BBLykm53iI5eIEW6FRttLhThDjR5W5LYlViGesYi/U
 vMhp4ms4mUhpQd7Yn7VKLckwtZ/VPET39tl7kQmBX1hlSMQSZvJbvTkCV9hucjKUmHme
 R5ZLZCQJMNEOR0lgLnzf030dhDDVzQTuxfaNVUrOaxLuS7s6HFMT70meZrohIBi2N7gG
 YRzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiHnergHgrNSRW8S67hf0zKV2WKhxFQQ65G8rY3DQj1muXcV8mOzqPmT01XwSqFRZZEztvMNthv2WRqtCcsnjDUY4BK4c=
X-Gm-Message-State: AOJu0YwYFl5DYNm/FzQzity66UytIP5x+tgHSd33YF5tPNb64/6ofzD8
 2UoIzNj7iD9rrARlG52TN25SjDcAHr5njVD+gke/Zj4Uk3vn115w
X-Google-Smtp-Source: AGHT+IGGvNtVib4RLAUMCX6a9mVQvn0IFYulq4anTXrPuG4Xo0UDzI1dcsVxMufbUEUonPkaH+3mkw==
X-Received: by 2002:a81:ad4d:0:b0:614:29b4:670 with SMTP id
 00721157ae682-62c7968e07amr74689057b3.1.1717389141921; 
 Sun, 02 Jun 2024 21:32:21 -0700 (PDT)
Received: from localhost ([1.146.6.28]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c355ec0f50sm4567309a12.53.2024.06.02.21.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 21:32:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Jun 2024 14:32:16 +1000
Message-Id: <D1Q3N1LQCFLC.1AUOTQ4YMO282@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Glenn Miles" <milesg@linux.vnet.ibm.com>
Subject: Re: [PULL 25/72] Adds migration support for Branch History Rolling
 Buffer (BHRB) internal state.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523230747.45703-1-npiggin@gmail.com>
 <20240523230747.45703-26-npiggin@gmail.com> <87le3phhlc.fsf@suse.de>
In-Reply-To: <87le3phhlc.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=npiggin@gmail.com; helo=mail-yw1-x1130.google.com
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

On Sat Jun 1, 2024 at 6:06 AM AEST, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > From: Glenn Miles <milesg@linux.vnet.ibm.com>
> >
> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  target/ppc/machine.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index 6b6c31d903..731dd8df35 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -711,6 +711,26 @@ static const VMStateDescription vmstate_reservatio=
n =3D {
> >      }
> >  };
> > =20
> > +#ifdef TARGET_PPC64
> > +static bool bhrb_needed(void *opaque)
> > +{
> > +    PowerPCCPU *cpu =3D opaque;
> > +    return (cpu->env.flags & POWERPC_FLAG_BHRB) !=3D 0;
> > +}
> > +
> > +static const VMStateDescription vmstate_bhrb =3D {
> > +    .name =3D "cpu/bhrb",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D bhrb_needed,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> > +        VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIE=
S),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +#endif
> > +
> >  const VMStateDescription vmstate_ppc_cpu =3D {
> >      .name =3D "cpu",
> >      .version_id =3D 5,
> > @@ -756,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu =3D {
> >  #ifdef TARGET_PPC64
> >          &vmstate_tm,
> >          &vmstate_slb,
> > +        &vmstate_bhrb,
>
> Running some tests now that Nick re-enabled ppc for migration tests, I
> see that this new state breaks backward migrations:
>
> $ QTEST_TRACE=3D"vmstate_*" \
>   QTEST_QEMU_BINARY_DST=3D../build-previous/qemu-system-ppc64 \
>   QTEST_QEMU_BINARY=3D./qemu-system-ppc64 \
>   ./tests/qtest/migration-test -p /ppc64/migration/precopy/tcp/plain
> ...
> vmstate_load_state_field cpu/slb:env.slb
> vmstate_n_elems env.slb: 64
> vmstate_subsection_load cpu/slb
> vmstate_subsection_load_bad cpu/slb: cpu/bhrb/(prefix)
> vmstate_load_state_end cpu/slb end/0
> vmstate_subsection_load_bad cpu: cpu/bhrb/(lookup)
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
cpu'
> vmstate_downtime_checkpoint dst-precopy-loadvm-completed
> qemu-system-ppc64: load of migration failed: No such file or directory
>
> If you want to support backwards migration, then this needs to be
> fixed. Otherwise we can ignore it.


Hey Fabiano,

Thanks for picking that up, I missed it.

I think we could just say it's not needed, or only needed in
case we are doing replay. I will work on a fix.

Thanks,
Nick

