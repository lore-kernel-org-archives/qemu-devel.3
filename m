Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAD9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNaiN-0002io-HT; Tue, 17 Dec 2024 11:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNaiL-0002hg-KT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:46:29 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNaiJ-0002gX-SZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:46:29 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53ffaaeeb76so5880259e87.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734453985; x=1735058785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g/GNX8ntzAwLT9sHQBI2pzf9S45oh8QJ0tdAUd7Tans=;
 b=ww0ILHjgXX2HOngzfIJdPZfYpTIAvDXR5Cbeft5sQlss/RtWjqeGdkTXaxGEmHMDXp
 RcpBpQmfNjqGT1JpSdv87c2HnPNiJg3sELOlqDIR6mdMZcljV4rxlFp0XkWlsvB1md9N
 jIpj7okHGHdkSV4hIGCAuCZ4BXIdaQIq+42u8zc9BqwPPu7OkR0dT4IUkoO7SAbvEbZx
 qHlrBt5haSLR/NfTC27Nh9zSLW8xDSgI/WP0XwO+LYTUzPLJRhAQNJggA4N8tDeba1OR
 XX4A+OKRqCRkON7oWqKbPwIJv3NjAE3/q5D9PsR/4qKcukIFiIIHyaCE4L4tflyW+qOR
 uipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734453985; x=1735058785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/GNX8ntzAwLT9sHQBI2pzf9S45oh8QJ0tdAUd7Tans=;
 b=bz/wFtoYwA4CV1uxJyqqQcP3iMhBTqXm9tp496mPrZqFu87YcLtSSlncT5UwoxoWyQ
 HgdtVHisilClb/ULajTLm/GNDnam5VWgpKWGz3hBWJ+6OdJ8WoCK4Dq4BqD9MTH2Ymbb
 2OWfPw2SOfVOuyYZhbummE96evak7T8I2l05hQT7ipwLqjoatfs6p8Y5j1PrnmP1Cn+E
 1j2tSU2Ts0bl0hAGV648KOHBkt7eX8Dds98vd64UlUP4ZVgvxfl352JT/KXl2mFsVnxk
 MvGjUHDAiE2eO859kxQhtPzn5gz6KV/nEYPEV1/xfUugrvgCiXwkOmCB+8txuBpLOcDQ
 AuUA==
X-Gm-Message-State: AOJu0Yyq3hzO8Fu+Cm3eJdZxG1mPuvGa2gCtyu6AIeORlZ5vkSwVBIDG
 ni6JGo1eJ7PqL+LZpLNAII/UC4ouSJLSlDYfmf2gAmtRHBQfrfFn0wuMiGtA6Bk4T4SAEE6LLDW
 hYpnxbMp/
X-Gm-Gg: ASbGncvvPOOH6j0QipSqCvAoDA4AAwwcKtV8/SOhT0l5p65vJfrKUUZZtQJ0ZtDAdPU
 qWFnwxE9UTYar/pVyOTVsn7TjkyoNKo8PYSv0HMCadWAVdRbYLni8uT6EkQLltPmBrRzYoSkq/r
 rYltDEG8Loa6qVRVDD4+Zvs7VfIrVVnO9o5eTbFetrtTu+yClVlo+g7GT1G9z9hj+3QpknT8t0o
 8LSUvTiIpandidrR7GnMHWrwLeqnxlRpgd+ZLq8qt+R9HtUwWYBfhUYgyo2ME8qDx6kRhDqYFU=
X-Google-Smtp-Source: AGHT+IF2U44SIsX/jT+gKHLzggrrQPJiWnqZgMLbcfmXvimeU65acPFutkFUXBa08Ls7K0cY8fIRxA==
X-Received: by 2002:a05:6512:690:b0:53e:350a:7290 with SMTP id
 2adb3069b0e04-54099b71919mr5947182e87.51.1734453985439; 
 Tue, 17 Dec 2024 08:46:25 -0800 (PST)
Received: from [192.168.242.227] ([91.209.212.65])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120ba9bd9sm1217531e87.62.2024.12.17.08.46.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 08:46:25 -0800 (PST)
Message-ID: <1beb8099-3c41-4269-9346-f7cb994db5ac@linaro.org>
Date: Tue, 17 Dec 2024 10:46:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/32] tests/functional: drop 'tesseract_available'
 helper
To: qemu-devel@nongnu.org
References: <20241217155953.3950506-1-berrange@redhat.com>
 <20241217155953.3950506-7-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241217155953.3950506-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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

On 12/17/24 09:59, Daniel P. Berrangé wrote:
> Platforms we target have new enough tesseract that it suffices to merely
> check if the binary exists.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/qemu_test/tesseract.py | 12 +-----------
>   tests/functional/test_m68k_nextcube.py  |  8 +++-----
>   2 files changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

