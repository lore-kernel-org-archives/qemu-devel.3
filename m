Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7FBD19520
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 23:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkWGW-0007ux-S5; Mon, 26 Jan 2026 18:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkWGU-0007sk-Vw
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 18:45:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkWGT-0000jf-5i
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 18:45:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so73837735e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 15:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769471094; x=1770075894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3yw8uW8cMYeuENnKbV4cXrEYzPegLHIaF7niapqf8I=;
 b=JBxAeS9TdIb6ySepP4QtPx3AvQV24RldiJswGFy2/e//T9f7Z0VWW8z54ZrGhJxSjY
 ofhYixzoMz5e7Qxeabgsp31fWak68j8BSSSQauz6zOB7lEx5DmxY5R23DrthM0myRphy
 6L6c1lgDAVRW9AKqJ+3r75njauCVPA1h0Dn0uy/QKtlV8zsotAigtgKUZzytSNKnVjHZ
 AoztldgNF3UrxHoPExeqt0BDvNBLBvPzV89ouEtlSDxUiWuJKMgI+VFpOPOs6XwtsJ6M
 9GScTenpRPN5h/4phfy7AM7xU3eKgffCYZS/wUlO904JI4R/nCKLRvExCMLMKWeuoJDo
 vffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769471094; x=1770075894;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3yw8uW8cMYeuENnKbV4cXrEYzPegLHIaF7niapqf8I=;
 b=tr80hdA34pRVwvBzo0eDon7OeTKXHwbgayZMHC5o8H4INhXA0gbwKF+Shiybj3TBE1
 MTXtdzD84ikqcezJcHnsRFTFlrbRYuHsiGUxc+xwYOnuK2gdAKQrwHagZO3FEHCaj2cV
 +YAVRAgFfJE0dyQ9CFfgngMNrSBU27vIy91yH/OZv0dK0WDyqp60Ug5ELpH6EIuOd9KG
 KL++4i3odKAXnBWsPr7AlrFYDULS7E+J1H4RPGJ2FwIi5tJIyF1LtqtZk7Km/VvO8diK
 yKL8DC0oyU1lVa2zTMBRlwSsMM41pyDc3dF5gk4gpefeImaOMwyhkBQFmLQtQDikdQrM
 APSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTYwngbYT8WJEt7uGsghv+hm86fjqUbKS3mEpgQ8itDJrXWQVwqau4M+Js2rhSSo6+PjBGUQA4ZYb+@nongnu.org
X-Gm-Message-State: AOJu0YxKVPe3NbxID84ZNt1Bl5hiT3RmGbOe6gKKVzd/v4AZnbzeL/Hk
 //Vk6I4drCCWXzgFOb+JvrV4dntPNfcMTlwWj30UqIEMAvm2czNRgp+81TMzWD1Xmfw=
X-Gm-Gg: AZuq6aLcqsK9mRjaU2c0cm0t/EJz2TG44MTBEA+idav6lpoDJYWH9A/VwBcQ7EGvfWH
 /2hdqVVfqW4kIYtkpWbVutAZnHhC9VL/pNivKGt1HMLZIjKS6hl6PlHMUwzHOjUhiDfoQYXGjA4
 cPht+AJii4zRHz/jcrHqzn5xHZbnaffyj5R6rCUpnltZQgaaQGe4W2btibgV/iLNMRrEZLzXHLB
 Zd3o0j7sVBzwfEz4ijRnPIoQ5yA3IB96kzTG+ewWaBcRjrF0mKL7AkFDn2vSUcClIZVesMzQe9W
 SPMeD/5UhIxWQJMHh8CGQN3jQFsk+CQGPplfRRq0McYF19HlbeFVSRSe997YrazZWR4HEFKI7l/
 rzD2CI9i/mlZLN0haud9eZT9mo9W4Wv/VJvvLapKxGzkTweAdo10VUeoJmd7+tdqV2Rz52TaPTF
 1v6iLAYH/KjGeQCzwVlIjtQ6I=
X-Received: by 2002:a05:600c:64cf:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-4805ce4dcc4mr87693995e9.11.1769471094311; 
 Mon, 26 Jan 2026 15:44:54 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24ac1sm33305801f8f.14.2026.01.26.15.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:44:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9B645F80B;
 Mon, 26 Jan 2026 23:44:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel <qemu-devel@nongnu.org>
Subject: Re: gitlab docker registries
In-Reply-To: <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org> (Pierrick
 Bouvier's message of "Mon, 26 Jan 2026 14:12:56 -0800")
References: <da1443a0-5bf8-4ec0-9910-fd06beb42552@linaro.org>
 <CAJSP0QWQEr8+dEGD7jkUQ--Oq+D2PKv_ArRB_ApiZM++xN9TCQ@mail.gmail.com>
 <c12f3294-1ef1-41fe-a453-1422063b991d@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 26 Jan 2026 23:44:51 +0000
Message-ID: <87jyx4c51o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/26/26 2:05 PM, Stefan Hajnoczi wrote:
>> On Mon, Jan 26, 2026 at 4:55=E2=80=AFPM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Hiya,
>>>
>>> I noticed this today, wondering why the daily scheduled builds are fail=
ing:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/12868286187
>>>
>>> time=3D"2026-01-26T17:34:06Z" level=3Dfatal msg=3D"Error parsing image =
name
>>> \"docker://registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross\=
": reading manifest
>>> latest in registry.gitlab.com/qemu-project/qemu/qemu/emsdk-wasm-cross: =
manifest unknown"
>>> make: *** [tests/docker/Makefile.include:54: docker-verify-emsdk-wasm-c=
ross] Error 2
>>>
>>> I'm not really sure what the error message means. Do we need to push a =
built version of
>>> emsdk-wasm-cross to gitlab, so that a manifest is present? Which doesn'=
t make much sense,
>>> since the job is all about a weekly rebuild of the containers.
>>
>> I don't see that container image in the registry:
>> https://gitlab.com/qemu-project/qemu/container_registry?orderBy=3DUPDATE=
D&sort=3Ddesc&search[]=3Dwasm
>> Only the emsdk-wasm32-cross and emsdk-wasm64-cross images are there.
>> Stefan
>>=20
>
> I don't see where the job that is supposed to build containers weekly
> is building them, it is just calling skopeo inspect (???).
>
> It should depend on building and pushing associated image.
>

it depends on:

    - wasm64-emsdk-cross-container

is that build failing?

> https://gitlab.com/qemu-project/qemu/-/commit/8bec7b9874235e60f1417261812=
1c60fdbd39302

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

