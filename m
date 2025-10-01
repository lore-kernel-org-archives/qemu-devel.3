Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC410CCD180
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 14:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yAb-0003w5-JG; Wed, 01 Oct 2025 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yAY-0003vT-LX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:51:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yAN-00061M-8j
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 10:51:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-28e7cd34047so15680255ad.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 07:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759330243; x=1759935043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVdSi0KvObjHpPCH3YWc8HTTtemgo9ZaRLkbSjbusks=;
 b=H+zjCDnM9YUW0/orHBCdYUYOw0wxVfFxWS3qHG892TmW3Btq+Tfmig5XlWgsfVtYr0
 oHmkPGN5pRTbXVnp7C9uwxz+a6/y65T8Aji2qKjQLLi07yN3k246uuWKHuwO7A+3ZMg2
 HS7NjFbTCG7uyyahJplqniVFa8zM7vwRFHQa44KIapIK4JVRBb2y3IwpqCoI0K60L/d8
 44QVhDXJMUp24y/QHzBqKK5uoLxTgza56Az0CNclJTlR36EOWikKJmO2+4b/7Lkimqne
 /Z5X798QAcU6oRifwiXv67Ftvv08gOeIgLlvsfm8XOAWH6Upq5yQx1HpihPoJ/1xez1w
 Cl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759330243; x=1759935043;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVdSi0KvObjHpPCH3YWc8HTTtemgo9ZaRLkbSjbusks=;
 b=HuAL4tyVraADNWYpEq21s92fjWF+SLxFq8DxZ1wGtfaCXR4fugdJzpJLs7/RWT1adi
 2VM4SAEISEGxfjZgs94X1wCykgXd0rxW7oi7ue5VCOh1nuvL+CswqcPTeq3WTY9OTRYs
 qZhv7b2cNmWCsrYPQPxiupRRQGgk1k/2hTQvQeTHexZFY2pKXmunyej+GlJeQBZ+ZDRO
 hSDF/erhY/0jtI+G0Ill15yuOhgcEG3RlNFC42JhV4amXvUsJFzKl8EYjQmOns0ln9cb
 lA4O3uyNKVvGDzeykJuQN9lsHTHg+VFIbbcHEFFHLgcIk3wqrNs9k5EiQiIMYLg+gZWC
 /Nzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVn4Eu7SiogvN0u53pkhpWCViBYwmmTwmQVmaAMjzqk2nzdPZEHLJhQanIrAKeos45z2yC671KnE4D@nongnu.org
X-Gm-Message-State: AOJu0YwFrpmioo9NXi4s7cZ54I6mZ4NdR9XemP1Bvbi/uys9/024m7ez
 2uorhXxnRe6d9HlYDD5E+Dv0iLd3Uoq/mghUyugyaPq8wPJ+9hb+hIP10lqdUptlZ4w=
X-Gm-Gg: ASbGncsLxC1UprHRXZHeJkCC5inpWJ/58YzeV8gfaEWG92xccivtRLoq0RhFsvn0fFn
 ITVas1+4g2C3LoyASBDket2fikHwStNTqCDjxw0mU6viehcImxwxmHONoExcgbaV6MXEcw4KOeR
 rq9w0y1wZbFSvkKEp8vU6Z9+PS45GjKWYHlU85A/OJIq8CqNg28s77xELXm9Qk4DlsfHnOwQmlx
 q1vyek6tQvGd28j3HjHO+Ma7eKR6fXUUmQo/TcUinAl0kjqtyHZMmdbVmW+LtSVa2oluxEaZw6v
 Cjhvre/4s0IWbRy1ZXYRXP/Q4jRQXLN7RDvjWtWjpAJXuDSrF0Ib/KdVLABZ42avlNRUZQ+dGoN
 Sp847Lgtne0q8u55M7NVAinjOMvAl1oVYr873DIvSMv0W2WuanSCFZ63e/edFX75nO4euE9lp0l
 wPcHu/vj3zYd+CiMeSZ7P5FiKRa8tt0ug=
X-Google-Smtp-Source: AGHT+IGYJjnRHP971jOpoaSCxdHiiMh75RCNAwCBtngj+/DFng4johjN9S8/ZT5gqGCxj/5KaLFSXA==
X-Received: by 2002:a17:902:ef0a:b0:27b:defc:802d with SMTP id
 d9443c01a7336-28e7f48a31bmr51198365ad.28.1759330242780; 
 Wed, 01 Oct 2025 07:50:42 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ab64c7sm186763735ad.130.2025.10.01.07.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:50:42 -0700 (PDT)
Message-ID: <dd87c23e-c2f0-4cb3-a572-6b202cc25fe4@linaro.org>
Date: Wed, 1 Oct 2025 07:50:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/25] target/arm/tcg/mte: Include missing
 'exec/target_page.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> The "exec/target_page.h" header is indirectly pulled from
> "system/ram_addr.h". Include it explicitly, in order to
> avoid unrelated issues when refactoring "system/ram_addr.h":
> 
>    target/arm/tcg/mte_helper.c:815:23: error: use of undeclared identifier 'TARGET_PAGE_MASK'
>      815 |     prev_page = ptr & TARGET_PAGE_MASK;
>          |                       ^
>    target/arm/tcg/mte_helper.c:816:29: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>      816 |     next_page = prev_page + TARGET_PAGE_SIZE;
>          |                             ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

