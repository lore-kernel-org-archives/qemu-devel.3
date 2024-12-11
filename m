Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FB2E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 18:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLRFN-0003L7-B3; Wed, 11 Dec 2024 13:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLRFK-0003J8-Ch
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 13:15:38 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLRFI-0006f2-RW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 13:15:38 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3c8c572309so1111421276.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 10:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733940936; x=1734545736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vOBzHdzQEMcT/6325YZG7aVBpNdncbLX25LSjSteyU=;
 b=XVSHSzT5iuRb6V9gWgTO37mM17iBsQ9vtKRQveqEYFUcg2pJ+4BKWFZwOJNYwU2MlD
 luOeL2QUP4u6Nw/JcWx0b2m+oIe2OuyHlVLbY3zVb3y2OCEdzvWP+OSSeS1r4ZfNXZa7
 jWBq4eak++jIcj5hHgPbf0zXyCWG4X2yWt/SXJkSuOQrFz78hD51+YZemMJIPHCz6dHF
 1Mf6+Mk74t0NUdr+S8f3P1ilya2z8uf9dgdsEn6H7gddg3w548mOR6Op5ufKtYpyBuON
 vcGSksxNZWfPyjdYTY7uq65SsALdknSG0ZG6gFF6V0a5v6Mrnlo2wpqMY6IxJQE6pmpt
 nQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733940936; x=1734545736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vOBzHdzQEMcT/6325YZG7aVBpNdncbLX25LSjSteyU=;
 b=IFarNtp6UnmLiYta/f2fznLpG67SZsdO5It+ympr0MnRei0R0/uh1foSn3FF06O+qd
 0MmciPAQ7qt8lpT8geR3Gli2GGROlbPcE7wEEDwg6MR3Xqk4+gQC0leoQFoUhZpSQQ2N
 1ayRUcAv7m4MXjfPHwTLbD2Z8cR/3jaOuK5btjomdhqIYg06p7gNOPmn9mRvPC1TTlHP
 83Rw8pP8b3KlkEVZXH85rNTYIwirj03uGlRpC9tA9kPGZ9UgWiw58YQU/ylK8SPxYeWi
 a4vRe4WV5+TNpJlXquUD6VI9jv9XtUBkOv/JYuJkXAS8m06EiJChSmS5xzYYaHPqsgwO
 ah6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu63W/cJt5grX1xdQvUFLwNgEp+LFd/4tumFQC4QbVo9aNfEMHAtvhQ00m/pUGigTkp1NXwApGvEjX@nongnu.org
X-Gm-Message-State: AOJu0Ywgw3PmIDf439B43kBu0veQ4e/+Iec0aJGPJbTf9Oia70pEi2iK
 zS4rWu7n7AnNBXgjraBpedhdVkOwg1fiB51rm3gvghBgd082zCMY7IG+w4ksceBv/bbrZp5pG+8
 igZm4MftD+71SuaMlFfkdw/RSnJM46Y1hF9LrQg==
X-Gm-Gg: ASbGncsvvYv2aZCjem3lhiEqMqQx+0wA4aXSfBub6Mx+r9UBMInqD42dlgrlQDnTWhw
 GL3P8ju6CEE1vXH8K42jYEB0BzkJ8bIFeLcqV
X-Google-Smtp-Source: AGHT+IGbehiBcouJEo0VW0B93IzzHG6smQl4lfHbtwLEdAbegM1tsGuUcEC7C5jA9tGX4+zx0PaOglqEraUHaHa6vpU=
X-Received: by 2002:a05:6902:70f:b0:e38:a031:bbd5 with SMTP id
 3f1490d57ef6-e3da0d555damr316111276.31.1733940935861; Wed, 11 Dec 2024
 10:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20241211063058.1222038-1-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 18:15:23 +0000
Message-ID: <CAFEAcA9U4SbLWjQa5baZb=izbRZcMV0K6+7aJt0Lwp9kgyA5Vw@mail.gmail.com>
Subject: Re: [PULL 00/24] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Wed, 11 Dec 2024 at 06:31, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit ae35f033b874c627d81d51070187fbf55f0bf1=
a7:
>
>   Update version for v9.2.0 release (2024-12-10 16:20:54 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20241211
>
> for you to fetch changes up to 124f4dc0d832c1bf3a4513c05a2b93bac0a5fac0:
>
>   test/qtest/ast2700-smc-test: Support to test AST2700 (2024-12-11 07:25:=
53 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Removed tacoma-bmc machine
> * Added support for SDHCI on AST2700 SoC
> * Improved functional tests
> * Extended SMC qtest to all Aspeed SoCs



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0
for any user-visible changes.

-- PMM

