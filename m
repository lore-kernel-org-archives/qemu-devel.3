Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C238CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIVl-0004JU-6w; Tue, 21 Oct 2025 15:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIVj-0004J2-5I
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:59:11 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBIVh-0008PI-C2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:59:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso14025005e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761076747; x=1761681547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Tx+EoVhcEqE1CTtCgl+Yox25O5k+KD6JTQOFcz3j3Y=;
 b=SBWn+yeDLIgo54TBhjyNyhSj0YvplyZ6k7XlbSpfkAUx6RPJFyRm7l6OHYwGi/j+FL
 2ewC3oujzl/9sMJfUBcVkRqYVS8fxQjzgp1X8dsvqtx+d/XORyFg2yFgv5GKM8oe3GRT
 RS6SiSbICC3sU6liVK1SZEMFGoecAn+2+pVQ2nvHLiW8L9jXCV8cEz6HHziDvIyQRDWj
 yUlBbEUApfrSnrl6TY+HaGk4Oovtq2fRiTvrq7vpcjOlhCpdEXQRz6kxxoSYwrGvOHnU
 eI3DZBPv75zvgGKnr5WWh+zXvZxftQprujkw5hoN74OGjHfsI2VVQFBSi8JMheknc6yY
 WfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761076747; x=1761681547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Tx+EoVhcEqE1CTtCgl+Yox25O5k+KD6JTQOFcz3j3Y=;
 b=wPjdUQIC4bk4wNDDSVs7AeO/z6ihfZSMwg2UY5OcY3Ms/gAk/0Wp38sDavMEJr+DS/
 WZOVxekrmYq7iJUyAFlL6WXvrZCBmY0fLybx6jRC5kJ9x/mt1MvXsWJEDfMB8FBOEgDE
 yh0E7wcBt7ZysamqUSRbXFiEkRiRsx3aRVX/zJN50nVZIO88NHs6x5/R8WIlGRQM2y+0
 Gyw3XEw2CjPhysp5s5KIEb5Su4XceqztvvbBTNOrQbXFbjpFBNrWbHtwf1cevzxVODSH
 0KNGNkFJTi1snzg0K1Mv9BsG9MIlHNnWEakcjms3N9G+0K3pD7Sg6qnerqJDtS2vn7/h
 YhdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5y4trUx9lnDKl0YlnH78g95RKV5t7EXyci/ejUdpzum5MOKCF9jZi/f5detPBpSGPbChEMgDwIN+e@nongnu.org
X-Gm-Message-State: AOJu0YyQy5gq4781l0CU1+YpqjOGy7GEzRjg/Xadw7APtXIp7JGIeaMJ
 /VwTwNdCN16MindI+Vz3TJzrcFh2Zq/tgjtU9jjNbgsEJv8ustcnjU8bvRGxLM+9ymQ=
X-Gm-Gg: ASbGncuMPhy1F70KtB+Ru48npSSEYccYxQj+K9tR24d/Bj2zHy1lIN4T3iEMUT8mhXz
 PMJC/SOS4eI+KL4y7vDkR0NZZL+1cmg6umTgHza+XYLs59jGEu+15Iq3Wo4ZVIlU4ckRqrM5zui
 qUR6wIVFgBcU2/g9CVvwcznbnt22re+geQb7k5NV1rnM/03MEAq/U1G0MsVTTedg9SidHbwFuuQ
 6EHv7x+M6qkMP0l6ic3MLcXcL3TRLzmv+a6GRJzY9GC6rQmuD0kIBQCgv0/qC8P75/amIMEDls3
 jWjnotNqjKfxB8nQB0EXceYoILopM0fk0czpiBxA+p1bvl8o1XaoCICn5vzI0ZRzmBaPPsv2umU
 50SJHEaflvDwCPlMFcUe/6Y5TfAL6CEAcgyh/KYAVMAQGhXg6tzvDWd4xw4uaTeI59kHhH5EXwQ
 RxqtVY5raYsTnSnmhhnxdbC5h5q97z6dQiGg/aB6yaqkI=
X-Google-Smtp-Source: AGHT+IE08KTszMASyduyPuJ/g9V5i89UznVhg3v+3+j96Hp44H5rJplCl1YXiPaicbIdPdf5QulBWQ==
X-Received: by 2002:a05:600c:548c:b0:46f:b42e:e39f with SMTP id
 5b1f17b1804b1-4711791d96cmr127215765e9.40.1761076747350; 
 Tue, 21 Oct 2025 12:59:07 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c43f68sm22821525e9.5.2025.10.21.12.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:59:06 -0700 (PDT)
Message-ID: <c14d255e-dc6a-4662-90db-0adfbb07c9a6@linaro.org>
Date: Tue, 21 Oct 2025 21:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/25] target/mips: call plugin trap callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <cover.1760884672.git.neither@nut.email>
 <90f894e51477495903fc0594e6957c6b2b5c8bc4.1760884672.git.neither@nut.email>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <90f894e51477495903fc0594e6957c6b2b5c8bc4.1760884672.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/10/25 17:15, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for MIPS targets. We consider the exceptions
> NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
> exceptions.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/mips/tcg/system/tlb_helper.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


