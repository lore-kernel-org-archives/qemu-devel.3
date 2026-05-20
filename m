Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CCCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPl3k-0000RZ-QA; Wed, 20 May 2026 13:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPl3h-0000QU-99
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:50:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPl3f-0001mj-1n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:50:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2baef9f5ecdso41640085ad.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779299412; x=1779904212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kO+kPL+Mr9cV3hvxuG6WT/H5e2cjQXsc8xdWbBdTm5U=;
 b=MPoDULJ5co1yzcYzMlftSem125pP+yg+cE9J8B33c5rx/NhDSO1Fa7rbDS8zXdfaQn
 Wwp1K8tZvi8iVAYbJ1o9HRSRWlR7c2aIbj+Ud/l9FT/XL/bsVuSvGmZTMYUezut2BKsS
 zdoHBy/4E/L9Kry4dlpi6oL39DQbRndXrXpl9KzFPDNgtSgOGtgTC//hpxH5ul2jq4d1
 iE3hWx59BLA7RZQenXcAUdKp80dLPPhVRHsFtXqiqEwWCatSyhWZkMkKtUyqY5O+MiR6
 VBjP3UlaS6GELeWDKzpBBBhuryxShhtjk0u9XapZDbRuJaHxSNSmBhmIKoTKJZVsSkiw
 Labg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779299412; x=1779904212;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kO+kPL+Mr9cV3hvxuG6WT/H5e2cjQXsc8xdWbBdTm5U=;
 b=LkHZk9bqvZQftWNjJWwKbqKlXIo523bhNBJJwhOjigJZQiRes/OrGzgHDmEWYdf6pv
 TQHYkvAAnyyz26e2I0k4ip6yof9QFleXgyjSa8K2P1p2GVK1NPSVE5U8cnHrP6XW0TSu
 feW6avDjqMV/muG3poztJWdLPdLyWuoiSUxFaKU/Ve3MVFmEX8NABvR4Wrzf44kczReq
 TEOqI8hJSOhLLTeavGoODc4U4+1F583D1OWgHhd20VAKSIkUMTXp0itRoLWJzzHU1dBU
 yifwVqmxNhysFJTzBd+TJ7dn92/WsSdy/q2fiduD/CK7rtUEddKfdYPOhhyP+dcZrQUP
 Nadw==
X-Gm-Message-State: AOJu0YyK8l0B3S4DSaa5l1Ar+Wr8CSkQlt8s34iMBpmWIsWZFKSOUKlU
 YX9cA4LvOIyrP+kjgcSf6H1m61q2QD0lOtSgDpSrInQQbS3vum6WjoaJeDt4rFPZXxM=
X-Gm-Gg: Acq92OHs4pH1OhXnRORHr9UcnQAgKX5173rUY+aPlVYELHKn0q7Zh8Chsoe1tid6BfV
 il/so0Zeb9wFNhrgjNHj7AEl+a+ElfAY30SHdq98YBzl0mnnVI7bJb9sUyfgWGoZ+bK7P/w0ZPr
 luA85OunUzYVAwSGixZKXg37jKpJn8kQ1PvjD1V7i97GEoyZLviMLVhBxKxDrlGAEZyR1pkgsIj
 dPEOCWFPQngEcUmx7ljiLJzgNws1s6feP+mJ9scYX8TmgKaesWmZ1X9qr4j8D/7XpvFzts/q7AG
 hXBWzUgO4dJiH86EhDt51z6OzuzggMdm4DcX0cM/Qpr5X/to8mcckxtm0lnZdWIyEBQXb1Qz/zs
 4lIEvcOM7f1MGKekZDB3NR0TEybTQuzz3Np8dOJ9EPuC1jBIDBvz3989Q6NUvP3qd/TuL4ELfDr
 aFLbgGePBr/dGa04uKCuKwpA7xuvVfqVyGswml5YOathXoWgkJnt1I6WMlgA==
X-Received: by 2002:a17:903:1b4e:b0:2b0:c59f:3b58 with SMTP id
 d9443c01a7336-2bd7e7b58a8mr271332495ad.9.1779299412456; 
 Wed, 20 May 2026 10:50:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe7270sm222602705ad.50.2026.05.20.10.50.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 10:50:12 -0700 (PDT)
Message-ID: <16e28558-04de-420b-aa7d-38333393c576@linaro.org>
Date: Wed, 20 May 2026 10:50:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/63] target/arm: Implement BFCVTN for SVE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-31-richard.henderson@linaro.org>
 <CAFEAcA_9Gz1Nnb9-xbgjpySG0NkO9QaMudtUs=1Ef47gF15oTg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_9Gz1Nnb9-xbgjpySG0NkO9QaMudtUs=1Ef47gF15oTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/19/26 02:55, Peter Maydell wrote:
> So is the problem that we shouldn't be feeding in INT_MAX
> as a p->exp, or that the "round up" code should be
> checking that it isn't going to overflow with the exp++?
> Does the same thing apply to the "exp = INT32_MAX" in the
> exp_bias handling in parts_uncanon itself ?

Even worse, we should be supplying the exact maximum value because neither inexact nor 
overflow are signaled in FPConvertFP8 along the FPType_Infinity path.


r~

