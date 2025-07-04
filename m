Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgXb-0004Q1-MY; Fri, 04 Jul 2025 09:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXgXQ-0004M6-1D
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:33:19 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXgXK-0003Zf-FY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:33:09 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e7db5c13088so825588276.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751635985; x=1752240785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwaDmSI+c+ULG0pcs+kC8v9tTILpDgFwM3hxFcbfcyI=;
 b=dVsEBwQi7oMDmlAbrc/SnV87WqdsKBjUWIfRfMt05aEMa8k8yPorOeke6mFAM/sEsZ
 d1h4+IdureXF7l1N9h1YKYyDp7xTdwzgL4LGTE9dPR4AQ3d+7vAtOyO06vrXxtFFOkBW
 be1S7Qd+qhsJs9OV4fh3W/4Kh9lXlpPkCAOT2WSQXrqD1vxq4VXKPl0DNLfd+j+LK8Mh
 Q04iOU/lnTOgkzFGDphxJvw0kPjM+Oq8O3maXYFlW5K/LndnmNFu4dmhpwaGkDRLSBLk
 gZNam0Oz3XyS02+EzUTI7uVKVHfB1TCKtqJqXiroYX/CVJV1Be9IFmJDml1+O3iOTeGA
 OiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635985; x=1752240785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DwaDmSI+c+ULG0pcs+kC8v9tTILpDgFwM3hxFcbfcyI=;
 b=p5ewrGttgSpAkxbgNkc5D8vEpvOUbRBzVxYYhjy0zuyEH/xnGcVKP1q2edeSqmCu7I
 p756TSnW7FuWvpH6jqY8G63opBM/t6crzqebfurkISPj6AL0biOMANptYetlDeicWdzH
 rymj72qwQ8PmKqloxeQY70m2O3OuR/qw6KwjeHtxL9VyAGG0imnAY/WZ8K5+qAgDyrou
 AValbw5NZDjvKp+iHqNmg/dv9S4m+t1h+0fg/h0PP1ZmxNnZvS8cLMHdX6po1tj+H0YC
 xTzUqUW3is9H762Yx6fh0jYoRCtwoFAs/GufqaC5VslB2tGVLxTxX/MCKzWIsTWxtuNj
 Fkjg==
X-Gm-Message-State: AOJu0YzYGXzDhH4r0MnBjVv6ctDEX93nMtTJzZkDcb39zHxILs9ohK/D
 7XtTDXQeZj5A/Y+9ld7EZRLThDiwnAkhACSEEVDmSb5zv3/fcl0pyK+h1zVhZYpovRIo+aFeHh4
 n8PlbxzcBae/lYJhk+cHI43Ao8eZT6sm10RLS9QpwgQ==
X-Gm-Gg: ASbGnctbDQ+kYkNoR49TE2rZAdUfdE1q0EQOoFulIVBBSzGggYyZ8yfoXxq916o0Sl2
 HRx77QWscWHXWDBBvk/fH++kJV/YQYKXaV1N7JA0Z4CxG7wGYCvxdncyJsaOEmPemPO7eIKQKEv
 oEs2VDOH4BoiWoO5nsuxTss8AqvUnC6qgagnQ/y3kG1w38
X-Google-Smtp-Source: AGHT+IFCAnEZls9tvJ2p1vJqD4nxu7483ggQioJYTrgA1iflgq8Prd6RdGmdyuEWQ5cYALjCPuoaeUD1L63dzhiU3Gc=
X-Received: by 2002:a05:6902:2849:b0:e89:9a4a:42cd with SMTP id
 3f1490d57ef6-e899d13b7c5mr3492974276.12.1751635984913; Fri, 04 Jul 2025
 06:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-3-philmd@linaro.org>
 <CAFEAcA8KBTfJqUbBeUm9_=JoMf133Tt3tcWhJ=sSSy-Yc6Cdcg@mail.gmail.com>
 <eab8d30e-011a-4ec0-ab70-827f6a33a5c5@linaro.org>
In-Reply-To: <eab8d30e-011a-4ec0-ab70-827f6a33a5c5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 14:32:53 +0100
X-Gm-Features: Ac12FXx9p9M4oe1SZla9vu98oaZURWdG2Izp3rDg0x0klQ7UiXTxUxNHCnc1V2k
Message-ID: <CAFEAcA8sH8HyskYEfoNKFi9N3Bq7e0ze15_ouus82nEZSchrJw@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: Only allow disabling NEON when using TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Fri, 4 Jul 2025 at 14:17, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> On 4/7/25 15:03, Peter Maydell wrote:
> > On Mon, 30 Jun 2025 at 14:09, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Only allow disabling NEON when using TCG.
> >>
> >> This avoids confusing user experience:
> >>
> >>    $ qemu-system-aarch64 -M virt -accel hvf \
> >>                          -cpu host,neon=3Doff,vfp=3Doff,vfp-d32=3Doff
> >>    qemu-system-aarch64: AArch64 CPUs must have both VFP and Neon or ne=
ither
> >>
> >>    $ qemu-system-aarch64 -M virt -accel hvf \
> >>                          -cpu host,neon=3Doff,vfp=3Doff,vfp-d32=3Doff
> >>    qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or ne=
ither
> >>
> >>    $ qemu-system-aarch64 -M virt -accel hvf \
> >>                          -cpu host,neon=3Doff,vfp=3Doff,vfp-d32=3Doff
> >>    qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=3Doff:=
 Property 'host-arm-cpu.vfp-d32' not found
> >
> > I don't know about users, but I'm definitely confused.
> > Aren't these three all the same command line ? What's
> > the problem it's trying to show ?
>
> I should have only shared this confusing example:
>
> $ qemu-system-aarch64 -M virt -accel hvf -cpu host,vfp-d32=3Doff
> qemu-system-aarch64: can't apply global host-arm-cpu.vfp-d32=3Doff:
> Property 'host-arm-cpu.vfp-d32' not found

That seems correct, though ? We say
     * Allow user to turn off VFP and Neon support, but only for TCG --
     * KVM does not currently allow us to lie to the guest about its
     * ID/feature registers, so the guest always sees what the host has.
and hvf is currently the same. The bug the patch is fixing
looks like it is that -accel hvf lets us say '-cpu host,neon=3Doff'
but it won't actually do what the user might be intending. So
we should avoid creating the property, as we already do for KVM.

(The other odd thing here is that hvf CPUs don't support
AArch32, but ARM_FEATURE_NEON is about AArch32. But that's
a separate thing and we'd need to cross-check that nothing
aarch64 is incorrectly looking at that feature flag before
we suppressed it for CPUs without any AArch32 support.)

-- PMM

