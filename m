Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AB8EBFD2F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEA0-00052x-CU; Mon, 13 Apr 2026 06:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCE9x-00052p-SP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:04:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wCE9t-00042f-QF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:04:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so39638985e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776074682; x=1776679482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZ5dXdbRITfy0VMy8kOdZ2b596pCK5mEa1buj81n0g8=;
 b=o1W5EqHGa1cjfbS3OyCW1XDOt4g9NSzH4dM2g6hMzki/NA6pDwz+Za1lxakEujhrAY
 L9E6wyrIyLAAVHfatriWHiEvxHh1j1ifEH5lTfmQD4ihiGIrU3suCmDX7OA1ty5J4E55
 04SH9cQHfmbdnsYQtFcslMITgaTMzZMmVdLZxPBuylLLe1mbcwpEff2AE3IqRQ2VvW2V
 s7WV+QyKitUn9IgM/PhZ2jcb/3JWfVwrpREQ211lkb4DV67Te1jSx4o/j7ux5k9tUwxP
 P1uZKfJ87tZXfWIy42nYVNrr4QU8tcroMBo0r9DhZPIccfV4c8PuydlV7LP7RJPrE4r1
 Q8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776074682; x=1776679482;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZ5dXdbRITfy0VMy8kOdZ2b596pCK5mEa1buj81n0g8=;
 b=sfszrUautidJNO6WHVvhknSv6i7RuSyDbo68WNyZXG6BNIMhIwgGeBDhht7ixArLEQ
 JOYNBWmZfh5wyGe7d13UMGhXSUMp6ejh+EzuCG6swIbdTyJY6HISbhEwnJ294S7RspF0
 5Q+XXcOXA0YXuKGDGShTN6F56Uz59J7t/ozfmv/g2wRf7L7ZVfMCLljWLIajABf2cpNv
 3Kvqah/QX2rObeOtZdlC0HLkz2gI1UYpuOqG0ug+qVMjg2qsYRIvMcWrIUp+NJ7BnVGj
 34oEZB2fCL5fGs2HrkdUTLX+An2b13qNj8cKdcNSa9cVI0tmEOompT4kt0QmmmSkyj0H
 y6vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Nus5wCl+8+FeGlZ18Uf12I9IUOIIIV0V2jFC3tIiAny9rUv3XuubuU7ilAxcNwQrQFwMEnQMJdV9b@nongnu.org
X-Gm-Message-State: AOJu0YwwRxQefnDO9/D1OC88yjd7hTybRVV64Kk3ITae0mCeNT4d1VHr
 2AJEMZNUhN0vivZoIzFxknXrXilpljf8EltfcHGN/ynT1f97+2gsQ19gIlOVtoSbAN0=
X-Gm-Gg: AeBDiesOJteGT6IMnShlw5da/plhfEzQViS2QFaT0XyfOr1c5ALdxnpEEUOcIdCw4pr
 ZNgR3h+dj5V2knetvEzot1Dh13jgYHCZaoP8kI/Htr4sF2V45NXOi7u2LONJ58mxAw/70Uxn4tB
 QA9aV0Jg47dLLzdBQ/6pKjekel4TGCrk3RQtOjpRRwv70TFpHQ/J0eUlGlBwCftNV7M79bIJmdq
 D1m1Z70pQIgV8w1RwQRN2pl/Tl7zAXksu0WconaQ8V41oI3+/CxeDmPv7sufuXAa8iTyPyg7QRy
 7X6RB/BSyksQlVbP00B+dqJjQj89KqVe6NqC/pch1JhtTp2BhPJYFvwX/UBc5+HS0ZOPKXAfhWL
 F6I4RcWGAvCw/xk9ziceDl2CsBfe8HhQOuoiEl003ba6mVe3AFqrwNPnQ9Z0LlAVnxp7rBx0kv8
 3N+g3QzAGaIRZAPGf/I5tM7Ulprj4JFm8eCA==
X-Received: by 2002:a05:600c:3ba8:b0:488:af7f:7707 with SMTP id
 5b1f17b1804b1-488d6836621mr174706775e9.18.1776074682380; 
 Mon, 13 Apr 2026 03:04:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f1f9sm341800145e9.1.2026.04.13.03.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 03:04:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F8C15F864;
 Mon, 13 Apr 2026 11:04:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  QEMU Developers
 <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: Cirrus CI about to shut down
In-Reply-To: <7d223288-dab5-48d3-940a-f4a3ac252d0c@redhat.com> (Thomas Huth's
 message of "Mon, 13 Apr 2026 09:05:34 +0200")
References: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
 <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
 <7d223288-dab5-48d3-940a-f4a3ac252d0c@redhat.com>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Mon, 13 Apr 2026 11:04:40 +0100
Message-ID: <87qzojtbuv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 12/04/2026 16.28, Stefan Hajnoczi wrote:
>> On Sun, Apr 12, 2026, 08:45 Thomas Huth <thuth@redhat.com
>> <mailto:thuth@redhat.com>> wrote:
>>      =C2=A0 Hi,
>>     according to https://cirruslabs.org/ <https://cirruslabs.org/> :
>>      =C2=A0 Cirrus CI will shut down effective Monday, June 1, 2026.
>>     I guess that means we have to find an alternative for doing the
>> builds on
>>     macOS and FreeBSD?
>> It may be possible to use QEMU's AWS hosting where we already run
>> Linux x86-64 private runners. EC2 can run FreeBSD and Mac instances.
>> Sponsorship is on an annual basis though and it would be a shame to
>> redo the setup work once AWS sponsorship ends.
>> If we decide to use AWS then I can help provide access.
>
> It seems like gitlab.com also at least features macos runners nowadays:
>
>  https://docs.gitlab.com/ci/runners/hosted_runners/macos/
>
> ... however, they are limited to Premium & Ultimate tiers, so the
> normal developer cannot use these anymore.
>
> But since QEMU is part of the "GitLab for Open Source" program, maybe
> at least the qemu-project can use these? ... It would be great if one
> of the qemu-project Maintainers or Owners could check this! (I only
> have the "Reporter" role in the project, so I cannot help here)

Probably - I can have a look and try it out.

Not sure what to do about FreeBSD though. Ideally we want hosted runners
so we can exercise the hypervisor (ditto Windows x86 and Arm).

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

