Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FACC87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 23:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj4E0-0003uI-PP; Mon, 04 Aug 2025 19:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj4Dq-0003pE-1G
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:04:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uj4Dn-0002Zn-NY
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 19:04:00 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76bde897110so2828252b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754348638; x=1754953438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ZjnAvqrdXRCrUXCBSjeRfye+BzgWsI9XLVIFEwvurI=;
 b=LSbpN0qLbdEVJrLxYEejOrxdU31l5igKWeWhKrKzK33knGq2Xrlz8rjfruoOq8NzJ0
 bd5qKfTmdKP7QsM2sXDlMNo2Uk5jgGxujJLkSD7zfsyH59bzaSAksj3Fu00MTS/XSywh
 VmwvQ4RqZRDiAcsXm3UZwT/wy/E5dFzmsyNzMI7e1ojFYnV2XN2edZzhlYXv2cWYGXAh
 VbKsdSBW6D67nmvFmTP2iXT6PXfPmpA8/xg+Yy0pVR4bPW7k15OT1prqV5g+wRxP8iuG
 9bFA42PtGxqfWzMakUbD+ke9dVA7KJ3vsC3x+E+B4tI6tfDF30V3Zw+p//mtelVR88Se
 LVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754348638; x=1754953438;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZjnAvqrdXRCrUXCBSjeRfye+BzgWsI9XLVIFEwvurI=;
 b=OaAA+PLWVPnDmN80dcIyor8Bg6eNPCeUcfafPnVWA7uetsf0ii4jtqFRni/kOmbhi9
 fmOcCyFhCLbiO6WvWJ5lRAdsdUXdAwrbiRXZ6r3eNuE0q++LLj6UmhsxZMbw6p0g2MZC
 5dQCRzsjldrNoQjFUWbRDbYq51tvFweaGr4EGS75WCFI0q3kC1GaEmrWGbHmCP3EZ69k
 EI/qBAR+iQ1Uth9/aqY0d0x7ovBsWDj2t2FB6etQT6XdsGK6VHQu7B5UilBTARH/eZcm
 ell07mHJ+wA0zxnU4UOGm3eC2K+ZWHNawcep+/4mjPeqT8Ol4KDApLzAUWUXBKeWaoCe
 RJkg==
X-Gm-Message-State: AOJu0Ywafavs2gy+lNQNLii0ZokdeELuEw/UE04iq+JxkZhFBprvZBe2
 xBROZRDESK2kprJSW/yRag6axJMaZW7mJAab29JMvBoAFEA7srYy8JQP7P7OzYEcL2wRM+6IOJt
 I3KAS
X-Gm-Gg: ASbGnctmu+LnUcSnDe5c5mgzs2l8+W6TKvtbzSHorasXt6Wt9gS0JRNeeuWb8aclori
 uRHhJpXtXm3onBDmk2oWAAetj0b2c6sVLXGHifqUJLLmuZGWAPy9l4Kljkr3c+zboawNkTKGshC
 5Xa/3wBIZpZI49OZAlM6APxb4MVyPmh0WTDvG4hd4f6gl9ayFnzy8Ruga22A7hQKLfAIEyuLDdt
 6+xdl75wjXlRCgXXHuwbg25qxopT7//5WVVifTk97DsuYgLGCeHOiQdBwhXEweF492+ZENTaM46
 2L9YdLOovCCho1b2FY8HsuYre8KIZt21PoUSQ7dufJuYDMWOICnS7IR5uivA7pbQngeO3R8lD78
 zEdg/i2TC6mr+0plLxmEikQY7hJFXMLpuQcqU9B/MqctnG3avzUQ=
X-Google-Smtp-Source: AGHT+IFl0Jg/EZPWkUVe7CW4Xx3WcHxdc0Yir0jjE22TtGHtV310lAqqKUoUqtKYRvGsPtzCEKkFFg==
X-Received: by 2002:a17:902:d4c7:b0:240:99da:f0b1 with SMTP id
 d9443c01a7336-242470143bemr148886995ad.36.1754348638057; 
 Mon, 04 Aug 2025 16:03:58 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8ac8de2sm117308695ad.185.2025.08.04.16.03.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 16:03:57 -0700 (PDT)
Message-ID: <0a546b9c-7c87-4502-a0ca-ba79eb988093@linaro.org>
Date: Tue, 5 Aug 2025 09:03:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/11] hw/sd: Fix SD cards in SPI mode
To: qemu-devel@nongnu.org
References: <20250804133406.17456-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 8/4/25 23:33, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (11):
>    hw/sd/sdcard: Do not ignore errors in sd_cmd_to_sendingdata()
>    hw/sd/sdcard: Factor sd_response_size() out
>    hw/sd/sdbus: Provide buffer size to sdbus_do_command()
>    hw/sd/sdcard: Fill SPI response bits in card code
>    hw/sd/sdcard: Implement SPI R2 return value
>    hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode
>    hw/sd/sdcard: Allow using SWITCH_FUNCTION in more SPI states
>    hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
>    hw/sd/sdcard: Disable checking STBY mode in SPI SEND_CSD/CID
>    hw/sd/sdcard: RemoveSDState::mode field
>    tests/functional: Test SD cards in SPI mode (using sifive_u machine)

I've reached the limit of what I can review simply by looking at the code, rather than 
absorb the specs.  The rest looks plausible, and doesn't twig the Spidey sense that 
something icky is going on, so

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

