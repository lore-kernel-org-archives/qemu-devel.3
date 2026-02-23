Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B68AE98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSWh-0003oA-Np; Mon, 23 Feb 2026 04:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vuSWg-0003o0-Fo
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vuSWe-0006nQ-84
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ox/IPWGrKCa7N0rSHx+auK9BIiVxLmC2hSVQmQoi+LU=;
 b=Y50FySP1fZJu3pn/3wExt7gxvPKbYNa5YoLmGdthY8zqw4k0A7QwWcPTTWhn3Kz1ytHkSr
 jAaOcunSFv4zmFUcCmOuAozKS9wW3l4Hhtq54TlpSNEg1rQtfMGyGUieOMKQ7vFUOimSfR
 1zXzW/ENGER1ccEAU3+Xj3EaD1kuO6U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442--pdr3DIxN8-wAu-zIcSMCg-1; Mon, 23 Feb 2026 04:46:44 -0500
X-MC-Unique: -pdr3DIxN8-wAu-zIcSMCg-1
X-Mimecast-MFC-AGG-ID: -pdr3DIxN8-wAu-zIcSMCg_1771840003
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a8fc061ce1so348692155ad.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840003; cv=none;
 d=google.com; s=arc-20240605;
 b=jaoBzE1hqbTh0kJivGRg8J0FckgkWXW1/XlNfYROHC9H9au3ZP0iX+nKog0TPdtZbX
 NFg/pLc2+Uq+C32CoXQ2mFZYitaM8QlCfqDp50IDCIpOH7OZgHnkqILo1Tw9N7vMxHQt
 ys2W6YfUEGt+ykShO+DJYJtxsrPVyyeC/iPbF3vmbVPzG4ImEM2kQsnI7PGzCmZlRQHX
 CdpuvWdPYXC1Cl18nCpjyJ8mpmWhp+Apb8dau5SXu4bUAKLRQUptl2AYftWTbxWVHdbe
 XwimiuddRiB4Slqgy52YPErGqScYlZa6rbtPgGgcvgycnXTX7ysi1GVLfNgP+7IKr2z/
 yYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ox/IPWGrKCa7N0rSHx+auK9BIiVxLmC2hSVQmQoi+LU=;
 fh=HHMqO+ZOB2uMZktPXMWI+I2L7a0GwjV5KKUEbCTM83w=;
 b=ibUpS2N0Rz3UJz6mrAQaMRn3gudbD/3nRaiCx8QcKMwkMuRiFGHJXVNPAPkd6VFLvG
 a4q4xyuWoRRrmCjtL4WLu5YhCQbdk4rMGAlZh63XWDiPnbbbIF1tpjTFvyS1LmzSmHct
 Vuc8N0G5kXakXGWsZesvk8n4WXXuBIeSSYC6bZ49HEf0FW7iOYV9DfSsScG5AtGkG3TY
 O3cdRoj6YfIfSYLwj7NefoXF3SKeZD05iWXTlkrrTc+L7wTehUVOUTHD8xazIXIX6/m+
 DHc9Uo/6UURQC0hNDB9LFIM7mVht1+O6a2ZF68/DLfCwPhPdY6UHgnyZp9XZo/+Wwjv5
 FWXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771840003; x=1772444803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox/IPWGrKCa7N0rSHx+auK9BIiVxLmC2hSVQmQoi+LU=;
 b=BX6wAhihKQyxh4o8lwTThG8FCH1+36QtX+q7rBYw2zauKHc5TJFEBN7Z5XLXKNIPx9
 g5+K6Q6vSMYHcC55zZIcgXJTXwunmcF2hzpT0qCqitbQj0IHnsWUf3GtiBFjeRixjew9
 ceMnCwaJD4lyKsEppxB19Te6JSOnZqGq3tO1sxstUI7gmDdURF65qa0c/2msBBveD5gG
 s3r5kmPFmJpm+LQEtF/n8+8RXXCiFcFvOC4mtcZSmUYSOuoWGYiFQ56zHDoqCI/nFeRL
 Tnt67llTOzwwE1fTNIXmtJ4T6RlCK4FMxVNTCaxqfkxwD8AMYb8OCI/JWg+sy6an4tCw
 3AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771840003; x=1772444803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ox/IPWGrKCa7N0rSHx+auK9BIiVxLmC2hSVQmQoi+LU=;
 b=iY+E3bL5dIOx6SVm3Vm5TzomVVOejVI6abvFYB5zV2t0D3wR43W2XhNT/oH5mF8zPK
 JC8WNDBvMXJ2HhZunZ2gN4Z/HH9GYF4Aup7GzCumNtmqymKWLsUraP+8qA2j2+CGMFLe
 cXFMEGSHisS7Bh8K67MR9+DcTz0HUTECSyJKK8znk4JKXhIz7dQj3Guq4UNCbLsYe6+/
 WJb5RcK5zNGfO8HiDL/n52+NFz0VUokjH5OibsN1gfRhNvxxLV5kOxAyLfodmnl61rfD
 repUR0Zd3BZU7N3JdmtUjnwyQAglskhhCBgDAilLs8dkBxVdiV2aH65sKvzwc5HT2z1c
 iYHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ2nVIxjaXFYe0PiKT46J3KyoA7k+Hyp8bbTiZu9N90u5N/o1fTsTYFEaUjQahz9N4Vbl8ojx0ngMA@nongnu.org
X-Gm-Message-State: AOJu0YzA8qmQcaFAkNnBeluvnNvz7TQlRYG3PGIC2iiDYBrRx64J+qCL
 ls0FfaYJQAFxBdZh3Jd/u4N+bcMxGIqJna3jgIKqAHMN+hXOZ1CuPMc1WOIr4xzocyxw0vWoIwT
 qKgvbzliUQHJ/lCYDynWk82UA+mjO3JtdB4p0Oo+lka7JZf49PTRR9gqb/kBj4W7/MCiX6+Lv6q
 X3AMLfMD+ruJq2j9TvDbSx2mSHP4hLCxg=
X-Gm-Gg: ATEYQzzKhAivE9QX3zgpI6OndVo6BfYsomuY2DzO+hlqxddncGaE/InEqputOQ5ROOB
 Ge3eolO9bUIeTvXPKQEYvR5ZGmzIAbaFIXA7VgvXyKDOrHTYqPrEAJiXOhH2ALxi/qqVCkDqgTN
 qaCu0Cf7F6wjtCWe5G158/MMungDaiE+1XWBHLsw4K3Nd6qrt5p2YVH+qo3/4WlWWYXjIzbNDTg
 AHf0PUoHEKtjFBCPZfF7lfihFlErkbs9dg49g==
X-Received: by 2002:a17:903:3545:b0:2aa:d333:ce86 with SMTP id
 d9443c01a7336-2ad743e297amr72107415ad.6.1771840003310; 
 Mon, 23 Feb 2026 01:46:43 -0800 (PST)
X-Received: by 2002:a17:903:3545:b0:2aa:d333:ce86 with SMTP id
 d9443c01a7336-2ad743e297amr72107235ad.6.1771840002937; Mon, 23 Feb 2026
 01:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
 <CAFEAcA-Gg5pJW=SYV0xQX7tBz8XwVJT0pUbnJqwoBzhZ4Fwx+g@mail.gmail.com>
 <CAMxuvazA6Cay33qNT=Y9jN+TgxSTkKZdNfSORkQBG=Nr_0ok9Q@mail.gmail.com>
 <CAMxuvawjL=OV=doW5jqRBTBRhcF5DARUtgCN9hj4nyox_051Tg@mail.gmail.com>
 <CAFEAcA8dCFY3FfreEAMAMJsU=7dqGV0DzrAqMVBrD-wkuGkxvQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8dCFY3FfreEAMAMJsU=7dqGV0DzrAqMVBrD-wkuGkxvQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Feb 2026 10:46:31 +0100
X-Gm-Features: AaiRm53-r8nRbFlDn0oQ8mcVhy0yWsx_9sIyw7n1IdHUsADZsBGgPh_y72K0C5M
Message-ID: <CAMxuvawm_6D4DOLWRDwyVRMCMJRoEvLXo9YQLn=NHbHNqXazWQ@mail.gmail.com>
Subject: Re: [PULL 00/85] Audio patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Benn=C3=A9e=2C_Alex?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 19, 2026 at 11:26=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> > +# EVENT_AUDIO_IN has changed
> > +v13_event_table =3D v12_event_table
> > +
> >  def parse_arguments():
> >      "Grab arguments for script"
> >      parser =3D argparse.ArgumentParser()
> > @@ -413,7 +416,10 @@ def decode_file(filename):
> >      # see REPLAY_VERSION
> >      print("HEADER: version 0x%x" % (version))
> >
> > -    if version =3D=3D 0xe0200c:
> > +    if version =3D=3D 0xe0200d:
> > +        event_decode_table =3D v13_event_table
> > +        replay_state.checkpoint_start =3D 30
> > +    elif version =3D=3D 0xe0200c:
> >
>
> Yes, you'll need to resubmit, because I can't edit signed tags.
>
> Also, ideally somebody who understands the replay tests should
> review that fix.
>

No comments so far, I am sending v2.

thanks


