Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2A1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhE84-0006EN-7r; Wed, 30 Jul 2025 17:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDxX-0001yr-EZ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:03:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDxV-0004pw-TC
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:03:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2402774851fso2919895ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753909412; x=1754514212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mLqkvMWORNfVerEKRdyrpJ4UAqvOqoRlGSAv+02Qx4o=;
 b=Vk0JoepHARv2FPmhO4F2kQEqeMzqIdzxU+0GgekBv5mkNwgzjXXLfBpCHX/C9WyfYZ
 Naz1ECLLJaXeWsyS09oaZFYK9E+dVvRaSTZ8IQuddnHh+lEtdL4H8mwfmmqeU05oRgwH
 im3nXjmM3ybJyhJME1zQroM7BtQYjYKAmF44d4KY9ir9T69un51EYNQc0MGDc/1FqPdH
 JCw7Oq4dHo9VXuW1+OP9+j1VRnLSiLk14JxW++Vq8eEZE/8Dh6RbrS0dDQWMw04LYX4d
 FgDshyRU/o9zK2QVaFL+J8pEl9USseoHW4nkOJU6iy+XPJ/pXu1qlm9x+FMw8xmx3Nst
 2xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753909412; x=1754514212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mLqkvMWORNfVerEKRdyrpJ4UAqvOqoRlGSAv+02Qx4o=;
 b=meQJHlYOpFXShkXR5A3q82ia3/R9ha/lmXkgN/zL16IGl4wJQADHtFcShXuzEk/R+V
 iThbnpMvdKM0E2+Ffp4czFpOJnbVgs/ny68DZDiWWpMB6M8Oh/U5C7TK7IIat9iM2icS
 j6kVetsXLreZuFQCAsUTDgOnX4yQE+E3axBqgBjznquw9YshJJgCHMGdfW/zzFshKYa8
 0CSK1qQ0dr4XrdPA2HZtTStyHsjAAIAEa0nM6/pWuAhpis9gXksn9qjb73iMVgQ1Yp5i
 SVnqX+r1jMYL5T4z+1dm5nTvzW/MK+6HDZfc5mSS2OarHHn1/c/mqteF+yETloVhMQO4
 liNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmFfhuo8A0p4T5PPdEvzQyyCFNrWv8IVoaaze5A3N5IYd1vaIrKadaoVNdvu4yEnZS/2sLNXuqpdeZ@nongnu.org
X-Gm-Message-State: AOJu0Yx+AZN7B2MXkXoHLcxQzcO8UnQIU4RBVjfpdjOwBh+TwCr01tnP
 HrsziT/EseCVCwvtcqbMpHoAVcpWgxANWrZMcL7fsonqaW+HfjIJJgphtDlaYt3qM1o=
X-Gm-Gg: ASbGncvzzbykkDm++4AmA2QITwMlHwIvBzwFyLoyHCEyAyEssbUDITJnBs6cVwxDAmR
 PBRdisON3F19GZjlRHyncEZDY5xsn7U04ofsYgFpG1300PldiR9zeasb+zwrHC62yPqEXNKumtd
 eqcWT+CDE48kiAP0ylF0ZLTGCrX/KBlD1iiCGa+o+mGyMi1Uk3sOc1v9hbwCTfLB03Kc2KaRuwU
 dL/bQIRoIX9UrI264VD961WTv78hLQUccjgUfDGN7cNMtYfcuS8KsYOxK7gJ7VOEjafGRNzNyfF
 yQ59Odg3qKk+XnVZMxc5NHK6yr0LO/Bb09NoTK6hQGY5/M1cLREd7g8BSobEbvLv8gdf1rY2OeC
 8dIcJqlKD3TNJJY0s446LJP9c4GKp5yAS3zM=
X-Google-Smtp-Source: AGHT+IFaJ8RtOl/HPrOIRWcU6E18dFhsE8sOkM8Ov8Lq/YnZJb8Fe5iy8+W3YwdKoJLAruoEdXZu4w==
X-Received: by 2002:a17:902:ef0c:b0:234:9092:9dda with SMTP id
 d9443c01a7336-24096b23907mr87757425ad.24.1753909412108; 
 Wed, 30 Jul 2025 14:03:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef47f5sm422205ad.10.2025.07.30.14.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:03:31 -0700 (PDT)
Message-ID: <271f1334-48bf-4467-9449-2268657ddbae@linaro.org>
Date: Wed, 30 Jul 2025 14:03:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/82] include/exec/memopidx: Adjust for 32 mmu indexes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memopidx.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


