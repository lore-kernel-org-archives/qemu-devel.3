Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A55BC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJPq-00015s-FY; Thu, 06 Mar 2025 17:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJPn-0000wL-08
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:10:03 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJPk-0005RM-Vf
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:10:02 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22334203781so46839425ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741298999; x=1741903799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=50Yb4m4RoUbCo+jFNAyXQr1aRoOzdBZYd0J5HNF539k=;
 b=D8vBqR9p3zFAHbul0RItv7k65huuuw92jY9yUwXHHFBVBz16Y1fE4HExpzbT9Nldr7
 oHmQpujQPNUwyxN6wgjQ8DhqHbkQpl7pqRUQe/IAtzlWr6rrYubojDZpLUsY//dwamsu
 G/4UqRAX8YrwuXJ7hMCa2j4zHzsJ15kGdvjuuetS3swihZKt35NNeUw5dnpDBtr5Zs4i
 5N3dynNrlaDrew9UV1IJ2/vHqbty9Mc07lQ0NCrQDh4qs+eQnBLT/YtCm4Ul/Z566INz
 zV6B9HFBkCRINYaxMLxputSxdvDIlkQ5p75yfpRJj21aeoci+cM221RDl9n6pvAI5EhK
 /M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741298999; x=1741903799;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=50Yb4m4RoUbCo+jFNAyXQr1aRoOzdBZYd0J5HNF539k=;
 b=YL5fkJUn2BcgvL/3m2LnaANCW4uo3+GaS+GzcGfQDynyT4USh0zQXTK1TM1xkv4Tga
 rAv7vk2sdiMUk3DCISSiclsW6ohjvzhuJe5lgGNCdMxss8flCKBC1GNK9fuvs3BH8DnK
 mctTuyxWkRxBtCCoO64yDZ1hEHXr7m8aWF+KLgMCLfcE+hgLOuFX3Jg6mCQg68M/trHj
 +MwmSIdC7JBQke0/fWaez1cxkkuAmzN07iayZ0llD81/bsahQ6nfEwa2nYUW9IxJ9QV2
 joH8Tmv8rQfdNACyTRYd+rwBzEEvH1tRE+jSv5Si8RiREHW1cFXyvDxsHkJazcJo5/kM
 bfPQ==
X-Gm-Message-State: AOJu0Yzhs2LqugZEWpvGJ3WgnLuzZwNC3LAimIlN5/R4jm9r2s+fg8PY
 X0MIyb+dll7/jzp2kSAzTbLa58KlAqzNpDGSRZPLlLvrQ9ICYgxC42JSIYV0IFa0ghMr7YM6gjR
 I
X-Gm-Gg: ASbGncu8IRVEDf/sYRqfeU8sTp4AdZP5ClL81YOTowGpTE/eutapdc+rCeGEVu9I/if
 7fItn8rG/zF/cXepM/67Vp818nQouks9gKa7TkS9llxvem0QOmEfve0NuWNWYwhc7u6SMJQPtYo
 t9yFCuH2AwEBdbFdxRib2ZYiUBLl+5zEUniW4n1QIC34P18MSolRPfRGknck5E2oTPym7G5jg30
 5LYrNFc2RITJysnHkLIYw5HHbORUs4FX03FxrJNVTcXCW6jpmCsiRurORNGSRPil3CtzSOdf8Ml
 oSwHzramfG+E99Dbha24uHAxHYuCrmYT5aJKwOA8XAmOJ0U9KexIThhiqRZiWiR7CFR1rP+EQFe
 GXRHRbQIq
X-Google-Smtp-Source: AGHT+IHpQjcF1QnP1dhgR8zU3aXqjjbYY6xIJaxiazfPOHGoi5foYIFmMRtEd2XcSdlOFe3PLR2Eow==
X-Received: by 2002:a05:6a00:3397:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-73693e85ddcmr9941371b3a.5.1741298999456; 
 Thu, 06 Mar 2025 14:09:59 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736982456d8sm1874321b3a.46.2025.03.06.14.09.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:09:59 -0800 (PST)
Message-ID: <ade4a142-d304-44e0-8888-a0d61569fe7d@linaro.org>
Date: Thu, 6 Mar 2025 14:09:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] linux-user/arm: Remove unused get_put_user macros
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> In linux-user/arm/cpu_loop.c we define a full set of get/put
> macros for both code and data (since the endianness handling
> is different between the two). However the only one we actually
> use is get_user_code_u32(). Remove the rest.
> 
> We leave a comment noting how data-side accesses should be handled
> for big-endian, because that's a subtle point and we just removed the
> macros that were effectively documenting it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/arm/cpu_loop.c | 43 ++++-----------------------------------
>   1 file changed, 4 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

