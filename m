Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B313F8D758
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDOMW-0001dJ-Dc; Thu, 16 Apr 2026 11:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDOMU-0001d6-VV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:10:35 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDOMT-0001g5-Dp
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 11:10:34 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79ea87af213so11662997b3.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 08:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352232; cv=none;
 d=google.com; s=arc-20240605;
 b=kYzo2MbDmt6vhGGlXxhUg0qZ8jScljttwcrmhVEyVpiPk1aK9t9695YCIFUz9UnqSV
 MoIKymYB9KLqHL7tHi/9XaKO6fHqNjC6zeRA7kG3vwuMR97kE478dv/nn2S2dYHwKJYB
 czYPzfqavysi2/yLQcWDD1pQKxuY48lyYxZnmRw2bAI8+PVRJ5zRBl9y+Ax8NgclR+mu
 ujZn9B/9WJgVC6NljE8tvrAjc4Ku3hmsL8DdnbcRsWtZZwCgv5dLQSdUogN862CS/3Vx
 E6MlkRatBFXKgZzYHyXBGpp9w40fbSrCDvy3Ir/prcCrWJEmV2V5UEfHiP8QbJwHgzu0
 cJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ay/xT79tumIsvGOuKM+3HVLVNXsLPFEg+b+LWCp7Q90=;
 fh=yaPSKUJydE8GPG0gagCK0Pgig7hJS8VHDRsQea6XOuY=;
 b=HuB9QKJPNMDBTHwFHppNbZ7Lir2GESH4h+K3Sf4BZdSOfQalF13JuXH4IjtcYXvswA
 SwLrxj7wlZSUxusyNeTd577Fr1BrJgMJ+VsIFP7/LAGY4ID89woa9uzh8aucPQQs/5Ib
 Qydgy/VMQCpjBCFUbyjWRJHhLq+z8AmR0WEL0GR89CNvwrJyBDIdo6pABaiHKJoDudKJ
 kRErs9drSVMHcoky46qIpvNXcK69i6+u4ifO9jRmEmdRQUYMusVLQU2U4R/0rBCjrfAz
 +TSeFvyFxTJvs7q3OZjAbtoTBmOdD5pcrs9fG508q0bcSoy+npJ/QW0RDJxILPlPwUf4
 64cQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776352232; x=1776957032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ay/xT79tumIsvGOuKM+3HVLVNXsLPFEg+b+LWCp7Q90=;
 b=r/y7VpzGuOu3+JPyRUe1XqTUJmedX+0qfdZOiWGJ8eU7xDjwdDM3v1sttOFsFcg4NS
 bvQNUIoIJgBACLZf7Bx85NbG8tnM48KltK+3K647lRMHYKi7xyJXhCeR/IEUSb2Z7g08
 FVFWag2Rjl8fWMhxIvXHGk3ZHoGralC+tRQM5eC1brCt2xpfFVk502EA00hEGqyJsEyh
 TxZS90P+pKiOoJD6scOUtQchR0rIitt8ZSUPn9ijOK9Rxe7f5imOTeg9TgIc4Eryyasv
 PF0zs2Hwd86dzFuCC5QOjeIL7SB3VLW98PJQ9fzGaaHxD2ylJtgk6wz0Kxmg1z7Bvudw
 K5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352232; x=1776957032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay/xT79tumIsvGOuKM+3HVLVNXsLPFEg+b+LWCp7Q90=;
 b=fel3Pn/1BhdhL4eRCjv2NgSxLJNXIYT2hX8Af+39AfrS3vXb5dbfDwb9U0hNZ9ncEG
 JIIp+NzyZz4CfduJhiwd14gb/9EchO28ECSTuJmGHJWFekJ0KCm0E1UxIT4iKozdXjq1
 UmeJsAM3RCdAL01cnzYtBTUvwLDd6Gt51RtAWPwuxwyAYwqgoWGLJkx2Rhqfy3Nt/jVV
 A8MSEXa0MyYFatHnsT0CBe8hMWCS6KN/PQmIIWb1rF5Yh2MbQ/YhRC0cqu9r7uLjY6Vq
 V1pZEzU3WuxXbYPy8B3Xm8iqq0ZJpLUjJ+DRR7y6gDb1bKFUcxRnF5dFh4n5IbljrTVo
 DDgQ==
X-Gm-Message-State: AOJu0YzJiV5MQWBCdxyIjig6sFqLa/zEvJWrGyC/3pDRwiVKB/p6dmZC
 AmMaJMmL4FYXdp8qMw/432S9tlKKbZQ5kb12cX02xOQu3Ros2NRmq25UYyuMD9N+X/9xIJORBiR
 qIQ6oJERjDGN/XzcWIM7oDkbCpH3aQNx/3x4hXlEffQ==
X-Gm-Gg: AeBDiev0dOBfHyHjiu4txjaX6xo3WfhK23Rgs0vdYOtKKItmlsZAlofN8BDb/029enN
 yfcIltiNXY9ajv1zzO4UPfWrsfMQ6mSC3qQ7lvSUaauCHMjdwkN7AhSAGyBpJKlgVq8wXf6JaUg
 0WTPbDdyMLSRjrTDMOBRgjF14izJYdgskT3UuzuMdz5XjY4QdS+A3R+jEsEhdO4wPdqvV361Vab
 qtHiys7PSmhHBEJ6NXEEZs6HTYKPgxgpyVSaYRkbZVwaAaRAengTcBBqa7XDjVpdCQy8UGYt8qo
 PbAF3hhdaB3A9XhKDoRBLj1NbJBV2A6clPxQD4LVnS6cV0saDHrAV+4GIJazWUpVihzl7gz2xOx
 pXQ==
X-Received: by 2002:a05:690e:1687:b0:64a:d18a:66c3 with SMTP id
 956f58d0204a3-652f65a3a4dmr3347246d50.48.1776352232105; Thu, 16 Apr 2026
 08:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-29-peter.maydell@linaro.org>
 <20260416165801.5795ef14@penguin>
In-Reply-To: <20260416165801.5795ef14@penguin>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2026 16:10:20 +0100
X-Gm-Features: AQROBzBnx4EOor6DhpuaB-KcX59L9mAIi0ydpIhIAX_KFnjGaVYrQPVNMCMVTi0
Message-ID: <CAFEAcA-eVwwpRXCZWAg24gMKBsEhwu_6V77PstA=GUYEha+PHw@mail.gmail.com>
Subject: Re: [PATCH 28/28] MAINTAINERS: Remove Xie Changlong
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 16 Apr 2026 at 15:58, Lukas Straub <lukasstraub2@web.de> wrote:
>
> On Thu, 16 Apr 2026 10:16:54 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > Xie Changlong has not posted to qemu-devel in some years and did not
> > respond to a query about whether they still wished to be listed in
> > our MAINTAINERS file.  Remove them, on the assumption that they are
> > no longer active in QEMU.
> >
> > This makes the "Replication" block filter orphan.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1fb56bdac8..a50e5dbaab 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4382,8 +4382,7 @@ F: block/export/vduse-blk.c
> >  F: block/export/vduse-blk.h
> >
> >  Replication
> > -M: Xie Changlong <xiechanglong.d@gmail.com>
> > -S: Supported
> > +S: Orphan
> >  F: replication*
> >  F: block/replication.c
> >  F: tests/unit/test-replication.c
>
> Reviewed-by: Lukas Straub <lukasstraub2@web.de>
>
> I will take over maintainsership for this component.

Thanks for volunteering. I think the easiest thing is if
once this series is merged (which I'll try to do early in
the 11.1 cycle) you send a patch to add yourself
to the section.

-- PMM

