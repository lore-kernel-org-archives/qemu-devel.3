Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD7ACD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUvu-00060d-KU; Mon, 11 May 2026 14:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMUvj-0005qw-9S
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:00:44 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMUvg-0004Rq-O5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:00:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso2868271f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778522430; x=1779127230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AL0hvEpQGG4e41gPn7iHuBeeLZ3f4rlm/X40Bd+1LU=;
 b=Wf1bqzV3gd8raOEFv2++ssoldzpuTxsGIMnpNqzpO0LQdJJEZjcNncsg8sbHLpINwA
 ZqeTq58PpdMBLm3CxPooUmAdk3iWIMSfuBz8usuFBKSHUjWNb2yvf1A4fsaPhc2zR0Ma
 gpWDLKmcOdkCFzirsnl0qPc9RK7ChwPHzWcprDi77jeEuiNshsotjWvlapvRny8RP+vf
 lcVYlabgmDzeNf9ghbN5HZg0f1LPZ4JcGtYJCRG9D2C+ksi/6Juw56RGp85ziuLuppbN
 rR2Q7smsahMuvfBSgIOJA4y66D4YzdE+OYDZbOVSG6ujQVHjiONQJq23ESyZKdKWBHWV
 +Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522430; x=1779127230;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AL0hvEpQGG4e41gPn7iHuBeeLZ3f4rlm/X40Bd+1LU=;
 b=VB4CeuqwZo8BQZZ5iWNmRTCOKBVGxCZOvvup8exASDfE0qc9bgIuSbXmvH75lIo7zB
 oJK2xEl5g40UeyxO7NbJGhHaGZ5WrFEqTGYd0gTHyk2GV156wswSWmHFGHdc4wicc/Uj
 GKEuFUdxGT6jAxLsPZYoip9qL9OYGlN5sb6YWB3EPVsH/ge8HZvjbaY1P2MzUboKq2cq
 MOV5JV3PIuqgxUyKAn92D0yM+L360jpQYjcSg+kjfzA6MVVzKP4GI4ooKsnq8NgqBDxZ
 j4fREgpaj+KYcwTzIXM4pUYZbFxEY2Oo+6eBz5esDSxqvhKIE03wlid+69tDTR4n5Q3Y
 T5cA==
X-Gm-Message-State: AOJu0Yw5AIGElGOaQ3bVuqX8UgCIwawREvDIEXIrjodHMqHIKGj9rWt5
 5s6dljmwYqDs+vNuD6+qCj/ZcHX/z9EdCZrZScb1N9jLDALaZQaxLjwnzAt8ZeMyea4Mb/V+SIp
 sTSFn0mc=
X-Gm-Gg: Acq92OFebH6GhIr2V2l0NVYaFGwBvyH/fKS+vBklqH1KwB9OE8QwYV2aI/9cKcBHmkM
 JRvPZj4upcmB8xxFxh2TMGcLolksSRHbZwi9a3GfpzPZ+7d6m74Nh7onn2pYGB2L8exkFyoNI6s
 pSx9cNQbeZ10zD6P0UiTBgPrN4XaKMYUgv9ycSYJyl7cG1+fKd9nibLdJwyTwVwQMzMoFPzw/Bw
 te++FetBte2py2JDgsz1VRj9NmuN7hNIenAM8wtb9xT4aTNDvl52ImmcgcxidMGxu29djTwavkx
 GR859vM+NmAgq6O0GDbTyGp04j3rOW9w/UwEMow+1VsECeh9TR5pAqHksqTwe2V8q/z9h4oTcYL
 CCGqlPz4mj4Rxc1dSY8wn6ASybEvZMKLb9CfDP4m2Xrr8ZCaaBF8rRVny/1PIogK34417fgChux
 nXaXqUtK4/0FMEXhQVH8aUoBA=
X-Received: by 2002:a05:6000:186b:b0:448:8db5:410b with SMTP id
 ffacd0b85a97d-4515c574761mr39199173f8f.20.1778522429806; 
 Mon, 11 May 2026 11:00:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6be40sm28349966f8f.12.2026.05.11.11.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:00:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D9255F7C1;
 Mon, 11 May 2026 19:00:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 03/10] .agents/skills: add qemu-code-explorer skill
In-Reply-To: <agISxb-entwoYzzF@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 11 May 2026 18:32:53 +0100")
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-4-alex.bennee@linaro.org>
 <agISxb-entwoYzzF@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 11 May 2026 19:00:28 +0100
Message-ID: <874ikdeshv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

> On Mon, May 11, 2026 at 06:04:52PM +0100, Alex Benn=C3=A9e wrote:
>> This provides a skill detailing how to explore the QEMU code base. It
>> guides the agents to use the tags and git-grep by default and outlines
>> some of the confusions that can occur with multiple build directories.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> ---
>> v2
>>   - remove personal gtag skill references, add global stanzas directly
>>   - moved macro information from AGENTS.md into code explorer
>>   - more imperative language to trigger its use
>>   - add section on using scripts/expand_macro.py
>>   - remove eca reference from evals.json (maybe we should just drop this)
>> ---
>>  .agents/skills/qemu-code-explorer/SKILL.md    | 119 ++++++++++++++++++
>>  .../qemu-code-explorer/evals/evals.json       |  26 ++++
>>  AGENTS.md                                     |   1 +
>>  3 files changed, 146 insertions(+)
>>  create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
>>  create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json
>>=20
>> diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills=
/qemu-code-explorer/SKILL.md
>> new file mode 100644
>> index 00000000000..d5b7d6a35cd
>> --- /dev/null
>> +++ b/.agents/skills/qemu-code-explorer/SKILL.md
>> @@ -0,0 +1,119 @@
>> +---
>> +name: qemu-code-explorer
>> +description: Systematic framework for deep-diving into the QEMU codebas=
e. Use this to find precise symbol definitions (functions, structs, globals=
), locate all call sites or references, explore subsystem architectures, or=
 search generated code in build directories. You MUST use this skill when e=
xploring code flow and dependencies.
>> +license: GPL-2.0-or-later
>
> Is "license:" a mandatory tag from a schema we're following here,
> or can be used "SPDX-License-Identifier:" instead ?

It's from the spec: https://agentskills.io/specification#frontmatter

>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

