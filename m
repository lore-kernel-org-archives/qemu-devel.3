Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5735DD75E39
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 12:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tESvp-0000OI-S3; Fri, 22 Nov 2024 07:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tESve-0000Nm-Ha
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:38:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tESvc-0005Zh-RH
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732279107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TC4kAn1uomfbjoFnTPWjeDLnoKIfHpAbgJxSdMzcKpE=;
 b=SKLMhkwVSH7gMcdCAzbalvhuM5KOmaStDb5JyEc2WB3PypuoYhzI9TeOP9fT27FDRvtKpc
 CGENUSSOsp6WiBOmeivuNbMyT37qt18tITpr1uPe+Tn/S83Dz+It27F/R7oMrUlUwl0sqC
 zg1PnlSLR6VAhjEkH7l4o8PsyY6V2yI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-4UlzQc05M8KYvd89TzprTQ-1; Fri, 22 Nov 2024 07:38:24 -0500
X-MC-Unique: 4UlzQc05M8KYvd89TzprTQ-1
X-Mimecast-MFC-AGG-ID: 4UlzQc05M8KYvd89TzprTQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso15504345e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 04:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732279103; x=1732883903;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TC4kAn1uomfbjoFnTPWjeDLnoKIfHpAbgJxSdMzcKpE=;
 b=b/Hrix2iQMAu6lE5LodJ0briMHrsSZ+ko+B+SasuV7siXLQMihbb2H1miHgkkbNtR0
 VtSZEo4RZ9179VHXHHgHp4WyBCLTKOuIMw3Q2OTJoObDUzLZZqMxFqJhleWwTSMEs9zv
 ggWOXO4UdFd3L90cdra12ZvfXUgRsjhfZKIXLxEIhRKut+7tSf0XBYK0jx+52PPr/80R
 XfjQlJVM6CvzEy+XymJX90yXs3cPLhKCeL/vYbE6yBgMz6bs6oBH5ESq9rhVIqO5BQO5
 Y1X5eIrPP6ZtfrPKjUFAmfe+57bq3/pwuu5gm/YjgU9ws8v5Yyt2Y28T6ysiw/s3qQDw
 Zqnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd8p4ZKmCe1ZnVMCpPO6OFm5a3bXjbfPbSOwpKG/+zdnp13lUkpVOylKuM0VSuXEMaY6VIU2TpX/i3@nongnu.org
X-Gm-Message-State: AOJu0YysJAIsvU8oPoad8gv3+IYIESF9JedTm78XrTq1F67ykIe80coS
 Gl1J9PFCzrguL/IP/n7T+RCIZWq4eWDwvF1Cm0sRvUdMM4AphkUXHsDRCvAgZ9ki8JlXkqvbdEc
 QXJPDt2b7NcU0sWoZGLUvSGjn4NGWXTCvf9OmybU5kfOrnHBUVWXo
X-Gm-Gg: ASbGncvlwnpay+QgsZeZzfiYoLzhsq+3qFjJCmk29zHjFq/gUMJtzSwIT9NhL9b3zLa
 ByUlUAs3KHoEOjniIaAd9Aw2sPi77x16kVxy34wMsXeDoyagphMtK6MId5doj7MXJZqsWbZkU/Y
 YLJiZ5VaivpKrASb1xpNtYPxqdElssmG/eqpwVyhmy5u3EJ4X89ijCMib0e8w+PZvU9u9LgLbfy
 bZi1hNwMIWFvNNXeUsOyg7QP42/rPN+/3u2Ng6bmDQPoLjW1mmqeAxkdb76ATCS8F3UQ1G89/Y=
X-Received: by 2002:a05:600c:4f87:b0:42e:d4a2:ce67 with SMTP id
 5b1f17b1804b1-433ce4289d7mr24274165e9.17.1732279103367; 
 Fri, 22 Nov 2024 04:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxpZGRxPPawtuDv2dbbJzICne4do8tyMgs1aF2DY0/DV7qH+M2paMuTrPQCwpwD5bW6LiCzA==
X-Received: by 2002:a05:600c:4f87:b0:42e:d4a2:ce67 with SMTP id
 5b1f17b1804b1-433ce4289d7mr24273975e9.17.1732279103003; 
 Fri, 22 Nov 2024 04:38:23 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bdbabsm89053025e9.18.2024.11.22.04.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 04:38:22 -0800 (PST)
Message-ID: <a2833980-6a67-40bd-8b19-7cd5e9322df7@redhat.com>
Date: Fri, 22 Nov 2024 13:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci: Remove unused pci_irq_pulse() method
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241122103418.539-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241122103418.539-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 22/11/2024 11.34, Philippe Mathieu-Daudé wrote:
> Last use of pci_irq_pulse() was removed 7 years ago in commit
> 5e9aa92eb1 ("hw/block: Fix pin-based interrupt behaviour of NVMe").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/pci/pci.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 135695c551..c0717e3121 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -670,16 +670,6 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
>       pci_set_irq(pci_dev, 0);
>   }
>   
> -/*
> - * FIXME: PCI does not work this way.
> - * All the callers to this method should be fixed.
> - */
> -static inline void pci_irq_pulse(PCIDevice *pci_dev)
> -{
> -    pci_irq_assert(pci_dev);
> -    pci_irq_deassert(pci_dev);
> -}
> -
>   MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
>   void pci_set_power(PCIDevice *pci_dev, bool state);
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


