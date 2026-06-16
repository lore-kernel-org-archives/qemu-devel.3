Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A759CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZWP8-00012D-0s; Tue, 16 Jun 2026 12:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZWP5-000121-Qq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:12:43 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZWP2-0000q4-FV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:12:43 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6626cd98209so5082975d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 09:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781626359; cv=none;
 d=google.com; s=arc-20240605;
 b=UERVZgv19QUAXQEy1xfCKAvzMtpQCaDEQvmmKrA3fQ2zbpdPMmhDxzXty6Esf4MLd+
 PhToOE9HQLqrZ75s4dKSX9QTqcna+zZlojevYTV7/IgihN7rRHahSgj3u5gLNcFWokJ2
 AriQfIFneiX2xe4ZZq8P0jylsDPREXGWrYd32lqx0UV0EX0BKEk25jCaxtwsQgxLsG1Z
 DTdX5RA1JTbKTEHP6fpKesA3EHADPNN40EAVJO7gFm2qyJMChEYhc+SDBSno9r94MaEU
 BE0dAejBH06GhUEm/D0Ao/IJABFthqRswr/j9L+XLCHJVhCtU4OjEel++hcD9EKQeT5L
 MVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+xGB58/J9OauCPIgNoe4zvbPri0Eq4wE8kiR4XNyUug=;
 fh=XkDcxgI35ocrFMcNShv78moWJRjgxn1fBL8CPzXhL5I=;
 b=fbU7m1x+WhYAMG5I2QLTt85XkGugOeb9k6BjD4Mugt/uzrs6WqYGONwrvjoK1xGcTN
 xMTY9DHxGWV/9CRRjQaXQoPtBIrqkgDw0CdcR36vCWTjyN9ILpn7qkrIuC7fnEodNGko
 EFbywjqgHyK3S1O61fHJrWJgDouwbeYxKN0QBWTrtfwa7C51DWoEavHTxfIwxAoI2dnW
 9zXZRqW8+2wd6I0lsKl6QQW23fjBUALlW2pdkkSXExfd0tLB+0vii6jNcGLih/QfjEvm
 /stW57nEu+B7+NoqasZUFxS0Gj54iDgE2azM3OWWeYe+qd71sFOYpQQS23VfzIv70Ymt
 Vuuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781626359; x=1782231159; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xGB58/J9OauCPIgNoe4zvbPri0Eq4wE8kiR4XNyUug=;
 b=yncCKlRJ0yvDFbYDBNg2SNjFEhDdYIbbn2VWPMtYXbgPEdFOchlP32KO4Zn+W/YRml
 IeSfwmWl1mzbx6+DYbdZIuZ7lD85iRB8rhaxmdF8VZg36gwDVxuCOeXG3MOU6V5pGPNn
 WSA/3txwTi8VdrLcLNJ8RpKTwc6p336zx7Z1M5gqc+UWkT/SnHaS8hasZxqQlYf6cIaQ
 b4K8WCZvgcLpcsd5XpO9ImanpxAg1UctE7EdcQ3QaMdRsATB/7oZSjyVvLX/MI+Fhwqq
 EpkrB6c0DL0VpZ5eWi4H2bSmfy+sZ0+TSzGuCmcFvT8bh9Y8iRt9o14IM1vGJeFlIk6f
 WLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781626359; x=1782231159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xGB58/J9OauCPIgNoe4zvbPri0Eq4wE8kiR4XNyUug=;
 b=kcxij8Fn3J7GnxElQ2pkx9z3+rjQLH2hYoLo+XCFBRU3/OL9WTtAkRsYqQnfkEh3ji
 PDwq1fVtZvr9NYIa/nQy1ksIN+rafrBMvG6+arg+r84m81gKhvvxOP4zcJO8jAwZsF0y
 NgYrTAOHZzx3dnzPS3HVYTGichwK/cP7d7ML7Wgq9P8DDO94Im3VYviTAkELREHHFVC7
 50IR9/Fb8UbIix09U4lBo4HwJGhNHB/0xNE56XQO+FVc20U1oeWySXMcLwCL9AW7jVNF
 lmMVdvQUvq+LP3bHADmSAU7mO/8VEVfPOZZvRU4VaTmdlagenW2pEf4uMP8fK4ya02AA
 enjQ==
X-Gm-Message-State: AOJu0YzV/ULamYSlZKmS/mbgeqoLaXcZU50jOEywbg95j5bGhiRh3Hoa
 UL0yIAgx7pBrdESIM+1I7JEvNIBMkyPXrD/sUVjX9FcczAXv8Xn7lbsCnSpLTB720ILShbJOnuy
 GbQxgBSXco4fzZqdeiq2amjy6+5SVfIXCIWGeaIZEbw==
X-Gm-Gg: AfdE7ck4fAB2whrMdwUBmMwjvHhpEt+p3lHN7xMZyQegpwcIx1glxifVG0Gk1WncUyG
 dsfwPfxUX8/bYYrnjMdeLtIAXNs7FvDMM9VE9VFC6rnOd8ALXg+fY86OBIbV/sk8FiUmQTKQR2L
 +MIf2+6mP8l1w4+YBBKmqQ/VVNCBtjkZEFyXafCeF9Ie3zfavsJ6bxEo2rgd7WTMsNNVi2iFe8O
 l4yswxwBWzIvW7/q9IzYbEKzzI9qq5QrtYGR/GO5gusSd81asR10B7JN/H3lijDsWoB6gye/VnN
 BXSTQMRLQU5B0M99IDAGzGOgDhfjoMJuw0h/kX50UALJpCv1CvoXKwMAmOVtajqpm3H5PVU3JUA
 ofw==
X-Received: by 2002:a05:690e:120b:b0:65e:41dc:e8de with SMTP id
 956f58d0204a3-662b619b7b0mr3328451d50.61.1781626358831; Tue, 16 Jun 2026
 09:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260616155554.264412-1-berrange@redhat.com>
In-Reply-To: <20260616155554.264412-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 17:12:27 +0100
X-Gm-Features: AVVi8CcXWfmk4nC-hu5rur5GCINcxEEKBIWv-CPQ-uqo31DCuOTkbRcD-rnkD4U
Message-ID: <CAFEAcA-Mmt8=1iPOCbF=XsghFzfNN-=GHyLr70iUNDFFN0OKcg@mail.gmail.com>
Subject: Re: [RFC 0/7] qom: deprecate embedded objects and instance properties
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 16 Jun 2026 at 16:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> QOM has two rather unusual / surprising features historicall
>
>  * The ability to embed a QOM instance's memory inside another
>    struct
>  * The ability to register properties against the instnce
>    instead of struct
>
> While they both look convenient on the surface, they also
> have significant undesirable side effects (see the commit
> message for each patch for details).
>
> The premise of this series is that their convenience does
> not outweigh their downsides, and we would be better off
> long term by eliminating their usage, rather than trying
> to add more hacks on top to mitigate their downsides.

The thing I would like to see before we mark object_initialize_child
and friends as deprecated is clear documentation of "this is how
we would like you to write 'container/SoC' style devices, here is
an device written to the approved style you can look at".

Currently we have in the codebase a pretty wide range of
different ways to write devices:
 - really ancient, not QOM/qdev at all
 - qdev style (lots of Device* pointers)
 - embedded-struct style
and I'm not sure if this would be adding a fourth style, or
rolling back to qdev style.

(Borrowing a paragraph I wrote last time this came up:)

I'm not opposed to the idea of making a design decision that this
struct-embedding is no longer what we want to do, and defining
that something else is our new best practice for how to write devices.
But I think we would need to start by reaching a consensus that that
*is* what we want to do, and documenting that "best practice" somewhere
in docs/devel/. Then we can all be on the same page about the design
patterns we want and it will be clearer to reviewers whether new
code and new APIs and conversions of old code fit into those
patterns or not.

I think we're getting closer on the "consensus" part but
the "document the new best practice" part is important I think.

thanks
-- PMM

