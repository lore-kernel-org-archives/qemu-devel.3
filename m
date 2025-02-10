Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96662C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWl5-0004o6-LC; Mon, 10 Feb 2025 11:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWkl-0004kH-EW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:35:27 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thWkj-0005DH-NW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:35:23 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f40deb941so94935035ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205320; x=1739810120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d//oZGGD0NxXy60QQOwWQQcUAtiDDzPR8SdOODQM+EE=;
 b=bs2FzjMXnRrO0U88FBE5sFqwLQtdqyeLPb6Xxtyy6H2vG2HENAKJ1+nFnwO0UeIA7h
 GPFEgiv2uxH/Hd5qYxMS5p8fazu8QP0K9YNi4dp+NnCgh5TdF7BrU4sjMg5BM1MimtGf
 gz/D4ZPaKxjZZHVimreoI9KErCNKvP6qJZnLgG6iAWvttiX6hIcxcCVRYUdAnO8qiUGn
 7+CBGwxf/0qErQV7LoY0TsJ+oSuZp/Ze/tqXlAYhGipO/oZcDH9Ed/v+WT/rAjz+Sw2X
 aRT+rkvJiji4IYs5axi9okw8ERTix4bEIdw4ffVjf0E05GQ+Xz4BD0aB9AoNqbM0e137
 Ik6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205320; x=1739810120;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d//oZGGD0NxXy60QQOwWQQcUAtiDDzPR8SdOODQM+EE=;
 b=uwNp7B4c3Qhl+zUVkE9Z02bt7f62Vkddw31BHLLbUIC4DwKPavFg4ZbmJGmAbhZYtw
 IHc6bwGd4BRabirtgKM8MuhSfJyzUaSBt+EeebFRx+/3r5ZYNyOsirfKLyND0QO17uef
 /3Jd5Yg9MSsAo/7aP/qBZlSLZKElp8SepmcxF9KdI46aXmZEnquQTMfV5luc+/SzOhA/
 vTuHreN3WZbFPX3mS5UmVhi13qV3KuWQW1gQa8PwfMo/O3NiiAQuMR7Fkm94YERzZLXN
 8v9k7F6kEfL9wrVpV/2kdGp/ohfkRArgMeQY+E4+GmDiBPOUuqIUGi052s1cBwwdSve2
 XbdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0jKUjyIj28tm0tzHZ1EgHionCMVcYBsPV2/XUwTGC4KhtPOhVCWhIRvIvudmLPc8S8JPHrW0J1+iF@nongnu.org
X-Gm-Message-State: AOJu0Yw/i/B1/6Av7TLEUlGaV+TPpWCldQOICIFZiVnybWRPHV4+liGy
 D/yYD1pXRQmMa7V47UzUIjzP7XeNl0mPoW2QGl+mNyo4ziIPKdhhriQN0BApRSA=
X-Gm-Gg: ASbGncsL1CQ6m9JthtrgU0KoCKG0pXaAmK7jtVqJl9TrI9CjTwn7CLL4rfoo5MAOgIG
 KhMHubHpYJHeGp5VGi39Em5QcY1iBuiSqSWzomgtVeSCB1p1t4XN07KrSP3Fozu189J5r4AYeXi
 p8il2tBUXynd6SW4Y5lQJ3v5YdUCdnCCyrMw1vb/LhCm9XAFVSmweAtGSbrn4vpJwjkH7imdauZ
 Uy+IbfClgCaAi2e89or4XEMdziwbRq1hjERPTna4BOaeGvICxI1kJ8oTl+NDCU6eJUpfNe47ovv
 5721AAwmiGY6sFSQwT95bUHq4HKMXo9g5Cpxgxl1vnPzCTkJ4zETVdU=
X-Google-Smtp-Source: AGHT+IGu94gBoEYaSI2cbZ9fvzhnGZ0ZeG+Q2MUzEXSL2AUw58lqU58ANaPDaxUO/+NRRSZa4X1Wzg==
X-Received: by 2002:a17:903:1c4:b0:215:72aa:693f with SMTP id
 d9443c01a7336-21f4e6ce75emr204898925ad.9.1739205320217; 
 Mon, 10 Feb 2025 08:35:20 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d8ffsm80340165ad.150.2025.02.10.08.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 08:35:19 -0800 (PST)
Message-ID: <a25acd95-34ea-4d32-92aa-303c4dc64ab7@linaro.org>
Date: Mon, 10 Feb 2025 08:35:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] hw: Declare various const data as 'const'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250210133134.90879-1-philmd@linaro.org>
 <20250210133134.90879-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250210133134.90879-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/10/25 05:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/isa/vt82c686.c     | 2 +-
>   hw/rtc/m48t59-isa.c   | 2 +-
>   hw/rtc/m48t59.c       | 2 +-
>   hw/sensor/tmp421.c    | 2 +-
>   hw/usb/hcd-ehci-pci.c | 2 +-
>   hw/usb/hcd-uhci.c     | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

