Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C810CFC5910
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 09:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvXia-0002X4-Bc; Thu, 26 Feb 2026 04:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvXhu-0002AY-Gh
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:31:12 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvXhs-0003m9-3t
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 04:30:54 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-798374d0f44so25870457b3.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 01:30:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772098250; cv=none;
 d=google.com; s=arc-20240605;
 b=U11gMm47Osq94Y+namtHc2hBeKeIbTm79glcoKibFStQ9STr6tFQqG6yomjmCgPi8A
 +CZMUfTLPFjLAr5Wh7naF06RiBCZWxyHAlCAXSdi9yXfZFOjZq6tFPHuNXYLfiGqdDJ+
 XKHPpbK7XWm1cOfNCnSvcHQzcJJhYmF+GpnpkIQXPyvFuRcc2KAWHYR1onyb/V1VuE7B
 +mVZlz84qoT1mLkOIJ+/TqzNmCPox7kFldxO4Kd1jzqK6tSl+uLo/KQFhlNcrMl6wX4l
 LclsoUHJRgRCQJMS8REUef/25BH5/CZ4c39Gh5TPtbLo+03+VASy66Rzm/AHBh9dSce1
 7QGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8x7ebrdeU+RdfsKMuJgi7+dTMqGBHTzYaiSIquK8NJI=;
 fh=pqNLb1D8bcr6Ftek+8H330VOVv7kwixaST+YmWhgoFg=;
 b=Rk7DS1PxX2l/Gj8UJbN+kPl8PcOfqOqOR3Um8JSibJFHqomXu6ItuGdrysN+72cEXy
 mnRKrCQK4KO4clgrgnBkcrXpHqpISsu4gj+XhyNWY/9Z4Xk78tFdc9nc0x/tbDJblTmz
 A5CE598l3evHlFvz1sRW8oWzdA7UdVsKaldys0EKsFxiPeg1Mgi5tu+C5cjTSvNTDLbN
 TJdAgaHDYvCD9LkU1nV2bzKZ875vJZnraInuhFkUBeazJptGEvUv2zUb4t0R7WpxvuN/
 yacaFy0hcLgk8Yo7NzsB7q/LgR+Ln1kGzWJ0oqafg7yL4b9imUuR4exE/82coJKHkqkb
 UndA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772098250; x=1772703050; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8x7ebrdeU+RdfsKMuJgi7+dTMqGBHTzYaiSIquK8NJI=;
 b=qllwJqykRwfdhhGG4dk01NS6uDmnplOIp1gDXxC3akGQIbnbQfrUTxEX0dR/cKrcJN
 Ox4xtVe0G9xmh0icFjhlUAABqoX09B5LQZtNcCQ1+zMVGScuMMQznltG7qL4cperIJ5L
 WY9EpoZ8SNNP5uiNVqw8RBEo8V+/Xz819sY6RptvCkxVMLpzShVVhoDN+f912+x9sBVt
 ly5WHwxhJPLxn2iu8Pf0jf8RKikRPEyIt87j8A0P6pm+xF5RbgWWjgeBN9/1UUQSzaMv
 lnwSLvKnid2fjLk0hQVVl0jeZpPDSmI34jzwPxMoU7+bwulGwmDg9MKAH3J0RxXHl5gO
 M/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772098250; x=1772703050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8x7ebrdeU+RdfsKMuJgi7+dTMqGBHTzYaiSIquK8NJI=;
 b=wDJaCFpWaKn4sNzruPTzddmmgsB3lb7uhF4us7RBniXUSXso6ojYgqc7WmbawA3CdL
 G9eebkQFMDvgDii4mAMUhJrqtzQHfGOX6tD8Zktqf3B6/NVoxKIJ4pa8fEcHFBXMFFWI
 6d5AILI11oh3+ZtLpIZV7L0jDWg26V4VslbZqiyoWmZVGxc32LJpBwdsrO4T/DWDoV4K
 9ljdyUTN00XVQOUEKFJKjy/JCmbBjSmM0ATvna9VkrxYN/PsPMO1fK8fSQ7LkX4KNsII
 ABDCQTbh71cG6YDA5erngdFCJCwh1cT8V/3J7rpfHVdQlg/98Oea3W8Oa4rrdC0ka4Xe
 47uw==
X-Gm-Message-State: AOJu0YwEKbdBTi7KZ8PSvr/K4ZZZ5dmoFf+PATFuVVl60WSjEIswpVvG
 VwTHEaXSSOXxVaoMN5m5h3CMlB6eik1eGSSCh555uZWgPMklpAk7t3Oxcm1rUtXFMI7Hm50/jl2
 RusBVbw5xIZnlR/skPCteNmywLwGpCU71lvjzJ4pp9w==
X-Gm-Gg: ATEYQzwIOQ9rYzdEhzoI3pgvh4i3mCSnm8vYwZnADPqhwq/eEazVhOFl3myEDsEeQP4
 L0obL7+ucaBhgtayFVLQz2HcujJzXI0HadWDCRa9277DPVhxbtZdXfuPc63qFn2dUZwlqe7tnpJ
 4Q9QUaEMMpuoY5I29YGskaIVXvETqPi6Js71K4KhedV9oRCaYiGQL4nb38v+fZnjDGWkc+sDay5
 ZrZicvxqD0hNwFw+CcSFoZe0ArXsT5OQD0UTXmABW9kYBQ0b5wXOHZE+dZmF7e9FAcBeUz1p+d/
 rTM2zRShkXIxwCkZp+0DeUrbxIpxgVO7RZhjlHt1On+xO797HrhwsCN1YjvPBpCj4P0=
X-Received: by 2002:a05:690c:c24d:b0:796:3d5f:a2a1 with SMTP id
 00721157ae682-79874d16077mr16961077b3.29.1772098250254; Thu, 26 Feb 2026
 01:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20260226090704.27699-1-thuth@redhat.com>
In-Reply-To: <20260226090704.27699-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 09:30:36 +0000
X-Gm-Features: AaiRm53ZYluDKvaljy1bXBIpRgOquPnAI0D9_xlgEqiVQZze-pSE3ENUWe28N2M
Message-ID: <CAFEAcA-8s+fryKmgU7U=B4Roh4YsQYdWr005Q4opNd-fN3LoQw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Remove the deprecated "highbank" and "midway"
 machines
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 26 Feb 2026 at 09:07, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> These machines have been marked as deprecated two releases ago,
> and so far nobody complained that they are still useful, so it's
> time to remove these now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

> -Calxeda Highbank
> -M: Rob Herring <robh@kernel.org>
> -M: Peter Maydell <peter.maydell@linaro.org>
> -L: qemu-arm@nongnu.org
> -S: Odd Fixes
> -F: hw/arm/highbank.c
> -F: hw/net/xgmac.c
> -F: docs/system/arm/highbank.rst

The xgmac ethernet device (hw/net/xgmac.c) is used only by
these boards, so it can also be removed now. I think that's better
done with a patch after this one, so for this board removal patch

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

