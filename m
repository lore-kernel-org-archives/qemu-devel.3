Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F01C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8av-00073k-Qi; Wed, 03 Jul 2024 18:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP8at-00073Y-R4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:36:55 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sP8ar-0003Lp-UM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:36:55 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24c9f892aeaso29016fac.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720046212; x=1720651012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77PLC188Ya61WjBUNuFD6c9d/hzjThvnjgefUjH00n4=;
 b=fXAYGkDgnupq3peLJNS9kUgnNOLq9iKiHezWJkX4KPGzaw8sHhlxYytFENRvDxHx/+
 oz+zF/wurCtEHed9StN+O8qs6G6bnxDmhaF9rRl44Jv0JXWVD2zB6hvmGDXOYgviH6Ab
 dNltTRFIl65eAxdeP2faidVsvZTXcyt2e6LMsLuNnmRDXuczmzZnCo4fO/mL0dNs4jsi
 4XyDfEzvDK1YpgPq1gg+oP6WHXsihz0ma3k3VEuK8t3Baob0ZzpDoOWxOu0n5CjUrN95
 xsFcvaoq6S2cUzeaPK3lnwJ8WEWnWOSKwUJF2VeOCEnZ21meLA7+QhmWJ+84MpqYy+Do
 hh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046212; x=1720651012;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77PLC188Ya61WjBUNuFD6c9d/hzjThvnjgefUjH00n4=;
 b=P/LWuM3YA3hqOB6ZULsj+YmwWlpdH+oAHPmbDnlouImPfe3QVF9PXwQ2JKkgvHRcq0
 ranWl0U2Mir7mDlzuOq+28Hvsh+2FmMH8wQNErtwvF20qUa+qhjN7HPw48HsPbnpG9vo
 HdhXOe5k6Ri0cGcd6viwc3zRG1erhvBOqx+VhX5I2h0R77jjKZ2IojXDQIglYzYlcZN1
 GFHRi1uJYKResMm3zkM1tq3Ej7K8ZkHnc9rp5DtGpfDfaJ/Y00lNnt/XZVU1ysJVe2fy
 V7ye6+XB2MKX8GAjavs7mJIbuTMHo8DFZaetdG/QHwxvkZsXk9BPT8wpy7r9VSZyRbrq
 jpBg==
X-Gm-Message-State: AOJu0YzSEDhL+Law0El0xFlNnokKA2TTZhyEFcfKNI+GfanppTdzUZb9
 aMghCFEuntR5SHLL4ZLz6jd/1LYqudW3UOR1h5JffEN0OKgggvztediODnP17a8Fi0y1SUp55tb
 +
X-Google-Smtp-Source: AGHT+IFbPCkqJ4Te7PX3o0TbrcoRqWJca0Ja2V8qxyTdQbhZMzPaiFAZyY5QGuBjYnI74i/yOtS8mQ==
X-Received: by 2002:a05:6871:3311:b0:25d:77fb:3b0c with SMTP id
 586e51a60fabf-25db345a427mr11101446fac.31.1720046211666; 
 Wed, 03 Jul 2024 15:36:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803fc98b8sm11280220b3a.97.2024.07.03.15.36.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 15:36:51 -0700 (PDT)
Message-ID: <79a8c1b1-e541-444f-a936-1e395a9042d5@linaro.org>
Date: Wed, 3 Jul 2024 15:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240703174226.2117169-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240703174226.2117169-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 7/3/24 10:42, Richard Henderson wrote:
> The following changes since commit 6746482d12da3b6e4d3cdf06481a0027a797f719:
> 
>    Merge tag 'sdmmc-20240702' ofhttps://github.com/philmd/qemu  into staging (2024-07-02 09:52:10 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu  tags/pull-tcg-20240703
> 
> for you to fetch changes up to a71d9dfbf63db42d6e6ae87fc112d1f5502183bd:
> 
>    tcg/optimize: Fix TCG_COND_TST* simplification of setcond2 (2024-07-03 10:24:12 -0700)
> 
> ----------------------------------------------------------------
> util: cpuinfo portability fixes for FreeBSD and OpenBSD
> util: cpuinfo for riscv host
> tcg/optimize: Fix TCG_COND_TST* simplification of setcond2

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


