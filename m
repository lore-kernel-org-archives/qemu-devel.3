Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966B9CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IIt-0005ti-R5; Mon, 29 Sep 2025 14:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3IIs-0005tM-9H
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:08:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3IIp-0001DD-Sy
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:08:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-414f48bd5a7so3164491f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 11:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759169324; x=1759774124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa/is+6Xat5RR1GzShQnNksnpgfay0FQYp0bODEPB78=;
 b=Ch/4yukwrjJ45Dz6sN+a73FYTqAg2OiS3w9MJgpzSs3RR4ymzpvKUecht500s1Zzl9
 7WYpGZuwi5+8mmLvDK5TvSRQcgMZFr2nVwlhUddxELvNHGt5nxzTwO4dRoZj5zHD5ZAZ
 0aRJq+K2ZzSBV/1PFM1xGnf28TFg+utVLDLOzhjsZg7xRHvuhjHESQ8jCMF1g5sLgBFH
 kykA3+sywTxlZB3Df+fqe6Uud+mu2qQeDiPZ4ann44Z/hL98q8SAOI7G0pAK0uBBR7vK
 rAMH3lrnW8OSXYF2vTwpmvv7V9rhGOO1VMbVvQ3ivZ419QLUR+kskySe4YwSIWKDwxPp
 68iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759169324; x=1759774124;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sa/is+6Xat5RR1GzShQnNksnpgfay0FQYp0bODEPB78=;
 b=PfG+MMSRM0g/h8GALgtsTErk85x6Bl7ga6NF/eOJcMg5PWdUZv/6aRp5vn8Orfic5L
 rGZTjpDYmBDXGHZ0Ef1WM75Oujmdh6TXw8N3cPXj1V0WGchYbK8nAVJTjuM3nvvnbsMP
 geSANNmt7UjrmEBHPGpZrsv+7LRmJRhx+MkJv+86BhaLPG0AaCbgIlvbYuRmyz0nh5m2
 rjY+5YKuljZcpXSb+MIb2oiUUKLBg7QbzE11AHdOM4NE258benH85juGp9C01brsrcjo
 sBIs0uwihHkJEHE403rz3V+YglfdQb5cI0Xu/Em98IMgMF1SNJhE6TeiIYV/AoQYo5tW
 /IZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOyBDCDH2CdVMZeCDDDLgSOP/EA26GezP+1pt5hVGqNAcQbdYNwpfF4kTIfFesF+QPSGqCsV1sSHmL@nongnu.org
X-Gm-Message-State: AOJu0YzRHkf1QX8oO3by+d6l3G3v4OKVRL5rdWOYXOwwvlGf07BQPGaA
 gIrAzDXCbKSwBtTnbpFgi+gXzMHjSYTmxQ00urWAdRbwKTJGu82zIVCL5ELfBG9hbUg=
X-Gm-Gg: ASbGncsKRR3MOjaVs3b06+gYApNdhg6Sk1/fqxLRSPHqxF1H4zfWAZb0vDFH1UDZ8XP
 riSGuQSODVoK8v1ADFZ4KcT73p+pTcCjyZ0f/e3/iFLoadZSuMIqJYyLsZhxtZYgQA1IuVN+pMI
 Owe9Qc1ocRfaNa/bj6M2Ry5kU97Si0BTX843csqJsO6/pxwoM7iFMQApeAU3YtTr/tyQ+AjOD+F
 epLAzw0tfJznxbTtKRsmhkcJZQePX9nnoe96+JGloePA5chBd4hUYoih1eAcJmfGRkH+P54rjF8
 rKtFjbPU4xALPoX5gdKpunP/xTw0xnUo/Rdbd3vuRakyQ2Ipa/dPnM/hhTrXGjKKJQc8yiDitCS
 HvlsCh5sOEFEszb82WHenof4JNRkklZWHNw==
X-Google-Smtp-Source: AGHT+IFAxtUjiIk7vr20gQ6yIbeAV+T0Rh02llDqnwwkppPPARBCp39aKCZQ/1jHRmaYFYXiQdBang==
X-Received: by 2002:a05:6000:26c9:b0:3e4:e4e:343c with SMTP id
 ffacd0b85a97d-40e47ee1947mr15166498f8f.31.1759169323782; 
 Mon, 29 Sep 2025 11:08:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb017sm19201532f8f.3.2025.09.29.11.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 11:08:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF1FA5F83A;
 Mon, 29 Sep 2025 19:08:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 u-boot@lists.denx.de, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] link principle license to COPYING
In-Reply-To: <20250929165042.GJ6093@bill-the-cat> (Tom Rini's message of "Mon, 
 29 Sep 2025 10:50:42 -0600")
References: <20250929155142.1647606-1-alex.bennee@linaro.org>
 <20250929165042.GJ6093@bill-the-cat>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 29 Sep 2025 19:08:41 +0100
Message-ID: <87tt0ljfme.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Tom Rini <trini@konsulko.com> writes:

> On Mon, Sep 29, 2025 at 04:51:42PM +0100, Alex Benn=C3=A9e wrote:
>
>> Some license scanners are particularly dumb and when combined with
>> automatic license scanning for FLOSS accreditation on forges cause
>> problems on renewal. As GPL 2.0 applies to the core code link the main
>> licence text to COPYING to keep everything happy.
>>=20
>> This caused issues for the QEMU project recently as we mirror (two!)
>> copies of u-boot in our project.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Since Daniel Berrang=C3=A9 posted a similar patch 3 days ago, I assume the
> gitlab license renewal is coming up quickly.

We fixed it by temporally moving the repo to another project (although
it seems that is not a true mirror as mirroing needs the full paid
GitLab). However it broke a bunch of down-streams tracking earlier
branches.

>
> In principal, I'm fine with this and will apply a patch shortly.
>
> In practice, we've always had to get a human involved at Gitlab to get
> our license renewed as we're clearly within the required terms, it's
> just that we've also got some further reading people should do.

The GitLab process is a click though automated one now. However I did
check GitLab identifies the right license with the patch:

  https://gitlab.com/stsquad/u-boot/


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

