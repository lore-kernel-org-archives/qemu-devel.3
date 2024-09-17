Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D3CC35FEE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 07:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqSp9-0002uV-1C; Tue, 17 Sep 2024 03:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sqSp7-0002rw-Gi
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:40:33 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sqSp5-0007vU-LV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 03:40:33 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53661d95508so4205e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726558829; x=1727163629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8j/fpIkfmWBIjF0vfufAq2mviuQLZAmdOlBbVub+gG0=;
 b=v1yzb/sIB06ERLMXuXqN+vWAesdVOVNOyInyLziFmIDAMgDd1suhXHicNMHeVGxsoh
 sCdaS5uF6dZF27/AjVQO3eZTSIabwJSq6WCZvR8aHURQI/9LwLtCCX65CQRG0moh1s/l
 PxDkA6h6dTxKoAXdT9I2nU0poTZ74BVroKnTHylxi+5A62I0vmNufQ284scdi6I67xmW
 pi8LXn7d0bF6sjwAPyDqV5Tloo0UJt05wWrcJeSoJPtYiLG22nE4SCa6Cjxzw+lG9g9U
 kKWXJTujYa9uejSuSaIjSutgkwtwk7G2m2VeohUBS6MCLq+95vHI5Q9PCzK/2pJ4CehA
 CnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726558829; x=1727163629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8j/fpIkfmWBIjF0vfufAq2mviuQLZAmdOlBbVub+gG0=;
 b=S8O9cLTYJ3knoHAJhRs60iBykflo6pfUiJweUI9aK96JRDnuCr60ONu2ryZ1efI0AJ
 7SQl06JbrPC7Ost9opc3donNapGQ0Ta5zjkDFySaXc4tW26WhxcYrWR4iy47Gdz78tDb
 Nex5s5AWvvM+35/+spAVVqs0fVPH2Ib4xmeK/mMTnz0fZHfhUcAPSJsUYWp2jjnigvkJ
 O6ljXH5jd7EPXO8b8VRFhDU4mrHaHm2hG4ykkNIpJRmNgNBXniEEydygXEl2rz53NG+F
 RTRtjiUfuC5BozCyAlgNRSfsN0HvV1UeRMMVknH6+oBbiF5bpFXPi7HW+LeLNprwQzDG
 0cjg==
X-Gm-Message-State: AOJu0Yy8b128algnpeSI0wb/3k6L5ECM/CBtYDIhAu1cGJ1mPRH77oXO
 5fTCFt/Jy9cNGc8HJyESYZoKC7497r8k8v0u8qIOuHkP1Ch4XePdg8QCLJjYP0TnnmHZTRAtldm
 adsKakJ2PEBr/roJkrbTOLRr+K7svg7lgfW3Q
X-Google-Smtp-Source: AGHT+IG5B7/oYunVs20kK6BtiatjGInveV0EYUkhd3+WRAVYLobGB7NqI4hZJCYscdLzb5rPEuElnsUsGBeheTh7WJM=
X-Received: by 2002:a05:6512:2312:b0:535:68b2:9589 with SMTP id
 2adb3069b0e04-5369bbddabdmr78507e87.2.1726558828342; Tue, 17 Sep 2024
 00:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
 <20240827064529.1246786-2-tavip@google.com>
 <0fa93707-d092-4db5-a4a4-f000df881ccd@linaro.org>
In-Reply-To: <0fa93707-d092-4db5-a4a4-f000df881ccd@linaro.org>
From: Octavian Purdila <tavip@google.com>
Date: Tue, 17 Sep 2024 00:40:17 -0700
Message-ID: <CAGWr4cTULB7PShTFUoDfTUiEBt+G7D8XzvVnAcmGYJO-4RZEbA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/24] fifo32: add peek function
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, luc@lmichel.fr, 
 damien.hedde@dahe.fr, alistair@alistair23.me, thuth@redhat.com, 
 jsnow@redhat.com, crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=tavip@google.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

 e


On Fri, Sep 6, 2024 at 4:53=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Octavian,
>

Hi Philippe,

> On 27/8/24 08:45, Octavian Purdila wrote:
> > Add fifo32_peek() that returns the first element from the queue
> > without popping it.
> >
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> > ---
> >   include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
> >   1 file changed, 28 insertions(+)
> >
> > diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
> > index 4e9fd1b5ef..77aab488ae 100644
> > --- a/include/qemu/fifo32.h
> > +++ b/include/qemu/fifo32.h
> > @@ -140,6 +140,34 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
> >       return ret;
> >   }
> >
> > +/**
> > + * fifo32_peek:
> > + * @fifo: fifo to peek at
> > + *
> > + * Returns the value from the FIFO's head without poping it. Behaviour
> > + * is undefined if the FIFO is empty. Clients are responsible for
> > + * checking for emptiness using fifo32_is_empty().
> > + *
> > + * Returns: the value from the FIFO's head
> > + */
> > +
> > +static inline uint32_t fifo32_peek(Fifo32 *fifo)
>
> When respinning on top of Mark's Fifo8 work, please un-inline.
>

Do you mean to move it in a new fifo32.c file along with the other
larger functions in this header? All of the fifo32 functions are
defined as inlines.

