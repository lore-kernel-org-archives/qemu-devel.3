Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDBDCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1pak-0005E8-KE; Thu, 25 Sep 2025 13:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v1paf-0005DB-Qs
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 13:17:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1v1paO-0003Xa-30
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 13:17:08 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62f0702ef0dso4900674a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758820607; x=1759425407; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vAaS5TX8VmNJa+7WYXzUYE4r47PEDNHyj/0OXr1WJeo=;
 b=KxSUU6tAamIIExTUjoDJJ1fKbhqlVhNmd9JdD/4BlCtIZir0/WOu43XOYx1tplLo1+
 cxJUPOCAtrLTnS7bWx5EwHx6Zg2QD6rv/BnKH2seuVJa50N1npVgm1lS5gErnyzaXSZX
 huwY31LfKTJ5eBzK71Vln4lL0OpYQwkwL1H+mMaBJ/tDFsO1wdgYLQuYBXUgttgDWJcF
 9S7Am4GrQqMIHfz+t2nsmJsaGiq0JSkXY2NetTFCwVCEgnL+NiZX+mRrM9Se9ekatagW
 3BC2A42nwq+4yHMV86HMdDz8+nwje0EehenBeN9bViQS44oIe2aaBNYLIYwLzBhsB40B
 7qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758820607; x=1759425407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vAaS5TX8VmNJa+7WYXzUYE4r47PEDNHyj/0OXr1WJeo=;
 b=EQsyzRSnd80W7GftmY82T46J9UmOuSl/46l6zP6RhUh+iuwYscXVmVZbCTvkbhr267
 RXRTJlRL3sihxiCaVDkKG1pRM2SKOzz8CgmEIn52gHyEK+O8eEqeh9Gkq7hsYj5TLVXS
 NorgNuDs9q7PefdVJnz6O59eALuko5vxGdDqy/USM26TahBZoJxcFb02tnU03qUXpTn0
 CzQZi75cZb0qoJaQYi+uxZ3Ovwp2IsA2PzZPEEmgPPLBb/fbN9Qr+TVMEImOagEZ+uvs
 FJAjahdz6PWkOsOG2PRGghhdO16LAkwxkKoCd57Bx/yUZa00u5TAnCHBKxY0dddObFnt
 YelA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa14xWYu/Vb3dMpfWwQNnN7znS2fRMSQgRoD2URVzDFghEhSBfTZszklPn5Igw0AoCFo9rgcMQcXCV@nongnu.org
X-Gm-Message-State: AOJu0Yz74iiy/k9dTvGaPXHdeImjr5p+tVpA+1Fjc/NIlrb/qiVI3u84
 1mMWopmr1aWw+RVqf2fcFkQUF2gBmBv1KqHZe/yMIig0jI5/yS/UJHmoy+tWK3Ba6VEpeo2NczE
 bVWyeZavSFz8gMunBCis/TTQSNmqZ8gQ=
X-Gm-Gg: ASbGncsiNZlL8b+cUrYbLg/XtQITxouWSN+a1cXKMhucgx/S5x4yQv18imD36AnPqaJ
 N3lLxsPiNCMhR6sclqP3yEz7Mcet8mM3wKx8PKhxXTwE3M6vJ+ZvhT6gc2qBz09QcanxAyTA1xG
 Mm0d/0nM+OijgEL5lukrwzkNh+AB+YK8pmrm5d1ZtrcMJyv/Hh/qWPcj0ZM8qJK6LrMGOfVDv2k
 giyHcvuLDHTSl3Z
X-Google-Smtp-Source: AGHT+IEPrMOZdOefJYZ4+rQASRmQ2w8G5mCEtmbqt6ZjJnVQveuvzYPOSShUjkKhIDcU+amHoew0YmEFRY+4y6fiNK0=
X-Received: by 2002:a17:907:1c16:b0:b31:cad1:b43d with SMTP id
 a640c23a62f3a-b354eb13deamr340143166b.32.1758820607177; Thu, 25 Sep 2025
 10:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250919112536.141782-1-pbonzini@redhat.com>
 <20250919112536.141782-9-pbonzini@redhat.com>
 <20250923192354.GL509965@fedora>
 <85ebee67-3c30-4f14-93ca-d9cf65708619@redhat.com>
 <20250924181024.GB6015@fedora>
 <CABgObfbDphuWOx9r8JEpQCtvGtZM2XYkEd+mBxO4LeqoVPvW6A@mail.gmail.com>
 <20250925115047.GA22729@fedora>
 <4d7d946f-db87-43b6-a5f4-4f6cc583df20@redhat.com>
 <CAJSP0QU-XSrY3NZFoSiFDPLduJw_md0+7YEGr3PZ3UEWGyvEsQ@mail.gmail.com>
 <d36504ef-6b5e-4764-aa09-9da6137e4f88@redhat.com>
In-Reply-To: <d36504ef-6b5e-4764-aa09-9da6137e4f88@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 Sep 2025 13:16:35 -0400
X-Gm-Features: AS18NWBowPov_H1rbLjFCrbnE6R0eSP0hi9Glius73Rj00XNtgzD3-zIGB4W9CQ
Message-ID: <CAJSP0QXAAX8wUxmm8W4JgixsnQf2TgBM=OzvqoSrijNFNjhusQ@mail.gmail.com>
Subject: Re: [PATCH 08/16] tracetool: Add Rust format support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 25, 2025 at 11:37=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 9/25/25 17:09, Stefan Hajnoczi wrote:
> > On Thu, Sep 25, 2025 at 8:40=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.=
com> wrote:
> >> No problem---in fact I have now realized that, for systemtap, I have t=
o
> >> ensure that the semaphore is shared between C and Rust!
> >
> > Is anyone working on the DTrace support? If not, I'll keep it in mind
> > in case I get some time over the next few weeks.
> No, the plan was to use the probe-rs crate, which is almost trivial
> except that it does not support the shared semaphore.
>
> For the shared semaphore probe-rs needs modifications.  It's also
> possible to just import its single file with magic asm[1] into QEMU's
> trace crate and modify it as needed; and contribute the changes upstream
> later.
>
> There is also the usdt crate, which recently grew support for systemtap
> SDT as well.  It takes a much more complex approach and has many
> dependencies, as it almost completely reimplements the dtrace compiler.
> It may be interesting for the future since it is more portable, but for
> the time being I'd stick with the lower-level probe-rs.

Okay, thanks for the link to your semaphore changes. I should be able
to play with it at the end of next week.

Stefan

>
> Paolo
>
> [1]
> https://github.com/bonzini/probe-rs/blob/extern-semaphore/src/platform/sy=
stemtap.rs
>

