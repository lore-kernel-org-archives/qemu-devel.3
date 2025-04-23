Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CECC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7YFs-0004Ba-Ks; Wed, 23 Apr 2025 07:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YFL-0003xR-Sn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7YFK-0002x0-2W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:26:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso59168295e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745407587; x=1746012387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDdacHs81ODyaGveLMwXgwwF0FL1GctGivT/nuO5Y0I=;
 b=TbRKBuHwUamH1tN58+588TkWiadxLMl1WRTfz/Jbzpatb5JDQo9fJYEan0vG4u4LCH
 94h67nMJ5SSrVCvGJxTlWgus2hcB7Gi9sUDH4krOJWPOJXkTLml3Taz13lpQtfvHaeTj
 wv8oown9t8H1t9OfNi/9YgHO1J2dSsOWN5dm9tZSi1Sv1jcnkVhGW8NY+ci0QdXy4+8F
 lIqHbhOJythMwLtrMO+QI909iNuUePn0YpQfAifiNSrf/QXtzbZV0eeJV2n1KOu5JVTZ
 p5KKZDJA+lf4vi0yQV44qtt/M4MMs7wEHvrZlydwpk7KpQvu8dr3TeO8qxPHb0bPQD5L
 YQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407587; x=1746012387;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDdacHs81ODyaGveLMwXgwwF0FL1GctGivT/nuO5Y0I=;
 b=p8dzaFCIF+mvs58oBIwtc4649fQHKmHLjojsrfJt0eWHWjwzrXFBOSHsBeFD2mwfo5
 TblKFBw3ftYnQ+2FDtToWPX2/vL+a1oZSTw7SXb6symyFU/hRR2BVBcdsGP/ulPeR0XT
 CUNZmJi1aqngKHWR8GAfu/dsmNcVhX4nUuZYtzszXeDxmDl3aDnx5QRZ+l+1TkL9XLt+
 h3/MI2dJEZ1x/Xs4WOQn0Ph1wOpGIsVDUSwcYvZjtdp+zpuXNTKxEtXYZuHKQMY0SP5T
 K/QxrwY7E5EIEsNOPcfQl2IkofIcy8G8TLSqaAVjFsAQlAjb7ImaeI5wIt+ObTqGnlRa
 atTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt0WDl9p9FVIpc4zeVmiyce3R/27Q4hymjt++0KMOm7ix+A+P87Ct8gunmPOALY8/CzGfGh+T7VD9g@nongnu.org
X-Gm-Message-State: AOJu0YxcVQwVqWUxH1Bak+MwG9+zz12gN0bVS5+u9jykj62Av4g7rDXk
 W155qkKcqxzV0GKOxnvezkJ5fWmqHjQ6LVt6jcay5ZNAoIwNHfiQzrvx0h6TAz4=
X-Gm-Gg: ASbGnctcpmKa6z+Be8E//EOS8QLUgxJH6AsoMZUSsarKtVrzVE1MG/kOcamqd/10gSZ
 CGjmMQzV2znVjpuZbwx2CVQ/4CylRBDZE90+csgMXCyhn2dI1O0fNDSo7oJo6U/rix2gOExXHN9
 dmXDlDx6HtmtHGRzFkQYivN9frNROdtVy1lV1NEmuvGvgF3BMimmhLnkU6GXXjLkHlnst8mgZT9
 NBLr/BiyK+B33yNSD2gyF+v/xoRl8umTLKseSzDMe7Ip4RFMSB8lFU20sN8dg1UcJaF/j+eRtW8
 1d5oIYNeXwPA7IrLiouX/NF6v8IrQOmXYL5R5TT2PLEdbw5flapwmhGps9cXkvs3/tlHVz6nAMX
 llvJLVlEL
X-Google-Smtp-Source: AGHT+IGqkJ/PUUcBO/yrs7MdKLw8bIeJdunnM2JInc4oxMKpSJqxb8Z+VuPtQgPOqHLelVd/9lPtgw==
X-Received: by 2002:a05:600c:a4b:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-4406ab96871mr186753195e9.14.1745407587418; 
 Wed, 23 Apr 2025 04:26:27 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092dc229esm22773755e9.40.2025.04.23.04.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:26:26 -0700 (PDT)
Message-ID: <c2fe5a5e-1bac-4857-a306-7c838aab40b2@linaro.org>
Date: Wed, 23 Apr 2025 13:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-10-dbarboza@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423110630.2249904-10-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 23/4/25 13:06, Daniel Henrique Barboza wrote:
> We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
> strings for uint64_t and hwaddr types.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


