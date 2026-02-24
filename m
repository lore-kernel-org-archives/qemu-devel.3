Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B147F4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy0s-0005Bk-54; Tue, 24 Feb 2026 14:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy0n-0005BA-MV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:24:01 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy0k-00076o-US
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:24:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2aae4816912so40924745ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961033; x=1772565833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w9DCFgZvgaQj0c8LldvL0MBbBGlu4vW2aSWbuBovBUs=;
 b=I53dqNv8z7eqOFftKD67csps7ZFBgAAEifLeDzunr0uZ6zG4GqML4VCfwj5LxgX96o
 mOmmdekhJtz9x+M/uAprchEnvKYUw418hdPp/lNWEGQHyeqTcVcWyYrA4zzuMJ1zu5PM
 oRsSmohioOxp9Lc/k45HezjHT7Jex+in1bECauAspXeWT/Cz2Na5xp62xw6WcQBZNlqf
 XPA8oUtvtUcG0HyGHJGJN1FzERXrwK9VwGuNRnPSNimbkRSVf5OUHgWECQ9kfA2hQ+zC
 THhf/tmZJvCL+r9XtL+Ur7IA2ntc07NEFMYxHYwLqgSr5mEoYTo1XaJY96zX+W+p2BR7
 nFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961033; x=1772565833;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9DCFgZvgaQj0c8LldvL0MBbBGlu4vW2aSWbuBovBUs=;
 b=eLVdDeiu1znHIXwKMBqWv66CpMvhWytRiHUA6PG7+cXfgzR32liKxz2AXPDYu13ClQ
 Daalfuc43BaYp6/VROl2niYdGmK9PlkjFlfxHxS0zjTv/H6JOnaVebU73q7lZcj5Ugo2
 96zHBNNj0UfPdUpy5e2dh7wFHAnYcdkbVuSKjmlPV8JBelVlsS0nQfSu7JCijJEKLaBl
 P6p/UH92iLasAGUloNMJ/556R8heZSb+Gv9f2FB7HhNSFQL9vnYIw1qc2ZB4sTuyPGz1
 5Npr26/0B09xxvZd1S+5Xf/MtMXb2otaC7Zb82RC6W/HYj6u8eDWBXSPhP7eE4qAxyuv
 Q9kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWAJ+yYGXJlAGRZ9nrBNyYIJdk6V+zcdr5qjnvJ8VkK6Xc0aInSn7PAP/Fo40rIjF52ugrl6Q5WBuY@nongnu.org
X-Gm-Message-State: AOJu0YzA4q3b6//ELREaQ/gED4l3MaP9kqkfzzgfU8r1OtOy1VNnTscu
 R69r0gSBuVAy35kIpgKn6oYxrQ0WBsU1j8yaqH0RZp0Kz85vANKiyU/FEXLmWzsODDs=
X-Gm-Gg: ATEYQzxzC0mByD1fc5xdlV9BtqZ7khdOLotIyLnxu2zqVAQhwS7E+e9H8xgBGuAnmn7
 iRD+PsxcepvkKGRkuSSNBOnqf7rGzDglQ3/MFl5xSYUYWC2FVpHh3CRFbG0VVqi6WU70q85aUZc
 bAGduabMLaRMEtsglMCLGu1iQC1dC5lfnbeuIM1e9AOeAjc24h2I75L6hmKBCaaNknMasQxrSKD
 4zFJl7s6UdCJ26J/t9BY8a1hA29Mc1pTcegMbd392m1K0B2igcxkL42oF+SmO8Egw/nT8E7WLG8
 5kAp54U/xZPc9AeDHVNQsXJvDfUPpf0KEPVkD6mGl1zPvcgMTIs9WlIGPtTVSn7rW/vNDD1suYh
 +coWM8+xAsg3hqL66Y1+MiwhVQrcUh/XEPIb5De6FZ1/W/E+kIBHj2c8n5OiuT3CnVrCu09ZjNN
 BUG7Y2+ju9Wha+f3Dx4oviArgF9Cu9uZ1XD5n7EQrv5zaPMjBBqvtAS4FXDaKfaZfNtcGu
X-Received: by 2002:a17:903:9cc:b0:2ad:b97b:be88 with SMTP id
 d9443c01a7336-2adb97bc2ecmr15670105ad.32.1771961032642; 
 Tue, 24 Feb 2026 11:23:52 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75173903sm108444195ad.81.2026.02.24.11.23.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:23:52 -0800 (PST)
Message-ID: <42588a53-5f23-41da-966e-f6e2c2568162@linaro.org>
Date: Tue, 24 Feb 2026 11:23:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/acpi: Move acpi_send_event() function out of
 acpi_interface.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-3-philmd@linaro.org>
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
In-Reply-To: <20260224182017.99865-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/24/26 10:20 AM, Philippe Mathieu-Daudé wrote:
> acpi_interface.c should only register QOM interfaces. Move
> the acpi_send_event() function to core.c with the other
> event handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/acpi/acpi_interface.c |  9 ---------
>   hw/acpi/core.c           | 10 ++++++++++
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 

Should you move the function declaration to hw/acpi/acpi.h in this case?
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

