Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D18C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 19:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZxFt-0007Bi-6u; Thu, 10 Jul 2025 15:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZxFq-0007AR-2f
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:48:26 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZxFo-0007GS-0k
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 15:48:25 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-407a6c6a6d4so415160b6e.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752176901; x=1752781701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZUZQQXS43w3BzT7GN7yR+jIN/pDlvzyk3Qt7t2nDHHI=;
 b=xRvcLPeirSYIX3fGrdVl2a9dthHqnLgZs8khS336xPBJ21w9YNdCI0YRhbnKun1l3J
 x2p2478sHY/WjEB+Ge1/r49p5S3Eab67pcShnNaU7EpL47utqNl1RC1HwVEkJ5/CCvSJ
 4fQ00D7aDvKm5aObYkzLtn25x7vT+JwwN8qo2p/O3E6qDST+ypj2foxFcT3J9aB9L8cX
 pUud/TlhrphmqtGQovDEpTKHVZpYkVyRqtxzm1aHnaClNfQOktXEAfRSWX5/hSMFhLA1
 iL4i+OGRiUESKpx543KTOhEZOZ5bQe9465SqH2otpqveMy9q3hnzTuvsgZ//X24NT/Ts
 /+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752176901; x=1752781701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUZQQXS43w3BzT7GN7yR+jIN/pDlvzyk3Qt7t2nDHHI=;
 b=rAxSMCVOz3AdgjFqYUc7hUEUjxvW+V8+xiDzYOVMQ8rnHWKWBOHkhRkGAjRiyoK1Gh
 0GwqB70pt+Bmmj1aB6mGTYR/TkVbWoi3/XZXSumNwRGpQv7SNjpixeG+3bN8gd1nBRGD
 UI5Y0L8NVgtbDhjd8Shn9tGC+Rne57zszceuKmKMsWef5SDHTzX6mF8VhMgQWoKLahy8
 BdqdcXcn+QW2e0p3/kE10XgRFu4pM7Rk9Bqec7riwPIFCuG81U7HLFDemO8XjCYtstL/
 srSzPAVPK4gtV5dLwVCugvXi3mvprCVKgxXf7DpdAgzEDf9j6tbfTSt8tcgNVZfgrbtS
 Qr+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4lSi+OEUujhVKfix4tAswPrXU9z7Fv0l1nw9KNmZfrTj02EAr639c0I8w9H3epcHa3KwV8upZrnxw@nongnu.org
X-Gm-Message-State: AOJu0YyqyP4nn8YRJqFDrKt8B8WLJSdwvR21e0JeW6NQE5ibvvmOD6QW
 DgPbwGWtZnzgrED1c9JtDWRz1xQneKa5wGfn6GdWoK+Y3HY3fQ9HFdWQWGGEicC1vjM=
X-Gm-Gg: ASbGncuy27iqX4DC1vyHqTn2HclBsMT8aLu7CDGhdFA5rIuai8UlWMru9VNPPiJrmyI
 7VvGkUBsCqot+i+53hB8sTuhPfKiyeOlSwPbPbjAq7/IPG56JbyGEWyGCA57eBlEr8RU+QvbXki
 DSxEEEAoaWLyqZ6T8iQD+Ee+kx5JalO4gFWH98aB9N0DGgPBYxxfqdo05xy+CLqDxsgADoN2VKO
 HUGdqBqmKxRlEhIeHE8EBWGz/cmWTQVvlcPbML74p2qtbeNsXlNraYNhgb4HvcyaEuCdxAeWMrm
 PcxM74zjlkXaU6c3gRa645CwbF8PVbpZbNMDR2Sk0KIa9T8Ei6h7FIg6vdRl+iA9kyNdmFGNiV9
 oAtJCgBsUcRDrO7z1sPdSnHiWAVCXXRVcqROhgCQ=
X-Google-Smtp-Source: AGHT+IG8NumYP0SPtd5AjQ4iFjL9K4v3gslW1UOmpqIImcTQV3/hkTC48EqzS3CGVrvnOpypl4LSnw==
X-Received: by 2002:a05:6808:1202:b0:408:fbed:c3ab with SMTP id
 5614622812f47-41510184766mr638146b6e.38.1752176901081; 
 Thu, 10 Jul 2025 12:48:21 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-41419baa665sm308243b6e.21.2025.07.10.12.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 12:48:20 -0700 (PDT)
Message-ID: <eaeb838a-6211-44f1-afca-4d94eb24c170@linaro.org>
Date: Thu, 10 Jul 2025 13:48:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Support madvise(MADV_DONTDUMP) when creating core
 dumps for qemu-user
To: Jon Wilson <jonwilson030981@googlemail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Jon Wilson <jonwilson030981@gmail.com>
References: <20250506173423.1312788-1-jonwilson030981@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250506173423.1312788-1-jonwilson030981@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 5/6/25 11:34, Jon Wilson wrote:
> +    case MADV_DONTDUMP:
> +        if (len > 0) {
> +            /*
> +             * To set the page permissons, we must OR our new flags with the
> +             * existing flags. Only mark the pages as PAGE_DONTDUMP if the
> +             * entire range has the same flags. If any part of the range
> +             * differs, we would need to process it one page at a time which
> +             * might not be very performant. Since we are not obliged to respect
> +             * this flag, we will support it for the most likely usage scenario.
> +             * Note that we don't set PAGE_ANON, since this can only be set with
> +             * new mappings.
> +             */
> +            int flg = page_get_flags(start);
> +            if (page_check_range(start, len, flg)) {
> +                page_set_flags(start, start + len - 1, PAGE_DONTDUMP | (flg & ~PAGE_ANON) );
> +            }

There is an existing helper function, pageflags_set_clear, which could be promoted and 
exported to perform this OR.  Indeed, the bits-to-set and bits-to-clear interface would 
probably be clearer for all existing uses of page_set_flags, eliminating the need for the 
PAGE_RESET hack.

You don't want to clear PAGE_ANON.


r~

