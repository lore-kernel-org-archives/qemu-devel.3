Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1696C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 22:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTpc2-000611-Ix; Mon, 23 Jun 2025 18:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTpc1-00060q-0n
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 18:26:01 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uTpbx-00021r-2a
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 18:25:58 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ade4679fba7so899653466b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750717554; x=1751322354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FI9gHoaT60rkMRvJB7b1gpL6DSPWBs9h7J+VYqCjA1I=;
 b=AwQF10ObbsaNgtCekvfhJbzs9qXrfQTv0mKGN/viwfIrRqMaoTq/OS3thgDSxC7Kxj
 o8feA07Hthh1mYEU0WKSjpTBT5vvlfd5u/q3RBNqua371tuq8j7fu0+736c3jXZbkWQj
 Ge7kB3xulhztoESw0mRcXgyUrwTj/BbkpWRjQEZDM83JklUbco/Jd7ia6+EB1NYXh9gh
 tzgXte4dY6FDUnPvownqmIVzf9ttwlUnJ3HuJXLIyGN4sl5BKa5ikI+vajdQiEv88sVD
 0+Z8nBaMbdY0uh4R1Y/Dn5oPQ85ij6K1gkeVWUX+wL1qzkkmiiISo3OJ3nXxcpKiOcVr
 7jGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750717554; x=1751322354;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FI9gHoaT60rkMRvJB7b1gpL6DSPWBs9h7J+VYqCjA1I=;
 b=Y3s91uieHuTfm4aReLYojbv/CNjqJFLcsJkB6cYxGLSHWTUCxrqU/hFC8F2mP3F7ve
 KBNn0DV0823LLMFxuokn+gFUB6Lg5+aJ796XIzZT1yNbfwR3ZEo+gKTUW0HkOQQ+7ggf
 4YaFmtGQYnqCGMu3qxpHhz45zNRicI/46iO8xzwgopvviotFtzE4ixavEjzrZ1AlrR3m
 Il/ex4Y/9ZHLsT6ikyxwWCgHTmNLBF9RdkvZ5UwNvb/GkPBlNd9oDbxhVZOjURYZCos4
 lgyfIuVA4lXpZlWWUKSY/LIOYsqRzMM6TB8uY+WzCG9lEWRSQ/2QOqLJ8GgPpTenCFV7
 6SmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVFxgX/PvLPfCGUFVzc4VidVg1H2Dk0hnQXkkQtMd3epwzST41G/UkCNqsfShlpCqHzM2Y3uoa8R1z@nongnu.org
X-Gm-Message-State: AOJu0YwBb20auU7/K4ws+eD66eEv/jTLkOc9lnxHvWng1ZVtRl7oSB3Z
 0ecd0/Wz/XvWh2Yd81+WIB/lYn0cmts6k0UsdS5ZT+aHhY0KUBxG9kO4bZpVOD0Ijus=
X-Gm-Gg: ASbGncvwgB33qN8T+67cyxdQDi23gzPmMufEcJWooiRl+TaIPU3OeUFtS5ZWoo1K6v5
 NPBiSsguRBjwU5x9lQLJ+2hzMNbFq3xIXLBfvILi4Lr7nWTthhfOUm89lGPamNx95nHNNRJ3Bhp
 3iAPFcqLm5EFPT6xFmJ59RIV3zL67xkIK4aUzQQvDc0QrT+pzfp0HfDpWfuOCUpfs3zeZf0bCla
 WZHqGBwCrNun11BZm9mpM2QXAMYhEcV3+Gf9gD81Sih/ISEZYn3PQ+nQn/RDb8ledObd3MeWCqJ
 ce380pj8w59fv36FQSV8ZTi6yEP9GhvVa8trC5PXBFWrC+YOo8uPCRDuApT2VpU=
X-Google-Smtp-Source: AGHT+IHNHS03kaj3hj0wHuOP3rzytlCASQ/hVwTxwh9TDm7Wey+7pn/5++mXRI8ZzyLEXmLIDWrZBg==
X-Received: by 2002:a17:907:3fa5:b0:ad5:5302:4023 with SMTP id
 a640c23a62f3a-ae057b3b6femr1489967066b.44.1750717553756; 
 Mon, 23 Jun 2025 15:25:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7c6fdsm763230666b.3.2025.06.23.15.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 15:25:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A9515F80E;
 Mon, 23 Jun 2025 23:25:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Daniel P
 . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kevin Wolf
 <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
In-Reply-To: <CAJSP0QV=mfmUt7s+iBkJtZsLiNd1v2c6tNrZeG8htBs58JHhrA@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 23 Jun 2025 15:30:23 -0400")
References: <20250616092241.212898-1-armbru@redhat.com>
 <CAJSP0QV=mfmUt7s+iBkJtZsLiNd1v2c6tNrZeG8htBs58JHhrA@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 23 Jun 2025 23:25:51 +0100
Message-ID: <87h60614eo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Jun 16, 2025 at 5:27=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> More than a year ago, Daniel posted patches to put an AI policy in
>> writing.  Reception was mostly positive.  A v2 to address feedback
>> followed with some delay.  But no pull request.
>>
>> I asked Daniel why, and he told me he was concerned it might go too
>> far in its interpretation of the DCO requirements.  After a bit of
>> discussion, I think Daniel's text is basically fine.  The policy it
>> describes is simple and strict.  Relaxing policy is easier than
>> tightening it.  I softened the phrasing slightly, addressed open
>> review comments, and fixed a few minor things I found myself.
>>
>> Here's Daniel's cover letter for v2:
>>
>> This patch kicks the hornet's nest of AI / LLM code generators.
>>
>> With the increasing interest in code generators in recent times,
>> it is inevitable that QEMU contributions will include AI generated
>> code. Thus far we have remained silent on the matter. Given that
>> everyone knows these tools exist, our current position has to be
>> considered tacit acceptance of the use of AI generated code in QEMU.
>>
>> The question for the project is whether that is a good position for
>> QEMU to take or not ?
>>
>> IANAL, but I like to think I'm reasonably proficient at understanding
>> open source licensing. I am not inherantly against the use of AI tools,
>> rather I am anti-risk. I also want to see OSS licenses respected and
>> complied with.
>>
>> AFAICT at its current state of (im)maturity the question of licensing
>> of AI code generator output does not have a broadly accepted / settled
>> legal position. This is an inherant bias/self-interest from the vendors
>> promoting their usage, who tend to minimize/dismiss the legal questions.
>> >From my POV, this puts such tools in a position of elevated legal risk.
>>
>> Given the fuzziness over the legal position of generated code from
>> such tools, I don't consider it credible (today) for a contributor
>> to assert compliance with the DCO terms (b) or (c) (which is a stated
>> pre-requisite for QEMU accepting patches) when a patch includes (or is
>> derived from) AI generated code.
>>
>> By implication, I think that QEMU must (for now) explicitly decline
>> to (knowingly) accept AI generated code.
>>
>> Perhaps a few years down the line the legal uncertainty will have
>> reduced and we can re-evaluate this policy.
>>
>> Discuss...
>
> Any final comments before I merge this?

It's well reviewed lets get it merged.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

