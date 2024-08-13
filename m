Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E650C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se0b0-0002ij-Uv; Tue, 13 Aug 2024 19:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ay-0002f3-Qx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:06:28 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se0ax-0003Wh-7e
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:06:28 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-70b2421471aso3759583a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723590386; x=1724195186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+v1hql/NGE5shbEUgD1ehfnA7p0tOVctuNHo9V6HDbg=;
 b=IP2W4YkZzJFoA5iiUyP7WPVX0+vD5xiHKcxroYkAeE2IqOAef6NYH7xidvkBoZ8iUQ
 C76srE4hgkPxInTuQ9THz1HnkvYwAkLdF4u5eXeB7gD+6TfXVfRiw9YI/chfCiYgMSk8
 SauSHAdOA9xiv4EOAZU3rc3CHiN+uh2J2SrX7fGD8El3hJrS7G5v7i4gad8vtqmvWLBM
 JRo09dlu9Xg+G6Erm7+yVZtkVIfyIu4DUnx7mdZCwQF3IRJZVlGWpM//um5lFwrjIpfd
 JaEGnNhqMbhex5/EeykxJ1H0sT4Ggp6u1tdgFfVO9l36Hp0Sklx7YT41vicpvBQtAy2k
 nh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723590386; x=1724195186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+v1hql/NGE5shbEUgD1ehfnA7p0tOVctuNHo9V6HDbg=;
 b=eJETYmvo8i4we4MgWQEbAFWxHhtjXFeumaeAZTYDUAp/31LrG/hvDW7y1VeeEI0Gsm
 ubPPocGX85i/0draX2Ov9idBstTk4/bXYgJcmVJspAUH+H4y+bmeoNreURPcXcq0l3+u
 2llioyhsU4ylC84AGESLJGI0t22DrCtabzDaBVKktIqjYoLXLew/IZlIyYbOCY/k5X2e
 0wKfEHAl68Dai6C7gX+QOIhRaXpYwNrEOVPZLsKfqbLMx+yNLMwOZGcclg201NVRnphb
 GuDv1QOhxon31LW6Pp9EZdGtnTaEJzbKkcOKu5B7WRz6tDtZi/Y7hLsvTK9C7iblHBO8
 oE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Zu0hB4DanY41jLcb3w3ExlVrsEV/fNxw435BZG3gciGV2sMN11Fw8uyDHWhm2PGhlikf7KAdR92f@nongnu.org
X-Gm-Message-State: AOJu0YwiNAjfLuAfCPsnLLAzujq4TJ/2AOcSd+Qu4MRnyLQy4hMnMoAO
 DnITveLE3G5MAKH45vk+T+TFarHxYnbtIx/Jbfjk2TDb0F0ZqIo9YzzDncTmCTU=
X-Google-Smtp-Source: AGHT+IH0Vot78ZOrJjMRnh1vu5Nk69pSmjuyvS+t9jLMnpUsBwao2PRBHvUwusAMbxlMCwzK6vLPgQ==
X-Received: by 2002:a05:6a20:9f08:b0:1c4:98f8:9ccb with SMTP id
 adf61e73a8af0-1c8eaf54534mr1472279637.34.1723590385303; 
 Tue, 13 Aug 2024 16:06:25 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5873086sm6219172b3a.20.2024.08.13.16.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 16:06:24 -0700 (PDT)
Message-ID: <ba4b1d86-4684-4d6d-bd83-8cae18adfb7c@linaro.org>
Date: Wed, 14 Aug 2024 09:06:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 03/10] hw: Remove device_class_set_parent_reset()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813165250.2717650-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/14/24 02:52, Peter Maydell wrote:
> There are no callers of device_class_set_parent_reset() left in the tree,
> as they've all been converted to use three-phase reset and the
> corresponding resettable_class_set_parent_phases() function.
> Remove device_class_set_parent_reset().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/qdev-core.h | 16 ----------------
>   hw/core/qdev.c         |  8 --------
>   2 files changed, 24 deletions(-)

\o/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

