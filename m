Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073ECCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7HNe-0005uM-1g; Fri, 10 Oct 2025 13:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7HNb-0005pD-Fh
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:58:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7HNR-0003HY-NK
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:58:11 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so2346574b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760119077; x=1760723877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lgJ3tcscWZQqDacmcACVzQEwWsbClAK/rSM74ZhWPnA=;
 b=t1pefm7fKbt80X/9ytz2rUb2psIuElQzao3evstmg+eiYo6NgsoVsTLelFL2dK39wr
 LwsHJX+V5pnrt7x5pzm3lhQ4kq0in1ZdsjqSwDml7oJBAK60pMMa4yX4PGvEnbp3g2Nv
 eql70OLDAGKfIjtRP3JUZdMNSaQ62viOfAmqBLwogFNl0HYpHyZnPFqFTJztUyNAeaPf
 avIOy0p5kcit1fLLTgmxpf1FPlAPGsTrgMw+UY5ytiYrcxL7ROW3z0Q70mvLc4TLXGti
 idgJr7WLtCNH/fDW04qgAS5C/N++vlHq1nuh0MaywdKeJ4wbt6d88vmIoOp0trRAAtG4
 Mb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760119077; x=1760723877;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lgJ3tcscWZQqDacmcACVzQEwWsbClAK/rSM74ZhWPnA=;
 b=mlsJON2Q0hOGV09J3lgEq9Ek8Yl3rE+kiJCqx0tWcuunZovZx/bJSrHZlQJLHtfuRU
 W9oy01Up4i15UHaVyyXeCSi/Slcf6sSeYlQU4dZ+sQZWaZz0pva5cxPlz1pWvbPSaHwj
 2NMyToYg1fy0+oq6WzZnnKlnHH7BIhwia0Rbp4QSPi7pvvZK2Qe4C/Zb8WEaQBfEErFY
 uAr6QpyEfSr8X3FfYuOHq/pXCpyYkNP3jCioGGBBm/UYvc8QRqMt9V1kpyqp7htrcXZt
 xDHuHrNgOfHfqtQyPUfKUlkjCrAO69iCgeoDquApwEf5VsGh2nmYjMOzf7qGiDSDHIuQ
 3JwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR+sIZTUuaGIXxVOkdlmU+q/rqLh5YJX/AWziTs9OA/5TxG9+m00gKojPp95/UZ1sMO6D3daDWlNkK@nongnu.org
X-Gm-Message-State: AOJu0Yy9HxYHJt3qRAabdkNCQbdgza8EN370PQhuNDcUO172lfzP3GVz
 GbJbuDqOF1fK6BR7nOn0lHSVRXC+1iSAP8VMlVokHvOnemO/yeIBTutJXJPtsTirfLE=
X-Gm-Gg: ASbGnctAAx/zFn1hLYQbDLXJFPhjgS7AKw0HJaQdZejIcc5MVrvoEo/w0ZuQrVWntzz
 LeFEimqB8ksbCzmygyJZRbvGxqlXWgFj9H/4mPN+uwCvbfM7l5PMw/qTTP+9qhitmJRYOHGnCDf
 izPW5RaUi4xjOxn9s+LptEn9z3Ad6qjUMdViZBVUnYDDcuQC5Od5NFbp7U36HHdDHCZVYrcX+kM
 +GBzC2YFRpXAO6uw43gEx8ABWMMKnItnh6fc3f00JbfJjv9IepJU2BK/laFNeimmlkE0W7/+HAt
 vzm8QN18jjkrfidaNdUAOnCTpmLPX/i7ctDpamiibU7bDGeM+6ACbbYw5a+Yx6A+nE2hNRMG0Iu
 DVSPGLl4AbFt0SMRtlln5QYDV4fBB4HvbaJfPQrIejpG1p1Jys11gytmRZJU=
X-Google-Smtp-Source: AGHT+IEyes5Pw3Iitakfnl0gnOgg0dAhq5ICs6UvxjKtdR23pokqyDd3lBacP/91g2t1+VUMVA9wZw==
X-Received: by 2002:a62:e113:0:b0:77f:9ab:f5 with SMTP id
 d2e1a72fcca58-79231eee6e9mr13839156b3a.14.1760119077017; 
 Fri, 10 Oct 2025 10:57:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992dd85317sm3574675b3a.79.2025.10.10.10.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:57:56 -0700 (PDT)
Message-ID: <72ed8f25-8bc4-4d9c-9e7e-1942a1f7c020@linaro.org>
Date: Fri, 10 Oct 2025 10:57:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/hppa: Move CPU::cmdline_or_bootorder ->
 Machine::boot_info.gr24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
References: <20251010061836.45739-1-philmd@linaro.org>
 <20251010061836.45739-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010061836.45739-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 23:18, Philippe Mathieu-Daudé wrote:
>       } else {
>           /* When booting via firmware, tell firmware if we want interactive
> -         * mode (interactive_mode=1), and to boot from CD (cmdline_or_bootorder='d')
> -         * or hard disc (cmdline_or_bootorder='c').
> +         * mode (interactive_mode=1), and to boot from CD (bootorder='d')
> +         * or hard disc (bootorder='c').
>            */

Again there is no bootorder variable, so gr24 might be better.

> @@ -685,7 +686,6 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
>       memset(&hms->boot_info, 0, sizeof(hms->boot_info));
>       cpu[0]->env.initrd_base = 0;
>       cpu[0]->env.initrd_end = 0;
> -    cpu[0]->env.cmdline_or_bootorder = 'c';
>   }

You need to retain this store, but adjust to boot_info.gr24.


r~

