Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2EFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrbO-0001q5-DH; Fri, 02 Aug 2024 08:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrbM-0001oj-Hq
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:41:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrbL-0006ma-2T
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:41:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so7127030b3a.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722602501; x=1723207301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gaHCODtcnrdKbENZV7JJywBEb6CMUTokG4it4ipCsiE=;
 b=tadoTKD4ob6k+C41UM/CJ5tDwYZry25Z8ly9atcqJp/n0z/P/rPSO7Mp9+Wm2i7C4A
 rX4XkcLs69ukxYMuywX4eqOe7+dTqF61l3/Mk27bvjZIkvp/mrv0yYsKOlPlx2k1Nn1/
 kRcrFE87WUCHWViXnV25PxlefEvT41+Vlz/3GP82XCa4YqLAximz8p7IYhI7WEhGyW6Y
 HK4J+WPmVcFwELMZe6ElOCYjwCZ6/UmkvFpDqDAQAX6K/sD004y9m37by1xBqn/TtmZx
 MUE/krilLnbxjrJFgunYoWM3PwpxGeRxQJldUaTC9KJzJBRLDKSTn9xic7xL4dcqHsqX
 MTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722602501; x=1723207301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gaHCODtcnrdKbENZV7JJywBEb6CMUTokG4it4ipCsiE=;
 b=T/Tn6Ffp4bB6ehB5pz64DxypHSJhdyRtpqpH97lotT7wkNqVrraTch2PwkrtMtjOXA
 LCQL8mC2JTmjxktUTEpEKCaeuPiTD31wvmmMBmxqrYKZp/fpHjzrnDcV8M9HCtXf+3sX
 lpCF3xpjdDotE4+in1YhpWyYxASg4ZHf1YNvc5iItAXL/ErTWYKB/YWpcQTiz3eGJM62
 gYG4EPWhWs6EBGJVX8emT9zXXIdbjdAuDj28wcGT9R+RbXvdhp2aZ3W4/qVGh4em5sjW
 hkHwoNHrZtymJMpb/RSyshTMqQlTIJZFNhaGn0MHl1vFYNnXBbDR9wMvrMyii6hS8akh
 TaGw==
X-Gm-Message-State: AOJu0Yzsp29dGdAxN3ekTa6p8cNXR4WEg3imlf/IpkF+gl52XT/Cpio6
 jnpCZ9AzRIQJsI/C2piaDQVKOMl3fJ6qYpEEqFBmrzEqRYStZkk+Q0l9NrWVaszAYttJmQcIx7m
 zXxycoQ==
X-Google-Smtp-Source: AGHT+IEqTILpTNeDmgR9V1soqwM+LMFo6CC6JUk4FKIUBmbopCj7q5SllB+p8nLBLR3wBOvgXt4K4w==
X-Received: by 2002:a05:6a00:996:b0:70d:22b5:5420 with SMTP id
 d2e1a72fcca58-7106cfd260emr4713761b3a.15.1722602500719; 
 Fri, 02 Aug 2024 05:41:40 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec49486sm1293736b3a.55.2024.08.02.05.41.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 05:41:40 -0700 (PDT)
Message-ID: <7ef8ebad-ac0b-4417-83a3-6a987c34b2e2@linaro.org>
Date: Fri, 2 Aug 2024 22:41:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] bsd-user: Implement RISC-V CPU initialization and
 main loop
To: qemu-devel@nongnu.org
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-2-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-2-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> +static inline void target_cpu_init(CPURISCVState *env,
> +        struct target_pt_regs *regs)
> +{
> +    int i;
> +
> +    for (i = 0; i < 32; i++) {

i = 1 as r0 is zero.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

