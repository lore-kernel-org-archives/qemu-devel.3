Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E169CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZlF-0007mh-RB; Fri, 19 Jun 2026 09:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZlE-0007lx-7d
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:59:56 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZlC-0007kg-Un
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:59:55 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-662df6a4fe4so2701281d50.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781877594; cv=none;
 d=google.com; s=arc-20240605;
 b=jHBoBwDyD1Sf9wPQbJivrPnFpvSF1nf9y9jAkABqgIj9HS3xdwd3cA/JncHKJwMISr
 gXj/MuTRBmIwCjDeZt2ZU3ye1p9khsmKTyvcuInmSBpNMuYZm4TOO3WacUC+71GjsUSF
 vNK1KILM+Oal+TXsOD/KT18rbqpaFSTSKmg83NlEwrSfK8zPX+XaFPI73YmsHlTRgg++
 LbakjFsI8xyRqmE7OqWeYaqvhtkAnaJOxSWe1sR/yiFK7VUEHLGtURmT8I0zzHG126Qv
 EW/h0waQMLG/OumqYarOYHS8N4XhWyJBYJoH0GWQgrljO9NFgpepkVxUUBftBfK5Ds8+
 tvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qqXf/2zUQuOG4WvhbjV5Xtvcxhzrfyvur9hCrlONaFM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=aGKyFrEA4F94kaXfo4xLzQhtI6/Gkgia2ffAi2hAZ+0whS2MMWmrrVm90efxqbHhab
 sZqvBlRrmi+gyPR/MqTg4II6ZNTBS3GLkvDKUmaVvjItOR5OlB24Fu8a9nrvgbrlNQQI
 07hrNzSC42+4w0j6vMe0j1mBE5JqK5/aDXbhPwfpTqhimndSVrdihMfqDN1G/4JS98ZH
 0G5TGjHgCNf0TztN1+l/54xbP3W1/Q+DaEqv8J8LNVqLGPpWSDNQcHbAOFsrf/o6YZqo
 W8QDXwle65MFvTB5UnOtTVxc0gRSlTTvRU+8sIrHL/HXUeUPOSiyny2XhxBaE0gXrf8p
 ZQtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781877594; x=1782482394; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqXf/2zUQuOG4WvhbjV5Xtvcxhzrfyvur9hCrlONaFM=;
 b=jTzWsH8yy85A6DTaLC2L1qXhAqa8Io/z70tskmsBij2TsXu1uZJedBNEV1o9OUZQLj
 2ZXb2NMhJZ5uJmJq69P+zTvoQ+K/wxpbPVCtjDtAoW/9p9y1KZm+KqassHtZ82QIYc6m
 DLXusyKUGmOJO6/bXwyygIaXnv+3RfN9w+uKazPBPKoeQfbNxDGgxFPS6wH2K57p30U7
 ENyyL+Boz28xT4oO4Ie75NOqwixrYfrJV1VKU3Efz3By8DvVphyPI58n6UN502y2Bglo
 gYrkswzFmJN1ugK0UhjthGTvnRF+jsda8ouLr4RITi7w/DID5/sHJ3b0mx5e7/q9dryC
 7VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781877594; x=1782482394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqXf/2zUQuOG4WvhbjV5Xtvcxhzrfyvur9hCrlONaFM=;
 b=i2YfXLfJ2xb718krjHwTVilca/IFnXa4ZCIZOPEHaH8YTqD/Zyp+MFqGBDO3U5/8Je
 xizN4oE3ECGR5LO6dBu/A4W6Fkoo3TJaf6vhOPVsVyITSmbiNi2uuAYw/pD/55rfPieP
 q/O6oAU6SpY/c4TCGvrPe2veEiwy768FY/uu9/EkVjEcBDuykys5kLoRf/8Z94sNyqcg
 SaQAojhq2OXb2IXVBdPSv6/9Mrgu/tC+MqaeuCDcHX5BY4CNWS/2yrM6B8ZSI93rNRUE
 Dvfsolc3ShNqBgsXP3mvLED48R97jVbMeMV7YGtDNW/6NJw8TJyZoM0XLSlMoOL7aWqP
 NCcg==
X-Gm-Message-State: AOJu0Yz5N4JO7AHjAKj1PfnF18wr8k5/+VP7Y+DYLfQtXP2UgV+7PchZ
 WUjRw2dpLyZC8yHHzBo8x2VLKOigYXO11YB/DRlWUPLx66y6NlN9FgsI3XBN22iZtoYpfxdJ+Q4
 Xs25HetF4M+8GhLLsH+LIbxZ5ngrHRWu4H0u2f7ix6w==
X-Gm-Gg: AfdE7clZIkZ/AbT40i+8IrWo9QitRej1bkSnKYf0Bnue4yVejDsWghFIGaR3vtctYyT
 ohU9XJ5uY5PtXfzsIboDh97brroxKM7zC90dhwmXKQx2ZMkLBsTxZ7tZ2ppXl+rTuXJpYuVH8BM
 a6UyUnuRxJxLBvGL1FxawI0yvdhXoguujU1Vpx7/It+SvHp3gS5xm0rCPlQ/4N+Nv0Y/6CmyOUT
 oJM/0AA2ZlZE24uNxY0j8TtWWgMrOqegxmIoNKYgSc0oWmWXiy+dnvRym6Dq2OcETNBfX+d4oFo
 3WxvITzjTttUeTx0PHW8yJCIL1vkBQpxbPzsY/NjFnYgzUIfuUwG6OQT
X-Received: by 2002:a05:690e:12cf:b0:660:40a6:4c9f with SMTP id
 956f58d0204a3-663035f151cmr2049130d50.54.1781877593729; Fri, 19 Jun 2026
 06:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:59:42 +0100
X-Gm-Features: AVVi8CdBD6C-wfS9OQSuwmTJZRjBtEqmfUyEyG3NhnfLq8YsXiSpROQOhuloIAs
Message-ID: <CAFEAcA_k03TSrmLtUqYO7LiVat6oYSrqZH_wX6a-+O-KUqd6DA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Implement FEAT_SME_F8F32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 18 Jun 2026 at 05:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260618040718.572950-1-richard.henderson@linaro.org
> ("[PATCH v2 0/8] target/arm: Implement FEAT_SVE2p2")
>
> This is (kinda-sorta) a prerequisite for (parts of) FEAT_SME_MOP4,
> which is a prerequisite for FEAT_SME2p2.  It's fairly easy because
> it's mostly re-using helpers from previous FP8 features.
>



Applied to target-arm.next, thanks.

-- PMM

