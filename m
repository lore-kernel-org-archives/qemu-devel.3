Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF2ECA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 17:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqxkQ-0005xs-MO; Tue, 26 Aug 2025 13:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxkJ-0005tW-Th
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:46:14 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqxk7-0006S8-La
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 13:46:11 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e96d65194c1so1576890276.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 10:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756230356; x=1756835156; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JnB79UeR1JR2QHdamVbJtuX1Gne8UdhR6ShXKkmGj+Q=;
 b=Pp9uWG7UaXNTMujmKvK6xCHiE7UNDcN3a5KI5Mwb/bvJEfcEiSWJz+xdF5xsEZsoOk
 pwMSfER593ch6VJt6vKo4+XlWNpGv6BYhC9pCuEYlQO0/OlGKDaXDMpKUwTrIL8QFqSR
 UAJMAJHOM0cHjusdkHg++w5oLge6sOiIe+X3uWj8u65BB+/GoozksPkZ1umeFC1lqWI2
 B3mdng503SG+W/oPqWnQ4D+EMU05S2vYx0afQYuXEqihBoq3sghq/MX0ttMzxRiL+vV0
 BAV/rSbDw0xR/tSSrNdm3KVlX7mrzoNHqeMJwceG598MpLtcGomrU2qdI9u9I7nSwMwi
 eqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756230356; x=1756835156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JnB79UeR1JR2QHdamVbJtuX1Gne8UdhR6ShXKkmGj+Q=;
 b=Bcjb42+M8o3b+H7H8gUNUP471NGlzRYBRTvSSPy8iDK0q37q2ji5VLuuKG1+a1D87Y
 EKFBgDijf5YGqiksAa6Uxps9v2iNkCTe9iT1VJPj2ooJdC05sG4BHq9xy7eyuOXTxrqV
 HvakGhgSwPl5fPCPRH1xOFznDMlmPirVH5et5KVDJSwofsVF+sFX74q3zbXRqePhdtz0
 ViEmS3IsDQtU7gmAFWGg0fjQpxCt9lMF0h+Lqc8xhyVBXT9oA7aUN8IdDc6HYUvkC91z
 2uwnaVV7djtMcIoZTkJicmnuHflz28j3EQNK5Yu76/qoQXzYTMFB4542dWKOZAKtSs9U
 hE0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpahwP1Mb5y0u2z1WhIf90gFdBNhaaOZ5bznYsyTfIrWi1D8n3hOjQx9icvL5HKOlpqmidfUENFlCE@nongnu.org
X-Gm-Message-State: AOJu0YySHFH9+7lRMSUETbSh4zlZD9tBgXuf2HbHF1Cys+pJva9gXmPf
 se13ZyMThqW5imyfnVQAmR05B03wxrpJjoMS+U3x0TZyU75PtM41aS33jBCPBbdcwhq5JYLDKz3
 C1q535QunBLAJplaSdvwo9LaNkGs7OJU4xjac4iyOoQ==
X-Gm-Gg: ASbGncslAWOGSNav3enVwvnoY9xlGlyPsNNyk+I1uWViQc8Y3b8wT0P+TGqGeKEIrV4
 fMhKjv1O2wt7taooLChgV+bWBICjJFbSEErYR0DYDMAO3qLKJV8+UaoV7DayYYVY/cqWzHOISqF
 j6FDDbKbY2sMtSI37cLLDrVRaZHqCWH6IgJlZ04ZPKqKQwnHM35IlakxGHN+SwKGkbp+dSiwG/C
 AoqKL6tz7Bk4HWw8cI=
X-Google-Smtp-Source: AGHT+IGgs89pFH1ao75VYrI7xULLR9SIG/Ps//4C4VeI636bW2tosrmBKGv4VHaP53q1qbtUTYv4mYetbQHhp0ZQ4vU=
X-Received: by 2002:a05:6902:3103:b0:e85:e81d:9e20 with SMTP id
 3f1490d57ef6-e951c2c8547mr15084023276.8.1756230355778; Tue, 26 Aug 2025
 10:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
 <aKctCjv8newNIX71@x1.local>
 <CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com>
 <aKdizYeNGocXvTzv@x1.local>
In-Reply-To: <aKdizYeNGocXvTzv@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Aug 2025 18:45:43 +0100
X-Gm-Features: Ac12FXwbHF0IcY3qkjG8MwMWRb2CfvAn1eqpRbrKYzB85B0dUz-BnOMGItlMk-4
Message-ID: <CAFEAcA8dKu3mSuD=rJkwDPcvqQASsOpFPdpG4Ht59GrTb+AywA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 21 Aug 2025 at 19:18, Peter Xu <peterx@redhat.com> wrote:
> I remember I provided a draft somewhere during the discussion, anyway.. I
> redid it, and attached a formal patch below that will contain the removal
> of the mr->container check (plus auto-detach when it happens).  The hope is
> this should work.. and comparing to the v8 of Akihiko's, it won't make MR's
> own refcount any more complicated.
>
> If necessary, I can send a formal patch.

This patch seems to work, in that it fixes the memory-region
related leaks I previously was seeing. Review comments below
(which are only about the commit message and docs).

I also can't remember the details of the previous discussions about
these patches, so I'm reviewing the one below essentially from
scratch. Apologies in advance if we end up going back around
a conversation loop that we've already had...

> Thanks,
>
> ===8<===
> From f985c54af3e276b175bcb02725a5fb996c3f5fe5 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 21 Aug 2025 12:59:02 -0400
> Subject: [PATCH] memory: Fix leaks due to owner-shared MRs circular references
>
> Currently, QEMU refcounts the MR by always taking it from the owner.
>
> It should be non-issue if all the owners of MRs will properly detach all
> the MRs from their parents by memory_region_del_subregion() when the owner
> will be freed.  However, it turns out many of the device emulations do not
> do that properly.  It might be a challenge to fix all of such occurances.

I think that it's not really right to cast this as "some devices
don't do this right". The pattern of "a device has a container MR C
and some other MRs A, B... which it puts into C" is a legitimate one.
If you do this then (with the current code in QEMU) there is *no*
place where a device emulation can do a manual "remove A, B.. from
the container C so the refcounts go down": the place where devices
undo what they did in instance_init is instance_deinit, but we
will never call instance_deinit because the refcount of the owning
device never goes to 0.

Further, even if we had some place where devices could somehow
undo the "put A, B... in the container so the refcounts go down
correctly", it is better API design to have the memory.c code
automatically handle this situation. "This just works" is more
reliable than "this works if you do cleanup step X", because it's
impossible to have the bug where you forget to write the code to
do the cleanup step.

> Without fixing it, QEMU faces circular reference issue when an owner can
> contain more than one MRs, then when they are linked within each other in
> form of subregions, those links keep the owner alive forever, causing
> memory leaks even if all the external refcounts are released for the owner.
>
> To fix that, teach memory API to stop refcount on MRs that share the same
> owner because if they share the lifecycle of the owner, then they share the
> same lifecycle between themselves.
>
> Meanwhile, allow auto-detachments of MRs during finalize() of MRs even
> against its container, as long as they belong to the same owner.
>
> The latter is needed because now it's possible to have MR finalize() happen
> in any order when they exactly share the same lifespan.  In this case, we
> should allow finalize() to happen in any order of either the parent or
> child MR, however it should be guaranteed that the mr->container shares the
> same owner of this MR to be finalized.
>
> Proper document this behavior in code.
>
> This patch is heavily based on the work done by Akihiko Odaki:
>
> https://lore.kernel.org/r/CAFEAcA8DV40fGsci76r4yeP1P-SP_QjNRDD2OzPxjx5wRs0GEg@mail.gmail.com
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/memory.rst |  9 +++++++--
>  system/memory.c       | 45 ++++++++++++++++++++++++++++++++++---------
>  2 files changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 57fb2aec76..1367c7caf7 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -158,8 +158,13 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
>  as soon as the region is made visible.  This can be immediately, later,
>  or never.
>
> -Destruction of a memory region happens automatically when the owner
> -object dies.
> +Destruction of a memory region happens automatically when the owner object
> +dies.  Note that the MRs under the same owner can be destroyed in any order
> +when the owner object dies.  It's because the MRs will share the same
> +lifespan of the owner, no matter if its a container or child MR.  It's
> +suggested to always cleanly detach the MRs under the owner object when the
> +owner object is going to be destroyed, however it is not required, as the
> +memory core will automatically detach the links when MRs are destroyed.

I think we should not say "we suggest you always cleanly detach the MRs":
instead we should say "you can rely on this happening, so you don't
need to write manual code to do it".

The actual code changes look OK to me.

thanks
-- PMM

