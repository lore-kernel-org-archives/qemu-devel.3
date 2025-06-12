Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F414C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 04:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPZo6-0005KL-PX; Thu, 12 Jun 2025 00:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPZo2-0005Jx-8E
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 00:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPZnz-0004Hq-Cf
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 00:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749703485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JB8EwHEZ/OePmM5Ks6FWdJDJnUItz8sQjhyvjktlr8o=;
 b=ZL3Za7/S7FBP9rBtjhUJhDSuhJdQPTe0m/NScLjcZO8TO7CW9jz+omDahMbQ6lKlTn+uXW
 T/ZRSizdXdDbJ24zM85SZQNIiUsCFiSjN71bxOR2Z14ZH/3WkQ3rNR2MKZMvFrcjR9oLMv
 IRTiEziEVFdi6kdZtH7fKlzbJcX1IeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-45Td24FhMGqk8-cDOLL9vw-1; Thu, 12 Jun 2025 00:44:44 -0400
X-MC-Unique: 45Td24FhMGqk8-cDOLL9vw-1
X-Mimecast-MFC-AGG-ID: 45Td24FhMGqk8-cDOLL9vw_1749703483
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so2007185e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 21:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749703483; x=1750308283;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JB8EwHEZ/OePmM5Ks6FWdJDJnUItz8sQjhyvjktlr8o=;
 b=sjyX078ZYXiy5fQicDIzotyA8AqXlc/kb8f9aC4jWbxjbJ/r/sHEInYjKbvt2PXEzm
 nrdiUiCw6ds4LDlrd23zlTqKJiHOSOKnNsbZjl3LBRclQxVdcLRJDniOM9HSb5JLm3OA
 /ASWxjg7sOpdz0NqjrTh1qM7Dp5uqd1P7ffs87siu2HWTEp2mF2VvSHbK+PGI6hAf16T
 hFKR7KEKRt8VrMUEhjk8sAAYSGezU5Vvuj7H99+mChsgGBqyZOoMHzPUHDx4GtPnDSeS
 d3iPxRSTyvnnemMYnpxWZiaCTQJCDl+N/wXrIU/nhjXVdlV12xjAnxQlXqbCM2sbX+yu
 dkig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRKxYPe6uH6Gql30BEQ4WZ4pHX9J3NIh4YZO89+udmm1ktqDJAv3BN5mF35O8aLgA0zggau7Knrxtj@nongnu.org
X-Gm-Message-State: AOJu0YxqaW3R0Lby0GXrDMvWTgaXPlNa88bpP4Z2crMigZtPtR5HmuJd
 AkT4Zj0/YSLISvjDm/7mguadtF0WotFN6uQiqFnxo9HyNoVrZI4m5JipOPUaomKLfH8dh+XsPSv
 fL+d5RThp6PCvGIl8DXx9/+r9vUAtJK8HOTIy4pLk95GrxgHqY+vIOoMuMtjDKgAk
X-Gm-Gg: ASbGncu3AHcxenIln0gGml3zHdLU0+lxmSLUhFzOJs1EuTXsixN+qQll4/pjAmtWbgd
 ynxviI1k4Jgh/MU2YAlttNQvoapW7mUB1DLr6uahBS8be1KWbPf9AbcRIUz8JrGRIjopjCajhBh
 7OsevdBrsnjVfAOo9i+HhkojGQ1mxkpW522dVyJfEolym0Htq8O0Rtvsvsd5vDQ6lsrfdiYznts
 5i2863Hs4ms7mfEzksfnfSZiX9ElNyZSOek4qa6LLgGTUOOZ31XrxRdV4WswIaRDT3R1E1LSIky
 LXAWtRz5vTYVugFuPEnesM4atSCno/6sxz5O4MXdpNk0/PwuowPbaRI7F4KknE4=
X-Received: by 2002:a05:600c:a011:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-4532b9362f6mr17868505e9.27.1749703483245; 
 Wed, 11 Jun 2025 21:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUi2NlWMJ0jWIrKoomr5Jg+iA6/tLyOa0pj46IHuGzs8p4nYuaDH6iazwhng+QmHZ1Kj52dw==
X-Received: by 2002:a05:600c:a011:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-4532b9362f6mr17868435e9.27.1749703482922; 
 Wed, 11 Jun 2025 21:44:42 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net.
 [47.64.115.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e2449f1sm7872215e9.23.2025.06.11.21.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 21:44:42 -0700 (PDT)
Message-ID: <f986cf46-038e-4e83-8ad8-af0aef23e280@redhat.com>
Date: Thu, 12 Jun 2025 06:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] hw/vfio/ap: attribute constructor for
 cfg_chg_events_lock
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250611211252.82107-1-rreyes@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250611211252.82107-1-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/06/2025 23.12, Rorie Reyes wrote:
> Created an attribute constructor for cfg_chg_events_lock for locking
> mechanism when storing event information for an AP configuration change
> event
> 
> Fixes: fd03360215 ("Storing event information for an AP configuration change event")
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 874e0d1eaf..1df4438149 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -52,6 +52,11 @@ static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>   
>   static QemuMutex cfg_chg_events_lock;
>   
> +static void __attribute__((constructor)) vfio_ap_global_init(void)
> +{
> +    qemu_mutex_init(&cfg_chg_events_lock);
> +}

I wonder why we don't have a macro for this yet (there are many other spots 
in the code that initialize a mutex like this).

Anyway, for your patch:
Reviewed-by: Thomas Huth <thuth@redhat.com>


