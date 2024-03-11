Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED854C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhOm-0007IQ-T2; Mon, 11 Mar 2024 11:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rjhOb-0007Bj-Fc
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:16:58 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1rjhON-0002WL-GJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:16:56 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a460185d1a7so261849466b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1710170200; x=1710775000; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/DJJRBIU158DTlaQwv1AqQAnPuatDTe4xV2ENqB9VM=;
 b=JrNCp1YIyoy8F9jVgKCUcLJZnG4r+aXR7qWXVqckS5aZzmfGHcZvBH24+03nFlcIIZ
 cjWw/aQ6l1Ns/Tl88REG1fvpjPtq0Y9mjPquIX6lA9fkpQ6Wo3eBSDTmTSltzv0vud9T
 8epV83dSWgOubr+vtOb4XYCUBMpS32+3LuKzC1kPXwvpixcznhNwk5k5Bf9FmvnjVgsE
 kYXYo1ibwxSFYS/9a6ewY4M6tVP0A4IbODQiSTxy9pG7uRAfph1ZxAFQLCK4Ga1YIV8n
 KIP3UKR5J5DJVYjA3kFDj2aNiLzdN5bDdu+h5FdtlaEZ6PBPOjSYteAxYWJhdsNk36If
 KDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710170200; x=1710775000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/DJJRBIU158DTlaQwv1AqQAnPuatDTe4xV2ENqB9VM=;
 b=iTb/PNlXQqC9kMa6qeOaTl9TwQVUpvHi0Wiq236+h54L4TPCO5Ub+8NKXuQ4jKDvIS
 eE7uDgBg5005VxzmBBEqf5+z9mThJ983Ol4RTdNYjGTZhscKrbzToDeqoTfXfrVxKkxO
 7YR/MYuRAEWgmZNVC/HlTcZ5PEGGvDSLfFlpcGVi2SQAHxnz0U5vml46wc3OkpqQZOJj
 o5NdT/fp0UvQ4bQ1B65vHnEHV29NfUjd75UUaV5xDNV9d5bccZFn2Ce+yNpiO/31OrOb
 BzSb3STTDhzeRsH0stCqbQ0IjG+P4EiJqGudtvkMU3ZxCsrVNbQfS7CDu+I25G9bnGVl
 IPng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo6/Kkpc3JWyIassItZGKepvMVyXY8V3rFB9ZGHWKa73tr8mqOs7lIsGB2FTsWOmsHWGLT6f9oKQPouyAHaBHj3gJIEWI=
X-Gm-Message-State: AOJu0YwtMTMXwASZxAVaWOqjDgPImCS4i6/vsAs3shrEkiETcwh9EDEf
 21uZ0Ki/uh6tzpMepJRS9LNmZGYg0Kr/Ai0R/eN6XQngsnKyQtrzs/uHxcizVbzeGUkhWACU2dL
 JP+wAmVSARB69Z4kxbaUOw3TkRfbwIs6XZ8/dOg==
X-Google-Smtp-Source: AGHT+IESazEy5+/gDByjCjlGUhZbaPzDsuU4qRRHAJQ/SBzM7yy7NFSXvftXINlPT0KdlPOVfTJhpCnOIWaAEnBu8MU=
X-Received: by 2002:a17:907:c001:b0:a46:17d6:c094 with SMTP id
 ss1-20020a170907c00100b00a4617d6c094mr3592611ejc.4.1710170200361; Mon, 11 Mar
 2024 08:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
 <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
 <CAOQbQt0+UbfZNPrticjLD4X+S2KR4r+yWPATnhEhTRuxbwvGiQ@mail.gmail.com>
 <CAHEcVy78iCXVGmwr-2snpFwOyCxv3wxYrYJonK6nZF9UfbX_bw@mail.gmail.com>
 <CAHEcVy7kun92b8drEdDZndcWBBT7uvjOpHfqvVbqP0MqvJO01w@mail.gmail.com>
 <a5d4b5fb-e3fa-44c9-b7fb-37c3d1ab2bb3@nutanix.com> <Ze8ZOnWad7_otUX-@x1n>
 <9731d9fc-9d0d-4358-8286-e8ddb21f44f7@nutanix.com>
In-Reply-To: <9731d9fc-9d0d-4358-8286-e8ddb21f44f7@nutanix.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 11 Mar 2024 16:16:29 +0100
Message-ID: <CAHEcVy6xyL9EBT-nK1Jc5=Cx7F9XBMj6JLMxZKj-he9qRyCc+Q@mail.gmail.com>
Subject: Re: Problem with migration/rdma
To: Het Gala <het.gala@nutanix.com>, Peter Xu <peterx@redhat.com>, 
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Cc: Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>, 
 Elmar Gerdes <elmar.gerdes@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::634;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

>> I have reviewed and tested the change. Have tweaked the commit message
>> accordingly.
>> I hope that's okay with you Yu Zhang :)
it's okay for me. As it's a tiny fix, you may modify or include it in
your own commits.

Best regards,
Yu Zhang
11.03.2024

On Mon, Mar 11, 2024 at 3:57=E2=80=AFPM Het Gala <het.gala@nutanix.com> wro=
te:
>
>
> On 11/03/24 8:16 pm, Peter Xu wrote:
> > On Mon, Mar 11, 2024 at 08:00:06PM +0530, Het Gala wrote:
> >> Let me send a proper patch to qemu devel mailing list and cc all the p=
eople
> >> involved.
> >>
> >> I have reviewed and tested the change. Have tweaked the commit message
> >> accordingly.
> >> I hope that's okay with you Yu Zhang :)
> > Het - don't worry, I've had it in my queue.  Thanks,
> Okay. Thanks
> >
> > =3D=3D=3D=3D=3D
> >  From 694451b89b21b3b67c404cbcfa2b84e3afae0c5d Mon Sep 17 00:00:00 2001
> > From: Yu Zhang <yu.zhang@ionos.com>
> > Date: Wed, 6 Mar 2024 09:06:54 +0100
> > Subject: [PATCH] migration/rdma: Fix a memory issue for migration
> >
> > In commit 3fa9642ff7 change was made to convert the RDMA backend to
> > accept MigrateAddress struct. However, the assignment of "host" leads
> > to data corruption on the target host and the failure of migration.
> >
> >      isock->host =3D rdma->host;
>
> Regards,
>
> Het Gala
>

