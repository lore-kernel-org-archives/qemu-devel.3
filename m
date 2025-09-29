Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FEs-0002YF-LZ; Mon, 29 Sep 2025 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3FEp-0002Xc-Vo
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:52:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3FEn-0006oQ-Bm
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:52:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso35216055e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759157543; x=1759762343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rv9gjkFCucTMwco6R3M1SPZbE5QG7gfEF+2ZiiVXpp0=;
 b=zYaV/McaGWUw8yP34/QVioY5EANR766BIrgIROVcEng6/1VrEqpVYCUioxvLAlzrFZ
 53bHS7mt+OQD0fj2W5ZtXJe2D5KFjW0qp4RXAT8NB8I+nnVmSzCcLLybSPE/4s62B6Wn
 PAK5i+QYkf7r5O78xRxVZnqyCPbwd/mkg2K7MlbsDPwtw8cX7vCSDHnBvf0t3ToElsPm
 /btzEObZI7ikeJDwftr7dxjboHqj0AMjqbNIPVlPdkyQMoFB/4t7voNv0NvKl25us8i2
 20heESw5ahL1a7XEKRLCFkSe9FQlxBVYgLyrcinyLrU0A14ZYQPLAbJHv0dqmKJqh9C0
 h7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759157543; x=1759762343;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rv9gjkFCucTMwco6R3M1SPZbE5QG7gfEF+2ZiiVXpp0=;
 b=wIkuEpyTPgq2VYzidEpWg0XoAzEFhh4qmByYxaqMFD4B8rrFYz8I+9QWF7F3Z8Wr0D
 6Ingjd0uxcxlA5Cx0fYJ4K5AupS/AQ5nqTEYwc6FHHRuNxONqn3IUZgbD14kjDBa/Qdo
 erfbIqwK4gQm7SDo/rOt9BwUsx4JvfH+zTf0NGvyQjRHmRu8Gt4g6VokXGezOAUTi/zL
 c7EOlz0clsxuFeg7QTxE30rlr9VIZbMhlIegkSwgHinZkRdixsVqIS9uQUp9sGlJU81G
 quV511BoqIaY1CDlEn6fI1QJVjoX4kO+ztBB6mPMiM9uOGDYOJzaz71Q4oXoSzfQN7mG
 ctxA==
X-Gm-Message-State: AOJu0YzQxbXgCGsgaUtvEygrBbNh0cyFRnM8zn4Xsbal4gZTaxac6Qnn
 dQYieXcdPJElSgIFSWcUtllTkcf/yDZZzGyRT0dTUfZDNwK9H6Ru8KN8LMo9ukHf6x4=
X-Gm-Gg: ASbGncsLX6825gojYTeiGxzHnX2JCniJVKyGKXuaOfQmj2K+n5O4ZOVci4SXKGCRuK4
 M+X4OXprS4yYv9L7M0c63xhdqBlq1iyFUox1ao3KFiYGTi7z7bmcynZoSTcsV5XRLG+bZ6EUeNV
 +PfTtnwL5ffw5We7Gjlm1w53v3SPoxj88/Kj3WLtAI/j2r0w4wHHi0Yagm9QXa9TC2166IUbg8j
 rZsa2Lh3NB2mqiav6CnyJD+yz4YF01Jw1ybH1bgxl/g6oR8SLAPH/wKL3s2fF/5OEafMSpwVUtF
 53Ti5rtWkrN+CgRe9vAz1EYc4FiM3QISu2Lmv8Mbj/48X6XagUXezIqmzeH+76kDClbZrEDrBhU
 mcpZcdvE0TK5zFdU6B0xEu1gmLmdc4Rsja0+GotDbgwOO
X-Google-Smtp-Source: AGHT+IHQhFU7WOvRk9sCybFSxh4/LxgYoCBTw7n1lA9wami1fMXglRyyAtRUgcKsF7yZ1dSsjZ7HEw==
X-Received: by 2002:a05:600c:1695:b0:45b:7e86:7378 with SMTP id
 5b1f17b1804b1-46e32a1987cmr107114975e9.34.1759157542949; 
 Mon, 29 Sep 2025 07:52:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f64d06sm15940565e9.12.2025.09.29.07.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:52:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52EFB5F83A;
 Mon, 29 Sep 2025 15:52:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com
Subject: Re: [RFC PATCH] .gitpublish: use origin/master as default base
In-Reply-To: <b726ecb9-b93c-43ce-9bef-7e18451885a4@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Sep 2025 16:39:32
 +0200")
References: <20250929134348.1589790-1-alex.bennee@linaro.org>
 <b726ecb9-b93c-43ce-9bef-7e18451885a4@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 29 Sep 2025 15:52:21 +0100
Message-ID: <87h5wll3a2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 29/9/25 15:43, Alex Benn=C3=A9e wrote:
>> This is very much the result of my recent fat finger but I think it's
>> safer to assume that origin/master points to a recent commit (or at
>> least a commit a given branch is based on) than master.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .gitpublish | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>> diff --git a/.gitpublish b/.gitpublish
>> index a13f8c7c0ec..a3adb21ffa1 100644
>> --- a/.gitpublish
>> +++ b/.gitpublish
>> @@ -4,48 +4,48 @@
>>   # See https://github.com/stefanha/git-publish for more information
>>   #
>>   [gitpublishprofile "default"]
>> -base =3D master
>> +base =3D origin/master
>
> Any key to specify the remote? (not everybody have mainstream tracked
> as origin).

I would suspect most do if they clone from the project repo - but yes if
they clone from their repo first this will be just as wrong as using
master ;-)

>
>>   to =3D qemu-devel@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "rfc"]
>> -base =3D master
>> +base =3D origin/master
>>   prefix =3D RFC PATCH
>>   to =3D qemu-devel@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "stable"]
>> -base =3D master
>> +base =3D origin/master
>>   to =3D qemu-devel@nongnu.org
>>   cc =3D qemu-stable@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "trivial"]
>> -base =3D master
>> +base =3D origin/master
>>   to =3D qemu-devel@nongnu.org
>>   cc =3D qemu-trivial@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "block"]
>> -base =3D master
>> +base =3D origin/master
>>   to =3D qemu-devel@nongnu.org
>>   cc =3D qemu-block@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "arm"]
>> -base =3D master
>> +base =3D origin/master
>>   to =3D qemu-devel@nongnu.org
>>   cc =3D qemu-arm@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "s390"]
>> -base =3D master
>> +base =3D origin/master
>>   to =3D qemu-devel@nongnu.org
>>   cc =3D qemu-s390@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null
>>     [gitpublishprofile "ppc"]
>> -base =3D master
>> +base =3D origin/master
>>   to =3D qemu-devel@nongnu.org
>>   cc =3D qemu-ppc@nongnu.org
>>   cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --=
nogit-fallback 2>/dev/null

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

