Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B22EBFD37
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEpS-0002KW-9E; Mon, 13 Apr 2026 06:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCEpM-0002KI-Cn
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:47:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCEpJ-0003fE-FJ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:47:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso862102f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776077251; x=1776682051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTIduCdjaKRh19ssTjBOgolLFpFlDuJcVrvN1jjQFcg=;
 b=T5MXzkwixlj2fE4kVKaaT8il4bsUklEHCwxRMlklEYEvaYOC3xctSiUnU8PrPZhiLj
 /NxuFBuw0hMnEszgUSi/S/4yZnfUN1HYD7QbpTJFYG4qeztP9txISL6nBBRBnWPC+993
 bUof5AQXM6v0WWffyAn+dmxu9MCbVRhJMFvYvh18p+I3SEQY2j9wqYAPPdKcYOF9F3lh
 wqeid94PS+GWS1Th7LfJLIr88nZtsQcP2AT0AoBA97MI0vkS8NNDGrmBPPquIh5J2b3n
 W261GT3ryRe7pP+wuwiH6+5YOow099GpfbisqLA+sNfe/YkZWdRlikXBZQou1tyRTHNG
 Wd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776077251; x=1776682051;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hTIduCdjaKRh19ssTjBOgolLFpFlDuJcVrvN1jjQFcg=;
 b=RC+B6IwWUBHgJcjLWPb7RgWGbY8BRdfRdT7cmgLQQyl6WAUmKFNWTFwt98qgsvEs/p
 Q1gip/VSOuAA2U0Y6cOp32PGDpBTRDWTbuxp7uBz6CtJpTvn7BY7CNkGXmXxEXrEuf8z
 Fk7AQRrVmJJTwHqVAIzMc2pTUeU7y9HhQegdjUi5yyteEBRgEWHMEN6lOwAhhWQOIiJk
 GqmcrPkbJpQ0ngvDGUwE2npr2fYUFSTHpgUcZHm3E+apUwO7LEsvxjUPyF0UpXQFRtai
 3+umsRMzhwxITI+oThljLG2ZvvThD2MXyYMBmx7LSj5Vt+ncfaAiiXjkkjU7wwRsamjV
 d1ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ8trogoeLbr5n+gH4oJPZtmyxhvFdAA9WWv+t1JqYJ5RWMD1OQwa7387dGE/+hBjimCsCYvv9B2o/t1@nongnu.org
X-Gm-Message-State: AOJu0YxvQ9NJbBxUSte+ntaHSqKljySNaj9ccBJa2WWzcxd1wDO095/l
 pt+56lDXg4NkaDkByGznaTLzrfJ+4YDVCRf5SqZn4s/2AXIIMBeDpJMMrIOZOT+BFcY=
X-Gm-Gg: AeBDievEmyNkOxLFIfoiWFn14VMNJFHmqDNdxz86726Vlh2CkWO3dg2FhBlhYbFjUN/
 eIswz26dBEb6ZC4f1wOWrIdyKW8R3yyVBsdH/14Jffll/cSY5vPWbnhKoHJdeo/jHo+FTX7s/oV
 TIboC1IqbBXhVV2drqHHNnwHJco3d6xR4iAwMsOwR9T2DPEGFfAhyMUNlcLqvs36IFtgdLnCjFZ
 xHHJz22qvSOjLEA2cUvfQl/vs6bJ/e1hObtfFPnEZLBQUuMq9I3qh3tWl5fKu5J3q6pEdoMJgLd
 ZGImvdxg1Qk74AOWxALjrZd+53wc3NcgsX/KvvYWcxIWxCnSmqYoRgXtWyE/dW9+ftkirLkXanR
 Nt5iFsq1S/jcmGdQu/UtREcdok7S7Ei1T+tHou0Cs1opK+aFeV2FusrTE8qW3Z9+Z8FXMj+nYwK
 3+ZpFJpUhefxZEz7vYa9ixk9E=
X-Received: by 2002:a5d:64c3:0:b0:43d:714:34e5 with SMTP id
 ffacd0b85a97d-43d642da7aamr18032703f8f.24.1776077251073; 
 Mon, 13 Apr 2026 03:47:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6a1203b8sm27169892f8f.16.2026.04.13.03.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 03:47:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 63FFE5F864;
 Mon, 13 Apr 2026 11:47:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Cirrus CI about to shut down
In-Reply-To: <adzAhSbs21GGVCUv@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 13 Apr 2026 11:08:05 +0100")
References: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
 <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
 <7d223288-dab5-48d3-940a-f4a3ac252d0c@redhat.com>
 <87qzojtbuv.fsf@draig.linaro.org> <adzAhSbs21GGVCUv@redhat.com>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Mon, 13 Apr 2026 11:47:29 +0100
Message-ID: <87ldert9vi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Apr 13, 2026 at 11:04:40AM +0100, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>> > On 12/04/2026 16.28, Stefan Hajnoczi wrote:
>> >> On Sun, Apr 12, 2026, 08:45 Thomas Huth <thuth@redhat.com
>> >> <mailto:thuth@redhat.com>> wrote:
>> >>      =C2=A0 Hi,
>> >>     according to https://cirruslabs.org/ <https://cirruslabs.org/> :
>> >>      =C2=A0 Cirrus CI will shut down effective Monday, June 1, 2026.
>> >>     I guess that means we have to find an alternative for doing the
>> >> builds on
>> >>     macOS and FreeBSD?
>> >> It may be possible to use QEMU's AWS hosting where we already run
>> >> Linux x86-64 private runners. EC2 can run FreeBSD and Mac instances.
>> >> Sponsorship is on an annual basis though and it would be a shame to
>> >> redo the setup work once AWS sponsorship ends.
>> >> If we decide to use AWS then I can help provide access.
>> >
>> > It seems like gitlab.com also at least features macos runners nowadays:
>> >
>> >  https://docs.gitlab.com/ci/runners/hosted_runners/macos/
>> >
>> > ... however, they are limited to Premium & Ultimate tiers, so the
>> > normal developer cannot use these anymore.
>> >
>> > But since QEMU is part of the "GitLab for Open Source" program, maybe
>> > at least the qemu-project can use these? ... It would be great if one
>> > of the qemu-project Maintainers or Owners could check this! (I only
>> > have the "Reporter" role in the project, so I cannot help here)
>>=20
>> Probably - I can have a look and try it out.
>>=20
>> Not sure what to do about FreeBSD though. Ideally we want hosted runners
>> so we can exercise the hypervisor (ditto Windows x86 and Arm).
>
> For the various BSDs we have  VMs for QEMU builds, which (in
> theory) we could run from regular gitlab Linux jobs. Running them
> with TCG is rather unpleasant though. Do our private upstream
> runners have nested-virt available to let us use KVM ?

We don't have any custom x86 runners, I have no idea about the cloud
ones that serve the bulk of the CI jobs. I assume the AWS EKS machine
wouldn't by default.

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

