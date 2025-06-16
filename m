Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427CCC71159
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 17:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRDiy-0000Tg-R0; Mon, 16 Jun 2025 13:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uRDiu-0000T8-PV
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:34:22 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uRDio-0004Tp-Ab
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 13:34:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c8cso8762129a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750095252; x=1750700052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVfJTpKiQ6gxhpDt+NpQbe8CiIZp1Tqpsbpuecn0z1c=;
 b=frOu9a1Is1ZCL8zYvcUyLLa6ffmHKYvcm9TYtYvvEJbqk795jVwGKjPG6DvxWXnpcy
 q0gZmpm2cEtmBYBxQl0kia+QF4TrxE1abluusC28YdZksHOpwoCrZc6wE+oKjI0qvt/y
 +Ivo27357cXmC+VIk0SA2RMfNFQ+k55CkUuHl4OfzGrgUUC8h9sZImApMpPMTuBKchN/
 MCM38TE+GOnurngPwqC4WQ3z0eqv8uA7H+w57WQlGiXnfxGtbfziopyXz6egFH1gU5tJ
 bysEsOQtU0vWq3m0X5b9e/0HPfqnsNiPSjkLivnJYGrvNeO/htql5tMPsNTJO01Grwb+
 lzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750095252; x=1750700052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVfJTpKiQ6gxhpDt+NpQbe8CiIZp1Tqpsbpuecn0z1c=;
 b=kl/FZeMIKaFVWHefo1yFb3tuI49nalu4JPONrFOzpzwSUrQsJh6qhlfgS9mjwDrx12
 8pNlxxNZJjap2jI0cC5vL+DtIAdPp1ZBq9I1U7Q6XrVWCbxkdStevsNTe+PjGmV/rdPZ
 ePJT6Vu5/KUQj1KeT5bBMvncVfS0C6Vf9eC82toeaIrNO6pCuxJSx/R1IycuD3t/5nb1
 MBA3dNg75v+3RcDIdbKvxecC+oy2I5MVi9PDopn3btc9Z/1zBB8sDmL3FNZoeRNLchJX
 cQAu8Z6bFoYssZnIoO5XpNtGEaC3vqK0wrDM6A5xBpeAmp4XNV81vLw0VB6QxVe5gKKf
 ffnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKaJfftKLsz8LyXUXq8J+wXIm37l83OQ87qa/9Muvdg/rBQGsQrYXsuwVV7E/QaKFpF39WEc44kC7t@nongnu.org
X-Gm-Message-State: AOJu0YwgX6N54RM8CDE38gB+PSBJXf2LciJueYTbAAFWCrgzPmyn1K+S
 JxxoYAUAAMZrSC5ujTFa0l8d3fh9gLqq94IKmi2hOFu4KLHyysgbKKE7WYED+8cn1Qyftenbr1n
 wjDEdzeRFNJ/IJjL2zqtxv1GIG60n0Go=
X-Gm-Gg: ASbGncuscqKQyHw3qhIVaC4gICkvjse26iSAnjYg3cnzRsw6aGo3NsJOQ3jxnKREjMX
 qlFknm3vUTlOGCPdthzYW+PLRGw7vlkZHst5Oe8GLw0JkAnKPAlP/JP3Nhf8HCH6Aqn2j5e6WqG
 lDbVHmjvMZaaG+Ze4kJI8EV4heZh7CuLco3BhGoLXQBRoWzmqYxJgv
X-Google-Smtp-Source: AGHT+IGCkEONrpt85ER0lPSDNUqw8noHRa4xUQ9u758QsXsoq54PQziX79ZbOZt6GPkpDdWa4G2axW4+yP+hZBsgk9Y=
X-Received: by 2002:a17:907:3d93:b0:ad8:a935:b8e8 with SMTP id
 a640c23a62f3a-adfad2b7637mr1020361166b.5.1750095251645; Mon, 16 Jun 2025
 10:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
 <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
 <be26f6ad-f266-4451-a7ce-3d78afe34f27@redhat.com>
In-Reply-To: <be26f6ad-f266-4451-a7ce-3d78afe34f27@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Jun 2025 13:33:58 -0400
X-Gm-Features: AX0GCFsGPlUAfczO0lNuBWNXr4bQsXsUdbMbZeLmgVWQc83Eu0uyhwC7TemiDnE
Message-ID: <CAJSP0QVPqt_9-pp6Ox8jO8ozDUvOzpErWu1cxPv1pptaAwFW=Q@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jun 12, 2025 at 11:05=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 12/06/2025 15.08, Stefan Hajnoczi wrote:
> > On Thu, Jun 12, 2025 at 12:36=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>
> >> On 11/06/2025 21.09, Stefan Hajnoczi wrote:
> >>> On Wed, Jun 11, 2025 at 2:36=E2=80=AFPM Thomas Huth <thuth@redhat.com=
> wrote:
> >>>>
> >>>> On 11/06/2025 09.50, Gerd Hoffmann wrote:
> >>>>> The following changes since commit bc98ffdc7577e55ab8373c579c28fe24=
d600c40f:
> >>>>>
> >>>>>      Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://=
gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
> >>>>>
> >>>>> are available in the Git repository at:
> >>>>>
> >>>>>      https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-2025061=
1-pull-request
> >>>>>
> >>>>> for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f95=
2de1:
> >>>>>
> >>>>>      seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>> seabios: update to 1.17.0 release
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>>
> >>>>> Gerd Hoffmann (2):
> >>>>>      seabios: update submodule to 1.17.0
> >>>>>      seabios: update binaries to 1.17.0
> >>>>
> >>>>     Hi Gerd, hi Stefan,
> >>>>
> >>>> I'm now getting this when doing a git pull:
> >>>>
> >>>> Fetching submodule roms/seabios
> >>>> fatal: remote error: upload-pack: not our ref
> >>>> b52ca86e094d19b58e2304417787e96b940e39c6
> >>>> Errors during submodule fetch:
> >>>>           roms/seabios
> >>>
> >>> GitLab CI didn't detect this, probably because the tests don't build
> >>> SeaBIOS from source and use the binaries instead. Given infinite CI
> >>> resources we should rebuild all ROMs from source to catch problems
> >>> like this one.
> >>>
> >>> I wanted to mention this in case anyone wants to tighten up the CI to
> >>> catch these issues for SeaBIOS and other ROMs.
> >>>
> >>>> Looking at
> >>>> https://gitlab.com/qemu-project/seabios/-/commits/master?ref_type=3D=
HEADS
> >>>> there is a problem with the mirroring:
> >>>>
> >>>> "This project is mirrored from https://review.coreboot.org/seabios. =
Pull
> >>>> mirroring failed 4 months ago.
> >>>> Repository mirroring has been paused due to too many failed attempts=
. It can
> >>>> be resumed by a project maintainer or owner.
> >>>> Last successful update 4 months ago. This branch has diverged from u=
pstream. "
> >>>>
> >>>> Could you please fix this?
> >>>
> >>> `git clone https://review.coreboot.org/seabios` works on my machine,
> >>> but I manually clicked the "update" button and GitLab failed again.
> >>>
> >>> In the GitLab UI there is a button to add a new mirror repo. I though=
t
> >>> maybe we can delete the old repo and add a new one, but the push/pull
> >>> direction dropdown list is disabled. Maybe that's because only 1 repo
> >>> can be a mirror source for pull, I'm worried that deleting the
> >>> existing failed repo will leave us with no way to add a new repo that
> >>> supports pull.
> >>>
> >>> Does anyone know how to go about fixing this failed mirror?
> >>
> >> Maybe do a manual push --force to our mirror to sync them again? ... b=
ut it
> >> would be good to know how this could have happened at all - maybe seab=
ios
> >> force-pushed their master branch at one point in time? Or did we commi=
t
> >> something to the mirror that was not in the upstream repository?
> >>
> >> Anyway, I just noticed that it seems to be working now again - how did=
 you
> >> fix it?
> >
> > I didn't fix it. GitLab's mirror operation is still failing.
>
> Oh, ok! Maybe the error message only pops up if I pull changes into my lo=
cal
> master branch, and during my last fetch there were only changes coming in
> for the "origin/staging", and those didn't trigger the error message.
> Anyway, I'll keep my eyes open!

Hi Thomas,
I force pushed upstream SeaBIOS to QEMU's mirror repo and now the
GitLab mirroring feature is operational again.

Thanks for your help getting to the bottom of this!

Stefan

