Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB67CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 10:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCF17-00039V-SG; Fri, 24 Oct 2025 06:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF0z-000391-Q8
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:27:22 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCF0x-0003la-L0
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 06:27:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47106fc51faso23655315e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761301637; x=1761906437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ofH/qDioWS9i85RSfGKQqa+DzVFsKGlL6h5yNY5wH4=;
 b=eU22lcQMrstsUHYETagEArSgZ8FmYUvpaV5CXZitIARfGAQ1/6fAoaVGOcZcAB1Sj7
 YudZ0E18cJukKhOOYnsjuALiFaQgp00S0DSblD0OY25Duef72bsHXroTeuMEslwcdbp4
 zb6ap2zxkbb4b7EhjJ9mryQqfetiZe35Ix90ELxG/aooRPYhkQM5C1PH+CDCZrBAnkFw
 pQx9YQ16cybZZMX9ieLhwORmJiRrGuAFBW0ikxTEc8iNQUYGXPhCbsB28ffBhNjMqExJ
 hgzwZFSbCWkiIXJ69SRYV51Jsml1lUtjydJrrSCTb88negm7TIly9uvMxSXWWYPTB4mT
 abbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761301637; x=1761906437;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ofH/qDioWS9i85RSfGKQqa+DzVFsKGlL6h5yNY5wH4=;
 b=wedaV7UyXs6yh4mpECqLNXvHwhrbR6RjQulyzkipVhl2Uu3XqL9RHsDARPkYwvSvdV
 uHyr5ztNfdiiOKKWkE8G7E9tUZ9mmPIS4JCDfK/xiFWNzCa37dh10DcDfj7ZohXl7GSK
 VRmiiRwpxyIabEjk3KtBDqrKli2PX9IgwurzB4zs1QqZaLEYiEkXb6NtuQJfENylmu8y
 Z2W21G3PGs9bB0Fjm+rx8eJ9Ozz6X/EGJFiM1CPJk1qwu2puvMf1CqDMDZXgBEF3J+VK
 1msK1T/AVlENieDUMOh0zJ0yH3EDfAWel57JMqdePqhCrUqU5kInzhZGrykVm+kPtdoM
 DXDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN8xYLrQB30+GHb27RSCLUsObK8eRV+K6rxqnTCbql+xt9tNNv1No1efftcNjkqe1u3wKIFSh7jdDF@nongnu.org
X-Gm-Message-State: AOJu0YzvF9+wlAYL/acywxjhzhtNkYqmRV8vd9jIsK8uPxx7g3vQdR9r
 KIxyzeB9hIXIK/Pr8pkRuS4wpPP3R5Omd8Rva0c/fgA7evq1IE1eMug44N/K3NnMcwo=
X-Gm-Gg: ASbGnctPyfsgj848WFJyhIPa8iWTsGDGCfdJDIEDTqVVVYiS/ikvgahL3LOBSS+HjzT
 6Jy+NTIUCUb8lyIp+7EHoLpEIefLwo5axnG3g2E1px2/L4SVL55S1N3pbo0Vomzxi5HepGT5Wp7
 Y0iUBt8jJZbn11+97LP6fFtQ9HJKboZNIwvVeKpZ4yU84NSvRcPMaOJsKbg4M908KGAEpon5g/p
 a/8QGUxfe2HDi2VaRsmtd5UlvRbdKuZeFk+1oD1OPHIbtlmRCTCeCt/0bWvZfdQbSbF4hsDEPUO
 YsSY8f4lhFAg+Dl1eLrdh5W1lkuJlOROpSnOHmRmn9hZJ+rXxppXEJBPR6g9sS512IGUNyDSWut
 tY8uKIsqKvsiXkifZyaMR39YlxV634RYn0LJWzecaJQbHlxyPv6kHIbjQsXGxt8e3XFAf+cgDzU
 8ZfLRV3Pc/VCyTYylWzCIiR4KdEX+ummbbzBo7H/iDtrQzR12w5jZLrQ==
X-Google-Smtp-Source: AGHT+IG5Kzu4L59Mfz5Lusfrk1UlhytOQcBmk416tnpsTk9+ZpncQiNVfVwcJ7YGQjMmYFvtywBgcg==
X-Received: by 2002:a05:600c:3149:b0:46e:4b8b:75f2 with SMTP id
 5b1f17b1804b1-471178a7ea5mr190556735e9.16.1761301637330; 
 Fri, 24 Oct 2025 03:27:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c41cc92csm139922175e9.0.2025.10.24.03.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 03:27:16 -0700 (PDT)
Message-ID: <8b878349-fa1a-45e9-9f19-ea7a55e8ac41@linaro.org>
Date: Fri, 24 Oct 2025 12:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 6/6] ppc: Pass error_fatal to load_image_targphys()
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 hpoussin@reactos.org
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
 <20251024092616.1893092-9-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024092616.1893092-9-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/10/25 11:26, Vishal Chourasia wrote:
> Pass error_fatal to load_image_targphys() calls in ppc machine initialization
> to capture detailed error information when loading firmware, kernel,
> and initrd images.
> 
> Passing error_fatal automatically reports detailed error messages and
> exits immediately on failure. Eliminating redundant exit(1) calls, as
> error_fatal handles termination
> 
> The behavior remains functionally identical, but error messages now
> come directly from the loader function with more context about the
> failure cause.
> 
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/ppc/amigaone.c      | 13 ++-----------
>   hw/ppc/e500.c          | 19 +++----------------
>   hw/ppc/mac_newworld.c  | 16 +++-------------
>   hw/ppc/mac_oldworld.c  | 16 +++-------------
>   hw/ppc/pegasos2.c      |  9 ++-------
>   hw/ppc/pnv.c           | 28 +++++-----------------------
>   hw/ppc/ppc440_bamboo.c |  8 +-------
>   hw/ppc/prep.c          | 17 ++++-------------
>   hw/ppc/sam460ex.c      |  7 +------
>   hw/ppc/spapr.c         | 13 ++-----------
>   hw/ppc/virtex_ml507.c  | 10 ++--------
>   11 files changed, 28 insertions(+), 128 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


