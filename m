Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F29C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzUX-0004x0-W5; Wed, 16 Jul 2025 06:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubzLr-0005wG-Ty
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:27:14 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ubzLp-00051c-E0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:27:03 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60c01f70092so10712642a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752661618; x=1753266418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ib04l/ykAWQliB1DGXibqTIzCBddfVjfjwviN9NuPKA=;
 b=fdcwP6leL+/7VPEnkc+f2DVnKPmU2sNcJRHOcRfc7IqDEwomuqC89pmxvzu24lfBF8
 sV3O7Fns9PzwvJ7BeEkzwZdzXXR2QtPl90sCkwMBoSA5nfkZ0re4L3DFMEUME0TQSEqA
 1eHn8NmcYQ48QvObRszPkuQ+QkoZH6jZn4n1bc/mTYCMtLrXM6C/DfwVccJJlqo8HVQj
 I3pVJhpr4noW0nHms4y5EkTgLVZl65P0xz1oRpIAt3THnpI418F/8Ez7Ye59KACA3hBD
 kFrA650GIatY2DcTMCNoUG7yyzrSHrxOYmMF/IVGsX8f7sPdgi8eI5RcWWHfGOcmHWvb
 GNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752661618; x=1753266418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ib04l/ykAWQliB1DGXibqTIzCBddfVjfjwviN9NuPKA=;
 b=Hz2bv25Z8LuxSb+7U0pQ7TEqULt/+82aIAiOwH2ig2vxrTQGQaQcSVEvy+MBsu8kZW
 XFIlGs7bmA77596m7tyKyWicyQgQOOmmwXTa24daHoQAEU5IvtorPmsDI4+23z5MO/oh
 oKigmC1tQQ/gTjPDvLRPB5RH8b1tLvpDxFKPnNLlKQweMJJjN7M50gkb6S7jO3FxPbeQ
 WE2aFPcIi9NYy2VDzGLJsbYlLLCNlnlW1gvu9wQ7GpeHfj3Dh16FshEvYmICcCvj00Eb
 gr/OmWUaLqC6L0fEOLSz8j7AtDF1U5a6NKPNzK/gSiWYET+vFEB15ZsuX90FhD9pYsK4
 ZFJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb5KsqLkGrioOWh0QIThaLwRtTdrH6oFGGHPiwMHPKxJFGvFaRRXcZJN1DQUBTsHjQq4svjbqZuFHR@nongnu.org
X-Gm-Message-State: AOJu0YxtuVwpvz5GjionQ522NSV/1xsKFd3IPl6IvuVH0vsfUWHGk4m1
 cJ0M1TdBLrqng+dIlglI4OQf9lZBWHzqnxpevDoMJK+I/zbZAg9QBqrwmj+Xm++wBZTO6heGgvi
 iVGUGolgdWsHfByCi4EOoXzJay4XzHm8=
X-Gm-Gg: ASbGncuEbZrAGzEznDMMS2l3vzUfP0DX8UYVeA0pNm0x0REef+X88m1ex17VkHWdGvI
 +nPiY1SKJsnib29OGPHxJZGni+loPzDJiPVEI1XUHOrF51/S+za21S/zKHHHkXwi2KV+SRnistG
 YhIF8v0DOi3uzQT4KJDti7miWTdncmToVA2yjeKSeSIQ31Vf9dfWUMQdpCTnEfae89FXcYt+SRI
 QamNA==
X-Google-Smtp-Source: AGHT+IEVU77xKPPXqqZ0Dv55ZhngcETDUqwoIhrZq98+WtFw2Gaqb8saFUz4taNEIaMklmYleQ2Nj3I4N17HZH8W7as=
X-Received: by 2002:a17:907:78c:b0:ad5:2328:e39b with SMTP id
 a640c23a62f3a-ae9c9af078bmr271062866b.31.1752661618382; Wed, 16 Jul 2025
 03:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250714053423.10415-1-jasowang@redhat.com>
 <20250715195028.GA242340@fedora>
 <CACGkMEs=VtoeLUeXHy9Uyqb+YsRrZDXO7tOJVKrhGqidsjOn8g@mail.gmail.com>
In-Reply-To: <CACGkMEs=VtoeLUeXHy9Uyqb+YsRrZDXO7tOJVKrhGqidsjOn8g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 16 Jul 2025 06:26:46 -0400
X-Gm-Features: Ac12FXxhZTZOOu3itkoUXlOVylJIQxFWnU0TTvHyr4hTK-7ctjKjut3LFLBkxEg
Message-ID: <CAJSP0QUOY9V=8Hkj4O0ohtz3u2nFxpbr0JxLkMiL3iRN27vXXw@mail.gmail.com>
Subject: Re: [PULL 00/13] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jul 15, 2025 at 10:23=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> Hi Stefan:
>
> On Wed, Jul 16, 2025 at 3:55=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for=
 any user-visible changes.
>
> I sent a V2 of the PULL:
>
> https://mail.gnu.org/archive/html/qemu-devel/2025-07/msg03794.html
>
> That includes some enhancement of AF_XDP. Considering you've merged
> V1, I wonder how to proceed.
>
> Are you ok to include those three patches in the next pull before hard fr=
eeze?

Hi Jason,
I'm doing a final merge today before tagging -rc0 because I see there
are more pull requests waiting. I will include your v2.

Stefan

