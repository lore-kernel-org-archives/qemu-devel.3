Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753D1CF45B7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfM2a-00064O-Da; Mon, 12 Jan 2026 12:49:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfM28-0005qw-Cd
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:48:55 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfM25-0005BR-5W
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:48:51 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78c66bdf675so66379027b3.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768240128; x=1768844928; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1NGxSpPaWLf346DXb1hEjKX8Z0bh3P4tRexoqH2yGE=;
 b=iiLAf1wV39ZYr/0+mni9oUH7+SO6FvL65ZSTjRQCOtzYj1uc9wsLDgXzyiO4XNsENg
 U5Y0W7tdx8MSN/NbGKtwbXWAT9kLIYp+rj5pr5BuHtc/pnzF5mDLZJZvbEvXRDaBwzqy
 hQCpHJtrAA9w/bZJeYxnAhcZ5BaugRhp+KLUMK57/do66cXv3CrImlUGlQR6lyRaRJZF
 P8YbGo+XlZ8sa+TrNo6V4VpVlzOX7H8lh6jSiaWwVxM2l8aQTMuk9cE0AeVHyvny+VZO
 C6EgZFShQYTJID/HjgznHSDNXG4fCeagXol7SKnVkdNku7PjQtyCL/nDueEOspGilCKi
 H+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768240128; x=1768844928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1NGxSpPaWLf346DXb1hEjKX8Z0bh3P4tRexoqH2yGE=;
 b=MECpX/selPDUVxi7rzn/utxD+u5lQDqAdiJLXefnVCbkDBGR6r1XHy3xzmbxb0Hjs+
 ImDsryIN8qJGYXFjAvJLIxNTOrDLFatTOa47znl80qtMzk66cSYihYNUl3Der+Gfhyf7
 28hdCLj6gMkudhLmIvg8bznKSv32XJ17+McPNvlces2Kopv8+e7DmP//SWnulhnrelSA
 KE/twnCWP5DqB2b/F9H5eNF18VHgmXJ3b43UX7eUECkUV3KX0jEEVTjB8lt3mPhpvata
 2UV7+Fd7AU4xiCE59gBZfDaETAMVobTtLtbPEvW+qYooFoQ2rs3kALSR65OtFUMpbPaT
 r1Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCz+A/a8mRjvAWSCMXFVw7AD7NCWeL8wYEBkIvHbVZj493gkHi4BvE19o9h7teGcZWLibrJRbyMJCE@nongnu.org
X-Gm-Message-State: AOJu0Yy6i2EG+srOno76ISSfgYhxhHMa/kYzketaJcOGzmHA5Kx37Orc
 +LCfHNtlThjZ3RCoB3Exu8DkpmrHFllVY6x0xgch5SjsFRsLVMX5dI1FiVZfY2AVrdGMDr2QNgz
 wTikQGhDRxHp6u7NeJs0KacJ+kai0BcKjhjsluXLr2Q==
X-Gm-Gg: AY/fxX7ZfiGKXtBzS8LcCpSLazJxtthWyUQkqGwxmNleunekCeg00RVQtUxbpf15HlS
 WADK3lT8dcpW/TltSs75gCPYsJqLRcAgmYSheVHDX3PwD3Ka0ceqStmGotWMvhKrMQY53PSXaZ8
 ec01VZSWNLoLDouAiwaPf8cZIKMy2nG87N9OmDx1Sb9v9TdMSAM11sm1kLIEUixHqKXwa2VODVh
 iXYEKMaiSHcYsHwvgnuqHNveLpUX6kTiH52Z7QWalsV56OvDcY06NtT/wOByb3a9L9tvjWOxKO9
 Tnt4LiCpdXkjTzOFJt7+4hs=
X-Google-Smtp-Source: AGHT+IG9M2wnBwvzPXAOyDL+ZeCeKBgloXjsBche/590vuwSQNpjaRRMDImfs824co7F6XkkJHkPMoCPEJ/sFeqSIiw=
X-Received: by 2002:a53:eac7:0:b0:63f:b5a5:37c with SMTP id
 956f58d0204a3-64716bbb65dmr11493877d50.2.1768240127872; Mon, 12 Jan 2026
 09:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20260109063504.71576-1-philmd@linaro.org>
 <20260109063504.71576-5-philmd@linaro.org>
 <f36ff8f3-98a5-8f8c-c6c7-069130e5a64c@eik.bme.hu>
 <2dcae9f5-b306-4e32-b9e2-7ae83aafc14a@linaro.org>
 <eceb1fc6-11f9-cbde-4215-75daf438bf73@eik.bme.hu>
In-Reply-To: <eceb1fc6-11f9-cbde-4215-75daf438bf73@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 17:48:36 +0000
X-Gm-Features: AZwV_Qg_--fSq382EaL3sZXoPBZvkowQUN89Mcgph1XUrJtQVhq0q56IJWtVTOI
Message-ID: <CAFEAcA_C_xD6S+wjwr6hO62F4vZR+2AdLHr8yU9jMkhiWTCudw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] system/memory: Rename unaligned load/store API
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-ppc@nongnu.org
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

On Fri, 9 Jan 2026 at 16:41, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 9 Jan 2026, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/1/26 14:48, BALATON Zoltan wrote:
> >> On Fri, 9 Jan 2026, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Rename the API methods using the explicit 'unaligned'
> >>> description instead of 'he' which stands for 'host
> >>> endianness'.
> >>
> >> I still think it would be easier to add a comment somewhere (or in
> >> documentation) that host endian stands for no swap just use what the h=
ost
> >> uses (that also explains what be|le will swap relative to) and then no=
t
> >> rename any of these. The le|be variants are also based he so do you re=
name
> >> those to lduw_le_unaligned_p too? This gets unwieldy. If you want to g=
et
> >> rid of he at any rate then maybe just drop it and make the host endian
> >> variants lduw_p without any endian notation but I see no problem
> >
> > lduw_p() implicitly uses *guest* endianness... If we remove it first,
> > then w can have lduw_unaligned_p() become it. Quite some churn rework,
> > but I'm OK to pay the price if the community is willing to go in this
> > direction and we eventually get a clearer API.
>
> So then we could just leave it as "he" and document it better what it
> means, that seems to be the least churn to me. Adding unaligned only to
> the "he" variant does not seem to be improving naming as the others handl=
e
> unaligned too so it's still unclear and renaming everyting would both be
> too long and too much churn. But if others think this improves it and is
> worth to do this rename for these he variants then I won't raise this
> again as I've explained my point sufficiently already. If nobody else
> cares then it's up to you.

I tend to agree with you -- _unaligned_ is rather long and obscures
that we have this family of related functions.

The "no endianness indicator in the function name means target endianness"
APIs are a bit of an unfortunate historical accident: we have ended
up with a fair few places where we'd probably prefer to use the _le_
or _be_ versions explicitly instead these days. We could perhaps
clean that up so they use a _te_ infix instead. I'm on the fence
about whether I think that worth the effort or not.

-- PMM

