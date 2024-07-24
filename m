Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54891C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbAI-0006Gp-U8; Wed, 24 Jul 2024 08:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWbA6-0005Xx-Gj
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:32:08 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWbA4-0002sG-Er
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:32:05 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef32fea28dso33012311fa.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721824322; x=1722429122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPAMhbit1B/V9vaKOQX1Yb2zF6e6S3tju5TN0jGrNiU=;
 b=dPO4hYH5OaPWCJQ+OZ5NLmogO5ahVpcukytEjwB4lhyghjerKR2yuJN2CJRnQSwtFM
 IxYCqVjuUCWF6NaGkqb/9IveAErlfbLCWpiO5rLcpN3/yKiPmkLT+PsLfpKjdSGvFfiB
 nuZz5UfWQMSsxTOXOlSK12DGrUmAZHVQN/9UhDJiox7hjkpWT6mLmFfJbecYZmzAl1GA
 AvMV/SSEmUrVYUd5A3JR3nX5TEoGIieU6s3KbqbUv6JbSf59RVZr9L3odhZob/XdZ1Ti
 OiK14addCd7NW0N363VY8BdXVEOsE+zDjYkdeAbgsgZxyGtqi9HcuCz4PVomj0AuXUV/
 A20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721824322; x=1722429122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPAMhbit1B/V9vaKOQX1Yb2zF6e6S3tju5TN0jGrNiU=;
 b=qt3rhRZ4nZoTrLvIdf5c54UxXUaifK7aTphrLmJRsjiFQngmfnXpP69xeaobQncnXT
 /c+0N6jiYlq/ZCKIGgKDs8HhXYNZVVBdbm+ohvogkHbpH4OdRpqhy2ZOWCXFj9LFe6Dr
 mmSfJdnJkajh0q5PN2aD0TSzXofgXK9o2u6Sglrt+Ykhw5hYkUbn2PpzkBXJAn7jWkE0
 jijlw5vTgDp5Hi6/vIofJHUujIhMYT8J6CuFSX3ZtbObvLQ8BtWxtpfgRhDiP0JcIlLC
 bVD7rZiTmvv/YoeNDfvBP07efHLY+IIfjhFSs8fHRf9L3iLVYo4eOLUYy5H1y5iUl7vW
 RJeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvwAOy16dHg4wnAS0toMzH9OxKDAlCh6ZK5RaU4DmePcPQ32obITXRhGGghzzZKz0c/dPZfllei3xZo1so6+AoQp9srm0=
X-Gm-Message-State: AOJu0YzIHaU6eaiYU3TnfaqE/8trWwKwUqSvrDo/CLB9WGueZ+MdH2sK
 S+Qm2khHJQbzDJxo7ppkiQJmvO8q1sKMR+xK076x3cj4LfEPCR6DcOU6gnn574yfp+xwPzvyrK+
 YI7nndqZhUMA1SI76EK8GxnvnPutp3WtYgkkWvg==
X-Google-Smtp-Source: AGHT+IFCeVDXObHmqK7oJ3Z7gYfh/XKxXFusZ6aYGOYULNSRreYvQ8dFVVz/GmHpTjd4ty9E8yqVqEZo1wKdYZh0GiQ=
X-Received: by 2002:a05:651c:11d1:b0:2ef:2b36:933f with SMTP id
 38308e7fff4ca-2f0324ec08dmr12495901fa.14.1721824321907; Wed, 24 Jul 2024
 05:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
 <20240723131029.1159908-3-peter.maydell@linaro.org>
 <a8291990-e161-4a43-a1c9-69040f1f6f93@linaro.org>
In-Reply-To: <a8291990-e161-4a43-a1c9-69040f1f6f93@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jul 2024 13:31:50 +0100
Message-ID: <CAFEAcA8GPPy4P330P8kgbCxf=S+f8WGmB6tnAHN5bXxxyN9U=A@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/misc/bcm2835_property: Avoid overflow in OTP
 access properties
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 24 Jul 2024 at 08:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 23/7/24 15:10, Peter Maydell wrote:
> > Coverity points out that in our handling of the property
> > RPI_FWREQ_SET_CUSTOMER_OTP we have a potential overflow.  This
> > happens because we read start_num and number from the guest as
> > unsigned 32 bit integers, but then the variable 'n' we use as a loop
> > counter as we iterate from start_num to start_num + number is only an
> > "int".  That means that if the guest passes us a very large start_num
> > we will interpret it as negative.  This will result in an assertion
> > failure inside bcm2835_otp_set_row(), which checks that we didn't
> > pass it an invalid row number.
> >
> > A similar issue applies to all the properties for accessing OTP rows
> > where we are iterating through with a start and length read from the
> > guest.
> >
> > Use uint32_t for the loop counter to avoid this problem. Because in
> > all cases 'n' is only used as a loop counter, we can do this as
> > part of the for(), restricting its scope to exactly where we need it.
> >
> > Resolves: Coverity CID 1549401
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > ---
> >   hw/misc/bcm2835_property.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> > index e28fdca9846..7eb623b4e90 100644
> > --- a/hw/misc/bcm2835_property.c
> > +++ b/hw/misc/bcm2835_property.c
> > @@ -30,7 +30,6 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
> >       uint32_t tot_len;
> >       size_t resplen;
> >       uint32_t tmp;
> > -    int n;
> >       uint32_t start_num, number, otp_row;
> >
> >       /*
> > @@ -337,7 +336,7 @@ static void bcm2835_property_mbox_push(BCM2835Prope=
rtyState *s, uint32_t value)
> >
> >               resplen =3D 8 + 4 * number;
> >
> > -            for (n =3D start_num; n < start_num + number &&
> > +            for (uint32_t n =3D start_num; n < start_num + number &&
> >                    n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
>
> I find not making the counter size explicit and use 'unsigned'
> simpler, since using 32-bit in particular doesn't bring much here.
> Is there a reason I'm missing?

I just wanted to match the types between n and start_num and
number (where the latter two should be uint32_t because we load
them from the guest as 32-bit values). Otherwise we're relying
on "unsigned" being at least 32 bit -- it is, but if we need
it to be 32 bit then why not use the type that is guaranteed
and says specifically that it's 32 bits ?

thanks
-- PMM

