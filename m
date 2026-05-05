Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B5ACD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKGL9-0001xB-6N; Tue, 05 May 2026 10:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wKGKx-0001v8-HY
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:01:31 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wKGKq-0002lb-B8
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:01:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso8245727a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777989672; cv=none;
 d=google.com; s=arc-20240605;
 b=IhWHXv6IXKT8VkPE57llG91Bh81rIqJTbbqmRezJMHYAp1GiAM4j9EaztYDP9hRLni
 x+cgD36ii02UdCeoe5r4lOgmfM4OSvrZjyuJ9Cmkp+bVV8WATKZAgFg22AhFNaUeeBrn
 bZDe6jRhlDSAUPy1ubuHHBbFr0nSkGiTKKu0tBhZe/5SxpZdQsRrCTq2O7DgAZExTu6R
 ALC9Tn3fatJhidlVF16IQ+8oNP64+ZhH2gADpfdfvxqKJvkrWTCB40h0OuaC1xCxB+q6
 g/NufgR2bTsR6GT0s33aBvkwQ3tkhnCyip3J9bsre8BkS355BD2HvYDVkyg9QztYw+1u
 93yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TusxZum7fHOq7YOcoycgz/1GaDUn5NnYfl2ONeiIImM=;
 fh=nuETIhhrjDx3zGe6bCzSe94wBdKnqdNcr14yViqMafs=;
 b=MBoCTefGFb90UPsODH9fUtLyMgg7k3+4zSQySUyeeObpyg7qM/A0Dwdl3+xNDunFaC
 c+Ssx5ECOyxW60GlwUerndgZ8YFiJSSQMW3CwnnDarxR5SF8gnLvT/Ao+6vWsgIZQC8D
 lok56/v7FVI+bOT5LxgPe4H0GYlu83z03LQJV42tVYdQtICyYM/HkVxJbgNbAtDMnuSW
 M7hyxicdBYd9oUk9wbdcJd99X+u4pzGLxWbb5z61bKjUUZ29ky80EvUxb1V29EkaxGLE
 S2Z16aZ8ktzsyE3PwR+9zu75HeTWIUrFLs9bgGO3qPh6XJwxVfzSgDzXidBHf7CxSfyS
 GNWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777989672; x=1778594472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TusxZum7fHOq7YOcoycgz/1GaDUn5NnYfl2ONeiIImM=;
 b=tF29nN+XsuCFFHW6wHRRzDMz+Fkh/IMOaD4pqvq2jlGsZlIyJ1YZRqSWnYze0zG8B4
 xEwcEX6k6vRDiDLQFjU+R22CD4L2gly98DRXJKuemSOIuu+zOci2SAEXAcacnmX44STH
 2nvOH69owtRwNYZ7UI/BTx7xiEeL8P83AnhdiBcGll3J6RkQFZRBUqlFuwro9JjDswXH
 jSrVrLErX/O3CxkCk1meymw8vMWTTXpf1SDhlePrYOj2vzhlLYEjZW8r+03Uo9buMQpt
 uYH4Kt36vcPB1liz5ifAMynzsiPl4N/rEhCKspbqryrZXFp9By8sRcgZOdyQ0gWhVyBh
 aMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777989672; x=1778594472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TusxZum7fHOq7YOcoycgz/1GaDUn5NnYfl2ONeiIImM=;
 b=lrqF+qCzlM7JfNvwQyH4QaIVHN4nsrbVWPtUtIuu/KXT858Pz+xlWvPmWeAtDvvzg5
 8v/qG/fyqdM1IKEh7M3KKQUo91FadaLvNNnZ87PYKq5jBDtfHrD/KiMfnhIzHuQ+bBs4
 JBv1vE8RTNFgWVMrjbQL6bnr5DyM9bJXkA4MdebmAdhH/dY0OeSjHlZ5y2Ttjvz9QfpM
 YRdXdzNJ2yBkCXVo5GHhqSdwyqLnfiPPUoFm+OC8eMLNBoF7+q5UFkFevAxEKx9234Za
 TeSIsM5OR/NV1hBEPi272BPENVU9ofe7qU0xBJ/W5MjEO/FW/dKXSCUl9AaF0pEr9yuc
 EhFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jpIHN3h96LO/BzkD2auMb9F+w38ahegvJs5En89bZQOQF2d8qaFziaCOHJlx7uadi0HaSgcZ/7lw4@nongnu.org
X-Gm-Message-State: AOJu0Yz7R3QfOdZiTV1+elWvGLGScZdgUIk3ucTQ3Tz4mt9XBMjEmvgb
 79DsiUpUxj5hGZclkrp5Cf6FiCCVs3axCGW4F+z11/UUYzZce+WxTGCvn6otK/ZCVqlr1bHqE+7
 o0zE9900WulxYj9RclCrjOsUNKcl831c=
X-Gm-Gg: AeBDiesa61uofaVbxJsEFnz0CKIQztc36o/IupI6QjfUBlWV9Wzz3Zqr9lUS2yTDOZI
 TnKHi15NgOIpa1FHui7ZeDV+WAYhg1Pk5eD4Rcy3pxOuKKooItF++FTwYJu/suJ5VOdjzrkPgie
 LuB9LAh/R8bUqm2SfFDMmKwGykbrJvPPwXUcjT2wJ8zDDip/xRHWD9Hg9FZ7vjaLW3ZulRAULp9
 Z7JEw0OJ+3eKTg0ajBlXezhMyd0tloPfklf+qg7rpEDzltOickVa28IAsA4ldKwtitQ+ouSqIdo
 osmHPvmZf72umjXG3h9v3bXLGDmfAPmMdutewzljssRaZSKT
X-Received: by 2002:a50:ed13:0:b0:676:d851:447e with SMTP id
 4fb4d7f45d1cf-67cc37acf74mr1318916a12.4.1777989672014; Tue, 05 May 2026
 07:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260505123502.1316554-1-armbru@redhat.com>
 <0f68fa39-f190-420c-a55a-f31a7b95663c@linaro.org>
In-Reply-To: <0f68fa39-f190-420c-a55a-f31a7b95663c@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 May 2026 10:00:57 -0400
X-Gm-Features: AVHnY4I_FhjtFRHrNdmaqLBYjgZXOrtGC9tkVOvEJhGn_v5OocsmG1BZJ20BAl0
Message-ID: <CAJSP0QWVdSHvK2g8jncEL40nR=yp65LGZJ6z5NnsKM8ey2Oh_w@mail.gmail.com>
Subject: Re: [PULL 0/4] Monitor patches for 2026-05-05
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, May 5, 2026 at 8:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 5/5/26 14:34, Markus Armbruster wrote:
> > The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac71=
1ab1:
> >
> >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into sta=
ging (2026-05-01 14:41:49 -0400)
> >
> > are available in the Git repository at:
> >
> >    https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-05-05
> >
> > for you to fetch changes up to ea017f67ce1ca34c7503b6f23f48b433585d37ac=
:
> >
> >    monitor: Add `clear` command (2026-05-05 13:53:03 +0200)
> >
> > ----------------------------------------------------------------
> > Monitor patches for 2026-05-05
> >
> > ----------------------------------------------------------------
> > AlanoSong@163.com (1):
> >        monitor: Add `clear` command
> >
> > Dr. David Alan Gilbert (3):
> >        hmp*hx: Move info docs
> >        hxtool: Split srst/erst add checks
> >        hxtool: Error on missing docs
> >
> >   include/monitor/hmp.h |  1 +
> >   monitor/hmp-cmds.c    | 11 +++++++++++
> >   hmp-commands-info.hx  |  9 +--------
> >   hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
> >   scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
> >   5 files changed, 80 insertions(+), 21 deletions(-)
> >
>
> Obviously this conflicts with the PR I'm waiting since 10 days to post:
>
> $ git merge pull-monitor-2026-05-05
> Auto-merging hmp-commands-info.hx
> Auto-merging hmp-commands.hx
> CONFLICT (content): Merge conflict in hmp-commands.hx
> Auto-merging include/monitor/hmp.h
> Auto-merging monitor/hmp-cmds.c
> Automatic merge failed; fix conflicts and then commit the result.
>
> Sigh.

Hi,
What is blocking you from sending your PR and who can do something about it=
?

Stefan

