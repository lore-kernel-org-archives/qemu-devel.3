Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84215CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PZm-0004gv-Sx; Thu, 02 Oct 2025 16:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PZj-0004e2-Kb
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:06:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PZf-0001XH-Ed
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:06:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78af9ebe337so1098909b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435605; x=1760040405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pu9TnxyxLTHllDoj83ZjJF1DAwKv+IXe+QHbW08H/as=;
 b=TTmEU4/bZbaCu/1RQwz1ClKDWckq3yKKlFZHQGZnqSvfHuDUFLrCsPcMfibnsSNv6B
 d7B2s7JPG7mXlV2z8YYjdk0/JEQc5XC3aJ1/wFnauVnmVUsmfkcs2Hhier5ZE8CRzq3t
 AqMFtHad8UMoP15ZuIXOOAMAD42EU/IwukN3rO9xH7nDDoO3X+SiLBG42Uu5AGB5+q30
 5EB9ncUW8MPMdihXl6UQ8SSZxoylXolYwL48MjPC9s/HByzZFasOEm0wMuk9jD4MPvvO
 Ypn3nIxbtKQftygJ2xaJ0OZS40CbfAJb3nwrV3Dz13NB5MRFOcRD5HCmAr9kTrN1yHC0
 fqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435605; x=1760040405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pu9TnxyxLTHllDoj83ZjJF1DAwKv+IXe+QHbW08H/as=;
 b=hjlfCQNMknz1LI/9VQT7KwSgMrMRda61KMfTRxoMjHfplP0pFfdaEex0hqrrqyb4UE
 ICz7OfgA9k3chlQ7PIq5YbKinUJ5IX2mkrQjolRKRzYzBVAg1ZrYLSbTgU4K2n8Muc8/
 xWUPJlsNeTWG/le0srUFTldCpAtE4I01SrG8FX7ZZCYvz4rn3NT8OX0XreKXSA0Df9TG
 e7FCAbkjmDyPqJMh21Z3eAw3oINSFWdXhNPoYmSrktsEOshnFaMjlf2TtVToBriOhLDO
 tHx0epvqHMAZPKRVW/iNM0YsDxLpCk/wFN1JqZ66+t3TTXbuXcZEIGUI0OZrlO5FAuqh
 4U2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX824Vu2Ji4H3QOpuUghONKK4GUJXK/oGVdMV8/pOGGN3AeRRjEMgIfQkvRXZYcukQ9V9FnDhzzu8jz@nongnu.org
X-Gm-Message-State: AOJu0YwPJIf81EeEg1lgfIxnZ7m4y3CyFmZQ7eDKzYH/gOQ8JqGUS+51
 L+GIuJH80Q/iiiC1MYQbC4qbGgTuThd25on4P1SheAtQaT25+jYx67cjr++8soNYiP8=
X-Gm-Gg: ASbGncvFRy/veEEUdFE/HGUXvzY9NhaJsYZ8jlzTNIrr0snyvUu4He+4dtqIQe5ejPX
 nRksTdMPWvIZcAFz9dItuvB1jKVPpZhYjCbDmIJ+90G3uXhTLdopvcmQOMPp8ZtygjiAinSfgLb
 BjGbLCx8Rv457mDFgHSVRMeRSC4mvhAX3m9OI2t/qZGUkYA1MbmguBO4dsk8cpem9EZS0hPj24Y
 xcxaV4KYtruSqhfC7ymR+04TPrJX/xmoGrwLQHtBFKkGHS5ApkhtUBkhWpAGo16oqe3iTvOIx+J
 bfIp/ahwij0I8xHwU6xG1oUXg9CQ1Ibsv8KIBCFRgf9pQo+4F3o/nlqwMtDaOFgFHuoqxGFGuq+
 IHsKEfwL0jD8IP8BSldDr3bCOvqaPiRev/QeEBtSuB5AHVGp2DWU4lCjKMTHaQ7U=
X-Google-Smtp-Source: AGHT+IEmvGw9nrTCo15jBdKqTYCVrRpoAUnigLKUnDS/EMUm4dMyeM82pIyzigWm63CRX1TEVDa3QA==
X-Received: by 2002:a05:6a21:3086:b0:2f9:dc8d:d2b3 with SMTP id
 adf61e73a8af0-32b61e581dcmr751780637.22.1759435604919; 
 Thu, 02 Oct 2025 13:06:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b0206de1csm2844090b3a.61.2025.10.02.13.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:06:44 -0700 (PDT)
Message-ID: <6086800c-0fb5-4cbc-aa8b-155031ab2370@linaro.org>
Date: Thu, 2 Oct 2025 13:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/33] target/riscv: Fix size of excp_uw2
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-19-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-19-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Fix to 64 bits to match size of instruction start words.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


