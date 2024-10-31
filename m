Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA2BD74959
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 13:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6UmL-0005p6-04; Thu, 31 Oct 2024 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6UmH-0005og-Mo
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:59:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6UmF-0002uo-OL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 08:59:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so1355513a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730379590; x=1730984390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cjV12eTgGM/W6VxKSYtL5Nw4UUw/HSAOYX1se12Zig=;
 b=qmJHJrCsnHRhWbgeVT6ReyJx0IpGG0Z6jjKd9iUfHWgYaxnJPi2ShtNyGd9uSjFVOA
 bCL1AionWfsF7YAnAmfMt+aQwu7Gizzc5Yg3aEWn1OqsZIn4DnwcGZkW8QJazywYOMFf
 3EL/CdD0xh4t3XRgIBmJ3HMguxg1vlJUvHCA4BycWomyvQ5UpgM3WOqwn/LBAK+jm/Dx
 e93s5x6rzeXIS2oehwZD4KLuv2S45Hah0xwFQL153q7uFRULIsYQR/IOkZQ1bQxuvprD
 rNOve8LC9ZaAvZoGiKRhjHK2F5PmLtBY09+Lw/1wU0c6++7REMSINUS/+EuPC6LppfHI
 FqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730379590; x=1730984390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+cjV12eTgGM/W6VxKSYtL5Nw4UUw/HSAOYX1se12Zig=;
 b=Qm+aL7SbiiTHPH+/E8Lq3qicVLcRA5QbklqmEIeNt/0Fx2c0A+JtepoZLjRRBZ6gI1
 l35qOB++5rExiyAQt6FppYHYYozhJnUI+zXFQVw+Iy7UC+szdB+N9kWU9J1UhZuJXH0b
 fBQmB7gEeXL0n0qqjgkqKPLJwqj8WD4TRqULKJAZR6SAVev/Bpi1BN+7TRoN4sIdR9SK
 +q8GznuQvg3BNobZEZpJri3DA6KTII8AJ2bxfxo7vC1IGxv2wandjzEtVW4gVPcuqhbM
 27iixjSyayYNbWBmBi+PvD9bBmGNQiNC6fILPjsWvzwA77AKj/hNtIWlb9zbg8hbfmAC
 kQ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/M0zQEVf6YvKkI5C0wm/Q5RVCv7OEB0ejx1rPp7hdZpo7KRbBsfzEOxKY7nOYb7lpAoMYcq3qeNz9@nongnu.org
X-Gm-Message-State: AOJu0YwBftIF0cM9rK5EEh8sSr4dzxKB+2SnA6GqvVPF0jnPRU4aP4xF
 xRXv/J/bltqGmi+tPRARKcgI0wtRJEIOv2Xq97ubD1FNu3f4ykjI8A8AXNOWfJGfS9E11FnTQUP
 r4x+REoqr80ZXIRBCxSdqEjJrl54RHCNvHcN5qA==
X-Google-Smtp-Source: AGHT+IERALXckroa9H9wtBfFLwXEcQL525RIETUMpbqoyMAnjF9yZNCHsaFTftdbxaN4KRPpPN9q1vw89+BTyseQZR0=
X-Received: by 2002:a05:6402:4022:b0:5c9:816e:45d with SMTP id
 4fb4d7f45d1cf-5cbbf8ca1aamr19516036a12.17.1730379589860; Thu, 31 Oct 2024
 05:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com> <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com>
 <87y128nrfr.fsf@redhat.com> <Zx-3OUioG1l47hW3@redhat.com>
 <87plnknqco.fsf@redhat.com> <ZyN3A6dAEDkx51yb@pinwheel>
In-Reply-To: <ZyN3A6dAEDkx51yb@pinwheel>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 12:59:38 +0000
Message-ID: <CAFEAcA_1R+xf-nBKCM7JDuNj7sLCA4KUjen6kPAng+1yjwHRrw@mail.gmail.com>
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 31 Oct 2024 at 12:24, Kashyap Chamarthy <kchamart@redhat.com> wrote=
:
>
> On Mon, Oct 28, 2024 at 05:29:11PM +0100, Cornelia Huck wrote:
> > On Mon, Oct 28 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrot=
e:
>
> [...]
>
> > >> We could consolidate that to the current "host" model, once we figur=
e
> > >> out how to handle the currently already existing properties. Models
> > >> based on the different architecture extensions would probably be mor=
e
> > >> useable in the long run; maybe "custom" has a place for testing.
> > >
> > > If you can set the features against "host", then any testing could
> > > be done with "host" surely, making 'custom' pointless ?
> >
> > We might differentiate between "do some consistency checks" and "allow
> > a completely weird wolpertinger"; if we agree that we don't need it,
> > then we surely could drop it again.
>
> Yeah, FWIW, I agree that it's best to drop "custom" if all the
> meaningful tests can be handled by being able to add/remove CPU flags
> from `-cpu host`.
>
>
> Related: I don't see any mention of `-cpu max` here.  Is it not
> relevant?  It is currently defined as: "enables all features supported
> by the accelerator in the current host".  Does it make sense for `max`
> to allow disabling features?  Or is the idea that, why would you choose
> `-cpu max` if you want to disable features?

Ideally, disabling features would work with any '-cpu' option
(including our existing TCG CPUs). (The main reason for 'max'
is as an option that works whether you're using TCG or KVM.)

-- PMM

