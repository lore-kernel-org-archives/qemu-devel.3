Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43263C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 16:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ6xd-0007RO-1X; Fri, 13 Jun 2025 12:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6xP-0007NW-5z
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:08:44 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ6xN-0001Kd-L5
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 12:08:42 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-70f862dbeaeso23367877b3.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749830920; x=1750435720; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q0AGVEj3qEhFG+8N5hRJQD66tcaORTK0Qv/mJVuZYFI=;
 b=UAB0EYZiJCgmt0vEvmIzBnOV1pzwNWqiWWF37y8+7l/XYdFGSVvj5Hr7w6+NYkT10m
 KVfNWBDZmzFE0e5ThGHL6lQNPPZrp8/82DWzVe4X6B8YP1M/qjQxedbVrkM/Qa/lVJdZ
 +gBySBYQ2ua6S27siTArwZochRbOouX8XHHfAAxDBKl1rbC76AGgzoTBpJpXLqUH5cj9
 zgJXx2AJRKzm0zfihwI7v4GGSptrtxW1JQDqs1Bk6l7rtUMvwBYEfmhzh32IG4oNHrYI
 GyG2don9FgWb8teHU0q9jf+vUwcQOgSMtNpbzCxNqAMP6sXNwTZ8fmXc669vhR4vKLQB
 YlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749830920; x=1750435720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q0AGVEj3qEhFG+8N5hRJQD66tcaORTK0Qv/mJVuZYFI=;
 b=HSjDA4LVNorcrDy7JrEmZrk44xQS1u/UH64iKq5KFGSLXpOzJY14b5U2/D+OuVnqM+
 DKlyhH/elV/9eeURqRLWugYtYnRknRLfCepy8EwJFLQMr26ufWLHGlAdBJGILEX/q+kU
 2MRn5NGLEtOyLUaffzZjH5DzjIpgawD5+dsiIWS/hF2/Hg1ARizdQ42P22UfE3M60sJN
 I5JXaM9Un8fGMkZ1lgug8HKl7ssSSdQbt9iEKB9cGYcCCn9EKQ0NK+FIJZZc44wlWF0g
 W0Y1qiPhTy79QrcinMSmJLIxt4Lufy1srvsRlm/M51aQ7vETrCTYId13m3fXo8LUMEOU
 0nCg==
X-Gm-Message-State: AOJu0YxmLI9Z2En2d3zqmBiWHgrL/s3S+uYt9sIPfsKlvDY61R7HyMFw
 L0bVeo+2NwtmYRG6VJu4YC5LnNRfUpOJZZuwMmm0RY4MSfO6DiGdDVg3lc8Y6RdtWQsMlzA5SbM
 fFpzKLceTHP0YGppqwy0xq8gN7JgEIr6FiQLu9z+RCA==
X-Gm-Gg: ASbGncsEch0unW9IFPPaEcgoFdZHaoCOj6MA4mwUR7HmO5riFbrPHuBPuLKNwISt+Ou
 zlkT/rk4zms4pSjhm5F1m9uXnuRlMkG2e/wObJHiKEeDQ8XWm6QMBeNeWUCdm+hNq337xlSILNi
 IwJ7s0Zxr4pM9LD8l90gDZg4kGWRbhh8nNhX6KiQpCt2Gy
X-Google-Smtp-Source: AGHT+IHElaU3RUXZGp1oeZWJCJPSrUK/n0tHMa2uBoZHgT+aAWen+V+PnRFJAoQg0vBu1VZiHvd4z51Hi6eHefpTBI4=
X-Received: by 2002:a05:690c:dc1:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-711637ab1e3mr54822697b3.17.1749830920354; Fri, 13 Jun 2025
 09:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
 <20250613140954.000013f5@huawei.com>
In-Reply-To: <20250613140954.000013f5@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 17:08:28 +0100
X-Gm-Features: AX0GCFtBfo3kmQAF6wwgQG8QxEjF53UX0ugXUJJfukHAY7fltSOjcRO4-bqAPPo
Message-ID: <CAFEAcA_ZbAnUS4Ufa+jsOgj6aeRS5JHJP=scw6d0qXd3NNtqdA@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows devices.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 13 Jun 2025 at 14:10, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> For these specific devices (the fixed memory windows) there isn't
> any state as they are representing fixed configuration of the system.
> The state is all in the host bridges and beyond. I'll add
> a comment as you suggest.
>
> Currently CXL emulation is completely broken wrt to migration and
> there are some known issues for reset as well. Both are on the list
> of things to fix. Migration is less important as the only current use
> for this stuff is running software stack test cases and for that
> migration isn't currently of interest - that will change for some
> of the virtualization related work that is just getting started.

That's OK as long as something somewhere is registering a
migration-blocker so there's a useful error message if the
user ever tries it.

-- PMM

