Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2023C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqKh-0001gg-CF; Thu, 09 Jul 2026 11:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whqKg-0001gR-0T
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:06:34 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whqKe-0001AM-Gn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:06:33 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66766d649fdso2769713d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783609591; cv=none;
 d=google.com; s=arc-20260327;
 b=CZSoWkRLeaLZVtae1mPYfteq+vvYQeEPx5UTLcJq27Eq6EVNvfcb0wpXub9Q7t8f/B
 TkCNwQU//2u3YUh79zujj1JkjHPEXyijKL+kiobkHXdQ48v9Y/viTCwYiAVKLii6Z9j6
 M2E1WYRc8dDb5us6j5pmGXKfmc+h/UWWQbYuWDdwD4Nth3cI+Q1rFR2h1mmstLXo8np5
 mM2egAbCsXFbG4Fc3VRMe/gfBVB3Z0n4kmXcjRh9kvP/Sjx4x376TNSLqOu/V3tb4TDV
 3Y8YfMA8FsBEeJGPZXsILMneMe0w2I/NBKuWKboWVcUJBFh/FO3x4fvebxRNce7OvfpI
 gPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9FCRLqSzPnhCfzaqJIN9ov9x9PL2MaqfIIqgHRLYjnY=;
 fh=h+sg1vjygHmN2QKp4a3lzSCJ0A7HTXv7mg0CWxQ91do=;
 b=QYn9ii4HHP0gQfftRoT2PjbtHjSu+cdg7QREC6SsraDtzOlVEAJl0rh7XujMWg16/D
 SMsfSjOAgcx1vYw5YP45NwbffhUbHR/cNStiN2D0RQMGZWdlZYvIInSOqgLxfLpDUFhR
 SUGA3V/J4WZ8nK/zBS9rZriQNWRLbImtYvkBiAbllGwYu4VtXKCEcCIulbNa0R0hN7zh
 VoYeaS1eI6UC2N91V238TwNUMcpoFJRHW6MYL/DJsBgEz4Fn2qDx2Pzo/0dJcCs5vVIf
 91SRDd/NQe54hHKeJTTcFORZmcV0DrRogi/ooIK6Vw8/+gPHaLhCFOAgoqdO8CfQsEbx
 yteA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783609591; x=1784214391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9FCRLqSzPnhCfzaqJIN9ov9x9PL2MaqfIIqgHRLYjnY=;
 b=b2w1BAMDJtE+5LUVOhQmpjQSHPnS54KC2QdjPobhpdkuGwgnA9mRs/sKyqJCPKYkVV
 /Pwy1HHMVjM4gn+FiLg/fzHWw2d1rP0bQviloRDMx/QkoZGVMIdBVUjrLdJQcOi3k8RW
 q/mrMTwBX4bSHvwzdOCx/usyt6bdf0KeqUO2LzKyO4z6UAIdFAqe+HCJpJ01an7xo16L
 0r1BHM7GTFJQvdgP/oVhAaX3qcXCYhkZRmfXS68cpqhz85/ijB1pbveFt9qms5VWDOK7
 zO8gPvKYcMSHmGNIPjl47ofLh3N1l8rLtj+HTgkg1rfrjOhGJpwhrotC+0w1u49FAisb
 t/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609591; x=1784214391;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9FCRLqSzPnhCfzaqJIN9ov9x9PL2MaqfIIqgHRLYjnY=;
 b=JoS1fe0kb4+xPCXu50DTdCzvH0hpiHloboPGx3JQq0ObyuSNCpWRQ1lszvkIWF2wHl
 T/t73eVcKSF5uSElVn+wUiv+R0HQXUAIMbeuedBifyzWIg/sY2HsuGesae5UpxWimlR5
 JvowNNhEprwk7Ubq4kuUatd2/TGwGyhs/sV4iPDovK9pJU8psV+RZLYqpa7EZvLKahoo
 abcU8BYLtQKNZGIjiQJx2bOSaPs1JSeCDBp6betOR94X2W9crxjbppykZBozHXeFzrWF
 uHn2LDNfJ9My88+vcvBAI2vdAOoOuh23wkITaR/Vh90TV9wqbom1XaWsr/YYQhR3W43D
 QmGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpX06Q/ihbjhUIOTL1fR3+vUq0zoj8FHu0J3iLNqvqrYDmo3NqaMd+uHwodBBn+tMIudktjU6NzIQXg@nongnu.org
X-Gm-Message-State: AOJu0YwnqGrybC+RDL88dbSDwzN2g5+aa1jiEoEb7YxVR7mF0zkQmKnH
 ehm+KC6sZ7MuiauLLnG1Ej0rUQXDs/EtoqUrTWor8jtc+QYIllba0YgD7/C7txvaMbEo0tFhc9N
 hIHUhgdRluseU5fPcyENfjSZW1eofVGoBG4Gs/tIhxA==
X-Gm-Gg: AfdE7ckfIJ6HmJDeBUTo9OGt+JS5msMFLcDxzKyYW1byzCqmxed6zFHpSm0KAeWhg+I
 4FpP3Yng0IvtY5tMts4FiWfBSGZMWas5V0p5tVN9+cuImqSklkGpVhBhLc6UxXakR0jX9wam3tx
 4esmipPe2nB4XsM/wU2rI+f9m9/vLIE3hCf4PlsyMWgIKd71qPWUw+G/eOKkOTGoCyWxsOItbbr
 qzk+D2/RmqSJlbhmZdTzZnD4hbAM3HHxWsxC5Dwxr/YxtMGMaOXu8/2zCsR2TpyPZMe19X0ei03
 fR+VoRz/6T8fRdkDX36OWOuTNjQ98IUOku1q/XKjoR7Hb3BcvVerWvW1
X-Received: by 2002:a53:df51:0:b0:665:5af:1fad with SMTP id
 956f58d0204a3-6679f0b74c0mr4134840d50.22.1783609590932; Thu, 09 Jul 2026
 08:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260605-pvscsi-endianness-v1-1-b0bf472b0f59@gmail.com>
 <273f53b8-9edc-4c0b-a793-d0667548553a@tls.msk.ru>
 <89089d8f-101c-4520-8031-e9522e2cbb1f@oss.qualcomm.com>
 <ACA8103D-AF3D-464A-900C-5448E29571DD@gmail.com>
In-Reply-To: <ACA8103D-AF3D-464A-900C-5448E29571DD@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 16:06:18 +0100
X-Gm-Features: AVVi8CcFlvKzNF8PN09rsxyfNCcxMfsuzhLMRsyHqdaA5ctacYjAzD3CsJjiQl0
Message-ID: <CAFEAcA8Rx2MHUDXKAyr-4B_L7DxGEpOHtB=tfauTvfoqhkkPnQ@mail.gmail.com>
Subject: Re: [PATCH] pvscsi: translate data endianness
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 9 Jul 2026 at 15:54, Miao Wang <shankerwangmiao@gmail.com> wrote:
>
> Hi,
>
> > 2026=E5=B9=B47=E6=9C=889=E6=97=A5 22:41=EF=BC=8CPhilippe Mathieu-Daud=
=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 9/7/26 08:39, Michael Tokarev wrote:
> >> On 05.06.2026 16:27, Miao Wang via B4 Relay wrote:
> >>> From: Miao Wang <shankerwangmiao@gmail.com>
> >>>
> >>> This patch improves the implementation of the pvscsi device by
> >>> translating the endianness of the data sent or received from the gues=
t.
> >>> This ensures pvscsi can work on big-endian hosts with little-endian
> >>> guests.
> >> Hi!
> >> Can we pick this one up for 11.1 please?
> >> I know right to nothing about s390x internals so can't really review
> >> the change.  But the fix seems to work, and it should be picked up for
> >> the stable qemu series too, it loks like.
> >
> > I tagged this for review and forgot. Basically we shouldn't using
> > tswap*() anywhere in system emulation except semihosting. Here it
> > seems reasonable to use cpu_to_le*()/le*_to_cpu().
>
> I have no idea why tswap* should not be used. Here the problem in
> pvscsi is that the driver on the guest side is using the native
> endianness of the guest CPU while for handling the values on the
> host size, we need to convert it to host endianness. As a result,
> what should be done is to convert from the target endianness to
> the host endianness and vice versa, instead of converting from
> a specific endianness to to host endianness.

Right, but what is the spec of the device supposed to be?
Generally speaking in real hardware devices don't have any
way of knowing the endianness of the CPU, they're specified
as "data is always little endian" or "data is always big endian".
Sometimes paravirtual devices end up with "assumes guest
endianness" baked into them, but this is usually a bad idea:
the legacy virtio does this, but we fixed this in 1.0 virtio,
which is always little endian.

Do you have a pointer to the specification for this device?
There's no URL in the source files.

thanks
-- PMM

