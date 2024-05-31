Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD8FC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1ko-0002aM-6f; Fri, 31 May 2024 08:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1km-0002Zy-16
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:53:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1kk-00044z-DA
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:53:03 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a033c2e8eso1095138a12.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717159980; x=1717764780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPuY0CSVGkW/J5U7g75og9D/qM9b57zKvu2kw1tatKM=;
 b=UP3/+LlcfVUNnZMCz5guF8xsYoBifiwRGJKBK6PhYOJlTDVWmDbDPxIxDx9gBmID9P
 3fiC1kDz+dVnCMF60gFJ5hsYjKOCPc8k4lx8OkQaswPBloYrIG76he2dMbpRCf40rl2z
 OYNgYs/in6xVjlsroHPJ2uS2LcYbeyDaPegdy8CoHVrIzjv9Fo/0jrFD1aNTP2pG30ld
 uwcSSVdA9olY5WukLXnNAUAr2oez3W6fVC7V8L1hQ6JmmSbjkZxXzvfJRTioYjrMx713
 gIvxK+7JNai/1FUbxiOdaOL8Nbf7h4YYbTRMaUsFPXpRNYM0fNZlvojxHbRSOBLXRddr
 c6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717159980; x=1717764780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPuY0CSVGkW/J5U7g75og9D/qM9b57zKvu2kw1tatKM=;
 b=lv67qGNFPY/qZyUZsg3w9NxivEjKX3fT5Kz9DdHcEgzi2oc+dqYolFypQPbkP6bwrl
 r2HLIS83SeIwr7rqHXjqijdjQuuQpb3+1xwxa8Mpkx6uWllbjr2LU9dVN0aVObQCZA71
 28az3HQWqSwwkp7N3BtzVc8JfCsJe3KETNKUIJKSZBd6xYxedqZ8MHZiTXwPCmWiZx0H
 eJana2JV0Hy802qNQVSZTQ3BEYlYH+TllbNDSVRrQoJ3H3W2pcOQ6beThhT/tV4HceEa
 Lb5MFpWgFrD5fW4y6sUGEKujbmEZkkqVvYmmcA798zoCn1Zt//4L4DCEec6tSzF6rv+r
 hDBw==
X-Gm-Message-State: AOJu0Yws8soTWhzgfVdLLtRrPYmjcacBWnPVC/VgzYg8ytvzP7T079PV
 dILcdHFrWOeWPsApIe9SjNUVMdaoUa8mGtu0my5olnYXxmup2hh9zCLN0iyu3m00jLnlHBOTDBo
 28Ur/sSvaX6EBEDQuFSTLJSS7vtJsnPKTEz4O7wt/mk6SBz4h
X-Google-Smtp-Source: AGHT+IFLBMT+7lYemxlyOA6pUSqfV6jHz+DNV0YvNameRk4gAbHpPCAEbiBnwZgF5L8o+j+UYq4AzqE0I8RMv+xvcqc=
X-Received: by 2002:a05:6402:2313:b0:56e:743:d4d9 with SMTP id
 4fb4d7f45d1cf-57a364acf15mr970542a12.42.1717159980370; Fri, 31 May 2024
 05:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <CAFEAcA9w1PeT4X=eX6Xh64vNWC1FPQdgGCXJkf0+=3kDLuYVsQ@mail.gmail.com>
 <CAFfO_h57h7MX0Drw_jjym-kq8q9jFwTx7J7nYX7cxW_XY+pOsA@mail.gmail.com>
In-Reply-To: <CAFfO_h57h7MX0Drw_jjym-kq8q9jFwTx7J7nYX7cxW_XY+pOsA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 13:52:49 +0100
Message-ID: <CAFEAcA_1AWpCyPvx6KRk6zg9zN72exozyfiw3grOb2NSGtW8iw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 3 May 2024 at 17:53, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrot=
e:
>
> On Fri, May 3, 2024 at 10:28=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Fri, 19 Apr 2024 at 19:31, Dorjoy Chowdhury <dorjoychy111@gmail.com>=
 wrote:
> > >
> > > Some ARM CPUs advertise themselves as SMT by having the MT[24] bit se=
t
> > > to 1 in the MPIDR register. These CPUs have the thread id in Aff0[7:0=
]
> > > bits, CPU id in Aff1[15:8] bits and cluster id in Aff2[23:16] bits in
> > > MPIDR.
> > >
> > > On the other hand, ARM CPUs without SMT have the MT[24] bit set to 0,
> > > CPU id in Aff0[7:0] bits and cluster id in Aff1[15:8] bits in MPIDR.
> > >
> > > The mpidr_read_val() function always reported non-SMT i.e., MT=3D0 st=
yle
> > > MPIDR value which means it was wrong for the following CPUs with SMT
> > > supported by QEMU:
> > >     - cortex-a55
> > >     - cortex-a76
> > >     - cortex-a710
> > >     - neoverse-v1
> > >     - neoverse-n1
> > >     - neoverse-n2
> >
> > This has definitely turned out to be rather more complicated
> > than I thought it would be when I wrote up the original issue
> > in gitlab, so sorry about that.
> >
> > I still need to think through how we should deal with the
> > interaction between what the CPU type implies about the MPIDR
> > format and the topology information provided by the user.
> > I probably won't get to that next week, because I'm on holiday
> > for most of it, but I will see if I can at least make a start.
> >
>
> No problem at all. Just let me know when you get to it. I will see if
> I can fix it or ask if I need help then. Please enjoy your holidays.

Hi -- this is a note to say that I haven't forgotten about this
patch and the related issues, but I still haven't been able to
make the time to think through how it ought to work yet :-(

-- PMM

