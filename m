Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6BEC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9PV-0005aD-5n; Thu, 20 Mar 2025 02:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9PT-0005Zm-HF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:29:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9PQ-0002KM-LT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:29:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22349bb8605so6710335ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742452179; x=1743056979;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OsKouGqaCLWkulgpWhE+23G53JRGkHyXy93jpLs9qlM=;
 b=ns0V0dsN3pFxzoBelNN5w9yi+1wN75OF24/2j1LHO6VeNJ3FsItLvjYCJbRZi7h2lZ
 T/0kljMb9liFXvxA6v8oqrEARxIss2effZtxnx7RKhvuWxkwVcfxAxKh0uwzz3Jo2+eI
 7C6szhAhIOrJDegZ+5155d3agnvTpsVqNEDq4QGDHopzrQqRv3K88QBlMd8Anlmg9I4l
 7xno31G9EFSsxxkrqG0UCjzna1tAuYvvXMRKjPAHZP/iBOC9DTwt5FqC5GjYSMItO9cc
 4gPi2xrzJ7Q1d9WHRc8p2Wv2HelGuhZed/u3f4K8z0w/NQA+zIq9/XwYRzGo8kcA3i4D
 HauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742452179; x=1743056979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OsKouGqaCLWkulgpWhE+23G53JRGkHyXy93jpLs9qlM=;
 b=AzkTYjMNTIDYWVty1OUhHvLf6G47Hu7X5vW4j7K4rVRIum0luCeICioenkMoUX/uln
 sI8W7DcWYohP4X24CNrRZzzbLpiLm1i2Id7zYhACnvCS51fcS8uehqZa85v3+vzdqLrM
 9KA1HhzXLd40wh7INlu8mTIu1ZNgOyQ0jM0CnQ7dWZZAX9jUExbsaYHuFpccQSH7oM8g
 TllhElsQMQe4ugUmTY7mLcCFOp8oVgdm9jTkZfMUWOeI2qdbo1dodpoVYgiTJzAwDhP4
 oDA+/DGqr8Re1Mp9Pf9MWe/uI4qyx+3HEyy44ML2ng2FE/TBqbUJh5z8ma0rfus3brJy
 j/BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUymQ6MVTNxUtCIlHkgN4m1slvbGfJ4AqUEwiH+hA5cXD3rwrzjpLDf9ahwenM7BtS8mN/ouA4/8Nqg@nongnu.org
X-Gm-Message-State: AOJu0YzY/TTY1ppg0nA2gG6YI+Idjcc0v2HngRsDAYb6vRChXwAHgF8O
 eT4j39wRhNwMe1DbeiB1tzdiof6rAK8uzgom539QGW5GRcfHuiMC4O47icDDyXU=
X-Gm-Gg: ASbGnctRjtv3EwqC2+vttrVlej2btpWJEA1Zkg+ECaMFw6llY6IPLnJ6biSh0vuYsNk
 P0PCZbrz39FFSLlgaG8wLHlln/73/yvxQbial/r98hpA0mXD6yivDKWA9qaIsj30jrZmEtBk7VZ
 5qNvZxdgIf4ZlvweujAVI0MONmgfIJEg2MX5Bentx9dpz2W8J25G9+7RmX4xD6+hNVDnI86E5T4
 9Gxp7CchrHYQ019WxXjWGcVq+Y8FliERny74e2WsZpQ7j6swIZBz1lOcDjD2/nUsVAhWNS/6Td/
 8vU2Y50DipYj1DwCA5DWHP5lm6SRwQN/RgT7ID3XjE03x9+zTQl0fhZx5+5khq7eMfGq
X-Google-Smtp-Source: AGHT+IGHOX9vNF7XnZZyvY2KJZ20ta6SLhASwDBqJOKzBDqm+LbMa9sJM/BWYcz/0yidLVWwtpI7aw==
X-Received: by 2002:a05:6a00:2382:b0:730:d5ca:aee with SMTP id
 d2e1a72fcca58-7376d70d09fmr7028809b3a.23.1742452179085; 
 Wed, 19 Mar 2025 23:29:39 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167e02esm13274993b3a.95.2025.03.19.23.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 23:29:38 -0700 (PDT)
Message-ID: <d3688ce0-e2f3-4bee-863f-dac7a394c789@daynix.com>
Date: Thu, 20 Mar 2025 15:29:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] include/exec: fix assert in size_memop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@trasno.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250319182255.3096731-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Updating the email address of Juan Quintela according to .mailmap.

On 2025/03/20 3:22, Alex Bennée wrote:
> We can handle larger sized memops now, expand the range of the assert.
> 
> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/exec/memop.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index 407a47d82c..faed3ff902 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>   static inline MemOp size_memop(unsigned size)
>   {
>   #ifdef CONFIG_DEBUG_TCG
> -    /* Power of 2 up to 8.  */
> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
> +    /* Power of 2 up to 128.  */
> +    assert((size & (size - 1)) == 0 && size >= 1 && size <= 128);

This is the minimal change to fix, but perhaps it may be also nice to 
change it to use MO_SIZE.

Regards,
Akihiko Odaki

>   #endif
>       return (MemOp)ctz32(size);
>   }


