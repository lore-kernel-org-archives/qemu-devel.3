Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F125AC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtbW-0002Ya-F1; Mon, 21 Jul 2025 12:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udtae-0007Da-NL
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:42:13 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udtac-0004Mo-AW
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:42:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso3910790b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753116129; x=1753720929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zmJPQjHLHknSa5OKOtJR5fqkEuCteGRxB8ltVr9bd/U=;
 b=NbGxkoYOFyMmPTF8Lu0NilNE2ges9E+LJooLX6l4BynZZErxMr6x6FtpHpaMw4tff1
 k5CFPxVdTV7FaIb4kDoZJM7Loo8AMMBSojuXoyy46zJn6DyV+7ZK/ZRTCLHt+eoSpXQ+
 m7q2Zt5XE+geEu2/UFZKLMm5xfpM2wej7uRYzhYJpLA0GudOEmzgwQ5+vT5Aoyo5NndS
 hGx6+Yk+PKv9kFSbLb+O1pgqMbMDJjlizHkmb/8UZqSBpoL3UFx1yADlun9GcKPeIUGl
 l9+w+l71UxYp4hLmv4cEhDnwcmU9F6OSnB1ZaPYYW5mbNVUjLbrAUQsujBSfK2UlYfTt
 BFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753116129; x=1753720929;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmJPQjHLHknSa5OKOtJR5fqkEuCteGRxB8ltVr9bd/U=;
 b=wA1gPw5E67REJT4+ipbZ0rqFZKRGtFRifbjj50IqJ1TE+7CaQkB8WGn/ToGGMqGIv6
 om+mtTRxXoCCZvYhXs83w+8GN49FvxVEnZjs8tFmiDT/9cJwdHQrbTP2jcJOj4h0AACI
 erS4sN5ZDISEa8DS4HrYWfvOo/FjYux+CBzNTJWh90/NMyLKqo2Utp8eTGbKurD4oCHp
 TRB79/le0mIJ1yNFEEsWwrpJt+XftyXAQayOvoxNzQjqFYc4V1M4MZ7mfvHWi0dMQlHI
 wiH1gmobogMjVDniVxGXn2mM78F+//yktD5BhU1nKzHqg9zxjJ6Plkw5XuOQdts4iyCC
 hc0g==
X-Gm-Message-State: AOJu0Yw7Gc+GE7jdXANKCEU1fIy4YmPOhn0j0ruzpXw0namJ5iM7Sz+f
 CH30+6I1Il6f5cgq9SznvvKeMRQrul+RVCIujEeTNfe1GNjYjYz3GK85Qy25J3ULgPtTlTpHQ+3
 c1I+b
X-Gm-Gg: ASbGncvY8CayM1cCTklDnxZjeWdiXdI9ZsxXMLt7jf7i9ku7KWxeLKVOl62IZNvUrc0
 p7YD94/E76g1uRX7eY2fX2wBLAynoPgLYBfMjbKOEn9Ioyor3ElthmHMy+lGNV0FtGqfHy8VQOp
 xYQoh1q+yvFGZMWGRhpkKCWg6sBZp/ICotugqv/S9mCfCDbOGaiYnQ06q42bt3nc2PUcNeRYW42
 UzlkA00uJrQx1+2oYJokxKaHB2rZxdTMHNT0Cn3TANuIdlTpP0LLxh9jmHGtlLRQbfW91GPAOyN
 db7drQM5AXcaLIAbS5Sxy+RaHEf1CdXfngGb76xq3oWhZ+EQ7KIdZSLKGokYAPBeUdopGjEtZ5z
 1Rj85NWSxTIqIk5SlAL6h1JxZRpb6FXKOBW4=
X-Google-Smtp-Source: AGHT+IG5XDNg+WUX9eiqFN8FyjQc3uEDfPyYQL0XC4JUeuW7tV789KaLlfxYpsj24O1aofz1D2DUrQ==
X-Received: by 2002:a05:6a00:21d4:b0:74e:a560:dd23 with SMTP id
 d2e1a72fcca58-757248722c6mr28840862b3a.21.1753116128589; 
 Mon, 21 Jul 2025 09:42:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb678f21sm6093595b3a.104.2025.07.21.09.42.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 09:42:08 -0700 (PDT)
Message-ID: <f0fec739-f543-47e3-a6d7-bb462c364923@linaro.org>
Date: Mon, 21 Jul 2025 09:42:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] control guest time using a dilation factor
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 peter.maydell@linaro.org, philmd@linaro.org
References: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250628002431.41823-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/27/25 5:24 PM, Pierrick Bouvier wrote:
> Depending on host cpu speed, and QEMU optimization level, it may sometimes be
> needed to slow or accelerate time guest is perceiving. A common scenario is
> hitting a timeout during a boot process, because some operations were not
> finished on time.
> 
> An existing solution for that is -icount shift=X, with low values, which will
> roughly map virtual time to how many instructions were executed.
> 
> This series introduces another approach, based on faking host time returned to
> the guest, by applying a time-dilation factor. Time will go slower/faster for
> the guest, without impacting QEMU emulation speed.
> 
> It may eventually be used to fix some of the timeouts we hit in CI, by slowing
> down time in VM, to be less sensitive to varying cpu performance.
> 
> v2
> --
> 
> In review, Paolo mentioned timers deadline should redilated in the other
> direction. After going through this part, it seems that arrival is always based
> on one of the clocks we have (which is dilated already), so I don't think we
> should redilate that, as this would create a discordance between time set, and
> real time when this happen. Feel free to correct me if this is wrong.
> 
> - keep start time per clock and apply accordingly
> - apply time dilation for cpu_get_host_ticks as well
> - use a default factor of 1.0
> - rename cli option to -rtc speed-factor
> - forbid to use option with kvm, as time is not provided by QEMU for guest
> 
> Pierrick Bouvier (2):
>    qemu/timer: introduce time dilation factor
>    system/rtc: introduce -rtc speed-factor option
> 
>   include/qemu/timer.h     | 60 ++++++++++++++++++++++++++++------------
>   system/rtc.c             | 11 ++++++++
>   system/vl.c              |  9 ++++++
>   util/qemu-timer-common.c |  7 +++++
>   qemu-options.hx          |  7 ++++-
>   5 files changed, 75 insertions(+), 19 deletions(-)
> 

Another ping on this series.
Paolo, do you have any opinion about the comment in v2 I added in the 
cover letter? Especially to not modify the arrival date for timers.

Thanks,
Pierrick

