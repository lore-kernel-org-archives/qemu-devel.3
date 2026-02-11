Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC136E9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqBpN-0005yL-0y; Wed, 11 Feb 2026 10:08:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqBpL-0005xi-Gt
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:08:27 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqBpJ-0002P8-FT
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:08:27 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-790884840baso65824627b3.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:08:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770822504; cv=none;
 d=google.com; s=arc-20240605;
 b=B7ZVJewta985k9f+WTh4PzAYPaDmL12RFw0KMKwiQezvPAtIWApRPWGNl19FsFQTWR
 Eo2bSxZcsCZq/A2K+Md1GV7HjcdCoQQuEHZUz3OHTU8KPvWMEuvkn/i+D2RR2EYAB9g6
 ROkOlVz0HTb2ZXEkUT6SoV+qDzpb2fXLF8VBjMH2WsSYzIPtOBMe/X1WpgKg8G72d5sF
 k6mGWULgCnGsDnVVjBiZdJMqCwUoRCvAmGKIULxc7zykox8YwJhZLaXzoR9BL89JwopU
 Q1WVpLUCKlFAR+N+5JAgksIiViGiK0MKq3Qriz7dac0eZYAdc9p8GAVJewXj8hyppSts
 WjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tAXeJuNXG/11xoILElsy8mgQo4sn6X2VMcX2eWXK9ds=;
 fh=toxUVulOumXxZMZvd0F2NPPxWviGYV6MnOMM8/NoKV0=;
 b=Mr/4WQVXNIAQ6YskMuNDEnHjJk1b0s6rSNMG76MKkTvEh9P3foxqVKBUncmTQmViij
 BKHtw4WWBeAMgx+RAhfKi9GrOmAWXEVdAWFKa0j0cKMxT13yK2mQJPP/pkOFnOn0uoRh
 QZoBsB06sotEBTg9GftLXqcObBqnYlHpu9v+H7zjfu9K8TLgML6FfbCPW/MCiJKwEecb
 Nh9X3L3amp/YPLyP4ee0RwpmIwv03F14NCQVLjaD+nspcan4ktiOBwZ2J4iNMvndC6vt
 1mX6zThMWvwJeyn39W0r3RBn5LyXr366e1TXsgW7q6IwWf/tVYXyndYv4VU6PptcRYcS
 96rQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770822504; x=1771427304; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAXeJuNXG/11xoILElsy8mgQo4sn6X2VMcX2eWXK9ds=;
 b=xQKijsx5dorTye5uFKvXCWAa1Tyh7eNNOI/QKUZFs2c+pk/yHTggYCvyOX9uy/f5FM
 GVpnhLUEvRKnKuxf0D9a5qNP8CC0lbkhi8yGuSPyQn6erPLBXIYPBUzxcuSJ4WPWDNei
 CrMXnbjGX6qO8uJ07vHlwbS2L/Ez8EhlQN6c8kNmBxefHg5MBMaowY1ohgGe4SeLoNhZ
 ANwuewN8EhXtAYVUJD3BM3hwZl55+L25s15onz7uE2BwsbEzD9YgPKqHwcMu2CDSvDxg
 +Bv8L9xQSzzVktaVzku3yYbHekt/wtACulwmYF15yZtWNn68foggoOp2X5seliDMlhaX
 Aw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770822504; x=1771427304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tAXeJuNXG/11xoILElsy8mgQo4sn6X2VMcX2eWXK9ds=;
 b=FFaPItz1QWE0mIn+RacihoDR19P/Prb+ZC7pavkX1c2vZxrvYI8KpFxeMS0m4+3pWt
 6v0k1TSJwszK/pDteGq6UVy7AR+z5OFl/c95E1i2Yz3dOeU5ew9ymrpvGMA3xYcaNx0w
 +cz5QVw6ifosV4DdEU1UWIlgT7XrMemrL3Rtkokk8SMiFuI4V/2lfioAgAYcgklcCuny
 639qvoqdcOrEasOf8nWYbhBFEBuK6hlaiQw0M5oTSYTAw/hFWnQVeoN1eedZ/Ze7NDEQ
 n65Q261mZpMmiVVOnLSeYFUxm8viIkTSrjtwvgVO3P/li3L5accy9LDg+mxOeHSy/BvX
 eC0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0sCBbpMyCffTQiy7hPcIdM5k3BbRzsRkDjPnvvD5e5plHNbDZXvsBYNH1Aa0SWgSk/YkAeO9R1w7B@nongnu.org
X-Gm-Message-State: AOJu0Ywsj/hIybtAxnBcGGgFyoR077CN4CYTvQXiZKcCvbf/lbvafTdb
 QsSdhbu/B0HIIF8t2sW5JD27i4laOVMnC/3RLdWZJranAWQG9qv3B1epEBPqsM2YxROtbbB2H1x
 7/Sg0OLgxjeFGWTyYVVJ3vmRWc+rNc0DcMVp6tea1DQ==
X-Gm-Gg: AZuq6aLPKpe1jtBUhheEgxtAmpSmpFRPkRbgbjn3BIfKEV+F5SuWb3fBKqYAZ5olLEn
 nEWsD2JFBtW+QcZ6Ik8tKo2wTGH92pouOfNFFwoUAyRHJikDk/WrTV7dqmyF32stz84Y2aMdcT2
 SZf+AqdiJV/4t7SevwOKrunOZrCopMh5HWHmJ2QTukooLFYQbj996gqiZtXLKP5ZLSro2w8kkxa
 TRNZ3xxHzdI1CBoGw+F5oL8AovW0CJvuEzJRkad9Dwt0uKmyVYRfdEgWEYvXIYl996n//VirMq8
 KWSg5+QCW7gL/NjYbiJcnAVYXxGowJOaJpO2SJkEDMrQIEevgBIgWPU4+a/Ws3o/IeA=
X-Received: by 2002:a05:690c:81:b0:796:3079:ae1 with SMTP id
 00721157ae682-7965f047e7dmr50246597b3.50.1770822503777; Wed, 11 Feb 2026
 07:08:23 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
 <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
In-Reply-To: <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Feb 2026 15:08:12 +0000
X-Gm-Features: AZwV_Qh6dt1x2qdmkCqGtAVWpZdbnYac3r-RYhT486zdThNz_e-q9H-ltOpXhxU
Message-ID: <CAFEAcA8qtxXP0Uawc+UdSYmpuC8wmpSVkjnYQ_jDQe6zTuNWpA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 alex.bennee@linaro.org, philmd@linaro.org, cohuck@redhat.com, 
 eric.auger@redhat.com, sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 11 Feb 2026 at 12:50, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 11. Feb 2026, at 13:27, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> > tables even when no backend is attached. This causes "Unknown
> > devices" (ACPI\LNRO0005) to appear in Device Manager.

Is that a problem? There's a device there, and Windows doesn't
support it, so it reports that there's a device there that
it doesn't support, which seems reasonable enough.

> >
> > Until Windows fixes that by supporting, adding a new machine
> > property 'virtio-transports' to control the number of
> > virtio-mmio transports instantiated. The default remains
> > NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> > Setting it to 0 allows users to disable virtio-mmio entirely.
> >
> > Usage: -machine virt,virtio-transports=3D0
>
> Hello,
>
> With keeping in mind that this was documented in this (closed=E2=80=A6) i=
ssue
> https://github.com/virtio-win/kvm-guest-drivers-windows/issues/595
>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> > +    if (transports > NUM_VIRTIO_TRANSPORTS) {
> > +        error_setg(errp, "virtio-transports must not exceed %d",
> > +                   NUM_VIRTIO_TRANSPORTS);
> Any particular reason to (keep) capping the maximum to 16?
>
> From a cursory look, base_memmap seems to have room for plenty more.

My first question to anybody wanting more than 32 here would be
"why are you not using virtio-pci" ? The whole virtio-mmio infra
in the virt board is only here because at the time we had no PCI
support.

The advantage of this series to me is that it means we have
a way for users to say "I'm not using this functionality,
just turn it off completely" which lets them reduce the
security surface a little.

The other thing worth checking is whether we're correctly
following the ACPI spec in exposing virtio-transports with
nothing plugged into them, or if we're supposed to be
suppressing them.

thanks
-- PMM

