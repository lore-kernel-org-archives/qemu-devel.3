Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B47BCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE9p-0001mc-8e; Wed, 29 Oct 2025 17:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE9k-0001m6-NG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:56:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE9b-0008It-HD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:56:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47721293fd3so2431415e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774979; x=1762379779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Po6AyAoeNogstTHc5AgDY1aqQVkWkqC1kTR6HSRLJ0=;
 b=pAdmJirJ0Kf2Xc537GumVtrIwXtrvaNRgZ5+/+zK+3STqAW1YbsPoGYy4VhpRiPRub
 NkcTAPI3wdlFByN+5X+pVnZLajX1idyAI7FAMbCveeAoZWfVGTyjXNMZsgZbmpHxxz6o
 Ri6bgPvzxoTumnoAPd4GugtjF1ZSCCdEZfbu1kK7uoW0996blbmlwfqtSAalMlA0eY9F
 p6hJFr3oILJl/ZJO7ka9WNfbTO3MN25C3SRX3peDVvIdsRFKMGgDBdogL5sJTAhV4Ij1
 wbU9yQ1P+o7a9qa/S5Qq9qcxoK//p0o8qHIIVIwKW9X/+P4q6/TwlLPE88TkxfdZqh4J
 pJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774979; x=1762379779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Po6AyAoeNogstTHc5AgDY1aqQVkWkqC1kTR6HSRLJ0=;
 b=sWC9IxvWyNq9r79U2Ni3HbZBUiOZ5d0AuoXssuKPMEOMns0obgOXM6Md3PHvdOWB3U
 EIAXra7HZ6hbPNElNU87mJm4QyYPULVK000TdZlVOxM43WtXrQ5hmB1CxzfXw+OOqeej
 zKVZOqOP31Xs/U7LhpKLZ684x9HR2MpquYTudxeSAANUUFxT/VqAsBtPH6gxCuTzjWze
 Tbap9b/RTV5o76vdwtGCmw9BHo2v1k1/T3TMCo0fEaw3+h+pzgEgDeYfjd0sHqgYmIBk
 YsjQHPUEEA0TJjcz7gomr0jYMhlGwoYlFPiGWHm8MeTB7Oqk+c3gX7zoe2DbmReD7/2S
 UsPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoaZFNWLTA8rD/nj5GzjvsrPVB+/bruqbOYgmqPfBjO+a+RwTbQyg/SoCgn/V68e818s5O+YdoN5Op@nongnu.org
X-Gm-Message-State: AOJu0Yz8WOLMJ44xd9HFZFgWXAmmBhzNiJTootQtFjNVwm1jfS1CltFf
 O0QIFgdBJ9+36f7enssPjTWeoUR8misSyBTu3qRzOkI8+uWem5Chx0SrDW0RPgWxkGM=
X-Gm-Gg: ASbGncsNCf3bUAfY5BdcFqalmWOmsWD7tzGwJbTraOzNe76KlmthElqGh9KmoA3G9an
 qmNbUks+JeJyX6AljDRt6/7h3GfujKfiM5CGitnsLGRX+fpPwN+uGbpWs9WjGkJ3Tk938WiFmeY
 LTx1ABYxLM09j6vzYv/Vp9BZuOe+HzgaKBoVZ+ejM/zF+Y8berwhfmg6yW3G8uLRD6GWF391JQc
 5n/SqKoUBihkwsSJrpQ/xJCgV6TTFosrQzkeRyk0BX2wPn/FS6FFjJ4KsKB91cNl1RLYrNrEhzr
 6sPmKdFwfGhHywOoo9xwBBKxvpEwVyK8oOyehOCKU3ipII1ucsPTFFe1Lv2RebnZbqmumzVShyR
 tLzxbRXKx5fj16Z7GIfq9uAoKvATxnjYbA5lmqjhHFMvFme3D1yBJXCEnFSjR0khy/spbYzii1O
 zg39WzMYv/uV/U4wsIiTW1tIY9qTpP5VVW5m1sUiNoBzM=
X-Google-Smtp-Source: AGHT+IH2d4Oo41bUMM4e8ov/5r5JLj8XpGGeh/BLTWPpeEBLCKkyQOnGF1fhqzCvKJS6uLDB2nJsCQ==
X-Received: by 2002:a05:600c:a011:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-47726276e88mr8878165e9.7.1761774979232; 
 Wed, 29 Oct 2025 14:56:19 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289b0bb3sm4709405e9.8.2025.10.29.14.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:56:18 -0700 (PDT)
Message-ID: <5fdf4757-ba5f-4069-ab6a-8761f33f8ea7@linaro.org>
Date: Wed, 29 Oct 2025 22:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: mark io_mem_unassigned lockless
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peixiu Hou <phou@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20251029185224.420261-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251029185224.420261-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 29/10/25 19:52, Stefan Hajnoczi wrote:
> When the Bus Master bit is disabled in a PCI device's Command Register,
> the device's DMA address space becomes unassigned memory (i.e. the
> io_mem_unassigned MemoryRegion).
> 
> This can lead to deadlocks with IOThreads since io_mem_unassigned
> accesses attempt to acquire the Big QEMU Lock (BQL). For example,
> virtio-pci devices deadlock in virtio_write_config() ->
> virtio_pci_stop_ioeventfd() when waiting for the IOThread while holding
> the BQL. The IOThread is unable to acquire the BQL but the vcpu thread
> won't release the BQL while waiting for the IOThread.
> 
> io_mem_unassigned is trivially thread-safe since it has no state, it
> simply rejects all load/store accesses. Therefore it is safe to enable
> lockless I/O on io_mem_unassigned to eliminate this deadlock.
> 
[...]
> Buglink: https://issues.redhat.com/browse/RHEL-71933
> Reported-by: Peixiu Hou <phou@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   system/physmem.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index a340ca3e61..1dc2b46e12 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3011,6 +3011,9 @@ static void io_mem_init(void)
>   {
>       memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,
>                             NULL, UINT64_MAX);
> +
> +    /* Trivially thread-safe since memory accesses are rejected */

Maybe duplicate the comment in unassigned_mem_ops[]. Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    memory_region_enable_lockless_io(&io_mem_unassigned);
>   }


