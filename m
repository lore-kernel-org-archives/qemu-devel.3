Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EA9C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 10:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8Hlt-0007EI-Bq; Sat, 18 May 2024 06:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hlr-0007DL-4y
 for qemu-devel@nongnu.org; Sat, 18 May 2024 06:58:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8Hlp-0004Ie-GX
 for qemu-devel@nongnu.org; Sat, 18 May 2024 06:58:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a59a934ad50so531795966b.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716029912; x=1716634712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xT0eLrzC/Z/BVpcaeEUTbrpvnda7nmxnI4jBsyxh0Jg=;
 b=DrhzZ2tJ/VTbVEYET/H3/mDEtzf53TcSeKgYjQN/MMtQY5/TZ9TgQqYq58YABVul+W
 /tdFJNiotORdkZRkE/RK7RrZYQHC08REO9z3BuuPCByp1ygwZ9caj6tWdQUDiaysYV4o
 LJnfyGUT2EtGDmXm2iDzRD8eqa6DoJNus0T0gTJ5jIHlIcNrfh1yfwmmjpT+KeiQRH9v
 B6gZ3f61dhzv2zcNFPxE8nDJKraXqk0mvYn7OVBcCqLYe6p3vyvQ7YRhdKzSxptuHFu3
 8Zm3UYkB4xZy/84APFEm5RN7fdmOm5eBNMF4YRJMCKUAdrClbfmVzkp0xO1q5FPh81pJ
 UXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716029912; x=1716634712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xT0eLrzC/Z/BVpcaeEUTbrpvnda7nmxnI4jBsyxh0Jg=;
 b=bmMAtYRa0SoMH+c4JCCt0RAnLo5hAStX4/ct3LzmDlSB0hndkaCB+3vmBs2C1OBL+8
 HSVxQFBIK5QGMI98CAbzjuwX2Mk/1m6Y4yrsSjZNu65m+DisK2fQN1+QmdIAZZP2s41x
 JThsZASi7OBLrxtPAmzLPuL4/VNukuSNThTDl4BieJDowIX4X7Ny2ZPO1bb+eg2uEz6m
 FKd0Z/StFV6VyvRGI+XzvarOMXN7GX2lhFr/92ALP4fcUQpDqskPsvwd3S+fz99LP4f5
 VGjXBvnWqUJSIYYaO6xxTw3yFK2bDMEOsR3ua5iyvZ18v0IBiz0niO9X+zPblXxK5Xvp
 mbPA==
X-Gm-Message-State: AOJu0Yw3wa34nCuIG3WPFM8h5znt3Gdwul89f0rTdCnfar8aepbSVOxW
 dBxflZ+PVDTKTTVjM9L4tRnoevbQZzJYKPrgX13jXUPtiuE74Kf7XcD/ejL5w6o=
X-Google-Smtp-Source: AGHT+IF/KGU4hn7YpNxPSOHaIqmSG7vm6p1RMHSLbDvvH8K1L8xma3BWJOgrstFcdPlbsnhAW9jkyQ==
X-Received: by 2002:a17:907:3f0d:b0:a55:8f2a:950d with SMTP id
 a640c23a62f3a-a5a2d53b28amr2162580666b.16.1716029911376; 
 Sat, 18 May 2024 03:58:31 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17891f87sm1203291066b.65.2024.05.18.03.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 03:58:31 -0700 (PDT)
Message-ID: <85266815-a408-4345-9774-2ea52c97eafc@linaro.org>
Date: Sat, 18 May 2024 12:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/ppc: larx/stcx generation need only apply
 DEF_MEMOP() once
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-2-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240518093157.407144-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/18/24 11:31, Nicholas Piggin wrote:
> Use DEF_MEMOP() consistently in larx and stcx. generation, and apply it
> once when it's used rather than where the macros are expanded, to reduce
> typing.
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/translate.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

