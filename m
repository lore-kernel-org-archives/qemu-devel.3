Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7B9D15D98
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2swW-0003Wy-0t; Mon, 21 Oct 2024 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2swU-0003Wk-Ls
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:59:30 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2swS-0004d7-P4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:59:30 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso289593566b.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729519167; x=1730123967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dWtPQmw5WBzZS/2Bf0jAY3n/IYsBr3y+IVku3BybJR0=;
 b=a33cQZXffAGQZ2lvS7AdVfNxwXGCLOGc/KSKHnopyR7GDo5UlOMvRRJfTTLVQJ5cQ5
 jxI1QBqkG4au4WODfp90tD27Nu2J4f6WyjvGl4vkEK9VSI60V81jgDSaG4znsOtBaVKk
 fEq+E6r2ZIiPTOq/omBIqdsZ5CeuXGehpN8VqPKxONBsqm0rmCxYdVkuiYMx1cc2NCvK
 2mLtL7WHSGg6YPIZ0BzgTgNDJcy0Ats7/4c7YoqDLp/WhdKSsYroZ04/0E+SwPT/c2sf
 zl+RbL6pNLeGwASJNANpCJkMcV42wQ9d303c+9ZZwWw8V2JD+gOXUiHLwvzzSghgOtes
 3vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729519167; x=1730123967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dWtPQmw5WBzZS/2Bf0jAY3n/IYsBr3y+IVku3BybJR0=;
 b=FxgvSSE4BNtlrV6S9gnY677oKsiyrHTX6XfIHPLSN9UEIakjjmnFTcc+0HqgUjQIqw
 3ktT6+a3NEn9uYTHlbEXWn746LiHCpRCTDAWZyJzWkoNYELey6VmyH2S0kA/iJEgeAsD
 CvBtm/fHtkX15DkN/ONAp1Euj7nk8g19qdyeuesPHfVc69PamHwoKany6BGBWjGwCIpl
 VCHBHkOxBOeU3LF51t1TFBi8XY8SHYIu6BdWQ1h3jOBgjWLDYgVHKV0qJ1Vf0r1swWyl
 Dd8m4d0b1Bz+mkJysZyfm78ajjDbbimtHE/j/tGw+LO8eO+Y+ETRvldBYWN/cdWpA+zM
 Sb7g==
X-Gm-Message-State: AOJu0YwFU4UYmEgP1hoBK8Q33fGwltFrLg5OpFPEIg5oZVBIaXH/QbP7
 ESqepB3lMZsoTx3XCqTgM3MJV3/7t+V4Fs0nbJjtnay68YlTcUHG/8qk8/VR9CqabZueILorURz
 GAq6tKySkOoIK5XTRuw1OnXC6ws/akgArmpkCxw==
X-Google-Smtp-Source: AGHT+IGp1fjPzPlWyQKIJZL2NWjZkcAcgqDqnAXNcEDCTtTWCL9GEWaZeXU2S8YDaAaYNSSGbUM47xOkm04t9XQJTI0=
X-Received: by 2002:a05:6402:4301:b0:5c9:1beb:b971 with SMTP id
 4fb4d7f45d1cf-5ca0ae810e4mr11211391a12.24.1729519166627; Mon, 21 Oct 2024
 06:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113500.122500-1-thuth@redhat.com>
 <CAFEAcA9VKkjfYgnv=x5kp+KUZ4rC0y9-KiCWBG+F84MBh7rxPw@mail.gmail.com>
 <a8bbb335-55f4-4c34-b56f-76482391c80e@redhat.com>
 <d5db0cb8-0ec3-4f41-a14c-7d07cbe6f4ec@redhat.com>
In-Reply-To: <d5db0cb8-0ec3-4f41-a14c-7d07cbe6f4ec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 14:59:15 +0100
Message-ID: <CAFEAcA8xdxdzXeX7YfZgz45sRqzEsDSWxrhkz11VOSWfVhQ3Dg@mail.gmail.com>
Subject: Re: [PULL 00/21] Test updates (tuxrun tests, new QTest maintainer,
 ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Mon, 21 Oct 2024 at 14:55, Thomas Huth <thuth@redhat.com> wrote:
>
> On 21/10/2024 15.18, Thomas Huth wrote:
> > On 21/10/2024 15.00, Peter Maydell wrote:
> >> On Mon, 21 Oct 2024 at 12:35, Thomas Huth <thuth@redhat.com> wrote:
> >>>
> >>> The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:
> >>>
> >>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into
> >>> staging (2024-10-18 10:42:56 +0100)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-21
> >>>
> >>> for you to fetch changes up to ee772a332af8f23acf604ad0fb5132f886b0eb16:
> >>>
> >>>    tests/functional: Convert the Avocado sh4 tuxrun test (2024-10-21
> >>> 13:25:12 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> * Convert the Tuxrun Avocado tests to the new functional framework
> >>> * Update the OpenBSD CI image to OpenBSD v7.6
> >>> * Bump timeout of the ide-test
> >>> * New maintainer for the QTests
> >>> * Disable the pci-bridge on s390x by default
> >>>
> >>> ----------------------------------------------------------------
> >>
> >> Couple of failures on the functional-tests:
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/8140716604
> >>
> >> 7/28 qemu:func-thorough+func-aarch64-thorough+thorough /
> >> func-aarch64-aarch64_tuxrun TIMEOUT 120.06s killed by signal 15
> >> SIGTERM
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/8140716520
> >>
> >> 14/17 qemu:func-thorough+func-loongarch64-thorough+thorough /
> >> func-loongarch64-loongarch64_virt TIMEOUT 60.09s killed by signal 15
> >> SIGTERM
> >>
> >> I'm retrying to see if these are intermittent, but they
> >> suggest that we should bump the timeout for these.
> >
> > Everything was fine with the gitlab shared runners (https://gitlab.com/
> > thuth/qemu/-/pipelines/1504882880), but yes, it's likely the private runners
> > being slow again...
> >
> > So please don't merge it yet, I'll go through the jobs of the private
> > runners and update the timeouts of the failed jobs and the ones where it is
> > getting close to the limit.
>
> Actually, looking at it again, the func-loongarch64-loongarch64_virt test is
> not a new one, this has been merged quite a while ago already. And in
> previous runs, it only took 6 - 10 seconds:
>
>   https://gitlab.com/qemu-project/qemu/-/jobs/8125336852#L810
>   https://gitlab.com/qemu-project/qemu/-/jobs/8111434905#L740
>
> So maybe this was just a temporary blip in the test runners indeed? Could
> you please try to rerun the jobs to see how long they take then?

The alpine job passed on the retry:
https://gitlab.com/qemu-project/qemu/-/jobs/8141648479
and the func-loongarch64-loongarch64_virt test took 5.08s.

The opensuse job failed again:
https://gitlab.com/qemu-project/qemu/-/jobs/8141649069
7/28 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_tuxrun TIMEOUT 120.04s killed by signal 15
SIGTERM

-- PMM

