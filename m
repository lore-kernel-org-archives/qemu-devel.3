Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2855C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyes-0000Vk-8S; Wed, 02 Jul 2025 10:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyep-0000Ut-TS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:41:56 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyen-0006JZ-Vm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:41:55 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso3086384fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467311; x=1752072111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fJMbZzyuCjKMp2mBYkZ6K5DWbXj8hlCLm1I3s7QFSXc=;
 b=WoNNXQ4dY/XuOt6ZABz8BU6qIacdlCS4ggZ7eX3C9Lj36DjX4s3IhaM6hEHj7lGYmC
 o/9Jl46oEdL/FWRhAf3Oo0URGOzPIAXtFjFDmNrdUc+anOkk229sASoX8krOl13wMc6S
 k1O3xWEYTAgbGSPgUp8hrxFztOlTHY1nShUCu0tevAAFc39A0Yhkr13jHHb2QGw/9PbZ
 MWB5SGY3hW0jbBYcM6p786MjBWcqjygKfu7TAIuvyuyn2UMTlS/w7HX7lAtAO9awM9zK
 JHY2u6raeuosOtx8ru4T5MwAzpQTNUGA8MqX/rckbJlHpQCt/Q28PKS5exPb7UPTJjwq
 t5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467311; x=1752072111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fJMbZzyuCjKMp2mBYkZ6K5DWbXj8hlCLm1I3s7QFSXc=;
 b=SBuenbY1XExA9w9JJZyc5ykvNNSD4ZMlKPfyiqTm6oetWC/ZeVVQgWknhVgv1VRvWB
 /I80gkuSgXwhqsBt0Rgm9IK3lf/sQB0ezGq6QfYKUxJELozuYpqiLDD/YtHSjtnda5bd
 1t8VvgcaymaR7OyCU0IN6DcFCq6UNmZihbEFJjlxoqtL3ZQ8sy4XNWEAqy6uO7eu5p0Y
 jgla+/eRO3+1LwyWC8ZpYA/7ZRLKAg47jfUs+kKqP8COP5ofeK8kELidOiHXepZ7ny2I
 Kver+b+OiEomB8pRqALMU/P0MMJ1NNZG5Bp1ufmEIqmn1lsdIcTCdCEpgz5Muv2a2gom
 64Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNKdkbJP3Se4ylDSQct+MofqbeC41y+UFsyWwcBc8G70JNgip3Jh3RW1enEn0DwpJxzVIr53nWNrjd@nongnu.org
X-Gm-Message-State: AOJu0YybiFoYLVEwj2eC2itwIavAlb/7O7suBL/6CQGSaHzbJrmwNv0O
 B2PCEMTaRCaqxJCkGPImGc6rAqrYYCF41vA4vCkWgBEr+kTHsV/LGqiYQqvdpgSk+2s=
X-Gm-Gg: ASbGncthzoOR+5MWLabxrm2HOp2ZLac803H7lOC1vq18nA10X0eQtSg/rA6qseX5Q5p
 3rpvZOJCr4wU369fk/a+3Db9HRscN7S5kHLq1L13Jz915Gv7k337rFFbFp/LXmTnq9V0IspLsSv
 WGt17L3SFCEJMBKuHJIoEXV+LmHL3pHfHoegNOrSA5+VC0SYBFyzVSnCrIkDcW6DfYSVFi8Xy3u
 I84jzzJyi7E42zB/qBKvilZksfOs/wEr6uQdmV3fZH1qGRwyOt5JvGwUyezL1nSi+ANem0bYyg9
 h1/Ip0Ue7BV9ks3rF0WU2NpSiI8gmN2tCJIZO+QGClIkQhns5/n5GOLp64YMYYkDEYdvo91wEmj
 B
X-Google-Smtp-Source: AGHT+IEyjvWaFxn0Ya2wxqb3M7UcnlwvxvBb//VJmNwDe++/fGiY2bQlrtm3w9r61aGTbyUr6+YPfg==
X-Received: by 2002:a05:6870:5a4:b0:2ea:736c:2b08 with SMTP id
 586e51a60fabf-2f5c7a9111bmr2567299fac.29.1751467310889; 
 Wed, 02 Jul 2025 07:41:50 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b4d84sm3859002fac.23.2025.07.02.07.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:41:50 -0700 (PDT)
Message-ID: <96fb3575-726c-4637-8223-f4948200567d@linaro.org>
Date: Wed, 2 Jul 2025 08:41:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] target/arm: Fix VSTR helper store alignment
 checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-6-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-6-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the store operations in the VSTR
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


