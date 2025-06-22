Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B88C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9px-0002oH-IY; Sat, 21 Jun 2025 21:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9pw-0002o8-Un
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:49:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9pv-0004Vn-1K
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:49:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-23602481460so26801595ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750556973; x=1751161773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EwZDLw9ht2YbOsBYuiu/Zn7Mgtun6ZqJR/Etn1hwXYk=;
 b=kAmzi73kFM6fMVTMPSZUjukOsA4JI79Fnd+0eKoTkWpNrT/r2bUqOyL8wwkFCiNi3F
 aqVKlUZHj6vnX7UETqqCWmG1U8qnEHGmPwDXAe+v0Es/Wcesh6uRR5MCkhePsb5uqeSC
 lznn+Lbyi9oRaxK7ABhMD2ldnEl6U0QhCtxr66JyI5FyUFTMwdPAbrNjVTX8iu3DKpXk
 S9f187amWs5JS2GQfVi238YkKqfygGdeWKdYYAlRDyrhOd1lg2VejLbRPseHbXce7xlt
 UKH7/eNYlmZnF4yyCF/NuyFvKMn/wRyG4Zt5Vb1z4Iob1TsrNqKrVN60mKnWRixGOA/o
 1f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750556973; x=1751161773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EwZDLw9ht2YbOsBYuiu/Zn7Mgtun6ZqJR/Etn1hwXYk=;
 b=aBFdMbcPk/0v69dizG9AlWDx+lCXsSMjan9zJOFu/vnt491X1Wb1No6jisIP+H11O/
 bVm9ae9qR9oru72c6NBAPtq8bZiu3PRrLWjpXn98NThew5tpG+BxRV88RqQVA9myxHnJ
 X79C00je8mjYIh7LMOTqGabUSwWU1LxvhoQB+mjEnN6jCANFEHZA/rqYRINfTEP74hLL
 abiDewp2ECSKEtNzzw3hAGreWVn/7fJhKeA7Rqmqx6v4wbcXFbE30ZDpRrSZEg+5jvmq
 GZ2FsmBTngPQv+pjTSO/d4TOaF3iweJg9p+fyu53aBMB/DI/O4pB6gxXGoBa2AdVP0y4
 J/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV+ATqMDIw/I/NMRjBMB2b9NDwZnzSuRA3zUGVH7s4KmECcN5U0mJ27C8L8BGE/VOZcuk0x6xcwS7g@nongnu.org
X-Gm-Message-State: AOJu0Yxi1F7RFoSWMJLA+U72HYMJWrb8z45utH+/s0yu+nEG0u4Ovmhr
 oisBIdTcGCi7hp+8s3UHDSwRAd2eHFthOZKNCcCAmpBvboPPxAuwIznlhEJVpwRdSpc=
X-Gm-Gg: ASbGncsYccDxqdk27QETIR8WWYOCiUnW7iT9McFwwOz0YesNAfIhTTKKBwhXAts8QmD
 gnGgmvnoib33M7Udq8lghNkIrUd40TMrD8pDmE0wAfUwCTfjoo6JCF0EsSS1smjUClq9HzeK5Av
 yg9JZ4eWMHozmupLYnPZxZkT266cGXun/6T3LJ+TIDGO/kgIA5n1iJUUItNRZ928f1PBy5Yw0ny
 pieCUE9/R61L5y0e/IRapQY2lq2FAJKRRNlPXh0/uD7SdsEgRORDy4FosUJcywdyESUPdiZc7i0
 xJbfJ5yvEYGW8hIo+I/Jgx3yOemRnEsdc4ytRPT6svBWwVuk2I23PqkMTy3EsnKxav/4nkR8xGw
 Kn09o7lhimYdCpcQcjquwzOhIxYM9
X-Google-Smtp-Source: AGHT+IEBXvTex53x17/89M9aaV/vlLxwGtd0ehjiZ/xGAMFiEJoOtmIYaO3ZnBrelNwOzMt92hveXg==
X-Received: by 2002:a17:902:f647:b0:236:7333:f183 with SMTP id
 d9443c01a7336-237d9871fa9mr123574605ad.19.1750556973532; 
 Sat, 21 Jun 2025 18:49:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86101ebsm50997505ad.113.2025.06.21.18.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:49:33 -0700 (PDT)
Message-ID: <4dbe33a2-b30f-46a3-87e2-a8eb797c81bf@linaro.org>
Date: Sat, 21 Jun 2025 18:49:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 28/48] accel/dummy: Factor
 tcg_vcpu_thread_precreate() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-29-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Factor tcg_vcpu_thread_precreate() out for re-use.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.h       | 1 +
>   accel/tcg/tcg-accel-ops-mttcg.c | 3 +--
>   accel/tcg/tcg-accel-ops-rr.c    | 3 +--
>   accel/tcg/tcg-accel-ops.c       | 7 +++++++
>   4 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

