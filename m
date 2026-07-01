Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36493C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 19:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf0mU-0004tJ-Br; Wed, 01 Jul 2026 15:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wf0mS-0004tB-KM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 15:39:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wf0mQ-00065Q-NC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 15:39:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47248615e4dso1055493f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782934768; x=1783539568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xL2701bNp0/C2fZ7bBEzpI0NEEq78NMsb3WNBM5OMs=;
 b=vhBhdmCVFUC1HaAZwVgRHKVMhzdfUBpC+97MuQ1DGB6JUOWq+m2P92T6HLVQpRnjyB
 ygilNtoqNh73hoLyaGwOS7JBEReG6TmmOanK4ea2TYge1bBAcLoz8HP3BI8CgNa8QCXE
 vV9nTqsx6dSXo062zEZxdBJTh9KRld/t92I7yj5Ykf9o8P8REuO9I5Rp2Cp5SW5zba0Q
 1J67l9wkKdaHFSKI8GvnW3gQfa4shfqw3OT+VTBa6LiEK18alBJcwkyusdSiw2SnmPV6
 V1gN410gwYYc823mJ6GfHdjPNZYZZxdtpkROF4s7hRg96ozfiqZ00OHt2oIea0z6Oaxe
 y1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782934768; x=1783539568;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xL2701bNp0/C2fZ7bBEzpI0NEEq78NMsb3WNBM5OMs=;
 b=tXec8cmK2BMcOWYwWX+6v7/iqu4LBIjay3OlRVoEGMaw2l8lyCaPDZgzKKYZfuWWR1
 nti8QLdw1KWNvJKqE3TTvmuUUCB/1wrCatsie5U9DLF7r1ILayqOk+5zorAq37MQidC1
 D9fTKr1nMYRlNffYLT+MZALzpMexdmtEqpi/UvaHkjdzv0xI7TXS2YZZOFAyL+T2uG4i
 2Fg1/A6Y3gIizZk7pIv9mpBwetT6d7kkPdamtC6sp/Yq3jVHEzkXL7yFIr7d+MXTJW/Y
 pv5WbKipoonvP1V9W2DiS6dTsPiOxXufAmOkRKz3jrXh/MCEnTCp+jYYcFI8KHQg28u+
 5JGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrr3hJFe3vMnVRi6DoF0XfCeY1HbmDgqRJ/tPjWRpCLB4mLH0553RS4wtRCn4kbcGv0D2S9ckg5g0mU@nongnu.org
X-Gm-Message-State: AOJu0YzQeTlLs9VglPMXq1uLVHoBMFKAPJ1euB6KVEllR4Bt7t+F1m49
 Et038aSqTCr+mRMmIJldYAtD6PWnLRymYzPUvunSdKCbC4vLdK9PqrHARILLHH/T8qQ=
X-Gm-Gg: AfdE7ckQNMFgVXVw7FWxKM6aFIijJv1c12Pcx3ypQcveMiSOgfXOWo8IJZc6uTEcs4D
 REQK7Cjc+8BsEi8GFUbXFwBbDDbru17WVu5q2RskLiSXg/Bcr+idz9d/Nr+s3jEOpPBUc9L7by1
 WJ6vsHtpjn2jWjWuUgkUOQH7voIMkroZIpH5mbxGiJ4pd8nUAko7EOdkpveBpXQYw3QeYGzbP/T
 qUzjMDCwJDBz6OKGKdzSPXl6r9kWyEMQnKiAXXfMM7cTsWKvrva1eBIzTlmr0FExSWE7z3IQeSS
 7q+pg0MOih7RxwHCt8XYHuI8LCCsqgeAX/hT+cRDWJ7rb2vz3UrrWRIy7m+3yYdU1aaeEJLZLkp
 8jcSbDneEmkxcalvUOtxU7gUkjF9JCQW23cxmhL5kN8A8F+i2otc2UlZwIFzi+2b/0lWscE1W+9
 Pnt5cqRof3vAjP
X-Received: by 2002:a05:6000:469b:b0:477:2e75:522c with SMTP id
 ffacd0b85a97d-4775a1010f1mr3024596f8f.28.1782934768220; 
 Wed, 01 Jul 2026 12:39:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4ad4sm2555225f8f.11.2026.07.01.12.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:39:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41C9E5F889;
 Wed, 01 Jul 2026 20:39:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,  Emmanuel Blot
 <eblot@meta.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: macOS builds broken in CI
In-Reply-To: <CAJSP0QWgS5wN1rnMw_xx5DwDDfpkGyB5fJEHdCGbK3mG7Xdqag@mail.gmail.com>
 (Stefan Hajnoczi's message of "Wed, 1 Jul 2026 19:26:38 +0200")
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
 <CAJSP0QWBpXN-=iu_13y3k_4z4uZJX7NPTgFH16CSBn30EYTrAg@mail.gmail.com>
 <CAJSP0QWtZUKQC5d23+tJi896H6sndwL+bD2cvSkQhC67mBjbkw@mail.gmail.com>
 <CAJSP0QWgS5wN1rnMw_xx5DwDDfpkGyB5fJEHdCGbK3mG7Xdqag@mail.gmail.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 01 Jul 2026 20:39:26 +0100
Message-ID: <87fr22ts7l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> (Update Philippe's email address.)
>
> On Wed, Jul 1, 2026 at 7:23=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>>
>> On Thu, Jun 25, 2026 at 9:53=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
>> >
>> > On Thu, Jun 25, 2026 at 3:15=E2=80=AFPM Mohamed Mediouni
>> > <mohamed@unpredictable.fr> wrote:
>> > >
>> > >
>> > >
>> > > > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable=
.fr> wrote:
>> > > >
>> > > >
>> > > >
>> > > >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> w=
rote:
>> > > >>
>> > > >> Hi Alex,
>> > > >> tests/tcg/multiarch/system/Makefile.softmmu-target's
>> > > >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runne=
rs. 5
>> > > >> days ago it still passed, but now rerunning the pipeline on the s=
ame
>> > > >> commit ID fails:
>> > > >>
>> > > >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipel=
ines/2615134022
>> > > >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/2=
629704018
>> > > >>
>> > > >> I've tried many CI runs with different pull requests applied on t=
op of
>> > > >> qemu.git/master and they fail in the same way. Maybe it's an
>> > > >> environmental thing with the macOS runners?
>> > > >>
>> > > >> It's unclear where the SIGKILL (Error 137) comes from. Could it b=
e an
>> > > >> out-of-memory condition on macOS runners?
>> > > >
>> > > > Hi,
>> > > >
>> > > > SIGKILL is the known symptom for failure during signature verifica=
tion
>> > > > by AMFI.
>> > > >
>> > > > Now that we don=E2=80=99t have separate -unsigned binaries anymore=
 but relying
>> > > > on in-place ad-hoc (w/o certificate) signing with entitlements we =
might
>> > > > have issues linked to that.
>> > > >
>> > > > In the past file modification had issues with verification tied to=
 the
>> > > > inode and the workaround being a reboot or a cat binary > new_bina=
ry;
>> > > > chmod +x new_binary so that the old (now out of sync) signing stat=
e is lost
>> > > >
>> > > This is highlighted in the software update context in: https://devel=
oper.apple.com/documentation/security/updating-mac-software
>> > >
>> > > > This code is incorrect because it modifies the command-line
>> > > > tool=E2=80=99s executable file in place. macOS caches information
>> > > > about the code=E2=80=99s signature in the kernel. It doesn=E2=80=
=99t flush
>> > > > that cache when you modify the file=E2=80=99s contents. Modifying =
the
>> > > > file in place yields a mismatch between the file=E2=80=99s contents
>> > > > and the in-kernel cache, which can cause a hard-to-reproduce
>> > > > code-signing crash the next time you run the tool.
>> > > > While this example uses a command-line tool to demonstrate the
>> > > > issue, updating any file that contains signed code might
>> > > > trigger this code-signing crash. That includes executables,
>> > > > frameworks, dynamic libraries, and bundles.
>> > > > To update a file that contains signed code without risking this cr=
ash, write the updated code to a temporary file and replace the existing fi=
le with that temporary one:
>> > >
>> >
>> > Nice, thanks for sharing this! Do you want to send a patch to fix this?
>>
>> The macOS CI jobs have been failing for a week. The QEMU 11.1 soft
>> freeze is on July 7th and I'm concerned that we will enter the 11.1
>> freeze without working macOS builds in the CI system.
>>
>> Does anyone want to fix this macOS host issue?

I'll have a look tomorrow.

>>
>> Stefan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

