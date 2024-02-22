Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F1C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 00:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcwjn-0000tJ-2x; Wed, 21 Feb 2024 19:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcwjl-0000t7-47
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 19:14:53 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcwjj-0006dt-8i
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 19:14:52 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-299c5a23f40so2437617a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 16:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708560889; x=1709165689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YY78NTSGxm1LmNoSUhSwbpvJETi2BK+jXhQC9djLPFs=;
 b=w4I862bd2Kilmbr2hm8TqB2BeZiymaUYxPyfIz9xwmdoSI4k+6ecw9gO26Tg3BstR2
 Hbm/9CdrlVkT38ijxf2iB0A26AergjHudqnHz2dwIQlyovdwFVy8bo37T12lSaLM5ooW
 Kxba6uIXVOK74o8UZHrkkVlL5b9bHqyRrol1A4T/S2/4pRWenbzv1HYnUMNbA5EYv0+y
 I4qh3gQb1vOP3zs/X88/fyB2asdxBT+V0U908t/eGKJZ8+HqXHSdN8ZwOQ+IEsHTCe10
 1iEq9ZGXrkzC4nI1Q+VMUWRIRm1kVEQzbsJjmMlSnNSnjsj93bQsZpqVo5yRoqtztAN0
 qXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708560889; x=1709165689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YY78NTSGxm1LmNoSUhSwbpvJETi2BK+jXhQC9djLPFs=;
 b=py8RuSmP42llL4f8qeo57VRCr4JDoGF1+QOF79DA2W/XIGFjMLw3i29PXe1m97qW+D
 RrE6egjlrtzoHyotFo6GcMVyFpoZ+kOpaGvhEKN47nz73cr5uz4OTMTmOi7H/n2IVr/J
 TAVX1GjXEHtGJXkm1Lp+tGK5SrOneMpAMiA/KQme9iR0V66xLoKWZyt9UTSXzu9ULM/Y
 y7vzNsJ5jC/0In55u54os6mB7GwnOWdUDdfFwv+4pnTPDAQnPuuIKgSnfV4QjigZR3Yo
 sR1RrllKSiYeOd2rWCDRZvFPnxNu2WlmcssEzNiYhNgDKoPVdwodK8ED2auCv2CrepDX
 oQ4A==
X-Gm-Message-State: AOJu0YxzXNb85H2V8fbH/5v5/NHiiy10zqwD5Fsxi8WBPCCBXhW2jpPF
 nVAd9vOgOPWBu3tHynsffi4Unem5Ut/tP6aOYKSY3A66xozXSn4aXBs2VE5dhNk=
X-Google-Smtp-Source: AGHT+IF90baV6/YJ6Rf1oyJG3hhC1nyxrmXpr9XsYtUL4/2TbszXJr5UDbs8+37n0M6xDbGHnre6rg==
X-Received: by 2002:a17:90a:fe93:b0:299:7b37:9221 with SMTP id
 co19-20020a17090afe9300b002997b379221mr8777421pjb.12.1708560888966; 
 Wed, 21 Feb 2024 16:14:48 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 n10-20020a170902d0ca00b001dbcfa0f1acsm8069073pln.83.2024.02.21.16.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 16:14:48 -0800 (PST)
Message-ID: <ffea7a24-86cd-4019-aaf9-11e22e9feacc@linaro.org>
Date: Wed, 21 Feb 2024 14:14:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/13] linux-user: Use walk_memory_regions for
 open_self_maps
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
 <20230901204251.137307-6-richard.henderson@linaro.org>
 <9860cd401db66e6bf10e9e41df148b25ee6c73fd.camel@linuxfoundation.org>
 <c845093f-1fe0-477e-bf5e-db22c985241a@tls.msk.ru>
 <3cc4df1a6fe27b211b29d2c17846812936255d7a.camel@linuxfoundation.org>
 <ca83fc98-219c-47b1-a16b-f281d914e4a0@linaro.org>
 <360135aa106e1925979bc0efd5a5d6fdeed4202d.camel@linuxfoundation.org>
 <2no4imvz2zrar5kchz2l3oddqbgpj77jgwcuf7aritkn2ok763@i2mvpcihztho>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2no4imvz2zrar5kchz2l3oddqbgpj77jgwcuf7aritkn2ok763@i2mvpcihztho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/12/24 10:43, Ilya Leoshkevich wrote:
> int main(void)
> {
>          shmat(shmget(IPC_PRIVATE, 1836016, IPC_CREAT | 0600), (void *)0x20000804000, 0);
>          open("/proc/self/maps", O_RDONLY);
> }
> 
> Apparently an mmap() is missing for shmat() when g>h and shmaddr is
> specified. The mismatch between the host's and the guest's view of the
> mapping's tail appears to be causing the SEGV.

Yes, shmat() is handling none of the h != g page size issues;
it is in fact fairly broken.


r~

