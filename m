Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553E3CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwh74-0001OU-1R; Thu, 11 Sep 2025 09:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwh71-0001MM-4c
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:13:19 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwh6v-0007XF-Ry
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:13:18 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61a8c134533so1344830a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757596390; x=1758201190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BLArwD4h0WuYLDjVYgR3IWlbms1EKzAZ7hWpKqNofrY=;
 b=na/pRSC1/AF71OiBZTny6YWoYoY6PIyUaOVZy17A3MoUtzrLC3+J0fXlS0oWiOIr0x
 yv20J8qk0md1eH7ve592gxQapK1MsKqta6FpU+9+HI0E8LTqGh91kJMMQnIGsREpv4hi
 A/5ovLjKZGNs1b+CMHDIXxFlUOqvkZX4xmNkphqrzs20dKRtER+KLWK+1sPLWjKrJdPS
 W2Sup9Z03dsKOwuQegS/FIGTngXS/n9RxLLB89fzL507n4qIbcS+vobCE/Rq2+Ml+vU0
 kv/hfds6ARfVgSh6oRpz8JUAwtIini1j+CKwHW8wZk5JjgrDEOC13Zd0gAkqeyWiSJqR
 4LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757596390; x=1758201190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLArwD4h0WuYLDjVYgR3IWlbms1EKzAZ7hWpKqNofrY=;
 b=cXheW36c1Ui/gI/7LNOYw6LtxWwNz/9LJNfjDMM+0wVIECzRzhMsb89bDqJ9GWzaF3
 vuEvjPfJGJRZQ06kkAG+Lh3DB5XQppH8FW6jzQZHwDJO6Qrx8f9Q6zAGeznt5GVTtkGD
 QdPh2vl/WZf//Ggh643aGdgA0WLbRsT4X/PJjZOr+JG79F6bcQgdhr1IrmjmmYUbEN6r
 cF0BF+1p/tvT9lWSPuIh+e3HwvaSDo15Bp2m5gUmnbg9/koOHCr241cn6kWeL6P6md9v
 cYl9bysKCaySXRfiLqr/QhTGCYo6IdbB2cmXaEFzZSupKyWKLkLvTEjPixjNxrF4pynr
 sMqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8yURngFI/hJZ7DEMJi6jfrhZ5U6uom3axofkW10MXJq5aL8jGk41MJxdCRtwRCDgG6SJfSy4pMfO1@nongnu.org
X-Gm-Message-State: AOJu0YwQL6K6hRbcLHuz+7/v1u64dlanbEp7+AIGF0SHrwtLM4jW73o8
 XkQGsJ54+iEa53t40vUY+LShYyfTP/SFK1xEjhIEImh9UH27haQN9tm79KBimaVRt5jUpU6s0qO
 X4vRCDhBUCzMYiRfYPo4B5gMAPawOPknPb5ijfVWddQ==
X-Gm-Gg: ASbGncvVGQFvBam9vr1pOB2GXd0vc0HEe01dLJLsZmqhXkL5DaZkl5Jzl+B0YC3Cwjt
 nXZSsGl0v66nw4MGYMEQ8aw9n/B7dhpGIGumSoDsU7kqc7pkXUft0aaQxtGdLISKSTbzW9i64VA
 0DEcSasle5gn98i2H5rExpee7xPAk+a31g39BT3t4ZZtgjrKp9RnMLgkwjvuY2sSIfUBFbLpU9o
 6JGgh+gqLO2+BOFMX0=
X-Google-Smtp-Source: AGHT+IF1Do3jJJouUJIYYM5Oe7bMecITwlXX7e9Z49dzvjsXu2b7hjeaXyKSNiI25DkAz8KnlclYlmcM9ZOVih/biQ8=
X-Received: by 2002:a05:6402:254d:b0:628:20b9:2621 with SMTP id
 4fb4d7f45d1cf-62820b928bdmr14561690a12.2.1757596390349; Thu, 11 Sep 2025
 06:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250909123747.567480-1-thuth@redhat.com>
In-Reply-To: <20250909123747.567480-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 14:12:54 +0100
X-Gm-Features: AS18NWDgOwpwP8VpUus8K1NUd1-geWRZuvI1MgI47EqU8IPPNQcD1WfFs7OPkfQ
Message-ID: <CAFEAcA9h4HDAsSBUQq+3MCOcjyHJxjgyz6pz6GfzuboZ69=Rjw@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/aarch64: Fix assets of test_hotplug_pci
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 9 Sept 2025 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The old bookworm URLs don't work anymore, resulting in a 404 error
> now. Let's update the test to Debian Trixie to get it going again.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/aarch64/test_hotplug_pci.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to master to avoid the CI failures; thanks.

-- PMM

