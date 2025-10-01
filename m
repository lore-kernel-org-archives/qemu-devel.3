Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559EFCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v440x-00023T-6r; Wed, 01 Oct 2025 17:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v440s-00020k-K5
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:05:27 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v440f-0004W3-82
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:05:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-27d3540a43fso2432585ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759352702; x=1759957502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBoDt4i180w0W+W3GnmR6lat2pqax9OiVtrPjs0Bc5o=;
 b=PGEVvCB7V0IZbGmiqQI5589cdsYJ4CCExWNBgrASNTRR80pX71tseWhoGypszI2LJv
 DDlIy9ZHmozqaXxhUr35RWyDG6NeECFevcpXVEUupEHuK3Mz32ACZZ5uUBwWjYLLrBbq
 O/0UHE1E6LiwVg6lKP8JWH4PsOglJO/t5TNSiz2oGWpnoKrQ5xoodIrABetqcDZxU4hZ
 wc90n1oCVdcdXlSnX+Wrok9NHT8+S7ycLBQ2s8ysk4qUI3fryOlxaYbADG7oXbGt2gRv
 wuDyrMJLoKVZREQoaGLVsOaelrl+qYJYGFTVJg0NNNZFiUs65QRCpOlTy7QdcSrtIvBQ
 uUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759352702; x=1759957502;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EBoDt4i180w0W+W3GnmR6lat2pqax9OiVtrPjs0Bc5o=;
 b=d5nstdljMjDgYPq+1LCqMzf631rAj0C5YNB+RuUnxogC1+Cn++UHrPTWKrx3CYM6dv
 Wgsz2R5aBxZ/aLgM6c5dxmFCmKfguEPFrRlJR94ptOPtUEwPaSxBQFXpTVBZ3kVzFnsx
 kGuIk6skCRzSGWlscUyxlwIUtfq6f2QoXVrHraGrtw80fuvJYAUgLVn3B6mn4zDHHZvp
 1WK3s8uVo36KLzzdaGr4eM89iJnQ4+WsAX85Fx3LHt2VS4IvZlTlrZDbbxtKFAWbfEDX
 GuiJ87DUaSI0KNzRgQ5WfeihsgthXydV/5th7oncPKTQ4VUoIB5ANesBZcKxAsSBd6vJ
 EPiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCRYaqj2vSaMpzpYygvJ2y3v41mO0khoDiIB6Dn3V5oK5/y1G20h0AzYburj0/EGheCsJU6k4ICui3@nongnu.org
X-Gm-Message-State: AOJu0Yy8BeCNBFQGVmuX6D0KMhuCRQo0xMAS1y5lnSsUpfcOeA+pNriR
 u78nI3vAbOxsPXDAN8wUA2uGWm5vhxOtMJLn2UuV1DjmlsXNSl6ZeoFT8JqQTEpUOio=
X-Gm-Gg: ASbGncs/NL//VE5VtVhxW8od/tLnT6dgqAKLyBKRqlbMjlEWA/YPyYR4A5Itcjcdt9Y
 Tjt85z458fmM7xSo6H+Vpe3S6zrxAK3BuSGs4CPBKxUIolINIsXhbbOtwg7MZLf7Efg27wNEKnb
 ks9PqDJjMzoB0+9xZJS6JM9OJpWSHUVUhTrMsQtJGsitZ3h+H+DLAvy3/KmD+MqowX4ihylOb8j
 lxzspatUI7rYSMeRDOmTd0XYodNlO8RRvUQheiwEKx9k1DIrPj6quRGYiTv7bTL8nXW/ri5C6Wt
 OJqGhOVBa0BdpCT1FRcpkxFWjJQ1L7pm3drR8eDDB5Hf8swwHGe/AkE2M1xbsl9OCDArWm/wFHt
 A6vUVz2I38pS18glO0TU6Fz0TyTYpb2/LqiFfaO8f10KfZMAA0C5E/aEsMcvE
X-Google-Smtp-Source: AGHT+IGsFw7njXVok92E1aEOYbg0c+sleSab7rqVSZKHYCMYdqDq8eQ21cflr8t+sNqWkTiPCNcEgg==
X-Received: by 2002:a17:903:230d:b0:267:a231:34d0 with SMTP id
 d9443c01a7336-28e7f4440a5mr67875105ad.42.1759352702384; 
 Wed, 01 Oct 2025 14:05:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d11191bsm5318465ad.11.2025.10.01.14.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 14:05:01 -0700 (PDT)
Message-ID: <9bb1c7ae-c852-4438-a28f-0e047dc7c4a0@linaro.org>
Date: Wed, 1 Oct 2025 14:05:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_guest_memfd_range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>
References: <20251001164456.3230-1-philmd@linaro.org>
 <20251001164456.3230-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001164456.3230-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 10/1/25 09:44, Philippe Mathieu-Daudé wrote:
> Rename @start as @offset, since it express an offset within a RAMBlock.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ramblock.h | 3 ++-
>   system/physmem.c          | 8 ++++----
>   2 files changed, 6 insertions(+), 5 deletions(-)

The patch subject is now wrong.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

