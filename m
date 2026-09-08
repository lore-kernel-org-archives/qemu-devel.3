Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95609C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tRl-0006VX-61; Tue, 08 Sep 2026 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tRi-0006Uy-2D
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:52:58 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3tRg-0007vA-7w
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:52:57 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-865bdc6ed72so73391747b3.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788864775; cv=none;
 d=google.com; s=arc-20260327;
 b=FutakqNMGG/jjKLixxx4rQBdra+FlebHVX84lAs68GQxNdRMJg9usn2UjgQT0/5/7q
 MqaXMloFSf+6XDqC7+gPWgVMsNv+0A4/835w8nn85prsvsAq0X6B5B7OdoOBv5N1SD9W
 XDv4CzRwedDuTgxW5Nmyr0zACnmOjBi8j8ntjbeS49kaYA+4Qf8ECjCGeMD7bacjUFbo
 +8j8XGx/LluXSt/MgPUwVQHAnHNGzvfcyv6I8x2P8xQwyTGJ4ahQV1HEEJTvRLZEHPsF
 bhKc+9vvvwFNCnubmZ6QLlnpJlUpHAd2u2HQIfL5tAIFGN7/qcS2yNW84aXlk9kfd6tr
 NwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1J8vxuDXqLCYZZyMA7TT7r1/xNlq1o3om5nwLugTks8=;
 fh=sRUZhOrtQrMqc/eFOHKvsgkQfkY6GQJF84aRUpG8Ebc=;
 b=DMZ2bJQc/1VI2UvV7+ewxWNn2x67nrYLhtyUql7mfMyerJBCMiogAW5nFbSNbTLX2F
 94uENTbkEAcXmt71cZIgdiAowe4RywJpoG7B4RORoI0BHPP2I1ZlQ5USZzsddB79ssiK
 afwY2dC+2HOXHSlefEmWxBwBxbMUi5edvuNtiaJCx/Wg5eQHQnKdZduNzSWMjBaALOCH
 DfvkRLAb/4ml497WGc3oQiuD4M2jyW9umqFZUPORXPbso3DRGAQo1r+b3ndeKbphw8a6
 kfnPEm2ihf0uiXAnZW8kDp8lajEuVBahVPh6XVfQAWf8SRVyEY5sXwh4kbizXGHAXCFM
 ePSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788864775; x=1789469575; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1J8vxuDXqLCYZZyMA7TT7r1/xNlq1o3om5nwLugTks8=;
 b=WGzARZg56lUX6zayMPz3u5dFEcw4LLAQ4X1h1BN0naGpmiGWxtJkyntiYGUDKWewrM
 n8cfU2w96vF8XqUax9iMvcKeADvuUUHmECq9DBpZPgjPB6nSYJ4IBmxAQ88BOF72EuAu
 QG8+BK9qgdqFdK4+b1XWuE0vgSeTZ7T6v7lHLZpbuIaAeSdD6LHcNA5OqZRVBTK+ihDk
 2EQVlmzu6ulKIdXsNnUaVotudCeaq4Ocd+wNYtssrOLqsvwO40woQRKx8VfMwlDYqh7w
 ArkWbgaIy7LQ7I0z/SRLdKS82dGB7EWT05mJgdqiJz3roQM77IWHi5b+FZlftwDp9uWB
 wzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864775; x=1789469575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1J8vxuDXqLCYZZyMA7TT7r1/xNlq1o3om5nwLugTks8=;
 b=Q11PtFPYhnm9QeswDO+gjhPDwkjHXZLSUkSLdElLmoDOmvnN14CZEwqRpRXpW1ThIu
 p9tX7Z+HNXYKnKIAXZDk5XxkLR21S8qUQwVaSii/QLUsSm9E3DicUqRlxXya/Pw3qP4e
 vRXPR/RXWfP7fBvoVHqUVVy/zUyYL6PcJ9+catQLrYdRiWH54oSqPtrUo7U2Ns2pQf4c
 1H/Ixi/cIB/CJDUTKo8Tc3WlYjXqf70SmpHnX/P+p1GxeOFuCETO6wBpLps4OA2A7/qW
 uP5ZRUPGLdBbAZ3J4RCb/X8utnhq3hw4XTUZogYAmWinEDnRCGd6acXgjH/214484sME
 tusA==
X-Gm-Message-State: AFuF++mBDNxEqhgFczPNv3tOhVxS/EOkmSajoph0MuhSS5fGwOLfL4U0
 8Beue3lE7hCPub7YLcUqLDVij20HPWjAel7r3celXKL5LlbcL54Eozbx0UkRzFV/Cahkb1Mc3mf
 0WsgBwm9L+usHjxqmoAbQszycSldOIXZoIXi5OqvYt25EcTgoSeXe8EI=
X-Gm-Gg: AYBFou0S3nPWTvo1Ua8pSuTRzZ9WIi82wDX/BHBdC0aTc4WpwUGJX0/+ZowdyyvXue0
 6lo/KDHsr2a+GqAx2mq9EdIBaB1vxLVPMemVkdBaBXgzsOGLoOfY8DHWICp9RnVmBU4IYBlpw6R
 9Jh4bJ+XQLSLkY6GXBXqR282SWGnmD/DyZriH+0Xz4NZKv2IeIXj/4+whEA2uYDhkutsEEsXtMg
 iJmeIZ2Yho9k1rM/2hhtW3B7H7Bdr379AhB9QNOZuhjsN5j4XF3DAEclo3kqdTf5H4iobhBp7Eb
 ljlhbaitbUmSyr9nJyOVUXDkK14ACIeUUP+QCZTcJPcI6p9AfnaAgYmT1vI0hSYIwdbkb70dq3C
 QyLDIW3GAf3jai9X+HtLtRABFzfHg
X-Received: by 2002:a05:690e:12c7:b0:66b:300b:e95d with SMTP id
 956f58d0204a3-66fb5b2190bmr7753144d50.50.1788864774856; Tue, 08 Sep 2026
 03:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260831081709.77725-1-guobin@linux.alibaba.com>
In-Reply-To: <20260831081709.77725-1-guobin@linux.alibaba.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 11:52:42 +0100
X-Gm-Features: AcwNN1UHDdNqB3wZGi8w9Eo6D3c4n-sqm2lzOe75ZmJG0Ix4a2aCCW-u2jtv1yE
Message-ID: <CAFEAcA-SGEY4+fhFTVTcRVieqh_eTQWAcRzOAQLas_oPnZ31aA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/bcm2835_ic: reject out-of-range FIQ source values
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 31 Aug 2026 at 09:17, Bin Guo <guobin@linux.alibaba.com> wrote:
>
> The FIQ_CONTROL register accepts a 7-bit source selector, but only
> sources 0..71 (64 GPU + 8 ARM IRQs) exist.  Values 96..127 cause
> bcm2835_ic_update() to call extract32(arm_irq_level, start, 1) with
> start >= 32, which trips the assertion in bitops.h and aborts QEMU.
>
> Reject writes that select a non-existent source and log a guest error,
> so that a malicious or buggy guest cannot kill the emulator.
>
> Add a qtest that verifies both valid and out-of-range FIQ source
> selections on raspi3b.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4368
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>



Applied to target-arm.next, thanks.

-- PMM

