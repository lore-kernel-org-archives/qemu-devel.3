Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9946EC1EB9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 13:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnzk2-0000R6-Is; Thu, 05 Feb 2026 08:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnzk0-0000Qc-Lo
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:49:52 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnzjy-0000k1-Qg
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 08:49:52 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-794fe698e36so11298227b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 05:49:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770299390; cv=none;
 d=google.com; s=arc-20240605;
 b=TGuPW95UlX4RYazHUWNWgBTzCidP8QDVQ3gplKRZ2NI/PqCcXZTGUW616hN5vwDC73
 oY1QWsQ+aYVG8+8MRvgpdknf8erwYcw6BZ5w4WEgPs4sTjZLBdga/lsLEDeU7Ig4c2Mt
 JCJv1P8agDgQ5jkTKllnRmfO+Gd+wLSljSKX2Ks4hn+pZ/bVc6tPoVvUTx6S8skgYUsY
 A8EH3ONJHrY2F8tb7KpA9bm2zpX39dp2DrisKxjIivwBiSOUR2sVoSslYMr24HQpGd1t
 hUj68c6h+0Pcc2tr1YboSWreI1nTUPn6oZ7rv9RRBHox0kNNnsrdYsP949V3ECPL0Fio
 ltxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VUJV7lO2Etxa8EI6mOIX+Zm3FnjXLmbHxih+VeV14YU=;
 fh=ChTBsvUZEChGwtOKl1bHGKWwWzs1ViLPHy2xZOZWEW0=;
 b=isoeFYkZuI6mK/s2nY80q2Pr4lABy2wnQ6gtQLMsF0L1BbyNFvAoHxX1SVsZlik+zE
 pf5wCZIPXhMEFvNQZoYZ1u3+fywEb6kUtGeY7a+Q/cnHJwVKlu50kZslZ9y52wQ/ZiTu
 jQNVfB/NdRGb4yfe7z/MGqJ+MeoZQpley1fIQXzJ469tQQtZC8lRhZAQivpXcvGfG6QN
 Y6CKVdylva4iSzUKmHm1jHs8bunSmfjnQibwv4i58BGZukThhfrnUQA1LtiKMlPXKm7C
 sXK6nWfunQC/7qlu3izcbihKcI+gE6skTHMGsKpOiScEfMj7Ki75T+z7yBlpqoRYJme4
 BbGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770299390; x=1770904190; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUJV7lO2Etxa8EI6mOIX+Zm3FnjXLmbHxih+VeV14YU=;
 b=Usgnuw40Luv1ynAcwXAyActLl7WGTmRzyk7pU6xRjR7S3lFfJ0HSrR2Lg8z/HtzamA
 doVaB9eITev+op/FVR6W9KIiWdI3n+6jt43xmXnWPYALh+UEJ4OkWrWl2BC8RUJuyj3k
 5JOcd9WVp0mIpguz2CvwULr2hMQthI6+q1nQaS6DnWD0HLn9jQ4i52nVWH7+OE9d9q+4
 v6owNhAOnAci9wgZSJ8siBWKXJPSm4Vi5pErQS49YdVAIl0fctyvgM8hIc2Vu24Jb0Mp
 OXJY8W9yI87uRgnctICRjQ5rbGck1l91+/X7cnTlJRp5tbvv9xEKYBYQLYC68xG2kHKZ
 GJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770299390; x=1770904190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUJV7lO2Etxa8EI6mOIX+Zm3FnjXLmbHxih+VeV14YU=;
 b=mYD7tTzJ1e6krhNrbEyYBmD95z4pxtQzqe9BzLfF1oN+SGxR+fVJRKuU5qH0k57FHo
 wyh/JiDTKaGCfCAKtOPBUHFh3EpbTpYB7lSSLQ0FnaVZsxGcCYOTiXx3fyaPZJtUQjuD
 kk1JPbdiyf3ipACz7oUpeV2E2uE8BgKeFKgc/TFa/FNC36bZHlECFuRevrF6UfogAJO0
 Dkv5hJ9SKjlbFNcgyYCLHDOcVcSEfmvbR/rwYqmPU23Dh2AnsVVetw+Qn+v06sLZOTNT
 wXU45uqBRetqvmoU/HS7KAiolJUlW9TuUtswx3nzflQ/Etv3murT3uYT5TbWVqsrp2Xj
 53wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDjw2DOvh4c4+EHQMnIOHFadcbLwlCp3jW3FEgSrmw3QBDkrfP90FW7+lv6vWAtti1UYZQtiAX8Y6h@nongnu.org
X-Gm-Message-State: AOJu0Yxqy/+AZlHa4mXBkJNKLk9BC/MAsD9nx6AJROY8/ui8l0XEO1o2
 2pQSBU+YOGfihGSTLFxvBejcyZVZjqqDLYntv2KIh/uQbjyY82VseVxgV8o53LkzgmTHviNejLU
 I704Rhn9MYd6ICn5K6AEjnLIAosWQ4csqNvBYTHWvkg==
X-Gm-Gg: AZuq6aJHcFOcWAPwoRaeJCNttiMQJtQsVlvKPjaTEYS12QZvkIplzOyd0odrH2iQTxF
 S6EssCER9TPCe79wkq5BU3fGlzi2lL+1jkKbF1szghzCWgeB4HjR/BVdNEiLSCen2lN84FvbkV8
 3kEqofyCmdLoh3rvyRDmiQSC6znYxhGmGqrWZGehVQBn9vfdut1XQig4hdn803F2QRvQBmUouHU
 c7d4M9DAO5/3+3WvQzz+uIc8hl+VmArdFlW2TsegFKiu5va0OeeAZSKaKKl6ew69jRCjQ==
X-Received: by 2002:a05:690c:9692:b0:794:b8c0:5a96 with SMTP id
 00721157ae682-794fe8b469cmr57914957b3.56.1770299389623; Thu, 05 Feb 2026
 05:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20260204103136.1795455-1-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 13:49:37 +0000
X-Gm-Features: AZwV_Qghem5n2npTxlGOn-5VoMGTEnUpF91GxHZNzmgCxur4QQNh3CfnWRVtpMw
Message-ID: <CAFEAcA_w02hxyiCtOzWc9mmFR=6pLixObnSnenhBdJ4zixjfrA@mail.gmail.com>
Subject: Re: [PULL 00/45] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 4 Feb 2026 at 10:31, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 28a6ca268c2cd3718b5bf24c2d97e3d1e95fc6=
04:
>
>   Merge tag 'single-binary-20260203' of https://github.com/philmd/qemu in=
to staging (2026-02-04 01:57:26 +1000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260204
>
> for you to fetch changes up to e56e45d5bdc808ed52f943d1a785e4d885b6f18f:
>
>   tests/functional/aarch64: Add I2C test for AST1700 IO expanders (2026-0=
2-04 10:10:57 +0100)

I noticed this a bit late, but:

> ----------------------------------------------------------------
> C=C3=A9dric Le Goater (3):
>       Merge tag 'pull-vbootrom-20260116-v3' into aspeed-next

could you not include merge commits in your pull requests, please?
We don't generally do that (the last one I think where we had it
was back in 2023), and it will definitely cause you problems if
I ever bounce a pullreq back to you with "please rebase"...

thanks
-- PMM

