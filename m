Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727CED4A5F4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 08:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhkCs-0007lI-PK; Mon, 19 Jan 2026 03:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhkCq-0007jP-58
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:01:48 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhkCo-0006O0-Fc
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 03:01:47 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso23391325ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 00:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768809704; x=1769414504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uuWAehcqaKWCczrmhFYz6Ttq4kLDp3Wwx7ZZ/wvFvZE=;
 b=S0Mc2H6ltWg0hqhQNg0rQI0wrEukAxjN3w91NlGo0XH3H5CzrFe5KMerF65DE7cCXA
 z1hqyY7PfZK0uSREQ1oRWojSqnA6/BvtqGPOwZOB8A+l0dXgZqonyFDHpzguxfsBuQ7y
 Qw90hFKLmT4mDG8Az2XaZpsiSo0ggSnyS/n+pqB7h9CzNtlsVyekNaWk+71umptYCgua
 spz+zjMW0OzM9+2HMba4hERlaAOQTfodmDLFY9JAdTLRAjC6CjE3jykblrigtuw+OFV7
 DoD0SPfzpGNdztYELgJNnMmH6TUdSXmhd+BH3HityXaEJnR2qbWyc8NQeYuj0ldnrVEU
 V2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768809704; x=1769414504;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuWAehcqaKWCczrmhFYz6Ttq4kLDp3Wwx7ZZ/wvFvZE=;
 b=UeMqNzvb9lCJsWEiIyO1EcG3gbkqInn/wCALi/mMyr//NjPjCD5Y+3H5Ps0oVsjLgS
 L/xh7FgLD7MmdSgbln4yEy4++S9lTFk5ZktohFUJ/VykiT2sYQpYEVRXPuoq8l5rWu6S
 FWi2ciiIC8eGNLFYSwNCFU/oVbYsen2AyoF4soqgtXdfkKrcl/aKAst3ir3lFnGf9qBn
 HD1azfvOZTpSOFZdr30V3uHxDZFjPr+OHXJ86UjpU0pQrDAjRQTFYCQi3n0M8k6CF62F
 hzTV+N23RtX61kf9A38GDK+3meiGGcCIf24ekIuywoAZl6HC35DSSvnIqvDZFEOufG2p
 uVjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWajAPJ6BDA5zpQXqhHEdGnI9F44PuKY9UGxfO4iJpK7ROIwkrZbVGkkGlE9XAtSs19VbNGEoPPnzew@nongnu.org
X-Gm-Message-State: AOJu0YxnsqR33LPj5OIbClrJFriQU/WLH4O8GeMeqTnooRY1SIJqPGBS
 MJ6blxwyrK4StItZ8dTQZ1tHxwl54w7obYFPqMftAKWkMDCN/F7hUJNqeIWcv7bQ5mg=
X-Gm-Gg: AZuq6aJtR664r/4ZtRfRj4q4MZUvhWR+U7cM4MHke/QUL5CBAsF5mokBxWCqI0/Q+h/
 HVcewPPbr60bpxqOQkIuoh3iq+AxfXYwrcuVfceKaC5La2S2IVF5mhFizkaEiQDvVf5Kk+3eBJI
 wH5yykOL9oGsCGGpzV2VQ5NMWu2sQbx0Cqo7s4l3SIQ7CXkYemeZKxu/wYQTCjyjvoR6n9peEsS
 OcKuJG+M7WVGu6fcf2aXv+HGiL8T9xEoOznNdgyTv8ayrnECS8fQxB9DeqvTayxnlLCl1AoaXl+
 wADEbhBGhK8OJFiiIktrxHl3rmUXGJnbPIhM0vjhlxGguxi2VkjD3YVG3GNuaTAk1I52LtdZdrn
 LdGQyaaQ6PpOSTsxUMapVjG1vMdYK5m4wd4Zx7BHIzP5k3Y+hE+bxFTh036S0Tp23KqpFPpumr0
 hRlFMTiBQDc+9RU1CJdMNWUr8CuOQWeLmkvTiWOqEiPALrqWH2cbpdGTwZ
X-Received: by 2002:a17:90b:5545:b0:340:5c27:a096 with SMTP id
 98e67ed59e1d1-35272ef6b15mr8338174a91.6.1768809704188; 
 Mon, 19 Jan 2026 00:01:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352678c6a10sm10788444a91.15.2026.01.19.00.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 00:01:43 -0800 (PST)
Message-ID: <f2a27e86-8044-4ae0-ba3e-afa1becf4db8@linaro.org>
Date: Mon, 19 Jan 2026 00:01:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 07/54] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
 <20260118220414.8177-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260118220414.8177-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x641.google.com
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

On 1/18/26 2:03 PM, Richard Henderson wrote:
> The target test is TARGET_I386, not __i386__.
> 
> Cc: Kyle Evans <kevans@freebsd.org>
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/syscall_defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> index 52f84d5dd1..c49be32bdc 100644
> --- a/bsd-user/syscall_defs.h
> +++ b/bsd-user/syscall_defs.h
> @@ -247,7 +247,7 @@ struct target_freebsd11_stat {
>       unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
>   } __packed;
>   
> -#if defined(__i386__)
> +#if defined(TARGET_I386)
>   #define TARGET_HAS_STAT_TIME_T_EXT       1
>   #endif
>   

This commit brings a regression, this patch fixes it:
https://lore.kernel.org/qemu-devel/20260119075738.712207-1-pierrick.bouvier@linaro.org/T/#u

@Michael, the current patch is a good candidate for stable, but it has 
to come with the fix also, or it will be a regression.

Regards,
Pierrick

