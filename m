Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6094ACD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWQa-00074V-0R; Tue, 03 Sep 2024 12:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slWQR-0006Vs-2i
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:30:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slWQO-00061l-3B
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:30:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2053616fa36so34303125ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725381034; x=1725985834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNtYTwy1Fi8HEpXlEBchZPkcPdsMp7/U0VLKnw0mETQ=;
 b=ShnR0bsbgwJwZiXh2B9xwlKIPC4ib5RG64KkDJaicbkZUM/4g+YikJX7nnkR0hAS7q
 cBcKgQsUlqw6TYvAnAOMYfE7byGe3zgK0SFlesNMPqnAv4herjUp1F3gK6FHkF/9UJmM
 OCNWcYxfTQLuLU9CFGDEnTIUdCvVK2C0K31lIG4yAOHewyOQSIgo6J8zpOrS3a/v0Jjb
 CuZP4JHDCDlQ+et35UpICO7sy9a1rXZkR50E69hkbNTzznAGSwGTbzMde6u/wXNWYFtt
 MZiaMA+mT+Bwi+o5FrJ3u/A3jA5skzB6XSRnG4Yzm72iThBly1eFmQ8wi1lKjusX1qxd
 zE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381034; x=1725985834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aNtYTwy1Fi8HEpXlEBchZPkcPdsMp7/U0VLKnw0mETQ=;
 b=wuc19xfv/5jB57a8l9/Yih0ENr5Hfmmr1SgRWqUxOckJHKX2FWb4qqYvFQQ13jQGjt
 n0iJ0IOAFu6M6TJ+v7iHjCq/FfIXdImGkyowPzbA3ynalez5DsjlkVQpNVL+YNlctzof
 FMp/c67z14U3yxRzWawmO+QrcqWgDcOEWkdft2kWu5ox8F9No/xA3WRQGMHyVnh1DTcP
 sU47/QPSpbel6ulCRUMgxaTqy8WRQHuBfqkSRYQB618VmelNt8WvCm7QE2PWLjgPOeVi
 0PsRIuFq+n7qr4yDfwLzEw+AtnZufD1rJIRhrXp1MQPCniTCz3poMXzgWzNIRKgrljgl
 u64w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUALCpE/MhL25u9MR/pBjPaix7/H9YjYXfg+uyH/VtQ3xCJsgDYAvhPPE2h2XRFjrLiepaMf73ICaCR@nongnu.org
X-Gm-Message-State: AOJu0Yxp+bh9HqEjs3k6yK3zsktBMvPayFCtLnfMsL/zXXRsAAgoXqnO
 EKh4nT9zdZzJ+8QeT+BpYwha44uQSKuN5yRhSr+xTTFrSge1PGCyQUzSnfHFtgY=
X-Google-Smtp-Source: AGHT+IHYCVNk5lOgSSugX6EUlyi3WrAAvIjh7EbWOWfu/egqdF0+dIFvCY2mq8tGPWdBmPNOG3iK1A==
X-Received: by 2002:a17:903:22c1:b0:205:874d:6a7d with SMTP id
 d9443c01a7336-205874d6d4fmr70389265ad.12.1725381033276; 
 Tue, 03 Sep 2024 09:30:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae950fcfsm565785ad.90.2024.09.03.09.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 09:30:32 -0700 (PDT)
Message-ID: <bc313f51-706d-44f6-b020-c9b35d23d3eb@linaro.org>
Date: Tue, 3 Sep 2024 09:30:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct names of VFP VFNMA and VFNMS insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240830152156.2046590-1-peter.maydell@linaro.org>
 <CAFEAcA_g5ikdqXQB7t8x215TQ0O2YoE4S=Xa8TcrUxba1kddyQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_g5ikdqXQB7t8x215TQ0O2YoE4S=Xa8TcrUxba1kddyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/2/24 06:21, Peter Maydell wrote:
> On Fri, 30 Aug 2024 at 16:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> In vfp.decode we have the names of the VFNMA and VFNMS instructions
>> the wrong way around.  The architecture says that bit 6 is the 'op'
>> bit, which is 1 for VFNMA and 1 for VFNMS, but we label these two
> 
> Doh. "1 for VFNMA and 0 for VFNMS"...
> 
>> lines of decode the other way around.  This doesn't cause any
>> user-visible problem because in the handling of these functions in
>> translate-vfp.c we give VFNMA the behaviour specified for VFNMS and
>> vice-versa, but it's confusing when reading the code.
> 
> -- PMM
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

