Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489DEC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TAu-00085P-QV; Thu, 17 Apr 2025 13:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TAt-00080E-8o
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:37:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TAr-0002IY-6v
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:37:18 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224100e9a5cso14255835ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911435; x=1745516235; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZSdU8xi8w6v0rIsJfcpmcN2IuDxq5gl7DYdX8LwO5+o=;
 b=ft21snJoDa9FkGCSprG2TJN4UtNpZ+kFsdpuNHAPV3+Vkn2+IjZY1E4EH+dZoHOR5Q
 5zcf85Kw86kQJWmQKIBc5Vw/iT4vaSWPgTI7QizkdEw3REw+lpg07cTarCHpPYEomJyL
 s4eGRWv8MKNSDk004bonCvow05bDBZ7WQu82P30UZuMdLNA0JindU7kHFdvypGx+Uyno
 1w9KIp7NcEjFu3aYUJh4gV2AHkvtCnhBvG2YK/kldxVre64OuMFir5TBcYmMvehYLPMj
 qYunJmgqM+INEZZ1kEW0HjtBxf7QHO7tiOnCJceyeSoq2I676dVHz32fuvkWKPipPB0M
 cmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911435; x=1745516235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSdU8xi8w6v0rIsJfcpmcN2IuDxq5gl7DYdX8LwO5+o=;
 b=nOs483D8bkijy6nS2EkKUJSZ4fALZJ6a2nM0ZHAFAxiY56CgRq7NyDFa+WPGvzeSO1
 aAG0k994SGi/rU/jLSgstWZR8+GzsSKqZt88Z+gm3tqSmw8wLI8pi0Dx7OimPkLT1QLm
 ob6l0yZuklnUME2oEnzbBnPOmfhUqcloYffBhlHMPVMR0rPakO7xFoonLkUcuZN931q1
 DpEyxVlvWCIVE1qy5yoWfrfv64MPdw1kt7b0vPdnh+J0mSTkbGLjQkDSzgew/CycfpX9
 XOlNg+o1WEc9FzBmuj6oBAJCQphIcnB//fcOcN++a+uBY9yvUBCkRYKcQvKpYLlHScxI
 8mjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyPUdqg3NEmWso9uE5kqoxuQZisN0nCx2+bxFeeyQOARH70m28KXUfZGCJEfRt5HCiMCJHk4FM3bUm@nongnu.org
X-Gm-Message-State: AOJu0YxoD+SYIBtZBc3Ck+o7ODNEl+h8JEgH9t/aOkWbSUobOKvlEhAX
 oLdMVk1CJbf3HYN0P42o7QiSpMdVZp/PIJFXZZq0EoJqkbqg3+oNq2nEaBO5KbM=
X-Gm-Gg: ASbGncujRUoQmZ1uUsTWtQWKf6HOTDI7wsLM/hDnXddA/l/sHjppwlUKGkRM54yUsw0
 95lXn4Px0CNdD+WKh9t2NaScmUbWNlgrwT5z6GgYtQdzJhEmt/n/+urCcXd6GZA7UtQ4/xVmuX9
 P4L1gODeC0oml6GFT6CnCfSjnRseeqZ7F3o24gL8EOCtHm+EG0asF86FRsv+DcWn4XBI4ncsY3c
 pvhPFIu7iiPwErva5BzxNbXZgJ6h7xHP81c2G7LbUvWuCVXy1UnV/F/BcqCCz9JGXdCYORSeFZe
 qPSmEnUfSgRWOXdZS7BvnkXvBImXWyY0QXLeN+8yJSEJrtmWT2c1
X-Google-Smtp-Source: AGHT+IFZRy+KFbeiHh+pIZU/M0CBww6h73ZxbbFaP4eBJIB747NMr4ePRfuzvZ6t+NZ2UVDNrP1KbA==
X-Received: by 2002:a17:902:f70d:b0:224:1781:a950 with SMTP id
 d9443c01a7336-22c358d67abmr109117205ad.14.1744911435583; 
 Thu, 17 Apr 2025 10:37:15 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed0ee3sm2578695ad.206.2025.04.17.10.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:37:15 -0700 (PDT)
Message-ID: <2b357864-6309-493b-9013-4893686f0bf5@linaro.org>
Date: Thu, 17 Apr 2025 14:37:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 11/13] microvm: suspend the system as requested
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204424.3021-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204424.3021-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62d.google.com
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

Hi Annie,

On 4/11/25 17:44, Annie Li wrote:
> Once the microvm guest requests to go to sleep state and
> sets the GED register with S3 type, QEMU needs to continue
> suspending the system.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/acpi/generic_event_device.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 5a1ac8e362..bc53551a45 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -213,6 +213,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>           if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
>               qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>           }
> +        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S3) {
> +            qemu_system_suspend_request();
> +        }
>           return;
>       case ACPI_GED_REG_SLEEP_STS:
>           return;

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

