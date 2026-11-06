Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34796606A32F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HT/CW3Hv;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MV+HWadV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPL2x-0007R2-Tq; Fri, 06 Nov 2026 09:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xPL2k-0007PK-MA
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xPL2g-0000QK-JS
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 09:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793975745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEU1FFl9p8QKFt3KoXpoGyAibRKo7aP0DPJXAUN0p44=;
 b=HT/CW3HvLrBKjg0z285s1VOsNmvOGMNlqM7id3PtTfLp7PKK2BsZ7qpKG7ZwYS8plh5+zG
 afqit0YZe/W2zQpAG+r9uZVa6A7F7Wswz2K3UaVLdrI/9+xfLET9ShqY3T6qA0fJQcPcEY
 tWxxG901V2e8/JpuOtpkvz3tpM8ssXE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-XL6t_XiyPsCghbX8p5CztA-1; Fri, 06 Nov 2026 09:35:43 -0500
X-MC-Unique: XL6t_XiyPsCghbX8p5CztA-1
X-Mimecast-MFC-AGG-ID: XL6t_XiyPsCghbX8p5CztA_1793975741
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3adad90c894so884243a91.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 06:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793975741; cv=none;
 d=google.com; s=arc-20260327;
 b=sk6qhMf0NqHvOVkq861JgIfQGmZzhd1uSj+3pm7ULcZxg4Qw55Z/BfDBkTs/cIAfJZ
 fmcER68ZORgdpioPEgOa6SbdEiafJDtA/zNxLRpQQOkvRO36jUlwfYxJ5Ya3F73mItna
 SXsKDpVxxbQlLQFlqb2YfBkC56yxZA+MfOu7eFNgYPWkkK/Io7rnWsU94LQnEUyGpOIY
 ro+7rNabbkMnHpGMZThFaiyqz1LvphsjNipvUrC2HYeVnicSzQdjzplT1sJjCbWZHqXN
 b0L3naoLJC8tvrnAmWa2C3NQsvrRBtjezQnSnFpTM65BZaBL39K7sDM0c/5QwIJyEiGx
 /JOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OEU1FFl9p8QKFt3KoXpoGyAibRKo7aP0DPJXAUN0p44=;
 fh=7wW7r2Bp4MusRWudoMpNGh/YRv9yvKyXhrCXRQ3L/mI=;
 b=nZsQqUGrVDfCjb2hFZWQPYR9MyMRYiGjNHYoMq81ArSVrbUs67Vg4zzgBqbETxZV4R
 JE1pUNXmTwV5IIobAXniot9n8zixdEC1xIZOZQ1XKmz5ywuMFzjhvvc6oji6GkZNq8n7
 92yzU7NxeI3BN6anYZ9qAb2MBGZ8bvZI9UylYMQ4M7MGpKQ2RRWY95nxCW29bHUV6yPj
 KSmRHqI/oB2gUaFVShzeV8xFyc6jVIPozCFbK9XIek2PIHbqMoxHc0D3QOqHCxVekQvO
 awkMUplvSMRq9wh33ftmdX53oFUlgA5iDP/OlqIfqvmsPEh5o6/NGGp+YDb0GLlGvYKe
 mang==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793975741; x=1794580541; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OEU1FFl9p8QKFt3KoXpoGyAibRKo7aP0DPJXAUN0p44=;
 b=MV+HWadVK/w9Rt9xquVey8Uz9rDl60fGQAUA5nUb4GwAQZvo4IvThV8yfhb/A1drOr
 UAek8zbfpdhXuXV49rDThh1mRWvtArjrsAn/E8vI2gR0MpKQUrMspsS0oQEabEh68ajU
 DSBy+y1yjdjasOrVefY8c1Wq8ccLQ81joOCAU21UiGHc/x+IQGQ52z7ImtZMwdCEA/lK
 F6SsvS81b6ynl0v6bo5rmvPyArrbRJ6DS396OntI2ycNjcEoBa2TI5cY+Tlw4IU8+WFg
 o2QulvLZf0jlEU8B9Uh13Jso/Iw9M+QcNOAZIkDz6kQlCYQQhrf1CFft14h5oS8GawEc
 uIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975741; x=1794580541;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OEU1FFl9p8QKFt3KoXpoGyAibRKo7aP0DPJXAUN0p44=;
 b=DoYwzHs9tD7kCnHIp9/kdIf3nhr0hVDUa+01eCKjPP/QgisaAVax2b+60og8nNUEFq
 VqXUmzl042VyTsd5lqsnE5Wa6M1J5Iegvw/97/Ib1Ot51LuN7qmyDWD/wHqs4STpT7YL
 Ajk+LYCQ1lZxY4I0PJf4ybZ/qTbw3s8zv0DWW90PnA2Sn4pCl3hTXA7vLJVB4HQMa7Xy
 fLd04yN/SrO8oaPJSRJSieldlz1B5aIyB4AmPIVhl6AuYZ4leN2QLbFHwLI6J8uW4wf7
 O+oM1bNsq3URKg911usdGSTGIQpRJW/pf5wgaGMgzhYrLZ01shYC6VZ2pttNgOo1quCP
 ptkw==
X-Forwarded-Encrypted: i=1;
 AL+hErHX6+2nYXEkOQCLGWhCCR974oGW+E+HYbOeihrmbFhSOhLjsCKUW6LmqQXI5iAfPJFTN3+u8lGFNKbx@nongnu.org
X-Gm-Message-State: APuU4Z/2Xf5k2Do6Ko8pBEKKK9ZXn4+yETT3fN9L37oCMgn8cL7lUY3Q
 xGQPcu/AU/tEMxgIZsnt8P5w1rcjWgdE8aN+4K4NrG+u/VHohavS3aaqOGNNmIgFyH24Ngsaa1k
 OmwTGgTtWA1QNH92GD2BeAcO74GM9Sp7ip/UF/XEgpKMTkLVIISoTIduD56lUI189Kr38yFiafy
 HhhLrj2jJpPaxEBW3b7ibZrntymX3HugQ=
X-Gm-Gg: AYBFou2ra1XLIBrpm5hzBGC9zu5s5DFo2iOKAKTbGA7jYgFjNPyy7Tj/vzL05tD9lS1
 jDSBHQZ+soX4UUSDiq14ri2LTCGnvC/GiNamh8FNEDnXk8S6kawZXPPy+XOGb3IWyZow5T7Ub6z
 HhyAzwPZckCJe3huYaSrLISghNQD9Po+by+1TUAsm3cAgyHsjGMPoS4/4u0AyYPmH43/LShh18/
 IOiEfIQ3S5kEOJ1Gtm6hg4I4cKnnn32k8X0jVxUj3pN2cZYODvdRu/1PK2PtRFdHIMoOw7cUnfp
 Yw==
X-Received: by 2002:a17:90b:3804:b0:3ad:b7d1:8631 with SMTP id
 98e67ed59e1d1-3b0db6bb484mr2733933a91.17.1793975741367; 
 Fri, 06 Nov 2026 06:35:41 -0800 (PST)
X-Received: by 2002:a17:90b:3804:b0:3ad:b7d1:8631 with SMTP id
 98e67ed59e1d1-3b0db6bb484mr2733912a91.17.1793975740880; Fri, 06 Nov 2026
 06:35:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-5-berrange@redhat.com>
 <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
In-Reply-To: <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 6 Nov 2026 18:35:29 +0400
X-Gm-Features: AclHuK9FADW3osoyNv3LUIVQ7f8FSa2MdA_3foOulSE_SWW0ekbzYnV7KFEDPMc
Message-ID: <CAMxuvazfhfGSZCiSi+viwJ7f7XDWAZfjmW39n3a7a-qQyw-YSA@mail.gmail.com>
Subject: Re: [PATCH v2 04/28] hw: mark all remaining virtio object types as
 secure
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Fri, Nov 6, 2026 at 3:53=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 29/10/2026 14.12, Daniel P. Berrang=C3=A9 wrote:
> > These are all intended for use in a virtualization scenario and must
> > provide a security boundary.
> >
> > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

I have a second thought about this, I'd like to exclude all
gpu-accelerated paths for now. virgl/mesa/rutabaga expose a very large
attack surface, so I'd like to drop them from the secure boundary

thanks


