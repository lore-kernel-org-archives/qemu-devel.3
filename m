Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9925C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuEvn-0004bX-Iu; Wed, 12 Aug 2026 15:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuEvl-0004bD-ND
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:48:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wuEvj-0001Hx-Du
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:48:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4956242332dso12274255e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786564081; x=1787168881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rtmfmtenm9aBgGdqN3vZkwpfRQlESCQz08tiyQzDZFY=;
 b=MAlW2hjyWwLm8j4jeGp2XzxlfA5eYx+6NTMoQ3jBfc57GureoY0a+x2Kao2E9IDjY5
 4HSMVfY9/v3Y7b5w1iAYIVpRKYFCgTB9HavmAHhvABmd8g6xHej38rq4M3929tf7a9M6
 U8pXvMtvOBQfpFo3an70tTQHqISNAqR8Fp4pr849rcEJRcyqUv92RUg1tnnirM+Nm5AK
 R4SFaiW4WH10C/BtXeHdnc+WUq8R+w3Ir0IZYRskxrR2GHVO97uCulg8COZF8SskJl8n
 jW4CT5q5Ow1yiNfX0xIrSjO6unNme232k5o77EcTe2/2zYHkK7nCOfzMB083FKDGqT3V
 Cxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786564081; x=1787168881;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rtmfmtenm9aBgGdqN3vZkwpfRQlESCQz08tiyQzDZFY=;
 b=mjxOxbI78g3fPwFc488QxjpkzFep8py9fAOXeSVeICO9I6O+n0DZuRF5dT0MkD3LIN
 qq1S08s+I1P/xrKT+Tl9PCYt2W2WsF8iddyfjUuxJSx/C8EPW20EcW3R5pJWNxg7+3hg
 ahBSY+J51ojOhV0rMSjAKQi4nWzmrYVU3wOlLN/O1TeglhQEaDciYCp7wO/O2Aj4NfPQ
 Qbsb9qTIZvJ9F8LtccqZYJv9tv44hqLcAhJoEHAi5h16bw8VBlYbcwn6cwb59xr3Q09T
 VJhsR0xnNKn9QYLgIRzLYnLzn6/uUHIYYjyJ9lVYS5xFkycYzIKyjO42pc73G9p6P2ny
 pCwA==
X-Gm-Message-State: AOJu0YwVZL9zOMwsGIVcXnT60BZwwWiXNy32yyG2T6i37c1byRNWCMB2
 yjLzArixcmEgX7QejzhUPkva+nxbIZms8oVlYMUftHo5gYGjqQ0/PW0cXl16cB3sYUo=
X-Gm-Gg: AR+sD13R7iI111rDgP34OamyjZB+z4Tr5fdUZS2FMyD5qmFs/Xscslv9D5fl3VqEHPj
 NQJ/MZ4F7bl7xlDIf5cGt5ORa2LuN++5YyuRi77IQQdUFfVRoa8EoIiuBYJjFpEKXS9/N5I/PWV
 GFRA1fY5XvnZTbH7nongfqOS6HO630HbAz1TwmhJWGkJeqLN8IS8IHMQmKQeb6aC3svfaTvTb7F
 4svnDc+ReS4gOQk0uv9dklC/6uc1NmYmftEgrDTmIomj+72a81abrrCJeAyax95CsUErGz3O2Xz
 ELcHA9DQ6PRsrFe3uyJntJfNYGDHNJKWVe0JXXieTFcHOHBQ2wG9pYPqNwBDUd01Ddx115gjIRd
 xIB54TUjjuxoeA8JqAW+sCcBrEgWNTxzVAggy0naqAxWwJACiFlMN4OvlVwJJMdTL5cOlZXh5mY
 1qA6YihJfgnhq4WQLlrzabQJFkvw55XrLLxBwul4HFl2Bdn3+H90vJc82xzB/2YSNGlGYojaM=
X-Received: by 2002:a05:600c:4f87:b0:499:8191:62c7 with SMTP id
 5b1f17b1804b1-499821d7e83mr777375e9.18.1786564081128; 
 Wed, 12 Aug 2026 12:48:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e2dc44sm12704625e9.2.2026.08.12.12.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 12:48:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 572615F89F;
 Wed, 12 Aug 2026 20:47:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v6 097/103] tests/tcg: remove remaining Makefiles
In-Reply-To: <2e675bbc-1163-4a8b-88c4-0e2875164965@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 12 Aug 2026 09:03:14 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-98-pierrick.bouvier@oss.qualcomm.com>
 <87ecg3za53.fsf@draig.linaro.org>
 <9a1d9f99-ef41-451b-a8fb-fd1fae500e22@oss.qualcomm.com>
 <2e675bbc-1163-4a8b-88c4-0e2875164965@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 20:47:59 +0100
Message-ID: <87fr0jxgr4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

(Add Akihiko to Cc)

> On 8/12/2026 8:57 AM, Pierrick Bouvier wrote:
>> On 8/12/2026 7:27 AM, Alex Benn=C3=A9e wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> tests/tcg/mips/user/ has extra tests that are not currently run at the
>>>> moment. Keep their Makefiles until they are implemented.
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> <snip>
>>>> -else
>>>> -# For system targets we include a different Makefile fragment as the
>>>> -# build options for bare programs are usually pretty different. They
>>>> -# are expected to provide their own build recipes.
>>>> -EXTRA_CFLAGS +=3D -ffreestanding -fno-stack-protector
>>>> -
>>>
>>> Ahh here is where -ffreestanding came in. We should also check why
>>> -fno-stack-protector was added.
>>>
>>
>
> https://gitlab.com/qemu-project/qemu/-/commit/580731dcc87eb27a2b0dc20ec33=
1f1ce51864c97
>
> It seems like a specific setup on a specific machine will have specific
> requirements. Not sure it should become the norm, but if you prefer, I
> can just replicate the existing flags, and we can call it a day.

Was this a particular GCC build or the default for all GCC's post 13.2?

>
> Let me know what you'd prefer.
>  Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

