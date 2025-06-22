Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E43C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAQL-00018v-1l; Sat, 21 Jun 2025 22:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAQB-00016U-47
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:27:04 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAQ9-0003cP-2C
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:27:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2405976b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559219; x=1751164019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnpXsZoPZAlSnSi06Ja+UiBpb7h4MoWvJrEoclDmjS4=;
 b=f2EuiWBOZuvViahDmAOm4py2wPrVmEGlxshiAEL2LIanqcqOMu+NtzUyVghxk6WbG4
 H4vcKEhSqBsMF1HK5wSnagec7z1CQCGse0vboMLDaAD399S2FZkDbs5LgvJtWZ1k3Wax
 vHoqc1LTOQumbUDtnK3m6djbRPec7hs0ep8Rcc8FU09W+t1ZxBM9BZAMknAgYrlQ0tEY
 Ko97UoIvbq4HVHc4JNIDF9Smpr0T/o1WgVqHhXxAidL1U/sXVNqJ5b3c84nrVQKgP1BZ
 OrK9ZGUm83XY4/jZgldOdGKtnKi5RmxsJzCWzqy+jmWniMxixM7CwWKGXiU6pMNHq9of
 Be1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559219; x=1751164019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KnpXsZoPZAlSnSi06Ja+UiBpb7h4MoWvJrEoclDmjS4=;
 b=Nax8sOnOracST5FbF6ZkUhbXIMbWL0VN0gWDDMiOVv65dju8PcAIGBvDto7B4m49DA
 X2vj7epgZTpxTcTT0IhLOwXjt7cbmWAShmtRk0+cexi/FVrw1FERUBd+jAQvq+alUfX8
 JKK0Amj7radWNKDZriAfZLxU/MbMHMru9SrcR0IQUJvhHnn5GToYb/U2WWw3XvuB5oL9
 Y8RG/3QJNq4Q5W9zZgMi+uFeZ6hZVibtcLgMd+nz4dzcpwAn+9Z7a5Hc1ydip8wzirAy
 QMpqqfIbtVIl/9QmTms/9Hfc2LTEiSytFLh9m6HFjBIssSI34rtNN1S4Y0DSlpg393+o
 EpxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhpgY9XCiQTalq584Kxb4Gn/Y0LjNsuuSfkopRNW72dwvJwoNscDJj0gHDr9LentvbenfqEg8IHyH6@nongnu.org
X-Gm-Message-State: AOJu0YyCyjajryqrKRIPYY0TPLsWLuxqnjJLUY9Rqi9xW4PC0FUI3X5R
 Msv+oJ6YEhsnXEbgiVKCwvrnAxBto0aPqCSLDPIZVeAzPAy8JiJ4kPjxxk3MlfUBrv6ALiQJ4NP
 5dRVPcaw=
X-Gm-Gg: ASbGncs1wK2bJDcpIqjasLRL3RULcIR/syB4H7xSGtM8H3y/9Ng9UzwriAG9+uhjVYt
 Mgu6978DpxMQaTlb8XP4dCeLabiKtrTKbjlrcPfm64WJdX4AbYaeht659da+t/52yzWqcnlvJCu
 xrUuDnVq9vr+j+rNg9Y+ShA11g2wRDVIZM/FiPYEDneEHh50wm2nnvEWxXjQ6U4/ZkkJFH/0+a7
 mXa+y+/AVcpxiAoGu7mMq89u7oyOrmppJZk1fGsfe4ZxXICJz8w6BtoKHyes8fNklnQlZtK61DC
 n8L51k68SqtyUG0hg5bT3ktFgWls2lLA6YFrTvYd+JzVa/bcF9dPI0zob5B4CnSuEEc7eodbDLQ
 DpgD3yaSMKdtHiDJsMHST2l4uWvTV
X-Google-Smtp-Source: AGHT+IHXuFT5ZFS5A5XMmxXrNxqr1OvoVAq4rpmivM6YZ2vzclB8QenB6LEq4x/t/lf8cz2wCOlj+g==
X-Received: by 2002:a05:6a00:3d53:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-7490da6e841mr10496374b3a.11.1750559219353; 
 Sat, 21 Jun 2025 19:26:59 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a64bde4sm5192970b3a.124.2025.06.21.19.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:26:58 -0700 (PDT)
Message-ID: <76773d40-5c57-43e7-a06b-762a28f4527f@linaro.org>
Date: Sat, 21 Jun 2025 19:26:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 06/42] accel/split: Empty setup_post()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-all.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/accel/split/split-all.c b/accel/split/split-all.c
> index 28f626d0ff4..8b9f8ff77a4 100644
> --- a/accel/split/split-all.c
> +++ b/accel/split/split-all.c
> @@ -37,11 +37,6 @@ static int split_accel_init_machine(MachineState *ms, AccelState *as)
>       return 0;
>   }
>   
> -static void split_setup_post(MachineState *ms, AccelState *accel)
> -{
> -    g_assert_not_reached();
> -}
> -
>   static bool split_has_memory(MachineState *ms, AddressSpace *as,
>                                hwaddr start_addr, hwaddr size)
>   {
> @@ -129,7 +124,6 @@ static void split_accel_class_init(ObjectClass *oc, const void *data)
>   
>       ac->name = "split";
>       ac->init_machine = split_accel_init_machine;
> -    ac->setup_post = split_setup_post;
>       ac->has_memory = split_has_memory;
>       ac->cpus_are_resettable = split_cpus_are_resettable;
>       ac->supports_guest_debug = split_supports_guest_debug;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

