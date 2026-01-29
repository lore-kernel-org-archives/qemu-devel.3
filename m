Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60989D6100C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 12:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQtu-0001t6-E2; Thu, 29 Jan 2026 07:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlQts-0001rR-KX
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 07:13:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vlQtq-000182-PM
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 07:13:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso8868585e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 04:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769688805; x=1770293605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ube3iZX2SrsJMnHpOdRS3dFTdRplV+wy9wjhzsLtKR8=;
 b=NkoTL4sE2vScSmQAoFoBQN1r7WP1SmZGBxAcVXeV/RjNHXt7gj9AvnjHaaZ0bPBPZD
 zRwczzqQ2FjGxY4tYjT51QhTtTMxyWf7c/hn1dLxPTtr4oW/9cTBv7i6uDnngiOwUolW
 L76iQjSgGR7lGYi5UZNP/ZL+PYusudIX0jeTyp2fmAWrCxnQAzSPVbtzFtbzy6CyeD65
 OA2T3jBCKW1kILNPcnATklNgvBgRC5uRrFTCWKW78N2G0FBmlEPsgKkxzwIIg3OFDkpp
 cnwgu/Os8dJLo6vAHURLWVznMI9le0t12Mj8CBAir7dzLT3L29HqN8zbMzARUcQixTFT
 bwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769688805; x=1770293605;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ube3iZX2SrsJMnHpOdRS3dFTdRplV+wy9wjhzsLtKR8=;
 b=kieJC+Ki6NIjnEzme+BWl1moL79yQlPBmyXUaMOmqD4vIFI6Luu+0K2BFzC/bO+OcT
 PVTPckhik1OkLZrZ6o/bqMyexSOnlJ5avhKgMrH2NeD3UIi6AERqelzf8SgY93Z6m9Xe
 yInQLjgqdmaUeQWIOIDqwPgB09FvwexDs7at3uva2IHSnBz3PRTRA+KKK6Ywy81xEU9K
 yDKTKxHRv+4Ow4ua8yTzDq+vTp6arZZ8dUm0Kcb5DqnJSMnWRBYA+SQwpKxEyCHv0645
 nsv25x4eMxA8yaanKiPM0o607RBW+hieEflq6oK+p1TSvYFOrmYZ5TehEgr1rC+OKDpb
 ZmVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/NbaOXdHruXTCTVxNiYCKVU28tgl8XuggGet0zJWx3kU+HHm1oTgPb8NDzrnB6z6aFpr+X/PvvElQ@nongnu.org
X-Gm-Message-State: AOJu0YyHMc+N+m8kctSjdNZ3ur7Xiyt9PyiMgpKVtrsMQQPBlv+QvUTK
 n/D8nXfH9qH7FxSJQN4p+AJvE5y+amQREH6KJh2Pb39B7ZWS/uD94P+259D2+bYry24=
X-Gm-Gg: AZuq6aIO7fLbRDuzOxlRVz4/7yn6Uqi6LGKis+fRMQCduCysrPSGgCNZsLSSYhrqhe/
 rOLA6vaHh6I72Anrbdsko4UPNa6Wu+bg/LUnhoNJzEH9HMsS6C0EZX+49GiTyZvj1LGbWa95QNS
 v5ol0spPvXIQZPuGB+36OESCEeihfeRSGLWzFVZKY0SExzTD8ddI2wC6dNb79HsgrJOz92Cwxc5
 r9sEUbVs4m4LSLEHVBtDfvqFtRFKdRdIO1sTa71JcJcVvgoAcwPS3DR/henxLEaP/d+0eTtFef4
 RacF08QDjIPnjD8IF7IDd2W6aLDgJYNXhloHIIf5PbcoeNY3GpJSLIuLiJJObkMTX3W8qUoGisL
 H/PTiTSajGW/DljBjjJbBjyNXVdmL6UqZMH9gBuu79I7kuTFMSeABG5/42iEVwj4zTnd2mtsYXp
 R+VYJypIKq88Y=
X-Received: by 2002:a05:600c:6096:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-48069c75255mr137167295e9.35.1769688804619; 
 Thu, 29 Jan 2026 04:13:24 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm188555815e9.15.2026.01.29.04.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:13:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2EAAA5F809;
 Thu, 29 Jan 2026 12:13:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  Leif
 Lindholm <leif.lindholm@oss.qualcomm.com>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Subject: Re: [PATCH 2/2] tests/functional: migrate sbsa_ref test images
In-Reply-To: <c2e17000-e34e-4244-a377-ffd37627aba0@linaro.org> (Pierrick
 Bouvier's message of "Wed, 28 Jan 2026 16:53:20 -0800")
References: <20260128105839.3487840-1-alex.bennee@linaro.org>
 <20260128105839.3487840-3-alex.bennee@linaro.org>
 <CAFEAcA_sT6pGhXPpgaEqkJOVuAj3e1KMz_AP6-MZ6YP41YvoRQ@mail.gmail.com>
 <c2e17000-e34e-4244-a377-ffd37627aba0@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 29 Jan 2026 12:13:23 +0000
Message-ID: <875x8kaa70.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

> On 1/28/26 8:25 AM, Peter Maydell wrote:
>> On Wed, 28 Jan 2026 at 10:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>> As the builds in codelinaro.org are going away migrate the binaries to
>>> share.linaro.org. As the hotlinks don't encode the filename we need to
>>> explicitly tell uncompress how to handle the files.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>>> @@ -54,15 +54,11 @@ class Aarch64SbsarefMachine(QemuSystemTest):
>>>
>>>       timeout =3D 180
>>>
>>> -    ASSET_FLASH0 =3D Asset(
>>> -        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa=
-ref/'
>>> -         '20241122-189881/edk2/SBSA_FLASH0.fd.xz'),
>>> -        '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c338=
4a5')
>>> +    ASSET_FLASH0 =3D Asset('https://share.linaro.org/downloadFile?id=
=3DkyoMLGC9zXa4oA7',
>>> +                         '76eb89d42eebe324e4395329f47447cda9ac920aabcf=
99aca85424609c3384a5')
>>>
>>> -    ASSET_FLASH1 =3D Asset(
>>> -        ('https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa=
-ref/'
>>> -         '20241122-189881/edk2/SBSA_FLASH1.fd.xz'),
>>> -        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d41=
2fc')
>>> +    ASSET_FLASH1 =3D Asset('https://share.linaro.org/downloadFile?id=
=3DDj1HRXnDnKtU6Nj',
>>> +                         'f850f243bd8dbd49c51e061e0f79f1697546938f454a=
eb59ab7d93e5f0d412fc')
>> Is there really no way to have a human readable filename here? I
>> know what
>> edk2/SBSA_FLASH1.fd.xz is; I have no idea what
>> f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc is
>> going to be.
>>
>
> Hosting on GitHub/GitLab as a release file?
> Or anywhere else than share.linaro.org and that has names instead of
> hashes for url (i.e. not Google drive).

If you can setup a build pipeline that generates releases got for it.
However for it's faults at least we have control of share.linaro.org - I
have no idea what the policy for hosting binaries on github is. I'm
almost sure it violates some policy otherwise people would spam github
for cheap hosting.

The tool does actually know the name in the schema:

  Name	string
  example: Test File.jpg

  The filename. Will be 'Encrypted file' for end-to-end encrypted files

I note it is currently running 1.0 - we could see if the later versions
allow it.

>> If we can't have useful filenames, can we have comments saying what
>> the filenames
>> would be if we could have them?
>> thanks
>> -- PMM
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

