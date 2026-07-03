Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A277C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfafy-0008GA-TQ; Fri, 03 Jul 2026 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfafy-0008Fu-9h
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:59:14 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfafw-0006MN-V9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:59:14 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664c535f1a0so538171d50.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783072751; cv=none;
 d=google.com; s=arc-20260327;
 b=PABru5kPXNhgGasJqZsf+o3fnStpAx3TZpIoPVeMMoMz97mdkiQ7m3EXwcFBQuQGK5
 /wGk+RumRP++yrEVrNXhYH+X82rj1sV11RhmOxGcEPS2rp4wl4DuFY/PnMrGz3k3kZp9
 JnN+6tNPfYSSXw5CLeyVKSfm5HnIO7qVva4y8shBCKgO9ex78myZUEYcnXJWSV2DbYCm
 VGqYKpHU+Eelqrkxs5j7uGJBCpOktEJwfFc4Sa3H85yIw9GBXwW0PuLMMECy1qdcxvEM
 kHI30EGXmXZJ/1VvAoA9buW0RAbObD/TnKGbl8HNzDDyap6pCwxOFnwHTwzMtClHl//6
 VKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AoiTYKPuGd8/4vXTOmKUZzPml9GhwnmxVTdu+0EkMrg=;
 fh=LQgl77NGTLnLNi5By65zk46n7C3uWs1Hphtzg1uKkpY=;
 b=BIDRl0KAXMoW2zjHVaYYugyeWwIZPxJgoaz+aHeKtwDzw5nFpqinIlrWz5kxQocMBd
 V0PzyFBuS1h+L2MtR7rq/VWgRaomhzvPAN0Gm7yaNAVISb//JXoojpiuPEH2sHN5FsJ7
 SyBn6g+2IUavl6oLdUZKVSaBOyskmiJUPT3iHnUnqP8SKscQmd6waITcUXuixKpEWpRx
 JYIDruZp8KZgezEMRNfdEE3Ef7FJCP36x69mxn4RQDaXb4suKe4Oe/+gWztMPEpTIJiX
 RIm1mPHDd7R/kY5Y+M64btMq+XFHT3IKXcl4iJBjFYmWYOMun+dt6mKcvX4HS7owkzoD
 /dyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783072751; x=1783677551; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AoiTYKPuGd8/4vXTOmKUZzPml9GhwnmxVTdu+0EkMrg=;
 b=jsNeo/Y3BoXoE3xjyoOOdFokXFpHxnLy3jlZ+bMGUsZ2Vgkxyfay33UHRwyFLuQGal
 V8uu5U2SEi/PLcgVaQ+VnFtDZw+hyrq2GQ1kJdgsVf4YZZqlRykWchHY4Jiektyng/9o
 Ykta+UWCazxiZU55VsbFlvMNtScvc246vvTd0KNcwPYoU9lYRumjtvmnfTNkUMP6+VXD
 RanMVzaTfVWG2MHOws0oAPBJfn8AOfq25hdbr2c68GfKoMPYg1rriwFPGeHYkamvVT0h
 0+NZNkQGR7G5ZXZ2c4Dl3/7thUpHaIigIy54k0ovDpVcBpQ/Q0FMZijZeL7vCagguo9t
 PrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783072751; x=1783677551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoiTYKPuGd8/4vXTOmKUZzPml9GhwnmxVTdu+0EkMrg=;
 b=WOsX2BzoQVUzUHH/EO5Cnezmaa2yKmNXHqIFXQt/zAjZ1z87jGm42NytVAgl0lY5i2
 rszolTEfFKYgQmWlaFehI8a32uaf/QHrwIUO8B3Tg0T8zcmVrmGG+9J3hD77ZjlZ7a/1
 Y+KJqODiOse0cq2CGvRd+ZmK5cVgzJCS7cDhGq9/ppUq8Au02hQ6qZQ7kqM+PTa8Bh0o
 /1937x56fBEp32uQjxataOIjt7tYdpJ/cSkvIHFld14uvyCiNwi7WHsImNQZ5EHYiTlf
 1MRbB8jyKwNHtn3ZDB6sPhM214Tk9uW6wd8zGZVyAjnVtkX+gnAqn8PWOVwhphpFMi3X
 Rp7w==
X-Gm-Message-State: AOJu0YwExT1g8MSawBttPimii1bWJT1oWgGY19U7htBueJTWHewQPwjr
 wXGsgpnBH6t5CSv9jq5yBGtb1ODA+NxUiyp0i4lvpU+IR0PnE3QS9Zj3WvkP3ihiw8Z8KxzK0n8
 cNY3ExyC832eRMEluvfzEzgxIdkPzGio+DeZ77g5L9w==
X-Gm-Gg: AfdE7clxFYQkBVmjtwxR1s7XT2ChFtHYQMAGm7er7CU2gq04TOeB1CBLe10sf7omgY9
 olVzwAHh/xbI9qYuzdE0nV9x1g5pZgk8Ei8DGD/tC5BRQZxVr4eImcdQku/JhdgQKjhG3qNsStj
 Z3YAHFAm6jGHfFhXbGUS3eNehyOa3bVDwOstsx1/JTCeZ2T+uZ290SM8vNHHIFWFIEEjiohsQkN
 Rhacfp93D42w2lC2ZGTovzWO+l213tf9uiKi34/iheljqD+kyKD78xDD/CeXcXQQf3e0ii4MuTL
 Grzb2JSNt/EkZZxXuBSzoKX1DyMB0dkxvudZVeEmrAhkSN5eqNnjvbKCnpvFcYxwpJM=
X-Received: by 2002:a05:690e:418a:b0:664:ae6a:e9a5 with SMTP id
 956f58d0204a3-66521d54781mr9218668d50.75.1783072751406; Fri, 03 Jul 2026
 02:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260625161855.5132-1-163wangjack@gmail.com>
In-Reply-To: <20260625161855.5132-1-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:58:58 +0100
X-Gm-Features: AVVi8CfGHeq34WW-jf92qKhEhtKsmAIj3TkjRMaUcE1sjTGnf8dQKdJIOE5w9_0
Message-ID: <CAFEAcA_iK1yK2rM+0mDc8b4Y7wYNsmsd4jrU+0Kxkr4_FuAsbQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/misc/imx_ccm: Replace DPRINTF with trace events
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:i.MX31 (kzm)" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 25 Jun 2026 at 17:19, jack wang <163wangjack@gmail.com> wrote:
>
> Signed-off-by: jack wang <163wangjack@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/imx_ccm.c    | 18 +++---------------
>  hw/misc/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 15 deletions(-)
>

It looks like you didn't send a cover letter for this v3 version,
which makes the series harder to deal with. Anyway, I have
applied it to target-arm.next and fixed up the compile errors.
Thanks for your contribution, but please be more careful with
testing for future patches.

-- PMM

