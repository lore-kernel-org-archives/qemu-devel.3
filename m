Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D95ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sngbG-0000sc-EF; Mon, 09 Sep 2024 11:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sngbF-0000pg-LA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:46:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sngbE-0004Pn-3A
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 11:46:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-717911ef035so3487600b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725896802; x=1726501602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=quVd7PvWgaRhlBSJNDXFPD4W++YWwtHNUiT+1RsmpJI=;
 b=ue3nuu4/F4i8pk4OIvyXCHAD5iYd/PkqKNrQ3bMlCigckQ4jbhSbg2uZIBFAbKGO3x
 fJs5qWPwBqciwdPXxyEa0dHlj1ymxCYJbUFEq9qwWCImb7TiwLHqmTGkXrsTXHZ/Nzyr
 760dGljqqGOZPrIY0nS6jQ50rtIKJcpCWsc7UBxTpINI+/zInKv3KA8+a4YROVG3TzRn
 dxnnN0d8llybPgaUqGfKUVuVFNxYXaqOyoPSY4eYfcllqJZrh6Ki+rnA2BN4kC+4wJPv
 j20LKvG/vauR8JHCGgQc/lUF/RhHOJ33hdbGot1/FifjXvAjjO4Z65ybDn/qBogeqMOj
 +jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725896802; x=1726501602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=quVd7PvWgaRhlBSJNDXFPD4W++YWwtHNUiT+1RsmpJI=;
 b=NwmiOSmXG10hPULgehLBKDOAeYNQOwRqk6vHUs40880sxmGTdJTUyWtKXCVCensIbZ
 HPTGMNWxryOM+J6hl/S00E4tcfl09ZbKxp1lXcUNudLQhg85Fm42IAoEMKfNJv4V+EI+
 ci/oCsTC56jOl2jSr003rDenafA1N+wf9Z8UZvqSARdJveB5RnTUgsCYsaDEnGzG2J1E
 Rm8JmhrAKqzYA5AfbosF7B05x7/4vpyfa00Dzl/P66DSw1V/2C8Ua27qD3HRuUOzliJY
 el8DcPP5SnniXdXO0uyA044tpSIw3Av8A25ZKtW3YMfHeXZwA9tfzBuKwr+xz8IshrWe
 UP2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXskz2VDRjZ4LWAAf43Vyr9CgHTnFD/FwAZa14OROsjgHmu6Iv2vZeYTgtRQ9nt0aGU9zZ/O6eDOXjm@nongnu.org
X-Gm-Message-State: AOJu0Yz21UxQHiSX+ZZ0Ss/L4dxQP8rGdmMelJrzfK5FWYxM1MZy2e4W
 AXE4yRbMxZgM6vBk/SvdKPAwjWSY9P2cDmennkN7e8Xnt2RaL+uPtmwns9bxJqM=
X-Google-Smtp-Source: AGHT+IEQjKFQVTiYcNR3XMZRvI9PXzA48uGY07R8mCSQ1FGBbHG6nqM/5uPIfmJmVFMTuHpA08GJvQ==
X-Received: by 2002:a05:6a20:d80c:b0:1cf:2843:f798 with SMTP id
 adf61e73a8af0-1cf2843f932mr8706977637.47.1725896802303; 
 Mon, 09 Sep 2024 08:46:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e5990bf2sm3676380b3a.195.2024.09.09.08.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 08:46:41 -0700 (PDT)
Message-ID: <80b90332-58dd-4ba6-95b6-171790239d80@linaro.org>
Date: Mon, 9 Sep 2024 08:46:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv32: Fix masking of physical address
To: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 zong.li@sifive.com, liwei1518@gmail.com, cwshu@andestech.com,
 dbarboza@ventanamicro.com, philmd@linaro.org
References: <20240909083241.43836-2-ajones@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240909083241.43836-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 9/9/24 01:32, Andrew Jones wrote:
> C doesn't extend the sign bit for unsigned types since there isn't a
> sign bit to extend. This means a promotion of a u32 to a u64 results
> in the upper 32 bits of the u64 being zero. If that result is then
> used as a mask on another u64 the upper 32 bits will be cleared. rv32
> physical addresses may be up to 34 bits wide, so we don't want to
> clear the high bits while page aligning the address. The fix is to
> use hwaddr for the mask, which, even on rv32, is 64-bits wide.
> 
> Fixes: af3fc195e3c8 ("target/riscv: Change the TLB page size depends on PMP entries.")
> Signed-off-by: Andrew Jones<ajones@ventanamicro.com>
> ---
> -v2: Switch from signed long to hwaddr
> 
>   target/riscv/cpu_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

