Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81992CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcnx-0006rG-Lh; Tue, 02 Apr 2024 07:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrcno-0006os-9A
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:59:44 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrcmW-0001yD-PF
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:59:27 -0400
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so5914160a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712059096; x=1712663896; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6xpEB5Lqky6CjRgyeYD/m/zuvp9yUQ+gxZBSsw9FK+o=;
 b=GjFSaEC3ejJyXlZ4IsSPx3YXnljMZY5de6I96loZbsFrCmwsL9XhEb/XBS1qy/NIlk
 TglFmO4xfP/WkhMUOYBGHclAITnX9gAr7GFS7WOkQe09+FXquOXAZXDoWNUGBAZXuWpK
 J5qXJQm8o3nGamk0hxv/Aqo7gYjSC7ooFAC52iYR6sY+xg4gKRTixVyjGDfn5jPkeGfp
 PPyIYzdRhrY8AB6OFqwl7ZtJqskZ4thi3uyu/vYj1Y3KvIKoE+EqWjlFvFEYFtH56CzJ
 J+hdEl7BhtlzZZmAP9RBSjtH7iWE2mllvjrVn4O+3yIYN2DRYjZa+Fqfjau+9kH+xrkm
 xs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712059096; x=1712663896;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6xpEB5Lqky6CjRgyeYD/m/zuvp9yUQ+gxZBSsw9FK+o=;
 b=SzGZ6pI6MDoiveUbKutiWnK4wIJVvpemakVfSUuyGWQzzfpW4QbhKCyeo2cfBv+is7
 DKSe6FvEVDx1A/9JGKNk8t+h1/xlVhFpf7K6+BHNWgIAgFQaH9oQCt0uOoK0Mx0bSqQ4
 dti3Uciz/NKJgcqzXRqAfvgAMKvFHgBlQYvM0iV4NYHO542G3gPoD/OFa/gkAm7aj9GB
 bqF7i7VEEe1LaTX8F7KVOJFqfSvRupCCJBuS1asGbC69n1ac0awCkv1wAe4KGgzXLjRO
 056Wu0a9jk0wGESh/UsTDbOqIBcS176OWKOv3phlUWtpEunEvSV4dk5/Wxq0QdivT1M4
 A9pQ==
X-Gm-Message-State: AOJu0Yz9OPR7lHg9ZsWr7nJYo8CleDNgVYLjOG8yy9Z+mpjvOAHbdLuR
 jMi3hHnmOf7eRoJ++nRB9O2ZZlmwUQUyJXQP0z+OJRXSjXWlcBv3FJGHjwVv2CXR83WO18VCmqM
 q6WPBSSTBpn3vMbrpc3eHgx5zjnL3SffJkZSIUsSP/b9tZuag
X-Google-Smtp-Source: AGHT+IEb8yA4deglQmB70r7zjeTChOPr7ikTwzSyzVYnywstAVRKGXLcdrUkpB3XSuOLesnmIOAic/NDLehQZddT+7I=
X-Received: by 2002:a05:6402:5112:b0:568:1882:651f with SMTP id
 m18-20020a056402511200b005681882651fmr10685384edd.25.1712059096483; Tue, 02
 Apr 2024 04:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240402102951.3099078-1-peter.maydell@linaro.org>
In-Reply-To: <20240402102951.3099078-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 12:58:05 +0100
Message-ID: <CAFEAcA-A9NDHyZ_A=Tsw7UdGTy366YK85Q4CGQiari2h97VCdw@mail.gmail.com>
Subject: Re: [PULL 0/5] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.208.51;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-f51.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Tue, 2 Apr 2024 at 11:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Nothing exciting here: two minor bug fixes, some fixes for
> running on a 32-bit host, and a docs tweak.
>
> thanks
> -- PMM
>
> The following changes since commit 6af9d12c88b9720f209912f6e4b01fefe5906d59:
>
>   Merge tag 'migration-20240331-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-04-01 13:12:40 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240402
>
> for you to fetch changes up to 393770d7a02135e7468018f52da610712f151ec0:
>
>   raspi4b: Reduce RAM to 1Gb on 32-bit hosts (2024-04-02 10:13:48 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * take HSTR traps of cp15 accesses to EL2, not EL1
>  * docs: sbsa: update specs, add dt note
>  * hw/intc/arm_gicv3: ICC_HPPIR* return SPURIOUS if int group is disabled
>  * tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
>  * raspi4b: Reduce RAM to 1Gb on 32-bit hosts


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

