Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37476D49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCz9F-0005gs-0Z; Mon, 18 Nov 2024 05:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCz9D-0005gj-Br
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:38:23 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCz9B-0002Tj-G8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:38:23 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-431688d5127so32828895e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731926299; x=1732531099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oz75XJXcNCXuaTIorKcm/sctedlRoLRFkyNsX1XIM9U=;
 b=QnKdUxwMcDt1As3FGw93IyvCVXtycnRIZCw1gSC8qlE5u40OlNIZLiYBtHYwVyv59F
 pnmQJ2zcb/3i4bIxBztTefym0rpNEILCk41L1r7kt+LqE4YkClZepBKS4qohzClzHwKf
 EXkcg7OMwmmWKFuu6f81yoN351xb4jMjxn5hU4lEOXDhPRtjNR8CC3nCape49R3Vu8a3
 Irkmf6kxMUlP9bAnG8S06ep5w3py2wUjVJwsqIFdtCVw70D4Ok8L2TGirShyiOxVhp8S
 tDvGUR+4YmNHUmS4T7dSrmYGsDSJ0DFoUrd5IrKLrUMkUnXRlvee0c6ngys8Ip9HMlVV
 ZSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731926299; x=1732531099;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oz75XJXcNCXuaTIorKcm/sctedlRoLRFkyNsX1XIM9U=;
 b=kAVtCMtGQl/43n+zVHNcIuL74yRQ9w/c+iGS+8O43yBNzuL5Y0AqvDV9BeRRXNSKTr
 C9ryuRki6URp8praUIHxygdo6IqJhzDqZMtXj/y6jW4hwqU9jDy8gKPJg6iafU+HbM9d
 A41UJ0IWuLAwNZpsedzxjRBcFeftw1Q7tFyU+aHT5BVGozQrB5siPJRDvufU6PR03ADW
 cbKI51howK8TQUaU1f4UoXgI5cTwPlyyx3hyQx0yVJvmzvHOPJNwFcoZVdwZnMt+YCbp
 VwWGgDNfp9/AQ2AzIrdQ4fIsww5bavIvvPn/0GBMP1QcPziln8EC+tA+Fxz/XNVf3dET
 jCPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN2OdilwBdQ0t6pJklW5EMDrbx2Ni/PbGiAQOsMNXP4tLsVYJpwdt2KtGSVFvO5fM6POzXfoviwp7k@nongnu.org
X-Gm-Message-State: AOJu0Yxav+kP2o0dVHdOuXgISTgWQ0g95K1Uff4H7A+0ROnC/c/Sjghs
 tmqpjL+mdKobfzNCaPJuSYpTqM0IRrtudfEgNKu0scro7PqOJ/ZV3GUZusIVBug=
X-Google-Smtp-Source: AGHT+IHWKkDWbhTsgCSAIvPgxE6gMdkWh73zFshH+LC93D0GGNhx7DI5xWcOSNeZTyO+IwhNmExGUA==
X-Received: by 2002:a05:600c:3b20:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-432df74c880mr111143195e9.15.1731926299313; 
 Mon, 18 Nov 2024 02:38:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab72159sm151259775e9.5.2024.11.18.02.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 02:38:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B19755F7C6;
 Mon, 18 Nov 2024 10:38:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] rust/pl011: Fix range checks for device ID accesses
In-Reply-To: <SY0P300MB10265E91E369AB15B611018D95272@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 (Junjie Mao's message of "Mon, 18 Nov 2024 17:54:29 +0800")
References: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <87seroubaw.fsf@draig.linaro.org>
 <SY0P300MB10265E91E369AB15B611018D95272@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 18 Nov 2024 10:38:17 +0000
Message-ID: <87mshwu8rq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Junjie Mao <junjie.mao@hotmail.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Junjie Mao <junjie.mao@hotmail.com> writes:
>>
>>> The peripheral and PrimeCell identification registers of pl011 are loca=
ted at
>>> offset 0xFE0 - 0xFFC. To check if a read falls to such registers, the C
>>> implementation checks if the offset-shifted-by-2 (not the offset itself=
) is in
>>> the range 0x3F8 - 0x3FF.
>>>
>>> Use the same check in the Rust implementation.
>>>
>>> This fixes the timeout of the following avocado tests:
>>>
>>>   * tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt
>>>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt
>>>   * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpress=
a9
>>>
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
>>
>> This certainly fixes the avocado failures.
>>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>
> Thanks for reviewing and testing, Alex!
>
> Meanwhile, Manos has submitted another fix [1] which also replaces
> arrays of constant register values with more explicit register
> getters. His change may supercedes mine.
>
> [1]
> https://lore.kernel.org/qemu-devel/20241117161039.3758840-1-manos.pitsidi=
anakis@linaro.org

Yes I'm looking at that series now. I just wanted to note this simple
fix might be more relevant to 9.2 as its concise and easy to see what
its doing.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

