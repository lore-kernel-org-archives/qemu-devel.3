Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F72E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 21:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOkcV-0000qT-Gz; Fri, 20 Dec 2024 16:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkcU-0000qC-2J
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:33:14 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOkcS-0007Eo-JQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 16:33:13 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so1537913b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734730391; x=1735335191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uVwFGQczTa/nXRixvpdyQjZRERK8yXEOSFYzy3+em/E=;
 b=ROHKsWhwpDBqgz2WAiTJnMuxgHSVzBLWcXI/HSdYGWhaJxrD3fTulcKDJngBjUQQ/M
 RXwWR7qCRq1pl4Atv8fyfqz9TLp75MgpNWkq4xMOJhAXUS4PmgqbU8QfzF0nR7sPwMPT
 cOz19Bb1xsiporLoP0T1WHeKa8j+AG29obM7xOTOvUiKZrERuVxFCXnX2g14Jt3bp6cS
 j+L1TEAPtK/ynwaAh7bI8jZfviPn/8M5f3OLjoHd3R439UZHnY2b113kqlRuZcG6aBC6
 7yQ0EeDvrKZRLIpJQD9KWXYnyNa4MNn4DjTttAp5GuT1WgCL2ErGQL3ikXadc7UU7wi5
 d8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734730391; x=1735335191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVwFGQczTa/nXRixvpdyQjZRERK8yXEOSFYzy3+em/E=;
 b=mknffkWMx1rSVlA7yukG2k0Oh/CdicjwV/SDoggqig50tKv1OI8tabOCE1G14coZoF
 x1uFVtbkTNAI6cJ0vd+LC1tgLqHHJed2FeY8QV5jfgxOqtLAQXgMyYIcoaJseulrzYOb
 Yt2gdcKl7T7h8Hd4JXcz2MC8C5vcyubJRxfZr/psqpU5yo/QjixSAIe+rnEItoRpk4lR
 04nkOHsEBC7QuKHJTUESRFFocmCxaeqwm+KBNGSIj+J2fRgAcJbup2CYyGvgbDEKr5/U
 N/w4ZkHNfK9dvXYiVfF8mkZoijAVRREb2liSxi4xiqtxohodnMN/ZDnQ0JR2v+MU0cnA
 wC7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw74yw3ZlWYog1w/JpLTuBzB01aSxRRyLZWN3to0yE/GYDk/jUJQNGSJUVkjk54wANt/nPUJYzPGBU@nongnu.org
X-Gm-Message-State: AOJu0Yx0kcHM7N4NFfN72jZFhEcQ0nSgpXStGT2UcMsn7RIMxnYzpWG3
 w30DY4sAgIUKcF0sV5CVrOkum63yEiiqKyVExbctg7sXJp7j2p3o77UDxc+5DWE=
X-Gm-Gg: ASbGnctoXGvyYuspbd81MuBaP+VhSy70/OLjA/NavamFpVNHAGXYCqxoaPe+g4Vh9cM
 NpO1XXNY/RlYyVXoyuj1wqYz0BD0sbOsd4lrC0hzk2crZG71NNQUW3lLTizV4Os5xn6a/el6OlQ
 neHUwxEBkB+pPSuNV0Zux34iI2FKoUvGJTzwSI6lSjl8/WaKmqEtgCxkVBrNDvgi0h20IAI6VmE
 hxr7os8FVEsdfmEwanr14oAhnTjLXdPfu7bUDmKRdu4xv24+Tkp0N9VOYVg9LQu8A==
X-Google-Smtp-Source: AGHT+IG7blaVlhXqPepx/HYzBY1lsVW0jrxQC/2reVVkbbzdTQqUQ5MqXAphC+eeZmr8NmXOIyCq6A==
X-Received: by 2002:a05:6a20:c907:b0:1e0:cbd1:8046 with SMTP id
 adf61e73a8af0-1e5df94b400mr7077533637.0.1734730391031; 
 Fri, 20 Dec 2024 13:33:11 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dba6asm3551737b3a.130.2024.12.20.13.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 13:33:10 -0800 (PST)
Message-ID: <fd382732-16f4-4b26-89ae-0252e62332e7@linaro.org>
Date: Fri, 20 Dec 2024 22:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] accel/tcg: Always call tcg_flush_jmp_cache() on
 reset
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>
References: <20240503123456.28866-1-philmd@linaro.org>
 <20240503123456.28866-6-philmd@linaro.org>
 <bd395931-0883-45b0-89fc-8766ffcda9cf@tls.msk.ru>
 <1bdbdcbc-29be-424d-9215-fc711b11a1bc@linaro.org>
 <464fd4fd-a6ff-45ea-942e-ac4b3a86d4cb@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <464fd4fd-a6ff-45ea-942e-ac4b3a86d4cb@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42d.google.com
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

On 20/12/24 22:08, Michael Tokarev wrote:
> 13.08.2024 18:10, Philippe Mathieu-Daudé wrote:
> 
>>> Has this change been forgotten, or is it not appropriate anymore?
>>
>> Not forgotten and still need to be fixed, however unfortunately
>> this exposed a bug in user-mode SYS_exit_group when using plugins
>> (see qemu_plugin_disable_mem_helpers call in qemu_plugin_user_exit).
>>
>> Pierrick is working on it, and I'll rebase this series once his
>> work gets merged. Next release :/
> 
> Hm.. Do we have an idea *which* next release it will be? ;))

Hopefully 10.0, otherwise 10.1.


