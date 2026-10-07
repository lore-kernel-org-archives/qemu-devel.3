Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F6BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbj-0000kt-IL; Wed, 07 Oct 2026 05:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xELSc-0003ma-8y
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xELSX-000596-08
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791355735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gw2HSe5c6Kcz1B1NCu2kK7goeJzmobwy9WQiWk0Ibyw=;
 b=T9+NW4FBtViDdAqRzHCH4FQutITBR7iunbRvVj9H2Z7TliLLu666hywi09/T/uvXXNNSro
 CgUkl4I0G707QTum378CVwMJJ2RNwDmS11Cu1czZmRreIPTPvSIXYO0PVmRoyYUpxZdz1o
 68vpCqqiHD73dAWBnw4ZWzONdK6Y1zA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-9dio_Q0EOWuJRB0l8bTRrA-1; Wed, 07 Oct 2026 02:48:54 -0400
X-MC-Unique: 9dio_Q0EOWuJRB0l8bTRrA-1
X-Mimecast-MFC-AGG-ID: 9dio_Q0EOWuJRB0l8bTRrA_1791355733
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a170fa0879so20267565e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791355733; x=1791960533; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gw2HSe5c6Kcz1B1NCu2kK7goeJzmobwy9WQiWk0Ibyw=;
 b=Cfe1nowQSDjIqVYxUsPZWS/xXdQ80+5Eq21etNJorMmVFZpnaKVvWviYlZqxMsBdab
 gJikjXIx/C+17WVzVf3VedGYZW+zQgCR0PrYjId1YsbvGG9k2EKkvMue1MZOX0t79Lis
 TZk/uGKX6Nm9qAtfYXnYn+d28wy28ug7y5DTibWJgO9dCGIcLZzIm9KTz8irrs8KiYKY
 rXTws6Me6NAWT0zvSz1wbk9UjoNDVm9zO5ZSJtfJC/bh2j6H47CyehMTr8C8wvTGowYP
 Tf0m+/gqhRXb1LliOs7dnZCvSVwnufWzDS38Gr4CVozAhY3VtFNKTtORTKyXTwR5H9Ma
 XRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791355733; x=1791960533;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gw2HSe5c6Kcz1B1NCu2kK7goeJzmobwy9WQiWk0Ibyw=;
 b=GpOpbCImLZNV0K2CUtYm3Pn/FI+NgVz+g+P4JeH5k1vCebev0pfpOGfX5wri6gYjm1
 kYtOkK9LmNUZltu7ECJ5Ny1bNTAidpPfTc5qOEKyM44GWlLt1RXbGelEpWSp+m8OgH+K
 zkR+VLz6BXmYOD0VAGcIethnK64Nz5t73bxbBPyh4rIPB+2pij5Bhm+VW8ntFqnCD13m
 BZmcbjLaapQj7PeL+9fqpWum2dglLNVr24jd8Ol+peJJEWqyhS2ubyEJUEZ4uMpeh2yQ
 d4Rul1DctgsIhkF7ZssJMuHNr3L+KOIUwuk6mfbiMJmOLXQFzWgr5U1p9QwHMjeXaf4K
 ipJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDIMdh0+XMRaRq2iD/RFGPlCMddmw630szEtsdlNe0gBpOwOOJnacT1c8Q0iJVjG2ryviAdH/4vE9H@nongnu.org
X-Gm-Message-State: AFuF++kcebBg6fyJu2uCxINWd4B08qPJUNfwNH+cahVpBTgFS77AJbUq
 +jn3EIp/jrOQsvb9MPWyOIEv3Ucph0BFRDC/aJjW9oMu9C9cxmVchh9ciz2+7/GQ9quM9OWs73d
 y3iX7J6KIcfEKlB6Q+k84y+o+6BTKlreKVOwaL2mvaP6w3gwJPvR7h2KP
X-Gm-Gg: AYBFou2u+KJCeMmU3ri+UlaGtjxdS0/BUGJFwEdCHhYe6+UbGent3KKEOEeZ0U3OXKJ
 0BoCSUGHggNUXMJn35bkVmH3Tsmjs7mUWd5ydYxc8Uz5jodB5+i0pAEmsolveGTFhshoL9A9iCn
 OUtxOzkbzHEXY+ZVZBsPApYG29TJXfQOH0ioAdcv9QKa3ylSoF7FSzLeXkAnXA5ICITrBemMrvw
 X3sgYCUOEJsYhfRDDaW3gsM3RCrdsvLQTKsYU1Mutf7n+uFZM2f36kgM4aHYocIy/CyWn+5OQCA
 G62eLk+wGHS+/hXmUr+Rzc+WkApdXledj4wz7zdEtODK5v9v1PmkyVtx2e2GvEZJnEZlVeIdGHx
 72kGFf0is3tOa7DHZhx8=
X-Received: by 2002:a05:600c:3b2a:b0:49f:cc2a:f73a with SMTP id
 5b1f17b1804b1-4a1806502a2mr15931825e9.25.1791355732861; 
 Tue, 06 Oct 2026 23:48:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:49f:cc2a:f73a with SMTP id
 5b1f17b1804b1-4a1806502a2mr15931455e9.25.1791355732482; 
 Tue, 06 Oct 2026 23:48:52 -0700 (PDT)
Received: from [10.1.38.247] (90-181-163-241.rco.o2.cz. [90.181.163.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a180310c9fsm27732335e9.4.2026.10.06.23.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 23:48:51 -0700 (PDT)
Message-ID: <97a696f4-37e6-4454-a1cc-f9583e3bf44d@redhat.com>
Date: Wed, 7 Oct 2026 08:48:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Error recovery for zPCI passthrough devices
To: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org
References: <20261005174314.871-1-alifm@linux.ibm.com>
 <54ccae64-501d-4f17-b4c5-14eed8d502e8@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <54ccae64-501d-4f17-b4c5-14eed8d502e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/26 23:44, Matthew Rosato wrote:
> On 10/5/26 1:43 PM, Farhan Ali wrote:
>> Hi,
>>
>> This patch series introduces support for error recovery for passthrough PCI
>> devices on System Z (s390x). This is the user space component for the Linux
>> kernel patches [1]. The kernel patches were merged for 7.3 release.
>>
>> The current design for QEMU updates the callback for vfio error notifier to
>> an s390x specific error handler if the kernel supports the new device
>> feature VFIO_DEVICE_FEATURE_ZPCI_ERROR, for s390 vfio-pci devices. So now
>> on an eventfd notification for error notifier it will invoke the s390x
>> specific error handler.  The s390x error handler will retrieve the
>> architecture specific PCI error information and inject the information into
>> the guest. Once the guest receives the error information, the guest drivers
>> will drive the error recovery.  Typically recovery involves a device reset
>> which translate to CLP disable/enable cycle for the device.
>>
>> I would appreciate some feedback on this patch series.
>>
>> Thanks
>> Farhan
> 
> @Eric: Series LGTM at this point, let's give Cédric and/or Alex some
> time to look too.


Looks OK to me. The ERRP_GUARD() is not useful anymore but it is minor.

Thanks,

C.


