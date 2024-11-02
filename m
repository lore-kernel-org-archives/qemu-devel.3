Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB6E677F8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7BqA-0002UD-CB; Sat, 02 Nov 2024 06:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7Bq6-0002Tr-Ri
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 06:58:43 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7Bq4-00084e-Uo
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 06:58:42 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso40281391fa.2
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730545119; x=1731149919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPycWZ7wjWzsUMQZMTg+1NhhPy8gLSG79qoVnmaxGuw=;
 b=IetWN79gMaQnWoHHor5FIAQNyLN4kYue7mRG10/lk61vkSvn6vYiFEab0TtsJSF0NK
 LUzjQR8WPOri2knIYwIXDT1gP6Gm+Y1OlMFJCc4TZnNEIaCxKia0INi59q9g+Voe+Vy5
 zCJWsToTs12nf0pPxaG1YHvtO6IyUMLr5Z8OXYEGuB+BawFMYIMLnCI3iYmnN1ePa618
 Do2v9wL4uqpo1T4shGkJvMtCV44ND5PNH4BCEkDtzXx5grnZ2NN2MW8Xzv6Iir0Ta0ga
 Wdu/dTG4/ZwUc7qxf1aoIVaAGctKTNslG8/7rfDWDMmsabkYf6h91B4u/2UFnM+LcaCm
 Ye8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730545119; x=1731149919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPycWZ7wjWzsUMQZMTg+1NhhPy8gLSG79qoVnmaxGuw=;
 b=J3EW6ru9V2mggWSWPn/ZspPxSfusdbNltKUEmorczCXlXjOMJKzvM3Jh7rCtKc0VdM
 EcvKdJg9bj9bgrVhS71svI17Eo4xKJByIM1ZlNfoS6VF1oG3olf7PSR2ny3EqgPIYgh+
 O+DYdTWYs8FWqTAI2MLAb5e+qIITdjtEfRKE8AeiPUQTV9U2rzLThNmTGy4EsvxwFdFG
 bZcHPbI5KqyPw1GlbioTgUPdiF5NIUpCLBnlBwBOBV5xCB67pqs13ArwRURWltYc1kAP
 WA04XD/kZtZcVDZjI1PuCFSwpjMdvt0uAZBFjW7jBaFGEm2LVKdoRprQY2Pr2EWkhxSn
 c6hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4XY723jPgI00p2uLUJXo6YenqX48yJ2Dtxf0C7xbF/H9PEmCp+gBBwgUNgKQCsSgvq9AZ9YPTbGRm@nongnu.org
X-Gm-Message-State: AOJu0YxUOl5Cr+MllM2Anf2AA51JZ38WnJnvILVL8T3+YFFr401qNEDB
 /Gqd6BC3khbMJcVbi+MdGx9uRuFJ3DoT3adL3ObOlebpxiX7zMg2cP+xWEAjGaSrap4k8j3qIhx
 m+pyVU5H7nkabmfDPJ/1VAgmv2CY=
X-Google-Smtp-Source: AGHT+IF7sbAQWXWnbSGQ+2Bd5Uy8HQUbsPYNwIsuVdVlcQ3bYU0FHZoT1eErXjimH0BoLTAL/ppN3qN3DZSy3Ofu+u8=
X-Received: by 2002:a05:651c:893:b0:2f3:f1ee:2256 with SMTP id
 38308e7fff4ca-2fedb84a3a9mr50564851fa.44.1730545118393; Sat, 02 Nov 2024
 03:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
 <20241015085150.219486-8-marcandre.lureau@redhat.com>
 <CAFEAcA8DztPbmp_PavV9EGs=1RUeszDOpGRtwVexQbcCOXWO0A@mail.gmail.com>
In-Reply-To: <CAFEAcA8DztPbmp_PavV9EGs=1RUeszDOpGRtwVexQbcCOXWO0A@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Sat, 2 Nov 2024 11:56:17 +0100
Message-ID: <CACZ9PQVYChQht8ykaCfdhrAKnF49RRsP0B7B66vesW1EjNBxjg@mail.gmail.com>
Subject: Re: [PULL 7/8] chardev/mux: implement detach of frontends from mux
To: Peter Maydell <peter.maydell@linaro.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22e.google.com
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

Hi Peter,

On Fri, Nov 1, 2024 at 4:25=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Tue, 15 Oct 2024 at 09:52, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Roman Penyaev <r.peniaev@gmail.com>
> >
> > With bitset management now it becomes feasible to implement
> > the logic of detaching frontends from multiplexer.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-ID: <20241014152408.427700-8-r.peniaev@gmail.com>
>
> Hi; Coverity reports an issue with this patch. I think
> it's probably a bit confused, but on the other hand
> I read the code and am also a bit confused so we could
> probably adjust it to be clearer...
>
> > +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
> > +{
> > +    unsigned int bit;
> > +
> > +    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);
>
> Why are we calling find_next_bit() here? Coverity
> points out that it can return MAX_MUX, which means that
> if the caller passed in MAX_MUX then we will try to
> dereference d->backends[MAX_MUX] which is off the
> end of the array.
>
> What I was expecting this code to do was to check
> "is the bit actually currently set?", which would be
>    if (!(d->mux_bitset & (1 << bit))) {
>        ...
>    }

Yep, that looks less confusing. I'll send a follow up commit
on that.

Thanks.

--
Roman

