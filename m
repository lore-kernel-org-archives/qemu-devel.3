Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A6CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v956C-0001LH-Ha; Wed, 15 Oct 2025 13:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9566-0001KY-2T
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:15:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9561-0004vs-Vv
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:15:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso40285075e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548521; x=1761153321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Ibs9r+HE1oPolICmyeyoUkQJcLCShVeB+p/I8ErSHw=;
 b=SoKQDvn+r/FisSfjXfQytJT5IqJlc0/BlSqJfV3E1vph7ZwucmMN2SWoOT1+K/WABv
 b3H61QJGl14WcpS9KfMfVCLbJCyc8nOsYgHtcofBs2HZI0Vu9YSNcyeWYhOxhGUqLEkY
 +gC59ubtbxPhfD+7X+nNGHSsvLUzGad2qYFReb6rDCmvnrKh1OS2wZAeH9B8hhP6ZzxB
 NTizUXF7FW8Y2xuT1iqCz11UowTX7LiFFzjlYqXCDQzMxo3t3eGUe3nkaFT1U4xP3zIf
 04n2ybB/H8Jwq+LBj3yUc91dvL1RWHpwu/hOJ27UQxhOZPNOzesTwqowtXpKVs+PGiG0
 e0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548521; x=1761153321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ibs9r+HE1oPolICmyeyoUkQJcLCShVeB+p/I8ErSHw=;
 b=rrkCuFQx6v+pkQ5Up+8FH1tV4vuJfLRg66mqholLMIvKhClgE4FePx+50jJ/gpklAt
 SXEYtwrGKgsMtaDogQxAPw1KY4Ilai4md7TenZ9hN+TxjuWNQoB2uGjKfoF6/S09GT6o
 W33k6vghWKbOyGqRCgJ4QuRoqwmM4dzoyBduxjJTrpp8o3TvxOPZSdqIvGDkU0/qfd7m
 /+anFshhTYfmix/Aeq5gcZJVuJNOCpVGDqOTKBY7HnDPacZO2NV6NSWpmBbfNzpF7qOb
 I6Fcd6avwNC6s+ASCWwjavq47jogOARJu/F1Ai68M6yrI7j2sZ6oaundBsh9Hn/JP+Ui
 6BUQ==
X-Gm-Message-State: AOJu0YxsQTkqbyiOpmbHFdft3/NomY5DghUfb9/RfHHufeY9wkq+FjAc
 /N0WeFj6tDy1dtUi3harjNKxg/JIa9yZQbysjNK8vOHOa8p01sqOjtt4KxDS76rfiizqE6bXWCP
 zTIzDClAAHQ==
X-Gm-Gg: ASbGncvra1xrUhA9H9V5Kr1QYtxWYdJ2onstvYFUNzrJ9N/8ANcgqoOg3mxUxd0On7h
 35EMHEDslFxEMBZfQMgBn1TQ79B3Bn4BE8B8DnGbvKucCTDnVuonrXuR6cQGJsmVvF09212ON3I
 VEj29OMkWCFp7ZtIlBkjx9ihZuJrXI6+ne7LGf8am1DuZq17AfaTMTcQEmtUhkxzCruFV4DZO88
 0ZB1kKasYPIDmNEJ+eKpw6UBr3FP6WzBcTVyZAMgGXTiF2mCtl5tqDl0a/PqVNHYBSSLCnD0IJy
 JfQYzOw1XTwutteVsVjr3xpp0G0BWmnGVxjrQwppXM3nsh8VKJZOl303BezhG617D2dHpCwffxe
 aICQot/PCTO1Qgz0rvrqvapAnBrhw1UCgFDjpSAeGt47m0ly4mWsStYgZa1eaJECSHP5NpGVvQ/
 xKJZyCMiOBrjsd
X-Google-Smtp-Source: AGHT+IHUUeaZBzpI80fOa47EijNSByjbnIox0U+o+KeCB6yBQx0kwSWskCDI5fwP1G1LhDTIiMmnlg==
X-Received: by 2002:a05:600c:8288:b0:471:6f4:601f with SMTP id
 5b1f17b1804b1-47106f460f6mr21048985e9.19.1760548521179; 
 Wed, 15 Oct 2025 10:15:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab500706sm185243425e9.3.2025.10.15.10.15.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:15:20 -0700 (PDT)
Message-ID: <dbf3e294-2d91-4c26-822c-f3b054f32f0d@linaro.org>
Date: Wed, 15 Oct 2025 19:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/sh4: Remove all uses of target_ulong type
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20251008064814.90520-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/10/25 08:48, Philippe Mathieu-Daudé wrote:
> Remove the left over target_ulong uses in SH4 frontend.
> 
> Philippe Mathieu-Daudé (6):
>    target/sh4: Convert CPUSH4State::sr register to uint32_t type
>    target/sh4: Remove target_ulong use in cpu_sh4_is_cached()
>    target/sh4: Use hwaddr type for hardware addresses
>    target/sh4: Remove target_ulong uses in superh_cpu_get_phys_page_debug
>    target/sh4: Use vaddr type for TLB virtual addresses
>    target/sh4: Remove target_ulong use in gen_goto_tb()

Series queued, thanks.

