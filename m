Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E612CDD54D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 17:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqys9-0006T2-1R; Wed, 18 Sep 2024 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqys6-0006Ra-UT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:53:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqys5-00063x-1U
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 13:53:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so3484a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726682023; x=1727286823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QCT5Ncw0JAkP3JDT5lUd0SIEm7Hpho3lH6DrSESBd00=;
 b=QLIz9W5iAnpF4/95ilKn1511vh3qnwls07yeuAEtK/YdYYwygT6epGxU+nAMRDLmxn
 5bjJ0r6o+jes7eRzyKF1L4BfmSECb0HYf/busVAmHHqkiRRb6KPwnA7fZCeBlncU5khD
 omiUq4I2beg0tSjbTr1rtUGvg3A4768nvSZtIYLTcvYPmIq3ufFHKE5VOAuKanSZyZ/n
 YhD0dVLpF+ALkSodcytpaGHHP4ArgpIOLkkVGLu9iHUCUmowp3Lwl9mTTh+dZ9gJxYt6
 flf2OzeCEBZOymSwNyeBKqCjmrxkfSx9EL4BHCwHfALBxc1nxKaTDjRNGyw6rZ0st3i1
 y5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726682023; x=1727286823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QCT5Ncw0JAkP3JDT5lUd0SIEm7Hpho3lH6DrSESBd00=;
 b=ZR2BXmKaxiVlI/KxkQY44EFr7j7T3w2Kj3AhrJq78+MOAqzQ8tAwGvG5/71BGO0sL4
 x/H5r1PCqiz/T+cfcNWZADQnN/PgyR65uM0L/RRHlOFyB0028qMly+YdihAGoSJdNyQv
 D5YQQEEwbAnz2eb/UAfOKMIkj7D2Zdb1HgI+ZCM9/yLOI2S/1wOJ80e6FMg2J5mLzLE2
 lPIOLDGJv2y5pXsVDUAJrOZPWxofz5DwFbJLexZ2ga25pFo8adLpZRF/NjEwMo68RzYM
 zYsWATPM6Toc0oaMz25DCT3BF3BBS8wQWAecaB32aAOxs3yYolYy/s0yiPOXWH1wdTgh
 x9/w==
X-Gm-Message-State: AOJu0YxdT9jkF3tot/QXs/Pvs5PvTWkBTvHes4W4ZETKWqmeMcidss6n
 40Q78JkZj9OolJdA/d0/RIQ1YXV6jLui5Ck5X0PNEkTrbuur2EQLwVUuoypS6ctD9j+Xw9QUfv9
 PUJWnGvSuCTg4k+92yHLpTo0WbuIiR6v/6G7MRhmI/RipjOUgxho=
X-Google-Smtp-Source: AGHT+IGrBjRqFAzD3G9wcEW748dyYg5U4/JXY6tG22ZciI8Grl2Pw/3DyygGEWGBSmR2Q2zK+WWThHgdI3wXwnXTVNE=
X-Received: by 2002:a05:6402:2b8f:b0:5c2:5c7f:60cb with SMTP id
 4fb4d7f45d1cf-5c41e1b5883mr17316914a12.34.1726682022424; Wed, 18 Sep 2024
 10:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240917215506.472181-1-peterx@redhat.com>
In-Reply-To: <20240917215506.472181-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Sep 2024 18:53:31 +0100
Message-ID: <CAFEAcA-vBV0DieO=-bwdV46T08A6pR0EnRUNNrE_Q++SAC0Uxg@mail.gmail.com>
Subject: Re: [PULL 0/6] Migration 20240917 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 17 Sept 2024 at 22:56, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit 2b81c046252fbfb375ad30632362fc16e6e22bd5:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-09-17 14:02:18 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240917-pull-request
>
> for you to fetch changes up to 7b8b4c0e59d2b7928836072536a5528820d8a041:
>
>   migration/multifd: Fix rb->receivedmap cleanup race (2024-09-17 17:50:45 -0400)
>
> ----------------------------------------------------------------
> Migration pull for 9.2
>
> - Fabiano's patch to move two tests to slow tests.
> - Peter's patch to fix qatzip builds
> - Stefan's multifd-zstd fix on unsigned diff comparisons
> - Fea's bug fix to consistently use memattrs when map() address space
> - Fabiano's bug fix on multifd race condition against receivedmap
>
> ----------------------------------------------------------------
>
> Fabiano Rosas (3):
>   tests/qtest/migration: Move a couple of slow tests under g_test_slow
>   migration/savevm: Remove extra load cleanup calls
>   migration/multifd: Fix rb->receivedmap cleanup race
>
> Fea.Wang (1):
>   softmmu/physmem.c: Keep transaction attribute in address_space_map()
>
> Peter Xu (1):
>   migration/multifd: Fix build for qatzip
>
> Stefan Weil (1):
>   migration/multifd: Fix loop conditions in multifd_zstd_send_prepare
>     and multifd_zstd_recv

ERROR: pull request includes commits attributed to list

specifically:
commit ebb47ddce00a1d681124f2e248022a0a5310daa8
Author: Stefan Weil via <qemu-devel@nongnu.org>
migration/multifd: Fix loop conditions in multifd_zstd_send_prepare
and multifd_zstd_recv

(git log --no-mailmap will show you this. The check in my scripting
that catches it is:
if git shortlog --author='qemu-.*@nongnu\.org' master..staging | grep .; then
    echo "ERROR: pull request includes commits attributed to list"
    exit 1
fi

if you want to automate finding it.)

Can you fix this and resend, please?

thanks
-- PMM

