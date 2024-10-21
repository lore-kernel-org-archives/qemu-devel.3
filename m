Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA05ED15D89
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2s2N-0000bI-HV; Mon, 21 Oct 2024 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2s2D-0000Wk-Ce
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:01:27 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2s2B-0005eD-Bw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:01:21 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb51f39394so45121711fa.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729515675; x=1730120475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wPOJFYL2cNmAvoObruyhvf1O5ICgQDYFcRSOkIlnyHU=;
 b=oTTAQnLGIWxjYrdDg1ySge75LM9nLutxm6zcnEVVlOh9gqIMd55gbyhVnP8tNvprXS
 WMKmH1xLRVIRhamyXNJrXez8zbDPtMkVuJG5n4NLf9l8hJbZxUJ9z9DZhS17+ZKSrixD
 ixNZ7bNkl38xDnBbgLuQbmrcfniO5sgVwg4n0APCxfkarQgmJA4Q8JEprRPHcVTbJK9o
 3JX1TQRm/ADzBtMZlrgF5KkJxNUK/pzPS0djkzhj1GPiWhHTkei/tfmgaMlZBxKgpqNl
 ew3X1FLlUhkoUEpHndRhZll53GIwL7iJsLJwo0SPVUN2aGKsLoSZupoLwspoQZIv/n+9
 LWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729515675; x=1730120475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wPOJFYL2cNmAvoObruyhvf1O5ICgQDYFcRSOkIlnyHU=;
 b=C8xIU/OkcUwaXg9Ty0U0Sq20qlZlQcEubX0Cz65nJ3ZvMHm0dLvOMg5kx8/ooGW7vM
 qQHg8eCA1iJQUOliS/586xE3V6BvPYmEajpMPtIfuMVEQ/e7XelTcspWT32pLbNoNAv2
 TpiF45zJFvA8WDPOjf+IN32lBB1pkQdeycamsG5c16w9vxKrfmFqMlM1ZSfss2GR0+fc
 gi7r83Hbln4j/fdunpWMRfU+cqkwrnOQ6rdcyzd04JcR58lmFbSgG9osqi7rKKi055l2
 W12KjeA+owzJUTWj97D5Tv4aKRjPzefFu5fcR/f6Ez9lJmQPP/s7Kha9SX1Y/lKcJJmx
 XTCQ==
X-Gm-Message-State: AOJu0YyzlFwlxxL7eLVffYs+buxTTGKVSMT0g6r/eLDdFyijMitHP6tk
 ACpW0L2BTfjKzWtrO7loWJw2dyVlek+7u3BaczKC3wXxJfMh6xMuTA/NA82ccWk6N/8UAFy7Hj+
 wFFdXhS/Ez9oyk6sv3gnW4F+uLUi2gjLNuTeiFw==
X-Google-Smtp-Source: AGHT+IGOe2UCVW/Tyo+xdcjYb6kN+1tFpDv8rKobTA3iGJK45yueZ3sJ9P+Cffmo2ua3G/HULl8CCyqla4D/pvkENO0=
X-Received: by 2002:a05:6512:308b:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53a15445ebfmr6059413e87.41.1729515670599; Mon, 21 Oct 2024
 06:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113500.122500-1-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 14:00:59 +0100
Message-ID: <CAFEAcA9VKkjfYgnv=x5kp+KUZ4rC0y9-KiCWBG+F84MBh7rxPw@mail.gmail.com>
Subject: Re: [PULL 00/21] Test updates (tuxrun tests, new QTest maintainer,
 ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Mon, 21 Oct 2024 at 12:35, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-18 10:42:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-21
>
> for you to fetch changes up to ee772a332af8f23acf604ad0fb5132f886b0eb16:
>
>   tests/functional: Convert the Avocado sh4 tuxrun test (2024-10-21 13:25:12 +0200)
>
> ----------------------------------------------------------------
> * Convert the Tuxrun Avocado tests to the new functional framework
> * Update the OpenBSD CI image to OpenBSD v7.6
> * Bump timeout of the ide-test
> * New maintainer for the QTests
> * Disable the pci-bridge on s390x by default
>
> ----------------------------------------------------------------

Couple of failures on the functional-tests:

https://gitlab.com/qemu-project/qemu/-/jobs/8140716604

7/28 qemu:func-thorough+func-aarch64-thorough+thorough /
func-aarch64-aarch64_tuxrun TIMEOUT 120.06s killed by signal 15
SIGTERM

https://gitlab.com/qemu-project/qemu/-/jobs/8140716520

14/17 qemu:func-thorough+func-loongarch64-thorough+thorough /
func-loongarch64-loongarch64_virt TIMEOUT 60.09s killed by signal 15
SIGTERM

I'm retrying to see if these are intermittent, but they
suggest that we should bump the timeout for these.

thanks
-- PMM

