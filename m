Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AF9C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 12:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSyud-0005z7-Sq; Thu, 25 Jan 2024 07:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSyub-0005p8-T7
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:32:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSyuZ-0004LC-B2
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 07:32:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40ec6a002a7so19618855e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 04:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706185969; x=1706790769; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4hkJswXreC+jSYrjgI8dedn9By3CLWmPVCT4M6zB3Dg=;
 b=eFJP8XuG6XlN+Vnu+RgJs5T9txyW0uastuO/lKLFwLT+vNByA46zNVVPC8oXFTHf/Z
 r0YMQXyIgYrCWD2UU5/J0QHkgk8R/RZGHA51Zxl0xj4jdouIywnzGIOxcEgvCC8s3s70
 rj30qIsR0lheS7JxwegXrVfy35ysqzoZUK1/t/QLubEfOIvS5oOpQTkvJcWngdT8nLA0
 DgwRRGPMKcKryiVTVKOG7YLt7nVQcnA5ns2oLLJjyKm43wxTaVnLtm5AJnK8NurMUZCK
 veQSHASvh09alHXn1oVgzI88Sgm1j9y5+NWhCDtpTE9CZnrRXz31xci/mPFLA8pQ7mDq
 ywOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706185969; x=1706790769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hkJswXreC+jSYrjgI8dedn9By3CLWmPVCT4M6zB3Dg=;
 b=LdPrqOWIjDoY8G79V11NEnFvUifXsonFDiqSqEk9wKDuDVIOP3jhrsWZmzw5+IHPek
 6lgoAqJdEnVjMNb2nJfCZB7XRgje+GDoQnjsVfwvc1vQDUYLm8uFSCD6Osm9cyIkLs/j
 1Ot32mgxlQUsg3+egplOWLtv3SUIz2wQnBUFm3Hk/I3EMWdCYvkxsKpzjH4hFLBHerG5
 nlzI+8bYxMZD2L9VTQtjcHIx1W5mEosb5PyXjLIAe/1H0BCwqrpGuL/igcI3xFZgL6GC
 UG17tjkTEbbeqZjKEX4RYjpzXy67+cBdCldIVnZTDW1AD/tYBTCRNALwwatI7+Mrcini
 SrZw==
X-Gm-Message-State: AOJu0Yw84fSMoM/RDZrsl18aMDY5FE8y+DGhfwxazb90F1FyIj2edZMd
 Y/Vwd0UaiVC5n9CP6j2/UTDU9KFYSOljKaVqecUPGD4XoBNsMflH9TGX1twHWy2EVC2Zu2mnM2X
 pbVMxe26lSb7zFKBHRfaaqdcMWh1GNmzLToFS6bjxXLfaiB98
X-Google-Smtp-Source: AGHT+IFGDkZePA6GiZUpi7E3FeRBT3qrOxtmaaNhi2HRt/3vn8oDIDKv0WvB3IzQgtlTG4r2e8oAUBKolZu9BD0peWg=
X-Received: by 2002:a1c:740d:0:b0:40d:5a9f:5281 with SMTP id
 p13-20020a1c740d000000b0040d5a9f5281mr349739wmc.200.1706185969413; Thu, 25
 Jan 2024 04:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20240122111812.45918-1-kwolf@redhat.com>
In-Reply-To: <20240122111812.45918-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 12:32:38 +0000
Message-ID: <CAFEAcA9H6rnsAy0JhXgD7ghJ=8tX=TWrtcPxCJcPied7qO4XgQ@mail.gmail.com>
Subject: Re: [PULL v2 00/14] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 22 Jan 2024 at 11:22, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:
>
>   Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to c14962c3ea6f0998d028142ed14affcb9dfccf28:
>
>   block/blklogwrites: Protect mutable driver state with a mutex. (2024-01-22 12:16:26 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - virtio-blk: Multiqueue fixes and cleanups
> - blklogwrites: Fixes for write_zeroes and superblock update races
> - commit/stream: Allow users to request only format driver names in
>   backing file format
> - monitor: only run coroutine commands in qemu_aio_context
>

This seems to be consistently failing on the
ubuntu-20.04-s390x-all job, though not always for the
same exact test failure:

https://gitlab.com/qemu-project/qemu/-/jobs/6009661151
   -- timeouts in various tests and iotests
https://gitlab.com/qemu-project/qemu/-/jobs/6003367403
   -- test run hit the 75m job timeout
https://gitlab.com/qemu-project/qemu/-/jobs/5999451175
   -- timeout on test-replication and an error in an iotest
https://gitlab.com/qemu-project/qemu/-/jobs/5993334498
   -- timeout on test-replication and in an iotest

Similarly from an earlier attempt at merge when I was testing
this pullreq together with a different one:
https://gitlab.com/qemu-project/qemu/-/jobs/5984802405
https://gitlab.com/qemu-project/qemu/-/jobs/5983419166
https://gitlab.com/qemu-project/qemu/-/jobs/5982308583

The job passed OK on the merge that became current head-of-git:
https://gitlab.com/qemu-project/qemu/-/jobs/5990993136

thanks
-- PMM

