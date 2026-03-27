Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4E910F2859
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AaT-00067C-0W; Fri, 27 Mar 2026 13:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6AaP-00066u-Ew
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:03:05 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6AaL-0007qz-Rw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:03:04 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64e87a81639so2499365d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774630977; cv=none;
 d=google.com; s=arc-20240605;
 b=Zl1T9xC86b1SYeEVR9VIX/B63Hr/RrE/24+O1lSw9KcTATgrg46Dud+hujCQ5qMri4
 AUjDb48CsW4uqsO/wHZipLfj3SbXx4dXIfQ0pKCAiaWewhVMYD8BowAd/i2pSNeMsHPE
 bi4IP6T0TYxyIQHB8+XEMvGwGmYuFP8/69Q4OF+22sl6nFKAS+htswc+pWcJC7F0mHnm
 oyBPs/tICfocMoNBJWJ9YZzmDnaxEFHmo46fmxFR6ssovFU68Hj4qYtqCMdM1Oxwg8Lq
 BcCwdN8E9cxp4kF6H5f08E2aVqRBLLuN+Pk3wRs2y4poYNjls7CkwtQHQzOcjj6hAWCu
 wIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KL/oyeH7gwTRT6hR9vZXnG1BaXwbOoATcYfdLNN+AtE=;
 fh=Kjwr8hMcMavBDbrWdFU/EDJkBusd3KJKhZNS+bj7eeY=;
 b=VqwJQUB8OgoPSNoUKwIH95IItohXAD04JnDhRfMGkY9seeL7cDU6y01Bsl1N9R2v1b
 HIEpYRKscOmz8K4xy7ELEYaCYfuzs5vGsVO4PkJ4yiH6GafCxhSXyfC/ZchPWAbzxOGs
 w6dr5mEuRliA/vhXWqBT8GzqC/qHNil5q/gy1SboLM8jZTjeVE9ePkVDM8cE0hvmkpBp
 tLX5Sfoi0LmwgUP8cB2WBhyoj4n8Xa3mDBnaMe+fwqbz57ePBau0fCxPB6jeBNHDV2ej
 c3b92rR0WPogUOKoWbzu0SG3CQ6RkhICzaBhx+QRECtAewgoCV/xDsi+Qoo602m/HHl2
 kUpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630977; x=1775235777; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KL/oyeH7gwTRT6hR9vZXnG1BaXwbOoATcYfdLNN+AtE=;
 b=Jw0zVzvCgYQ2VlUr9ccbcbVhhUpXNBm10U65dtsk8Hqn5p2rISt0fzE5LsvL1yTOQ2
 RJnKIAEIoacrKwjXbOfabyds3p3a49OFz7+dJYW/XwPHfKqZ5S+YwkSsP3U4hk5L9OsA
 U+cwDxI6AnHOC/5BPo85j4RDuBoNxTRceOjhSKNTm4zaI/SkEX/8D78Y+a1shl1zvm90
 1TNpvfiiBs6vNd7cd650MmysoXynAzedlEmcAbAoZJGAikaDd4V1mpgY4IueuZPea2GB
 4EarvjZa5V1CN2w2h+3rIzPJBk3554E8aTHx5e4VgcKRN4g7KuM5PS6KjGTlpNHnyvIE
 jCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630977; x=1775235777;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL/oyeH7gwTRT6hR9vZXnG1BaXwbOoATcYfdLNN+AtE=;
 b=d3pR3zy7OOV55wzpe58YExrscKFBQVFZNrvKicX14C88yizG35OFWUq8opTmfgDUYi
 f38d4xv9LYbMoaPkI2UGWvh6MS/+krfuZoVsCsE4SDrBVZVG2g6kPdXNTo7TICpn76AM
 Q2BVCgZarTUV/6HhwKRJ87qQZ/DarusQdmV293Y2qIurFG5wKop3FHK3EUDWS281WWL2
 vWf6hDrztJ/aSW3eEzlLszvrkvUNtjgyq4z0eEaS8i5KqstGGigeEvc2jdo8meOpXJhb
 jFm8N9CAc5ZrFy9Ro8J1EkP+YfmBxM8PTpjEfigHTQS3lecIZKtXIrQJ8FBqKFucuAX2
 IjUQ==
X-Gm-Message-State: AOJu0YxnrZwmd0lDH/S7FDzJoJqSOEIMgbBUjTxduf1yOEGwVqWxB96Z
 5eY1Gp0pBnUcJzh+4j1vMbaKIn09DlrcFWjhMF4DJTZzYRwwyroEzhM6BHFnR9R+GrLtvBy2OeG
 +MvRAYAcwr6ljGEMzCz6EdS54acXDNMA2BieoSoNLSRqBOiyc2yFzYvE=
X-Gm-Gg: ATEYQzz1Hs/33HwbRn09NV1JB3/k29TXt8mHUK9o+3VK+l0Bc+pTSIFxPF5I/CoqEyM
 eIw8tT2cTuHr9o66i8Vd2OhrYNyypD8poqUOWMQheHqWsQFPuMf23zVzSAcii/099PHW6XqvgWG
 Qm80/rc7A/KaFsvK5eKe7flGVEsB6b9euTnr3ZgsYJE8eSXSJ+zk2x9igUPAQZdZaZ4HcZg3YLJ
 kqNjrqSyQ/bXxaGfKoOrnMAtr5U875m61YnS8ohh+C5LmphMlFgP8zEYIk8tll2YvndFlPJ948q
 PIeus5rF/lk24e58AodbsQ8FOjKlZq0PF52bfsEGqBo+8SPL6E4tO3KI4YzNCbLyyCs=
X-Received: by 2002:a05:690e:12c7:b0:64f:fa9a:9017 with SMTP id
 956f58d0204a3-64ffa9a94c3mr2575046d50.28.1774630977130; Fri, 27 Mar 2026
 10:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
In-Reply-To: <20260317094806.1944053-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 17:02:45 +0000
X-Gm-Features: AQROBzDs9R0T4PcOuVGdHeFLr2ccA5Cdls_uXP6TUXBL80Qm8SP2_k_kmU-82W4
Message-ID: <CAFEAcA_VF9iztXv9hEp1BvVoqphFM8qnmh1nJC3VUKRbVMeB2g@mail.gmail.com>
Subject: Re: [PATCH 0/3] fsfreeze-hook: fix bashisms, syslog fallback logic
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 17 Mar 2026 at 09:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset fixes some issues with the fsfreeze-hook guest-agent
> script reported in https://gitlab.com/qemu-project/qemu/-/work_items/3339
>
>  * the script is a #!/bin/sh one, but it uses various bash-isms.
>    Most are easy fixes, but getting rid of the PIPESTATUS usage
>    is a little less obvious, so that gets its own patch
>  * a bug in the logic determining whether to log to file or syslog
>    means that if the logfile doesn't exist on first run, the script
>    will create the logfile but log to syslog (and then log to file
>    on second and subsequent runs)
>
> NB: I have tested this by setting up the script and running it
> manually in a temp directory, but not as a "real world" fsfreeze.

These have been reviewed, do you plan to take them into a pullreq ?

thanks
-- PMM

