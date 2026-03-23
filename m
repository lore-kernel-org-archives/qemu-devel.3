Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878C0FC72C5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ecL-0003Ii-Nb; Mon, 23 Mar 2026 08:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ecH-0003Hl-Ff
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:42:45 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ecF-0003Ku-S3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:42:45 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79495b1aaa7so33464577b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774269762; cv=none;
 d=google.com; s=arc-20240605;
 b=TdLTn8ctS2HwR+dVQtwkIOzH0ve+AH+EoFV3ebj5nrij/yT74jVxGgxFhu14EhX9rx
 Dm0w37DxWIEZSSUXwR3ItFkTacbLZ03TZw6BXnCvmvIrnuxUeFRlrgtvxywQ/Q4Mc/2j
 ldnIw3AyG6h5V7lC8dVNhu3S5IHWwMlqo18BNKP3Lt2MIxxyeR8PA0M4dLnR2guhsdT5
 skjttO5kqKMhjGFT3CA7qG22zRclg9wGHf5+y2yirNk8vWtxemC4fgSr5jcm1JtQ8OTC
 tQZtBU/bfFbP9dBtQd4svaeJiSGzxdHTaSlHvlyxP8AeGn/Pp/5IoG8KiPM3WgDRSiEK
 v4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bWQOdPxoWNTmio9+Twmarc0LaqonfKM/EkcEVyn+YDc=;
 fh=sbxuPqjMywa3JYEGeYJMyo5ksfdP/w06LeNzDEfn49s=;
 b=PEqSsM7DEbE8AJhdcWTgyEyG0/LItLJ6dyzivKghzj9Rn+Ur6xC1bZkyxypHkazzBZ
 qSW8pqpaBEUnQ4yX6Z0fRFmrtZWPR00CTt8lABx/zaAZSXLMRzWlBk1NWXw0rUlnUcNI
 AOBbItHq1VLiK7Hdb/dSFaNYcAzzoIZqCOOOIbZYLWJ0Wb8RPmpTjB802kdJpqRgVpLu
 q4+Xd3YiAO/IsX9WGYDt0U0TMNe1oh3m9GPFkgJvhHU/akKHPc3XHR9UXLOFYNm6Gl00
 ddeULt5jBiWjIoypov5shGy90mLhVxQxFMiioe32awxBPc1hzPylGvQgs7zoMNRokIt7
 hZDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774269762; x=1774874562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bWQOdPxoWNTmio9+Twmarc0LaqonfKM/EkcEVyn+YDc=;
 b=LpLKRNGaUPdmSINeYax/Wl9+eMGmRve2DKny579hkeAUzeCak78Nu3V4LeAyigTq+a
 /tbY6ou768qVn//kSb8q7ep3ZRE5zSQaV59Mha74z5ajbkorKxLcX2hD9mfclISHH+oo
 b1+3EFACe2UdcgAjFfbMhpMWFVXCPcATSOLmm9QbiqFXg+LKV6AvDNzlUJ4xqlfJoTGU
 n0ebHpdA+AqNGUtHXkagry96SzyLbbVQmXBQ58wToiTXkuX9eBfBbKsqBaJYzmpDlUY+
 Z9c5IFyqmrC+r/UiVmXmPLPHyndWzWLCHEpmDx2OJmdQgW711eUI0ARWf24QLhZlWqrc
 ZyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774269762; x=1774874562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWQOdPxoWNTmio9+Twmarc0LaqonfKM/EkcEVyn+YDc=;
 b=mUSxc9Fhv6VKFQgFVqsInZPYmxoPWlASHCWwU+H6nb5dIAI7j42ZQmkub0VfLPElZk
 Mx6MlYrK6ExkH/f0IQTjnIOhue1O0ZqmGYAZdEOyYZOvmWQVGVAbL2WYt5kHpVdgQmR7
 i8b6TdvWDEDwTGw78a8q6bmIj/qQyGPRyNnC3WrAacSxdkGAZoS0zkv6WXKfuuW9t8hF
 NpnzwixEC2ZttE6uK2FCDoBmRKTvUh2yNx/G/m+xDnMIXDGw08LteT3NumfMUMulhrbV
 bPAKpneJwd9sEwHtEmu1UdYPzj5p69sdmoHLmvUcrqjqNGqnoRxoEiSRt2/acfT8B9i5
 hclA==
X-Gm-Message-State: AOJu0YyLLHMvl2JoMCRfOghoDP6ZhwzinTFeSIcgGQIKbMeVqyxBQfj3
 /rpY3gIhY5x3vULb5+8QJ2CXjnSQA72W8dDeQ994xjM28ZmjxjhOoT1xGonxM0WS8vw+1UUdkP+
 rDVhTDF/ErsKNHBvy+tAm9hLyAY0zv/KesH0qJTmXGmqMBAYmLXJO5dw=
X-Gm-Gg: ATEYQzwtlYC0e2u8A+0cp0Wp+5VAb+h0QY42dVIvgHVgZk3dq3wyZyRXPG0dfdOuemK
 5bmK4+ZK4WosPEg7kJyq/g3XJhXUEsYDQcB++ehEf6w+EPHXo/cuh+wLasVFcqZBYITIXqL68v3
 a2daKrRDLkpdWMAg41XgzgxMJgc5g/cwG5YKS/UwnQ90xuTKZxGDSr9SNXLO/2ZDY6vpFBf4uCO
 e/yoR13z88onWOFV7jGo9GcD+ySQ/6yOUz/BAOhad/w/6t/tMFPsXFGYmTVxYl3WcONgZR1iGqe
 n5+jygDTZnqaLyay4lPtFOUjyJCk/UHhRP4B0mfqS1aluGFrD1AU/EesNkEu0aH6jSk=
X-Received: by 2002:a05:690c:22c4:b0:796:2fde:5dfe with SMTP id
 00721157ae682-79a90ba0251mr131343807b3.38.1774269761750; Mon, 23 Mar 2026
 05:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260320145041.3027130-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260320145041.3027130-1-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 12:42:30 +0000
X-Gm-Features: AaiRm51ipqtXuwY3ht_eQmKVmLKBW2EL4fsEC7vdGKDs3MHkz1V2s4fUYdbLcCs
Message-ID: <CAFEAcA8tO=vRqRxzbsGyGrGTRa7zc4CEPBdHyVbjZ+9KtKckPQ@mail.gmail.com>
Subject: Re: [PULL 0/3] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
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

On Fri, 20 Mar 2026 at 14:50, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:
>
>   Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/quic/qemu tags/pull-hex-20260320
>
> for you to fetch changes up to 1adf67b3c445f4060900440ea210e7a1e03042f5:
>
>   tests/tcg/hexagon: add test for predicated .new branch LSB evaluation (2026-03-20 07:43:03 -0700)
>
> ----------------------------------------------------------------
> Fix for J2_jumptnew{,pt} pred-reg misbehavior
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

