Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D99FDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2Yj-0007q6-4x; Thu, 23 Apr 2026 18:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Yh-0007pJ-KB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:30:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2Ye-0002lu-DX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:30:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso33220695ad.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776983402; x=1777588202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a9yf2bdZlrlEqK426BBr4P79p8ux3CYHJhDpa7YxTZA=;
 b=hNaP5KqY0wK/XT1OdSR3f0heZqHt3uaqBSe1gUEOArYggL06gCW+obRihX57ZCEePf
 fhWksnX2HLGSumwwEXjM5HPih+YvM7MSvzVQV0QRdeyx0ltCAUDZ5prxLFIen2lqEWwx
 3r1oQlQMtZIuTVeYtyqFct7ImmROD2Rw5NDWZcQjvyw0CYWVKXFNPQMIXAmiB1pa5ysS
 eOk7/tczri6aWCbAa6UCf4icjVnvK31hvwelXYWoV2+I9bZysDQZTHhAiQMHAnqgFg0D
 O4dW2CmdKwmPu3oRs+gDWWwsp1ZsxYy7KulylDhPlUS23fy5i2v9j04mFMIUWvtCY5Pq
 1h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776983402; x=1777588202;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9yf2bdZlrlEqK426BBr4P79p8ux3CYHJhDpa7YxTZA=;
 b=dlSrWR68wMogjWjc5wPiyK6h0ksgJ8VMuFzbC68gA8sTXDxuvV/N4aXcKBQeN0DhNv
 /FUiYzHPWRbmfrpvi0F4lrnKBw5aL5MGFGTF0rYDo6FZXid5b3XvVkr4CWd5qF99GDW8
 c+TdBdQpoo9tMbD/jWd2AEIxsQB2MxexAkjvqOfoUCpBHQgmfDkezWZQ/VMzO8SAQPOc
 0p25LU1fZ8qZ5obFZL0Eeaka4a9ghHuFqlwKQaGN4q+ArRSQKvPx08fb84yD1pbOo0du
 7OTLtWCNq8q71Rv3z7gxtTFg+dYre1a+Hiw5HCDZDy+RVj17biedd5DKHE1MFGUBqfBg
 X1Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qR9CpAhhZDtMOzxILCuR3chIBKq62xeurKEYx0/lHgkSM+ZlMbZ9EhJsHXWSeCc1n8HgRF4SPK0jx@nongnu.org
X-Gm-Message-State: AOJu0YzbCbFO5OYU46uwywJbiu8VMuKzWFfXfVz6tk2bhRop6YjQgY9y
 sPE7JdoSaHAsya03NFG+qRY0dEimxBjED3ZTMwM3w3qLFhJBQdn8pgYTekAD6wRmsHQ=
X-Gm-Gg: AeBDietKqZKMbLtV4WW9jarrpQDtDkZ4TlrgRisKdMTJlTiEmgBDuyppN6GaoEFIG0Y
 +cm1hz3R49AiptL9n8x+uUpIj7YLUI/TzbWt/dwsZi5fC1VhM0JSxU8V9YWKWEVs6TZWabiK1Xt
 ZCt7SVkaEUk+mRIezD7h7nEvJvnqADnbgcrjwvlQqGZ9wOhAoMWWvdw9w16GsLhQgnE/Khfhj5H
 wnoSdezPSu8bcsuUvkgf3G/NbEk50aH1XvacmGmAe7Jgp+W5Dj/5i2E0QGrFBwVBW283qugK5rV
 OyAUqCWPHQilYOGozpc0g5dcElsG/S1w0fZoDAbSsmS+rLh86caUk5wXNwLoJpcAElFmR+DAUlW
 GvGnKtgUSnBPgvb+XKU2UJQdcYBlVdCJvZZyfxk+irpGnJRu2hECee16zdzq9TjBsyjKmjgov8F
 P3mfHc/7zlcgkESZN49QH0pweokWwgRw4AjJJf0fPvIyq/VHtxtw==
X-Received: by 2002:a17:903:2ac4:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2b5f9f3c616mr298137805ad.23.1776983402197; 
 Thu, 23 Apr 2026 15:30:02 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa3073asm195590255ad.27.2026.04.23.15.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:30:01 -0700 (PDT)
Message-ID: <be4bb8ad-9cc8-4c8f-b228-70344c1a1435@linaro.org>
Date: Fri, 24 Apr 2026 08:29:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] hw/core/cpu: Expose CPUState::start_powered_off
 docstring
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
> The comment about @start_powered_off is buried within the
> CPUState structure. Hoist it to the structure docstring
> comment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 04e1f970caf..bc719d51b3a 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -419,6 +419,7 @@ struct qemu_work_item;
>    *   QOM parent.
>    *   Under TCG this value is propagated to @tcg_cflags.
>    *   See TranslationBlock::TCG CF_CLUSTER_MASK.
> + * @start_powered_off: Indicates whether the CPU starts in powered-off state.
>    * @tcg_cflags: Pre-computed cflags for this cpu.
>    * @nr_threads: Number of threads within this CPU core.
>    * @thread: Host thread details, only live once @created is #true
> @@ -502,7 +503,6 @@ struct CPUState {
>       bool stop;
>       bool stopped;
>   
> -    /* Should CPU start in powered-off state? */
>       bool start_powered_off;
>   
>       bool unplug;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

