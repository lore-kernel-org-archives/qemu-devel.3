Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E47E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJToe-00007v-0O; Fri, 06 Dec 2024 03:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJToX-0008RK-TR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:54 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJToW-0000Vs-IO
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:53 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso907562f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474151; x=1734078951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n11WyXKWvid612dQI3SmR7GwE09/moDRs0zM225VZ08=;
 b=rM2pCeNBG5ixFFhNLdJRmbsqIyUDO+oc3uzJbt+CwSSJ4F1Jjqfea/hmRkVm2d4/d+
 x9dNLBLnB0DLnX0TCoCxxZ31oPUtrWxIMJJjylLULzTKDrHprcg0xUN0WXQFZUJwMOkz
 KbrrQ7P2vCXmlq4i8d4THu+Lma3nTFFmaPvjogNQcwk2gTkisK/X7v+11W7CBsuRinmq
 Wgl2sT1shmSbhgYDmdHoZGgP8qFu0dkz3ZKFhShSc1vhSzjVlbYPTzCXeJpuAzWo2uti
 iQ0fTU5TjlVt3/sHev6SpsJoGN7Kr3OR0AH27RTlFLopH+fn++nx0IJLMowS+CKPARl0
 Sjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474151; x=1734078951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n11WyXKWvid612dQI3SmR7GwE09/moDRs0zM225VZ08=;
 b=QRbn4nifu74FM5lYPytdrl0ZQ05DQs/DcWHnd0BLKXHxm1Xz+sR02S6vXiswENxu7w
 pT9h/Nqy5Hoh0Olg8bIy9WuRE+hbMqm1b6IiiyAsT1H5obWbq6voIuMSCm8nNrTPclSe
 2gd3JzEDwvyYNUghnnuK7Mqu8Rp5QL8K17XbwP7eloPbfPnLbAo2sXCpgiYf2WeA/JBE
 LM2yIcei/iTEEx+yh7OPijLtkhYTInZsk46FWw2+PHmIiLQHMaDeSazr1emzqXdH2Cb3
 hwD9/kg68pWuydfK5+5eUfgecMt8ylHIfJiFbWqaGp/kz7hxMAR0FkoqRd0MMf5fROL4
 Gggg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrGbSBqdAZn8cj9p4cLC/AqlfAKl7oY2ZNTyi/Y75nI7Czm12dGuw3RqRPkBz0Vy+UgKIMCBBR1dRT@nongnu.org
X-Gm-Message-State: AOJu0Ywn5ODj7M/AYFnAL79nXMBYSFcaJuRaLb3kPbG1O/brC0HuURvm
 6UtnjL7kMR2mXysyb+SIPML+mX1IpI8DHbJZonqXPTEMXxlGoy/U5C8rGG/6R9XQM5uqo2TqPv2
 Y
X-Gm-Gg: ASbGncsu+nM7XteuCMK5DWOI2L9+F/kU9Yggwu57Tt8iciYwxGiRzmLgq+p+9TGnwkY
 NgXrCUgOCsIidWkNArK1UJDLSmXRu7+4PcfLfG65H1lQcsYh434flZPwQ91zKT9Q4miqO9DOfsb
 oMfYJuV02eioQDZVLwZ/vFDmbOtoy2CtojwYA1wvY0uLK/A1nA+lR0oa5r0LT4vKSGHrN8jqUbm
 gbQPclDNCT6I13atJrFLEeflrrgRPILbpVKWU2uXXyIFG+J5FuYjWKll+FhXHhs+jbiqLo9T8Lw
 W/Dup8/6bBf3Hozu5Q==
X-Google-Smtp-Source: AGHT+IG2p1jxsF7Uu3DxjYLNvfv69Wj2lTkGPLOIqlMch/mVRkybI8O81s/THGbG/wUAQl4eTkx0gQ==
X-Received: by 2002:a05:6000:1a86:b0:385:f1df:2502 with SMTP id
 ffacd0b85a97d-3862b3d4974mr1158644f8f.36.1733474151012; 
 Fri, 06 Dec 2024 00:35:51 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862190989fsm4084152f8f.73.2024.12.06.00.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:35:50 -0800 (PST)
Message-ID: <3d1caec6-8806-46aa-b41d-cea2390a2375@linaro.org>
Date: Fri, 6 Dec 2024 09:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/arm: Convert helper-a64.c to fpst alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h | 94 +++++++++++++++++------------------
>   target/arm/tcg/helper-a64.c | 98 +++++++++++++------------------------
>   2 files changed, 80 insertions(+), 112 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


