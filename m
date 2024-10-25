Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FB0D0C600
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 11:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4IuB-0007iS-1w; Fri, 25 Oct 2024 07:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Iu8-0007i3-2j
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:54:56 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Iu6-0003rW-19
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:54:55 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539983beb19so2490044e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 04:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729857292; x=1730462092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gV0weLqdYjYguMdfnEZHguqNLd9J0cbVHGY9mtum1P4=;
 b=tqgNfT2OigpivR2UuBBsHIOR9v3ONHqa73OTDthU/hgetoqL68c0EgQJ9rG0WrCIdY
 l97KFJzSzwbQ01Z6QoEHLRGSFgKRvV+tL+N4W/KFu6s4do3jhdUYbIM8sIV8KkJttFVO
 +iUNQ23PNjrZIDnNvnFvrbvoeJIgsYKK1QyqDEQqjD+VmaXAFiCojVf5qypue7SGzaW+
 vPGET0YcooGml+cciei8BlqviMAAxMy1155uZnjE/9MZgcVhoiXCV/zS6PbT7SrTPL6e
 9+r5yi5gZi8x4shq9ZKPfzE5QKjTtz3B74tbhXcxDTEz5vLmQkjc63hc3KrZX4qhA8wI
 13lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729857292; x=1730462092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gV0weLqdYjYguMdfnEZHguqNLd9J0cbVHGY9mtum1P4=;
 b=vNxy89pCUitCRROkzPMMQiZsGn26kIAOqCiOmBayzTBcJp/htxnHOYf90UXSrkmpUm
 lgoRStb4j/KURKyZY8aekKOJvIQ514mUedYVigP1qh6WzdWrT/WzBNLxf6aJzcfM+59R
 uvRjTz2uoE/XCATeRIploXsvFCHctu+gwbsT6riC4n02pURneyLBJNajpnGN9KYp3fb0
 a9ZALSiSPraYf+erdvj28b5s/CqSEWf6CfS/4ZgguhWPn7UpVReBq+wW62vUqk4NVL6y
 KXHuNOgbZKn1Nzxm/HHfrt7gUoXLIiPWPsRMSACeiMP6pjOeCc1xa+/XKCfmjJfaj0qH
 bSRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYrVJpe9T/I1zxmAWjoyEGLofdKatvGRImYffpQWWmgC0Ge7CZhsiXv3k9WvfNugQin3svU+N1C21+@nongnu.org
X-Gm-Message-State: AOJu0YxA687lGdq1KitUonYZ049AQN/elyCzeTpFRI3w5wxbY9aLCNgm
 IN+MuMwjKoSkt9FyUOHlHUHVtSAkUIJnPEVk/PO3GKuM9aq/OS+azH538Iok37k=
X-Google-Smtp-Source: AGHT+IFfvicRStwgbW6AwNYtv8DFcBKvlKFoWa/WDxPY6pDzI7Cw4e7CJ+6AGwdqtV0N5yzLRskPnQ==
X-Received: by 2002:a05:6512:239d:b0:53a:d8b:95c0 with SMTP id
 2adb3069b0e04-53b1a32c66amr5856745e87.30.1729857291942; 
 Fri, 25 Oct 2024 04:54:51 -0700 (PDT)
Received: from [192.168.200.153] ([185.201.60.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193573ce2sm15832995e9.10.2024.10.25.04.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 04:54:50 -0700 (PDT)
Message-ID: <da5c449f-5226-4894-91a1-867d61d05778@linaro.org>
Date: Fri, 25 Oct 2024 12:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpu: ensure we don't call start_exclusive from
 cpu_exec
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
 <20241023222026.1430014-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023222026.1430014-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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

On 10/23/24 23:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   cpu-common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/cpu-common.c b/cpu-common.c
> index 6b262233a3b..c979138fce9 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -194,6 +194,9 @@ void start_exclusive(void)
>       CPUState *other_cpu;
>       int running_cpus;
>   
> +    /* Ensure we are not running, or start_exclusive will be blocked. */
> +    g_assert(!current_cpu || !current_cpu->running);
> +
>       if (current_cpu->exclusive_context_count) {
>           current_cpu->exclusive_context_count++;
>           return;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

