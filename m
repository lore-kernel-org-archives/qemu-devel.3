Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E21C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 19:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trM6v-00017P-0P; Sun, 09 Mar 2025 15:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trM6r-00016t-NY
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:14:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trM6p-0008Si-Ql
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 15:14:49 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22423adf751so46606255ad.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741547685; x=1742152485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23yOkf5dgZi53mNfH2aRdR3dbE0qN7QGQCtvqukhGHA=;
 b=kgbmyOrcUzVLa9PPUkHAKCPsPKLWHvc3aJlZltsr0kqndS+nJ7c+8mZH5t2yM2niFM
 r3LgCxJdc50H0zGwfw8cJR21CDuxZl1SrJMvupSkv2kcp3eGj/O0nGGhMYHfwmpguRlj
 UPTV4nW0Ao1EdmZ5ajeRSsqbkCODONkBur2SAsuJpSOJUtUso7O9rG4wdsTv9TbpBVus
 93rxeJDWGOgUTN/EbU1nhR/EdWvA+vFu9hZv61NU+afsQsfLTejN0RQ7QlPPzW4+tt1V
 +uq/Mon8xnGPx7faKOibIptUWafi4ZOdpFVkNsP1eU/4JOegXBkj8APR7t3R1gfbrleW
 sSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741547685; x=1742152485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23yOkf5dgZi53mNfH2aRdR3dbE0qN7QGQCtvqukhGHA=;
 b=v3+fAw/VAM8ng45osq6+K/MD46eNKbNSVi+htRrAs2unhoqT+qL3/HrUoIwF2eQqHA
 kscT6eT0o+Wwx/s3fhHvuaLyiKkDxtsP/l12dpjkJS9KI2i/RoV2hxWGhTsKTINNujia
 bXHRiHjDbgzvbvyTip1s9r5YnKAWoIeftRS0lJytH3ghuc66mqHgFC5NOpB8oNqhtmrt
 ZMhw6P1vy9GsuPx6rHUjf6gAK4wlmdwLLkPtX36nX6pW1Sp8Aj1PpYylhtvUqy6oyTDn
 xp4PwsCYbQ2Za5GZ5l2ePSCyD6WngALjTTM0mMBpqiARbznPDEaDw3sH478Fb9JIY4T9
 KKlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrfM4i8pSz4QTyyLKRyb1ZL7aHfldAHg1ZBnXAIzsJPfwjR76WN0vHTdJJPEOoC7spOVEEokRx6KpS@nongnu.org
X-Gm-Message-State: AOJu0YzfkUqhhvEdxelrmd5C9t8SM4EToG9bZy1UJ+QYEsg4np8XEh1J
 +BA8E0SXzY3M8O4OBEcdx4vKhF2yYb0Z2m2lhnVLLyYoOa7Y1dI09dKi1YcGOta3FRZ1K6Sho3O
 1
X-Gm-Gg: ASbGnctttDI1Fb2YZfa2+/EWEKbicb9BX0K3lsiIhA1b79wZsxMlwPFJWZTzj+KfsQ5
 NklYBR/JGqfDzIDugcfOSb99Wf4TV26m84W6WSUHHl1mIuSMYFDan69KUeh7g51JKQnAIkRG0rE
 D6SIp+T0eiuCcGFU0qXq9qLm5fJn9ztyeN2LBvDmRIi7qc2H4FEhaSE8EnFcWmUoqftPKCqWxxx
 uq7cH53jxqjX/E/p1PoSGMj+cW7iQyjWIVVPZ7bxetnuS5fEt5fVf1JBD895TuMss72TLa6V4Bi
 nf9v5VRbl9Nlgg0AuQEGLelC+THO4LtH5zOn+BREzTPgUa9TRmbY8b2JoXjsc92h+sXHX+rzpNN
 CqBk7PxAE
X-Google-Smtp-Source: AGHT+IG30J8sdWfv0GW0HC3Y/AGSFg3V7eWJd4q+s5kO8Hr1OFPe7qSQmdTzzFdu1gXiD7OtloBpEw==
X-Received: by 2002:a17:90b:2d83:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-2ff7cf317c3mr16092052a91.30.1741547685670; 
 Sun, 09 Mar 2025 12:14:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f747sm62923515ad.127.2025.03.09.12.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 12:14:44 -0700 (PDT)
Message-ID: <e8584c67-0006-4b30-8987-6783874e346a@linaro.org>
Date: Sun, 9 Mar 2025 12:14:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] qom: Introduce type_is_registered()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250308230917.18907-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/8/25 15:09, Philippe Mathieu-Daudé wrote:
> In order to be able to check whether a QOM type has been
> registered, introduce the type_is_registered() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qom/object.h | 8 ++++++++
>   qom/object.c         | 5 +++++
>   2 files changed, 13 insertions(+)

Does the non-initialization of the type matter for your usage?
In other words, would object_class_by_name() do the job just as well?

But seems reasonable, anyway.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

