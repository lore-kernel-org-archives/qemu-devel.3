Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EA9CEACCE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdoi-0006mt-9o; Tue, 01 Oct 2024 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svdnp-0006FX-7v
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:24:38 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svdnm-00068Q-NQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:24:36 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fad6de2590so22072541fa.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727792670; x=1728397470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FLJSkJjinENX7RpB5/Edwqkj4/i5cta4HH4Q++ARRE8=;
 b=UjvI8d+IwPc5CPOw7lcqMpWzPWGwpHGynrdWUMeYeIBKm9VWUMWLWZzYUk/9FhNjzq
 bCJvk5IYf1INymaPJp1LOg72m6gzBtG5DGT9XufxqglYUxTa+E1fcJVwhVLWuWdc9DIi
 uy5V3/4LZKyn5St8GvY9Gq7g/N7t0qCCpXsvqsl+y9yGeHzWeZtt6950j9JOdMXCVXej
 WVlSAJ5bID7iSzekGuVd9vhZTlH1YYFGx4V/bHNTDt8pkdNx37iFQwDUwxhcnwHDtGY3
 gxgsaEkxWs656TacPz6WE9rduBWM49x+EhW6B2wVZx4DTMTjF9f6ooEMwcZi7PVMsv5d
 v3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727792670; x=1728397470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FLJSkJjinENX7RpB5/Edwqkj4/i5cta4HH4Q++ARRE8=;
 b=NvllFtGTpsQ8J3dhPZA7Wq8T9NCL6Omyl4cd7Jgxq1IbLJULnWHKEVEcUk9EiJaxwI
 lCHnM4EuSDJp5ADFQwQLn+5gBq5zGTu6y1iZeQmaGce7aCUzc7qUi4/v0hEUp/PmBWf1
 8NQV1B0AsFLsfKiDxpDDwp/B+YFWVrTIOo606vMHi+wbf4RfCKiaso+4ZdneekDUAeeU
 dfiA4odH2Djafj5B5N1fOhAeDDACYPlAI1AlMb0OuM5fCb5mm3zOhTaPEyW/F33KyWJc
 /TT13w+1L2y1kq8liUDJn2jikhEXAgBWrY5Pob27J7KP0EUmZOiewZqAP1YUoWFFciJP
 YMbw==
X-Gm-Message-State: AOJu0YyhzK25dkdXtCGX12DTv/LJdASDcC2GU0W5GtCTbSgC2KeejW5R
 d19fEcxTJwO/0IGabqjSLHh/Gl3S8rGQE5wbbCjSWghpWSAHfdFakWDiAQxRBRTgnzTIoW36tYZ
 U+/75Ta6+Innr6h6gE/wolU2EDt967hLX/eVk0IJHB5Qjvphz
X-Google-Smtp-Source: AGHT+IECrUjIPW4qMCzTEOeDF7GnhNfH3HKuiabce7cCNaaWsgJFfvBIqNF2H3VTsGZG0J/wV8IRNODPdusf0rQgdWo=
X-Received: by 2002:a05:6402:35c4:b0:5c8:9f44:a0b2 with SMTP id
 4fb4d7f45d1cf-5c89f44a0e9mr5850306a12.5.1727778646108; Tue, 01 Oct 2024
 03:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240930084325.187606-1-vsementsov@yandex-team.ru>
In-Reply-To: <20240930084325.187606-1-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2024 11:30:34 +0100
Message-ID: <CAFEAcA_3BQwRTv7QSDqnU_yqSu9fxhknGCV0GPqJKC-m2fBvcA@mail.gmail.com>
Subject: Re: [PULL 0/5] Block-jobs 2024-09-30
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUBJ_LACKS_WORDS=1.955 autolearn=no autolearn_force=no
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

On Mon, 30 Sept 2024 at 09:43, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> The following changes since commit 3b14a767eaca3df5534a162851f04787b363670e:
>
>   Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu into staging (2024-09-28 12:34:44 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2024-09-30
>
> for you to fetch changes up to b74987cd3bf9bd4bf452ed371d864cbd1dccb08e:
>
>   util/co-shared-resource: Remove unused co_try_get_from_shres (2024-09-30 10:53:18 +0300)
>
> ----------------------------------------------------------------
> Block-jobs: improve backup fleecing
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

