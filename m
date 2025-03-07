Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429BFC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg6j-0007IN-Sa; Fri, 07 Mar 2025 17:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqg6d-0007Hn-To
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:23:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqg6c-0001GI-5N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:23:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bcad638efso14079795e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741386223; x=1741991023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZXd9P4OZkyPtdusTwmvEbFh3MNToWxJWhiCbmiPCBo=;
 b=jnwr0tmdXuljZzDWN98INeewME0gvGYx16zCnMDk4vd7dAKZQ5sH/NbOHwYnIDLiH0
 rxgnVVWcypZG/1ixF40aSnD+hb7VrCqH7h0LFjgUG9Ekgs1fQ5vMKXbI6OBvCqw6xVME
 M/JktFKrjdYDjEN80m5auM0/+0dpZtOwc6j0y/nFltbzlO/LyxPAOpB4Z5vGEUdsO/pS
 FuRpQHJrnqaShneWtORRpVOYO4JLiI15jPZFh0Y8WDkHjxlfN3c5J6OUMCOgxwYde7a8
 to8p4TABrWqnRCR4Ky1boxiR/kGtCcO5qjpcjJgxcgXAvWELad+uZ9t0Sw2v44qfmdfC
 VmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741386223; x=1741991023;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZXd9P4OZkyPtdusTwmvEbFh3MNToWxJWhiCbmiPCBo=;
 b=JBwTAmgck47a1vNsuRe8RRlO3eQmVWi35/U9tM6ThddeBGHu+bExAmwO4rJEQlhKgY
 1clw5N5X8xnC7eu06W2ILqVy/kYVhkcvkk8PzmcU3XlOeivDSZD7LdpscS78kNFGFidk
 N713ftO9AQHS0BjhXtHxfXdCZ1ZocG7VksY8YQIw8ugNXJxi6PKI7CCaZRh0DALobvDA
 sB4LkgKF68SIT+b5INHgNauEKtKhs9nvZ9bxs7ojxQOUzFcHVY3hiZ5jwyWw2Dd2JamH
 sOgFytKf6ULoplgS+Apc2vCqZZutYzZ17xdRhzEOs5MlwRHevF3a8AQgWVhf9+EM7aQO
 HQmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrrcJSW53wNlGZ0+Kv/a0cz1zk087K5MikHTe5RRgKGNzB/foujkO70AU0zpk2gkWSFojDial88JqU@nongnu.org
X-Gm-Message-State: AOJu0Yx8hAZZ4y7Vf9ieWcSdt7UG2bJagh4Jp89SfEwya2ysA9xTGZPq
 SS1tAvy889XlzMvsAsfWVqkohuqQOPXTu0bcGCXLhGh2bL3sGOV3pPiIKXZjiec=
X-Gm-Gg: ASbGncs0XJGK8gzZPxFbY242Srwp7wFDPCUhNcukfnZsEqux+09FgFFKa4uxppdtAng
 RGCMQ8/jcOAA3cDIbFkwB8hILUIwv/kQgSbSL9XyACQZDzfaqlGjpZxfOISRTTzYd2suG7LxysN
 1NaeJ6trOKTcWTsqWrpZXiEq3d5FCbIprO5CGHQu6UPpt2WjAeFqGRsjfuN6Oc3KZkt9+nkla3b
 tVNatx76KdaXbgaiGerZbIHkpqiQDkpD+wLEW7xnKyg6jY1ehsw3SGEi6qXJ+YtJ2uVDDV0taft
 boyWjoduulJTet9tO81KKXpg0Z2a6P7m1FRam7MJRV4XWMAfGUIR4nOQglZGUfQPQczHYJCOHr4
 C0pX1LR6UF5Su
X-Google-Smtp-Source: AGHT+IG0aOFIpC0LaIYsiyBrDuU+l9Tb16aa/GM+M+iXikNNl/3gwXb5q5IdPZoL+HJ+If/Hpi+abA==
X-Received: by 2002:a05:6000:1a8e:b0:390:eacd:7009 with SMTP id
 ffacd0b85a97d-39132da110fmr2755093f8f.42.1741386223416; 
 Fri, 07 Mar 2025 14:23:43 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c10437dsm6763118f8f.99.2025.03.07.14.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:23:42 -0800 (PST)
Message-ID: <89e26da9-9beb-4091-a6e9-6bb5e650627a@linaro.org>
Date: Fri, 7 Mar 2025 23:23:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] include/exec: Split out helper-getpc.h
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-16-richard.henderson@linaro.org>
 <0107b62e-48a5-4424-b238-9bada9e49217@linaro.org>
Content-Language: en-US
In-Reply-To: <0107b62e-48a5-4424-b238-9bada9e49217@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/3/25 23:00, Philippe Mathieu-Daudé wrote:
> On 7/3/25 19:56, Richard Henderson wrote:
>> Split out GETPC and GETPC_ADJ to a target-independent header.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/exec-all.h     | 19 +------------------
>>   include/exec/helper-getpc.h | 31 +++++++++++++++++++++++++++++++
>>   2 files changed, 32 insertions(+), 18 deletions(-)
>>   create mode 100644 include/exec/helper-getpc.h
> 
> Preferably include/accel/tcg/getpc.h or similar

Also these should be guarded for CONFIG_TCG IMHO, similar to
include/exec/cpu_ldst.h:

   #ifndef CONFIG_TCG
   #error Can only include this header with TCG
   #endif

If cleanups are required, I can deal with them later.

> otherwise:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


