Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD8FCD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 08:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAzC-0006sm-2k; Tue, 05 May 2026 04:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKAzB-0006sX-76
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:18:33 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKAz9-0007aO-No
 for qemu-devel@nongnu.org; Tue, 05 May 2026 04:18:32 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c21049dafso4645029d50.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 01:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777969110; cv=none;
 d=google.com; s=arc-20240605;
 b=JamiQQnGT4gRxtO165OhvOal/RNFD+/RnyBHvXNoXwJXJGoyLMd54k8Do2RQGE+g78
 zedYM2Jh8Yjz8xCCxxYgu5h1Jc6AzPgbPfyimFi+WvHcf72/heNpg14eLqvov8ablxIA
 KEBlmHONUTtUlDJjFZUObMF4bd0emHxFzz5Srr4sv78Bve+engosLDWI/nQKt39JHXNY
 kTiz+ZDK8o2isT7UhHUyMgVhaUh0ukgn9Z4eEyHjGkk/R/Bu1M2Bf/f5dirStze47N67
 7LdwNpw9Ay6PU182u8A6m+b8hIoDgbm/hW5wKnk9kb9vjAK2u3rWdDXsHagapa9ItyWY
 /CZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8iACR/gHRLBBLts9Z7rvitoq9zFPlMAA1icxYCWfZ40=;
 fh=0wL63QeoBMNWrXsxDGVQk6eFJMbbFJ4UtXHphZINY1k=;
 b=UoMDC20vq2L090/mCxwuXKAyLQwis8vj91vZLCY/k5uGIxH4Ss+6OrSNM3XY/gXKXK
 6RKYoYRuDNagqPO5VJQVjRptptmpdJct73lPfrUyxN6nPaBPUDp+xHHVZRdastpIH1a1
 i9dFlWmCEjHp2p7VoAVUbzYMtgV17p5hcCHVm1Tz+wSxqecy/Mjv1TyqrHQ4sVmv36bd
 baIaHDzRB4om94e6morz3Ged8vtoHGjd9hr/YG4ksQJa1PbVqfRv517IB0m31C3dedcw
 i089PIeBecVgyEVS2sXloAy51OTKCeSXFy1AtOHpRD+SqpAizVlBDFBTNCcNiX7ctwCN
 OJOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777969110; x=1778573910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iACR/gHRLBBLts9Z7rvitoq9zFPlMAA1icxYCWfZ40=;
 b=aEwM+vOy/pueg9MJseugP8GoiWGUsitjro62CaY0DxigCOwb5YRxlXn0e/YpCCGJ4G
 Cht5ykdwGB1HoUC/n9po8cGcm36l/vkyy0z2lXMn46o2RVpbhJEpLU+UZyVuVQLVe+ee
 VSZHdaxEUiniJCG70hcDC1N/A0B0/d6vCglEZj4Fc47ROMkhub501mlCxhQ5+dc32Web
 0xYQyEf1s6QXpF6ZTBMLc31nfvoBEaRdhDjGjdsseYVoTTh0jGBTzFnT3m/o+TUOoGcQ
 cYqArRym/XuCtqvfjze4+Nuli2nsvTYqAPum0GW9SMpWCh3ZxVWlzUoGFR5cqF0qXeTu
 kJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777969110; x=1778573910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8iACR/gHRLBBLts9Z7rvitoq9zFPlMAA1icxYCWfZ40=;
 b=sRsigw6W5D6w+7WQMf3lOmdjACEgbAABGocA2HhCWQTuYBYqjEECkIZWdO5AjvMvUC
 dmAzE6a0pudpm3W8OH74POBC6m50uQSQHuvaS9DCgiEr3UnQvhYZGHxVs+7wyP7sje+R
 bFNYNFNh/4lUuXbJnpm1hNC3eUVwxF0iOEdeV5NKD28po0/d68TuCy972XUmKdVgXmKq
 9Am+t3ArVhfcsiALD1cCtHLzyUC8tEYCYgg2JTslftbU01Sz/+48FGsBNSWqAIlMTzNJ
 PKD2gldzqvVBsLclgqfcKic+gv5YzSxa3UGpavGEMqvB1wFXMu7cSO2q68wyxSr9c1zj
 tJuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ObIR3nLiJlPgRTCYJ0Sc+NJNUApc5Hs8jEreL243GynEAlCYV7fiBBguRiLYN2QdjdKtWNsuNSojJ@nongnu.org
X-Gm-Message-State: AOJu0Yy4oi9OyG65wprHfkUpq4cltj8aSupwhN7If0T2JI40+oM+D4VZ
 VPKTQ/5yJ5PccMNKFIEjMTkFAsKrbA+7w7l0LwpD/gPjiHeUSWHJvz01LPQlsmR5Twy0v0dJUel
 yoSb2Ya0p0bZ9UIlxbjcYWcK3waifYFAaRDkG5LMQYg==
X-Gm-Gg: AeBDievIpe03+n5MdLO78U42l+JJGRyn3YG1aIgNHOt5R2zNVGQihLSQzEd/x0NLXCf
 Z2DG3vpq1l/PgPCCkkm1Nbdo0QdY+duU0RY72sQ5iXLEzUoCIJswYN0frub39/Ri5MXzSXK1AR4
 o6G9T9KAB+ByOqT7XxBR76U/MMv4khjEogUqc2KzR0fDWBQgScWLjxJxwTPwWJWNenG0T4OibDq
 0+itrk3yqV9klrUeLUKfSCNsdHScxbPhk1XNhaGlLAftzVKtnYv82F9N95GUZMCAoT0FNULi0Vq
 ITyyaKADQBMDhF5nqzxei6skFf0yM0ijJ7Ay5C/DXHE4O3VFxRFiMiuIgwPm4CvWkxUjG+kVgAh
 4ig==
X-Received: by 2002:a05:690e:4011:b0:652:e4d7:248a with SMTP id
 956f58d0204a3-65c3d974010mr13245379d50.7.1777969110486; Tue, 05 May 2026
 01:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260428163702.3224323-1-thuth@redhat.com>
 <64e966e3-8450-40ff-98fd-479eee458b38@redhat.com>
In-Reply-To: <64e966e3-8450-40ff-98fd-479eee458b38@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 09:18:18 +0100
X-Gm-Features: AVHnY4LSVjlAJniKh1AmKHkUxMDgBbitlvx7573C-CFsyHsZ5FjbaFQbRIkZO-M
Message-ID: <CAFEAcA9HGWgJYvU_GVZCsxM7-WaR5QuwLES8aetPqD9jaLKr_A@mail.gmail.com>
Subject: Re: [PATCH] hw/vfio: Drop superfluous inclusion of hw-error.h
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex@shazbot.org>, Tomita Moeko <tomitamoeko@gmail.com>,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 4 May 2026 at 16:04, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> On 4/28/26 18:37, Thomas Huth wrote:
> Applied to
>
>      https://github.com/legoater/qemu vfio-next
>
> Please base future contributions on this branch.

In general I think it's better if we don't have odd subsystem
specific requirements like this. The general assumption for
QEMU patches should be that they are based on the current
head-of-git. I don't want to have to remember that vfio
is weird if I'm doing a patch that touches more than one
part of the codebase. If you're accumulating so much
stuff in vfio-next that it's problematic to have new
patches based on head-of-git, then my feeling is that
you're not sending pullreqs regularly enough.

thanks
-- PMM

