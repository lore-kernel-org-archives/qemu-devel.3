Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06065E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 12:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMRRT-0007ED-9D; Sat, 14 Dec 2024 07:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRRH-0007Bf-Mz
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:40:09 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMRRE-00084E-GB
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 07:40:07 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so28330695e9.0
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734180001; x=1734784801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjneZFKrcu+uWUFSjlh0xBBfNMH2Bn90wxjOnEEOBdI=;
 b=jEm/NFes+wZLzT5mpjtzKMxO9JZLYbz08zfgOH0yzPFbmfwuNvd5xcMblMHaa1Kjh4
 3p1oze/W6d5q3XgN9wAhAvBZteh6v7KGFk2Uy5EOIUtJ1rST64qZbHiXMJFwtbsrJfr3
 4RhhVUWp3SuJU+JUe3JxGoS86zOUsQq4I/eiGiqET08Sd+OSFXIqaFmA8YSE/4tm9cOI
 svhNL0iAjMHpHogYjGTa7U3leL5TkBjPl3ZRJvvfrpe7BIP4U7Vu2OsrWvRPvuTmiZtW
 b+RjGwff0gDZxpZc3L7chEoIZWQjeSbVnp74z8lusqXMxaZqdhQd4V2CfNsJrALR7CeY
 NrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734180001; x=1734784801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjneZFKrcu+uWUFSjlh0xBBfNMH2Bn90wxjOnEEOBdI=;
 b=BIcDEpCup0KiQcIdjZx7TK58GmTUIZlwDFbTtx3OvjydAW9lkmM7qhEZ38mTEHFkeI
 TBnIBqF6l5K8ZnqQ12zCCPZkP/KH6c/w1dszDO7+2TQyXgf4W2p3j9IYbDdX0fcOF/2M
 Aiga9EdVx9tzx/7/vNGHXMvPI1HKddPs+xJz1Z3nzfSRQKkRE6nGT6M2EQ8WKDCy/knd
 CFFhlPn82utDxRyzx+wVG0JWbTLr/mV7j9r8xp6m8JXrl/Cr1A+KdSe1AaUHKu+KioLe
 qtkXpNiBjjdgaGBcwu5WGzexjTsQ8R5+X9m7hJ9rg/VgqaIKm6nv3nroq2u8EV4UitcY
 EBxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbYFtvbaY1yLtPC/EI69cTRHYqiFOAXnW7QfjvyY7h5F2ItrLnHuvZXgoqsnbJXE6pZdOXPFQ3ZtqU@nongnu.org
X-Gm-Message-State: AOJu0YymSHuaLalrUEv7lh5mP1iFVZJsJCJAiYb4f196K7QSpHTptqn3
 2UHV+EWAxb4SE0kIAsC3S2EOXN5//rxkH7H5yvRaRh3/10d7hoi+E4LwpF1sTSQ=
X-Gm-Gg: ASbGncvjKgPI0dhJEhhjRJTHJNk2M7ud43hV7F/HETbszcJ99RO5QHBxD7LFwHmzR3V
 ZdgRV1/UHJeWQ1NglK69qe6MYvoJKrzSlbW6Q6gHDOozGkAeFRdQpHHOCHli1OWIInMg1IUtrZq
 X3/oIKGgOu++SAb24/shC0GLjHsEG1bCqIrE4rfTFQPGR7LxIhNYshJk/Cmlx8cHz4/Qd0u1WSI
 MMv+LGsbAeN1H86ICwIF8i8h35KnzB0mepXKrTXnK+HttFYkEuXpdQcRnBcPawa+ehuPZS+UlZ9
 AtNxYDvlW8gaRuC5pAAEeOVdjtZYWSXY+d04gbw97tClZg==
X-Google-Smtp-Source: AGHT+IHmrr8ZTcmK/A3GOLX1/Msq5ltu4lnYGBHXYPV0OEtyhofe4ZbOd1XOEGzZRO7Ij9WP3sKaXQ==
X-Received: by 2002:a05:600c:a4f:b0:435:23c:e23e with SMTP id
 5b1f17b1804b1-4362aa28318mr50071685e9.12.1734180001008; 
 Sat, 14 Dec 2024 04:40:01 -0800 (PST)
Received: from [192.168.224.213] (196.red-95-127-57.dynamicip.rima-tde.net.
 [95.127.57.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c54bsm78334135e9.13.2024.12.14.04.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 04:40:00 -0800 (PST)
Message-ID: <06fdc8c8-377a-4969-8e11-513f6c8cc553@linaro.org>
Date: Sat, 14 Dec 2024 13:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/34] next-cube: create new next.scsi container memory
 region
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-4-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/12/24 12:45, Mark Cave-Ayland wrote:
> Move the ESP SCSI and SCSI CSR registers to the new next.scsi container memory
> region.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/next-cube.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


