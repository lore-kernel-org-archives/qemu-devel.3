Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0D9C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNC1-00037x-Rt; Fri, 24 Jan 2025 12:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNBz-00032G-G6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:10:03 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNBw-0005Zm-Ko
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:10:03 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so4239860a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737738599; x=1738343399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ucOFhGc9ZIz1FHlHjFRyrXQBnRjc6o6DctzPWxL7TU=;
 b=cQK1YkMasVDuPvTsOxexi1oWvJnqnwlBeabpDeqc8VkHgpvhnF3/UYdOF2R8xJBF7A
 k/Mn6vJSn5oCDXeyr9l39PEwGP0+Suezaa6bJVNh+ZHuIDsaExMKf2b8YqrfMW85oLbI
 4d27hpq4PEx8gha0T5OmsUDvH8boKKxltNAb4c1hlUFLkFs3s44lnw9ZP21Cj8IY2RyR
 rISA0M+fzjjquWnnIOv7qaxwzX+cZvvCV6VZOR4ToHmZxwEAwk+vDRgnDbeMOWERGIeh
 JFGwbgyZoKATOMEr+HYsYaeTH4cd83M08Vu7dzLcHp72HSA7bIsIMQUFH0xSLcFoYax/
 4UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737738599; x=1738343399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ucOFhGc9ZIz1FHlHjFRyrXQBnRjc6o6DctzPWxL7TU=;
 b=fhXB2H97Tjl23ZIkXw80rPldnV4DlBuiAmkweeHiWOVScz4XL7mjOHiMplAKRzBR6S
 /F2rkb7QCgzzc50bS19OJuq0S54IQza3j+0FRtkLGnYmarMGOM717lluydsnI+flxak1
 H5yiV4BIWxOdT4NR4D04Rgj8Gzq0g3tR1l094HY8Jx798474B98CCKyM3brSa9a/5xLh
 IR9wfgnzj2CigjGDDdQ/0BxEEHr9FJmYREZN41vzHdg55smuMR4HBwT/rPhjT33Y4NHM
 ciLrodC0XofvwisTklryl5PAAJ097KzE1BdysYpMKNvcuUeT3hokGPKAVRao5ZGxRl9H
 X7hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2YCww0WAd7uuMMH3HOfU6SGn6UPpclrQ/3bhNHicmXRUaCbl7ijn11tJ6qe4ufutiz1q/+7K5vV6N@nongnu.org
X-Gm-Message-State: AOJu0YwgWshIWHz6D4NC1y6F6un/9cr+US6UwAa1ayv/yK8dT0UdMhi8
 wqZWNAwTwgpp33fDxwT9YMKZfQtQ1HlZ7H3KOwSGqk+bbK/6AEHreVZLU1xlI1c=
X-Gm-Gg: ASbGncuxBw4vSV2vzPBM3kn0H0C4vLscEj0/fItgCIjEEY0wzvutdDKxGgHtUTMSCFm
 kCj2INumFzAB+J+edvzm17xPlUtkpguJj3ztC7bHl7aCKdlabCbRDOtaVY2Yh/uQM4yn+zXFxVl
 Fwa3uvcsVpbzJGnmCfmxyoIEPcS6HrTVwxJF4kKEfuZMh4M1g7z+Tr5WBJ8wU+44Mj4DWlHmJce
 bJELRq/ww/YCiASND0XtMlI8rTGUvXtRRYGMEfxxIbwOdG6bpwmfiTeygAC+wPYyl64FmDwNxVH
 WwuhSyKMaWkIz9kYKUfvIaxf
X-Google-Smtp-Source: AGHT+IEDviNI1g//Uwaa14ueC69n6UmhIuPEebW7VZD7dfeL+0T9Jokad9CaDN85gx4zcUCj8Ud4oA==
X-Received: by 2002:a05:6a00:4647:b0:725:d1d5:6d86 with SMTP id
 d2e1a72fcca58-72dafb91467mr45267116b3a.19.1737738599260; 
 Fri, 24 Jan 2025 09:09:59 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6c6775sm2128316b3a.73.2025.01.24.09.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:09:58 -0800 (PST)
Message-ID: <dab47b23-f52b-4ab2-80be-b4198c344b1b@linaro.org>
Date: Fri, 24 Jan 2025 09:09:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/28] target/loongarch: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/cpu.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


