Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5287C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7T3x-0004tc-QG; Fri, 18 Sep 2026 03:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7T3q-0004tD-S6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:31:07 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7T3o-0006uT-OP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:31:06 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so5450285e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789716662; x=1790321462; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C50ngcUJwMDdFwqnf41FXjZ8xdJC1dZlvW6hU1/RDIU=;
 b=u+pGDA43BQkSQ0QNTB/W7vbABZHkva7MrWm7Nv3zYSsdb7asnl0xgsSrJLtAxsWK0Z
 VHmQt1cvKbbKtmL3w2NS0MgytvuYnRbotT2cigx6EMpjWEASNF0Zzry/8bEqeHrwANUC
 MQINtJgkrbvtpWZWjNmk5U8sbwwZNnu45pjx2BvGGOl+M5QbbID3fNsRwbn8nhowbEO5
 32NIREKtmNmNlargYZEwQCbOBJqx24LiNRNcC84bQEaBFzkLlgNSk87FVmU4eowlld5D
 DH4G636G1Kwu6Gi54PJajohf/oCKd3rlXSP3BlSfPpmjGAccsAecFjGxwYeQKa7fE0Ec
 /6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789716662; x=1790321462;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C50ngcUJwMDdFwqnf41FXjZ8xdJC1dZlvW6hU1/RDIU=;
 b=m0nrgM5mhxGwzMd5u22FnkNRj6vBKFH8VMrjwupuH3+Orbb9G86wrZGUoyez0kh43i
 eoOMMKk4xzhqFmWN6KY7U94hoQwzcUXSGqSpsUamriHssMkhfg7b0eX9XEyn2hTUZ9pD
 spDGd4yLPzajiGHvXPK+O2P4Wa2WwNdT6B3FkMdKbq6eKkN6DrZDDbzYpV2zl0nzrYVu
 ZlPbUeUyk5bfW55Ihirkzgb1A2R2lOwsQGffhwDov14obHM1BkXg63x6yQZ7A8TuAYW1
 ri59MIJ4CsGAQVDICd8Qk77LtADrfNFWo2Lo3E5YvlncAHzzS/QvNYA9rDrMwPm+X9lZ
 tuKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBSWtTjWiMRRxBoaj5A8JnP2N0RlSfFttD1gFGOO2ONWncwn7AlUFWhAnW6yM9+ovGxSJSC8EzliHc@nongnu.org
X-Gm-Message-State: AFuF++k64l7SJMmnjY6eHbH6lfVC6GTTfje+W9UP1oWKziVYutYFwakb
 xhWeMHFTEjTEOz2YAmOv3z/+qTGW1h30oR1/EZpLmXPnAHteli2RJ5gwMzFl440Mhv4=
X-Gm-Gg: AYBFou2cW2uxi6Wmzbk8Fv29GtAZeqz6+GDXpjufYvqK8RS3yZAUxuQfGTUvtjLQ0in
 qi4IxZMoT2FjSQiDljzcKC+YhMC0J9jTvGD0VIKSrJCSMgsj7AzoWyYySLqsCFFdKSwILkKs6CX
 kAa+Csf6KC3KV0tPk3Fis7n/7wvLFQIr6M7KA/tAT7MG7aSjev259YXM0K7A7FbzUSuhdvOXPQH
 4N4GLCgj0l+QZ0rzAQDoKZBekjjMW550SoMg1D2PwYrKb3fMRomBhpR8euTQW1PbIqd67/CZHoW
 S7QwOFKSTo5C4cI9uG4oQjknP/bVhw8Mv7q0AcfUMH8pggM1rWdFM6NrWcZ0vP38F753TtTLupH
 uxoflAVp9LAzi1O6j/XyVNKOVBmejUeGbo1WV/+wZNtSWUsMS7eI/HTZTJUVJNEKKuQr44nniae
 gsAofoux/iunnDgQ1KysfZtqdOLmDYJtEcwFb/ukpuyTYwWD8CopbYpcr/rlJxKJH4zNj0tJQ=
X-Received: by 2002:a05:600c:19d1:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49fc5743bc4mr17097325e9.23.1789716662071; 
 Fri, 18 Sep 2026 00:31:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc8dde38fsm18880275e9.1.2026.09.18.00.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:31:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF4675F8B4;
 Fri, 18 Sep 2026 08:30:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic
 from docker.py
In-Reply-To: <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 17 Sep 2026 15:25:20 -0700")
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
 <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
 <96e3f93f-a12f-4d18-badd-2ea60efc715b@linaro.org>
 <26dff9eb-b48b-4fd1-822a-806c3e83aadd@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Fri, 18 Sep 2026 08:30:59 +0100
Message-ID: <87a4pf6moc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

> On 9/17/2026 3:18 PM, Richard Henderson wrote:
>> On 9/17/26 12:00, Pierrick Bouvier wrote:
>>> On 9/17/2026 2:49 PM, Alex Benn=C3=A9e wrote:
>>>> how much time? it flies past when I run a rebuild.
>>>>
>>>
>>> For a no-op tcg-tests build (i.e. with tests already built):
>>>
>>> - With current patch:
>>> time ninja -C tcg-tests
>>> ...
>>> verbose pull and build
>>> 320 lines of output
>>> ...
>>> real=C2=A0=C2=A0=C2=A0 0m15.817s
>>> user=C2=A0=C2=A0=C2=A0 0m1.342s
>>> sys=C2=A0=C2=A0=C2=A0=C2=A0 0m0.840s

  =E2=9C=97  time ninja
  [1/114] Generating qemu-version.h with a custom command (wrapped by meson=
 to capture output)

  ________________________________________________________
  Executed in  515.16 millis    fish           external
     usr time  433.82 millis  968.00 micros  432.85 millis
     sys time   86.05 millis  253.00 micros   85.80 millis

Not sure whats going on there then. The whole tcg suite completes in
under a minute (and would be shorter if i386-linux-user-test-i386-fprem
and riscv64-softmmu-plugin-discons-with-interruptedmemory where in the
thorough test suite).

>>=20
>> The variance from the middle of the pacific ocean, and associated
>> network latency, is between 20 and 27 seconds.
>>=20
>> Amusingly, with the network actively disconnected (airplane mode), the
>> no-op build completes in 1 to 2 seconds.
>>
>
> Funny, on my side if hangs a long time (timeout 30s), then retry 3 times
> per image. I tried it on WSL on my windows laptop.
>
>>=20
>> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

