Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DBBCA0EED
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 23:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqK80-00048R-Lt; Sun, 24 Aug 2025 19:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqK7z-00048J-AL
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:27:59 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uqK7u-0000Ot-Cq
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 19:27:56 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3254e80ba08so1740713a91.1
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756078070; x=1756682870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+zLiu8rdp+ACTfQ+lTdUk9CocYs8/pZz/iACQKC+rZE=;
 b=DPAn6ePRG60HVHqO6rto1I6noCZvNdmnyb00hEDP0oATZ2/2u5jLchS5P3l1EYk9eB
 tc5HTAtbB17BuAQt/avwv8ArXfs6ahf0JE6yGAWR5jwae4D7vwp/mreorrUjmRohkqFv
 o/7rMUtP5uro7VSVaO9GI5BPOWVEpx83vs20PkAh764er2jd5xO3lTlYqTHnPjtadS9D
 lqgHNqC96I0UpUxEoGsHOSDS0jOn7rYqSMAefnu/Ii1umNMvWy+9UAaeY6mi8nCqwRjH
 sPvU7Yn5eYmfPL0515icgpHgKQbZkAFscNYl1Dzr0Z6fEaBEd4wkfAwAQ9VKx5NeR4Ca
 X23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756078070; x=1756682870;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zLiu8rdp+ACTfQ+lTdUk9CocYs8/pZz/iACQKC+rZE=;
 b=dA29kwIKZOyN7ipo0uI27IZb0gjJbEMdJ3aV8+pqXvqmegmo/lL37quEr6o0pSHzrE
 l548Sj2L6a/m0tdSDzAN80yUHnh58xlE3R/t1zel21wgD2lzukyQpmsP1oG+13bF1F5P
 t9f1tZ1MwXTaunYBIHFJdqV+DLr0nSOlfr5/pVErxC5SIueq+Yj0KnoUnR+OcUL5YTLs
 GtSX3dKLEO5EdpLhu+tdYQef1TltyfFTqWPRtxb0t9WJXrP4pm0G3kkQKTNZW6OLipAI
 o3HB8nWFSvJujX+3Su7L91U7JEMVegU5OJFwjNH3XAWVfo+mOMQl0uxEeJ6gOls8pulc
 qMtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNwmVc1XqCEpKC28dzA2nNv+pW1/Zxe6dg6LdtcPpOFyELK/miFeFTSnGOXBgb2qoKcvCSkTbX71RS@nongnu.org
X-Gm-Message-State: AOJu0YxyKo8dZXM9Ukdhc7iVq4bLVk0bP71U/z/qeXDmtolF2kwPoMmZ
 iZ94m7DwNK9Uh2N47vOZrZ98PUCVrsgixNk4bjgW0Sx/Plrb/sjl+JrRNidenpKIzxc=
X-Gm-Gg: ASbGncv8VebS+8s/UjPBbwmnjhX8yruRGesIzD9Y7no5ZhL3JnM5MRHVdr23+FYK1FS
 zdxLsraz+96kurCoQbhwOy5ZsSXEyC4LR1yl5IRquw2Zs+Jt+SRGU4ipsZ14GuwSTZRdgwyYs5O
 mhKCfFzxSaNrZ70Pt75RRglQCZPrBxlrIooLZc44VQXUlQj+837ViPyHNp82YNzonjiXO2pTCaR
 Dd1MJBXQnWOZnmlvCWC6pkYDf6OS/hAsB6sQ7Ss8JI0BwPcK+GhyjJHAYQp4lE7mGOPDJArwgaG
 QK6IwkFS9vrs+uE4Ynxi+0u1sk+XefrKgoTzmHoTC8qL0wfZF48Hn7uria8DDYOoAJsDlxJn5NU
 DFojSiWdErp+N7Zez0ypU0SD1phyS8rBIPBxNeLIxnzf681tRureGOsnHKmdOHiAbRaxwXOkSqL
 Zi/92GGKy67mOMmQQUTu9Wdqs1hmTaqK0N1R6501LdpuHk4XR912USUnqNt6ApvsRx
X-Google-Smtp-Source: AGHT+IGclv0Y72hk6laGRLGOskK+MCy9XNOu1IDt6I0jBlpSTFsxJ3d18Ss8VaWU3opNGJmovrjnVA==
X-Received: by 2002:a17:90b:3fc8:b0:325:57c1:6f8b with SMTP id
 98e67ed59e1d1-32557c170e9mr7280134a91.33.1756078070536; 
 Sun, 24 Aug 2025 16:27:50 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:2b1d:8711:2597:136f?
 (19r3hzjj0vw81f3fs315.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:2b1d:8711:2597:136f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8918e7sm5067070a12.6.2025.08.24.16.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Aug 2025 16:27:50 -0700 (PDT)
Message-ID: <09c7e4a0-9b1a-4568-9f5f-9e91291caa68@linaro.org>
Date: Mon, 25 Aug 2025 09:27:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] target/microblaze: Remove unused arg from
 check_divz()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@amd.com
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250824222734.4151956-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
> From: "Edgar E. Iglesias"<edgar.iglesias@amd.com>
> 
> Remove unused arg from check_divz(). No functional change.
> 
> Signed-off-by: Edgar E. Iglesias<edgar.iglesias@amd.com>
> ---
>   target/microblaze/op_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

