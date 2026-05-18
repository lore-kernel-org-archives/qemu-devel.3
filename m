Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95471CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzrl-0006Nl-MH; Mon, 18 May 2026 11:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzrk-0006NY-Lk
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:26:48 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzrj-0001Fh-9v
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:26:48 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c7ffe8eeaf2so970624a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779118005; x=1779722805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Y6gIWJNXvqS+Hb6BqNS77GroByKlTVbeZunAyJ/+Ew=;
 b=wN1i/TwHY18sNYzHTEhAdsWassPu5rVi9GdNvIFdzUYnqjZdLMv+YpWcVKcAJvKNdX
 mcCIz/6KJjM1x/Q47CwSL2JreR31+HFtEqjrMgBl7DG9JOzZfNloaz+XiBKhg3ADW/85
 UaU9JY/9ECeHcv7iEoYJZCxc3dAbSkMYkUMqcuULjcLzVTWUziaAneP/DRYUYhPCsEDz
 l0PCRFrUbQuyQQ+WWsjA2q2BfPPdQ0tN7inuqOXBw2hZLxNnt8EWG3uId67bLbBX+08a
 ko2cr/HV9yShmrMsjZ13Sr1SH/YCHtdarxjgM1yHQvfcbPgk1vYR3zXBk1SD7Jd0J8rS
 NWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779118005; x=1779722805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Y6gIWJNXvqS+Hb6BqNS77GroByKlTVbeZunAyJ/+Ew=;
 b=Nq8naenle48bpIBI+bi0824wLr0nV3GLY//9qR4kHVDDw8mMp64olXoxh5So/28fHl
 03+B2UYDGSnTWeLZlEHE2HNEAVTATgNrizhW0rOYuxAHMRw8HUIPetvK0ZF7mkzvy3u+
 Yt93crWfn3mvYivRla+RlHMEobbUYYsphB5JuaOZRWEyUkJmrmmA1qYl1aaHqokBcF3w
 NiYi2i7LE6iV+jQcP4X2t+g9BZS703MmfJadS125VvygR6uiKhPA9K5UXOF4kjCxf6f2
 tP8nau9me4pXF2/hW5JNI9FC0EOYjF53OHdvMBKnzEziWy/LDikI6cAq5WLzVzr4+S8P
 bBcA==
X-Gm-Message-State: AOJu0YzLW2Fq/9sn+JbUsDlNsdhruvI7qW9jM19aMlHG2a0eODREhiu5
 T8X8KN8zFOmJRj1XMsZiv/9RHhslei/tD9wDs0S/jEP8/RqTw8z/buB2/IzL2l17mw6kFC9y6pS
 iCZGMeOQ=
X-Gm-Gg: Acq92OEXL1Ngw5s4RnEZ7vW7aKIaALWRwgy7A8hXERYWYTUG4nMDPmcD8IYOQIR+q1w
 WEyVparLFjG2toB/gxqglzma/Om1YLKq4bQCEsEW2b9FOv40+OtEmuaYsHrYSalMYIrxGgTRVg0
 K1NR4j0eoyLPCv8nDsgeGzMOToGeBDknk9+r6dCTvI9LLrTengBCmTNDVgxPR4hqtmpMI4mtQ31
 VleY3q1j6VobDClk47DcZ7c5VP+pQTlWNdiViAOPjvl+fKqPQoXd+HVfBOQACXCEXK9iSeZydoz
 Ja/QJ+jicqLcnKv8TjtNKIzr0lEUBsjcH3Q3XHzzoTGwy03SyNhIR/EvCa9DQLk6Wzfh6OKnfJh
 XzeyC90eepc8P7QpmsNcZfE4YtEektl99WOXFiGGHPXff2CPIHnbfHLD++W4UundaA8acimCTp/
 vjFWJIcVNQ6YhV06YSC+sVnCwjBaUcXb/qNlm4ZRxqLHyvMPM=
X-Received: by 2002:a05:6a20:4308:b0:39b:f25a:28d7 with SMTP id
 adf61e73a8af0-3b22e6672e0mr17229624637.3.1779118005449; 
 Mon, 18 May 2026 08:26:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb06875bsm13604745a12.3.2026.05.18.08.26.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:26:44 -0700 (PDT)
Message-ID: <8313fd6a-9bb7-4743-a3d3-4a5b6c21c447@linaro.org>
Date: Mon, 18 May 2026 08:26:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/14] target/arm/ptw: Flip sense of
 get_phys_addr_pmsav7 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

