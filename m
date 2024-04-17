Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0872FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAvL-0000py-MT; Wed, 17 Apr 2024 15:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAv9-0000mw-Du
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:26:15 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAv7-00087q-Kg
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:26:14 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a5ef566c7aso113267a91.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381972; x=1713986772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VRxf2RdGOPO0bmMb7ToFMw1SqEgg42h4xPWIb/+lZA=;
 b=hHqkaUmjO94nMLaW0njuyuGH7nt2oFMIRI2KaF/PkdTdMvNsK8/qvzQ5C0Nwc7Ks8J
 ZbvJ3UZ6qg1BT+Obzu0oBJ75dbxdgnPtyLQHv1udEkJ47CLIv3GzLRsN5vjdXR+SAiYJ
 PFzH2i6ZoLB6uVsLRgBPELOTRJ4k7lJTphHUg3e8bOoX86uWMl3TyV5LZhv2zR4IdsBp
 KTD4JCkPIImUYcS5gHyld/YJ1eaQ/OJJS7l+Ef1VYa/Q6QM9W+j53pTkHblD9yhN9YRD
 BH1UUVxnm8MnQQVY5gwgdbFVOfIKuqd1gWA2CTer/owkFx+Fy6/VeL0I7Kd3TwqiKseT
 Md1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381972; x=1713986772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VRxf2RdGOPO0bmMb7ToFMw1SqEgg42h4xPWIb/+lZA=;
 b=f9NoSbYL+6+SLQPHumcOJ95qZ7vJesOfthpgQVMr8z1htXuY6HWD7SgBe2eXTJLi0N
 cNQgzU3MHnh+isYlm7FkgdMp6BDne49QEj6AS7q4904NC/fv4QaIeXGoF4+rOhUv7Jyl
 30McLpfO+2E4FsCJfvmBAfRV8MZyXSnnb7TlACc9QvMubsRJZdYxUUc3apSZDI6Iju8L
 +pspDN8ufJb15r1Im76pRav5spCuyDPtL32vz9CvHTzLZ9FtJDzTr9PBHZYorVHXydYI
 sj0W3et8KMugR67HbGUmc1+Dr7FoNxVa/uo74krP6xS94rN2OeO4cdnBjidamKE1gsQ+
 msLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv8MSEhy1nJ7iTIi8+JZ2/4DbFKNQ1DIlMleZ6Th2Sz5whRFJFPl4GhHdjARDGP3OM9TXGnyWUB9IZZ9a/N6Su7oH+jSc=
X-Gm-Message-State: AOJu0Yz5o5QNOb942j8cYC/wgiWiWJAepH3Koa01p/bQyL297r5tp8m5
 HQjhIkrypF6GZhZSA1vaKZitjt53BLMeWhYyVx6HZEbzZKHQQY2u9rWaQCsVSkE=
X-Google-Smtp-Source: AGHT+IHxu2WO774oQffFK1tzifINt5IvjUauuS1k6/ORiYoFm9LCRNMRxyB86sKQCVHIhbfHrjEGJg==
X-Received: by 2002:a17:90b:4d81:b0:2a5:32fe:b834 with SMTP id
 oj1-20020a17090b4d8100b002a532feb834mr389588pjb.23.1713381972263; 
 Wed, 17 Apr 2024 12:26:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fw9-20020a17090b128900b00299101c1341sm16850pjb.18.2024.04.17.12.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:26:11 -0700 (PDT)
Message-ID: <d947ecb8-15d1-4483-b46a-f39dd9f746ac@linaro.org>
Date: Wed, 17 Apr 2024 12:26:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] exec/cpu-all: Remove unused tswapls() definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/17/24 11:28, Philippe Mathieu-Daudé wrote:
> Last use of tswapls() was removed 2 years ago in commit
> aee14c77f4 ("linux-user: Rewrite do_getdents, do_getdents64").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Message-Id:<20231212123401.37493-15-philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

