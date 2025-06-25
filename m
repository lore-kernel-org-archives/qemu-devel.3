Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664B1C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUROP-0004Wn-DT; Wed, 25 Jun 2025 10:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUROG-0004Mn-0T
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:46:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUROC-000548-Fm
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:46:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23694cec0feso18988365ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862774; x=1751467574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qavh88NuBIiiF5WTw/VmZl1CG5VPFiMvAsaeWRvi1nw=;
 b=xiXeN2TCpdUwq1RTSYBlJMtqB0SmlBHI60FVqTeq2GZa94oGj756wP1tcl2z8ZEVTl
 h1qxmOeGj7E6rPb1SAfq/u8ccnMPIpN+zid9H6hvGJF71REFTljEwHGKXWPt8lLSvR0x
 THYNJCYChHLUpfW7W7vRRZl9be381B8KIhK4gUG0aL74hcsHmebUXJvZ4MgM4n+vhTeW
 B2vAR7XHjPLEI2rmThdIl8zQ1ZgDfHoyk5EqpOmZnfCcnHNjY4cFJ+d9i9AR8QEBRFB9
 hXBcYOi1j5IeI8fn+oSCm1TmAhjCld3NRTVbEX67lDb1v+KbhdHMf8zP267qkVlAE81a
 yXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862774; x=1751467574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qavh88NuBIiiF5WTw/VmZl1CG5VPFiMvAsaeWRvi1nw=;
 b=b9pWqjXeWvpYlcVVDa6vaMyq0oe45RKCiXoShF9bAa74jmRsyEMBQfpwj+Uz9ZsqrB
 o90QwO5JKrRgLut8h7P8Z/MWgFSqbd1C0Wj2My5YnHVRTrV2/kPhW0zx2ka5uwVXGem2
 XzF75ApKyNWVpbcR12gjWU3wsii7YnwrvreDoh9KOSA5YMOR+rBvMlN+oeBbj1Bol3uo
 hT6Ry6mBYPUWFU2N1o61eHhRRHj/Z4UHWnmgj/rlbJXypxLGjd7/uh2MEU2+XO7FYWgl
 f4T21rbrNoAZ9Fj9lbJjnhilCNDXQ6gPS9zn/CrfkTI6+cxRf/tpzKMlPsc5bc19k+OE
 Mcfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZuz/N7MGanP18LpBoZgixPAFz8muvzv4g5t3TDpDCRP1gOXKICjX8OL0GoJ8LK3cwkxrWeuNC5kME@nongnu.org
X-Gm-Message-State: AOJu0YwCro4KgXp68wis38pkt5Bxpvmt52l/BRuHgnb1jHM60M74OlnK
 Hcfm6EKEp+yL+sc7SFwBlutUYbA5IHxXT7hc2d4SBw9w9NpFCz8bMbapyomBacBXlR4=
X-Gm-Gg: ASbGnctQo+jj8E4+BO9dHs8GC/K4TObRc79GQrgBetwDbbFh9nsFaEom5tJo0w13Y2F
 z0LWDJr/hiM+qUPmcrFN1IARQjUw+Ijdo5lO+93N3qWtpR0wNIngzn8/50JbSlctMn4aKnH1bbb
 wZAxUyWLtRjogFgE/x9E1e1o1e9kKdTc6sH9Wc8zxVd35N1go+xWOhFMx+s9W72C5tNX1aqcXtq
 n1kYCUngSXzDDNC4qC4rwW6S3jXcPChmYKc6zO1rg7WIHzjtUEdVexFphQpElqWYe+IHayUaYyf
 MPW/LkIqHBhC8Tj4IbzWpBwPK0Q5AoWoyL4NxKOwLYRe1sEHZ3PRcnzv7hW3nxxxT0/4Cvcy0a4
 =
X-Google-Smtp-Source: AGHT+IFXUhUMgJjTLY5kjwSQRjB1pkCY4PqXMGuxGjUYxh2KdadA84Qt2ARcrT988FPCrrTEJkBr1Q==
X-Received: by 2002:a17:903:230d:b0:235:c973:ba20 with SMTP id
 d9443c01a7336-23824080791mr58259115ad.49.1750862774468; 
 Wed, 25 Jun 2025 07:46:14 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83ed5f9sm135565515ad.71.2025.06.25.07.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:46:14 -0700 (PDT)
Message-ID: <14112b09-6fc2-4639-96cd-433d6d99ae7d@linaro.org>
Date: Wed, 25 Jun 2025 07:46:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/27] tcg/optimize: Build and use o_bits in fold_and
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


