Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3201EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURNA-0003T5-Uw; Wed, 25 Jun 2025 10:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURMw-0003QS-Sy
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:44:59 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURMv-0003yu-93
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:44:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-23633a6ac50so26962985ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862695; x=1751467495; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HsXjxIRw/XwmiUnj3z1HszLMwdy0ICwhBBChPqPA9Bk=;
 b=hs85+ga8JvZekVarLpx+aqZTzbXhHy/D/Kg7eoyn3tpNxgSnT2cutELOMqHBlmD1fg
 QIfC1Eb7qEtmFVZ2zvcExhRa+XfkZNiX9b9Cyd8aZaKoTN7hprgIoWk2jmPPNvay6ST7
 LZIKnv+0ujUv80sPl8KXWmtHzFAqtUI6koqvAGlUK/Jcc5LOt47XeuoECNCWG4tlgHcq
 cO8BmKYtp3p7FEPn3AXe7TOlwmqtmoJt4Gd/F2JZO23Aap6mRFVS4+GarzHTchpoIWfA
 KswaCrZH5vBALURHv8UWDbVjqsoVIKhCK97JYM7MTg7yBJQgR1kxUhMWCq9RolU3Xbog
 mHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862695; x=1751467495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HsXjxIRw/XwmiUnj3z1HszLMwdy0ICwhBBChPqPA9Bk=;
 b=D0M/Znf3irEjIM83ozrqT73NRCEGezPvasjPjlL9x13EjAo/GCNz4xU2GPLpgvh7mO
 GCsPCjd7q4xTcmsFMVPEAKuBvq5gR56dI99FRdVvP4T8e9N0dGZHJSo48QQ3PKn/1FGY
 EJh6cNcPUFIg/vM2cILeR8HpbTAhwxYw6O9WR1EL56XLF33HMx8EfMzyvFaD6eptpit4
 gv4h1cn0KPR528asu5C5/9vqPrvKyG4NxTJdOu4bw2PzUuApFALf3CLgV5XT0NCnOPsB
 WMAOWoBVFuyElr9o0Gwkx8awZLic4uzKJAPrBnzctATt4wrhU3tRBBdgRzSz884aV1Ac
 pv3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtY5XHWd1/v2tm+651nX0O0PyqYwuneosOnhaBEVeULh5uJqJ9CREflZ/jelrtqxQnwfBePvgD918U@nongnu.org
X-Gm-Message-State: AOJu0YzDqyMOME/rutObJ7d88R9QOo3jCYaHuG3MTLfUBwQR33TVvL3Y
 RgwoByfM7+TY/bZO8KRdPoVvtEWa7JnJsc7kPZ8KXQUpy9dyJkm8usidLNHnJSG0rek=
X-Gm-Gg: ASbGncvLxJBBbQ26UobphvSkDUkwtAKMMbyVIen7HbC38GskWCmfZuNjwDk1H8WoDXn
 VZj9pP44SIV7nMOEosI/PyY3/tCE6rOieVpwZCs2J55Bl/JocQYrBczAgxNLQwJr35OkS7rl6R6
 5gFWJCk91rhACrUW2gsDqRsQw+wf5KUIH1DZeJPsKFV7EwhTAuHQ4YkGn6iOMmRxMAH2M4kJ1kQ
 xnwdYtzY95FlfYFfGxtZi2YbFkA0d0tai7yQD2KHuV2+aK4PboEKzuqILXE9heJWhxpdpPLS4IZ
 41MF4Dz+vPicfY5kdLEpieROfrGvqzcqTyi9sxK4ivLPY/vFqO+wE9wHzVJCqhbgttlK9USmyd8
 =
X-Google-Smtp-Source: AGHT+IEaKtAsrblQ6gqD5Oa1cqbiGe2vPN2tbuli1wg+zPwhP2l7cP3tfUN2fyVnkKt902LaGgCU1g==
X-Received: by 2002:a17:903:1aee:b0:234:c549:da14 with SMTP id
 d9443c01a7336-23824030ce4mr65154985ad.29.1750862695286; 
 Wed, 25 Jun 2025 07:44:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23809a8ee2esm41245475ad.227.2025.06.25.07.44.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:44:54 -0700 (PDT)
Message-ID: <a86fa724-f823-4fd3-9c7b-43e361fecb4f@linaro.org>
Date: Wed, 25 Jun 2025 07:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/27] tcg/optimize: Introduce fold_masks_zosa
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Add a new function with an affected mask.  This will allow
> folding to a constant to happen before folding to a copy,
> without having to mind the ordering in all users.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


