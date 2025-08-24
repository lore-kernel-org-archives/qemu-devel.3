Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C5FCA0FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 23:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqKOG-0008Az-Ff; Sun, 24 Aug 2025 19:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqKOE-0008Ah-Ge
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:44:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqKOA-0002QR-9n
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:44:45 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-770d7dafacdso541674b3a.0
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756079080; x=1756683880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jVnPNcDvyMSXZiQDSJ8Yr1Y6SUL+XG4oREAaOWVXMLw=;
 b=j/0pLf9q7/TdvV5XHj2Acyrd+1g6cxIisWeU01lNH33lx/g8I7bCDecVAhmKj4mDir
 0iZd/yERYPss7iTxgGpLBAg+Y2t4HjHMkQFmeI8//xCs+I4v6ml4J48GIALXINNPvhoH
 fQ8ueNwxUG/BdfgD4dZB8IPTnGKrklicS2Ws/WoLQH1zMHlQhLonsyEEmyxadhiyCgoK
 ot6ycE2K0+UGoO8s6DhgcIzWskcLV9p805JQF21/ihbcQgrGQ5Hg8WZ02lVxFGDf7UaF
 LwU5FXdFcqSCnVNCiKUOQco7OYpzgsHJJO6bvdzapMOGOeIAZDqsvHrDacgiX2yemhbC
 5b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756079080; x=1756683880;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jVnPNcDvyMSXZiQDSJ8Yr1Y6SUL+XG4oREAaOWVXMLw=;
 b=nJiKT6/j+kE8+V4rvQwXL/jsKg+tOs8V+u9TCKr9G2T4SA3StuhI24/QMgwTAwpT6A
 c6Dptt1mtPohLAA5pDzA29oi5fGlAEN81RCP9DYaClobHK06ZqyPiVT3Lz5GYZVB3zDJ
 f9Pi2xlSvIFuSU99yt7rknR5aKyzn+044zme52lIgrWDgikdU+gpx4jxpz4k/EvGJUwG
 5B4RoJYe0z+3/vAAIDPPhi1cH3RaWyU7jZuWMAyjwslqzIgw8m3XwTNPPX6mEj7farQ2
 iInTO6YUciFazDsriSIwnGxp8/nTeRjkl2B7IcinD99eF6jqsMbJizBqu3CMNX1UAMVn
 2EQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQXjzS/l2Epu3xzB/R7Kc2zmZsEELjSZhF1GE0KrZ2H//tY25T6Bzd4fVizvNI/B70jzewbEXKazSa@nongnu.org
X-Gm-Message-State: AOJu0Yw+oJ/ipfxRJBo4TrGjo9uHY3rd0eUq3YipHgXGFp3yqjRsNuHD
 KzxpldxI4CrYKC+O+Afo+9aekjITQ0JOYjpjEGrBiry3Ci4zAhiStT6WDo5DdxZefYc=
X-Gm-Gg: ASbGncslz7NeyYckCmRnSIs2iqs+5cFe2TLObZf2M55wMuAZfqd4tARWtsBiYQQYb6H
 ZjETHdVwlEcDinn9SeBfBZ3ndjmzSVBM9j4u4Bx0pcWpuBS/rJZ9HKp5AXYjbH8YhrjQvmvdvHP
 9WwXrCLH1cxlH+7KQduaqvQgg8nH0yNQwkwJWQeOjKe+a7GImV07miKFRaSX21sii7PnzBjjGxs
 jBub91GtQQ52t7Jy0/JlIM54Fqq+k/KcH1W1R+DxYnTlOH7KYvVE2BwCv17dIfbtoQDeSVofpK+
 nJplIRf6YcpUiVoLtyggZ7mKXnmir0pHu4sWmjME43h6av+Up5HvXUdW//bR79EMlHM784ozd63
 bf4aNgKjqsEQC4pgmCcXRm5CB+sjiTM7ym5BBAGkQUYJdJejRJ0wRX0U7xDEx39ija0UAvE1RMg
 d0QnGYNTfWCwAVavpGnU+oULAdsahmwmfvKxHV6jmpS4Kopc5yehEiJ5tbV2jx08cr
X-Google-Smtp-Source: AGHT+IHlBFDwK/DJr4c41lOM0ttJIZ6l6vm8IDAlG+1PWTz0qOEu1PIrYeIpzOxNXr5jt1FCIlOuFg==
X-Received: by 2002:a05:6a00:3988:b0:76b:f8ee:4eaa with SMTP id
 d2e1a72fcca58-7702f9f150amr12740203b3a.9.1756079080425; 
 Sun, 24 Aug 2025 16:44:40 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771cd49ca97sm1385127b3a.86.2025.08.24.16.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 16:44:40 -0700 (PDT)
Message-ID: <764b48a4-6cf7-408d-afb7-503348906789@linaro.org>
Date: Mon, 25 Aug 2025 09:44:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] target/microblaze: Handle signed division overflows
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-5-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250824222734.4151956-5-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 8/25/25 08:27, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Handle signed division overflows as specified in UG984:
> https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   target/microblaze/cpu.h       |  1 +
>   target/microblaze/op_helper.c | 15 +++++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 3ce28b302f..7dd86653f0 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -87,6 +87,7 @@ typedef struct CPUArchState CPUMBState;
>   #define          ESR_ESS_FSL_OFFSET     5
>   
>   #define          ESR_ESS_MASK  (0x7f << 5)
> +#define          ESR_ESS_DEC_OF  (1 << 20) /* DEC: 0=DBZ, 1=OF */

That's bit 20 big-endian, so bit (1 << 11).

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

