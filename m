Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E0CD78785
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 14:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWbpn-0003X1-E6; Fri, 19 Dec 2025 09:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWbpm-0003WO-4B
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 09:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWbpk-0001N6-IS
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 09:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766155912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1eWw38weqjxka8JSNE+S3KyEvrUPJiwiQZsZNAzFNHM=;
 b=dnHdARjpF0eafvBJXRiz8pyqAlJ0VbXpZQUi6rZI/bxkZr/DfdPJJraWNdfHgpOtHtvIzR
 5FlCwtRmRXrCMt/bCN8YR7U43ORtsaVBfdmAGq85YWYQbCbdg5o5JjCdlonYzF8l7SwXUX
 7xdct1jalATqoXAFn7gRptIj2VxXNO0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-BndnZtEVNJu6mGVeSFtDRA-1; Fri, 19 Dec 2025 09:51:50 -0500
X-MC-Unique: BndnZtEVNJu6mGVeSFtDRA-1
X-Mimecast-MFC-AGG-ID: BndnZtEVNJu6mGVeSFtDRA_1766155909
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so12288185e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766155909; x=1766760709; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1eWw38weqjxka8JSNE+S3KyEvrUPJiwiQZsZNAzFNHM=;
 b=qJxtpTyrP/N1RIsD5L+AWwouMj+1Gwp01NZ0ZaNTfJC3FvwfKmV3o8OjmFdYqfh2Hz
 JPSCw3aepslNNSfPyBayOXKUSKQz12SnZl6NNNfa7QBMrNxDieFxy/QS1V8AE75CQXmN
 WdAsVaL1tVBO75vRQNM6veZTocJNN1s1Al+Rp7KYgigFuPMJIsOsEB0hnE/nBtWEr6L/
 YAguEUUfOsw2kf/E9Fe/dtLlSf1J1B89AjZoZxEdex5ABqOiDaE4qtvccqMMBSYdBF5J
 u80YZYFubl2F/f7efFgoxei2FY2Sdg7LIxw7shs22Ofw/P+41koQXVAYNjnYox4LDgVW
 PKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766155909; x=1766760709;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eWw38weqjxka8JSNE+S3KyEvrUPJiwiQZsZNAzFNHM=;
 b=iMjUlNXiV68Sj6WQigv2zfiuWmMc/aKi5Xny6wZ4v4IgoYLrPgFpTQi8H2TBh5h0oJ
 53y44BrW7m7NdEDulqMKPVebh3jH7L70XsL6iEMzHdMxhHYVbsm1sZbKn/J+ZcAl9ddI
 LZc+asslgaLoAsslrNr88sq/RXs0nl3lPGkjwHO+1xHHqWxMf6WGpbQ+pmgWzwc1Jl/D
 vGcvAsiuvbfaFuzyyOfBPDTEyXTEVdti9Bm794vtNcQcuTgrJzKOxUCjX0VtcV9dRrhk
 OGBsxtWkUhFKKd4sFic93HQuXp+XiUwrF7WJqp06Cs4/7IrV5xyOWLL781l4uqwvdlJH
 CWew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNtTACbCpjzaPNGCCUqA52iOe2cn5dh0m9kO3ffsMXkk8F0/9cpkyhcLqbqTAhMT+4qD66+lVE9W9p@nongnu.org
X-Gm-Message-State: AOJu0YwYyttSc8nO5GyMKFwY4DsUpeXW8BMqSo0VttHdYhCfl59m+hpM
 TJpwAiuuKFpWArXTLFW27Ay4tG2rMj211DD4Ah76zm5R/TzE6H7V+NlOjHD4lb4xDgZb2vdwwBo
 lUdjfMlPI8Syf2Ae6un89u5dd5pt7kgFIobDfWs78xu4Jb4oICQV4EgNd
X-Gm-Gg: AY/fxX5s1nJCRjDDNuHesZy8LNOLaIT5fhoOAJRl7laqLhDfqsUWW/XWuamNUC1QArA
 tgfw4ds2Ln8Gj4WBF1uIBwDNrcJ9L3xJ0cNWZNwCbISADHM2G2Jp0FqmEMtZIWBT3JyOvkGc/6l
 mmoODXknNwztY6dUDkss2+rwpaTcxS+auQDCuRWpes8Tt9L5ioXKRvQ4xAyQvgqsB79x1xYvIJS
 6XwFVAj9FvaXLZekG/CYfrqrgvhzz4yMw9Ayo1qWppEELvPB3C0jEYHj+KBwAraRw+gj6T/AMTw
 WGjcqLzgFaggH2CdcEpufziNo83RxQQVA8ygoP4yIPQeISknS1As/IbxvYlXq34o97pH8DhgGAh
 S2Fr4DqBu9tv2zngHu2qCl4Tt/k9hAodH9awElgmJ0pEbVozr
X-Received: by 2002:a05:600c:3489:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d1953dabamr32360115e9.9.1766155909416; 
 Fri, 19 Dec 2025 06:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECHMI0Bj3gsm0SAajq046z1W5FYBvzfza8snAufskVs/5Xu8EfvMi7GOv53gpeTDuJ0g+5kA==
X-Received: by 2002:a05:600c:3489:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47d1953dabamr32359885e9.9.1766155909017; 
 Fri, 19 Dec 2025 06:51:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbe58sm46969735e9.9.2025.12.19.06.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 06:51:47 -0800 (PST)
Message-ID: <4d7e4040-349e-4772-bdf9-43d4f8a6f771@redhat.com>
Date: Fri, 19 Dec 2025 15:51:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] util/vfio-helper: Fix endianess when enabling Bus
 Master
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com, fam@euphon.net, alex@shazbot.org
References: <20251217184253.1520-1-alifm@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251217184253.1520-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

On 12/17/25 19:42, Farhan Ali wrote:
> The VFIO pread/pwrite functions use little-endian data format.
> When enabling the Bus Master bit, the value must be correctly converted
> from the CPU's native endianess to little-endian format.

How did you find the issue ?

Thanks,

C.

  
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   util/vfio-helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index fdff042ab4..3c8284284f 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -443,7 +443,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
>       if (ret) {
>           goto fail;
>       }
> -    pci_cmd |= PCI_COMMAND_MASTER;
> +    pci_cmd = cpu_to_le16(le16_to_cpu(pci_cmd) | PCI_COMMAND_MASTER);
>       ret = qemu_vfio_pci_write_config(s, &pci_cmd, sizeof(pci_cmd), PCI_COMMAND);
>       if (ret) {
>           goto fail;



