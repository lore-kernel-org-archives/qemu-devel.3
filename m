Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EFFC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 18:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9pkb-0001Nc-Bj; Tue, 29 Apr 2025 14:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9pkS-0001L1-6M
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:32:07 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9pkP-0001OR-TG
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:32:03 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so5704324a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745951520; x=1746556320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JvRik9u/TiP7O8jbLvFxdr/99ljzzbBCPxuGL7wqLTU=;
 b=ZT2pSxDTXyVB6r6vHFsGGI+8Px7MHGg0SyQnc0XD9gXFbqCmqmYPjB/VAihFfF7Ub7
 qQGjhpeFCYHfrrG1n315Tqx60RN5hG08miIfQq+KXAWNFBEmNPrstJojPe5STQkPfDnL
 dCKSRdm0RYC3PbN6UJf5D9p0yT8T6GquQXreWyrcXs6ZWziJF24OlMLfRTSaM8W70A+0
 NqI0sNuw2vTMBpsZ/pEB/2HvUuaggtk1JauEeNpmOyR66SeUl6oiNwl3EvQJf4+BIQtJ
 lxp1ESfMPjA6S72LY8tl61DhsmKKCuGXI9st4nno5lDTTsMnegnKVTXRY2EHGhqShGWH
 Q39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745951520; x=1746556320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JvRik9u/TiP7O8jbLvFxdr/99ljzzbBCPxuGL7wqLTU=;
 b=dMSyI9tfn3qEKtwQ+/0T+46LEt96+tQKxeKdYZtBwttKWXQDXQjrVyTdPV+XEYi5ct
 d6pVvUYPZBiAk1I42i5aoFOcE/sS2rc02+1X+P90RfeFj3or1mmpsqvWkRK4FrrtVoHz
 DgtGfrL/inHOM5R933ukwdXbDDayuFJ8fmIqDWoTDrsvg493i9KQzpVESRcVHpD06PnW
 JjOJ+jtNpaB9PhRHj0lbLiYoghx6k2GijfGrx5EJ6hjve3DQU++USsR1UKCLKPEpqmuN
 owzj1RWnlyYxpUj3qis+MEL3NTn8+k/q9EFJOReysZlATmZXdVRJiBBAl7k7+5FaF03d
 qhFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU70uUUMV+bYsKQrqh0FqOTqB1D7OzaccwG1gnMFxa6iW78ivbZn8mz7UN5gPzYY126V5ZjBzP7Q0h0@nongnu.org
X-Gm-Message-State: AOJu0Yyly8JKqHKRioBrjV7U/YhRzGbJK5ZWaDgA5ku2PCWI/kkz69Gj
 Y11byi2s67c8eGFOf8PHXnWii9XuNLDhoA5Qp3L2A3Kn289lo4X6I/61YQ0xm3I=
X-Gm-Gg: ASbGncuNz6Yq2aVYYiPCyj19PzGppnw3AR9CxK9ByPNY/hVtSB9vKfXvwe9ra+MYA4v
 ky4k/gPzIebL65r6DmVwjJJciWMRRKz2z4CZ92TrkVFTxJGaaFHFBtiMvvrIdxTqVr1XmFtSNjH
 8dA5s1g77xO9VhM6FAuJtexFi7aV0AxsMtk6SO6lP8E6ZFJgDnQg6VWHcb9sVgcMyeyESURAbv+
 J73mNCnD4506jxM7Uu4THuaBDB7UEPYqa99S7wnDzls2ZfvevbdQ34C4hG53HP+DBLDOt/b5o7K
 npInvW5+oYdixi4OC39JCQyZQLczdMEcDnIEMQSAB1NWJvpvEpRQn0y87DXy4NfV3GtIpZOEoUG
 4a6Fx20o=
X-Google-Smtp-Source: AGHT+IFbUvReGtp8ExsyhLE1Y70B0LQ/xw9RpVmkLTcZhlFU7aHCodTipl0c/kbGjs8sQKtD1DV4Eg==
X-Received: by 2002:a05:6a20:6f90:b0:1f5:7873:3041 with SMTP id
 adf61e73a8af0-20a87c56904mr60256637.18.1745951519948; 
 Tue, 29 Apr 2025 11:31:59 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a99a9esm10565796b3a.140.2025.04.29.11.31.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 11:31:59 -0700 (PDT)
Message-ID: <5739b304-a490-4e1b-a6d8-1a33ac9d07f9@linaro.org>
Date: Tue, 29 Apr 2025 11:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/migration: Inline VMSTATE_CPU()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Helge Deller
 <deller@gmx.de>, Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250429085148.11876-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429085148.11876-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/29/25 01:51, Philippe Mathieu-Daudé wrote:
> VMSTATE_CPU() is only used in 4 places and doesn't provide
> much, directly inline it using VMSTATE_STRUCT().
> 
> This removes the last COMPILING_PER_TARGET in "hw/core/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h       | 12 ------------
>   target/alpha/machine.c      |  2 +-
>   target/hppa/machine.c       |  2 +-
>   target/microblaze/machine.c |  2 +-
>   target/openrisc/machine.c   |  2 +-
>   5 files changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

