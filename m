Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68572EED613
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 15:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solZa-0000ER-8w; Thu, 12 Sep 2024 11:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1solZX-0000D5-0N
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:17:28 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1solZU-0002d3-90
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:17:26 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-536584f6c84so1437116e87.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726154240; x=1726759040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zvie+2UAd9ob9Sk5PvSJXpHOHZPbKSjyi4hbfLZP8cI=;
 b=DjEbgjXlkv6DqMlZ1Df1axM1ZQRZundRqxpww0PWRQFX3dBhgSi7Ylv7F9d7Cf4S/g
 amv0jRIrDF8zcHzy6EkpmeUa/7jii8TYEEtbILP8Z87cWU1RpstqQBBrX+mUIlAWFD+3
 ZxOz2m3ENDbck1AjlnxUSkSpWfBVWII0XlE6azYObcuXisE0oMKX2+0rvFjo0gDxs/hN
 g597djxtfu/6m/9DZ6oCJqa9VB2YJxYdxBYXIwVlIYfuTYahQlvYcEznpA4dL3ZKWxCA
 iPvUNfMb8gSrKrpedg2IONs2juuM4jZ1QY0iPzUz1u1k+mNweqkK5EibNlckqE23AUwj
 7RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726154240; x=1726759040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvie+2UAd9ob9Sk5PvSJXpHOHZPbKSjyi4hbfLZP8cI=;
 b=koH0M3aGBXNT7O9Ewi/LhWnqxfjEaCCLnUFH78cXqA3gc+ePOJGftisgTg16ivU/xc
 auGzykE6bNwe6My6ZiFRqObfY3AB2o9zgI5UgzX7wCDqWH0k+2xLbVzUhCw+JETrUHtc
 VxCP2JdL+cnGXs8y2ANvzWh8MAhVVumZLJdkWwF/5Xj2FRIg01i7C8bJClk9bToZiaVF
 lE7pLaHs921XEiOjHIeevnGd/PmT1zbHd72mG0LHok9wLLi5Abw9Z8BLJga5fGT9OHJ1
 6iZxglHz+vxMsC7ogQDuMJ2fE2I2/aCNNK3zxLTqotef/QVqHLLYR9Ss9cxMq4WSbxst
 9leA==
X-Gm-Message-State: AOJu0YwN/ex+J1v8dSXgMRkG/+OL92C/7Cz6K86GnpJHaYXncPytL0Yz
 uzDGKCu5tuxIK5uxht/b6soa+hI3dlWUIYrQUDen9Via58XRHbOqPHYX4DuVfJf6ZDmWAN9WwPI
 ccTSkrjjf2XCVYWsK4Zpuyc/pqWMEJaOIt7rGcsUALNPIYWsh
X-Google-Smtp-Source: AGHT+IECSDuP4zJf+w2Klo/WSvgjJbYny8P35a0Dcy/fK/TwATXTSome1UHVi7uvjMC94uatUr9Ea9roa8fHl/eoO2k=
X-Received: by 2002:a05:6512:a8a:b0:530:e323:b1ca with SMTP id
 2adb3069b0e04-53678fce6afmr2130128e87.25.1726154239884; Thu, 12 Sep 2024
 08:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240911123342.339482-1-pbonzini@redhat.com>
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 16:17:09 +0100
Message-ID: <CAFEAcA86M9M5U_Vf0+aLp6O71uOaHN7YaZ8uG2kCaM7Mq_ukBQ@mail.gmail.com>
Subject: Re: [PULL 00/17] Misc patches for 2024-09-11
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Wed, 11 Sept 2024 at 13:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 7b87a25f49a301d3377f3e71e0b4a62540c6f6e4:
>
>   Merge tag 'edgar/xen-queue-2024-09-04.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-09-05 13:02:26 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to bcc39835be0c3dfb375172e027cb7b29d08f8abd:
>
>   minikconf: print error entirely on stderr (2024-09-06 10:18:29 +0200)
>
> ----------------------------------------------------------------
> * pc: Add a description for the i8042 property
> * kvm: support for nested FRED
> * tests/unit: fix warning when compiling test-nested-aio-poll with LTO
> * kvm: refactoring of VM creation
> * target/i386: expose IBPB-BRTYPE and SBPB CPUID bits to the guest
> * hw/char: clean up serial
> * remove virtfs-proxy-helper
>
> ----------------------------------------------------------------

This failed tests on a ton of different jobs, most of which are
not the current usual-suspect flaky tests:
https://gitlab.com/qemu-project/qemu/-/pipelines/1450843335/

thanks
-- PMM

