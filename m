Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjjG-0004Zb-Bs; Thu, 12 Dec 2024 08:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLjjE-0004ZS-3L
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:59:44 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLjjC-0007Mj-H5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:59:43 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e36b27b53so64705a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734011980; x=1734616780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nz+Ev7LYG8CfqCq+2dhn+rzxKVPN0OVRSTVDNYX1Qbk=;
 b=tIHNu08fbCDeK7jeVB5rODdpHGgfdpwjxaEyHGmxvQHemwidez9iN/vZ4r4ggBwbXf
 wMzEnDyFRi7pAl1QrodCz+nrYzPXjUhjmEJud4tEdWflooJDkkOpfeVJtqB9n91LesCG
 J35udAMG4dQ3c697WC74F2ob583YZ9s32bBZOobiC2BI7FAvu1/zczfHoYzTKY5BDf8j
 syzHVaqiIbaWjdPpUDoDuBAH5q+QfNLlH0eEl918x5pezsNI5IaaI56B6iPWVUcHm+xK
 3K6QFveuWt6JeltPCpXJIt3O4or2Q7KP+N9K6CU9iWRWEIzqOMHzk0hmeX7G1i84FsrW
 iKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734011980; x=1734616780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nz+Ev7LYG8CfqCq+2dhn+rzxKVPN0OVRSTVDNYX1Qbk=;
 b=hoAM2uA9M5Y+4e46FeUmpVqfuOjtVepdLECoLCkATzIA0jLVfrxpiDvhKwLcs1hJM4
 0n/NWx2Kj09Tx5I9aXzQMLmB0TXcHTZO897uieMYtRd7FP8RdmyGGJrQEcRx/tQL+pnW
 Xo36RHPjmzhOHPuFNRDA+l2iBKlaxhNEmQyVkiWmW4JjkCMWDAT2MjZlADlAwMZ0FIrf
 jF8CHaOzpkND5+NQS7Ap5rBDArjWx48l29p+MSgEZRoriCcv4y7oCuci6jNBRT2xbTMt
 SfGK36Oea2ddhOdnAmhXPeEG89PMbMK7INUbsVJu6+7p7m3WdlsMoGd3y8iheda+RQfS
 ayJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBBSpCXTkVQL5h5mUgVG4G4DTV2tpTzTRbhZt9xQtOoetggkRh34YJMtkMfixRzFEYu9KiF9YXcUw9@nongnu.org
X-Gm-Message-State: AOJu0Yxo2ahnX0P3uql6sXe7PPmRMO9WPZrUp+fty5DtGp48XUm8K2yC
 UwxUWyQJtvWmKLHGkkCJ9601icBEtnqh/rd+dqGiUYrceYLsqB5ZuUOXcH27T7o=
X-Gm-Gg: ASbGncvWW7c18I934+zRuEPR/2oIEvaeMPgMMxHRjIcRTs/7UDHj0P4iyWXQIfpOhab
 363I//hTJWyg1T6REmI+Yzc3/sM6kdYMYk2SRXKRAd6Ucu2wR7+vzkmDwubzHXVptZPFBsCzM8n
 xyUfvCbMVMv6Al+VtX9NFglxTmrjpiPs5Bsc5zsDwMZzlNw3p6/Qw3tapDlZmfofKgjx/4fJr01
 YKAeLryJ1tlpyFwOejqwhRCq3+y0RsyffRelew7n/xCCGNB7rMJ0ZYJf/8ZRgV/48GjpsZHULRD
 mFwh3vSSai0bVpZ/I4HD8i6CDZzNfgVXvqk=
X-Google-Smtp-Source: AGHT+IH5eDYRi/vQn78qhwaOELL0IdjRh9Im2SLDv6UWdiI16v0PX3maXqZOmvheBWXSyL4zOa53rQ==
X-Received: by 2002:a05:6830:3509:b0:71d:f9f1:7f3a with SMTP id
 46e09a7af769-71e370fd784mr187396a34.24.1734011980143; 
 Thu, 12 Dec 2024 05:59:40 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e08cd4525sm1200291a34.3.2024.12.12.05.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 05:59:39 -0800 (PST)
Message-ID: <a1ad71d4-4148-42ee-b77a-fc4df1f5c2c0@linaro.org>
Date: Thu, 12 Dec 2024 07:59:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 01/20] kvm: kvm_get_writable_id_regs
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev
References: <20241206112213.88394-1-cohuck@redhat.com>
 <20241206112213.88394-2-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241206112213.88394-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 12/6/24 05:21, Cornelia Huck wrote:
> +#define NR_ID_REGS (3 * 8 * 8)
> +
> +typedef struct IdRegMap {
> +    uint64_t regs[NR_ID_REGS];
> +} IdRegMap;
> +

Where does the NR_ID_REGS come from?  In particular the * 3?
IIRC, all of the id registers are in op0=3, op1=0, crn=0, crm={0-7}, op2={0-7}.

Whatever the actual answer, some comments would be good.


r~

