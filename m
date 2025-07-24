Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C27C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 09:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesU3-0003Cu-Io; Thu, 24 Jul 2025 05:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesTv-00036K-Sv
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:43:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesTt-00073h-Fg
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:43:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so4723225e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753350194; x=1753954994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pgyD+3HLshz5yn2oNV5hwV9bMTPuj58o7JY+Yea3O9c=;
 b=I/cxYBiF4ubuQbNNXlSVH4yJDfn0CAEu8CQ92aEI0wvqixe0egtgmaIcegZCQFMmR9
 7VQQJVkz9U8r8dGZDsmHeQaEp1kpIIwXgkFxZyGQ59yI6q3UG2WO+kgDVygSANMQ1ZEp
 0iGMETr6dB7QOFsfHW9yLYtnfDJ0J3JhDOqsfkWA/VfsfYPoOB+Aw2NxC3Fng5izhq5n
 dDYFbzV7z6ukIXfwh2GUPw1TrBFi+UB1IK7+OK4mqD4tjAVobGCD7CLGkvCj9gH+iohQ
 fX+Q/NU1auAk1q/eRcQKC6c5W1d+uJ15B76cyzCNlLtVqtmR6T0e4cMDziA0WPRB7tXI
 9gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753350194; x=1753954994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgyD+3HLshz5yn2oNV5hwV9bMTPuj58o7JY+Yea3O9c=;
 b=GXos39fGdSSwZzgtz6UUdYFVx6+pq6EVKTTyKfK+1bE71jUtJxvr2ldkju+bzT4kcF
 EDr9b6qBJ4ybpgpGiJthrVWQb9BaahKNPIUYkAOiEZfE5Nk03IfutTg0GAXU1dRt/qNL
 G92GHLMk8OCEDqQagqQsapMscXybBVqSA0g1jGl3/LLvtV9ah53S0imnBkMUqzz9xxC3
 Ml4/PLngkP04S7bqC2RQeGZ1bIpzplmaQHKcxYM1lSy95ujwbwcPUTejGObkerkB7gTM
 Sdoy3E3QmFki2Lt0dEBACcyrkC0pxuZBnv9F2b3Ww//8DmwvMQmq/rfCYQu7FkxQ+o+8
 KzLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3tWN1w0676IhpJCE7hkinqJq094jNxdjvKJ7duwFXv3Y8ufZ6NhFVSf2Ga9PzT2nsF7BRiWwezxGy@nongnu.org
X-Gm-Message-State: AOJu0YzI449wo/Wijt4lPoVVEEisy5agiGGSkyhiJPO3+93BsEx1KTGl
 2GebYnDdn4uKld/uwkKgkXcNgU/BaVhdFu/R9IysmfY8t3gICB1MjxymCd1+99QJn0Q=
X-Gm-Gg: ASbGncvC2ZvCwxsJXSz1vxypRTf0DNep+mMhvLFYUU7Om0LomNnPaEAvOI6JpK3WdhX
 m7rapLLMNhixJtXeLk07PwRspGHg+7vVHDpoyHS1iTV4GoKoqx0Mm4Q4vF4uKfhpC58DZllbN/E
 DEnnl+Vn++IPOAkfVNLZQxsPMNin5lMVs9Tvka46N6V+dX3eWdvhWnr6E6T7eTUpqMYa8Cuhr61
 sBdjJ+avOY63tvH0qRG12VTrOgpZeSPBTUWQAWkd4rwIWQMF9Z+0d4L2lNVKA2jYVmwmPnRT3bP
 rpEBLzlLSbIKR9W3bPUYUBl0X6wxXYT8nbPyHBHG5zeEqXy8trOJ7DrLhObIXHM8NN9LYRmnGtE
 FFb2E+TWYv7RDdjJJ21s7Z8HgDEqUQxQ7MtZZJECd0qjSYs6XvmKpUQ3fa2aAd1gDuA==
X-Google-Smtp-Source: AGHT+IGPIDpR+N2d4tEUZ2CbJjZi7KUVMMUBQoQwHEV7Kcl0kVg2+mKfJAEXERElNYxZDm4WidqLoQ==
X-Received: by 2002:a05:6000:2c06:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3b768ef5b95mr5169930f8f.33.1753350193887; 
 Thu, 24 Jul 2025 02:43:13 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705e39b1sm12908825e9.34.2025.07.24.02.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:43:13 -0700 (PDT)
Message-ID: <d2388d3b-60e6-40f7-beac-ae965175e997@linaro.org>
Date: Thu, 24 Jul 2025 11:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] MAINTAINERS: Add myself as reviewer for PowerPC TCG
 CPUs
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
 <20250724063623.3038984-4-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724063623.3038984-4-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 24/7/25 08:36, Harsh Prateek Bora wrote:
> From: Chinmay Rath <rathc@linux.ibm.com>
> 
> I have been working on Power ISA for a long time now and have mostly
> contributed in TCG instruction translation area (moved 300+ instructions to
> decodetree as of yet) and would like to continue contributing to PPC TCG in
> best possible ways I can. I think it's time to step up and assist in reviewing
> related patches to enable myself contribute more effectively in this direction.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Missing:

  "Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>"

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e95ef00c1..31bcb82e93 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,6 +296,7 @@ F: tests/tcg/openrisc/
>   PowerPC TCG CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +R: Chinmay Rath <rathc@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: target/ppc/


