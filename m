Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E28DCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBD2z-00071Q-Bt; Tue, 21 Oct 2025 10:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBD2w-00070L-HP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBD2s-000155-Sj
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oZLFJTA4cBmcc0Fwy1diMJn+dAnM6uFOpWEbb9FSyF8=;
 b=iP1XEyx/T/Le4dF4I66Xshih/PGCKvIBwGsS3ODyqls6iX3tCrjI78gMro93Vr9XPUpIXI
 iDDbKUyw9PkudLnSrF29Z8bpP3IVBMJ0pUnD713nG7RbuDi7RlB3ALPBpBay49lm1uo2gI
 uvq8RN0FneQcQUqfCu+uw3596M7iSvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-7QdspFbDPvWG7naE_aoViw-1; Tue, 21 Oct 2025 10:08:59 -0400
X-MC-Unique: 7QdspFbDPvWG7naE_aoViw-1
X-Mimecast-MFC-AGG-ID: 7QdspFbDPvWG7naE_aoViw_1761055738
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso30089905e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761055737; x=1761660537;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZLFJTA4cBmcc0Fwy1diMJn+dAnM6uFOpWEbb9FSyF8=;
 b=P4/kNP3lciL/fK0fbjyKELSjLgjrx7Pl/PaGT3CSEpFalDq7NRl7fqGfJjQ/l92iE0
 o0FbsHHM+4K0SjKNLTIrUx2LpPidtaaKyTqREHUNao66g/S4b/Mpj+MJi2NjrPgvm1gk
 9BBUi8KOeLe0wuFyHB8QVwCmUorjY4z9tC+KWIShdaob0n09+mvuVKUusxEXG2EXt8sY
 mLMZlWP8EOdDIbIIyMfr4GbQFr0/gr2YLV2GjdZ5dNKMNei/AXNFHBl5tclI6007Ru4y
 05JOy6ANJBjocHkL/Sh2DavYajgBz/RD7Gglq57Z61i8wxqRP+Xuy27UufAkhPVjgAwz
 7uJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNfhzn8Ey3lrPQ6eNpzXqaVTBxVq6hMc30Hs0PY3zqM09WyxXM22fQzmevLKDTFhEOk7tDk3zL4Jbe@nongnu.org
X-Gm-Message-State: AOJu0Yyc+aZB9wZ9eSh9TQt0RsLP1LnV86suHNu/GNlF+LXCFRBgbYED
 iFbCjgdG7X7p7UD3j6UFHSl8EO00aysJ5PdHCnEgz5JVddhh+vXYrrjTXxLCEk+7L+p8954Ftkh
 6TCRB9yFQWea3hnDKCMjWrvZVurTVT5vWyXDckboQNFr1Fc92FrkI+emN
X-Gm-Gg: ASbGncvB8EJqcFlAzKS51anoSrLLoLtyONwBLm4S8jQKvvA/6bL2xJLq9SxltI8uiKb
 vElOstXOvybJzhalLWflPJNCOtDMLqErt/StJ7JZNGTtMykOwZqS7nHXGbJ0d2QP9+HeSIK2WxC
 iNZOR/42x3OJ8Uw0kyc32nexlw5XE9Uk3vEKwFHjoeZCjFu8OTOw45mPs2jqYbr6Lc8R+yXEGo3
 aKYJ9fg2aAtQynBzA6WVX7aQcfTBkRTOe50HBuUmVoBZsZ/0Ujap6VefnSxDXxuZt4iNmOzjJQJ
 4he3J2kFpDib5Zm7xO0J5yVWPhGU9QLCQ9b7cP0LRA1sWcTLZvXZKRevVKZIukNW6viKs8cbbN3
 ABRc8wYnxVIzf7AYlUuq6arbV
X-Received: by 2002:a05:600c:8719:b0:46e:711c:efe9 with SMTP id
 5b1f17b1804b1-475c3d9de79mr61295e9.13.1761055737398; 
 Tue, 21 Oct 2025 07:08:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCNfbrpktdLsySHOP/K3ZQDsmCIQNEuXG+yXrpZ4DxcJFfUeSv5GY1oqgqzANOOYSY/WyxQ==
X-Received: by 2002:a05:600c:8719:b0:46e:711c:efe9 with SMTP id
 5b1f17b1804b1-475c3d9de79mr61105e9.13.1761055737028; 
 Tue, 21 Oct 2025 07:08:57 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144238easm290959385e9.4.2025.10.21.07.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 07:08:56 -0700 (PDT)
Message-ID: <2fe7ce6a-9e48-46f8-a91c-a2690b41f260@redhat.com>
Date: Tue, 21 Oct 2025 16:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] s390x: Build IPLB for virtio-pci devices
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-7-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020162023.3649165-7-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Search for a corresponding S390PCIBusDevice and build an IPLB if a device has
> been indexed for boot but does not identify as a CCW device,
> 
> PCI devices are not yet included in boot probing (they must have a boot index).
> Per-device loadparm is not yet supported for PCI devices.

Could you add it? Something similar to what has been done in 
scsi_property_add_specifics() in hw/scsi/scsi-disk.c for the SCSI disks?

...
> @@ -346,7 +349,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>   static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>   {
>       CcwDevice *ccw_dev = NULL;
> -    int tmp_dt = CCW_DEVTYPE_NONE;
> +    int tmp_dt = S390_DEVTYPE_NONE;
>   
>       if (dev_st) {
>           VirtIONet *virtio_net_dev = (VirtIONet *)
> @@ -393,6 +396,31 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>       return ccw_dev;
>   }
>   
> +#define PCI_DEVTYPE_VIRTIO       0x05

Is this for virtio-block only ? If so, I'd maybe rather name it 
PCI_DEVTYPE_VIRTIO_BLK or so. Or will this be used for virtio-scsi-pci etc., 
too?

  Thomas


