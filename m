Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40D7EA7945
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 02:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpS4-000573-Iw; Wed, 04 Feb 2026 21:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vnpS2-00056q-FK
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 21:50:38 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vnpRz-0005pt-3N
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 21:50:36 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b885a18f620so63172266b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 18:50:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770259833; cv=none;
 d=google.com; s=arc-20240605;
 b=es7U575JgCeg3EkMHujGxX9yHjjqxJwRuVzSJgWd7u7kPF9LdJiz+65nCAuTaOzoWS
 6BqnEJjWxfwIWwDuhOPX0BHV/FHOxk6rE2ObapOAeqH6io8g5yhfqrklvtSbZ5c5n90m
 0kwXOuck9o6JepTof7ndU6qq0IPkqnbG506oo+dbyH1Fz5HyfOHyHSStIbTtNUzdwiFM
 0Mqs2W8HWWc0d5N081GGt6RG3244d/RW4dGcZvDSHdh6JhggJ+A94TNEq0eYnIUoPU0p
 pEbvI5wgIEYnajzKsZteWdO9d2iUL38cz82gW45xw5nIN0qrud9yJd8MFhYzkhtDuPtC
 XH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=99C7SfKQsX2UJQr7iXR1ykLNbjGCpbNlesEkxgIgX/E=;
 fh=KgimXnKYua7njztgMQq2QSz3aOrdbSVOwRY3A+EqJ1s=;
 b=HLIYx3e2xp30exrzDVkzjPO9vn4vxymyvtE+iT2zWh3sYM/iSiqsMVzDvx57ie+p2L
 /L3kaQuvn1FmHYnj6vdf/canVqZWaU8UaSME1k+8a3P/wOVuXndbnaJ/q2jepY4AN2/i
 Por8qeBJcqShKKhUdZcHyCpcdkZxdSBfRuWtXLdKLhN0HKnOcOMfPhvrLQikDB4sr+aW
 SFLdVZXtSXA/eNpSr0fnE2RcQYWcs8tTCYS43342snNRQUiE3VC5SkX3BUm6vazX6Z6f
 MZq3+oaUAMoBAcvDlhoaw13fG+f2J1gSrDOcP7Edv2KetfNL5vAy+zAEDT5+NcBfOnM3
 IFtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770259833; x=1770864633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99C7SfKQsX2UJQr7iXR1ykLNbjGCpbNlesEkxgIgX/E=;
 b=BOVal3elxclidOtaiDf3Zl+4ew+s0uyU/9HB53tYfBmPNdKu7qG6pRBj4i3FgBGOj9
 LH2ICOS1HShdWUfS2rjBmVqWsPnjm3qDj2iOkFN6Z9m1PWJTweiRBnO1iyePH00vBa9m
 JUYt3TtPMvcrHhnBYem4XvHqG7I5dqT98/U3f5dsEtqQDwX4NBphRpxurCJkpdN5poWb
 k79X5tmRi9lmUO/4rYZY+bjpjcj2nS/E+Wz0qX3x0r3DIQ/73Z+nlwC7wLnJG8S1ZC/g
 HhfgK2u94jkL2QwoSO+TiUjP6Dko4dMXHw12+ihzC2/a1bXaEdCourdkzdCvzak2Nd1P
 zAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770259833; x=1770864633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=99C7SfKQsX2UJQr7iXR1ykLNbjGCpbNlesEkxgIgX/E=;
 b=hpIJyYeMQCuCl1uutOMklD87dsEjtnEeQhzMvnWVlP+meSwPpcaAiJMTh8lZLxx2Ds
 ilJigJ0Y0ngU4H9oIGmD6g53mzDmJhz90Vj8cdLEEYqs3ZF4ljJuh5m8jFNImR6/Rczc
 4vShIM5Y2ZRPuW5bJGzMIw/LlDUaSrrHBRnWmhee3SIHF1RtyTRFMjrCH3iBM+WyJm98
 RPePVGUYy7nJYH8mMIlO5QQFUjubO7nNRFsy8ouB+GJXVyUAOKxKIORhDPswVfE0h9x9
 eKnYSzFutch0UFO29wk503NHhNAu4YMHB0Bh3XA0lTTNwVsa/nZpf7ooLmC/1R6IbbTM
 Px+w==
X-Gm-Message-State: AOJu0YxZvkmPr9B3JWRRDRIeXz889c2qFnxhVrIbq3q47l6L1Dm/Yo9N
 T7amCZPibdkW3Ghun/nH2DrytWfJTX/UoBQ4f3uHAneHyBFTY3y4XJ6dFm3JYPqk91rlkTsMFkw
 9VMm3q1peZTff6mGOLI6+PQq/VG5nYtA=
X-Gm-Gg: AZuq6aJBrv5wfwB1HgrwAgJscKiEV0QwwXSyAYjeqeA88vvG8Rkh9BniHnK54G/pNBQ
 MD7RgpXJmsJj7IkY9LC8n9EQX+WgZXkPqgrdEP/CBy/NOVD7quvWZejgXKVwNGo5GTveURXNT9Q
 3fxfhloPY4nizfwucjn3joQrPOyWq95Zi097aZ2tBDILiR1dwu4aaK+GFpmltnhluF3J6gjkr/K
 JQMipLf402wV+pF66QoUKwS/rPGoXo8oeO6KDwH5U4/psluQGcQDYbzmSHTYuKH5Pd0cSpT41ol
 CHjj5yE=
X-Received: by 2002:a17:907:d0c:b0:b88:2848:dec8 with SMTP id
 a640c23a62f3a-b8e9f4104b9mr290458666b.54.1770259832629; Wed, 04 Feb 2026
 18:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20260126094422.23116-1-zhangckid@gmail.com>
 <20260126094422.23116-3-zhangckid@gmail.com>
 <877bssy8bb.fsf@pond.sub.org>
In-Reply-To: <877bssy8bb.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 5 Feb 2026 10:49:56 +0800
X-Gm-Features: AZwV_QhomY1wOu1XQu_QCj7YjoCvXPCi9utUVn170d_fTpPmDTSulG8BZP6og2U
Message-ID: <CAK3tnvJb+TmOo5j8UUkWwLBOrzR9rcrXpY-DOD=op=wNTqBLQQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 3/3] qapi: Add attached flag for iothread
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x636.google.com
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

On Wed, Feb 4, 2026 at 8:58=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > The attached flag depends on struct IOThreadInfo's
> > 'attached': 'bool'. It can show whether the iothread
> > is attached to an actual device. Show in the qmp/hmp
> > CMD with "attached": true/false.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>
> [...]
>
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 1f5062df2a..cb865d6e48 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -76,6 +76,15 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @attached: The attached parameter is a flag indicating whether
> > +#     the IOThread is currently associated with an active device
>
> "the iothread" for consistency with other doc text.

OK.

>
> > +#     (e.g., virtio-blk).  In hotplug scenarios, users can
>
> I'd drop the comma.

OK.

>
> > +#     pre-allocate multiple iothread objects to serve as a persistent
> > +#     thread pool.  When a device is hot-unplugged, the corresponding
> > +#     IOThread is released but remains available, allowing subsequent
> > +#     hot-plugged devices to attach to and reuse the existing thread.
> > +#     (since 12.0)
>
> (since 11.0)

OK.

>
> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -93,6 +102,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'attached': 'bool',
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -118,6 +128,7 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "attached":false,
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -126,6 +137,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "attached":true,
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>
> With that
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks for review, could you please take a look at the 2/3 patch in this se=
ries?
[RESEND PATCH V3 2/3] iothread: Introduce a new flag to show iothreads
attached status
If have some issues, I can fix it in the next version.

Thanks
Chen

>

