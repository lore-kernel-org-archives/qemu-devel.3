Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3D4CCD186
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 23:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Gdx-0002ze-Vr; Tue, 07 Oct 2025 18:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Gdv-0002zK-Dr
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 18:58:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Gdq-0000eA-Lx
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 18:58:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so55064595ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759877921; x=1760482721; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SrmeYGn0k2HFDZF25sFpfNEoTlMsX7/qy2OU40vRj3M=;
 b=NGvUw4m7CnHTCHHOgntk1Myd0CQDbWVydQdGd6H3Mcszl8G8gbNyYGy73nlFC4jdcs
 pakZO7cGRGotbOvzUlrIwtkt2oJvwKtbfc0V61Hy+NXg0u9dJiISX8bvSAHHUgienyVN
 0vvznQnYjdKBNuqv+Sl6y6hK7dsqo/bc7wbiCS8G2uMZYdQ/HRXmWFYfBvQoecoRQGCX
 lSLRl8Fnha5yxcxSLilDgGxTzYX7Upi2DRE3vP4ynbZPIGls1WUOZQUuUvJi802RtaGL
 BB+7bxtv9ymHKcKi//1SAZqibD9MZxlPGZ+aGh2euR0yoCzU+m14TJkwb3olcNQkxo0b
 ZgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759877921; x=1760482721;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SrmeYGn0k2HFDZF25sFpfNEoTlMsX7/qy2OU40vRj3M=;
 b=FQSoC4TwmY9yIUxjGeoiqFD4r2EC8ARw2KK/7bDM5xOe1CrAhmTFwRtbcNq11ZBa+v
 Vmj6+C0ZtJkGglwepB7nIzjVf9ElKi8K8N2a67jsH8TTnbFXVI1NjaOnizcdePZdKIVm
 GMWPy0BY1u0wcTkqNVzxvmyFwesO4H8AD94NRkZyAaH2hHchQxFaagUta/MDSdy1YZvd
 9n5QkcNod6HpN/i8h4yq9N8+PnWH7a/43kebRIC5/FB3TnLEb0L4aHHYu+QFkV28SZaN
 CpDctqtANjouJGfHhwhXV74XNAYyDxiYXI8/N5+VPqzfDUDWSLgBFqCCBSjTWLxEpgET
 AeLg==
X-Gm-Message-State: AOJu0Ywb68Yh9iQYkfg9tOl0HGb678i1G0GplQP10d7iFlyaJdX0F/L8
 vZgHzboCMz0gYCEHnlaYU2++n5zmUP5mIzpHYUwh2qO1WIjB1mLdFBG5jK6B1pbaayI+Vc+X48G
 1zg4J
X-Gm-Gg: ASbGncsu57+ZFci6/ApZP14t/vArs1co+5N59ZEUxPnWkcEnEicWSNctsCwvIWJrOrC
 9VKYudDe6zHfOwt3l+yPUbjCQzVBPo+/VNXonfYpfbVz+S1SzjEKSW5irEwOLF5y03/1FxxkVye
 7ciLyczWDp5Wd8OLrVuARsntT0qWwJx04hIihwQNybPyllZVl1z2yXlrHYLlxHz0ifqEQE+5WQF
 LsKTtyffif0wBqo7mvsooy0ZarpFTCUXCo0XP31XeBC3F76Fxw8Yjp3oTtBFuzHEjF4vAFEJVSk
 JFnudU80jlXHs8dcf5tuZqYrp70koNtXMbUuRQ8pIW89likBij6UIeqaOqGa8+AFBfIwgd+kvzu
 8nAnADgtP+0+nVD5Rr9CWuRFsqCso7MguEkWPklctzihmbTwkzGPE+6pRvFLmZ7aKssw36g==
X-Google-Smtp-Source: AGHT+IHZt0jmBcgw0vKUx+jxQ7+H9U6GCOihlObLISc1z+VGVSvJOSYahLbyvRxAKZNPeVpAt+nxag==
X-Received: by 2002:a17:903:1aa3:b0:269:9adf:839 with SMTP id
 d9443c01a7336-290272b3357mr15128135ad.19.1759877921323; 
 Tue, 07 Oct 2025 15:58:41 -0700 (PDT)
Received: from [192.168.1.10] ([172.56.105.179])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099adbcbesm15557748a12.4.2025.10.07.15.58.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 15:58:40 -0700 (PDT)
Message-ID: <da71e188-2742-4ec2-87e3-8ec905f45b21@linaro.org>
Date: Tue, 7 Oct 2025 15:58:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/62] target-arm queue
To: qemu-devel@nongnu.org
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/7/25 07:10, Peter Maydell wrote:
> Hi; here's the target-arm queue. This is a little bigger than
> I prefer, but the bulk of it is Luc's versal2 series.
> 
> thanks
> -- PMM
> 
> The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:
> 
>    hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251007
> 
> for you to fetch changes up to 932cac41ca633f24f192a69770bf91b55c4d27bb:
> 
>    target/arm: Enable FEAT_RME_GPC2 for -cpu max with x-rme (2025-10-07 11:26:10 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * target/arm: Don't set HCR.RW for AArch32 only CPUs
>   * new board model: amd-versal2-virt
>   * xlnx-zynqmp: model the GIC for the Cortex-R5 RPU cluster
>   * hw/arm: Remove sl_bootparam_write() and 'hw/arm/sharpsl.h' header
>   * Emulate FEAT_RME_GPC2

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

