Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02E2C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0Pq-0005Ew-Tp; Mon, 04 Aug 2025 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uizFi-0003HD-W0
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:45:39 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uizFf-00078v-2d
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:45:37 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b42099901baso3701426a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754329533; x=1754934333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QULKk5VRg6vYTt6QR41gbigymrUk/XulFP8x2GxxytU=;
 b=EBVx4TDCeyPvOzna+38Pa0NFftdahe3PopCQnxwMoXR2nPM7gXHqK2GhCyKp6lQI3T
 yz01/KxOwixop4KPe0JU9F+ZS3X9NINoEmBoG82iMlOYIxrLCMQ42kvyMEAASJmjldFc
 klzriPDfiU4AR+Ne5JvFVwnc0Zk2uTYXflrped9J6Z0TleTAvX/Ka06glAkVaqNLUewQ
 GGO8xBuhit3PhFp6Vei8BynoufsBbuouveJFvXYsi2F1efxu4KRxFd1eA5pIS0kWLsbq
 O8j3Y6DAZ2QCMVHa4BVDqPAT2JnP7GUSAYPOk+aslVj+wDTufEvkYdU2vtijt1uk5+Mc
 o7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754329533; x=1754934333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QULKk5VRg6vYTt6QR41gbigymrUk/XulFP8x2GxxytU=;
 b=Lr5Vco2TWkNEOGtIwisGAc+UVfz+jSe4RhSakzFBrdaAQbDu0uO5R3VdviorJi0gnZ
 hMyVAKs7nqKQYyXQuiLB2MB4ACuP5JQoxVzmDyWLtGWqJ6Ia+BJbpoRNGpZNLoUKGVtM
 SAXouz0rAQ3A53pwe5FEt2TfztSVkpTDNW2glkeX+3wcIETg738Ns1Cl3CIr0ytH0c9B
 4p0YTypjc4PmS581lGzOSvXdVHfMGvMvVAA/21uXAEiX2dQFzPJLW7bhd1rORkLWN+Pc
 1Gs4vbJ72R7DeMN9yJS34/lTLUuWWQzN5Iun8CooFC4zQJxEuAuCfR/ejssZSctu2Lst
 zqKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULigQaDSf0a3Ja7aA22TfjdIjqAekT9cjtsxuIJ89UChXFHt+DIjv8Q2b7UFc+QQQqqlDHM5uSAAiV@nongnu.org
X-Gm-Message-State: AOJu0Yx3APu8Ktm0VBZaGvzXCMP32ofBafROuzqJIXgbxRxorReDWNJ5
 z+to1ke8QTeUQ/Cawd5SwIvVLb2RUc2lgtKRsSLrz79FIJ0yoMQ4CCLonht7nY1ozro=
X-Gm-Gg: ASbGnctxeIq2rFgzff1LD3qK1tHdQiSbZSBJ+t/ezDO5EfFCrRkBQgMQhMHKIXueQjS
 aKFwlpZvsYs2f1Yoo4Vl84rJneNXRfeksaMD6gjdHvgGtFaUsEnvMC3sjcohq7D5/4I9Gzx+EzD
 iFnWwQZsn0PymiLpnvC7bhtpsVhRuxaclhQxgi56IuwlApPQ+a3IkP7SE9EW6YA2g64MwJQGoBG
 6LY2EByPoYI+9NWR+bev97VqFYuXnjFZd4w7oFSJST3XnuDO761L2pFN7Y+yQO+5/MKOhjx34SP
 Ho4IDlkQnX9N6XLh74Mv2FVuyz1dDtQYYkKT2uA0owiZ8yZQiMP30aukj/A0JVIwS68K8plCHaG
 I3AbvSgtHhyWwAhsb1FFpoj+2mO+M04x+Llw=
X-Google-Smtp-Source: AGHT+IEcsjx3vy6mOGfSElPa84rxzX0M8DU56PbwvGi/iNOJPbGOsWy3SWYLXmEOTNll0dPbm4zPyw==
X-Received: by 2002:a17:902:f612:b0:240:92f9:7b85 with SMTP id
 d9443c01a7336-24246e5fb31mr124019635ad.0.1754329533106; 
 Mon, 04 Aug 2025 10:45:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bac16c9sm9499161a12.36.2025.08.04.10.45.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 10:45:32 -0700 (PDT)
Message-ID: <c69d2467-01fa-45d0-8d12-5dbbf2d4e793@linaro.org>
Date: Mon, 4 Aug 2025 10:45:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 33/85] target/arm: Convert arm_mmu_idx_to_el from
 switch to table
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-34-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250802232953.413294-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 8/2/25 4:29 PM, Richard Henderson wrote:
> In an effort to keep all ARMMMUIdx data in one place, begin construction
> of an info table describing all of the properties of the mmu_idx.  Begin
> with the access EL.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       |  3 +--
>   target/arm/mmuidx-internal.h | 29 +++++++++++++++++++++++++
>   target/arm/helper.c          | 27 ------------------------
>   target/arm/mmuidx.c          | 41 ++++++++++++++++++++++++++++++++++++
>   target/arm/meson.build       |  7 +++++-
>   5 files changed, 77 insertions(+), 30 deletions(-)
>   create mode 100644 target/arm/mmuidx-internal.h
>   create mode 100644 target/arm/mmuidx.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


