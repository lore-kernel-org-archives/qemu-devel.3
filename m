Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B38C77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6g-0005VT-2x; Fri, 20 Jun 2025 18:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uShgs-0007st-75; Fri, 20 Jun 2025 15:46:22 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uShgq-0006WW-F0; Fri, 20 Jun 2025 15:46:21 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-607cf70b00aso3915683a12.2; 
 Fri, 20 Jun 2025 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750448778; x=1751053578; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJ0pcPmPNxlXz5k55TMDmWuhtchWLUkYb+RZhz6ioek=;
 b=HLPBPMFcIEpzH0LxbtfyXoBmhUgcel94k1Qx6W0gYLWKAGySB5VJHnpqJbDgvQ9pkF
 EoGcuhD/P05R3LuZdORSiaW92nWws95Ns9tZnLCbq4O7lzuml1JgUTC2TIu8HTe7orAn
 5lqnjB4rQlrpA7qSov0yhtC03TYTMxr0DiNyhbZ4ImCnap6xk9x/qLU/whBBhiBfhEGA
 Wafrhh1vssXwnwJ6NUN2WppsMoTLbZIu21L6xubFrATqqbwtD0hFmpfsw5xuZ6wAd784
 bmxxd54N4vdfwU96uB0/BXEtTy/LSq9pbZijqwBZ8j2zNC1M9dYPGvU3m3C8A/4DW9R8
 7flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750448778; x=1751053578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJ0pcPmPNxlXz5k55TMDmWuhtchWLUkYb+RZhz6ioek=;
 b=qtgxYOoNlT4m/I8wPcgnvOQIvEJNbaHxMJXgdXkFNfEJP0SYSosjlX8Y/qK5ZUOqQZ
 ksggD6N4epc20iFVpMFBLkjJF24lP4F/Md1Hrq1+BOriXCJHqVHx3KFdBYkcxg8fNGnM
 CoQpltz/m+lUbvYusVxYmjfPgQJ9yE5drs5tIjt/ICYQl9HhRBVcWHrtv9eQG1tGQDmD
 TU2CD4GyiHAOtRbMPu1nz81MvdTCLExJ4vBRNG4ZB4qzGKLRzP7Awgp9NzLljsOohpIs
 cJ45Bmg+79ajKEAN/49nzGXmL6KYZjWz1SY6oR9u228PJ2ZmXXUKZG+W03woPOOyvuWS
 IVFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUpUah4U5SXhtDDOLSXYv2FH/UvGCuX3Q6h7Lk9NLiGeoOOTe5UETUi/AfF/CnK/V/2DiEdHumX0BkoA==@nongnu.org
X-Gm-Message-State: AOJu0YzMsYud2snbThX0E5UrMzXrodTGofEQXDupxPnUMZiXJBWaftT3
 2vcD+LxI61Tq99UqOpR+VOO7swXjmzEwl7bUc9ke9dTK8uh1X0XqQKVA5uVWnfYP7Qc6YErjg8T
 KhtNo9egH+ROYVYpGjsmhXTi4COVn94M=
X-Gm-Gg: ASbGncs558tq82I45SiDyTBsW4v2vO1+7rAjTI6SnqvO8XB+bQQ3QQOyg/wC+wlwxiA
 37f38ifqJz+OpBuZGvkORlrLwik9hsm28oth1jp4vyXTKsZkYB42ZS/KJ8v+8H+BRXBjPc01U9x
 ONel6CzcIPMEWy3Yh4Cg5tMRt/hLRBs0Wf8hLePtk8/y0/UFI2ToDR74rUPL+YzKcS2x14F5X+h
 ue5
X-Google-Smtp-Source: AGHT+IFTUsAi2KjyLrk55jgA9DmRTcLJNm5fppdOgPw0JxW2PZRqa0LVNp752FrrzQfeqUP757xtVkynnCHrYC8dCEc=
X-Received: by 2002:a05:6402:524f:b0:602:bfc6:f99d with SMTP id
 4fb4d7f45d1cf-60a1d18ef14mr3692258a12.24.1750448777945; Fri, 20 Jun 2025
 12:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-13-alex.bennee@linaro.org>
 <d504e5de-cb7f-4eda-a046-9edef5d23749@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+hS_jUtitaeqYYxHN6q9ijqBu=Zyviid+EJc2sJ1yQLRxSDQ@mail.gmail.com>
 <877c16ud1r.fsf@draig.linaro.org>
In-Reply-To: <877c16ud1r.fsf@draig.linaro.org>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Fri, 20 Jun 2025 12:47:59 -0700
X-Gm-Features: Ac12FXy1GgU7Dny479F2x0oDs3ckWuuEu4HSoCjGpnQBdyvl50zBfYYE81-2hAQ
Message-ID: <CAJ+hS_insLDZRmQhVWfbLxqzdA4oWXYGHHOkFVJTdz3TucYqjg@mail.gmail.com>
Subject: Re: [PULL 12/17] virtio-gpu: support context init multiple timeline
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x52b.google.com
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

On Thu, Jun 19, 2025 at 11:45=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
> Yiwei Zhang <zzyiwei@gmail.com> writes:
>
> > On Sun, Jun 8, 2025 at 1:24=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/06/06 1:26, Alex Benn=C3=A9e wrote:
> >> > From: Yiwei Zhang <zzyiwei@gmail.com>
> >> >
> >> > Venus and later native contexts have their own fence context along w=
ith
> >> > multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX=
 in
> >> > the flags must be dispatched to be created on the target context. Fe=
nce
> >> > signaling also has to be handled on the specific timeline within tha=
t
> >> > target context.
> >> >
> >> > Before this change, venus fencing is completely broken if the host
> >> > driver doesn't support implicit fencing with external memory objects=
.
> >> > Frames can go backwards along with random artifacts on screen if the
> >> > host driver doesn't attach an implicit fence to the render target. T=
he
> >> > symptom could be hidden by certain guest wsi backend that waits on a
> >> > venus native VkFence object for the actual payload with limited pres=
ent
> >> > modes or under special configs. e.g. x11 mailbox or xwayland.
> >> >
> >> > After this change, everything related to venus fencing starts making
> >> > sense. Confirmed this via guest and host side perfetto tracing.
> >> >
> >> > Cc: qemu-stable@nongnu.org
> >> > Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
> >>
> >> I suggest moving this in the front of the patch series to ease backpor=
ting.
> >>
> >> I also wonder if "[PULL 11/17] ui/gtk-gl-area: Remove extra draw call =
in
> >> refresh" requires Cc: qemu-stable@nongnu.org. Fixing -display gtk,gl=
=3Don
> >> for Wayland sounds as important as this patch.
> >>
> >> Regards,
> >> Akihiko Odaki
> >
> > Hi Alex,
> >
> > +1 for Akihiko's point. I'm also curious when will the venus fix land
> > in-tree?
>
> We have a problem that there are two contradictory bugs - one that shows
> up in the x86/kvm case and one in the aarch64/tcg case. Both are caused
> by the weird lifetime semantics of the virgl resource vs QEMU memory
> region and we haven't found a solution that solves both yet.

Sounds like irrelevant to the venus fix. Might be worth filing a
virglrenderer issue with some details. More eyes would be helpful if
this turns out to be some known kvm issue seen before on other vmms.

>
> I'm currently busy with other stuff and need to do a sweep of my other
> maintainer trees for 10.1. Once I've done that I'll have another go at
> coming up with a solution unless someone else beats me to it.

Understood. Hope there's a chance to move the venus fix up in the
queue to land first when you get to this again. Thanks!

>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

