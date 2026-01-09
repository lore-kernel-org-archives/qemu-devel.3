Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72869D232ED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Za-0003cK-VL; Fri, 09 Jan 2026 03:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Z4-0003Jj-Te
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:09:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Z3-0006zs-7U
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:09:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so27620805e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767946183; x=1768550983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cuRyffJLQTOMD281cNcmYFQwxyXUGv4vB8Cgz7rDWaM=;
 b=W5MjbpUIUKEE9SOf6jvZxHKMD0G7G+s85gyuxIedUG4jsRP7/5Z58zazprO2zaGzRd
 M2KPqByejMcusEu2ZfLLLrLIK1wzDRqJVYZKmsCIZHtdpC49VuIdHDJ4z5zrHUonqDjx
 eDPB8FTurupzqEecweSjAV7ifF1ZmMkWRlxKEN3EtqxgndBluodlJXvJOBa3U4kW2YN1
 xWh3H+vWhhk670pRoQTd4h0v5xYCFaYxv69D5OJAV5vigXJyAkfn5RZVLkOL1QGTl3a6
 oWZIJBMp05WB1I4WYl9DB/032GDKyLh9xFMuLwPBR7mAXEqXF6TYf6mM2rrPj6qfWCky
 B+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767946183; x=1768550983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cuRyffJLQTOMD281cNcmYFQwxyXUGv4vB8Cgz7rDWaM=;
 b=hyEMtPsP20rsh9hkD1J/UDl23BLnQvk8MPUYVTnexmWr4HxPYbskAYDwNXiO2YCoE+
 5zPxP0WapYDZmMWUmISc/a8l6jGCvjea7nXWKLLoUnnzZ8IhvUofXc6SfHiuS2Xg52xD
 ZCPRNbeYLS40HTMOJisn3aLGl9TR3s6WlhGQX0CdP6GQi93+Yoxruh7DXFVVZnut7jEC
 1RURuyoZGzCS8u8kwqrB6ZUIpBAa2jX8/xslnQe+bYyGpkO8l3LNaWhzz9uNZm+Gmn05
 NAWYaqiH+NYyllrf6urf8OHHH1HKgsJfY6sVwEroc2u/lfqCr61mFlie774l2lxTz8W6
 bZrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgZ1JLzvcMrDuWE2Qmx+QGQ3LCzi5923gT2SDBl7K65c6fT5s5EfS1eK1YFfyVVWiCoPhuil1Iocjt@nongnu.org
X-Gm-Message-State: AOJu0YwaPxBnplaYT5f+tc2sDbFPrX3jwbWhVg49KXdAZmI+FkND9T/V
 IbAGOvzMxbTH/wZX6sD8VdKNExOE6Hu9lIVXzEND0rry06sLjTqq2eplUeZe1Fiuvgw=
X-Gm-Gg: AY/fxX7FqPVMuWlLC+uycVDQ6VrfVCqvSv903ZVV4zIDGCRhzYTxi0a3Ozbm4uYkH2M
 nir+eaV5PVmQgp1MgubRdWLm90GVrCFZIZYhjCkNnUykUgeQcWQPuqwvtjfU1Nk5tDOtKSZITmj
 yV3GGrOVH4GHjLKi1hirNZWzIBhnXpJbPcN/iLs6KA95zPdxpbV1nUSQA8D3zEP8/tMSz8GWq+i
 3SPwVSqs1qRm+STShJcL2HOIZluZzJ8v6tt9yFxQQrCX0uHlsiB5O6G5/NEEHwjUq0oLwnkLcFA
 tONkmbZQSpfDt0G+bgcUHDN4XDzQYfWUc7yCkY5Dbv3ElBEOniMue+t6eQJwWmFkrUdsTRAi7up
 2vhGso1/xBXtBZrmfVy9j2jBBDKgo13nqbf369ypMRxeHLwno+eVHU2Hz6fcsvja69SglLfu1/O
 FKOYOsBW5J7D3SmWmnk0dnJfqxyfdueudosl9NlxKm3oTw8b+Dg0wNyQ==
X-Google-Smtp-Source: AGHT+IEspcM9vjrtaLAT7MnJe2KY+PNHopkLjYouGvxqLTP7SaPtzSzMs3hoKReNdH+Fyh6fN3pHQw==
X-Received: by 2002:a05:600d:6445:20b0:479:3a86:dc1d with SMTP id
 5b1f17b1804b1-47d8e4a3c68mr30560405e9.37.1767946182815; 
 Fri, 09 Jan 2026 00:09:42 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f65d9f0sm202446805e9.12.2026.01.09.00.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:09:42 -0800 (PST)
Message-ID: <67a7bafb-95ec-4f62-91a5-dcab5ddb7b16@linaro.org>
Date: Fri, 9 Jan 2026 09:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/29] target/arm/tcg/psci.c: make compilation unit common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> Now that helper.h does not contain TARGET_AARCH64 identifier, we can
> move forward with this file.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/psci.c      | 2 +-
>   target/arm/tcg/meson.build | 5 +----
>   2 files changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


