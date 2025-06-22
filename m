Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51021C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAMz-0008DJ-Ie; Sat, 21 Jun 2025 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAMy-0008Cy-0V
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:23:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAMv-0003Fu-FX
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:23:43 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-313f68bc519so2177742a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559018; x=1751163818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Caplm7GLP2aeZVRQwk/fSuef1KQmZ1tPXtSSo+ky6EM=;
 b=lmpsrTGNnsoW7dmttxepQBiEDytMU3PQDQOxVQtfY/HBieyGga5WEBqSwwaqIug64u
 aATn74+30m8Z691DqDJwXrXKkOZimyeCr5SB0qw6IKdPzIrWaJ/MYn8MjliopGNBbKxo
 Z0vDqBHcK5ZsV+3RbizGRf0NEdAq3bXNNIZz9t9g9Ao7uaxPe7ElLGJfJ8xpnDfI3q5t
 XDnKVb9ct5KBaLnLoogQdNUUp9PKS0n/53Gqro6d4gs5BtPBh02TsToHaajhNwwzS9qb
 /AaGXmvBo9/urTxRb4sUgdHBwsK+JM7vQ09dTDhmmGoUGb+koqUaBMFpB2Q3yGTAtm01
 9myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559018; x=1751163818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Caplm7GLP2aeZVRQwk/fSuef1KQmZ1tPXtSSo+ky6EM=;
 b=kUNB85kRUnUnNowIkZF9dB7mvHQSUT4SXDSLfiXljiFJgZqYUnYq3WQDEc39vjcZtL
 UuKdsfLFqJ0/SogNtl5c5pdC5tC4eQzAofciDLyz7lnKg0pvYg1eRU1qpmtRa22yQBIt
 tHmWaHHKdzauwwMEewFKmDCMaIN+JcSOIB4c1nrXJKdMBGMjCrKtd6Be8bY1j7OJVCNP
 /8Cl4bk4qz3X+leq7R1HPqIuGLUAIzs1AvKFG9i3i/ppa24WZPPVZSwm8x/ZF/Ay8gwh
 ZG1r80RRMnVGtFaF4vKTxE9g+lzSPdFft1ZxycQ6LyWrxPG9IFqxp/hiha+Em8J647ZU
 wDdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/T98Z2Yem4b5ErqfShJ7YdVa8g2TwaCPqrV6FF8T1P070eQ/VMdOZL3eI/HfafsMHq0xyXhKC39JZ@nongnu.org
X-Gm-Message-State: AOJu0YxEO7p/YjslqKLFlWN142P0RJiHDlgRFdpU4tyjMsTjjzXOwh5e
 KBhk5to2RT1ANscQUj1/9faFfqQGpeGCsaFz6Q/49yOamsrJuSouIwduiKcbQE9+A9Q=
X-Gm-Gg: ASbGncscE8tBloLfTkG33OCGYblHYm5glKpCwmrp26KH4HyHrRC1f6uRdiqG8/g0Gaf
 X3795+djapUYEnKm/vsjreholoZ57DWHAQHPiG/4Scdoj1tX2+r7VHw/BBzmugvLWonQ3NF8Vim
 QbntK21aKO3ZHQGFizvEcZMNA/1sF+hcyWxGhHidaP9DLQXWDftzOLanCodKY0HkgMB6QNonFQO
 V3lU5Tffa/kX9IbuUL0E9ZnjlJvTZguQTFN6p0ktxj7hms4WxbW2LbbLnZ3Kjp2KWOBuO4mVFKi
 lWTCfWwK6QMhUgi4Vplrd+HkXXl2Xr4+im3dEYvNwcXuavreAHzzkTzgal4ZDeoaqKyhChE9XCz
 9+7zooTfFfRLrlWiTQIJbv0RgGYtu
X-Google-Smtp-Source: AGHT+IF13w871hqfVy43mbOHN+d1iBlhLXqi7XqkwIv9+ichG1AjKg6RoD0TkOe5BXF2C0QUyUz1SA==
X-Received: by 2002:a17:90b:3cc5:b0:312:e9d:3ff2 with SMTP id
 98e67ed59e1d1-3159d626574mr13672943a91.7.1750559018420; 
 Sat, 21 Jun 2025 19:23:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159e06a5acsm4812861a91.33.2025.06.21.19.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:23:37 -0700 (PDT)
Message-ID: <86a193ca-9f6a-4a1f-902c-8a33544f1c0e@linaro.org>
Date: Sat, 21 Jun 2025 19:23:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 04/42] accel/split: Implement
 accel_init_machine()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
> +static void split_accel_instance_init(Object *obj)
> +{
> +    SplitAccelState *sas = SPLIT_ACCEL(obj);
> +
> +    sas->sw_name = g_strdup("tcg");
> +    sas->hw_name = g_strdup("hvf");

There's no real need to strdup.


r~

