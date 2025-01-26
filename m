Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A18C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc1On-0002WZ-H4; Sun, 26 Jan 2025 07:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1Ol-0002WD-QG
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:05:55 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc1Oj-0002x6-LZ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:05:55 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166022c5caso54455275ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737893151; x=1738497951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXI+fUyb1SarYqNh1xoKEHKVl7wDUkYCByfMkNIZbdc=;
 b=pORJFjsNxbcLIUJLS5/kU4Y9q2uouseKqkpcUrK5YUgJwg3RqjFxbfGV6hubyDbiDx
 Bg1A/U6yeasvBWvhdHyUsAYXpfygik829c3+d9bRQOaA7Bd0CMxcENLjSkyzKZneI0At
 4NEMEvUIV3zI49H/xSJubruPMU79RhlxqmW49/iE1cFa8GwUFdl6GboXYME7gjbz/SvR
 Wq+Ltq0cXcY3lPvXv0fHSPkmlXIMfbkPGEbIO+P/uS7z0iT2EqJ7jTnJfJdQao7ucq5x
 bf9M9YSzyGn8kS3AOJO8UgqFLEQ7i2LdvFkg4xia13yTZxQRV4rBLEhwfgcwIqMhUKo+
 BA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737893151; x=1738497951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXI+fUyb1SarYqNh1xoKEHKVl7wDUkYCByfMkNIZbdc=;
 b=WPb5Nbg8GiIiQPvD6YlQfknIcRMYZzbDUrL33PlPu6bhEArPzRyC6+DGP+/U1N+BPW
 QEYZ4aNQrmxkoEm5GPiGkfSgmhHsTOA1coEGFY+uLq6bY5mlvXgjIstK1YxuLduGpjyd
 n4BJoMzRyYpEwvBrZEii2zYKqQDGRt2qjPa6OXWE7MqOATSneWP/i46kdJNkfVCE2ixu
 6eOixi+sD2VSMCAO5e2vG8aoFt4WAfJPMwpu23QyjudRfjUmsoK1w9S5CYUO7stx1vtk
 DNiylC7Gi/gKGeXgREvSJM00ogZBAtt6ag8JOBjJEpazU90CUd3gGArzL568e1eGy60h
 sFaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3584pCFIfAYUmaquswlG8KK092gHYN3cI705fLIDxRuIIEcqpWFJqre6IpMsTd+wAya58Ermv5lDn@nongnu.org
X-Gm-Message-State: AOJu0YwVwzCDaYpme8WLbkpMWRN09fbCD5hyDtG+T/LIAJ2ejOSGwloM
 BnSS9G7iNdkuAqcSEVqfDHVuroboC2qwn0K0MoOYbQByYIzAwOfBAxj0NtpsxBA=
X-Gm-Gg: ASbGncubnydNG87cFPoPhHBf2y+fwel1w7sqXwFbSEvKw5L0qHxOuwRFpOIk5TwkFxX
 WdA7DFd+vOabe/BzmDMWRV9v0HkUktLYdnyOw9aw1ylWLIX2Iyco71ojGw0Bd1tJmcDYO/xoM3N
 P3AojkyqgjjiO1G1EiNRFRKVyptcef0l7Yh8kDsd2GTZdSvxrTuWdWe/fzxh5W2hWsjvg8EypQb
 TF6x93xr6ykuvkzJz6dHPT2cYzw+Z5IYKl+e/1qGRIVu5Ar9yY5Eu+qPtdaH49tj2gJZHof746A
 NxDfuyytZ/ZE/Oh4IE2kkBA=
X-Google-Smtp-Source: AGHT+IFqKr5yTtXZMFyoSn0W97cEkNJMOSVpqP0PzqugKfDuibgRP9SDGquELr4vTMfQXIQR3tTLrA==
X-Received: by 2002:a17:902:cec6:b0:216:5568:38c9 with SMTP id
 d9443c01a7336-21c35574ee8mr536779355ad.31.1737893151250; 
 Sun, 26 Jan 2025 04:05:51 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c95fsm45063465ad.14.2025.01.26.04.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:05:50 -0800 (PST)
Message-ID: <c3e345f9-5718-4459-b9a4-cb537468f981@linaro.org>
Date: Sun, 26 Jan 2025 04:05:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/24] target/riscv: Move has_work() from CPUClass to
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
References: <20250125160552.20546-1-philmd@linaro.org>
 <20250125160552.20546-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250125160552.20546-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/25/25 08:05, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Cc:qemu-riscv@nongnu.org
> ---
>   target/riscv/internals.h | 4 +++-
>   target/riscv/cpu.c       | 8 +++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

