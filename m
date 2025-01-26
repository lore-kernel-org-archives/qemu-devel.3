Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F6FC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 20:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc9LJ-0002fP-5s; Sun, 26 Jan 2025 15:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9L4-0002Z9-J7
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:34:39 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9L2-00011U-P1
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:34:38 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so5750051a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 12:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737923666; x=1738528466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HV0rFwm2c/DiJ3VIFDuxU64dDw12Xibjr9C6hrIuIZM=;
 b=IyvYzXDWglqc2TDOlIfdERC6BgdriQ8JCKYJTBLWun3F9TCTgSfxWb3NVtzrfI4wBJ
 hooROt7D/k/NyHzUIRvjxeQoTPGE3a1PHXu5/K54RM5iTuh4BPGEdMHZ8aycNVg8j5en
 oXalHdsFjhisKhBd9VX84pyuw6gOegqwHCmTAtzZTYBdtBYryLQM4FVNZsXZChRpmnmM
 pUHKGtt+UxgZINaiHoIMQIh4D/rJCqAo4gShYQx7p8kuWuuzwq8l4RjSPuu/tQFY4eOi
 jsXecPVxZKMoVhnJLd6x2tQewxZ/Eaa+9sUtlPJfa9dLbfYzS2tL9yqSRMif10yuB0Ph
 WAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737923666; x=1738528466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HV0rFwm2c/DiJ3VIFDuxU64dDw12Xibjr9C6hrIuIZM=;
 b=c0BcO2t9o8wdQ1T8enJbRwsHCwDiztZQigm88IfU25eHPAFEEcC5vm6Nzxc8bGuxkT
 mng8RS5hiBt2NHmDn7cnmSpiZ1yHrw3uqBr+vZtsFTk9LMFZCn/jRhnSAgScdW6tRbap
 uK3OH9G6IRNIa/3nrPxqKCBPT0OgMf24WUzrd6LsbNPjKdmC9XBjNb6JCiIqgM6tn3cf
 tWW99OMJTEs8zfwLNYPGlNUJXbQIEo72KLaM5+KbGeuDcvN15geM92B0JPFBBfhjnkFl
 I9fEMSQPG4BlJsJafPkFGjOhKjh98hz+lu7tg4eqiPnvGAGhu+hpbQcRFhuObmYIv/6m
 5HFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJt6xeER7tRDrPdQOOS0FMocisA0m2W/EM8X1LmhUVKcLYpk/ZsGJ1xA392P97dScVgkfQaftIvkim@nongnu.org
X-Gm-Message-State: AOJu0YzKCs06YHnjgilzzUpmbvLHLepF54Of/Fo3eT+v0DXwK5QLR5V2
 zavBoBZxI2SG4brJpzOHgsCbVQPYtkQaDymNh6B0crseZI9tZMH82tbzX8cwnjIxNzj/O3rWD6R
 O
X-Gm-Gg: ASbGncufXUxvGCy5USLXX9MCFjK9Oj5nLfy5ML+B7Tuih7J3mzuU7j++J7/0bzG+dC7
 4mcp5nR8kZEqor8skP6anve5n+PjwPmW2HRSm8W6nhreoL90rWHNFzZxPHymwxBaF1wr/QsZjzq
 GYUcbz1S+0DLZkaf7czVYU75q3bfBokkiTjG/vlJCsebi2szbdFU0giYva1hJn406+gNcmcFNe5
 vB1Cnr9ISOq/1MO2PgkD2TrAdFRMc4PwzOEttNstTpJt1kI5tNXTFby+HHs5pAX50auT7cgoPTv
 l0DxiVpUQ+QM+hf77hVRvfzzdYUXEi3kmHXSb3cJtRCfE5o=
X-Google-Smtp-Source: AGHT+IEnuvCpks4R8m2CWUAxXqy7OUK3I7qmzF32T6Ls9afPXbIvlOOo7wFmoCIeuE1afURwxObJ8g==
X-Received: by 2002:a17:90b:5488:b0:2ee:7e53:bfae with SMTP id
 98e67ed59e1d1-2f7f177c6b3mr23097382a91.10.1737923666307; 
 Sun, 26 Jan 2025 12:34:26 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffaf8b27sm5519409a91.37.2025.01.26.12.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 12:34:25 -0800 (PST)
Message-ID: <2641e9da-db13-490e-9bae-64ecde1f9352@linaro.org>
Date: Sun, 26 Jan 2025 12:34:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] accel/tcg: Restrict 'icount_align_option' global to
 TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> Since commit 740b1759734 ("cpu-timers, icount: new modules")
> we don't need to expose icount_align_option to all the
> system code, we can restrict it to TCG. Since it is used as
> a boolean, declare it as 'bool' type.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h | 2 ++
>   include/system/cpus.h       | 2 --
>   accel/tcg/icount-common.c   | 2 ++
>   system/globals.c            | 1 -
>   4 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

