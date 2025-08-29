Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D74FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNj8-0005oC-4A; Sat, 30 Aug 2025 11:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7Jb-000772-0w
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:11:23 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7JW-00083W-Mw
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:11:22 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b4dc35711d9so546970a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756505476; x=1757110276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p6dVFub8rfkbljYLWR1PaKydXBgAgpJmLsYGBvx29pU=;
 b=WEqQOvLmyARNMJaUMGqfgGGeLqAljOPZ2aqQINVIxQVySwXAwUvg+y+XWOn+AHSqvy
 Y7A/NB1r91I1JU/iNxdtRPczdA02ntvcMesKjxb8TataMILFgMdo4P+Li+A0uS1T/mr7
 McXtLKb1RrU+hQ0nxHns6p16lsveuZiy5i1lYTeeyZov2CqtzXdzEpCQAguS6yfiQSGK
 m1exrt6A+2ERQwcNQgMUeBNXb2waYkTCmUn+jLmvqBdTHqe7KdDDqkc43SbgfWpuaw0l
 6+WNv7qd/gr/adBwaMues47YyxavSPHss/y5PiJyfJhnMp+Dg0x3fh5CfaaNIpS7qMl1
 ZbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756505476; x=1757110276;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p6dVFub8rfkbljYLWR1PaKydXBgAgpJmLsYGBvx29pU=;
 b=LcaIyx57MFAhBrfE/r8ixl/O3ScepAC9INcqa5giQzPEymZd7/xlMtbRTN1dOxhLUk
 wfPMtUg8rWamblwaI3dbi0PdgElRZ7aVc34pWMJdIDLo8KO5Jhy+5pqlin6zIHX/aP/D
 Y8T8mMZ4vjlLlWOukKieQ0yCTU4HQFCnsOe7RvKpqxldizxOcxjLUMwJ4iGyqIIBWuax
 PrBohwaCPKIpMqbNfvfB3PNFJk12JgN5hNoEdDuCmKz5R+Tk/suhZY2LmdW5HmXG93Wv
 M6qL9B6yT24O9TdHhQ7A4OatWvZ2lT4TyR8RGvpT0C6qb+cjq5EnpFFvGOu51zKNTX7B
 RgRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkPGeKEVm7uMVkoGeNn5XmmdFCBGG1UTFz5eHpICMR8EjDFSk6UcFsK0+Y7RBp6Kt1/GkqCphcsgqx@nongnu.org
X-Gm-Message-State: AOJu0Yy7sYEo/lZBuTHCKYOWF9LpZLXKcA4y5EbjpoYesORen0qTmlJk
 PBVdHnttp3Dcy/zLfETEvIUXcsOcKSJ3WIOKOcviLFqAHeI+MAsW9Ce7hSrye2/QI00=
X-Gm-Gg: ASbGncuW9E+SSPyO9myEy8aAsqGWUddmAj7KlspwCnFTVAIYXd0E8U+jlDWdKIxqcmR
 0GmrHGNDPZlsq2cBNHx7+8my0NGsJkG5WK4xGoSdib4PiWH4Iw8FJDXajfCslDxRH0gihgAH7nu
 Xk/511/Nwao4VSLpIPwtBFVaolaLnW9zbEmo4bkfusxHAQQ2Y3xm2nMyvQsljm3eQxIZexCOq71
 spANTC6DeuILDVG1iAtBVYbjQUwyuWYP3wpqZTzVSuVeGkMclGaG+2ps6aSZgHSkDRP7SZv2K4N
 TAQxVJtLOq8UIRf/QUftIG4SkIiozjHe81eeL9OU9fa+8GzHIXw/8S2aXgybApnk7SXLW9RKn3E
 jEqECDChjnWThla8jQHwx8jSXK/qi2JU/4BT31TiaoYWuE5cOLt6wTt7DRAkwv62Y7lS39SE1Or
 sLZPfU
X-Google-Smtp-Source: AGHT+IFl4+lGRoxnOIQax/suYjIRf+kNKrxg03b+4a+EWxcsk+9353g1FBlcrNxjOeuvMNfv/CUjCQ==
X-Received: by 2002:a17:903:98f:b0:248:79d4:93b3 with SMTP id
 d9443c01a7336-24944b29e4dmr1938005ad.59.1756505475729; 
 Fri, 29 Aug 2025 15:11:15 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065ab343sm34715735ad.126.2025.08.29.15.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 15:11:15 -0700 (PDT)
Message-ID: <da327e5f-69a1-4480-bb7b-14bd78ec69c7@linaro.org>
Date: Sat, 30 Aug 2025 08:11:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] cpus: clear exit_request in qemu_wait_io_event
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-12-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Make the code common to all accelerators: after seeing cpu->exit_request
> set to true, accelerator code needs to reach qemu_wait_io_event_common().
> 
> So for the common cases where they use qemu_wait_io_event(), go ahead and
> clear it in there.  Note that the cheap qatomic_set() is enough because
> at this point the thread has taken the BQL; qatomic_set_mb() is not needed.
> In particular, this is the ordering of the communication between
> I/O and vCPU threads is always the same.
> 
> In the I/O thread:
> 
> (a) store other memory locations that will be checked if cpu->exit_request
>      or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
>      for cpu->exit_request)
> 
> (b) cpu_exit(): store-release cpu->exit_request, or
> (b) cpu_interrupt(): store-release cpu->interrupt_request

Mm.  This is the reason we want the seq_cst of the qatomic_or.
Perhaps comments in patch 7 should be expanded to document this?

Anyway for this patch,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

