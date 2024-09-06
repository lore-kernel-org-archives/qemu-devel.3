Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D60CE7B03
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYWj-0001lt-TJ; Fri, 06 Sep 2024 08:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smYWi-0001kq-5e
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 08:57:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smYWg-00054G-9j
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 08:57:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374b5f27cf2so1225859f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725627440; x=1726232240; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dr1mYRKilzzw/sd76xNkLIy1xkFKMn1OHBewhCWyrWI=;
 b=EbZti+yLQbZUFnUoyYvpuoQWt7SNkfQfvEv3cv+cLbv5Wr41/0CL1FD1sdHq6XLQl6
 aNu0Zo7EY7qt9BnmbhHE7IIX51JNmsnFSL9oTr7ughL/9dL4hCpWVAk7e3t3KYvHpMTu
 FzONozOc1Sfbh01ouCC+E4t44XY5yyI1U7Qt/80z503nZ19bxtHCD0fzusW7Sd2Hdp1C
 3/9smSC6Jprbvd2e4B7ugaC6YfA+5m2GMK86JDy8fwlHXBvQ3yind9+Ho0AaDQMDH0zo
 JOCh2G8T5pieo1UCJR5xiQE9+UHjfgc6uk3rOXOGHot/gywexsU997V1Ndd1VCAB5yt2
 9/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725627440; x=1726232240;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dr1mYRKilzzw/sd76xNkLIy1xkFKMn1OHBewhCWyrWI=;
 b=lk1gJo/irXqYUwD5hhIaR3f62r0JRxUH2J5irz6dM5XuPS/fmyjFj9OUBcCzZI4D/W
 cPkJIl345h+YYsmLjNt2PDZymG3IcHys4gPgFZlVv0vCAwNLYGljQoaZNrbb1fZl+CT8
 KemXoJCD3E+EvxcOhLiYwVPukTSdH+nQjGNDMHeEcwVc25eDU9N6DydfDe1zUbGBCp7e
 RUB+QcOv9vKSnBysym3j/D/gZh2yZLRKTYcw3Q4f5Wb5oGLqpYTcG7OX1Jf3TU/Wlqjv
 W0O2ZSENAd74oY0FgMEuWhu9THL6w+la9OCrqQkCJptQcHCxAagCMeP4GI6TCt/ESjp8
 mOkw==
X-Gm-Message-State: AOJu0Yzz8jjPWsxU7NHkakzU6moFiY8DK0b4TIBs1GQmAlGuUDSCQNWt
 jvFRS1w/NtsuyYCuSxDvJa/nkNdmTFMQavLSDr4Ga5P1abyL3kVKYJg5VO14tO3Yy9a4/XUvASv
 kPL0acouEJ8RiOPzYqQtzQ5drGJsJL8pod2SfKw==
X-Google-Smtp-Source: AGHT+IHrX6X/RGHO3bk/t0W+Trm4/XBZE2yqrWrz/xTI19RZx7tOdaCCDhL2G48jzNa3e/jM6YDpflZ1pXSuo47ih5Y=
X-Received: by 2002:a05:6000:184b:b0:374:c949:836d with SMTP id
 ffacd0b85a97d-374c949851cmr16159593f8f.37.1725627440370; Fri, 06 Sep 2024
 05:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240904124417.14565-1-farosas@suse.de>
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2024 13:57:09 +0100
Message-ID: <CAFEAcA-DGK9EtGt6-m53HBN93P=dv=-Wbo=hiJSc8kooN-kNyA@mail.gmail.com>
Subject: Re: [PULL 00/34] Migration patches for 2024-09-04
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

On Wed, 4 Sept 2024 at 13:49, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c53:
>
>   Open 9.2 development tree (2024-09-03 09:18:43 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/migration-20240904-pull-request
>
> for you to fetch changes up to d41c9896f49076d1eaaa32214bd2296bd36d866c:
>
>   tests/qtest/migration: Add a check for the availability of the "pc" machine (2024-09-03 16:24:37 -0300)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Steve's cleanup of unused variable
> - Peter Maydell's fixes for several leaks in migration-test
> - Fabiano's flexibilization of multifd data structures for device
>   state migration
> - Arman Nabiev's fix for ppc e500 migration
> - Thomas' fix for migration-test vs. --without-default-devices
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

