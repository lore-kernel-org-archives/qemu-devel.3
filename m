Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C084FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf6E-0005sB-Dd; Mon, 09 Mar 2026 14:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzf6A-0005qB-MD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:12:58 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vzf68-0007yM-RE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:12:57 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8c6f21c2d81so1133033385a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773079976; x=1773684776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TSgcsDOULrbpLNw5NSsQKmQvmKzE9KsxsxkqM+QyGJM=;
 b=lugfOidwX6rWhKFZpvJpROhQWesxdydkK3vhcmkU0uxZUmRLkyqv24pfEQzfICer/5
 mGHyBW0oOqYBEqion8OsIFUf92BwX7W6a/8pgFjpuLWkI/TCyi9ukoWNpAEHbY1GQBVU
 feuE4Py+NH0qN/edmvsAoz4rFXS3PHWecCpAMthkTOSGWAkXX0B27VuV2Qi61dW7F+Pg
 gHdwFwtx1ZFgxksjJhw4b0qDbkvhE/5DNtJjQ9Zuei7BLRj4j1pcakxhP3nq5XFQ7E5M
 inuEEkfOBymBB0i/fvnL/hvN9XaehHHml6o/XQUvhL0TwtOQg9+3GHkRr3woFmSmrQw0
 i9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079976; x=1773684776;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSgcsDOULrbpLNw5NSsQKmQvmKzE9KsxsxkqM+QyGJM=;
 b=KdXK+1KdhBfprrtvXWWkpaV3Efn2+XNyM02tkHy0Do/vjKQo2JXZoPaYukNPn/f8FQ
 FUJhINee9S8v/RA5eT1DFhyN/QG08s+w7kl3RmWRcsiB0f/oP7y2S6wkln9hzZjgbU/L
 IIyKEOp35mKgG88X6FmeKAQPf9LDcmExOzcGiSBcGsMA3BMvnilPhss02Vn1yt17w6Kl
 Y0HLM55lJppy1tjyVHnn37eqEieJJUYq/EN5p/wjHswOp5ltyHILqVLqVxg3M4Zw4d4F
 JmOhxihiTz54EsPSrVOXgctiTAmEMSTLP4B+qvlayx809CbSRDiO2HWFROMynTeCNyFt
 16Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHhkxVAx3QOr0egCYhV66T865JdxnImCwPbQ+x3d5uQl7bBmrRxbcRLa4E09Yr1YD7CUfQkC3jQF1w@nongnu.org
X-Gm-Message-State: AOJu0YzAfObaD3S4Ppt+KAIJwpfciROA8Z95NkA21W/ZnlJigA7jzLTb
 94NXKXu3D4X09nQQh1E5XvCwRzVGyvrXj6w8pX31P1do+7E9qNGQ9i177T0h4LmDbLU=
X-Gm-Gg: ATEYQzyvq07wOfhpJcG0sYxypBJH0LalYDTjm7H9PxjowUHbl3Uy4n2gx0+pqL9gVOy
 Fh4qVCm8UThBPUAUOsYN9lBaTV5pbmPRvzzL+UCS7a/Vz3f46ljRQwDTsLsPcs/fAzjC1qiHU0R
 MysJjJA+Vf6qmdMRacSpTpmUm5FMHmPphZITL2+XrQSryRlYEpIQBzu7ze8d/hvYP8CMWJw4cVg
 SE8YFsk+rXUX+GDmqPzWhqKatKfZH0vQD9OGMW5IAwGFCotN2o6sLvsDChE6Wn5LD9VoMKj+4tk
 TIICceFpTtOG6FFrJtvTFNzjpDFpJnbm5CDSuFRXBBI1CqNEu1FJtCVjlmwAA8cvh0H3PEs9pe8
 srOyEcWqSfivsxxHKSqQYD1fznSsMRn+9Mcbct6qw2AoRi3lGcpcHPxRUz7kLzfRKFh3EEOTqWZ
 rAv389jYDYKUTndhlWCml56eA1R8zQFJIq/IsGBaVyCpQQoJHuNNagiqD6yBMNpTtyzFZU
X-Received: by 2002:a05:620a:4409:b0:8cd:92e7:718a with SMTP id
 af79cd13be357-8cd92e7790amr160047385a.38.1773079975531; 
 Mon, 09 Mar 2026 11:12:55 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f49649esm719044285a.12.2026.03.09.11.12.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:12:55 -0700 (PDT)
Message-ID: <1f89ed58-280b-4d09-a12a-93c4dfae8691@linaro.org>
Date: Mon, 9 Mar 2026 11:12:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] accel: Build stubs once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20260309174941.67624-1-philmd@linaro.org>
 <20260309174941.67624-3-philmd@linaro.org>
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
In-Reply-To: <20260309174941.67624-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x731.google.com
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

On 3/9/26 10:49 AM, Philippe Mathieu-Daudé wrote:
> Move stubs to the global stub_ss[] source set. These files
> are now built once for all binaries, instead of one time
> per system binary.
> 
> Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/stubs/meson.build | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

