Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA081D5C0C7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Ovt-0005uE-NA; Fri, 08 Nov 2024 08:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9Ovr-0005tz-AO
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:21:47 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9Ovp-0001bN-GX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:21:46 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1753013a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731072102; x=1731676902; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ru1Xjt+2kClsCEX8Te+jiFj6tOiu+CpvyZeAxhVX21c=;
 b=fPtcd4FRLwXhJjWhZpbK7UaxyS1cWjC4MhPhqQV6DiooyBOVJMEi+vC1dL8LLk7HjW
 /B4uriaaknbtipKIBZTBi76rCtQjORSbdfmIZDuQofSb+21zCg5l8AqB5eWM8hSc7r+O
 J0G5xA5Qxy2mKhe4169SnRcEghPoeZmJREv3TPKcwG13UNzFNEW15bTVS6mA6YAgcNlj
 3z6nKXKB6/W7y7HzM4VLvQr1/vwumDRQlqOTpm3khoGR9nLTYIaARkIP22H471g5JUDs
 O/Ehj2YIPGfXCpRSCdlX0TKXLYq9uHIi7gx/NNb/Oop3cD71aNuJLlP8LYFIhtR8bmuR
 kCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731072102; x=1731676902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ru1Xjt+2kClsCEX8Te+jiFj6tOiu+CpvyZeAxhVX21c=;
 b=Wgqq0FrkHq4uTrXosonzm3IpOUHwg5P+aYiduNKSOItFKo363EOMMUIPfbn7j6IpX+
 BKh63xfmq8VxXAYpazP9Z2uoCZlP9cRdqRumf15V4VtTeESEYU8aayjg3EeKhWHoVhbX
 nw9EuHS93b1yc8ZTZOlcNjXFj8unXI8Xm1U2Vi3sa1vAWgbvpCU1D+gkjw/fqCzZQy/T
 xdiQ+ha4Dg/dc5F41XYoBjoC+LXgD8v7aqYFePPUXAiK9jqeW3DFKwTM/sADnzV9P2bQ
 11yFRJGmGteiHLIFvUb4nq8XQWSUddJls+dqYJ3Fi19asxIb3jihaWSw3igBK17+4tal
 tAzQ==
X-Gm-Message-State: AOJu0YyxdRR8gbiH0Np8niHjwmYiNr40Uu3tp9EH0hpqXTtevKAk4yrw
 oQXchYJ6B0IIb0Tilz+JHHfumuShtvwTuX4AGsjRRtCWoNDX4jC02uRBzq37F7UowJ1LUlQ3pZC
 hG4NNRD+diDfZZgpJOMKKL5NBidXG5hL8F3pA3w==
X-Google-Smtp-Source: AGHT+IHBCeXxbpo1eihLzssEPvoXw+Od+O2njRp4lMAk4z0jUJQpwzZKaiQymAGcVXyuCX3RxHQ5yi8MLEUclh/4law=
X-Received: by 2002:a05:6402:350e:b0:5ce:fc2e:709a with SMTP id
 4fb4d7f45d1cf-5cf096dd09fmr3505902a12.2.1731072101979; Fri, 08 Nov 2024
 05:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20241107104001.66039-1-kkostiuk@redhat.com>
 <CAFEAcA-Pmf2H06q+mvb8bPA42DCQvBeCXsKcqqGcy-Bxf+3D2A@mail.gmail.com>
 <CAPMcbCrkFCU59FyA9KOiLaMBLPeOTbgeqd3HPBJED1e59dH04A@mail.gmail.com>
In-Reply-To: <CAPMcbCrkFCU59FyA9KOiLaMBLPeOTbgeqd3HPBJED1e59dH04A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 13:21:31 +0000
Message-ID: <CAFEAcA-soXy9AJfnO0G9jNW_LuB4Ng5U8a8rBKLmfQkxhuCY8A@mail.gmail.com>
Subject: Re: [PULL 0/3] QGA fixes for guest_network_get_route command for 9.2
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 8 Nov 2024 at 11:29, Konstantin Kostiuk <kkostiuk@redhat.com> wrote:
>
> Hi Peter,
>
> Please update me regarding the coverity issues. Is everything fixed or not?

We won't know until Coverity does another run, which we do about
once a day.

You can look at the status of the issues yourself in
https://scan.coverity.com/projects/qemu?tab=overview
(you'll need to create an account if you don't already
have one; there's an approval process but I try to
approve new applications quickly).

thanks
-- PMM

