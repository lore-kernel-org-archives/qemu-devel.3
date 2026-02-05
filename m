Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E82E8B394
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 05:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnrtF-0003nj-AA; Thu, 05 Feb 2026 00:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnrtE-0003n9-5B
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 00:26:52 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnrt3-00071I-9i
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 00:26:51 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so446018b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 21:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770269029; x=1770873829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F097Q0+npWaHE6vxXwxTy3fwQCPXDeAdrbjRdO0FE2Q=;
 b=Xo1HhngFaCwx7DE58heZhG36oYMFbVreGIUEaLUnGxH84vH8LtpUKHGw8Brr1nU7Wu
 7bFtWOo+uFq5Oopn3vDCx5Vlom6I+BSpo764XqXvtcjYaMkWEF2Qhn87MQL5SN/OE1qp
 L7B4YPtRbmie5+79BOHC1hbSEMgj6m7bxIxqidk2S7BuFrHwxq5XNf5sd0SphhSm7rOH
 CowuBCJTPXVGBwDI6FVhghZ1ZTgGs0E9LinkAuPCtIMR0R1ASlHyq/4TK2V/BU28jeAs
 rY0hmyoWNXNufGqGXHIHMdy2qyKZdsIv1uCD7rfB9DEW1PLfkaTejfGTaqvtnJKy2ReW
 TDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770269029; x=1770873829;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F097Q0+npWaHE6vxXwxTy3fwQCPXDeAdrbjRdO0FE2Q=;
 b=MXjBf20M2YiqtYbPr4QAp1QpA6uqptTKtk05RlJSef2xbvzyD2zK/YYyHXHIh03Vit
 TDQqZU8771SnszkKu+1hel3dFJ/XtcqD4RvqU/VXveSU3MBx/rR46CI3E/5zCJWaLSJH
 uuonQrm2mVNptaU40qnhpyIQaCr7K0zGmUjnWg36ZyayYCQQC3gUFcSCirITqRWlqPzl
 RNZhMR6y1ksOkpiY4mPeH5SB+VwILbZPO4f+MUusa+eCOxfWMnBvscqEN7dTIb5fh0ED
 IqDDAAe3E+2wR7VlgbrsKZg3jVqkpE6nYF38HZeQJa5+/xFUiPfGMzPr7su3WQyKsdhN
 DHig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeGsC6OwYN0ancS3e6nO670nZ2o/Q+i1/R0yRNUUrpgVUMFqf2ZjcboQajEJjmxBie6lW1AbYelZYu@nongnu.org
X-Gm-Message-State: AOJu0YyJOI5bRIh664YZ4G2699XUz0KARLjkQLloiyqF/WwCkKBOcczq
 GRtqhOm//LtLKK7lm2W1BK76hA/FJmrRm5l5wsJcFynUWRXoDLkocM9HNZwNesSQg7U=
X-Gm-Gg: AZuq6aK9i/kKdeAzem/wvC54enhpMMqfN0l7uJZjhaIoYL58eFfKH/lnPXECrpWg+ho
 KwZQtoDSOgx2fIyRyfADMa461Wqsv0ZcU+UeG1ZIGkko0DrwTS0tZ/WjYaiGSD+EG2uxzrmViXX
 yguRJuJ9bTnA+XIyBK/Tsy/pXFJyd6FwMobYzenBxXXH49e3ihbUbtuNOUkmcP/GYYJuYXanQ/N
 yBlSebYk6CDY7tamzwnrmlAbCE7hCPgn/ySlam6+2vVadpZDKWmoun+nMhc7AsDOWQpRFZu5atr
 pU3q4P5edD+6AgtMrEIymjKEVHtjHGtKLMiyPteSDDnpYMrCgXi1ygN8WhT04M0AffOhKGfsWzY
 n4EXeOBC6AcekLhCV3h2H81NM4lwwFA3JAW6vNUwzNTS8S6JGFjlQ/KyiYi6LbTaKmMqSB+mhCe
 7eFJ/es5YTJn5fr3Qm8tN7038WjkOa1PXL4winkeLhDsj0Rn+24J0LuYGVz4cmukQSvOI=
X-Received: by 2002:a05:6a00:3e01:b0:823:5270:ef48 with SMTP id
 d2e1a72fcca58-8241c5f4a99mr5181140b3a.33.1770269029071; 
 Wed, 04 Feb 2026 21:23:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d16401esm4444293b3a.4.2026.02.04.21.23.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 21:23:48 -0800 (PST)
Message-ID: <7802106f-7221-44af-aec3-b9283bb42ef5@linaro.org>
Date: Wed, 4 Feb 2026 21:23:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] meson: Add TARGET_ARCH to config_target_data
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-3-richard.henderson@linaro.org>
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
In-Reply-To: <20260205030617.266625-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 2/4/26 7:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

