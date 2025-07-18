Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB7C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctKF-0004SY-2d; Fri, 18 Jul 2025 18:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsjE-0008FK-Vm
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:34:53 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsjC-00051J-LY
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:34:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-75001b1bd76so1717425b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752874488; x=1753479288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lDK8BMSxoa1iZ3EfA/s5tzZ9b0JEgVHWkas8sQGa8QU=;
 b=GBy7Q5wMLS8jdXhkXXiZ1w4jOuO7A6Kl+XoEuyThKx9WJ8Rxdnhc5ga+2oicmIigAK
 DNjMJRQpu2b/59XE5N0/mHbHsO99tosoJtG2zeBUteCklrya//EO+l/U7AKJ6vSM/zJO
 D/pzYna8AtupKC+qtXysQAfIcTaZsOV4R7vCIPMBgtd34ruzAJKKgZSHIHFwezs4nEvl
 SNoT7p3ZGkeOoalJnCJvoAhfDTwe8pPW758Ydoh+/c6cARlI4DuZlGwtAXjFTPuBuxV4
 F15h9puTU7AnhYmjhyAqI8lEHUhYhpsAnqFg/aNq2EKnVY1io+n30xQdVEDS6nl8a3dI
 2grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752874488; x=1753479288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lDK8BMSxoa1iZ3EfA/s5tzZ9b0JEgVHWkas8sQGa8QU=;
 b=W9UxDRNex4TX4X4gow3SW3+ilkbb/1Q+vthcRu7AcY0wpUgl+9qwW5EKLJqwGnX3L9
 qX3YYPXV6GBIiEXnWVlid6FQKFeUE6aBQZ4gemihzlYgGFRmS5gCBnl0qaxtT/uQY9Vk
 8pfGaPDHcaVBALDC5cxsBea+l5DDRrzeHp9dK4n/QZrtMagMAx+wFqgsBhYwBCt/4KsR
 iOQ27JQsdBOrNvgQcUNaI4e9fs6d4vocuuu4x3KL0WgRiMQBY1OIFwhxh7at8O4Y4eQk
 X8zhzwtTnKiit6UqD5v1gY/vh1xqo72dL4kdHy3ZK79z5j9W4GCiJxWnVoaKE0xiXhXD
 mofQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj9UugWqIhDfeEGhJYK8Tw8qwTmpMjYk++Nls0Gz6gmp5RtX8e16OKMw/O1tbH/uTbL2+suOHDh7Et@nongnu.org
X-Gm-Message-State: AOJu0Yz5zyNt4C1EDJz6Ism1wOkil/aVbuTk8zIwZVtO76LTUTZXIs6E
 EgMybU0dIzj0qy+GqsnME2E2F9BwoDD4ybrKIhN5MYEkNCwLTJyCIpIX4WREoCgs5+p31nZJK3Z
 ki4dI
X-Gm-Gg: ASbGncvWrpZddHaBAXTyyVXVS6dKPcYKskHXiA0cJ/FBGCIVBzXI5DTOHuQnRMlU4Gw
 6zwbrfWjNiUeYnRZeGFZKbdchjGKWURaxaLpHUrq5D2XYbYy81+ibkRSQGIRY7Hevd3nHNnyCCs
 mGASj5TniLmX7e/lMn011k07cPwvdmtS3iupcFN+90NuwHYqIaIkyVWAGAsebU3f24xVxd6AFcx
 GIqShrPvzif0GpjuC75AxM2prruQkfD+MsGw/kbN33pk0lktKre/AQcS8P9AqJrqJBod9zyt2/c
 2jAU4QXH9UcrewbpYmVajgNbssjIfym2ExEbFclM6zQ3RweRJ+eGQ4SFa/rBgfuf01+2l268RSN
 AQ7haXD3Xy6bnxeXRC6tzfavI4oujO5lwwLZAQxbQfA==
X-Google-Smtp-Source: AGHT+IFtMiePl2AMdNmNIWaMAwbyGbaHmBkHovL3w/+keJiutxV1rm3AZGNZcZLjlL0C8NivMs5oDA==
X-Received: by 2002:a05:6a21:a344:b0:220:10e5:825d with SMTP id
 adf61e73a8af0-23810e50fe4mr18750881637.8.1752874487666; 
 Fri, 18 Jul 2025 14:34:47 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cb76d69csm1769135b3a.102.2025.07.18.14.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:34:47 -0700 (PDT)
Message-ID: <b1677ce1-637f-439f-b52d-ddf53d32d79c@linaro.org>
Date: Fri, 18 Jul 2025 14:34:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 03/10] target/arm: Add BFMIN, BFMAX (predicated)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/18/25 10:30, Peter Maydell wrote:
> FEAT_SVE_B16B16 adds bfloat16 versions of the SVE floating point
> (predicated) instructions, which are encoded via sz=0b00.  Add the
> BFMAX and BFMIN insns.  These have separate behaviour for AH=1 and
> AH=0; we have already implemented the AH=1 helper for the SME2
> versions of these insns.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    |  8 ++++++++
>   target/arm/tcg/sve_helper.c    |  4 ++++
>   target/arm/tcg/translate-sve.c | 17 +++++++++++++++--
>   3 files changed, 27 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

