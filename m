Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C731E6F08F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 13:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY2o0-0000YC-TF; Tue, 23 Dec 2025 08:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY2nk-0000Vj-2C
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 08:51:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vY2nh-0001m8-5h
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 08:51:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so34490935e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 05:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766497901; x=1767102701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9aR5fsa+2QDqvPC7nBmPO53Q/gDvG2V1Tw1fx489jjY=;
 b=KGg6MxBpRRy1GDCBrpJAylEEWADhSWdTai33qZoDdq3ryazCzPSWgjU7VEdespILR2
 2bFunDAIYytq3sw/SuH7vH6UFQiRMVtXhfUvpMLIbIom4Gehjn2QnnVMfHD3xPWwRV/x
 lFtjZ++li6hxe+9MvywB50qKpZQbftwmZ80qlstR5dp3hOYKx8ADEFIWKg+P8Kv0+wsq
 bJaTB1+Wht9+OEH8j6NfCm6nPZ0FSpfoP3r8/r83gcIX16jFRgZO4C57POV/hpYYLeVV
 odhz8/du2HW3FPFp6FO8KHz/Lklbx/lNR+00hv0zKR0RD9EnfEfrtFfery/vrZWf0fvS
 koiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766497901; x=1767102701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aR5fsa+2QDqvPC7nBmPO53Q/gDvG2V1Tw1fx489jjY=;
 b=RYZh/GFl+lE1sujPheEGIw3UKBTuOAf9m5Rs63EafMXbVdn7a4av2IUc2/NMINCyrf
 kqDVbRkQGuuR8Eip7hoo9a91pYpsy4MLEjDA/cYrA5hSfrkB6DhmW5xCBxDpxMknT38A
 MStzf/TZgdXUVWOGABd5yrN9RdorMHGuKzQihiQb/QO8qW4SdgkdOkXSOKQ4nukcI/UC
 h6p7xqFGXLd0RxuGhIrSS7+jEiaXkinYPpDUk+zwB9mbZrFLODJ0jyEWcgcWg+ufuAUC
 mclD4OwSwqom+xrBJ8V2Xzb/USeNwA0UPtBQQLdwgrzFAlDFh+bddLL5aQfV3xp0cSTf
 tO5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEsam7bDldjHPO1A0MiYokNCYNEm09dVM42ZPRfedNMtYvPgPzD6glgYn2onndseY0nf3l3/nufCBh@nongnu.org
X-Gm-Message-State: AOJu0Yz5NI+/10AiA1A1/tKjWf0jAY9yJ+Q3oXlhGbsLlDLhh1abjY/Y
 1unYs3zSzzrs/Wj7yVuCOwSF2ma6TCPZ0Z7D/8iwNf0zDNzf3k9YI3J8eDHVwIH+CP0=
X-Gm-Gg: AY/fxX72Hi4zdzmAvpNzqdu+GY4B1teFFf9oB6vGPAC4IBaFQvdBJSTWZSJI+B+g9mS
 XAlyetIsbSJqko3pd8s8xsGJ2jkGjTsmJsCc9RxK7mrVQV4La9r6+YZijJYhXybHxgPacoZBGlq
 wL0noW2wdTtp0p8dsNDa/g6IxaOc/F6qi6VfMofE3pbyn70biPMmo/mYM4kDaY8zyvRw+7TFDAM
 KC3fDin8kbl7COYM8xVNynJFqp8F+aQ6dHz2lyL9KmtUtzAzdRA87ecLucLFoquGs4qytPWBzoo
 +f7NCSX/9qSMR70ymM+Yiq3KGMzmvHy1kttH7pq2NRQFkcoKzQNlhbCHHUEGZy0CStmLFGv3Ols
 wmIYwu4ux8fWNPKe+0hl3Wem2NlbAseD6/WmpeGrv7zewwaMQjqpA0b6MjYGWbbOQUdlKslKS3/
 WE2P4zE7OJoPlPYG2U3WdeepVzz7BIbfokq1dUTur8vte2ow0dejNSBw==
X-Google-Smtp-Source: AGHT+IHFd6/jZl7bW6qVW8Kb12BtVeyp3hzPb8CTPSmKkxSFLAY/tB/OyTR4K7+OWS6MFYxglslWow==
X-Received: by 2002:a05:600c:35d1:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-47d1954a165mr173156555e9.15.1766497901096; 
 Tue, 23 Dec 2025 05:51:41 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a9687dsm123700745e9.3.2025.12.23.05.51.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Dec 2025 05:51:40 -0800 (PST)
Message-ID: <0d6a818e-1007-4e98-8504-b5e88a30b51f@linaro.org>
Date: Tue, 23 Dec 2025 14:51:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core: remove duplicate include
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com
References: <20251126210832.34011-1-osama.abdelkader@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126210832.34011-1-osama.abdelkader@gmail.com>
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

On 26/11/25 22:08, Osama Abdelkader wrote:
> qemu/target-info.h is included twice.
> ---
>   system/vl.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


And queued, thanks!

