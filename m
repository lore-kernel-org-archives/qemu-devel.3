Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A8DC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTxl-0003fE-Kc; Thu, 16 Jan 2025 12:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTxj-0003ec-De
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:47:23 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTxh-0004XP-Ua
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:47:23 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2efded08c79so1823495a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737049640; x=1737654440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xseTO35ygV/Xqo84phj7r5+DK9KPsVRb4VtiWGmiekk=;
 b=YXZDzJyyruzWJmle8d+2bmOiUbZ/iAtHdGLcC05VKZj+lM9vVYWUHMuuYqDsgN2CUB
 xFPdu4ofBDXT4QX7BfaKpGbWnUrG6iyt9lX6SF1/vkwIEs1988UQLttA1CJQSJ/RHub6
 3KnWEo19tH4hR9gOqNucP6yIDYlKiRctDYO8/5ZnVkl0kk4JSJhKXL4HXqxY90z2bO6Q
 jl434JEsSjZm2FEa9FCcWymZ5NKeC+TQycl939JdRsWAwx4y9Ia+5CBVFirddooyfKQa
 iTmAbqA15nnBjayZzYb8c2rJcLVWOs5gwJAOgrcPX7QNAZ7C+uFKUM8rwlOtLV5pw8jR
 pDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737049640; x=1737654440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xseTO35ygV/Xqo84phj7r5+DK9KPsVRb4VtiWGmiekk=;
 b=kk/xLzweDNF48m4USTZ2v+Pm5zsI7+epxyXOGMlWBdoCpO+TCh5N9tQoZlpDWG8l4z
 zcxK7bKPstmXSFTufGfckHlnZIIGJt8hpLPJXGKJcbYNkwCdbIDBgSZn0kaEHTLxdgCD
 h9vKait0WvkfdxyxOrWvX4nGVsI1qbmTf1ZiQI3qcBTyMX4EG7voO0eEDjErSoZJqMZT
 KD3G6+wFGTL3FkN/dgIMSjpXmrHGr8JH8B4O+XVbObyY1pCuLtGWacC7U7ce+uJEs537
 eYFhq5Hoa80ZHq7UwJcsGeLwEO8EC/lrlwG3hYOhBT6hWstLN51vevrRKnruG4PxamuM
 KgWg==
X-Gm-Message-State: AOJu0YzjX3RI5/+jePkM7pptHfsIpeaY6zYDYBI5enixDjmeLW974LQB
 F3nlfEIx3yXRnJgauq+ogw4yW+NJmCtTxiRkV+S+FoShMq7lzYOQwYY1kYLFVhVLtSvP4flqqLU
 W
X-Gm-Gg: ASbGncttAbFo/nRHmv8pRS5fycQfaRTclQszjg0IUNTbYu5MGcAxcb6E/ht4p0Urigw
 YASHlxebhwYX02x/o88KewcfIHQprhmCzXCjH470VEBXSgGg84T227gJ7H+ho9FE9J49Y6MopJP
 7H9siyWAvH4+KXqe5IZGNcPQ9la4F61+cU+AJBceJPf2R/gsGRlA64ekJhy3va3bZ024nRqOrW+
 Fiqop52dMlpRj2HKl87z6dSn2/ybuuF30ul5hsIzjvE395OlFzEZu03qjwAwZ3KVDFbZglKTESL
 PUzGk/21qwhWLuvYitiDNjA=
X-Google-Smtp-Source: AGHT+IG7pUZbyJNJRbCbd7Cia/4kkCnpgKHhvzhT745vdELr2O3uolulCgWnOaVe03On3iXhQ8hngQ==
X-Received: by 2002:a17:90b:54cb:b0:2ee:b666:d14a with SMTP id
 98e67ed59e1d1-2f548ec8a90mr54490040a91.17.1737049640262; 
 Thu, 16 Jan 2025 09:47:20 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c1511b2sm3889687a91.3.2025.01.16.09.47.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:47:19 -0800 (PST)
Message-ID: <3a34ae1f-c2e1-40f9-b78e-11c4e3f53ce9@linaro.org>
Date: Thu, 16 Jan 2025 09:47:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
To: qemu-devel@nongnu.org
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250116145944.38028-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 1/16/25 06:59, Philippe Mathieu-Daudé wrote:
> TheVirtMachineClass::disallow_affinity_adjustment
> field was only used by virt-2.6 machine, which got
> removed. Remove it and simplify virt_cpu_mp_affinity().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/arm/virt.h |  1 -
>   hw/arm/virt.c         | 30 +++++++++++++++---------------
>   2 files changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

