Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D90D3F083
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 05:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlKPN-00026J-M5; Thu, 29 Jan 2026 00:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlKPI-00023n-U5
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 00:17:29 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlKPH-0001AZ-Fz
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 00:17:28 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so561546b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 21:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769663845; x=1770268645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FNfG2LP1692K1/7xvJf2rr0RAnUEpXzl7j0sPbrOFl0=;
 b=ZMTXlnE1m9q/2gwTCjBpu4awAJEO+OjPoNQedBEyjSuaKIWclDoULh00/HxI13EUBM
 s4/EiDN8rMYK3qgc/psjJ7nqu+tTTXbNddi6yxOSblHRRvH0R3DDKRJESCuVELL4wyts
 6k8y5YuKQqfPZthC1p9S+mabw1uiaTnCfhQ2BinqcDX28DkpWwHeOapO7mUO74Aags2e
 KvCjioWsxoTZSnUjiAZKhSJRi2h4DpUezCINluljcYylR8+FutTzDCrNOWy53ltRQz2b
 yydXc7HQTJWKzSlfU0tF30nXeqANbJW+d8ZrMfX7uF4t0JircaVpOZgA4TFxnOnz/ANF
 wneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769663845; x=1770268645;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FNfG2LP1692K1/7xvJf2rr0RAnUEpXzl7j0sPbrOFl0=;
 b=aVd2tyXq638r6yE2ymr/v2nCTGCbxCvQrvvklYapvuZGltwT4KKdzPp8v1OKCNoeYA
 qfttxbGPkZNZH5FKvpmQErOxO1xGep0VYIiS9iM972t1rJKHf6mo6ByK7orxXE2vQeb2
 4sCcgcod/xSr0FXfzA6eIpMplfLT6A9Ta/Xoyf2rrSFBvHyE9l1VNhKmmF6RScBNt7G2
 Y2O9UgMu3ZmwfAHRkjZJCB5e4Lj2keU554Czc0W6VqChHyiq0SwWz6tvtNzCt12q2qcT
 bFnwt4pYy8/wpnUzdIQGHCG/3fQtbCoKPCW+iW78yb3Mpma+aZptN6E4Bpyh6w8OmxtL
 wkqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkpMe7lrA8h82x/DHCcisW3msRKE6ldP2hG6U0UkHvxqH2SIg45wzXpgrDLyqC18SQqD7ZFKQczxwF@nongnu.org
X-Gm-Message-State: AOJu0YzV6554YmwU7mt29WcHzRKJbea+/IatrOv3A5I6xamydztcArC+
 6b3LqG8Cly99zVo2VhX43Zoh0LoViVYpK6zMv4O3IdYL2/TN49CEEWP+sAS/XqVZoyg=
X-Gm-Gg: AZuq6aKBtGY0Fuo0Qn2IppZi27qJ5bYVdLdJWldkiv6s31Uz0ccGxDPDkdncuaNeNpZ
 gFhe3YDWlfB4ynecWvwfgCquiReTRIvgq8TfLtCwqATkJhpBA0yeSzmhOehNNUiw+itGSqKixIa
 Y++Zi0mmqvfpMb18pQP6CEn+lS0U5WcPEnDshHqAjkQCub7m5NCFPYWGSmKs5UcV717nOds9uEU
 JByYmAVsEsufkv2UBKkZBke25Cax1ExPJO9pxqxj3L+KPMIswMTnbvy7KZeVOP0AJ2cJRMKNNw3
 TFT6FegXaUPkdxCDdLjGpFRzs0lNkLcyBWYvsl0O9DNYEKJ0CyogFK1PtDVmjKTzdwWfe6blloa
 HjoBv+jBwojJ0OcwU47jWb0GSDHOPvB3Dau0GIYTtw2gBJAtPsFSomwPXq1B/KLUGBg2dQjZZwa
 bTccwbQgm96pa+Pbir1pF9ZG46ABrszw==
X-Received: by 2002:a05:6a00:1898:b0:81a:7be3:9e6a with SMTP id
 d2e1a72fcca58-82369160fbfmr7401009b3a.7.1769663845313; 
 Wed, 28 Jan 2026 21:17:25 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c53f6bsm4542781b3a.63.2026.01.28.21.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 21:17:24 -0800 (PST)
Message-ID: <295bb922-9825-4e40-aaf2-24685d06ae3c@linaro.org>
Date: Thu, 29 Jan 2026 16:17:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/20] linux-user: add plugin API to filter syscalls
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
 <20260129013134.3956938-7-pierrick.bouvier@linaro.org>
 <a44ba710-25ca-44c2-bcdb-db917efaaaeb@linaro.org>
 <e85a01a2-faf3-406e-a260-ce8a832ed9cb@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <e85a01a2-faf3-406e-a260-ce8a832ed9cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/29/26 13:56, Pierrick Bouvier wrote:
> If that's ok for you, I can move the function to linux-user/syscall.c and remove the 
> header. How about that?

Sounds good.

r~

