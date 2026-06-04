Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3FDCD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVEmP-0008LB-CS; Thu, 04 Jun 2026 16:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wVEmM-0008Kp-MA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:35:02 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wVEmK-0004qO-Hk
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:35:02 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-304df7ff4c2so1519395eec.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 13:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780605298; cv=none;
 d=google.com; s=arc-20240605;
 b=IsZpu2QSoHxfg6E1vXC+C6fUfhr0TsFbVATj/6prWQ6iYJjKi65wMulrhM8Rw6VMFx
 w2Jft5awxIkOCNFvVrCLn7BEaKh7nZGygyClKuc9+M1ghtSzxP5ErdsSav6XpzVOc0cg
 TKKFu0vHLQQnZh86rqesU+fcWwpDIX4QCL+4BJR0AWN2Q0Io3zm9X24UPOdGDkNxYxWx
 Z4uppoyRn2IP2iMEFLu0Ieh0vduwyiZlX7WLuJ9mgrr/ejmHa4+BL3SV4lQPvVyvsei0
 uJlGhaUeE7LFnV99aHfSVipRTGcfJaDBCaOgEyztlyzNryYF83cfSo3nvYPiAw4xla3D
 hQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+Pnnyuvc+WrBOYVMH6+QU7RDj/KbKgdJjMUeRerhWIw=;
 fh=2AXKKvs6UPMWapHrr90pEv7S+1yePIF3Y2IBZ3MMSHo=;
 b=KuEb09fwqe76Y69CU87HEWDcSaUP/bId7ed1H8IviXgvdtfo4B23SxN374gcOhtX+y
 WHQ6O6fp/zDAVRdmXCYaThnxewTM+joPWrW8XvOcDiCLiWHWb9ldL3/OnqcZYf+ij2BS
 7f6ugKq5KF8IeNL617KWKLt31syA2hMmLLUD/fI1GLYxPtq+1xRo/nyB45rO34wMwrJ3
 nIW3T+WEtYY/b9cLpXwtgzTkwe+OAVnNUkWqKdm21RGMypNWqKBhUShE7ZM5eVoKWmyS
 RhVCN2xfDIFpd3rWMVHncPPWklZ3WvcWm58yZ6UHFEr4YWGaCV+MY7IBXVv8GI2AOL+S
 d7dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780605298; x=1781210098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Pnnyuvc+WrBOYVMH6+QU7RDj/KbKgdJjMUeRerhWIw=;
 b=bdCmy2HPEI2pyKqXuU60ESef9luFiFH1oOmla9Ud2ZE0ynHFIpwg8huno2va7wc5X5
 jfRSO8qysg3PgXUF9rHcfOn3gPEWCnUThEbTPNUAIRjlebASD+DbncFy5EwMdrV7R+dA
 GiKys4uvbb8x1Q/ks/wlJ0NKvnO3Tdy72YM/JGbhfRlGR1HkdzUpZjGKHlI7eXoEvHDT
 uDv7cFWECGOxYhrPbYC5UmeHj2LJtpxkyA9bNB0z8JSBDo/kk0smvBg9iftGurPfw8Xf
 KEWzJj9uo8jLtvb7s8GYhnDjxlQbgrOfFP77dmT9b/J1cVKAH/9S0AJ8wcjS20Ohg+br
 zpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780605298; x=1781210098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Pnnyuvc+WrBOYVMH6+QU7RDj/KbKgdJjMUeRerhWIw=;
 b=fTakhpqL94HHLI9kR3IPiLVUa/OwvPK/PaIprg8q5niL4sgriyojW9Xc3nTZxB+vIY
 LfK9J5tHxzFbqs+3XtE3E1ReHVosOaiqQUF/mpfLHVdLU4IyyxJff06JqDkd6kw/lvCe
 9ZiBZmhccjH6rxlS6sOXafD2Tp8jmJVjXuzljWuXxcfQJ51q1dTM7aGeo7HFkBEbJsSO
 affxHYhNzossvj0kj0y5Geb+I9ZNaNYCsi1jNuApnMt1QowAjqqHnHcl9ZShrNwQNiN6
 bCMKXltXGSYMl6Ob0q1gNal4YwFdxF7sotTqd9PzkI7Ai9pIH5D1eA0/lECYepWihs3o
 Bnaw==
X-Gm-Message-State: AOJu0YxJne5SaduXZtqLEQUIIajb75rGqE/7K4ZgSoTwJP+iGpEpY8qw
 XeVpKjtrrp2NmDjS185LJHtlgfgjOn7Yzx5jag+jR37WpF15ETfCho1mXi6sdvabGfpjFc3kRaQ
 W6dW/btZzdnTRZn1B2rvWhUVlH2CNQ9w=
X-Gm-Gg: Acq92OHdQ9NNN/f+9qTuU9EQsBZgeHcOnTIcmq8JLEQ+8FToKOrmmU7TnNCv+NXBpYw
 PTLjb55Gqxkhc1X4G1KU17u14ATOJ5U3mUkK1Kt4ShKHBoZI3uhYTWqygDbcs5T/YZoOVipCTV1
 V3q6rdxeqcKGbHteu4ypISDYPjK4YWXfmpiNz4eOXGvx6IboSZYxLXOwS+YNv8CK7CY7lkage7q
 +fdZJlGcUvpooS0P1LJUIXBJe128a45W5DO5hF3SyrvzCb3M+ANPgdd+IpGmBbIArggkMqmvbyB
 qoMjYbl/4m7f60xSZhBLRiqkNi014ve6jbNcZP9FMjOEvd7OD/qkOiDnYf3L
X-Received: by 2002:a05:7300:6ca8:b0:304:ad0:e91 with SMTP id
 5a478bee46e88-3077c1019d1mr90179eec.4.1780605298324; Thu, 04 Jun 2026
 13:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-23-3f20c3a029a7@redhat.com>
 <aiGjfMQamilAzhDg@redhat.com>
In-Reply-To: <aiGjfMQamilAzhDg@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jun 2026 00:34:45 +0400
X-Gm-Features: AVVi8CdrwPisjfuaUe2duXIAIphOotYX0kS8hqrEIdkh6zQF37cw9L3vpQESqKM
Message-ID: <CAJ+F1C+dzi0Zc5p_vBNduV-X9vJx=jLgZ90m=nVwOT0j7TN9OQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] hw/i2c/pmbus: fix undefined behavior in
 pmbus_direct_mode2data
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Thu, Jun 4, 2026 at 8:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Sat, May 16, 2026 at 11:59:22AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > The intermediate result of (Y * 10^-R - b) / m can be negative when
> > the bias (b) is large and the raw register value is small (e.g. zero
> > on an uninitialized device). Assigning that negative double to uint32_t
> > is undefined behavior, caught by UBSan/clang.
> >
> > Use a double intermediate and clamp negative results to zero.
> >
> > Fixes: 3746d5c15e70 ("hw/i2c: add support for PMBus")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/i2c/pmbus_device.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
> > index 853dc4b4342..861f5b4fb63 100644
> > --- a/hw/i2c/pmbus_device.c
> > +++ b/hw/i2c/pmbus_device.c
> > @@ -23,8 +23,8 @@ uint16_t pmbus_data2direct_mode(PMBusCoefficients c, =
uint32_t value)
> >  uint32_t pmbus_direct_mode2data(PMBusCoefficients c, uint16_t value)
> >  {
> >      /* X =3D (Y * 10^-R - b) / m */
> > -    uint32_t x =3D (value / pow(10, c.R) - c.b) / c.m;
> > -    return x;
> > +    double x =3D (value / pow(10, c.R) - c.b) / c.m;
> > +    return (x > 0) ? (uint32_t)x : 0;
>
> Couldn't  'x' exceed  G_MAXUINT32 and thus truncate here which
> while not undefined would still seem undesirable ? If so, then
> perhaps
>
>   return (x > 0
>             ? (x < G_MAXUINT32 ? (uint32_t)x : G_MAXUINT32)
>             : 0);
>
> ?
>

Yes, applied.
thanks

> >  }
> >
> >  uint16_t pmbus_data2linear_mode(uint16_t value, int exp)
> >
> > --
> > 2.54.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

