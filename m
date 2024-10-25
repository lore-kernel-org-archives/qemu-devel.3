Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE050D1039A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mdo-0005dk-9U; Fri, 25 Oct 2024 11:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1t4Mdm-0005cy-5c; Fri, 25 Oct 2024 11:54:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1t4Mdk-0003hA-QN; Fri, 25 Oct 2024 11:54:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so21206385ad.0; 
 Fri, 25 Oct 2024 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729871654; x=1730476454; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDI54KTdFRpNej9YaQfxoWTqRblPMpcIvzw4SOwLtec=;
 b=YfjgAAzK2mR07UcrY88FOML0Af3SMtV6JtJ8VR9W+3oJflX+mhZRljsjfryLOEzT+n
 SMoncOnSv9dkuXK2K8BNa9Zbv+Kp4cHUSzuGNTzpU1rEp29i47W/lNW5+I761IZ12Ags
 6hmaNOykdCNFfdjzAv67547r++8PwafggzTuquJj9lVVRu2XNj/h+Cn/3JtFvEnpAkkV
 8nEGWKqKTLEReKJKPUGTgcUpIye7esNlaD7Yu/uSEUl7KB8NtVi5zoyiUDlYfTGY16BY
 8aGU07WxKYjNz8yQkTkhomMzy+H4ocQXi3NHkX+yHvLBliKN0DhQHBjUmnwtYh0d2oTM
 tC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729871654; x=1730476454;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDI54KTdFRpNej9YaQfxoWTqRblPMpcIvzw4SOwLtec=;
 b=whEPjKYq1uhhRwEwOa9FnkI845iaDthX9G/X2DQ+A1xCX6QwcSnE+IzUojBilwrLPI
 JGzQ2wp1zUDAiFZbumko8cI250DEc9kMMdHb0m81uYvVQ5XfRIGaX2N0WwpfaI3WWur1
 BqJUzZo22ykUnXYctUrNmybgLCujBa8Sc1UPSHfpIn6oOZQ4V51DB8clWEaDPgYUsCb5
 19/9Xmt7AedEi6FkHiQjOFS8gC2yVzs678e9Dd6vi+9IsCOconDDpH8xXDhLjyUlixmi
 3hkFdksYMfjkuJq3DZ1tN/DPEP1Uq149RT/6XUx/pYl70MV/shDF851FeHB9MQubMZos
 Ui/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUexwm9KLlph23Yql/IWlovr64Yrul53ByKvEC37D4uxiDz3N1Xvnd+GcIqLqH9o2kQgdyfPyo9SWTP@nongnu.org,
 AJvYcCUm4bfKjvX1eVbHEMiUkA67EUSbL5iN7SIdXtb826ViElLL+M4CJqd50f3uIKVxTiD5UYhZin6uIQqMkQ==@nongnu.org,
 AJvYcCXAthWKchL1LrFbC4YGpNITrpv/VjPOv1Zcmv3GOd0yogFBt3B6gp9jtjvX14EGSdKqO0iMu9w3/A4=@nongnu.org
X-Gm-Message-State: AOJu0Yxr4vuzJYswnMY88fX0/kkHULQeMnNRFCh2OvrSdMyFz0OcF8os
 zKdrNZzp/RDfVxv1coqWad7ruQ+loRamTwdp2xZrrb5Fet5v6fCmes3B1Wq9yxuPk60aqVQFG45
 Scf3ZXPOBo0Z5HKcXCqj5qplCSh8=
X-Google-Smtp-Source: AGHT+IF64cda8/CX7HuY9GCD6+i5F9X3dCRHi9cKjZBXlUdfcsjk4LFg04CSvxxK4GilcKFWrW34xOFk3lYcPoihi1M=
X-Received: by 2002:a17:902:ceca:b0:20c:528d:7063 with SMTP id
 d9443c01a7336-20fa9e0aa82mr139767605ad.19.1729871653972; Fri, 25 Oct 2024
 08:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-14-peter.maydell@linaro.org>
In-Reply-To: <20241025141254.2141506-14-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 25 Oct 2024 08:54:03 -0700
Message-ID: <CAMo8BfJvoCri2+Xh-2e8E0UKVTJW00nJHzTskzdk6OZhXcd90Q@mail.gmail.com>
Subject: Re: [PATCH 13/21] target/xtensa: Factor out calls to
 set_use_first_nan()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.866,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Oct 25, 2024 at 7:13=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> In xtensa we currently call set_use_first_nan() in a lot of
> places where we want to switch the NaN-propagation handling.
> We're about to change the softfloat API we use to do that,
> so start by factoring all the calls out into a single
> xtensa_use_first_nan() function.
>
> The bulk of this change was done with
>  sed -i -e 's/set_use_first_nan(\([^,]*\),[^)]*)/xtensa_use_first_nan(env=
, \1)/'  target/xtensa/fpu_helper.c
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/xtensa/cpu.h        |  6 ++++++
>  target/xtensa/cpu.c        |  2 +-
>  target/xtensa/fpu_helper.c | 33 +++++++++++++++++++--------------
>  3 files changed, 26 insertions(+), 15 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

