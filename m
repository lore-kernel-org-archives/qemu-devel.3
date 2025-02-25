Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264B6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0gm-0004vI-JM; Tue, 25 Feb 2025 14:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0gj-0004iB-Q1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:33:53 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tn0gi-0008At-BR
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:33:53 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so21648835ad.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740512031; x=1741116831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kAbjg1fSFq0ywZ6CWns3M6T6SHr6oBZgf29OdvFVqUY=;
 b=HX6XewVoBJdqewm53GoSlX8Oc/VmOTfHkHyybOG1R3yT3WyK6YM6GTf+AVLv+km7xD
 YAO3oB470xwYmEYKIF8v6RIXSKamkba+Lh0pyXaCOdtBxIJGeK5h2NHWsyiriSiDrmO3
 5cAHDB3KNKRcEffC/VEP5aleV3kZinHc+0jLNtIGjjBlwNNoE+s1fq3nULMUUzJaMeJW
 TMT3QE07frIeqelpXEVJi+qOgkuGsnAvQGGfvpst8shn3ERZLur6QSflwP0lBlZOzVuZ
 ZoRU/oCvKS/Any+a5I0Cv1bIUl91vXfKJFSYcDX3FQGtlaNKVPeXtoaWRGvjF6sKG7bf
 KWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740512031; x=1741116831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kAbjg1fSFq0ywZ6CWns3M6T6SHr6oBZgf29OdvFVqUY=;
 b=acRoP9aO7gTcGU64JaUQd79IfpyIvYilCLVLsnEXyVKjiPb1b/BjHb/QKUynNUbBK1
 TrsMdOTmuJmMNOSJqr1VqaMWwlv+uVfrnbt7VqSHQ6iEvdFtIBhqUfpHbqjqsTwODtZl
 /AYFYrtUxxU4yI4+oXtl/QJBY7kqyVozqskP60SXnj+FM/y+2QTRicwd68y62hNnqNcg
 iMWmmsswjsqjXVccyxzLMZtDa4DqdEC0JpNHAx6uaBx9JaiWoVvI8zTVzS9n0dGCGbSh
 rRGBC4JZB4Gnvje3aa0bKM+il3/3r9w5QkjTCEi2RDcPqVSdx4frMkYtqVJ4VrfAOJqN
 Tutw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsuckdykhe7b1J6auKiVFqOhGsEkbRg8sOEmfAdvYLVzF0UNspRMWlCQ0fjKeRC/FinEW33gpRlIyg@nongnu.org
X-Gm-Message-State: AOJu0YwiAl6//Ve6f3kMugkxmdox13YBLAbDJ1Xqx9ni/x5UMVVwZER9
 7FOQzNde+tdcjfiDlOUhBLDgKBuZ/rypU8hDkuMoomyqcPz53aBB/s+OBkUgsMk=
X-Gm-Gg: ASbGncu7LGJjLt+rAF4U07BZfyKq2rh0zlXmzdzNSTOWBenUaOBU51VnDO1OsreAVlr
 CdUYQFHnJV0zTGL4P/KRrxcKpsQavGShr72o1slxAedCPL6LVAx2xtuc0guOdoepCtvgoOTRsIy
 Capu58kUxujrZ7X97RQJ++m0deFkLanv1mNEDmZl46ozlEOlUzoCwoWe3rC2LowUi9XplZrruJE
 NNd0u7MaQnFMrcivlHNcqJys8Qq1gA3z6x1ib7xdOJ2xVhIfJKiNd0+h4IBf5T2oZcsHhu44zv1
 IXy9staNZMMgrnNHRXGhHIX9GBJVu1+xRRKPwHbCULWMA87xFAVDJso6B6v8EEwVk33QbskstO1
 QouHu6uA=
X-Google-Smtp-Source: AGHT+IEfunvgFaFJJMsvNCpMPG6KHq1q8EeO+WSlyj6YGdqs7+7k/5bDv8qgnkr5nu8fQP4h1mA1LA==
X-Received: by 2002:a17:902:db03:b0:21f:6bda:e492 with SMTP id
 d9443c01a7336-223201f7e34mr10852695ad.35.1740512031028; 
 Tue, 25 Feb 2025 11:33:51 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0aea5fsm18102025ad.224.2025.02.25.11.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 11:33:50 -0800 (PST)
Message-ID: <ecce2fe8-f2c0-48fb-a3dd-99a1c4720dd5@linaro.org>
Date: Tue, 25 Feb 2025 11:33:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/hppa: defer hppa_ptlbe until CPU starts running
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
 <20250225184628.3590671-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250225184628.3590671-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/25/25 10:46, Alex Bennée wrote:
> @@ -191,7 +199,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>           cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                           hppa_cpu_alarm_timer, cpu);
> -        hppa_ptlbe(&cpu->env);
> +        async_run_on_cpu(cs, hppa_clear_ptlbe, RUN_ON_CPU_HOST_PTR(&cpu->env));

Nack, this is emulation of hardware, not softmmu.


r~

