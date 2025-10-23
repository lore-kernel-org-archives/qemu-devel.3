Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5ECCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 15:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBx0H-0001FF-3W; Thu, 23 Oct 2025 11:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBx0F-0001Eq-AN
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vBx0D-0007rZ-Gu
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 11:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761232400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQ4+fpnuG9EWulUQP3aeTQ/dngQl7L66uHHFU3LQz50=;
 b=LcXMBt54a0zDlUMLPojspYIysMWsuw8WpDWNFuH89Ut8yUdjHqD5cYM5PTQfHVLvdzBlaP
 3vwtUxqA89qpvuhp/JBGaR3qeBeP78ssCDMJD+vmt7SMNwUa4ILrIBkKMHUoBguTD5+pBW
 X2Jpao4P8c6lSA4/+/ttnjMItJ6GTIo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-3UIJmMFnOdOiHNz9esG8rg-1; Thu, 23 Oct 2025 11:13:18 -0400
X-MC-Unique: 3UIJmMFnOdOiHNz9esG8rg-1
X-Mimecast-MFC-AGG-ID: 3UIJmMFnOdOiHNz9esG8rg_1761232397
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-783696f7bf7so23068777b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 08:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761232397; x=1761837197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQ4+fpnuG9EWulUQP3aeTQ/dngQl7L66uHHFU3LQz50=;
 b=Qf7MJtuMMtAqy0dO/h4DtyzsnAqjQPqB+jF88BfDyjd2yzRMlWOj28+cRBl9vQby1q
 gMWmOLUjgc8jI5yH5xE0915bG3fLwNQj8JBntLWy6ft8NaRApXluMQIZwyWyDqnKndXC
 QN1ZQAnscLDpuQrtlLtC23b/eLdcdvIiqmsQY3P8klVZdbp+ax9ydwHBFeOfcj3H5l+v
 KhHp6mbzYkJ/Qh9x7jk2mEMP7oc3Jd3rK4j0ZoV/z3SefEIICKJJDxKP8O/s+Q1IUIAe
 j3XCKU5FC63A0PLQO4ri6tnMR939ekOCnj6/jp6vs0FFa3p53MCftdVQPYgdcDNi7HSs
 ejSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/+J39/eTr9K+RfhC6BwwZL5NLJBmnH9+W6YSoe1IngwFa94f1LBewOE6RdUtCKwAdaCTVzqZ8LKMk@nongnu.org
X-Gm-Message-State: AOJu0YykB7fJtCw5P0uUiLFUxejGcZxue9jQ0Sf2H6d0J41k+xIZUtCk
 B55WzyzHoF+o21+M5ikZYdPncIR2Dxy6nkk7KiBDLQz6wDd+DmfotmOBMt17ZvU12tSiq+c77Gw
 gClKCLS+yPALfA7uxMTmbD6/DyK5ImjHZcA4vh3K5ShggIa8lv/eg8Jv87lrchuu7I3XSrrrzmS
 xWV/yUFpZKfjULIHTyLPHD/iH/Ok6o6pc=
X-Gm-Gg: ASbGncvzB3oVE+v2537R3iRT7dy9rUtbH5RmRkfDDM09fOKH4aZa+cpvpvzXV1vVadt
 +JlyLragIuljvGzjrnHCebarx4YrEKlqZRuyrGjxghe4UL4qzF+X/8W2yYvFDxj6jy/3GI5LK8D
 MmJAOTcHHytkbxbA3FdYz8ekn1iN7OwmHj3Jp5DncTLvnhDByCIrqBKWSN9iOdoEWgEL6Z5wTFv
 NjJOfia1lHvauw=
X-Received: by 2002:a05:690c:6e90:b0:783:d695:9506 with SMTP id
 00721157ae682-785c4cc1503mr48914627b3.33.1761232397202; 
 Thu, 23 Oct 2025 08:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwm6NRh6yBrvCSv42U5BOiUyhIjugZJSPFw++MzBDWpMNCJ7/buyD0CNSmwiKesP3RzQhkU4BhZR0pdIaS118=
X-Received: by 2002:a05:690c:6e90:b0:783:d695:9506 with SMTP id
 00721157ae682-785c4cc1503mr48914427b3.33.1761232396691; Thu, 23 Oct 2025
 08:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-4-thuth@redhat.com>
 <57dc76d3-2a2b-428b-a457-94dcd20cb427@linaro.org>
 <93275cfd-8083-4c75-81f2-46006ee42f00@redhat.com>
In-Reply-To: <93275cfd-8083-4c75-81f2-46006ee42f00@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 23 Oct 2025 11:13:05 -0400
X-Gm-Features: AS18NWBaFjMFImWYaUxU9lfH-asG5Jr_1PtvPxjJ2fjlyVWn8f7OFbX3mDLq22M
Message-ID: <CAFn=p-ZexDSq8AT-WFTK1XNR_zEuyTJ8AAzjL7GO5GF23pkr+g@mail.gmail.com>
Subject: Re: [PATCH 3/6] tests/functional: Fix problems in linuxkerenl.py
 reported by pylint
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 23, 2025 at 2:46=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 22/10/2025 21.14, Philippe Mathieu-Daud=C3=A9 wrote:
> > Typo "linuxkernel" in subject.
> >
> > On 15/10/25 11:54, Thomas Huth wrote:
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> Use proper indentation and lazy logging here.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   tests/functional/qemu_test/linuxkernel.py | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> >
> >> @@ -48,5 +48,5 @@ def check_http_download(self, filename, hashsum,
> >> guestport=3D8080,
> >>                   hl.update(chunk)
> >>           digest =3D hl.hexdigest()
> >> -        self.log.info(f'sha256sum of download is {digest}.')
> >> +        self.log.info('sha256sum of download is %s.', digest)
> >>           self.assertEqual(digest, hashsum)
> >
> > TBH I don't understand why 'lazy logging' is better than f-strings.
>
> If I got this right, it's about a small performance improvement: If the
> logging function decides that the log output could be dropped since the
> logging level does not match, there is no need to format the string in th=
at
> case.

Yeah, it just doesn't interpolate the strings until it actually goes
to log; and the logging API was established a long time before
f-strings existed. You can actually switch the logging format to use
{} style placeholders instead, but the issue with this (AFAIUI - I
have not actually researched this) is that all logging messages in the
running process need to be updated to match, so it's hard to dictate
this on a per-library basis.

Maybe you can change it per-logger, though, and it's fine. I am not really =
sure.

>
> But thinking about this, I guess that's not a valuable argument for the
> tests, since we're not calling these functions again and again, so the
> performance impact is negligible here. So fine for me if we ignore this
> warning from pylint. ... i.e. we might want to introduce a pylintrc file
> now, similar to what we have in scripts/qapi/pylintrc or
> tests/qemu-iotests/pylintrc already ?

So far, we don't suppress this warning anywhere that I am aware of. I
have adopted a "when in rome" approach and just follow the principle
of least surprise; i.e. "the defaults in pylint are probably the
default for a reason, may as well just follow along until and unless
there's a strong reason to switch"

That said, go ahead and ignore them if you'd like.

>
>   Thomas
>


