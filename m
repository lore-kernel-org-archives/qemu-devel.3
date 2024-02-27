Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F5BC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Cy-0000oP-CR; Tue, 27 Feb 2024 12:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rf1Cp-0000kI-Dj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:25:28 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rf1Cf-0001s8-Q6
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:25:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso6122321a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 09:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709054716; x=1709659516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kcxG98UeYhB/BNiA6TOJimNtm6g2wl9X2q8dfRlYshQ=;
 b=Rt9caXYX7DmPzfQ688UXA5YBAH/b2ij+dPCt2D+phFkaQLp83Ocym5GyPq/WyNdYHE
 tUoFzLxi6b+c4UgNLyMo0kWRi6I6zAZdkT2/oUEq1F7QuN8WLpoVodaG4Uy1df1KvXXG
 MFTh1WZcnhUPoGwOZHfcYQm3E722FfMk4HIy2HVO+UZpRR2vCRgGXkrUVmUJBs3Axj7l
 Tpfx9a9mEJ5vU/n4YxNZS88MMquRu6ysD00/ijXH3h8UgtY7IvoGVpqODUXupU9Tck2G
 obW7OEsD1NvPGJZelKY4onNONB/2KodCumg4mPtQAXCCMkazJ8Bb89MCIhhh0W813kSL
 LZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709054716; x=1709659516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kcxG98UeYhB/BNiA6TOJimNtm6g2wl9X2q8dfRlYshQ=;
 b=vyZSBSNbbvslQkAANHDsNw8xguh715UFMSB6a0CJGCOWMlUqmlPqHtUZMaSp+ClPZj
 Bj6W2V1ilbOsvTnbzCz53uxKdcx6pOOihtYvMhnEjwVtkwxloW/5QHpQiO0WsQkQEbIp
 mEGf4eivefSS3Uo3/Tj8p/WPeAocx8D9tRq7vZMQSVXJFGj5S4OHB/YMi6SgVkOu3jMM
 UK/gzYEeZZ0APbi/8oFDJjX1MpERuiamPCg3PN8XhOTsFk2eJzDtCk6/yqcpCZ5Sy1pH
 oJ971ccxXFgOMHA9GdjOpl9mSsouTkU4cYePGC0qeqrtJSiTQdKu/GgDLF4W6neiIvXN
 TwhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5SsScjE9pf8Rv2x2GiY3jZOBIAXswTumhmkbZQJ6PfZQKvM3lkuhXlJflLfezOMv57YXyrQKZZglsJKGQotlWdieLuFU=
X-Gm-Message-State: AOJu0Yyu2LuSZg4GhXmHxDxtL8evkrfB2ylWGBj5/BHj3fU2YdfEvNwX
 1sTGUzwMCQpW8Mw31+x0G++1T4ULbHDbN+OqMkz+VXG4O9LXaKl7Bh+fKrX/uMr6DhN+lc8Dwaq
 Q8dPW+t3ipvYxSdzkH6a09YSoAuc+cobpyzwMFw==
X-Google-Smtp-Source: AGHT+IGnQb7TojBacz0J7c/6ngRDfLoycD7shaR0U50hlZNlgnyICjBoCXLEI7hu91TG/ya6fcPH4tVlSYJNPJTOvyw=
X-Received: by 2002:a05:6402:5188:b0:565:965f:b0f2 with SMTP id
 q8-20020a056402518800b00565965fb0f2mr9283821edd.5.1709054715970; Tue, 27 Feb
 2024 09:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <CAFEAcA_oSeqGAPNpemhbyVkuMYtwbr-TG2QNQ7=DSZv0s0h7XA@mail.gmail.com>
In-Reply-To: <CAFEAcA_oSeqGAPNpemhbyVkuMYtwbr-TG2QNQ7=DSZv0s0h7XA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 17:25:04 +0000
Message-ID: <CAFEAcA8GVZNt_0w=C+jEtp7uGt_h1SLJvZM3iGJAF_+8fDwi_A@mail.gmail.com>
Subject: Re: [PATCH v6 00/41] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 27 Feb 2024 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 26 Feb 2024 at 00:04, Sergey Kambalin <serg.oker@gmail.com> wrote:
> >
> > Introducing Raspberry Pi 4B model.
> > It contains new BCM2838 SoC, PCIE subsystem,
> > RNG200, Thermal sensor and Genet network controller.
> >
> > It can work with recent linux kernels 6.x.x.
> > Two avocado tests was added to check that.
> >
> > Unit tests has been made as read/write operations
> > via mailbox properties.
> >
> > Genet integration test is under development.
> >
> > Every single commit
> > 1) builds without errors
> > 2) passes regression tests
> > 3) passes style check*
> > *the only exception is bcm2838-mbox-property-test.c file
> > containing heavy macros usage which cause a lot of
> > false-positives of checkpatch.pl.
>
> Hi; I had to drop the qtest patches from what I'm going to
> apply upstream, because it turns out that they don't pass
> if the host system is big-endian.

The parts of this series that I was able to take are now
in upstream git, so if you like you can rebase your
series on that.

-- PMM

