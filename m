Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B19C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaXB-0003HZ-B9; Mon, 10 Feb 2025 15:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaWs-0003Ba-U8
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:37:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaWq-0002mQ-E9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:37:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso7010805e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739219834; x=1739824634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RC7sHgzHavW3ol4mYW8u376+AF+In7fWDQ+2UaL7XNw=;
 b=eSoVgPOO1mnK0I5zsLVBAnGMClciaI+TvR16m7kiF6KUV3q+C4LqhC/7LbivQkA/zO
 JdTBKO+OIaYcBuXEPqizVqWnDZdgzs37gEp7NFn8BvH/e3fznPr6Tble+FsmN0bfo55C
 3D5cS91ZzZN1enfPM9f8lue6o+V9u/3zjS9B2WizGMZe3VeaxtSR22vMdyxDxvBkue6Z
 vDN4goxflGV7ApfiLoFMD4Of8NYgyXNKZQCyuaTThC69gnHWcNYvmyFt4NtuKN+/k04N
 JHQuGnIU79vgaNRNOBcvHiXhcrMvEB/sv7uGBSHmMHLDf60YGdQr4yJ1kGsXZNGeufb4
 F2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219834; x=1739824634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RC7sHgzHavW3ol4mYW8u376+AF+In7fWDQ+2UaL7XNw=;
 b=NDRoi3G1GeveD7y/0+1re89EBgLXkfE0XishRRNSGTjEWgDWZjuGysaiOxCSpZvbD5
 bXhzXw0MPseU4/lPPIOKrnc2cgeI0HmxVzFU6SqyBjcWgGTsQ2VALgRrSXsTWckLMZCN
 XwhrrNBvggolO5rqVfv/JMnXMWMCjVb6iKQA0GZ0jnFk2/5ycs/tFOLeS5Qnez4vHP1b
 Que1+pT+jpltyfuEyJhKlvuk6Y+SWj/KtIeFE2nRJtJytcELxjf5m+EP7dhY0/rUVgwx
 B2optDfvj/GbDH4eAdioc7/xfrnQrDCzOnBd22qS/Z3Vk33Q2mBdmuSYXXygNOqn+HFe
 bpjA==
X-Gm-Message-State: AOJu0YzHl5QlLNtwMJ7I+IVN4QgBN24/CkLuSh7jQYZopNWI5eEmVdm5
 eTD/O6OQ2MwyKSZOSnT3FozM+6iBsydl/E3uOHBsuxYAsU57IHK/cqzHkZn6fhuc86SewwoDKIC
 /ZmU=
X-Gm-Gg: ASbGncsU2gMWclGPDxo4KunMGoOGu+v7PnQ/+WSr7g7otDpGAL4DpHswLs04hO52rQe
 NoKlwDoou/kbL9oCiJn2frq976VDWBz9dgC0xg4BDGanAdtNfjAfSZ2PocuKX1muPrbxsGxJEka
 GREfvIcfggoCz/x6I3ONzbb3gQ4Qhm1iouF9OG0+aRwce6Yi6CF8XL8BEXSJVmZ9zRj1e6SA57Q
 vfcuDpzOKxNm+kOmx+IYq+QewalxtwNHsemBdvx9YDuqxi1cjS7goLS+q6+SN7E2D0kD+PB/Ehz
 U8O7a87FYd+ng2+E9/wsPSu/5h8HKucLLnvy8Jzqd2Ol+4+AhzXFQw1Wv68=
X-Google-Smtp-Source: AGHT+IEMmaejRpJee6sHI97Mdi02sZfrrigF/m7Y1KeAMkInsoOipuqOaQr53gHPFy/JQeXkTYWTMw==
X-Received: by 2002:a5d:6d8a:0:b0:38d:dfdc:52a2 with SMTP id
 ffacd0b85a97d-38ddfdc546amr4461506f8f.40.1739219833782; 
 Mon, 10 Feb 2025 12:37:13 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d685sm189934845e9.13.2025.02.10.12.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 12:37:13 -0800 (PST)
Message-ID: <76bcf481-2175-47a0-ab28-f67695e27ee8@linaro.org>
Date: Mon, 10 Feb 2025 21:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/boards: Try to make sense of
 MachineClass::no_sdcard flag
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250204200934.65279-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204200934.65279-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 4/2/25 21:09, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (7):
>    hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
>    hw/boards: Explicit no_sdcard=false as ON_OFF_AUTO_OFF
>    hw/boards: Rename no_sdcard -> auto_create_sdcard
>    hw/boards: Remove all invalid uses of auto_create_sdcard=true
>    hw/arm: Remove all invalid uses of auto_create_sdcard=true
>    hw/riscv: Remove all invalid uses of auto_create_sdcard=true
>    hw/boards: Ensure machine setting auto_create_sdcard expose a SD Bus

Series queued including Markus' description update from v2, thanks!

