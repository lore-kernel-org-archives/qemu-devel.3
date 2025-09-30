Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DA0CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3c9n-0002Ef-59; Tue, 30 Sep 2025 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3c9l-0002BY-3n
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:20:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3c9g-0004NV-V1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:20:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso3466985b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759245636; x=1759850436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ppPNwT6bMZwtRl7KbmTBy9YWyzVFg6tkexd8wfvB4g=;
 b=yBYrXcsb5GNiPmw4j/5laAA97FEYTScLUlltaoBc/lZHz8Y6MKyJ/L4wFH2+7kCAzr
 g0r3uj4FLgZkgaa5mUJ1Ubx1mspazMzfaiXnGaxhu9fqS++2Ol+3aYKzlssjyLq7JCig
 RYC9AdR4C+2t8Y5GzV+vLUwp4Ig/xHNHy0pCXZWUWeIzqbVA/SX0WPhKJrsh1uNCHlpi
 PXr2C2awR/p7EpunEMNeQHvXrerS1DY0UyC1KjQHJmpzX0Hv6FanC9TuK3M5SxJyXW2v
 SIVwU+ji7wz5+9DvjHyz9UieHYExPYydNizDmoXLkixkPtDKQaThTMfj8o0Bt7p6R7rw
 BzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759245636; x=1759850436;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ppPNwT6bMZwtRl7KbmTBy9YWyzVFg6tkexd8wfvB4g=;
 b=tdHirIsO7Je9LjbNereNKm/+CRVgHl8P8fkXeHYPiST3ijVo45Pfv6COLEHIl3jg1q
 zvtHfoJ2eruolwsLNEAZQq/dIeuZCSP7C7eFXa920tGO1n9jO8L/a6PQLF0vsgmnMAU8
 9HqWmyAqLC3EvhbUxrP3U/XXexjhQ7PjKMCGtx23nBSuzpdrcAxhun3WjXrPVqIl/0jr
 4r0JEDFYRHHNFqlIExs7c+7wLXUZtpk6m1wqszmyDSgqkOn1CIwXV/GYOO3l0Z2mj5Zt
 tK+3yIlfnHH2yJJL0jqj0iO+UPB8vj8iTMXVXWC3R/lyhNxypw236nwgft+SX7OgYj3+
 bKNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMw8+OXAk5qxc6YI7ETLYNWpOj30CaLDELndV1dRwcEnQDLZBGtnbB884T6vK/TbuK/mu+OBQ7y1ix@nongnu.org
X-Gm-Message-State: AOJu0YyYu5NQDtkiW1kVxbxFL1ArgJxNuLrh7jybwUXhWDSYIDzWFCdp
 1lVyIsCFCyEHRoAcpz1lTBaIMHBfZbMIw1tdFzelfmbpFV00+4F1E8lIGyv/htqcLoA2Mn0ArAu
 b4PdM+7qjBA==
X-Gm-Gg: ASbGncvpRxRJBusdUJdXVtV3tEsKjHJapjrRT3zmFYPi8ia1ydNvq5u1Py7MmeRuz5l
 EVafxqG/xYzZ3qQKP0VCq1aHcrOFpaRS8i6X8jY07Q+4zdlFl4cfNWZieHQwOxy57H9UrVO31r8
 Btnx/cVAP5Ng2rB/JZlrSI87T8QQ5pXMgWcHjfMYlfVpc2LmOZKZR/Myj77F8RZtrSY07/rwCx3
 X07q8y4sLX0oznyPT+XBANXy1L+5i0eHJBI3Z9fr7Sav0t+5NRZ/oeqX5lIqK0xQxFbQIdnf1Is
 wccAFwDhXwtTBEoi/HXvUGjma7S0tXGuF/HAseNHi51cAQvgKHJMkFr8VgTI6OyP/OGsq8kmSUO
 fmX6IeOufOk9UOkjVw4EXkWux/HXNx0n7yh/0MBT0DGW4b3sCICX7clRrQWg979R0Tx/QFPY=
X-Google-Smtp-Source: AGHT+IEOXMKMLGbNRkMYx+oW7hNJ/pUiVgqMQyscec7f/9HKt7DK9lXueK1EY7X7RFDfwIj/4JAqkA==
X-Received: by 2002:a17:902:b690:b0:27e:f1d1:74e0 with SMTP id
 d9443c01a7336-28e7f2a37dcmr1333425ad.17.1759245636211; 
 Tue, 30 Sep 2025 08:20:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53cb975sm14288276a12.18.2025.09.30.08.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 08:20:35 -0700 (PDT)
Message-ID: <e58f6ff2-df5c-45b4-8a0f-de74c1edb7e1@linaro.org>
Date: Tue, 30 Sep 2025 08:20:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/18] system/memory: Better describe @plen argument of
 flatview_translate()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> flatview_translate()'s @plen argument is output-only and can be NULL.
> 
> When Xen is enabled, only update @plen_out when non-NULL.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/memory.h | 5 +++--
>   system/physmem.c        | 9 +++++----
>   2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index aa85fc27a10..3e5bf3ef05e 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2992,13 +2992,14 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>    * @addr: address within that address space
>    * @xlat: pointer to address within the returned memory region section's
>    * #MemoryRegion.
> - * @len: pointer to length
> + * @plen_out: pointer to valid read/write length of the translated address.
> + *            It can be @NULL when we don't care about it.
>    * @is_write: indicates the transfer direction
>    * @attrs: memory attributes
>    */
>   MemoryRegion *flatview_translate(FlatView *fv,
>                                    hwaddr addr, hwaddr *xlat,
> -                                 hwaddr *len, bool is_write,
> +                                 hwaddr *plen_out, bool is_write,
>                                    MemTxAttrs attrs);

Renaming to plen_out is misleading, because it is used as an input as well:

> -        *plen = MIN(page, *plen);
> +        *plen_out = MIN(page, *plen_out);

right here.  If non-null, the input should be the access length of the caller.


r~

