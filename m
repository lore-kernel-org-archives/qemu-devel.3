Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E463BFCD0A6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nmk-00039l-Hn; Wed, 18 Mar 2026 06:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nmf-00038y-2L
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:05:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w2nmd-00049v-7D
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:05:48 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so7536668e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773828344; cv=none;
 d=google.com; s=arc-20240605;
 b=fZbzbiqMcVjPFzR+DHWAXsaweFm3T+2XOVy9jsfg1OrS5bs2YEI1+aEdEb+ZHTImAu
 sbE83TIs6RmuWaKZP72H7hZEOwmNC/kUdKXGdN/8RmuYjt8c2eWhKP7V/vQbgUf9NmIN
 YxioABv+68tVDfY15s4l6E4YBE2Of9v5zOwJ8S6AoySJzwQIzMAnMRBOiRfmXmD3dnzS
 OswHl0vm9NtjAclnUuSTxOgRGI3EZPsdzMWfYExFoNYa2s0MaxUbygCBTZlLOMUDXA63
 W+HEUk6uTSdRKuZJwdTfRPoTYaCwCwNAlYCFnAm14JU30+0PIE3vV9ulATtW75FWe6la
 FvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e5ImvG9rvTHH+Bj4mOwgcCururl81itA0QyDqlpYRp8=;
 fh=PPOvtMHkqOkqS+s4WoZGxCoh6Ztf1gmLjaBoC9ThygE=;
 b=aDqZ8nG5mW0YNhlNGBTQLFLIeXphZjTO8UHpj8YROz0CUgVDSnqg0srOOXSbC6VxD9
 ppCZegiHHxuNu2CbKG4LfS4VBHyC3zjmHM++vkWttc+xY7o5K8MgyrXu84l+Bi9F+/0w
 DaeqemKJZuD4+EfKWg6JK6NXKvfJu3Z3HQvcaaTusdEC8R4oQkCaLjBK2V0cMlTeRWUL
 AEhikrbnCEN7hNn9O8uqHzwB5IklBIRuwBDCrOOoF9Tiv/jJ+ETFtM43zAnCI8TCDkrK
 OBPcpukeXPu/iGCsk3SMq8BesrmI0z3tEnWOdtVtZG6z95gVwt6uoAIk4oLjJxVQJ0hF
 DTEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773828344; x=1774433144; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5ImvG9rvTHH+Bj4mOwgcCururl81itA0QyDqlpYRp8=;
 b=Q8v3vkeQJ0GAt8XdZFgKKMp+nVA8edymuJmZHUJ+s1Ow7cPW9bCb31C8FEXIXb2DFX
 rKEmCw8OhciG5yovZIViLvGfdMSq+QcprU0NPb/zFlDl+qc2RVgnGUPRF90ysyI+Lj+X
 bQDE1rynf9Ueefyt0jfQo8xJE7YczsNwWlhoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828344; x=1774433144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e5ImvG9rvTHH+Bj4mOwgcCururl81itA0QyDqlpYRp8=;
 b=QMdNiLQ97sHut2VuMi2A0zkurg7ELa+PHk8erABlhqarA5qrkUjLnBp+IzumKq/Q7W
 aGKXmMb20KQUmV+Lz29ZCS0D84B9cmTIkI/YvpSvaYzlDjggZJF/dBDkkKyLoWDNkjY+
 95YdIYbSiYBsqHI5g2CEPPyX77Z+Pz2b4IAJP3cRLF60wbS2EqOZqQleabMHwL87sYYe
 3EL39rOX6qnYE3TAoAmVcl6de3tiWzWe4sOScUnKXoYKASYR/Wcf4LBUaqtOEoTIXwJr
 tba5Wi917HYAMkiLfgDf1qQloGYVsJzBpvLD3yY5guF18axXFduZhIVFKXth4rTBYAFM
 f91Q==
X-Gm-Message-State: AOJu0Ywsc2OHNZZBjcLaOG4DZxfHK4KQNnxQikPlNbftVwUQtsCCjhPh
 T/hthvwL8EpDGt5xe4wHOnd1d+EybBu7sfnmbjSSlv2SEmAdnWOFOmdkOp2AHS19PtbhezNzc/0
 mzoyUydCV3k5BU1p1u75DexHjAJgIlLyjgqS0B3qObw==
X-Gm-Gg: ATEYQzyfm6wPrxQg4F2SQON+Rg43wj4APgal68NcpO64ZxMqgPeAi4SGC0kmLJ3g8dU
 LE+KVZtdDaxsG7GwOrIH1+BLK3VCCkT2sxGpKYrBa9Fa3Z9cAM3CASTLl2bZwG7O1YoPdxstzgz
 d4Y9CTsQ9kDLtP4+zuFVzp1N1ap2F7ZpvaSdF/ASvyjYL/WDd+AnoIpz/W16J1dLGe5cZssER4t
 Hwb6RO0klh9mBPrxNHR5VmE3iKL0Ef6Or/tBOIgvy9wHZyLozR4I25+6ZzZF1H6M6kUKOXuiJjq
 IEt2TSBAE8C9VwfFX2hdzVUpZeSj5C3bAQOpLY0=
X-Received: by 2002:a19:f012:0:b0:5a1:422b:275a with SMTP id
 2adb3069b0e04-5a2796c30b1mr752542e87.38.1773828343609; Wed, 18 Mar 2026
 03:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-3-alexander@mihalicyn.com> <abnKKguESqlptJdp@x1.local>
In-Reply-To: <abnKKguESqlptJdp@x1.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 18 Mar 2026 11:05:32 +0100
X-Gm-Features: AaiRm50bZgokqrBrtrTQ8hZa9fwZG1VRdmGygDVLGMm72WKgHJBWhnIeZbHNr8k
Message-ID: <CAJqdLrrH2OD3+N+KOiSLB8MuWaaNL2PAg6A1j9e4JByWidwdZw@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x133.google.com
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

Am Di., 17. M=C3=A4rz 2026 um 22:40 Uhr schrieb Peter Xu <peterx@redhat.com=
>:
>
> On Tue, Mar 17, 2026 at 11:27:02AM +0100, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC, which
> > helps to save/restore a dynamic array of pointers to
> > structures.
> >
> > Suggested-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion=
.io>
> > v2:
> > - added VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC
> > v4:
> > - almost completely reworked, new flag VMS_ARRAY_OF_POINTER_ALLOW_NULL
> >   was introduced as suggested by Peter
> > v5:
> > - rebased on top of https://lore.kernel.org/all/20260304212303.667141-1=
-vsementsov@yandex-team.ru/
> > ---
> >  include/migration/vmstate.h | 77 ++++++++++++++++++++++++++++++-
> >  migration/savevm.c          | 26 +++++++++++
> >  migration/vmstate-types.c   | 91 +++++++++++++++++++++++++++++++++++++
> >  migration/vmstate.c         | 54 ++++++++++++++++++----
> >  4 files changed, 236 insertions(+), 12 deletions(-)
>
> Hi, Alexander,

Hi Peter,

>
> Sorry for a late reply, I didn't reply to your previous version on patch =
2
> because I didn't yet get time to really review this patch. It took me som=
e
> time to figure out what's the best way to do this.  I still think it'll b=
e
> good to avoid introducing yet another info like what this patch did.  In
> general, I want to see if we can reduce get()/put()/save()/load() rather
> than adding more.

It took a while for me too, and I've failed :D

>
> Meanwhile, there're small issues here and there I saw.
>
> E.g. reusing ->start to cache the object size sounds too tricky.  I am
> trying to figure out if we can always stick with ->size to store the obje=
ct
> size; I'll need some even pre-requisite patches though to convert some
> existing VMS_ARRAY_OF_POINTER users to reserve the ->size field for that,
> though.

yep, it completely makes sense. I was using the same approach as we have fo=
r
QLIST/QTAILQ/GTREE, but I agree that it's a bit hacky.

>
> The other thing is I had a gut feeling this patch may have issue on the
> JSON blob dumped in the migration stream, via the JSONWriter* object pass=
ed
> into vmstate_save_vmsd_v().
>
> All these made me feel like I'd better go prepare some RFC patches, becau=
se
> commenting will be too slow.

sure, thank you!

>
> I'll likely send something very soon just to show what I meant, it'll be
> good if you can have a look at that when it comes.

Kind regards,
Alex

>
> Thanks,
>
> --
> Peter Xu
>

