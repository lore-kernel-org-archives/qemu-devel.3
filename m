Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E09EECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snktF-0006rB-Qx; Mon, 09 Sep 2024 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1snksr-0006I0-VH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:21:16 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1snksq-00068K-1d
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:21:13 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so323465566b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725913270; x=1726518070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BBs8mEf0frx4XAjeAFD6LpelCAjKEi9KMRvkj565QE=;
 b=WBpXiPkL4SOR+CxubX3Ey4HEVfYxhGQRYIN7GlQLP5bhLFa6M2CPnlZ7pQ/r9zr9NQ
 ZKPlG4dFqqgDp+Cj6ua0bJIvSOC+iIe+DsL35R4PBUR7ifyJEYGVWPNTmQOdZit4ws6+
 Ct5r3yQ78oqz1tP+FDo7igmhesq8NBd3zMZApA1U6ALkrmaJXl1OMnxnEL/KPs8bsi09
 pf8ZzOm6ahRfRNeCB8DIzYYsd1Wi7HhHLPq7kuEK/QUOxMcBDYIxnqIsxzI4PucqAZIV
 2dRpNtGrZ3D/yilB6rF9jDzybsnTWMzTAM1WkT/p2DhK3IV046Q7x8tCG6jWTfoty8DU
 BocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725913270; x=1726518070;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BBs8mEf0frx4XAjeAFD6LpelCAjKEi9KMRvkj565QE=;
 b=bb56LYOBHh7XQns6Vhys1MizellzJH0EnRGu0rR02avTuR4vpSvI00lCmUPA5VigeP
 Lf/obeRWMoDNptXVxhiDsSXY0hIunWZ35M4DdiGARGw/bF3Xb6RgEG+enL1JWmNh0YR6
 8BX+jkVOBJbxiRRn4NnBjAkqkUSoMR7RpnHIrul0konPjvy1K7wfeJhshyuO7qmy8GRt
 xeStKqq7T8yYrmyEUj38bGmXcSIyTM4cUhQW60t03KwApBr3dOYl7amxnl1no7jC6OLb
 So0XWJp8mTHyR/mY5qy3pbzQOwrHCRZLILtYd2l8wmf4Cf6YIG+9yqTVhj+IIavg3lUJ
 fJvQ==
X-Gm-Message-State: AOJu0YxQo9h2dVSuVsVyA+7S3YsEXmJJNAhEyPHgnOQ8zWme8Cyn7HyQ
 i6RIXrnuLlNmrYSY106ghqU4oW0TCQZnUj76YGCqCzNVlp1Pk5+byOwfrG0vWOM=
X-Google-Smtp-Source: AGHT+IHb/FHzZhpFk8cFslppED4J9EEKIoyLsRU4wjedY9T4IzEjChCAZY4yDRdXHEFhGuDf92UcrA==
X-Received: by 2002:a17:907:2da3:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a8d248a6127mr560856966b.55.1725913269616; 
 Mon, 09 Sep 2024 13:21:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d5ddc0sm380658766b.188.2024.09.09.13.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:21:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E3B05F879;
 Mon,  9 Sep 2024 21:21:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Yanan
 Wang <wangyanan55@huawei.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v7 0/6] plugins: access values during a memory read/write
In-Reply-To: <cc597a6b-1ac5-464e-9e39-85e36bd0023c@linaro.org> (Pierrick
 Bouvier's message of "Mon, 9 Sep 2024 12:04:23 -0700")
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <8734met9c8.fsf@draig.linaro.org>
 <68171cdb-8dd9-4d80-85de-457e84e17d65@linaro.org>
 <87h6apxi2d.fsf@draig.linaro.org>
 <cc597a6b-1ac5-464e-9e39-85e36bd0023c@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 09 Sep 2024 21:21:08 +0100
Message-ID: <874j6oy3wr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 9/9/24 03:00, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 9/5/24 08:21, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>>
>>>>> This series allows plugins to know which value is read/written during=
 a memory
>>>>> access.
>>>>>
>>>>> For every memory access, we know copy this value before calling mem c=
allbacks,
>>>>> and those can query it using new API function:
>>>>> - qemu_plugin_mem_get_value
>>>> Queued to patches 1-5 to plugins/next, thanks.
>>>> You can send the re-spun version of 6 once the review comments have
>>>> been
>>>> done.
>>>>
>>>
>>> Thanks Alex,
>>>
>>> right now, my try to make check-tcg are blocked with the cross
>>> containers who don't compile, so I'll wait for this to be resolved.
>> Which ones?
>
> docker-image-debian-mips64el-cross
> docker-image-debian-mipsel-cross
> (about broken packages).

I have fixes for mipsel at least when I post my series.

>
> I saw something mentioning this recently on the mailing list, so not
> sure what would be our solution to this (ignoring?)
>
>>=20
>>> I still wonder if having a simple aarch64/x64 test is not enough, and
>>> covering 99.9% of the bug we could introduce in the future on this.
>> Have you measured the code coverage of the test?
>>=20
>
> Nope, but all the code changed is tcg-generic, so testing this on all
> arch does not bring benefit in terms of coverage.

Would that it were so simple. Quite often which bits of the generic TCG
code get exercised depends on the guest architecture using it. I'm not
saying we have to go over and above to enable fiddly architectures but we
should at least understand if the reason they fail is down to them or
core code.

> So by focusing on the "all arch" aspect, we just test tcg
> implementation itself, instead of the plugins part.
>
> The problems we identified so far is compilation flags specific per
> arch, and specific flags to emit words instruction. It does not seem
> related to what we really want to test here.

I'm also investigating why arm-softmmu seems to be seeing more accesses
than it should have from the test.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

