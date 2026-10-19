Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74487CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkFc-0001PW-Ts; Mon, 19 Oct 2026 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIkFX-0001Oj-Jg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:05:48 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIkFV-0006zb-Li
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:05:47 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8ac4806e210so10835777b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 03:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792404344; cv=none;
 d=google.com; s=arc-20260327;
 b=KRVuzAmBrrLRDmYb5TfcNtMCTp2GGN8S1SKI/a/t9yfaLK8PymHFTn8K3ht6xAopXS
 b40B/JG8qZTPnHOkxuV/FEzU17dpf26WKz0hoehEACp7VN7ZiCm9ps2TZuta819AQLtX
 Wh1jaEm3pHvDRcXGHPeE7HfiK+i1jfpXh+LNeG+ny0Bp2qVFX/To6iunlNirJjllz6UE
 9g5MemTtCcYJjmDnBoHNSpE4Mw37bdOq151ro+IpNt3bVa95wZuQVic2Q3UR4PYFCSc3
 nntMBG8iYW4kRI3sn8caBExA7l3j6b2vT5mWbIlR9MxhlVm5hlsKt5GEATkraPjO52A2
 2/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=umN8au4AwvrVj10Y8cmq0X4PD+ztQePyyYJBU9Stchk=;
 fh=oyYVkTN2tOJZ6Sy7PlWjXoqNIc3llQEvujqG4Um5lp0=;
 b=KZUm08opYpPEK8AGNC0O1Go/KUub2oNxNmcCifwQZIvsBRjG9VOQtLfQfAiRTK0nDV
 +dgTS1ZvLIAxX6LyG3GOpGIkKgz6m4ksgb9GSJ2LHuZxL4Gk1rI/w2MlRgqDuu26+2Ye
 PpfwFGZCM1GVsmNa5gKLqynIlpzladZlSIXVLkWvzZsX7rKImTos9vdEM4bpfDz7p4qK
 FoNM8Pramt6p6EiioYC/Gs0ACTmc3w1Ctk13O2S2CJA2Cw2B+XnFRDQZJz181ryKvMLQ
 Hs/FfU3kNfEXsp/CdC9xcCHhiOBjtpwGYeW8LOco86YtN2gcOAgxJreptxvNXXHlUVwl
 yT8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792404344; x=1793009144; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=umN8au4AwvrVj10Y8cmq0X4PD+ztQePyyYJBU9Stchk=;
 b=KKhkqaY00Ip7tLoEkIi6FRLAK40GjApNreeZPcOV3rQyoWxWgPeB5ZkCdFmFZ7DRZe
 fF5TSypqMf2kCU8HB1MKdkUsX7AgXZqJGc7/13WoQLUMOtm7VzeMCCx4Pa1MrnjP/+dm
 1YAU5CY/JtGDtWYg/cD8aTOIPT2VneY+qquGbZbcwbQmJR85hJVEGIAzCsXqJk7cTDtD
 Hu6ISZZen3TKZ/LYMSDLyzb91tJHTRVMJfPhdKjrHfca/lPPqi5sSkITvll7eiNtJ3TP
 5aT15s+wvDo/aFlRN1KbUWX878El8v6Z0tzXkBteVNEKY3TdGYbJAT0mnrW5e/PXdJVh
 gjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404344; x=1793009144;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=umN8au4AwvrVj10Y8cmq0X4PD+ztQePyyYJBU9Stchk=;
 b=m+TR/oRw7VHjktq7hTkc3HSqlaN1T/NnF+775UPCdKK6ao/0skosgWxfZRYdhQzpB7
 6rlX9cv8a1UbgfugVGQRfvQf0JeFvGod/u6PuaZvm6XRJqLuyXBmPVDe50nlYYwi5h7V
 hEnRizInQvpJXpZlh8CJ1PxRuSD1U8hdO/2DJ4x//0I8DKZBq73PQoazIhjtNh6FD8bG
 Kf1PRy+p/Z9/oFyAgz97zbws0AcRlaYdHcPZv2Bsx0zpcA7cPPUZ7zphOlijo2slyEFP
 DbjdpRBpmjMB6icHPQHa4sB3qQMzAxx25Blb+ND6gDeIu+fBFd2I4Ac/IQCiQRtJlaim
 axiw==
X-Gm-Message-State: AFq9FYKTXTgmVTUAQT6+W3yX2goBxbUsbMDIzcd/A+2wsxbE17euxrQ3
 JOVIr0Np+EcubG9AVQWR5zOO+mQNeXFmMmf/1t668eB8motRSjskh9072pRyeGOIY5ztkoVXRyE
 eKXTVrrTzdbvaOMdklXFSW8JDVa9X612QRoqjPfdtZw==
X-Gm-Gg: AYBFou16TieKpuAtKa3xXsOVE6+VyttGGEW+c0r/h6+kRbnEB2fgVv/tk3xHWbHs+gV
 6WM9idAHm5sV9F01ovrvUAibLHvbGEJQNCNqCjtakcuiAoebj3J9hkaVxyoENHYqXUswx2FH4SU
 tUDWfFH9hD/URKJTZMRBlPtCLBTxkP8WTZ9wsU+j/PFRCua5wxtE8YXiXVBFqJYcQHwnIStsDbC
 66o7N4mQiyceCpoapqSn6txN3BLUWp5foHfn4USj6XTSr5uCefOKsbWPHKbE89XgsrMCPnX89Xe
 BbQkKFlzuWBaX7ikJgVEQHeYcYeGo1tQYaehlD36Pvp9yLlJUVbT+ulsvV8Tz6wRIVIRzGQgVLW
 kV7H8cUS0a8NR0ywJeqA+pVQdR0VfE3cIxZcGjpw=
X-Received: by 2002:a05:690c:6507:b0:8b0:cd30:ce8f with SMTP id
 00721157ae682-8b0f21b9faemr23546817b3.49.1792404344218; Mon, 19 Oct 2026
 03:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261002165039.212819-1-alexander@mihalicyn.com>
 <CAFEAcA-JWf-KxgdTj5wuT7140ZY2=RXcnkCeAZkFx=t3OEoyWw@mail.gmail.com>
In-Reply-To: <CAFEAcA-JWf-KxgdTj5wuT7140ZY2=RXcnkCeAZkFx=t3OEoyWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 11:05:32 +0100
X-Gm-Features: AclHuK8aFwbyXElxhVGz8aTmeCIVQeEdGru76HdpNhE0AceVJQBqhAEBCnzNJhI
Message-ID: <CAFEAcA-dni9eUQs-Mxhuf7Z72BNrEcFwzS4ywXDZFe1VA6V3Tg@mail.gmail.com>
Subject: Re: [PATCH] virtio-snd: don't use virtio_snd_pcm_get_stream() in
 virtio_snd_post_load()
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

This patch doesn't seem to be upstream yet -- which maintainer takes
virtio-snd patches?

thanks
-- PMM

On Mon, 5 Oct 2026 at 10:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 2 Oct 2026 at 17:50, Alexander Mikhalitsyn
> <alexander@mihalicyn.com> wrote:
> >
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Coverity suspects nullptr-deref, because we don't check a return value
> > of virtio_snd_pcm_get_stream() call in virtio_snd_post_load().
> >
> > While, techically this code has no issue it's better to change it and
> > as Peter has pointed out [1] just follow the same pattern as in other places
> > of virtio-snd code:
> >     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> >         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
> >         ...
> >     }
> >
> > this way it's perfectly clear that an index is always within the bounds.
> >
> > Link: https://lore.kernel.org/qemu-devel/CAFEAcA-K7L5NWk0cC9R8yVvojSS6O6Eh+i9KXP8Lijo4Tjnd-Q@mail.gmail.com [1]
> > Resolves: Coverity CID 1687010
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

