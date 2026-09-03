Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE57C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29aw-0005Go-Ow; Thu, 03 Sep 2026 11:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x29au-0005FY-Pf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:43:16 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x29as-0003Yc-Cd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:43:16 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-86b03b75fecso393237b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788450193; cv=none;
 d=google.com; s=arc-20260327;
 b=AWNfjV149iSEjCe7iB4tgXyUpXJBp20z2AfuS7IgORTQ4uQKGYpHBnTK5UtVrtcr0R
 fhr+lDeuZ04BLlsdAPv5rVsHOOn4F5T+ezfLjeERnX27YYOFSxL0UwxFY2Gvif3cWInF
 UvPmyy9NUMJN81lRc/3yfEgkA5/qyseTBstlK0dxPgg0Ssw1D257rU0Sx+rMPuaTz4O5
 giQCr6AG5ebEv0wGf7CYyK1ISQn2WpF1ie9gf4U8YN/C3bDZPBsR0ABqCVtpf9ngsUZH
 iAgjlKiIsEFJs6XmhrOJJMj2Inl4oIvgfwPSmZFAsv5d7Dxy3btlY9104QAnYLqpMjKm
 /64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZRxsOrmA5EDylYoiOGMb6qq9DTnFpUX7RipNDmZgIbw=;
 fh=T+332A5ujRAvIM066VCGT/E6vI12MX14OsfX9lrtuRg=;
 b=IfJ8RomN0iqUoj5IHfJ9/zOUj2FUHqUC/Fd/7ZUKNxYINJhcLu1hJyqrPaUb/YNrml
 tKue/KY/IP39h70XMVXzloqYAA/XKaqWnycpaOUvv2MTVmgObLu25mweeviYtgorxl7c
 7HxfKbRWDEoVewJ1d8cc55rFzriGjUYJfQrGHe6CoG5V035yUqQdk8p16Kvkt9TTYW4U
 Klx8eA6ph0FcxwOcN+2E7R7YY2cFQyyrxJelh+8ya3qabVCCDUf2dnR8aFRE1z9QSsn1
 cXm8AW5j25B55HDsVih4pJu4HvYoQ1hwX+Gzd8SPfhs1F4mbg0M0Vap4MArPLvEquhR8
 +K9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788450193; x=1789054993; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZRxsOrmA5EDylYoiOGMb6qq9DTnFpUX7RipNDmZgIbw=;
 b=RJbmKF/yZCCp53jUqc+r5bDhHM9EkWaCJsCvU6PfFH57E+Glryx4/liFGzDpEwYuKc
 rLx0dxCgHA40G2rnkldLOnayCFCAU3s0ETUtVZwknM7AtAQEtK7Vr9eiTLzcwX6jeC7O
 rH383muRPv+H2hKY9LHB7phvyHi50f4HeDd9jr2ybMF+9ffQtP41EvFfwFV6wfVN968u
 srJKomHzHTly7FYC+1LfKyUdaX/PKtTduXmW2MpStUqCqJuCsyElupdaDvWgChzcqY92
 NvS5B1rzOT7E/QdP0eJyBdSRzKR1BwpAlm9jrbz39zubhi6ZJVcWCpwa8vU5I6QOXU0b
 Of0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788450193; x=1789054993;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZRxsOrmA5EDylYoiOGMb6qq9DTnFpUX7RipNDmZgIbw=;
 b=S209tNvB2HTULoHglTXY79eZ+tAKWBkMRqL4G6RPOC43mu19jf6ydi7bQyKWtrd1Rr
 gCTdBSNqadkvevphuSCTjZIiz0Y/2BUAR36SPJbs6adCAtkJn9QmMAMhA8VykfL5z2KH
 6MyK8/foOgT+XtCJNBncQ139SZuv96Ss6mi3K2deP3e1TwRgvSw1NtoYM7u1uPy5GdB/
 uK1EPPG/DV6SUecamnVFhy7tCSNXXmvx0rmkKzAk18KBoysHvje90haQ3DmujrvOBG8p
 rBO5neXpyerHPsNbivAEszXJi5WuQ0T+ioZlxvyEhNAF1AzmNqjmx6aJ8p2OJqJoxwOD
 7JXQ==
X-Gm-Message-State: AFuF++l5oPJSQKCtCCjiT3gb2FK/H40vWvPF5gKciEJXgLVYGnD31nzB
 Rn+JdvnSZZKrjGMI57t62+0G/170IAtwvbBAo29vNVJe5apUTlimAWJoQ9aET2N4fR/Shd8FrZS
 QjphTcB1FVz8q0AaZlWl4lfBfRY1x3M8W8PV0NpS9Fxip4lnfVYhJ748=
X-Gm-Gg: AYBFou2EitxOb7MVFPwvGTwFjpARUuGmel7nv2NqQ1YJNE6bZNzZ26bDT3M6/BdnwC5
 R9IA2oggqp93+ELRag95a2NIzk2sjnu7sNQ6TjnU3vu1Du+43U+I6LPkYnNGxK0cU7EbweJQt4t
 Y5Q0zbzOmJNsTEaUUgXZd7QjxZsEkYCD528bX0qmFqRRLa7rtUrdWq5yB9CESxD2TjCROuC9kQC
 UMuVmTkUxL8VbZiPQzXC+OGP4ub0s9gJgm5U8V2TWXVym6GPjWL3m8CwdvDBB5bRiCArnBC3a0t
 wnojK+o5gMYqbm7chl8/Rm/8hy/3AQJnNerNbbyUB4WhyiwtRKiVfDyoIJDL8Or5xwG52uXTlRv
 rwJxseAs1mpvNGU9NIfsoxN8hkG06
X-Received: by 2002:a05:690c:4f0e:b0:868:505e:b978 with SMTP id
 00721157ae682-86c4e209785mr55444067b3.7.1788450192830; Thu, 03 Sep 2026
 08:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260902193551.582660-1-jsnow@redhat.com>
In-Reply-To: <20260902193551.582660-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2026 16:43:01 +0100
X-Gm-Features: AcwNN1WKfKMd-iA8T5mfq-A0cV4oU1dCwR14toz8esetgqjqOiJZ2Ijr2_A2ptk
Message-ID: <CAFEAcA-vEb4jq=-afegE2qP9G4pHj1vPKMc7wSVbdeggPkkpCg@mail.gmail.com>
Subject: Re: [PULL 00/16] Python patches
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ed Maste <emaste@freebsd.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Yonggang Luo <luoyonggang@gmail.com>, 
 Warner Losh <imp@bsdimp.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Sept 2026 at 20:36, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit a925240509d1b4b656cc480f1cc79ba4d7c8bc08:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-09-02 13:40:43 +0100)
>
> are available in the Git repository at:
>
>   git@gitlab.com:jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 4061c0e95c6e2736926ab8723606cddf582f58e6:
>
>   sphinx: drop qapidoc back-compat overboiled spaghetti dinner (2026-09-02 15:02:58 -0400)
>
> ----------------------------------------------------------------
> python
>
> upgrade to py312
>
> ----------------------------------------------------------------




Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

