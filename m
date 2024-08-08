Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1551C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4j3-0001Aj-SB; Thu, 08 Aug 2024 11:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc4im-0008SY-7H
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:06:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc4ii-0002pt-6G
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:06:31 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1722577a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723129585; x=1723734385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKbSP4Qie7SKDPVYTOOt5vthjkc2KCL/iSENWLQZl8E=;
 b=Z/hwHHcsGJ9JVSxOnS5M1I6vJqiwtjLWypZPkWKL7GywmxQtffE3y2nCm4aMuPUU2L
 04eoXIaiwUINvN4I+QJQGYHIKyAzgOmBMPdBkKLJQu4CLklp27HwedJrbArwFBbxkmr7
 taCF0+WzezsIm6yYTxs1G0RiNYkuvSaePsV3jEPOa5SaVtoywMxp0Gl62tjcLDW0z+EQ
 LvlpCYA7HMxv0N3jAyKBPl8kDiY0Rrn+LOdvl7zEGUyCYEH76kkGCngZSzFHPeJcyD+K
 Fd78g+DMgujnx7Nl8LXsNVZdh8o4UitzVcml0EXfXeYDacevFKgj/OCTZuAmVbKiJZaf
 BpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723129585; x=1723734385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKbSP4Qie7SKDPVYTOOt5vthjkc2KCL/iSENWLQZl8E=;
 b=nHjNjvJwqz0cYfhx0OLhkQV5st+Rda4Mfx/vScMYBe+53lmwMChfTREZZiXrfGMbyC
 IisdXegQXHXRh8/qJ4ZgCPRfKVem0XmK6E2Tv7XKmQNsN5pk/R7TTnWaZJWbSoSAE06i
 cx15FsAARXObwDQYggWhvlstK8CWOJH4ZzcJZNCS9ntFF74AWts+20xCT8dF0T1UD7FK
 Or9ZOyj2/NyGQgJKP7FLCipAot3YlPjJHCBeHb744gJUlUMHsyDXbz9L/YuPavF8irX5
 E3ecs9v0Qk0znKuRcMkKiyZJIXXv/bnZM2i7v5xV5HYqU4g97h7RcMCuXPAWjVM/Fn/w
 1pog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtcG+3mGTdDL5vL6jQ7HG5szT56/VXtxQEKxjBZZzPES3f7MVyF3enlwaGRbNDgHkFsBrQfPXp0GeDQX4zsZSf6/xVHyI=
X-Gm-Message-State: AOJu0Yxkqj26oif5bnW1DpyAgbQp2rqN4f3KOlxRxk6QYRK8ifJiUpbX
 y4k8p80BmkF9tFaZ4K6jxiub9JfK2K96O6hMgyDHU49ULAyGENOLreXG4dsa4dz9QtKftp09Ta7
 7O1FtLHqcMWrclZAjaWb8kb6K0SlHhavhildOkQ==
X-Google-Smtp-Source: AGHT+IECqhL5hgVrl5UOv/+6bK956t0MbhDdaGErP8irkdvb2BSyCrQwfpP3X9HZVQUjLgxnDK1WLKf6ZdzSu1YQbQQ=
X-Received: by 2002:a05:6402:1d54:b0:58c:b2b8:31b2 with SMTP id
 4fb4d7f45d1cf-5bbb3d1d1f0mr1760801a12.17.1723129584983; Thu, 08 Aug 2024
 08:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org>
In-Reply-To: <ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 16:06:13 +0100
Message-ID: <CAFEAcA-rvu-X49cw8SHpqnmuLO_yqcaLHnF=9v0Oqz4WVQom-Q@mail.gmail.com>
Subject: Re: [PATCH] arm/virt: place power button pin number on a define
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, 
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 8 Aug 2024 at 13:55, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Having magic numbers inside the code is not a good idea, as it
> is error-prone. So, instead, create a macro with the number
> definition.
>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA-PYnZ-32MRX+PgvzhnoAV80zBKMYg61j2f=oHaGfwSsg@mail.gmail.com/
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

