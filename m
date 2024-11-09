Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F6DD5E37F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 21:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9sjd-0000h9-V9; Sat, 09 Nov 2024 16:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t9sjb-0000gz-Uw
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 16:11:08 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t9sjZ-0006l8-6q
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 16:11:07 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso2643100b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 13:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731186663; x=1731791463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rr3BFlN7W/ERosawJ8RtAD+AaSPmYSJaXcOZZ4nR7GI=;
 b=AzzCCi1GHeMqmqNPRXOfWkdRi8Hp4v8uZtU3VHJVLyACpT2tYbW73CmUV9OEiBPjQW
 4JiEeWh1DB2lWjhz58wHCXeye7inGx5HHQXq62E8EU/iVrrgqpdvsoIdJMSxuIzQIAlq
 DN3qJC8Edi28LBtMXotzoGOEvr3TD77Yj41B0R6BppWQpjCTE9hgk/Pz9AgPUlKR9fUC
 JZMtohiqg/7Q0pwIBG2zh8Dp1w7VlhMjWzVnRk102/KFnvLWlLFogN/n8iczRxouKg2l
 Yrv1c10HRXhbv5LzfGBBRv/AX/O5ezC/RpS8fB4xJas7Hnol6WU532NIq2eU7llSUcVp
 YBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731186663; x=1731791463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rr3BFlN7W/ERosawJ8RtAD+AaSPmYSJaXcOZZ4nR7GI=;
 b=XsbXeMLobI+lC2UfWjbuk/eWo+LNU9gItnftIlNRJjad/e7ANi03Bfgnh49mN6TNVF
 TSQm4EdMuGk3tmd+GGoOqBE89alI59iU6sLmJ8h8rZ8aYUI/94vdmeIkCDzVNNoHdRgV
 ZaBYzpiR65lMW37gtzHdaOywMKiY/lcxuIz2KcXNAohvUVunV3e+jgJhI/PS36YYS5il
 h8xfUPdZX4KpsdUlOjU4xI7zKcF1cLMmJ5bRMWe8lOfxqnbpCDOvLO8Zb45sRNnyXaO1
 VXghRPTXt1y8cj5RNIpNsU/Gftf0PpbrV9gHtMfec2u9XwUu9D79h0wLCl+HjAn/uQFx
 vuCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuflhxChZC8RT5jnSTfcWIHI9mfui3U/TZWIqYmAUzlRzRR3svzs+TXfrCeYLDl953LV67Kmpo0c5c@nongnu.org
X-Gm-Message-State: AOJu0YynSZCvJ1OjyX49YaMPngDwH55NwZv8yoIh/yvQkT5Zgkgf1WUD
 N/zDZo4j0vFNhB6VyEBweLrxug7+HUpfkCaO1h/zAOYVxP/d2p14OrU9YKX0UqA=
X-Google-Smtp-Source: AGHT+IFMjmvrx5LUyLgCTj37Nb52eJ/regxV8VTvMRh+6b/1G2jKahQ8S+bip2AJUgTbXrNl93YwfA==
X-Received: by 2002:a05:6a00:3a14:b0:71e:6a57:7290 with SMTP id
 d2e1a72fcca58-72413133f3bmr11248387b3a.0.1731186662786; 
 Sat, 09 Nov 2024 13:11:02 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f5b48c6sm5606163a12.18.2024.11.09.13.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 13:11:02 -0800 (PST)
Message-ID: <242ffcba-8e13-4705-ba3c-66635b298471@linaro.org>
Date: Sat, 9 Nov 2024 13:11:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] trace: Minor cleanups to trace header includes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20241108162909.4080314-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241108162909.4080314-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 11/8/24 08:29, Peter Maydell wrote:
> Peter Maydell (3):
>    system/dma-helpers.c: Move trace events to system/trace-events
>    target/arm/hvf: Add trace.h header
>    trace: Don't include trace-root.h in control.c or control-target.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

