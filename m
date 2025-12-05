Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C830CD2F7EE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRWOC-0007GF-8m; Fri, 05 Dec 2025 09:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRWNt-0007EI-8I
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:02:11 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRWNr-0007yt-88
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:02:08 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2984dfae0acso38923435ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764943325; x=1765548125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=koa2SFKFW0qyCmoTUlVEFwabWnndFjmDA+4O9qXYvdk=;
 b=HFQxqFYSCTPfsZ4Ep6WQlshSWbRYKE7qDmQoel06aNq35o7TAzXghYxsPDHkl8fZvr
 RY8TwJ7qrVrur3J1UyAR0FVDrOtuzj7NpGmyaUvR/nCyMQH96yYpU4a6kfdVqNWniaOO
 Qu9FjSI/glA1ciWuS5rgUHjt0uupX1L3vRc8s+hsIYPgXBvnowI8yL3wp4E+a3Oh5yvP
 7YqByYsU0V19RrT+bvUm9XATx9mQfZSW7YX0fu84l3UNJAfa9BH9T1Z+hec3A1wOMDuw
 keT1nqn/egskioZhPYcHeDncGEhHWPTheG6qBgfjoSXkK8YuhfSXP/S67WXDjf+s5sqt
 BrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764943325; x=1765548125;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koa2SFKFW0qyCmoTUlVEFwabWnndFjmDA+4O9qXYvdk=;
 b=XN7cNjGh+R0nHJut9fiI1eOmTTu3zdqZe4X3xec0fo4ywov26qg/VByZWuzdOnINTU
 UAMBJaDdq9COJtASX0axaQKtxHe/BcYaXIVjHqYngOU8pSMTFM9Dvas7FxtrbpGjhAxL
 0OA4SysZr2tWTywJWR4GSoS8esRJvSioQYSfnK6ro0BB10cSHygjj+v+xda04ozYE/dB
 XOtqNG/JXsN+LgQYsZxr4Sy5PGGcIvoF6CLL4n88nAKRPbHfreM7DXfSnocElIVp1u0N
 uqSypbi5nyp98P0Yo3brieHxT+OIDC0d9ULkhIgSwE56WEOSzEGrW6hPhStaWcOC8hEq
 fJqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3zqGCimGiMr+6xOzCFWITk34csyBsDfL8wP1OrQ1iBE2hLa50vAfvK2ibqEBm/UtZdZXFxAc0Po+H@nongnu.org
X-Gm-Message-State: AOJu0YyuCd0XvWdewnkRy29ESGTk1h0csO/Z8lSTd02vZD9RtbOCXTob
 FlFjHC2rGBtl7dzCase+tGDXOO7XKM6jF+NELtej0h7N1OS4iTb7t/bLN+E67bh5ej4=
X-Gm-Gg: ASbGncuDPydiMz3xHtzL2jRZEJVsJ9j9OJclwlT8e6luR2e/0E4OjLq+6b1HH++OzAN
 y9QD4q/RBCU8ort9iV+nxYzLTSl1yhFYT2HmVJ2/hhpnwfaDQqTFIDGW/VEVeuul/krPDRfY0z7
 tYfj0g+CmJY1OgGkDD5HiFqHW0TR37mpz+iw1CnpldX/n+GQ3S6e3jJWfM53BNxIo87XU0W/PsB
 aXJx+5vMVOWtkGHADxSs/wWRWjeIHKrXMBmM9/ApajSNTGk5I74boLVXEYd03QbL2PwtllMZmzU
 nIbWW3O64mjPj6V1qZjuM2MUKzWLnCOC5eYqgtXocrQKdE+ztWV7bmyRGv90WQ795bGVsvAsHhn
 GR1hVzmNsrf6CP+NKurjZY9yTQl/X7VTbzSaoiEYPTTpgNcBmoEphN1Nfq4E8Ghj0j1vTSywDDX
 RgAMqhUc18VeXRFrgrgdPB0JUoY+I4OD0nZbrVPWFMEBFSAOlaoE3rS5M=
X-Google-Smtp-Source: AGHT+IFoe49tUI4QNRqh9qhdroGVsOTAn2rtp1RtTWW42lIZXyoj+/utRK9e/OM59+/m14STfOFLpw==
X-Received: by 2002:a17:902:ce92:b0:293:33b:a9b0 with SMTP id
 d9443c01a7336-29da1ebb1b8mr88259205ad.32.1764943324525; 
 Fri, 05 Dec 2025 06:02:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29dae99f20bsm49868235ad.46.2025.12.05.06.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 06:02:04 -0800 (PST)
Message-ID: <77c23b93-249b-4e0f-b26b-130a3c66c248@linaro.org>
Date: Fri, 5 Dec 2025 06:02:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: unbreak
 --no-prefix-symbols
To: =?UTF-8?Q?S=C3=B6nke_Holz?= <sholz8530@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251205105614.13673-1-sholz8530@gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251205105614.13673-1-sholz8530@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/5/25 2:56 AM, Sönke Holz wrote:
> Since 8a545a336d, `name` is unbound if --no-prefix-symbols is passed,
> causing this script to break when that option is set.
> 
> Signed-off-by: Sönke Holz <sholz8530@gmail.com>
> ---
>   contrib/plugins/uftrace_symbols.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
> index 45fb79c7a5..21704541a6 100755
> --- a/contrib/plugins/uftrace_symbols.py
> +++ b/contrib/plugins/uftrace_symbols.py
> @@ -98,6 +98,8 @@ def generate_symbol_file(self, prefix_symbols):
>                   size = f'{s.size:{addrx}}'
>                   if prefix_symbols:
>                       name = f'{binary_name}:{s.name}'
> +                else:
> +                    name = s.name
>                   print(addr, size, 'T', name, file=sym_file)
>   
>       def generate_debug_file(self):

Thanks for catching it, I was indeed always using this option for testing.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


