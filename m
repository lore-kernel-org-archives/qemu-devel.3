Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A478C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGWI-00043s-FR; Fri, 28 Mar 2025 16:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGWE-00042w-N2
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:41:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGWC-0004ZV-RG
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:41:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so19661775e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743194491; x=1743799291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qE8rsxa5B1tHd1PsIDIBEkRAKhuAxu2odpXzlifVTwY=;
 b=bPaRnxUoNufYlcUAdYOJpP1anrDD2bKeSUYwFXF9fAlnIxicD8/j0V7gdgms8dxeLx
 y9ZifkHAYqBKtXXViXmcya8TPJaDlMdPzFnDegY432Fah+w+PChH1kXOSOGmXyHE9WgN
 1gkk5xbJ44jo/7TUqT0HtRHYBaVTXj/TyXAjIFq9nFnBnStgaNr9X2QBelxJPu3VaKkO
 sQ+LCQ0muQMGVExDU2dVt0blGclJAQ4iQEN+pCYXcWGTWAGJifXMSseBZFHHGDGywyOk
 BCRc5/x0Gc+/a6v9+6LQl9zvkEkkx4mhog8Tni9eZ1dDZ/tqX9t8weshNBnX30nC0Q7e
 GePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743194491; x=1743799291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qE8rsxa5B1tHd1PsIDIBEkRAKhuAxu2odpXzlifVTwY=;
 b=qKGxoQNGLOOAvu8kbANFguasUM8y0YsAT5OL9OluQpmNimi7+ggk00ztCUnzdBGxkF
 M8ggIOu+zQOZBxnx5XMBbwoaTIy3VzQNqQ3FSFvqEu7UbRiOH4wpD2XDaHgsEHUFlMCo
 joQazvvFGNY/tkpOrriSvalGJfqqS4xMv8cYbiD4Jmm3Ir3PJe4U2rmuH4wxV7m0Xg1m
 Ag/R6eHH8wMTh4a8hlbYi9jlPY42LzoDxUlv9NJDuklYBD3CgbgyaY4XDUfW/ketXiOC
 qqkmP1hy8t6unDuM7r/NjMosI0rV91oGmXisC6ktIobTHq4XY2uvx3gGTqPeOpwtAXyR
 NF0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhPPJEuGwXXdxsinWiXA6TGQ9GOik6ecWofLF5hMKiIN00DOjT4k/diA+q1tmXaWUiHeG7IyQW0WbF@nongnu.org
X-Gm-Message-State: AOJu0Ywc3wuK73sMOgagEHEgclzHcb8mkp+kAYjjqBZMA2nEMVUOzoe3
 ttnywDm8BEPkoalcV2EET4JiRbebMQOXQmnDaUs92by5iV5pC5KluTVu0VKVTWg=
X-Gm-Gg: ASbGncuTL2ghPuxGYs8c/t00GjlaX1SsARqztrA7r/dX6RItmWQZ4busEFJxxmxDQ1V
 TwNe9Z7GmjqEeph4vQAXtsgQX7EHWQJ2swZ0S6C8HWKyyz6N+CTj638apAwjJdW2cD/n/7Diadn
 4gJEcAa1BH2E7YPkaRl2LK6/mG4sYAdDqQimk9PNiv0e9u9HCo6laSoEMMzJnadjEVTLbgpQTIf
 iG9N2tOlxGxEQKa88QlNBBHCQvdysDM9RwZTPKaFMqXvFmBjeSuFBhJkhkWA/VkC9zkggNh5io7
 Hss4a+KjT/UyityTtZmMXGNdqlAV2wcJQqm5KsAFBLWkuGUYzgGXW0yNyzaPKmgz/TRnNojZqpc
 XDdGy1BSx0qfl
X-Google-Smtp-Source: AGHT+IGNYd1D2LLfwvf7+wJKnxaVhaykC5lUtKPA4pt1WM8OrvPiZk6B+LiBG0TF+rp4Cda+8kQB8w==
X-Received: by 2002:a05:600c:1c28:b0:43d:8ea:8d7a with SMTP id
 5b1f17b1804b1-43e1cf5c340mr2188935e9.28.1743194490880; 
 Fri, 28 Mar 2025 13:41:30 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f91sm38449355e9.29.2025.03.28.13.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:41:30 -0700 (PDT)
Message-ID: <43922be5-e1cb-4a57-8341-4a9dea9c6af4@linaro.org>
Date: Fri, 28 Mar 2025 21:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] block/nvme: Use QEMU PCI MMIO API
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, schnelle@linux.ibm.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-4-alifm@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328190627.3025-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/3/25 20:06, Farhan Ali wrote:
> Use the QEMU PCI MMIO functions to read/write
> to NVMe registers, rather than directly accessing
> them.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   block/nvme.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)


> @@ -805,16 +807,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>       bs->bl.request_alignment = s->page_size;
>       timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
>   
> -    ver = le32_to_cpu(regs->vs);
> +    ver = qemu_pci_mmio_read_32(&regs->vs);
>       trace_nvme_controller_spec_version(extract32(ver, 16, 16),
>                                          extract32(ver, 8, 8),
>                                          extract32(ver, 0, 8));
>   
>       /* Reset device to get a clean state. */
> -    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
> +    cc = qemu_pci_mmio_read_32(&regs->cc);
> +    qemu_pci_mmio_write_32(&regs->cc, (cc & 0xFE));

Extra parenthesis not needed, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


