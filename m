Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA1E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM4uU-0008K2-Th; Fri, 13 Dec 2024 07:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4uF-0008Hx-CG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:36:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4uD-0006vL-Il
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734093388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uIfleIgDesZdRmuHZu/gGCafP9XtmQsxa4tjlRml8Wc=;
 b=imSmXw9+/vp5heWjEiRnUS0xgqchhUGzLVMljWrfSch/9JYF+BcGCxjO/FZuCOBtJF/Y3G
 OUF1LM1iwQJqFK308tkj74dqFEfAYrU9T8A7Tf4L4A2lSWirLgDB5UxvMYS8FXJK0PQNLg
 /e6kwIJ5+HHUSQ1XM2bS4Q0aQYqMDII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-fmL2Cn_HN12bmUQbhtqORQ-1; Fri, 13 Dec 2024 07:36:27 -0500
X-MC-Unique: fmL2Cn_HN12bmUQbhtqORQ-1
X-Mimecast-MFC-AGG-ID: fmL2Cn_HN12bmUQbhtqORQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361c040ba8so3065485e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093386; x=1734698186;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uIfleIgDesZdRmuHZu/gGCafP9XtmQsxa4tjlRml8Wc=;
 b=DqsbN2PJ98oRs2j5WmziZDtMAoTPWMKP6C16+7Fp7IczSYAa7WIyfll4r7uYxalBaV
 vbPYmjqEvrCeuRcabukW9+1HnwDtex8WDDKIo/TEzQ2IXeKA88vtXExD8zmNtgWyObVk
 jiAZFf9wrkpxTVALIq+NaCGJ4Sq+aopp3kI6fTz6cpma/N74/SFnoTKNMvgGQZFoPIBZ
 lPcUgjp3ox1/zVgz4WHxoyR9ar+1HSGCLUjCZtIJIrcpGUsChz+8gThrJa/65H0OShZT
 gGPekbhs+KelZHtCIlq5VlieXg0qFuWBAqkwXYGLjtecngbF6ThGJrqKR2UUSeRk7Mzo
 wo9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkhszcTwE/LCIXkJnVDGkbZ1TPiwIIXddAxLqbyFvQeQPZDrnKsNurHssBsfeILcSTHznOmnuR1b7K@nongnu.org
X-Gm-Message-State: AOJu0YwDsTYtjpXKwSopvCw9nM6id13x9mXil6rQX19ZO5bzwAwe4ZX9
 aNi672X7Fja35yMcMMarAz4ejSyq/W3murnAzHFV9Tdg9MTyPQ9Lpl15JmTkWx2GZX2k4rhzWDd
 Dl1OqK4UEXsAFY77JXiuqjwJF1UZUwk/h6im8YE7sYR7HplXpa23W
X-Gm-Gg: ASbGncvuDhP82sOVxUeM2rt3Z6B4JAnpJNkpniIs/bIzYg7NhEBspIdRtY+fJZmcDgE
 qWstY+z5gGYquowhlHUk7rD8/BN4HsW8EpT+nLT/nSeGsSLxoVeZhTGwln8nBSHUKKiUr7rcDgP
 sMVw+0VyQsM27Q7BMfev2jZbkmZglUtA2s7jhhCUstm2nFaUCe3VCjT9bSiotViYTQvSIhNUDHF
 cqb+V9ipPDY7B+qZO5ml2L2Zj+QtxWsbalNyBlMMXFEdNWwKzCRUmleRZLYWIjrFsq/ERWQhRMu
 3iROng==
X-Received: by 2002:a05:600c:4e8c:b0:434:f7e3:bfa8 with SMTP id
 5b1f17b1804b1-4362aacb94bmr18171575e9.33.1734093386386; 
 Fri, 13 Dec 2024 04:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVo1t2NOlIL84wjHrwpfqSYw6UD/ZmepYOB0QeRERzqpNRrz9vqCdLaFxaPMyEQ2FJk1mm6w==
X-Received: by 2002:a05:600c:4e8c:b0:434:f7e3:bfa8 with SMTP id
 5b1f17b1804b1-4362aacb94bmr18171385e9.33.1734093385974; 
 Fri, 13 Dec 2024 04:36:25 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625550563sm48090735e9.4.2024.12.13.04.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:36:25 -0800 (PST)
Message-ID: <4c626c8d-6e78-4998-a034-75b1d3aa0354@redhat.com>
Date: Fri, 13 Dec 2024 13:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] s390x/s390-skeys: prepare for memory devices
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <20241008105455.2302628-10-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241008105455.2302628-10-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/10/2024 12.54, David Hildenbrand wrote:
> With memory devices, we will have storage keys for memory that
> exceeds the initial ram size.
> 
> The TODO already states that current handling is subopimal,
> but we won't worry about improving that (TCG-only) thing for now.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-skeys.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index bf22d6863e..e4297b3b8a 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -11,7 +11,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> -#include "hw/boards.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/storage-keys.h"
>   #include "qapi/error.h"
> @@ -251,9 +251,9 @@ static bool qemu_s390_enable_skeys(S390SKeysState *ss)
>        *    g_once_init_enter() is good enough.
>        */
>       if (g_once_init_enter(&initialized)) {
> -        MachineState *machine = MACHINE(qdev_get_machine());
> +        S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
>   
> -        skeys->key_count = machine->ram_size / TARGET_PAGE_SIZE;
> +        skeys->key_count = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
>           skeys->keydata = g_malloc0(skeys->key_count);
>           g_once_init_leave(&initialized, 1);
>       }

Reviewed-by: Thomas Huth <thuth@redhat.com>


