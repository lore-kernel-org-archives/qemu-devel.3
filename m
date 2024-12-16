Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EDBE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNGjJ-0005mo-AL; Mon, 16 Dec 2024 14:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNGjG-0005ma-7V
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:26:06 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNGjC-0004nB-US
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:26:05 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so7567657a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 11:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734377161; x=1734981961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUP0TWo5+K6oh1yNf4McUw+tjF2sOAoGTqVNP+NRNYc=;
 b=dGtKwHTRWIyMva6Wwm1EFvWkZ7KjzcdccyH4YW12S89s2v2uRhT3OA1UZfDeEcZhdV
 ZfGNvKmeMzGOZO9ynOwehbSnrFVvtQXLvDM15LiWmt/NG+JGuuFUujd8oqKjExvLcmGF
 2L9HB4UCz3/0cQ9SQ4NAe5XfrDpzI3M/Jh15FlJJhih5BopFg9w9wU8ILAevhrXp0d4U
 X9g+jjNVbQz+Mt8QDUBvsgUyhlwruUA74pcSdyWT0tbWxFLhkLd2/7IT8eOm1gRtcCGZ
 zyWOvc/nji7yMZWbJTPgRcIU9viXjHPa4jZ4cYd0ybn64GXYp8f9om3fbHZkM8YgagBS
 Vhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734377161; x=1734981961;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QUP0TWo5+K6oh1yNf4McUw+tjF2sOAoGTqVNP+NRNYc=;
 b=acjzcfbcz2W4uNy6eQVjp0ru6oAhohzu1G3J5sa8rrjbOl2v9FNlCL05DFPDwkX566
 dHhKBAQeD8/JTRYc9w/9A9AEVzw5I5dtgIccLlFRqYIfAm5wgY7wNlQDZ0CTQ++VCRzn
 6SRfXBTGx9+dQ/7w9ZhQoBDaWKmLXc+pq5s8s5JuCfKiSm6rmPVE2LHLg2uBK3KTVJ1Z
 +UZ9kiv0gGgnWFDuhO3xlCEoNWuSKqcd+bfBgm1G1pAqtA+bukRiR5NumL6iORx1KdkF
 XoJvqSyYEsDDqpSInAXF36he/u2dJpI49EkZ5NhDcADpw5SWJykgDlOiz4yQ6W2BD7LX
 5Gyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNhgP0BbU6GtWI1+taesXwL/6qLxu3ZFHB+vgRCA44x3M4Gciwfzr9jLIGIHeOWDC+AVYN5r8gCQQb@nongnu.org
X-Gm-Message-State: AOJu0Yzex5EoDmkRXPoHKGPGzjFrrZ42BS6YsSJQKgHjQlZ8Dv3JwNeB
 c+OQaozZvq/jQPNLVFL5H1fl/DwGw2xoMbsCuj60hHizJB2kKX0IqhFfgXpKmEY=
X-Gm-Gg: ASbGnctLAywMlMbJ2tMW2w9aRKBM21gXM9+3ts3IlkvfPsiik8zvO41oMfO194WElzx
 0zV1Akm4VEzzzmCQMd5bMVd3Ac/C3pNw76LTQUgxTrMjew+tmdIk1hON2RSuieUfgtktbv1ymUA
 tL4oyzATBXhJ+eHl4DqfsA1DJzQz7qVAqAydM2raAV+38YYovdZZe7EWJzqzA8J809PxunPiNa1
 940Rd48B5ggUfJbdGmUmOTpUKnhUg+7bI6EaStIpi87LVV0itRsUks=
X-Google-Smtp-Source: AGHT+IH6xzDel643fQZczGiN0JdTCsDsHA6B5li5LceLuqduft6CxNNMXa2EdYisgKG/zDyLcYOgaQ==
X-Received: by 2002:a17:906:4a1a:b0:aab:dfef:8136 with SMTP id
 a640c23a62f3a-aabdfef84f1mr1166566b.24.1734377160546; 
 Mon, 16 Dec 2024 11:26:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9608835csm359306866b.88.2024.12.16.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 11:26:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 248215F952;
 Mon, 16 Dec 2024 19:25:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel
 <qemu-devel@nongnu.org>
Subject: Re: contrib/plugins does not build on 32-bit host
In-Reply-To: <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org> (Richard
 Henderson's message of "Fri, 13 Dec 2024 23:29:13 -0600")
References: <dbb6dbf1-1ceb-48c0-8174-ee5dea7533dc@linaro.org>
 <718f3f80-eb3b-4d9b-b2a0-24946a8c5b79@linaro.org>
 <03bf8242-8dd7-43ae-a0a5-3f304aa546bd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 19:25:59 +0000
Message-ID: <87cyhr1lbs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 12/13/24 21:44, Pierrick Bouvier wrote:
>> Hi Richard,
>> On 12/13/24 13:47, Richard Henderson wrote:
>>> Hi,
>>>
>>> Several of the recent contrib/plugins/ patches do not build on e.g. arm=
32.
>>> All of the issues are related to casting between pointers and uint64_t;=
 there is a Werror
>>> generated for casting between pointers and integers of different sizes.
>>>
>>> I suspect all of the instances will need to use separate structures to =
store uint64_t
>>> within the hash tables.=C2=A0 The hash values themselves can use uintpt=
r_t, as "hash" by
>>> definition loses data.
>>>
>>> The following is *not* a suggested patch, just touches every place with=
 an error to
>>> highlight all of the places.
>>>
>> This is something I already tried to fix this way, but alas, casting
>> values is not enough, we might lose information (in the case where
>> guest is 64 bits). Some plugins need a refactoring to allocate data
>> dynamically, instead of hiding it under a pointer.
>> See this previous series:
>> https://patchew.org/QEMU/20240814233645.944327-1-pierrick.bouvier@linaro=
.org/
>> Finally, we discussed it was not worth the effort, and Alex simply
>> deactivated plugins by default for 32 bits platform, so it should
>> not be built for arm 32 bits. If we really have someone that needs
>> this usecase, we might make the effort, but for now, it does not
>> seem worth the hassle.
>
> Hmm.  I didn't delete my 32-bit build tree, but it certainly
> re-configured.  If plugins are supposed to be disabled, something may
> be wrong there...

Something should have triggered re-running config.status and triggering
the disable. I wonder why that didn't work.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

