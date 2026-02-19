Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31394E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt0eX-0002PS-ML; Thu, 19 Feb 2026 04:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vt0eM-0002Oz-OY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vt0eI-0008Qm-QC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771494520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uv98VHvlcIpqmPDx9IJSdDCUYPj2YlP8zoFkTQY0C0Q=;
 b=J7Qjobq6e+gDq2qwZn16YLYgb5CXtoIDL17ilOMy5TKvSspvSYQkSqqwugFEO0XPC/FqBN
 JIv1Y3bnfMvHUXfx+Hx50IGVFoq4Xc3Ru82H6eVp0zeKlkcEKPxljBH5peHoZzVwHFM48m
 L0bVl5xGixewBeQzGyvOiEegsTvQ6zo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-Rjhyydz8PCuBRi5z3ff2MQ-1; Thu, 19 Feb 2026 04:48:37 -0500
X-MC-Unique: Rjhyydz8PCuBRi5z3ff2MQ-1
X-Mimecast-MFC-AGG-ID: Rjhyydz8PCuBRi5z3ff2MQ_1771494517
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35620e2faf0so610986a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:48:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771494516; cv=none;
 d=google.com; s=arc-20240605;
 b=Odh8Vg1KSDGmVDcgGijWVzNCHMz6oOuH5Xw2uhG6yFst6LvWHxYWZoJDORa8N8XyOf
 woPYvBdBU9W4mkabZb0VjjIuSfc1OfyYH1ghwwb1B4KeF/OU2fGUR2S4yFUpRIhdthcw
 uVdBAINk5d0WuyaXbSc9d0B9YUEYiz8C+v8apEUPxzmGElL55oiltoJVljv3CO947UwI
 zQbDjrXuMtMBHX+pid3doyFUo9ZO2FbYVGLYtWpPYp4GwYmWOvuvFKMp/JoenGYCwxRD
 at3UIwmDl/Cnlgm24u+8SPKLgKVuYlcxM8AbqccWbtFMdkWCQO98CKbDC1Z0p/20H8Ce
 Lcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uv98VHvlcIpqmPDx9IJSdDCUYPj2YlP8zoFkTQY0C0Q=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=IOze5c4lTKtLj52fFt4W3zd2xovzZHTqk3/sAwn64JqdSqMgvfrwT3rei7Bg7Kk299
 zj8FyyD6b4zWbafUhBqQ2Qb3dUEeGMnGeBQaHIDrK+n0qC9yi1mxazOExnIzJmsAUYvL
 Y1vBdr5GuSFReSuXbKpwgMPzA+nEDBsFuWx581kC+B1xNoRmvhdDUiQdbZs9aWPpIkZu
 iRdj2b/xQjEWm5XS/1fCT69FoZ8kIrkyiyl53eMsnu+4V2PbMEFKgwJg37/zKOcW4tEf
 JTpP9L9GROcUOrVqjkYEsZStoVCecBhbYPHwWC6orxwAYfrUL9zPnRSAFpmK0K3J0UeU
 ZEdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771494516; x=1772099316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uv98VHvlcIpqmPDx9IJSdDCUYPj2YlP8zoFkTQY0C0Q=;
 b=JvtvGgydqjAtMGFbKbrQcdmN8U9fCVz6A4OyADn+67uuY1/DnsQHDydOF9csZmGUDW
 f/JV/fDLunMMnDEdyGcswNnIIECQFJGJ2yR7AAZCNaySLhztOHtaEQBI/+ktiGNeniqL
 L41k6fcTJmxHYq0DyXKzUZyzFg9rdjj1AQCpA6viTNONW/1vcJp+RxSZnmXoL3TVM+4r
 cOeFvMfm/HQF1t3OUoJ2GoqWrz0ttLe30nF9c7Oo1TXsjgFiav/k/aHCvZ8Ipqa3SA1s
 zhMJPc4mo71hYKVCArkaHeDwCyToTDEGdkg6rCPgUe9dw2UmoDMRQVc+EMZGR0MQmgiZ
 cmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771494516; x=1772099316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uv98VHvlcIpqmPDx9IJSdDCUYPj2YlP8zoFkTQY0C0Q=;
 b=QgWqf7CYgEYzLzBQoJNWAl+/CevDhOvKNEdOYOnr6Q/gzvVTWMZCErafu+0UGhurgg
 d0BdDNLLwhqyrlSu2vucSqRkGPy5DhhlK7KBWNvzsrViYIl80NUgeMzHB7errma+AddC
 zo7hwRr7wxSwxZiTCH5zVTR6zXER77FKJEZjS+a89A9/295nslnBzN63UrDah5cN0SGw
 T+IDnqJc0ep1zhK5G/QkupTzghINW1JLmhJOyppbDT+cY1CpXllhE1eyHO62udkT8osZ
 F6b2BNOUU8cqnNadc7Pip57MXm74g60wucFqOGUEJwQ4z/jdSa/eUbs1DAodt25+cPKW
 fYBA==
X-Gm-Message-State: AOJu0YxS/HpfEncRmPrG7OAZiSMpxUF9BwV/+s5K5WWV38JUqBzuKe2s
 KdF4xukuglWG3VBbyBYWLlr0gsQpliC9jLwCdAP9sZVCHR+UsRt8jr5m1AZvMjamY64nOBOw5vt
 4CKk6Jx8aPxWG+bf3BZ4KDK46W1QpVicdPSGxPpLl0OVvIIlioARg/r6DwkBuS6/wnaHzo0IDOX
 X/LjizW5/PKyikJqNv5Zc7rgQsTy6jjIfHe8nXvfhxqQ==
X-Gm-Gg: AZuq6aKG6hx7HpeDbOQV0PHie1WzVjFFuxRff4SgExPeIg9iM2b3pIuEXKlJgeiNI0O
 i06WZo03mCNveUAlqTALe/H4IT56AdrpgRiJNSQu/rpW5BpTC0uP9JxvmMIUeewsauqlnBfq7P5
 ycYWsekYlAv44HIgJkU9MVs8/jrJZf25nXZhfE67T2fgfEQf4CLmrgaby0brlVAQKaJpkLnfQNG
 bnh0DEElmg1tHUtz0NIVTM5wBDA9XTm6Na8S+k=
X-Received: by 2002:a17:90b:1a86:b0:353:38c8:b612 with SMTP id
 98e67ed59e1d1-356aabe68cbmr17975728a91.12.1771494516381; 
 Thu, 19 Feb 2026 01:48:36 -0800 (PST)
X-Received: by 2002:a17:90b:1a86:b0:353:38c8:b612 with SMTP id
 98e67ed59e1d1-356aabe68cbmr17975705a91.12.1771494515963; Thu, 19 Feb 2026
 01:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
 <CAFEAcA-Gg5pJW=SYV0xQX7tBz8XwVJT0pUbnJqwoBzhZ4Fwx+g@mail.gmail.com>
In-Reply-To: <CAFEAcA-Gg5pJW=SYV0xQX7tBz8XwVJT0pUbnJqwoBzhZ4Fwx+g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Feb 2026 10:48:24 +0100
X-Gm-Features: AaiRm516Td9-H4GOz0uGeE0X2VM2RAkRbi2nBJfQhPgBZAiJkr5-qIpjJi7Gxg8
Message-ID: <CAMxuvazA6Cay33qNT=Y9jN+TgxSTkKZdNfSORkQBG=Nr_0ok9Q@mail.gmail.com>
Subject: Re: [PULL 00/85] Audio patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 19, 2026 at 10:13=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Wed, 18 Feb 2026 at 09:03, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5b=
f580:
> >
> >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into stag=
ing (2026-02-13 10:30:08 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-request
> >
> > for you to fetch changes up to 671f6b05e8939f01621250446d6d9a71c7758254=
:
> >
> >   audio: fix leak of audio capture name (2026-02-18 09:56:43 +0100)
> >
> > ----------------------------------------------------------------
> > audio cleanups
> >
>
> Hi; something in here seems to be causing the replay tests
> in the functional-test suite to fail. I've tried retry on
> the jobs several times so it doesn't seem to be an
> intermittent or infrastructure thing. Examples:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/13179297572
> https://gitlab.com/qemu-project/qemu/-/jobs/13179297533
> https://gitlab.com/qemu-project/qemu/-/jobs/13179297557
>

Good catch, this is related to "replay: remove dependency on audio/",
changing the replay format.

I didn't realize there were scripts (scripts/replay-dump.py) checking
it (QEMU_CI=3D2 don't run those tests?).


