Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE7DCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUn18-0001hl-QJ; Wed, 03 Jun 2026 10:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUn0x-0001cw-Cl
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:56:16 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUn0q-0005N2-5U
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:56:14 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68d233bf083so6234302a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780498562; cv=none;
 d=google.com; s=arc-20240605;
 b=UMMgfoiSn/Dni3YBmUtlIz9L7AVm2V1WYcztrJM63Pd3p6n50P9w24hlcJsKirLW5R
 Vf+FXTj8JWnXdFKec11u8T2T0ntd6HmhmiZ/5AKx9up/2hb5ZhGx3X634/bTQVOaab+y
 JxFB6upXd/nMGqWVVxQdBdIwAlDWAkJyIn3hRfFcE1fveWc2flseRBindsoBqGkYzxAM
 47gRI9lWgLK9dzVuGAFdN0igWLsAeMuj8xvjHhpxKkqwLLXklP+bIFE8hWGd2A1MtYoP
 ES33ZbLOvsjcBp2Bx4wa601bV8QjtxOjNaacN4+eBiMLttZpg1ZniTyb6vONhw+eNUnS
 Sc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kngxHtyAW8op42IQBbu+VIrnAtAexnw0h+78Q0qyiNI=;
 fh=01/dSCvQlBbxzlxhwDdQw24l/G6oZBcCNz4wC7cjpow=;
 b=bpErv5C65QHoiwMQ1KSBT2OGretkfI8k3ggF3e4Tt9rR2iXk5ncCpIs+GVMS3wOw68
 K4xkt42CiO4nXf8KLEGwVtPoW974l7F1Cew5eAXqw8EGS1faha6+i6Pni5Qxbm9G4JbO
 DaZrAdJYA6F4tfFQMySQ828MsdivnP/jS9MXUrV5nlGTA95I+7jaHfRYRZZSQE/VkZ7z
 PD9x6wK9SMMRPEiQAw6ZLkN8rBbw9s3gk8QTXskFxyfQr1bmHa8EIhOJlFXHl63gFeXZ
 J97LqSSW9TR6AOk6ObBDZdSPFiwxwPLdHBv8X+J4K55Rsd0zg4jx00kOHtEcgRiF3JkC
 4X0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780498562; x=1781103362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kngxHtyAW8op42IQBbu+VIrnAtAexnw0h+78Q0qyiNI=;
 b=s1e4Myewx4AFfLqKuuBkvLZCJq+6U2MQNMN2IXRSn6L6OcSC4QlWfot0sstFYdQR45
 slR+ggFY5HttKH6zA+ve5SSzHwCRJc44w+iQxrR4wahgrSoIjSCQX9f5bhaAITcwgByk
 /PzjtNsQNZfNEZdmypxyR+UWcJvS1+Yl7WYlC/SeU5pOB3axe/UwmmtlgWaAHELRRL38
 m+xDL92fC2aV83dy+pK0mqXHWBjKIOK3XxJrmTLe7/b/cwiPCU8/qe6fWAt3B4sgA7vn
 A7w2P+jXyBt8L4EsHo1MdEci7QgBEMvmmY7/o4G/8LwiV+wiiHuz6h5tPFDTWh9CTtny
 Xq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498562; x=1781103362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kngxHtyAW8op42IQBbu+VIrnAtAexnw0h+78Q0qyiNI=;
 b=OinYYy0NkO3M6GC4jTYqHF793ITaQu0r2LAMQnltLYIK+bRSVZ+q4SourEdLaP4aeW
 5841DG6QglSqsI7ZhDmSUI7IiXDEXZ37Ol75HsUPzl7CfYzd/PqG4djyShKs8FWpag2m
 IZZXOU7qRjP5ZvthJP+zWdb1p7alF4iOLm1EL2bvKMWte05ju/Xknjp9pB4t3v1magVk
 inPkRWl8oiLAEjgpnYLGkYMI/xU17HS8JzbuCKcNrGWh+AN7S3LPPlnbZxrqOJdVlfij
 3Et8VZ/M8iy70EH+lkAzJ/+oa244k2dWUrRDgIFq50pxMdrwW0oDkDUAZlYwQp54D4oo
 U2iw==
X-Gm-Message-State: AOJu0YxIiArIatB3KJ/zBDblWxRRKg49W8EO1aZfQwA4xUveK4JwfLFn
 Zi6vM05GgZwdijFtFIwHi/bfUKrwokNFhvzDslb64HMN4SByIooUuK7OK7zODyJfV886DWU9tLw
 uXgCES4YI8soJhOnEN67LtgtyK5btZV+60A==
X-Gm-Gg: Acq92OF3hbMonMAzPSafzqVeQpm0EGiYrv3oNJgF+ZHkiUqanJstM6odOCijlsA5VLG
 Uo1MPYwypfxFSRd0FRV1hFab0prQweSnZgXJrr/DVAVdiBUMOMesnS+njeLBLAUB+u2d05Ha8+O
 YB9OJiq2CznoXTWRnb/J183ICiOvLniTFWihN27m/Js+D2wwAuGKIhHi+3UEp3eUYLJ0/nEaRz/
 5FKboeS2pB/sVYvMrK7WsiPRr6iLLk5l89GZ/Zq7aaRmRPeSgSGdKSPq2EEkARqHq3Uv2SRAo5c
 atgEn8cRKgI2L2ZcTvDOhXSqN9dammzKKLfUi8roj69aMVOLKqIO
X-Received: by 2002:a05:6402:320c:b0:67d:a63a:deb2 with SMTP id
 4fb4d7f45d1cf-68e6e647e9dmr1815895a12.5.1780498551801; Wed, 03 Jun 2026
 07:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <CAJSP0QW3Qg261XVNdq0T-J63LzRG4xCiWRQ2-U0QgqdtaPCyQg@mail.gmail.com>
 <c82fa01c-2630-49c3-ad02-e9a330ed94a4@redhat.com>
In-Reply-To: <c82fa01c-2630-49c3-ad02-e9a330ed94a4@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 3 Jun 2026 10:55:37 -0400
X-Gm-Features: AVHnY4IKwqZhptrcWwC_7fxYFK2LtHLipFZ-8cTDvlClneWtB1d-aHWoXKVHsio
Message-ID: <CAJSP0QXJW1VkUYz=QOSUaE6vMWPvWj2u34F-4MhMGbUdnxy0sQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jun 3, 2026 at 7:36=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 6/2/26 17:53, Stefan Hajnoczi wrote:
> >> Related to this, and already visible in the incredible uptick in
> >> security reports, is the question of maintainer burnout and the shift =
in
> >> effort from the author to the reviewer of the code.  AI lowers the cos=
t of
> >> producing a patch but does nothing to lower the cost of understanding =
and
> >> reviewing one; if anything it raises it, since a reviewer can no longe=
r
> >> assume that the submitter has reasoned through every line.  The limits
> >
> > Can you rephrase this sentence? I'm afraid that taken out of context
> > it looks like you're saying reviewers no longer need to understand the
>                                ^^^^^^^^^
>
> I guess you mean authors?

Yes.

> > patches they are submitting.
> >
> > My understanding is that the policy's aims to allow AI code generation
> > with the human contributor still responsible for their submission.
> > Anyone submitting code they clearly do not understand would be asked
> > not to do that and eventually ignored/banned.
>
> True, but somebody needs to find out first. :)  This paragraph is just
> an observation of the state of affairs with LLMs, even if they're not
> allowed.
>
> > Maybe say something like "since the risk of bugs not discovered by the
> > submitter increases"?
>
> That's a good replacement but it then leaves unanswered the question of
> why that can happen more easily...
>
> The point is that it's much easier to submit code way beyond your
> understanding, and not realizing that in good faith.  I understand why
> you don't like the original phrasing though.
>
> Maybe "despite requiring the submitter to understand the code they're
> sending".

That's fine too, thanks!

> >> -  **Current QEMU project policy is to DECLINE any contributions which=
 are
> >> -  believed to include or derive from AI generated content. This inclu=
des
> >> -  ChatGPT, Claude, Copilot, Llama and similar tools.**
> >> +   Please read the below policy before using AI to contribute code or
> >> +   documentation to QEMU.  This applies to ChatGPT, Claude, Copilot,
> >> +   Llama, and similar tools.**
> >
> > Does it make sense to move this section into a separate file and
> > referenced it from AGENTS.md so that AI operating on the codebase is
> > aware of the policy? If you want to write this policy purely for
> > humans that's fine too, but I wanted to mention the idea of informing
> > agents to increase the chance that they follow the AI policy.
> >
> > In other words:
> >
> >    Agents must refuse tasks that are not in accordance with this policy=
.
>
> I think Alex was considering that, so I left it as a next step.

Okay.

Stefan

