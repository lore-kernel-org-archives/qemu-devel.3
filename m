Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3C0CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xER8L-0001C6-R2; Wed, 07 Oct 2026 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xER8E-0001BL-GD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:52:26 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xER8C-0006e4-7M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:52:25 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8abd68b3937so39376247b3.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791377543; cv=none;
 d=google.com; s=arc-20260327;
 b=K+HWOsdNoaufrpnJR1hVJu3lqF6uQSQG8w5S/6+eYctSHVhucYCrjRSBiVle9B6A+v
 SJKNtC5uCTzt0r9E394nTLwY1N/LGTRWqREbJKVDPoO79WwUH6bgBkiI9j2zQ2wOYJH6
 3nnJaQiriDaf+2ed/Z9TbXTv+JYpYdp8N2SCPLHTobCWdBV7iUPmyio4bgmXNDBKuo9q
 eWobyX7EXJ+FJAy51n5IEpWpBRstNTgo92/YYbpMTroeLn6AFL5+7sWaNLCWji74j6El
 DdPPuNTJ1L6lVJgAJWCbUSSv/CVJD4c3jmECB2F8D+Ea+GUX2vbVHp0ERxdMlUSek4a0
 9b7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/M8ny6Z7tZvO9/2DnAQg/U+xG9tNzcjhn8IlIp4a7Z0=;
 fh=9bqvBnfBGpmfWndmeD8NdsilEdr3r+aoEhk26B8UTHk=;
 b=a1IPeDHsviUWhK3UaZC0STaX1hmCyrcjrvJneoTWxvQDUD+JoQm+ja5N3e9FJGfNUy
 71JUjuzoJzH595eWx3ODs5CrIhgO/FcLlK8pd1ls9MykNncnHkjoOZ+Jjx7FR932ME8O
 ksMKtWt3VxdeZFyPwvyyQ3Vt2lQwNt4IIHUN4AzYr8e3WTLWYVSK+H7tyvYsc3WyrUyt
 0pY8u1LYUq4SOLROn6PxXv+FP3U12Uz7/R2qWM4w6Oy/c9b/uc+bUD5m8VzS4wg/9Ipr
 +oj88xnKe/E+CIFOpVKkKadLTDx3W09Gu+LBxfGKFnlxUZauElpc6J0IpoWH+wWf72ER
 Nnig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791377543; x=1791982343; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/M8ny6Z7tZvO9/2DnAQg/U+xG9tNzcjhn8IlIp4a7Z0=;
 b=BRtuJev0fNbvbt7L+MVJu0zAxlZ5Xw6ypmJy0B0mU9qroHOoch3eTr2omqBDR8Pyp0
 K0bNT7rJDMlIgzpjzM1/CMQ0UT6+RnO42reg8HfD5869I681GkUqCq5CFMFUl/bHokBt
 NhyTuFV+6sMox2xtIzkWY0jTF8+KN/dyEl+TwbQGZ4RD/vdzLdymoqxclSi+cTzDm0Xm
 lBKdzfA23/3OxkN1YBco3IYl7jsM69wAOZyZmpMz7FQ5HjHo5IA9EhWqOkV8txzEtSU/
 SavIaI+8GQZR73H+FIqD1C/rThT9Ey2L3yj53ezp75KMa1qg2wvmy8tEO9+GUBLH8Jmv
 ZXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791377543; x=1791982343;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/M8ny6Z7tZvO9/2DnAQg/U+xG9tNzcjhn8IlIp4a7Z0=;
 b=V/U+ScaeDrLGBcz0KJgd8bldT64Hl9BIXWtfyF7JgozLKfet3ITR0w2faGYzeLvUp3
 g4C8CNjalcSJYQ9akQ71abqlpzFbNnNwkd8mGxLZhovuqTE/nTakRQU7f8w90G0fy6RH
 8fDm5G0G9A/hNgXUQBTwH8KniUqurLNzMCDrjjjgCvjVgUYd1a0H2Y+qa88NtES/v9nw
 l1ILpV2ZSX6QW/a1Ws32fvfW3K1XY739oy0V/gx9A8vTqHo98b8Eri3aOL029XCmAKpr
 PUG5iNBNRel6M30d5K4Ibf3HNL4/7kZIGokq+GRzlK8I6w4dlqWDXvPzxvI8/PFPJjaA
 QrEg==
X-Gm-Message-State: AFuF++kJG2QMuyizX4HzsfeWK74QLKULl+k8MhQ+rN5343hUdoCKxRLT
 hCDWqNC+0YAVrPrmu3jGYv/B9pQOFxSXFKY4+Y9fQ9ksge64XdzRjqu7ihY/M+lvGMU/rQEloU1
 //++wwQOgYaEhhj1uy2uy9lD4t3l/+gT3/EUliNLJKA==
X-Gm-Gg: AYBFou3tugWDz2GADgFRSGRuu3Q7LEdYE7fCN1fA7q1Nb+apymbFN2ty4AdRpkXZ2Yl
 Re7EXAHt5jxYoxYOZPfAnADaKELpSDvXwz/uh42zRgI2IE5FtrgSAsyOmnWEqZsPWU5/9Dtv8o6
 KDDZ/5v23hfbmscPxkWYDMQRU6aBq9qqAgllemlFsz5ubgeNOY52deeEM/Ycqdk30hB8OOktfBs
 +0K6ppvUNOgl+MT15Y1lT+w1d1UCG//kcEFFh1SOn8MGgjmvRoisTzMRXbKWAuWtgLwIjY8CtoR
 RiZvjg8nDfeM/wxQLuDMXbSmrhqbfORNG8y8zUewGWu16RRLcthA0PSsstF9aJcgNNQlzKflvcs
 GqEWqnmYpkQqlPPMsujq3YNmjDS0XygHcaF+8aF0=
X-Received: by 2002:a05:690c:e64d:b0:8a1:2b39:c0a0 with SMTP id
 00721157ae682-8b05af853a3mr13702097b3.12.1791377542837; Wed, 07 Oct 2026
 05:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260923214453.45335-1-manuele.conti@archimede-energia.com>
 <20260923214453.45335-2-manuele.conti@archimede-energia.com>
 <CAFEAcA99CSS6RQosZTOuaqeFZ7M0AX_LBduCF0HcHJZLjjfP1A@mail.gmail.com>
 <C2534A00-FFEB-4311-BF33-DF3BC8F2DCF9@archimede-energia.com>
In-Reply-To: <C2534A00-FFEB-4311-BF33-DF3BC8F2DCF9@archimede-energia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Oct 2026 13:52:10 +0100
X-Gm-Features: AclHuK_QGVvbUXJ2F9WI0-OAFLiecf1LVZU5iiqT0SSJ1sy594uMsj0VCAw4u-w
Message-ID: <CAFEAcA93+6qBjEzZZxkDpfou6zVvYb+675WdWR2uNwTQ-mDeOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/timer/stm32f2xx_timer: fix periodic mode, CNT wrap
 and CEN handling
To: Manuele Conti <manuele.conti@archimede-energia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Tue, 6 Oct 2026 at 21:20, Manuele Conti
<manuele.conti@archimede-energia.com> wrote:
>
> Hi Peter,
>
> thanks for the review. I have addressed all three comments:
>
> - hit_time is now local to stm32f2xx_timer_set_alarm();
> - CNT is preserved and returned verbatim while the timer is stopped, including when it is greater than ARR;
> - both VMState version fields are now 2, and stopped_cnt is serialized directly.
>
> I have also added a qtest for the stopped CNT case (ARR = 100, CNT = 200), and all five timer subtests pass.
>
> The updated [PATCH v2 1/2] is attached.

Can you send the v2 patches as a complete fresh set of patch
emails, please? The automated tooling does not handle patches
which are sent as attachments, or replies to existing threads,
or where only a subset of the complete patchseries is resent.

thanks
-- PMM

