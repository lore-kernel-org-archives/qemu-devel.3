Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C564C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 18:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUWVH-0000QQ-NC; Mon, 29 Jan 2024 13:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUWVE-0000Q4-Fb
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:37:04 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUWVC-0002ly-TY
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 13:37:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso40430505e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706553421; x=1707158221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dq4k9QvCB0U2+ofqzWjGaQzZW/uI7lb6tnDi294AbgE=;
 b=Z5IRa7MmPtV8QK/cCA9MscMk+V9avUDDHUNHfcVP4/DYRthZAv9oMQNEUJKjF2C7Ij
 yrsBy6Z3AE6bQOVKLZ6gbpk0wJf5y4OrFJQpm8Lg/rQrMimJCS+O/7Gynt9s9fionNo5
 eXrMmTSVLM1tPF3Cp/p9hwUxUNV2ImnkAvKOS7JUdN+rsfIuQKJgWCZnYLzcZe/inwcZ
 M/Ch/OQ+ufVfIPNeEompZK71dceOWliW5z+mAdf07v8HEB8A3BMgxdeLz4gCrq6bWFbC
 BRB8K5tkuoeIYPriKSSGfUDLZTnW7Nvfmf5m2xmbgik+8yoeG2tlF+lmKRqsyi3+FWPQ
 VOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706553421; x=1707158221;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq4k9QvCB0U2+ofqzWjGaQzZW/uI7lb6tnDi294AbgE=;
 b=wEAxMzZolG11F83yKt8BQ05w/mdlafzU3tYcuGGsux2JHes0jGL9zI5rjmW+05Lt2s
 OjwjNOhWMarsMmOsb4JFsQ+VTklR4Xsy2QiapigeKXRQtSb8C2FD98cMVuKlrxoEhTmA
 Gj+RvbPa3aqo3VgR9Q/wSSr4LUwyhe0XZ267sWgeLqKgnKRjLlglwk4XAZSp6y6O9P+g
 CVsffO9GstY4g7x2MP8urZHnOtDKG7HI3cXm8+uCj/KeXiZfErlfehk3kdr2kFU/4rEg
 Eg4EzmnLF1b9D2WZWtxDpYYAuCLkmy6DNuEh8K8igRhbL9IKAxQpcryLAiCeWjVRaIN4
 YxXg==
X-Gm-Message-State: AOJu0YwY26JZSmRfI4umQL379cY+jNRzy9onGkMzxt0I3xoV9SlZAqjq
 LvAfxB3TB5/o/4M+azjiltkTy0yYQSEjrMzj+XQ//6QGe8FXgWR3PRXLB2lTQmboi6kL2C5P/UO
 3
X-Google-Smtp-Source: AGHT+IHnNh2kEZLTmn/wyBFjcWeiY8fk5cAEiMhnNIn+LOhJ1e4yLk0FMJ5exR2SmZlpKhqJ6mY/ww==
X-Received: by 2002:a05:600c:548d:b0:40e:ce97:4452 with SMTP id
 iv13-20020a05600c548d00b0040ece974452mr5264430wmb.34.1706553421195; 
 Mon, 29 Jan 2024 10:37:01 -0800 (PST)
Received: from [192.168.69.100] ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 bj26-20020a0560001e1a00b0033ae6530969sm5934786wrb.85.2024.01.29.10.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 10:37:00 -0800 (PST)
Message-ID: <4423fb07-47a6-4b1f-b2e9-f2800f66b91b@linaro.org>
Date: Mon, 29 Jan 2024 19:36:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] tcg patch queue, pre-pull
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
 <b36e9682-aaef-48d7-8c17-97b60c7e3c46@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b36e9682-aaef-48d7-8c17-97b60c7e3c46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/1/24 07:30, Richard Henderson wrote:
> On 1/28/24 14:41, Richard Henderson wrote:
>>    target: Uninline cpu_mmu_index()
>>    target: Uninline cpu_get_tb_cpu_state()
> 
> Dropping these two for now.

Good news! (for me at least)

