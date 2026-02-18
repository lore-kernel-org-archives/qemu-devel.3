Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A654BE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 18:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmWj-0006rY-Qd; Wed, 18 Feb 2026 13:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmWR-0006nR-9l
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:43:41 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmWM-0004yq-PZ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:43:36 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-790884840baso1532207b3.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 10:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771440212; cv=none;
 d=google.com; s=arc-20240605;
 b=VIsOCfACAOTBb3AO87E4vk2TSpB5kVQsANHnxn4zdqlAgmfExpo8hBo/CKCa0AFFT6
 br94Q2897aPBVDs0gREYhBGFFLKbNu4ErdxP/f5lZ7RAPYwW/GVYjYBSwa/p/qQeJECS
 +UhNUO3SqSXq7j3gyb/z+lL96O2PWXznMjxj6HjUDPFwHjcGFf7fKgqBFhRcOvw/QhRG
 ZhbnGcfAJ9Nhuxyf4jv2pHD0/f7yvKfrsh0KfKXJ1/G/7GqsO5YTTwORkYO1rODuVPOy
 ru/Ag8O3TbTr6xplOKJ9Apbj2mtQOi+jraVXGPl4+efBkYuc7aA1tUIU7QyVbcP6ZPe+
 Bq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W3XpoEyIYAVmXg1g91m0FvVOGw+6HTiYEYjItlqrdn8=;
 fh=EX2y7zLc08fF+EwnNVqiVwJTlbhBpf7YEO4hokFB51Q=;
 b=f8N+Corh0M54PHa+EYaFmCYdzvXzJj/+5cKQbEE2O2x0fw8DbgO7PJpmaJaZciSzhD
 HNQMOiWNmBDPMhIF/SSVlwZYN7ImiCF4W9VhcXYO5zn0DK9tskErR+yfFRabFMyXEZIp
 NwIwYTYYB2cNrusdBclnOq+Jv769E6mRnMV5+Uw5hK3wdS6tgyq3hCRBFaR/UMxFgUdK
 qzcdsxzJJfffk0cLfuJhPKoSnfcqFaWj4rtqp5kW7/NNpglZgeBNrzgws7wk+vGwCQ3l
 0+tQKFCdQAaM1cUF4DQWcRWuMPOkWjorccjcpCVKHHCWQuDPZIivfxxl5xAe0fqsjl81
 ifhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771440212; x=1772045012; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W3XpoEyIYAVmXg1g91m0FvVOGw+6HTiYEYjItlqrdn8=;
 b=d7lqfUtg/C2YfvLoTUV6xv0cAUkV3UXe1n0iKbmlgJYFOF1lgo4bU/1U5ax8nigElT
 LyHr/ZgTeaMnMIsjg4jjBoqYAtjnLVqgCJEy4sAPlR/0ALfURHxBqt9ugJ62fvcRdH7r
 uD6q474utrBRwi9/JNyAOYrDCOoGB4cJ8WTEhWNp2RXTj17ZVHNRA6zrnd79yaH9eFre
 XO7WyCQjNsWSjN4FLmkhNCI2NtRKPELebZc1DKHLae7+7fp4IHsfC759CGHglZvsbqGH
 ca5s2rEPkfgGkZKVwUMq00ZD1GK470wH/o/vI0TC3dZTgepDb4cGcanZZUa+9Qi9ZLCN
 NtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771440212; x=1772045012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3XpoEyIYAVmXg1g91m0FvVOGw+6HTiYEYjItlqrdn8=;
 b=I7T8fzzcocFLzJHUeoU/LY60xneoPb0sAkoB8kFz2/5oUStWMgzCmPn6Bdr7BgqqyD
 QQvMZaBwCpuapzIjawROG32y571XdITBZSYBaOj3FYouVwtWACgUK4XJqzIe4+jAAgE+
 vwl3LQaMjokYChX8lFayCML7LolWEh/UV1uy69XyWkX2E7m6TkGY8NdNbyDGYQXjXQYN
 pmSIRIuUqopcdQ884Z00ph5U4ZR6kUgE8qiBMXcLipF9y17vJbjeR7gixTrcZJu/7J+m
 8Nh3dRQ+w0azzlScgnLdVaR8J1xkJaDVw0coezWz7urLkKsKfdqtr4eZs3KrJe6Opw1j
 OI5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJm4cahH5p4fFjHiT2lVtjZvoDAO5ECiybTOMMDdIWJu+YuYcvNGNhFx61qLgCxBwlFKLZFrzHsjYE@nongnu.org
X-Gm-Message-State: AOJu0YxVm9HVppA0wFwRt+K8bkv1cBtgoXzjhBx5xUF2ca95EUC4yh85
 Cuiu6I9kZO9Fg+XuKu2BFeV/WtKmcg0dui1Z6BJRmsjkEncLL8I3SqbhwBe/e6Aj+f0fPj/jQ81
 ajpLwq/0lNrvB7Nuc47pwFhYkczuAPLs2ciEiedQhoT/KcS4VtmlI
X-Gm-Gg: AZuq6aLHqdQ1p79hXI+KRQYLXin6Cd+uXZKrQX8eXOjibalnVhGc3/x+pJ21NVXZS2Y
 rY4I0dTvV4Y7EwEGqOb1P1iW7lWQk1gIH4p6c4A/Rfp9dZRONIl9UTod3aoQhVOkPFPosPQNNDj
 njAkR2wSmqZXY1rTDZ1c/dK3LTsFDSgKP5nCmTPXjNVJc3Xj9ALxp0+DiSsTIlrbEcSvw+oV1hl
 x6HEm/7aQRIMvPmNQKYbkTgP29fMuIW0IT8Iciat+cJb+4E/tGpWU3u1K7idNDeoJz29jlZaTWQ
 y46O9z/w59lKgftJLqg0MpIUwNgqzl1qQ3v5w+9yJAj56G6Ubq8t8ncOZ6mAnVY8GNoQiJXAhLp
 sbg==
X-Received: by 2002:a05:690e:134a:b0:649:b4cd:b539 with SMTP id
 956f58d0204a3-64c198c9bc3mr14259303d50.35.1771440212459; Wed, 18 Feb 2026
 10:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20260217210805.104427-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260217210805.104427-1-osama.abdelkader@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 18:43:20 +0000
X-Gm-Features: AZwV_QgXbqPFPyLhl1MjtUq2jN1K5CsPg2lVxN37Y_TFQoI3NWi3vHVJYNekfw0
Message-ID: <CAFEAcA_YEPGSVAX71MinzZWHQnu-9_epg0AoRjaPfu-Uc83NqQ@mail.gmail.com>
Subject: Re: [PATCH] whpx: fix FP register loop
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Tue, 17 Feb 2026 at 21:08, Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> In whpx_get_registers and whpx_set_registers the loops over FP registers
> were using whpx_reg_match[i].reg instead of whpx_fpreg_match[i].reg
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  target/arm/whpx/whpx-all.c | 4 ++--



Applied to target-arm.next, thanks.

-- PMM

