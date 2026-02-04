Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774C1E8B399
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 04:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnUWh-0005VM-7U; Tue, 03 Feb 2026 23:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUWf-0005VA-UN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:30:01 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnUWe-0004ne-FY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 23:30:01 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso2631608a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 20:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770179398; x=1770784198; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FgZQBzeB17i8aneSRU2yV5HB7PWMsSsPjMBm7sJEyfI=;
 b=r5BD8i3YioD3G243xNcPYm3ic+dBvoXimfdyr6OOlDJbrocpYgULX+qtFs8MsVJQd/
 84RnzvwPGEoLMrCrKhz4xuZPbY5BC+zlP1C2+BqeJxlrDggVMIURdbzHNJBUyjL+Hy0+
 R16c1q8Cq6SH8poCbmhpD0V7v8KDoVg7+DlT3OorBuXslIo69LJbnPLLUKBQn+GIM2D6
 1rJMRVVP4kqrU+HgvppMT1q7dVVauFZ/AVu4eK/EYOaGdec8xmDWpBy7Rf+KbbqxiGw1
 f0Vjj8uVO9T9Ke4r9rPv0Zrj/qA3oKfBU/WI7pNyLsVMtwhasl2K1Ps9NXqiFbxp4dGT
 NUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770179398; x=1770784198;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FgZQBzeB17i8aneSRU2yV5HB7PWMsSsPjMBm7sJEyfI=;
 b=bkod6Lw7B8cqnNt9v3KgGB5HnmYxEOi1U1KV3QGELgxRbM7eKZN1l86UG7u4ie0UTs
 +cSRzH3oM5+cVVNfxxD9k/DilvADAT1s60ChTZTn1nS3idVwtGwsJoqQSei+NxEKYMp/
 QWm5nWFPhK1YOmUpibfuYBaErCxr1/6a0k/XauRjh0A/eNdf0jb4AtNJORROVKtrMosc
 ijDfj1W8Ys3KfeJTf512r+EtPHImOGPrTqoZViYsmF38ZOCQ75A5zoKz+fHrsFGflC8A
 pBcg4e3n4SO+t0qR3mscxnBT6CEe6nKjuNCpzLM8PzHijCoSvLswphwao2JE7lZHgXSE
 XBuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvYwww+iLoQkzc0WjF8Rq09BohGcr//k6Ay9y1mb1UWEWACS8Shm5WaBd0ldZox2s/g8y1ypqwjFSI@nongnu.org
X-Gm-Message-State: AOJu0Yx0ZFw/bQLogVa47KZMmlHIZ/DZxBSMSwhpdrTbGkgi4uL1hyYH
 tC5/ROHNrr8K3lPpaYnbV5GUdk6j0HLSYTr3txXxqxnzJo/W+YByu5J2MBPXQZEBsdVwY7Heofd
 m2raUpjM=
X-Gm-Gg: AZuq6aI5lwwMXYAzg/2ZDxYwCXofGR7b5dRoVOpqvE8jduGf5dqOJgisS41LP80MoUH
 00kEcB0dzASDzWftBg5e8U/fwkWLQtkzzlwkhCd4onqUHWRMUxQvs2DyI/94aIDf9E3pQLOUD8E
 zUpdLPiPeobP3Bv9q7JMdBpaYegDFahqfXJQmCCgMa15B+3w7ih5h8fiK8PVDt1Nxmn0KjBHGui
 yLIObpZCI9pBFGi2R2oe/Nfapuug+9XjSYFr0bea2AL9zZ++T4wxXA6p2TncizHs5Udmweu5oVd
 0TkzAh3WCnnq7/wZbP2DDe+ofe/nEEzQ4+vYEp50Ow2V0Bg6azGHN7pRCviGayW6Znuk4rHCHoL
 dHdT3TgHmhbZgon9xhjioOmeAbAYO41hOF1TnE9+bJREbP2TlIGCDojRTWHa+a9mbesYgk/+yQ/
 SkFwsCEwtRo5zQiMlSS3DPlpOj9+CQF+fMhvKntbUxaEkdq8g+p07mhCCcl8o+2nNNnUzMotKPL
 7XagiwtvT7CZJ1tnvk2EPN8JLIAD4GcMCytj+MFM+99CA8=
X-Received: by 2002:a17:90b:568e:b0:354:83c1:9efc with SMTP id
 98e67ed59e1d1-354871948b3mr1397096a91.19.1770179398013; 
 Tue, 03 Feb 2026 20:29:58 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1155554a91.12.2026.02.03.20.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 20:29:57 -0800 (PST)
Message-ID: <21e95344-cd34-49be-a3b4-77eaa86e3406@linaro.org>
Date: Wed, 4 Feb 2026 14:29:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] gdbstub: extract stop reply message construction
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203115201.2387721-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 2/3/26 21:51, Alex Bennée wrote:
> The stop reply message we send can include a lot of extra information
> and a bunch is mode dependant. Extract the construction into a helper
> and add specialised versions for system and user mode.
> 
> The correct response for system mode should be of the form:
> 
>    T05core:N;
> 
> Where N is the core ID.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   gdbstub/internals.h |  7 +++++++
>   gdbstub/gdbstub.c   | 15 ++++++---------
>   gdbstub/system.c    | 11 +++++++++++
>   gdbstub/user.c      | 12 ++++++++++++
>   4 files changed, 36 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

