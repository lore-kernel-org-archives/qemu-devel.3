Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DF3C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkSY-0005WE-Hu; Mon, 20 Jul 2026 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlkSS-0005Uz-VA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:38:45 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlkSR-0001KR-6H
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:38:44 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81e69a2db34so49295967b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 02:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784540322; cv=none;
 d=google.com; s=arc-20260327;
 b=HgEacak/kJQhRaY3yaa08AgiCgMqdBqFDcfM8KM4EMbdO1F1mHuWVxmBXaemodwaxJ
 AKt2jp1YtBNjmJnEsDntm+ABvBxGwAi44DrlCDzeSBHETvAej8l29UF/IafXgD6UPlLR
 2aoOKETnIbF51tc9rkQteSI+iUdTq2RR+qIB7liNtFoJA33iQGvuN4B7HLNEA2uhSX7O
 zlSqELafQVwCwj93eGPwASq5e4qiu8g5DgtdAoVFYIGXIy/MnxqJv90cXZyOoJ+vIhvp
 D0UK2Lpf4Ly8EN4ag2F1vX418+2Sti5e3PKDqfBx7pHdMXb5GliRq3o3uBMfDwvB2Sxe
 UaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fGs3YhUAy5iS39FJNJw5sUjFsROlOzM4DzyuocfWb0Q=;
 fh=s3NtNAP3kwCTVC9F9j28vf7WgKiQrzz4SlBOeBsXzE8=;
 b=dZdsxmuAnga1HoUJX/M7r1BvjPfTDm2Tbk5bsMkn+E+qn4FyzpkKfZ3W51L5IPdwfa
 Vk+bTKs0BMJkbovgcd/jvk5uOiyYwtXQh48bEoSOJEcj1B+jURiOhpsT8JkWZ31ApalW
 QVH76MkOsi4i/dg9p+IcvmMRaMN37Xw2+qKwoUyA70h7aXVhYfkRq9EXzgOQtybwo1yY
 /l8+SM6aF4NP1c1W9YmVtUEnj0iz6OOrfYvC0FLIhsUhAwebHA45V0/pSoKeGw4GwI7k
 ZNH7xIfq/rmFpWuBbNZDJzeLVH+ZDxkd/wfTwY4u/2NdyHILmIbJb5fHs239//9FFfZG
 F62w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784540322; x=1785145122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fGs3YhUAy5iS39FJNJw5sUjFsROlOzM4DzyuocfWb0Q=;
 b=ZyZdEi5j9rB+bYMoseThqcmK5LT51xWP45+M8cQVpmRVOBaneZJQbG9cmZy1SryYUo
 bav3DdtXlu39xuvIG/9UNEoNoH7m5ghrdOgkVV1eum/JksOb6obj+RxhjDy4MDfHqJZr
 YNlmXqWz2DlQI4kuLmsv1RN5yVW9Se6QlVmfU9oktM2re79eqTY1dmjt4MFxSoMH0A1U
 4IO52G+qk8vf6XlFKfRPz6ou/bd9sa22lvEfHPXFmPilpMsmzH43vvvAqJx/P92uYim5
 rN+w2RapFoUf5ksn/ctk5D5SsTGRY9A3+mr8JJqN55aJ0em/8aY1QIT/Ybzzjiy+slKs
 4rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784540322; x=1785145122;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fGs3YhUAy5iS39FJNJw5sUjFsROlOzM4DzyuocfWb0Q=;
 b=ONEcbwnfww0fsgObRFYi0C6BlCbIuYSZYtfaGpAM2aWblmCiMK+0c+iVLY87WYKSgR
 8/AhWEePv4d3axMXYwXPXeqcxexYjnm/ijyj88bNThU/LvKMSK2GZ6qsCcpO3T9Gc02L
 NXvfMUi3tu04dUNl0zj4fs4I6c9v3Ea3ZwGyQYgno9LvtfoDAzajxEoOIXYcsogdk/iL
 LhhQ2tCU8zisBbhLKwDm9WfHyRV9Me0jubgPgUpiwIGKAkPTVjNF722Q27XiNLXuW16Y
 W/hJOQXJQkjISxAPHP+4yTkW89cW2TFkF2oBKe1O8UPVByflFSXa2f7t/0KllrEkZD35
 Gm0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpftuWVv9XKqecix1oRUVLO04PBcbDh05I82a8lBmdDqAaj7HieccaiGtqQ8YmCk5ZhdsztjnHQ817/@nongnu.org
X-Gm-Message-State: AOJu0YxJDy66KNkH1/riW+tOjWLOe7AQVjJJ7tG5cYVP7bCp9IkzUfzb
 VTcYb+Z+L7QfbbntI+R7k9Asb7iLutm/NgH1gD+bzz63pEGdF6GssYReSDT+KWeWsAmHt5kJunA
 XPot7n5po7BH2Wd2gUM/Qmi5cKXI8Y81qzQGLzc57cA==
X-Gm-Gg: AR+sD10d3Lpzkn5g5KaKnlKpxMkzc6f5PB6ftieQBI3xmkuHyTU69OVWmA378DflzAh
 A8Gcir3U8DchDm5qnjDxdF1CoSU4ebBfYlUmIN/SVhBTkIQtAmBVKRU5Mdb3DKWIwaJgkqNMUs+
 RXRE1/gcHRHrq41EmvgctS7j1GOST5zwwmYl0Ii3qWJBd4T+v0+JekQ3ud2vPBnqa/n/jIM2Tjf
 JiEEQhNqEXNAvRFyWxNmx0jfI4ihtmifQ1jM2eENgr1FrS1SB5Y4FpEcseATJwGHA42F/mTE7Da
 yJFCOJSgXpSWgRIfB6Hx7Pfawz5FP1w0ywRF2SM8KfQ3pwjOwn1y9led
X-Received: by 2002:a05:690c:6111:b0:81e:6816:9487 with SMTP id
 00721157ae682-81ef28da68amr40494987b3.66.1784540321603; Mon, 20 Jul 2026
 02:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
In-Reply-To: <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 10:38:30 +0100
X-Gm-Features: AUfX_mwmsDuPawTQUb1yoVNqwq9y2LJJvn2tFHACUO5HV2mHaV5oUq3WsWZNhLw
Message-ID: <CAFEAcA-X7h0hQ4FaTaVoEUKTJvxfaK8GcihR=+RzxOTBf3X_mw@mail.gmail.com>
Subject: Re: macOS builds broken in CI
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 25 Jun 2026 at 20:15, Mohamed Mediouni <mohamed@unpredictable.fr> w=
rote:
>
>
>
> > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
> >
> >
> >
> >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >>
> >> Hi Alex,
> >> tests/tcg/multiarch/system/Makefile.softmmu-target's
> >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners. 5
> >> days ago it still passed, but now rerunning the pipeline on the same
> >> commit ID fails:
> >>
> >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipelines/=
2615134022
> >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/262970=
4018
> >>
> >> I've tried many CI runs with different pull requests applied on top of
> >> qemu.git/master and they fail in the same way. Maybe it's an
> >> environmental thing with the macOS runners?
> >>
> >> It's unclear where the SIGKILL (Error 137) comes from. Could it be an
> >> out-of-memory condition on macOS runners?
> >
> > Hi,
> >
> > SIGKILL is the known symptom for failure during signature verification
> > by AMFI.
> >
> > Now that we don=E2=80=99t have separate -unsigned binaries anymore but =
relying
> > on in-place ad-hoc (w/o certificate) signing with entitlements we might
> > have issues linked to that.
> >
> > In the past file modification had issues with verification tied to the
> > inode and the workaround being a reboot or a cat binary > new_binary;
> > chmod +x new_binary so that the old (now out of sync) signing state is =
lost
> >
> This is highlighted in the software update context in: https://developer.=
apple.com/documentation/security/updating-mac-software
>
> > This code is incorrect because it modifies the command-line tool=E2=80=
=99s executable file in place. macOS caches information about the code=E2=
=80=99s signature in the kernel. It doesn=E2=80=99t flush that cache when y=
ou modify the file=E2=80=99s contents. Modifying the file in place yields a=
 mismatch between the file=E2=80=99s contents and the in-kernel cache, whic=
h can cause a hard-to-reproduce code-signing crash the next time you run th=
e tool.
> > While this example uses a command-line tool to demonstrate the issue, u=
pdating any file that contains signed code might trigger this code-signing =
crash. That includes executables, frameworks, dynamic libraries, and bundle=
s.
> > To update a file that contains signed code without risking this crash, =
write the updated code to a temporary file and replace the existing file wi=
th that temporary one:

I was just looking at this again today, but looking at our
scripts/entitlement.sh, when meson.build calls the script SRC
will be qemu-system-foo-unsigned and DST will be
qemu-system-foo, and we take the in_place case and do:

  cp -pPf "$SRC" "$DST.tmp"
  SRC=3D"$DST.tmp"

to copy the -unsigned binary to a .tmp file. Then we
run codesign on that .tmp file, and finally

  mv -f "$SRC" "$DST"

to rename the signed binary to its final name.

So that looks to me like we're following the rules for
not signing executables in place to me...

-- PMM

