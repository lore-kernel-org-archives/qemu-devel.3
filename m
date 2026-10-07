Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC0CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENc7-0001qN-Fb; Wed, 07 Oct 2026 05:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEMYo-0003Yv-DK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:59:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEMYe-0002hB-Rs
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:59:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a022fee0caso15308145e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791359941; x=1791964741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ANaZbwdwHNdakXC0TvCqPL4kGO5RqK82Cr1IcE+iE4=;
 b=d9EjHPjutPKoFTA9V1lTfyKFoNmUeIU8Z0NLsZBNCTcQSXcOKpPIpusmGjHBzGKuia
 7u4trg0mr+rUbOct8hSZYL0ypZnJNZUIZRGPCECvMVMDWSWMjDDlcMDW3ciqNcMsld92
 2+igifiHjXC5OW5ijB8E1tCpCtIQKuOewZ84B3HCnry3ADCb9cqpzhRPP1TAX488mKoP
 6PobLXIRnd7cKWC1taKfX6C/MRbChtLKfo9QqgiSIs47SSFqb1tOg+sK2Td9ycJBEykX
 1tBkmwngKHfELcwqPmVuhAUCiWtTHxDllggtdZUfyiSg6d3u+K8L7afvQfdMvodIxk4H
 7ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791359941; x=1791964741;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/ANaZbwdwHNdakXC0TvCqPL4kGO5RqK82Cr1IcE+iE4=;
 b=D828l75UYeCpxk7iBeYTYkKOeC5iwp2CaLgeGZjDtbV0mtvuYITLrRGMWE//dEPamJ
 RaPD0+bgqYEPBHIdzBgCWWYUQx9XZkA+G2RVFLoINiRZ3jarecDH0LYkWHUIrx+pqSBU
 wFgaHc20UUjsBQXKSo31rRiv4rTLz0OjWcQ9luQNZbZLP8rJhCVowzz3VdtEcBJNN1BC
 b/78jEjW1OUfsFi6F5aBoVG/7Az1OZL3YOVHdp+L9C1BLhfDMoRFqcnLf3fqpNmbkEDa
 xQrTwQN4u1TpJcSekoZe6tT9yMTGaJ+UK+J2S8kkuUPfEPAfME+jdFixOXlfY9AimOLi
 ErTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRs3AUedJdVv3RIrXLjAserylOyo3nLRzi31xOTkTri/g1Z47lBEBJz/s2XUIPjo0B3MPrrb8k+n9j@nongnu.org
X-Gm-Message-State: AFuF++lGxF63KT2SmepGQLhDPpL8EjWq0V4ODu6OoYrIOSeGBCq/qOTv
 8wURAr1WDSEAjPg+Ierzdkcy6PMPyFssFYdMwcwXQErknPF2irG7cTukBw0Y3IsJG4s=
X-Gm-Gg: AYBFou1MBoFumzIFxUkUL85uF1p1dkZkZmPXvkTYIW//IP8CTCEgi/DXh1VvCdmgYaS
 2876Du/A+2Jkis1SEJpRSdy33gwmEywLo639fvfEfah5mmta5CkdTTvobnDuxvmOe5ixFZWfBPr
 K1Rs0H0SIZH24t4H/10WN49SeJMNIMhcJXOmmsksdHj3fVWEmmbrGQsbqgFWPOrCyVF91suWazj
 Diz68fBcX+TpSJxIby45xxytgJgfm+Pcym1Qhkd3nohmKSpXd2eOZhEmfP+zg/ZHFbJe5xO68G7
 AiKsr61elWDMX43KHmMguYMhKqz9RT7eru++qra1MPjj2qWCY8UUsDZAo4KHEW6HPdY8y1AOQaq
 pk6dcVWPEN1UCUnaLFSQ+WXmehJVCBW3OqWw9cNUJxqano0bQzkpMUE98Ud2DXvgmmEs1L5F61r
 WdWRK5QJmMfRAMvje7x9+jxtpGiTdjD7mei9D7re0ruW1UDTV/Oojl+nx2wPS+POGkuDI+xyDnN
 mLXB0i8gTPqBXT9WzGEst9LksbMhiNOwNk=
X-Received: by 2002:a05:600c:3b9b:b0:49f:ed8c:6cad with SMTP id
 5b1f17b1804b1-4a180420135mr23179955e9.19.1791359935878; 
 Wed, 07 Oct 2026 00:58:55 -0700 (PDT)
Received: from [192.168.148.71] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm40001545e9.13.2026.10.07.00.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 00:58:55 -0700 (PDT)
Message-ID: <afaed027-938a-48ac-b14d-4a4745433fcd@linaro.org>
Date: Wed, 7 Oct 2026 09:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Multi target update 20261005
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/26 20:54, Pierrick Bouvier wrote:
> The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:
> 
>    Merge tag 'hppa-a400-updates-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/multi_target-20261005
> 
> for you to fetch changes up to 2cd349bf10c915d7a02c7444fa037f827a04bd0a:
> 
>    ci: add multi-target job (2026-10-05 11:54:09 -0700)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2 00/21] multi-target: add straightforward architectures (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260930020108.217892-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH] ci: add multi-target job (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260929183320.2960-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

