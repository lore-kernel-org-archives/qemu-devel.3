Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BCECCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eWl-0005Gv-PC; Tue, 14 Oct 2025 08:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8eWh-0005GR-W7
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:53:16 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8eWZ-0003vH-3T
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:53:15 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6354af028c6so5181920d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760446385; x=1761051185; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sk9uJbC7nqF1Vr/op1/1cZNr7x1v5xpAmDnAo7NDF68=;
 b=ADqqDuzV/tkt8kv6osDKvPM3zUk8eyKAh+vfdAP78su0ohBolVYkf39MivhDEpoEuu
 Kev1VfOTTtGwMUtnZOuJFAXLqpebxyrxx2kakYzHVLLYhbs9Cg9bn/QTlLl3nWzXeuae
 o9qnqQs3b+PnewxuxRwh+cBgr0Eqwiz6CN65lUN7arfNTYWpOnTp2MD0HGEvDghpnbKz
 RGTJridpdumZABMXBsf7mWHGIrpFziAVyeQUZWTykZzZWubaA2NuLA9QwsPX/pIcSUgQ
 5xwi1FEp26Xkp/WNwz6Rj0MOCAv6vM51WrsmAJJ3vIBILPkcDdO4glQo2+0uIkZaIj0z
 0Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760446385; x=1761051185;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sk9uJbC7nqF1Vr/op1/1cZNr7x1v5xpAmDnAo7NDF68=;
 b=TMzZ3Y4EvxnKisRNwpUKnRAjxJw8qJOcmlpuXrKKh0W698SoAzdMZ0hqtHCXGI0JZb
 +Kc6yBYX/DNokkb5kTTvqARnlRhG5xVwcbicwfoWLhSyN1nG2fwwlo0eeJaDNHG6oC3d
 Vdym6gthMjqlXF0gmH+eyY5x/4CQDYYmiMzPpEWH4vUNznbaLttGD+sDHKwdWKc3wM3q
 m5l0vWzSLeBVciuM6LJyguaiK2EMYctA3fQDPDd367wcsKQgjNy/nsVqab6SjKD8CFrl
 MD893ZgLzf5RgfJ/qNmUCyqwpsPrQpER5SSbeHiU2S+TqVCMz0tZ2xHtdJAfk7iCQNYs
 2qwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLKX88p1EXFCmNOLKtZOHamWIEMk6CTQg1y8visiaaA/25Di8S/9zrh/F5aowSycORyVBZkrJ2cZ3R@nongnu.org
X-Gm-Message-State: AOJu0Yz//b4DiqdJIbyA5OxKiwqDwVSBhFmU3r2tKObO95Va2dQcTbpt
 79EOCVfIqGn+k3J9NXuiD0v+d/x3FYfLjYJRnHdNEv378hjPyVyxT1pVzzvoIpjabMn3YKW5vlT
 OcddUNnouPrMDhra0C3yARkmU/HRTaZx2h64TnZADRQ==
X-Gm-Gg: ASbGncuWvMNm06K+KzuZM2RzuXtYytbWhihOI22W+PVbYQsI8CKid5UqSjQKEz6YMPv
 zGrE+1p5nr4xd9SF3gLXR/GJhdZlUgnGsQEeuzsfQr3URnpUkUsbp0N0+ilkYi0crXOyic1AAMd
 /Bwo2fC8MWcHn+2fnNVD/5P8Mw9D5J8yoViD3sLp0kuLp6D57gRLBNZ8aTMv42c3wNj7t4s4XfT
 RC5skFEsOR/JMaWFfNjyj8EDtjSUHc=
X-Google-Smtp-Source: AGHT+IENHNrZVm/nujcMu06bFxnzR63nkyRDwK429nxQdtTtB7BqjmRozQL2J/1ya9dDcpdqEjXViinZyqhLPNUFNzM=
X-Received: by 2002:a53:a04d:0:b0:638:53e9:bab0 with SMTP id
 956f58d0204a3-63ccb8e0cc1mr17817376d50.24.1760446384784; Tue, 14 Oct 2025
 05:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250919115017.1536203-1-berrange@redhat.com>
 <20250919115017.1536203-15-berrange@redhat.com>
 <CAFEAcA8AE4AcF6VOAPmtNeJi1XRBXityX1mLPw6K9+++VW6EEw@mail.gmail.com>
 <f5e98585-6ad2-4e54-97db-0c4019380ee7@yandex-team.ru>
In-Reply-To: <f5e98585-6ad2-4e54-97db-0c4019380ee7@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 13:52:52 +0100
X-Gm-Features: AS18NWA0WbwVlzEf6vW7gFBN0arMQ9prFOdBPDocU7diZzAEujjcdBEZAnoQZz8
Message-ID: <CAFEAcA-z8F2aVx7cCqCoWCXJkD+onzGAvd1DiO=dVGKZoO7N8A@mail.gmail.com>
Subject: Re: [PULL 14/16] chardev: qemu_chr_open_fd(): add errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, 
 Fam Zheng <fam@euphon.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Weil <sw@weilnetz.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 22 Sept 2025 at 15:27, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 22.09.25 16:45, Peter Maydell wrote:
> > On Fri, 19 Sept 2025 at 12:55, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> >>
> >> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> >>
> >> Every caller already support errp, let's go further.
> >>
> >> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru=
>
> >> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> > Coverity reports a bug in this change (CID 1630444):
> >
> >
> >> diff --git a/chardev/char-file.c b/chardev/char-file.c
> >> index a9e8c5e0d7..89e9cb849c 100644
> >> --- a/chardev/char-file.c
> >> +++ b/chardev/char-file.c
> >> @@ -92,7 +92,11 @@ static void qmp_chardev_open_file(Chardev *chr,
> >>           }
> >>       }
> >>
> >> -    qemu_chr_open_fd(chr, in, out);
> >> +    if (!qemu_chr_open_fd(chr, in, out, errp)) {
> >> +        qemu_close(out);
> >> +        qemu_close(in);
> >
> > Here 'in' can be -1 (if there is only an output file
> > and no separate input file specified), so we can
> > try to close(-1). Suggested fix:
> >
> >           if (in >=3D 0) {
> >               qemu_close(in);
> >           }
>
> Agree. I'll send a patch.

Hi -- did you ever send a patch for this? (I was just looking
through our still-outstanding coverity issues and noticed this
one still there.)

thanks
-- PMM

