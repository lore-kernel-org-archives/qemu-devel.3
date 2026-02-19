Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40E0C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBRp-0006bb-Gs; Thu, 19 Feb 2026 16:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRc-0006Ty-Oz
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:22 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBRZ-0006s4-5t
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:20:19 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-824a9348603so593906b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536016; x=1772140816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLfes2inW8UYSVTfyhUUpA00ZFt63tX+7s84/MqRwtk=;
 b=XSYD6siPIdhrcnrMzUhCFJUqAHYZAAt5vyjaB0LsfbXGAXB/DMu5rLvxkPipAMHX+7
 W3OTIgI+sNlBhERh0YegQtXaENxk/D2ifjR3P/eDE1S9sG7v0rh0LPsrTyIZ93LZspMp
 4yN3BfIxv0V4NSFpkz33zYe2T5nhIr4Q/bflpD1nR1GFThYSZd61bhXT6ffmD9/m+0fs
 BYu0rfLOg+tE4RsJH4teYXw8cN7rRtoku6DYwbDU8dYQXbitxpNbzjeyGv1T9d7aUhRs
 ATjCfLaZMJL+P1MkiCwluUT5E0A425dghtMFCR7CxmdFOpyPtgOkAmY7GkMuzkYiUIj1
 qNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536016; x=1772140816;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLfes2inW8UYSVTfyhUUpA00ZFt63tX+7s84/MqRwtk=;
 b=sSiUWe7fxBFElGokAoD44sJXBJPXdB6NMrPJkyLPsCCCOWB4i+zt9P6CA+pKT6dCIG
 CJlh1VW0Ixu24syMsrEje8rmRUZlmcTwnTtpsltngeKITSSTvdoSD9mOEF6lFO7hWsZl
 x8PMq0SNJ6BgquAQRrPgBEQ+MZPm6QJ3BkTWfIds4b7HjO5FUWKrOz5izsohOPYUqKtP
 TceZMVRmanbPyFdAUAr2VLTmzuxLJhY9iiU+49dDe0Pff/FOM5SUfqy68bhHS6X6gda5
 dYz55jRkTs5H7HendaWr1efGV+PW9vCYGYtY9kACD6A5Il5wmH8H/W6GO3tjxhBSmKRi
 AzWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIr4WrhX5PXLBMoCSdG3gE3Iz/7Rnw6bq3M+UoGXluBEJtvnsSWXMDNEFNxk2K+Rdl0ukp9k2v3eQm@nongnu.org
X-Gm-Message-State: AOJu0YwC2glcem0T/RD0nUFEIjRvWbgSrGIh9Q/XAEKDJb4l0uSzRkmK
 Xgm2EgPq7Ft0b2+WD9x31/YMzGpuT4O/YHoNTUQTb7yUtfYtN3RGRVn7KA/fJgGC+FI=
X-Gm-Gg: AZuq6aKfa64gZYI8sWH/u7LN+LB0Rhd0BWqd+OIFJTP02dte3YgkieNy9yPoag4aql7
 2wAYQ9hXWXR9bIPhd8b67MfJeYVFjIVvXQtLLuKWrI2Vo8eGiRk+PZ5BxnBBnTbeD3zreHV8b4g
 hnnFr/r+RBFrS838yphXLjlktKO+y2VkO9dVAb9hb7a4N+AZ8NFgZ8vcEe0LNcv/YNqGFlDNBvs
 KTz+SkEjHfBto89+HeLZDdwPuYTxfIm+Gph05IM1CY9r0DfWsZRTK96wJWFVnKQ2XlS/wt0MWy6
 vye3QxBjUc942f8rG7Ig5Atb+R4kTXAK6ueLRGZdwpHrN1AHXEm89vUFeO+JGbBwAV6Zh9l43FB
 6sK7nBaHzzUAqfk+LQJ6tpkX4mjQ7lsPMH/ldVeG5VjhK2pu1gMx3R4MihVaB9ppautQg0rF99L
 SpiswGohnKjERGlA4Z/ZR7qvHrjK9rhiD8xxnFo9MkefIxEmaM53G2ip4BHZsBvZVNQIyCHfk84
 wiiA6w=
X-Received: by 2002:a05:6a00:92a6:b0:81f:be2a:56e4 with SMTP id
 d2e1a72fcca58-824c95dbe88mr17960706b3a.49.1771536015692; 
 Thu, 19 Feb 2026 13:20:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e936sm19782746b3a.6.2026.02.19.13.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:20:15 -0800 (PST)
Message-ID: <f77b4bbc-5c55-4bca-9106-52f0a8bf61bd@linaro.org>
Date: Thu, 19 Feb 2026 13:19:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/50] target/riscv: Remove empty target_monitor_defs()
 symbol
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-24-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
In-Reply-To: <20260219191955.83815-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Prefer the stub target_monitor_defs() symbol introduced in commit
> bf957284006 ("monitor: remove target-specific code from monitor.c").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/monitor.c | 13 -------------
>   1 file changed, 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

