Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75114D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzOJ-0001Wj-7j; Mon, 18 Nov 2024 05:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCzOG-0001Vt-Ry
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:53:56 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCzOF-0004B0-84
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:53:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so33209585e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731927233; x=1732532033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ocx/TqUHiEzN1U7B1X4Kr/ZMMCZrseWcPqKqcBy+IBs=;
 b=IMtvMjnJDNo37eLvQxCjXWRWiuJkPi89Ct6ujJCGx7nm0gbeQUjAcy2jC6idu1tqAk
 W2S9TVSwv8HjInD7y/Hb4qv+hRvbWraZ/1zt1awlpLVdoHxYQvQ6LPeFbDL9ZvckMpu9
 VQr7BcH40joPHTNYrUrGYlDnYuJ2dGpXlYc1cqKsokGu+A5O2rM7lNYWMRymDDHQehr6
 fHX7aSwMg8dS1pcReA9ug7uBbK0Qle47P906pNqIM4ffny5WFd34Kae9UFN0UeZV364Y
 /klE7XNz1/B9saC7u7h0c+K7n1nQrwkA1H1tNZgaEFZ3S/Cq2XIBE8qhR/0dsK0LlOTc
 2GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731927233; x=1732532033;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocx/TqUHiEzN1U7B1X4Kr/ZMMCZrseWcPqKqcBy+IBs=;
 b=YlG5ZOck60miBTmY/dvrymYQEmArxJCHadlAvH+I7ujerkNoYMY30VsKDxA9wW6WQb
 SAs9qMFWP2eOFA8S3nt7W85WuPT3WdoHoKAWHj/4K989u79yv1Lz0VfEXL4R9YrAvWvi
 MqlmiXCF+H9YxBsy1lFhMk8gDeGvI254S/vFg6xSRKJ3E5JtbUL+he0mfPl+Isp88Z54
 HDPTOHzUPyfvdgZbJLfHo9pbkzlEOIzyI6+ee3tAg7aJEYza3M6FrVf5buFu8uDiYvO6
 EXAw+meR/iOBwVb3/WGouIk8gFr7ibYz5SNo16eRa6ytMrMhbitQZjCBlcDwZloR2Tdc
 FyLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQV8Z46jJIS+8Iftfpmyo3cvc/ubx8OFXqxqSqHtC4dgwhRn/N683rZG1aPLxlXgA6+/Bqxe0/usYp@nongnu.org
X-Gm-Message-State: AOJu0Yz1prWfA1BkAGmLlhW7Z/3PXeheLYF17FzB9N+8l/j+iPi5jHiI
 +tYgEr0+oDch5qSN6A/6DzXBcGVnXtxGCItlYrKeTECAVHhD3Og5QXFMgQjNpLsKKRHWWi9/MxN
 K
X-Google-Smtp-Source: AGHT+IEh0WlLuMitf2xx0e/vGG7iMbzu1BCgPQCK4lhS+cqFQYYUQqns4FEI0INZ3I7H6p7j7q/8YQ==
X-Received: by 2002:a05:6000:79d:b0:37c:ddab:a626 with SMTP id
 ffacd0b85a97d-382258f7197mr9145621f8f.7.1731927233381; 
 Mon, 18 Nov 2024 02:53:53 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38249ed88d8sm1543741f8f.48.2024.11.18.02.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:53:52 -0800 (PST)
Message-ID: <84975169-3c87-42c8-96e3-7ae724cc4692@linaro.org>
Date: Mon, 18 Nov 2024 11:53:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: avr5 not found in qemu-avr 9.1.1 on macOS
To: Iris Artin <iris@artins.org>, Gavin Shan <gshan@redhat.com>
References: <401F6B10-2316-42B4-BFAA-863E9B2B8F87@artins.org>
Content-Language: en-US
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <401F6B10-2316-42B4-BFAA-863E9B2B8F87@artins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Iris,

Thanks for this bug report.

On 17/11/24 02:51, Iris Artin wrote:
> $ brew install qemu
> Warning: qemu 9.1.1 is already installed and up-to-date.
> $ qemu-system-avr -version
> QEMU emulator version 9.1.1
> Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
> $ qemu-system-avr -machine 2009 -cpu help
> Available CPUs:
>    avr5
>    avr51
>    avr6
> $ qemu-system-avr -machine 2009 -cpu avr5
> qemu-system-avr: unable to find CPU model 'avr5'
> 
> What am I missing? Thanks!

Gavin, this seems related to your commit:

commit 7db8f7e895bff8b2eac08dfbc977d22a5a9fff36
Author: Gavin Shan <gshan@redhat.com>
Date:   Wed Nov 15 09:56:06 2023 +1000

     target/avr: Use generic cpu_list()

     Before it's applied:

     [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
     avr5-avr-cpu
     avr51-avr-cpu
     avr6-avr-cpu

     After it's applied:

     [gshan@gshan q]$ ./build/qemu-system-avr -cpu ?
     Available CPUs:
       avr5
       avr51
       avr6

FYI this works:

$ qemu-system-avr -M 2009 -cpu avr5-avr-cpu
-> OK

Could you have a look?

Thanks,

Phil.

