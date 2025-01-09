Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC447E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 00:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVgbw-00006F-7P; Wed, 08 Jan 2025 19:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVgbk-00005y-AO
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 19:41:10 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tVgbg-0003Kr-6B
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 19:41:07 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2166360285dso5228055ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 16:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736383262; x=1736988062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D3FUErQ3sfEJtBKE402t+C2cN34fQzSNGHkufLpYS7w=;
 b=gtghRTEoujxdJ2pb0PX6PPSV54Kgj2Blauu7btgCZ5AXqp1Lmz1DdXWfSs70WYr5zM
 vlZ5/W5pQDT+gJ4BARaQq3AW6R6pYCWKTirGgdRmZxs9W9W4zkrW1WIuYK5N7mtvltF6
 3TJh1UtnBkPEGCZu8XgtavtqS4u7MsnfDFpnJIrZpvh2WoD5KSBZFkwKd6GJQ8Q90neP
 YEe7j2iT65YOglAtZoAtGetFH7BH6doeKSPklOw/Q2p4iNpx8d95LaoHnId92RqD+ch4
 W6a+m+334SyzSTAcxrtXZjTx2K2mDjmTkPAVitR/FqI9JM+KR52oGOLAx9OUrt4/aDoi
 RSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736383262; x=1736988062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3FUErQ3sfEJtBKE402t+C2cN34fQzSNGHkufLpYS7w=;
 b=pKbaitIY6X+jDafBQ8fEO2cwWyhp17jUDF3U5CX1wIt3iXLg6QzcmE8A/Z4QNtMSyA
 wkXgeFRZAo+Stlw9CIDDNf78L4YuY21+4GNmCXEV3yiWCEhRLAilGMql2aD3O2CNptgp
 /xeYg4lroYiR52hlRco3cU91DdiexPBdWwrxXEZBegdcnSdqkrJMBJFyd5XTc5zyhxP6
 MDzUAAdqTcZH9+etamPLa+t585MVL7OAVbV14k1Ol6hKceqF7IT+Nm+D8QOyY2QFYV25
 /b1Ao9hgFaG5RnnrJjdZgs3Zu3jk5e/MVxmEzrECjmXXCpHHjW5HXvLMGkQ3YfE9tBHk
 3D4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEkFk8yiALgFJ/wCKlq2IDhAfzV6abkpO4MhmjKUud/w//XqHH7iXBrGu7d06lOfMxhIorByfUocoD@nongnu.org
X-Gm-Message-State: AOJu0YzOw9ATmYaayczmcpbWnRYGRDdd5T9pS8z7sxNjsh5Rdj6AjpQ3
 fiwhb1l+5WkrnXCoGAgKYoUk5PvzbIbD4pqoefzNcCXnQwEGcv09HFWSPdxHJVU=
X-Gm-Gg: ASbGnctp23pA5eQsM6tBaFRUu87GcP44U0pRzkXyBGcpVPIaSe0IBW7Pay33aP/1+p5
 tLWSeRYb1nCxBDWQRtkruvT2PBJJtFdqSaRXC3dk4EvQ2wOUshBLfXn4/lJmaedLZ4OYYq/BGOw
 MQRGTUBmtwAult/U/+UG+DRwD5YeRwmpIW5XWyLiVbHeFuop+glj9MLQ8qgcUikZ3/989Mm8Cl5
 QFhfSTeOzWzjBztINYzTKmJ8JjKVDcoZ8F7d35W89H1YnihkavaJauw5wqPyuB0dKvAHQbTd6Hn
 DN30xLpQLZiW1y9PpmZ/cTxxlNuQfKc=
X-Google-Smtp-Source: AGHT+IFUReovRfnkmBrygh1+ZdXOfbzyBo7aRiHQHOMLBIGK5hmRVVV3ExokgOc5eRCVU++klLzx0g==
X-Received: by 2002:a17:902:db0a:b0:216:7d22:f69 with SMTP id
 d9443c01a7336-21a83fd0994mr53914795ad.50.1736383262087; 
 Wed, 08 Jan 2025 16:41:02 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a917694d8sm547765ad.10.2025.01.08.16.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 16:41:01 -0800 (PST)
Message-ID: <787ed640-60eb-4466-ba11-0ac9c9cca3c0@linaro.org>
Date: Wed, 8 Jan 2025 16:40:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add missing /proc/cpuinfo fields for sparc
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <Z37rL5jVYpOk6ufc@p100>
 <f36ec87d-d384-4671-a80e-27d4ad4fe7b3@linaro.org>
 <b8ce1a5e-d239-4c4d-8515-171312ebdffb@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b8ce1a5e-d239-4c4d-8515-171312ebdffb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/8/25 15:21, Helge Deller wrote:
> My suggestion:
> I change my patch to just add:
> 
> +    dprintf(fd, "ncpus probed\t: %d\n", num_cpus);
> +    dprintf(fd, "ncpus active\t: %d\n", num_cpus);
> +    dprintf(fd, "State:\n");
> +    for (i = 0; i < num_cpus; i++) {
> +        dprintf(fd, "CPU%d:\t\t: online\n", i);
> +    }
> 
> Those were the lines which I was mostly interested in since
> I found one application which wants to parse /proc/cpuinfo
> to get number of CPUs in system.
> Would that be acceptable (for now) ?

Yes, thanks.  If only linux had added a prctl or something to not require parsing...


r~

