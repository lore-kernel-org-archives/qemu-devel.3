Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7428E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 11:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQPch-0008O3-Gf; Wed, 25 Dec 2024 06:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQPcg-0008Nv-6Z
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 06:32:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQPce-0000Q8-C2
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 06:32:17 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436249df846so39469115e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2024 03:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735126334; x=1735731134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lw0ofrJ7e/pc783t8Cho0/fhsXo+lE1G3dqPbTdXvr0=;
 b=CXE96FNlMRDQ8U2GEXe2So5Cuh0k7PGSmNwbb9SAbgGnn956RIIi0JZgl1ZYWYngw3
 XoFG0sY2gz4Cvhl8XdcA8VaHUuUKNj9nGoskQfRTf8W9WZmK6MOoVz0IMKA76OeVlplD
 0Rfqr2ozuLmh5zvl7eGiKVPWwNd4vIEgc855EpBvaIFnwJxhXqtpG93y//AzsD+1NSUK
 T9CKeyr87tcoTEIDNdVWp1WRrXocLtsF0cxECjV8XcYgjKIZ9ZQk90kT5gwEuHknvxCA
 Gd+WEIhlf3qPK96x2plwwIibGQAWo6aEaBi3770sGQckTpYZ/ISlfK8uDMgxINYDAxRx
 gASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735126334; x=1735731134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lw0ofrJ7e/pc783t8Cho0/fhsXo+lE1G3dqPbTdXvr0=;
 b=r/9kvyZ9Y9pX4fy96Be69DSa0uNoZVaKRkMEKVgZ8cM0aftYnxQ1XRmHR9HOqu5o1/
 RSjCjwinHgsMZ+8gLY3GxmfqusUbaYjIKi64V3RPUFFB2WhP5U6vlLQK3RQFSHkdqfgd
 94U3r6Tv1DhEfmrGytP1GBJ/U1LT+us/rfVD9F2X2iLwItkqcpPZTxdjmV9oXhDEfjZe
 tgQfm7k3o28BaWO0A5AhdH4v2B+jjb6cSyjsDWWkI0Llc/hfrVm4Aoz6BzIHjmnDDL0i
 S91MYiGOGd8uJ991gcymITPsgdaO36WmcVIG9M1jxE5WbDxuyKbmEBYpTXT6uZjzj7pD
 wI5Q==
X-Gm-Message-State: AOJu0YzCB/kGAFyWwQatAM0Og2Wm8Y95E3E+5tjUPkK/oqOkxYpZD57D
 qnQliUGJlBvDNRlel98NhMabi8bu8W7WATZkjUWQkxj3B4Ne2qjNgjZ93NRqcpQ=
X-Gm-Gg: ASbGncszisv6kf9jcvp0DPzWDnua7hg9aipH8SO9T9uyiCRg7VQXfx6UiWV8ck65kcy
 aPkX4rKEU5jJU3BtMICTspskzhNdGqeeu6tTffceWr7BsiTdueFY7RsHJ51gNjuT4dSLOEgXyDD
 Q3LPf6r7KGeD8ZazyEO3rUOAg00Ql3YFbJmUstF8a6U7KX2Z3EKyJwmSCUj4f+PIzmE0bmsSg4L
 qlP3PQSVw+2UtFc52TGXQvF1f++HSQiekNgF1H0xTJsMUFrGpCiCFOFu4vmuOztJRo=
X-Google-Smtp-Source: AGHT+IG64Mn6yHVyGQJQhNPpDLbpUPM32p3EhXA1rKhA68hu5lqfbZH6UhcGx/zBejXrpyvoFpTT0g==
X-Received: by 2002:a05:600c:138d:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-43668642fa8mr174408585e9.9.1735126334520; 
 Wed, 25 Dec 2024 03:32:14 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474b6sm16740522f8f.51.2024.12.25.03.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Dec 2024 03:32:14 -0800 (PST)
Message-ID: <b691d979-848e-4fc9-8ede-3b16c6de732f@linaro.org>
Date: Wed, 25 Dec 2024 12:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/6] target/loongarch: Fix vldi inst
To: Bibo Mao <maobibo@loongson.cn>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 ghy <2247883756@qq.com>, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20241225024008.486236-1-maobibo@loongson.cn>
 <20241225024008.486236-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241225024008.486236-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

Hi Bibo,

On 25/12/24 03:40, Bibo Mao wrote:
> From: ghy <2247883756@qq.com>

Is this authorship correct? Should it be:
From: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>

> 
> Refer to the link below for a description of the vldi instructions:
> https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/#synopsis_88
> Fixed errors in vldi instruction implementation.
> 
> Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>

to match the S-o-b?

> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


