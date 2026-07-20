Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6619DC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmX8-0007ZP-5a; Mon, 20 Jul 2026 07:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlmX6-0007Yx-HA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:51:40 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlmX4-0003Dk-Ha
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:51:40 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8114a4542b2so48972217b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784548297; cv=none;
 d=google.com; s=arc-20260327;
 b=kjRIFRNK5pnT4K1cxnbnDZLRebQVV+wxuEw+r0z7g/GPzrg1t64bVBEJg4lX/MNVya
 u2cmLI7XoS31i0MyKuRf0EPLXy6lEWXPFbDkgAwXkmf+HanG1dvPRiTnBi6vnTA9YSe5
 lkeUrRhBQoet7e1q+ZaPbkzGekL9G0ksg3K9dVm7PuxTKlwixp1/9obE1ZYk0wGP5TEz
 F2GE4McnVfPD0kEdasdAAOa+j3nzM2AbZ3lYM3wfN+1CzZ0baDaPESfp0XOn1EIGcfVm
 PgPyAq4M51dK+y6p5GeB6NJ3e2b4e/aPNEioo/ebnRGD15vX45Hc+Y6Xu+UrBvkaxKWx
 17Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CgPTE7XBWvgVPfarrPivwz/W9oXB+wzzuoiloCOHu8o=;
 fh=q+PUviekXnYIjE9Ya2V6iz3WXcKfyQiXPzG9GQMN/Uo=;
 b=TbaRLWZxs/v6gt/wE5f2v71PGkd+U3AlwCidIRjWRUzXIp5GcJBPqAQAn+qh8h0WfH
 PumnB8Nd1XDbBl65aE3FfBgRcqkWD69DQW2buL0RjzlUIY1sf1Z6DOiOja8zuCWZcdEn
 Gg4/ChvMc7hvOmbL8CVNl9i1127rZZMA6VeSbYtQydbbXz3Kka9/BZNFkcc5r/+xIo2P
 sAF74qrJPOLW772s6ef/pTyM+nXctukyV6pkicBLxCLdhAEcOodLKosJ36DIbzX97BWb
 kAcJzItYA5yKaTmbx5ozT86KCXQTuRTqDldRczEIvjkaJXE1wKNO/KV6nEtaSU6MuHqM
 Twrw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784548297; x=1785153097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CgPTE7XBWvgVPfarrPivwz/W9oXB+wzzuoiloCOHu8o=;
 b=LgZ66exFfVW0NFWYXpHKMvc8AWz9RAFd6rUavGPltF+46sd0bDL+RPSi6RrRnANSvP
 1z+XZNvrUJbPNWQqNsv2tP2QhVxM/kGy3e+jvIkoMFY90Pyu/aNKmaes8UvK/yYFGlcM
 gmpKeSJd4aGpL+UgG+zmqp/f9KsxTV5tHXMAda9OA92tn9Uuu6MKcJfp8dcMu8XSO6fr
 QQetdn1TIflobU1IPSQ8CGCGxdAlJsRwC2KblWlVuBvvkRRE3s5wD5gI6TyhPcAtcwP8
 rg/sNJRjsg8mWpyvemD/rPKifKB5boUFfu+oUQSMrJ9jdRey4T22zFniEpOpv4T3Qn6a
 f+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548297; x=1785153097;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CgPTE7XBWvgVPfarrPivwz/W9oXB+wzzuoiloCOHu8o=;
 b=erDHt3EOBq1+qfS/bu+ovYKjSyugjm7lue/L3l2ZIRbss/98spV6/0gR44zAmegasr
 eoPfjgZ0Vd//3jIs5OFYBYzuf9spO5f0V1ECT4K2te3ej41Q/5H61xBwgkdobEDQ5RB2
 gYKW8EfaSnVt2tFrM7QUa2ItIedgUZhJHkr5dWwNRuwgUOWhqCRXH0bip8O8UeEgyTW8
 QcFWyiy0ukmyfdnHx0ODew5w+ut45WRGnvF8Q8pAcN4ogwoOnoA7ysphrEMSjeDvSHQc
 cQIsGqvnwQ94f8EZhvWynjh0TY66IDjd5GzDcTtH1Qkf3DDMhT1GIRJ0Vmk5yF/dVZV8
 u45A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTWD3VKKu/nOcJeQ23ziUI67n6hdkGaeyAZMHTP0a/iZ/NcEQ5WKW5TFQA+9nIFekgDqgGK8M9N/n7@nongnu.org
X-Gm-Message-State: AOJu0YwhHQyXBn+fGhOTcC3OMoVdJGbvOPFtsZ/Wh+mRfjllWWqyp5Xd
 c1rwGIO3Zpk+5ocMkFlZESLPhelqhJyour2BMqS3i9PV8whrW4ZbxQgbh3WsPSejgkqz+LswZ+O
 vxWOYpfZmMb2Jdd+m6Rh5+26kqMlMSlas7Ob4KLwLyw==
X-Gm-Gg: AR+sD11NoWGPyZdLIZr12ausqjLtbNnb+GE/6hxO3tJab7176AgEKVN3jYWwPclvumh
 hCXLKCTjIKnFDk5pWS0odEsiGrKViKLLTrq7jegFXlUj7Dp6OLlDMaqo9fki8wHwjkHHebskgM8
 hkxkryMmwjiFp/WDcU6sjHtUtkVzhim5lZteUBjaSBLNfh2UOvr6ByOUSeE8SD1RNHMoD+1Mnyu
 pSv11nfd3DWxc9fR5KN+ELzgPFG1gHziCo8v9/nZ2Cx4sVBYhp7EIhrtl8IxG+NEffithSAsv55
 TevIk/sv7Nrsa4S0Y6sHd41tQtyE9y3iHjt1yNbIWs0GJg==
X-Received: by 2002:a05:690c:338c:b0:80c:85e5:875f with SMTP id
 00721157ae682-81ef28de1bemr40922017b3.72.1784548297061; Mon, 20 Jul 2026
 04:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
 <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
 <cc3b6f33-6cc7-484c-901c-ffa4003c2865@oss.qualcomm.com>
 <CAFEAcA9iSgrua_ekOQ=EaXp=Mcxwk52qK6AkRXCrH1KcRm_vTA@mail.gmail.com>
 <6e4220ed-1e4f-4174-88cd-151c03b8048d@oss.qualcomm.com>
In-Reply-To: <6e4220ed-1e4f-4174-88cd-151c03b8048d@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 12:51:25 +0100
X-Gm-Features: AUfX_mz_RwRGdWzke04b93SQSGKuiHLapQe5ByIfO4l06bKqc6bePwgygb4_REc
Message-ID: <CAFEAcA-_rWzq3zq4AfduTRodMTcBZEU6bFtX3qhJYfn3VfBLdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] bitops.h: Add find_first_bit32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 matheus.bernardino@oss.qualcomm.com, ltaylorsimpson@gmail.com, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 20 Jul 2026 at 12:46, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 20/7/26 10:31, Peter Maydell wrote:
> > On Mon, 20 Jul 2026 at 08:49, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> Hi Brian,
> >>
> >> some random thoughts...
> >>
> >> On 15/7/26 20:56, Brian Cain wrote:
> >>> set_bit32()/test_bit32()/etc already let devices operate on
> >>> guest-visible uint32_t register arrays without depending on the
> >>> host's 'unsigned long' size. find_first_bit() has no such
> >>> equivalent, which pushes callers towards casting a uint32_t array
> >>> to 'unsigned long *'.
> >>>
> >>> Add find_first_bit32(), implemented the same way as find_first_bit().
> >>>
> >>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>> ---
> >>>    include/qemu/bitops.h | 30 ++++++++++++++++++++++++++----
> >>>    1 file changed, 26 insertions(+), 4 deletions(-)
> >>
> >>
> >>> +/**
> >>> + * find_first_bit32 - find the first set bit in a memory region
> >>> + * @addr: The address to start the search at
> >>
> >> s/addr/ptr/?
> >>
> >>> + * @size: The maximum size to search
> >>
> >> Pre-existing, it is not clear this is expressed in bits. Neither if
> >> we expect it to be a multiple of 32, or @addr to be 32-bit aligbed.
> >>
> >> Maybe rename as @last_searched_bit?
> >
> > Could we please stop bikeshedding this function? It's
> > a simple copy of the existing find_first_bit() but
> > with the type changed from 'unsigned long' to 'uint32_t'.
> > The comments and parameter names on that existing function
> > have been fine for years, and having the new function
> > pick different names and comment phrasing seems unnecessary
> > and obscures the parallels between the two functions.
>
> Argument renaming of course implies renaming the other companion
> methods. You taught me to add public APIs with good descriptions
> when possible, I thought your advice was worth to other contributors.
> I'm not considering this review comment as bikeshedding. Anyway,
> thanks for your review and advice. I don't object if Brian keeps
> the current names or rename as @a, @b, @foo, @bar.

Sorry for being a bit grumpy -- it's just that this is the
second time around of somebody suggesting a change here
to something that's already present in the existing
function this is patterned off (and which we borrowed from
the Linux kernel originally).

-- PMM

