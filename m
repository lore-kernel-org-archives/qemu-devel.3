Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A945D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvzt-00006K-7c; Tue, 26 Nov 2024 08:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvzn-0008Rl-Nv
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:52:52 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvzm-0003d5-CP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:52:51 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ea369fdb0cso1527625b6e.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629169; x=1733233969; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00rEX5mxVGKKPEDOVYkz9OBh/Uk/fRmskmCl6tKsEF8=;
 b=S/JMDi3NxN+HuHhJytkEiju7ZjPsAakQevN7Jc3A6zwvaU8Fh/yjDd9oNmo7Uw1TLY
 qChGYAK/hVDU/1dFT8V9ZSW5VcjFPP3/DOXoOnnRrH9Zp/BuQGaxa/LKfU3dT/ghTVJ1
 zqkDAMavUXJlaSM3CPF1NqVJMnGgwGcqN+8mflk5gSxA8Jj8ll7e4HFSlgksP3WlfFuL
 VLtyb40obzAYYe8D6SEzj0zN/d6RAygOjrARBp/Dtuy2HIx44iRZ2XZ/oGgY3HgPiy4x
 pd70YCCjunivDtU26tpfbWcZzBrvjJD6kiJWKU2IkjqzCaGee/3Y1oz4HU0BmCOz3oCU
 5u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629169; x=1733233969;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00rEX5mxVGKKPEDOVYkz9OBh/Uk/fRmskmCl6tKsEF8=;
 b=snPvXY9EOW56F9Oy1euqVo/pUfWolnapPckSwYJfutO7nqMrEr1XWxm7k/LEM9Pu2w
 aYBLxfgiOTHGbGneXfSsxsWyqfnXIefgUfDJNA2RRXcmJFuyKL/E9SDXiPCkyeJ0LKBn
 ZixngyoL9igM+NbrwwjcsF/9UQJJg4BHD6hloqTPBNVaX4CjZ9XaS99uIKYEKqnB+E/B
 487mAztXVObDE94LmSMgN9gWYFVeAwwttn0NBr/MGjk0R/XEbOH4Fteor+jmVuXFYQY2
 aXZGNBKklbOXqEjmWJ6SHstfrAHM3HV5gsIXjsPRf8kEfmCxMGgy54zhTFgOwBVOaOVE
 CNQg==
X-Gm-Message-State: AOJu0YyszMBX2guFUsuWLqeH7A502IocC3kVErCmnt0QTp1UCxhgjwcl
 Oi9+rT57/cH73a4qhL8NSkM9EVjV1y860KfvAqhP4mC/7JrNrgCiaNttucDLZkFZm1BZ0ynHM1p
 A
X-Gm-Gg: ASbGncumYB38w3VqBPHAaBurOkTQfbuKJBDjb0MkOX64BkJBfEWOHEuBm/AaP5aeW3g
 7+1X12ja/eOaXwV63RwlD9Ha/gDsLM2hY8DaJ4On8jUB+EPP74H9T5b6vHaoAEEeQjFtAVgHdvu
 d5W3gJmtrpG1O4cASx0i9fHttQI7rCp+IpDKZpVnCE+rfAfRc3mwGEaBac7rIBgmIes/upnWr0q
 QYe++DH5aw4ZnQPlxh9Y7Rlti931G//UnfzaP7rJqSp9+pteTypupgOlPe8sRvaxQ==
X-Google-Smtp-Source: AGHT+IGkr8t+3ye6fLN7BU7u1Aql8qvMUXJDQ7CsQRe0mgsRD6hWZaFZPofJRldBLY/95XW3As+M7A==
X-Received: by 2002:a05:6808:aa5:b0:3ea:53b3:b3e5 with SMTP id
 5614622812f47-3ea53b3b931mr4720506b6e.28.1732629169054; 
 Tue, 26 Nov 2024 05:52:49 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea54d0e93asm689214b6e.16.2024.11.26.05.52.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:52:48 -0800 (PST)
Message-ID: <acdbe36b-5043-4e3f-b716-631ef79b6785@linaro.org>
Date: Tue, 26 Nov 2024 07:52:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] target/mips: Rename gen_op_addr_add?() ->
 gen_op_addr_add?_tl()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MIPS gen_op_addr_add() and gen_op_addr_addi() take a target-specific
> TCGv argument. Rename them respectively as gen_op_addr_add_tl() and
> gen_op_addr_addi_tl() like other TCG core helpers.
> 
> Mechanical change done using sed tool.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

