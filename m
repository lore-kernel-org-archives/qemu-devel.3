Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58218C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ozU-0005mu-S8; Wed, 16 Sep 2026 08:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ozN-0005mi-6S
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:43:49 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ozC-0004eE-I6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 08:43:39 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so561490a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562617; x=1790167417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IoXJgklBw0pY27LsuLORozt9BmtJ2YzDk3ZWsDpY9dU=;
 b=QdAU1tf6SIbDbbDe8orVtWgqLbDMhGxP/SiGKBDMHywTWV8oeDGyLT02i+GNVUFGW+
 mCVXxVh5/YjAka6/788loftREURqdl8lZfbcB3Ny4Vtqa82pWPrTJeXJg00p0xK1KAS6
 3FUwlzdWN1Ugqr4I6xQVmzBvA7RvxkmoS2irO5VsbYJJ691GWrZmxuX6id5o1J4jPQYO
 ZR33Sv9RrbwJmPbgcZdpfKKzqgubK3XSA7qo80BFjsTNZf6mZ6HzXlqSHjZuAFPEML+i
 Y6LU5kK9I37/TZ7cjKrfkSLXD2AHSpnqitvDN+ctbwKprDKURYIJ5hYu0EXmt+L2IvY3
 gnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562617; x=1790167417;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IoXJgklBw0pY27LsuLORozt9BmtJ2YzDk3ZWsDpY9dU=;
 b=TImFfFD1zZflLxT6IYTJILntLmjfI1+FawxQl/ritKBlXOYGtIaE1Ua4nUFGXUkPqE
 1ZcW5ycSSDoJpqL//wG6Ne6wN51xy4lj4u+f2W8gloTgO7Zw+Hy+9EcYebhprMYTM5Z3
 3yryv1gNrt37mLsdx40f1B+os0EynsXoy98WL4lL4GOviebsnakfBBo7Tz8udAOjlDPv
 zhbUZGT/u6KQ99G11mkv/DhaJtGpuK78OVYkQfzr1xqQ1xyLcSKaqEYk9t3w3qoYDnfO
 DMXAGidzmVSegsa1jx7uMKtqBV71s6fd4EMPHuU0iDWZk/s89mjFv6z0nZvWj3KLAOTe
 vJwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVMot/SfOZKGzEnBShjE/uvWBSVn1u01/o2lTOhG5MBrj/xXzuwS1Icn5+esYX2jtlNwPhcAytHNTs@nongnu.org
X-Gm-Message-State: AFuF++nd9tr+HGY/OLiM0gHMCYGWXj1Vw/AHhIbIHXKsgtmkXdo3zSu5
 /tEnoA7J7xgyD3f/c/0nJRerkspm6je9clGvAkXG0Xl7xhJXy3dt/ITwcrcaoVWB6ng=
X-Gm-Gg: AYBFou0C12y0hGeYO6KIQkjqJTOcyK8ntcUpCrFogqh48GoFIKtNeggcZQgPIYIv0Xz
 uyc+56TvZEBlSSqpZZiTNrAJNGTYRRfhdLTMK8UogLgl1o2k7xM+WZqDkp3Pg7Z6T/dGN0YOzhC
 g2tKwEFaYspbrwvZd8hq3i69/TkjyEmrDq4l3QYyMhtbRevDaOUgnNXpRj1ARcTIYHqPqo1/2YO
 cyK7HhjFRJVzVjHvX7l5NVcxdtyAFtKeQOmqoEoNnwBXluMnCSxsMo6AXTf/bgwJYzHOdUsjUl4
 lEAxDmjknfF4s4s3LO9j0nLruyG7yIjnPx52nkMZOJ0pg1zBREDdh4Hwpw2HS9RFEXwJaJ7qDyx
 ZjDRVmwLmI4f9I/lZng8HyjaJfpHjaAEEUO9cmfyrr+1BTJVsU/WRGaLpgl1yFEWRr3EabQMEXa
 HFbJWejzR84ruVVApd4y0Xvn0lfZc9HFt85XZ6cdPDyJ5ClgFBjXevJARzZOYdsunJnUPlVcyyu
 0jE1dz0qz1lALL9YqG6Q9L4tBo+BiL770NVo9ibUPdclJcyF3PChmEPiEQv2g==
X-Received: by 2002:a05:6a20:7288:b0:3d2:89db:1688 with SMTP id
 adf61e73a8af0-3dd5f3f9548mr6227518637.2.1789562616685; 
 Wed, 16 Sep 2026 05:43:36 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc50aba9dbbsm1528120a12.24.2026.09.16.05.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 05:43:36 -0700 (PDT)
Message-ID: <906234eb-ae0b-41e9-aa82-a7c3a5d7e80d@linaro.org>
Date: Wed, 16 Sep 2026 02:43:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
To: Anton Blanchard <antonb@tenstorrent.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260916123958.1884903-1-antonb@tenstorrent.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260916123958.1884903-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/16/26 02:39, Anton Blanchard wrote:
> Update tlb_plugin_lookup() to check TLB_MMIO in slow_flags.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   accel/tcg/cputlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7f7c208ba1..3ca777d59c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1593,7 +1593,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
>       data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
>   
>       /* We must have an iotlb entry for MMIO */
> -    if (tlb_addr & TLB_MMIO) {
> +    if (full->slow_flags[access_type] & TLB_MMIO) {
>           MemoryRegionSection *section = full->section;
>           data->is_io = true;
>           data->mr = section->mr;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
and queued for tcg-next.


r~

