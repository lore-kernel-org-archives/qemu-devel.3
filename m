Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4AFCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1iR-0001yL-Kx; Mon, 01 Sep 2025 06:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut1iK-0001t8-24
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut1iC-0004c5-87
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756722268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=padtxhQVDuk5yFAuF5m4JoBhkW/oVZxfsd6rmpGL5Mc=;
 b=Xsz7AKlIneL3kgMizViEk9w/QDoejfto2Pd261exkP/XNs+vbUf9ba30cWjzrrbTmbJKWr
 mWxlcShCdNXdKkEVqgpUFYDGTKN+Q7mi0acBSDSUp7WDdBTGIbQQ06pHVpewVXh3jtlPZJ
 EKdMG2Vbzxftj7zSHJc/BAPFRfwnTFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-JacS5zVNNumqY4k2kfwrPg-1; Mon, 01 Sep 2025 06:24:26 -0400
X-MC-Unique: JacS5zVNNumqY4k2kfwrPg-1
X-Mimecast-MFC-AGG-ID: JacS5zVNNumqY4k2kfwrPg_1756722264
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ccfd90630aso1785059f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 03:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756722264; x=1757327064;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=padtxhQVDuk5yFAuF5m4JoBhkW/oVZxfsd6rmpGL5Mc=;
 b=wSY363R9ubHLCMzwItDi5gzZupo3UGPOcMHQnsIcwI2pbNQYNsgUAoQXRy4+3WvDI/
 5j3RGYyIga6k7uDckxyTpQJvvERPLKROVV+jajF2ggOpKIIn9+T4pQePAzSirHOVNxgw
 ZBxt2IFMzshNr9r+Z95XlIcBL1v5H/bE+WYOAIYhdVtbIVenexbsbHS7/+SXcvmRPk5E
 RUDWaFtXbZ+QmSIWq3djsAcy8WutZ5NW/POZYBaANIoVXMxlbcrgErKC5UIAFkF4z7PT
 ERt1Z95RSx3mErb0UWgyJm7Usiot7ZPHqCOTX9g44Ca1w9SyHUOBFc1hlb1fZjFFH1c5
 nF1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/w/zWI3+AvTBXZReGUsn/5a2N+/pszODDqxP9HOb1CW46U9RaGPULx/7qoicTUX6iw6ieXrOjE35z@nongnu.org
X-Gm-Message-State: AOJu0YyA/HuX+tmSQwTJ4V0IkSY+vB1zHguMdRxSpCu5YgSAyfYTYL2C
 VmwPjJnJxnA3tWNlMt7v9ePSC9YjqSjVOIhko5RTONI2czgEOGZW6CWbxGh70cJKhm5O85/5igv
 a/xDnPrYNZWMO2JlnRetgPgawZItG2nCSOMFnhaHVf9WooN1wS3kOBksc
X-Gm-Gg: ASbGnctL9i4uVkF62vb9paYHEb5KsBlCxDNRGTR4JHdWAKxKzloIU04DdFfJpgE3BDP
 z7GJoV14zwY8q0EOyCK7k2eyWv3uGKAIPFN5HUVMd+gr1gW/ddGLwiyPJ54IPgHQ81ZduHluN+0
 xdZOuMJQBUNBSny/5HitqZV20xL/CTIQINGJKmnc1bAemNEJO6rF+8UdX66h+wESyr5q+ImzlRq
 XzcXUQAeLvG/tmBpF+pLrScugCi92ayY5AuHYeuJDsgGtr3M1XBGsZZhCF51U92uERamnpPOMSl
 C2wJu7pgmicisRbr1jc78unzNBk9EcVIwzf7YLbF69zABZ0AMwVuREGodrOzsWVs4LJXz5CClsm
 tdR0=
X-Received: by 2002:a05:6000:1ace:b0:3c6:df53:6968 with SMTP id
 ffacd0b85a97d-3d1dd81caf4mr6088802f8f.13.1756722264223; 
 Mon, 01 Sep 2025 03:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8fSbqC1h6RRAoLZgwSUI9/Al/i8E3918nQ33vrdkaBP8DTSLhBR71pRqdLWfpPqEK25QxGA==
X-Received: by 2002:a05:6000:1ace:b0:3c6:df53:6968 with SMTP id
 ffacd0b85a97d-3d1dd81caf4mr6088779f8f.13.1756722263797; 
 Mon, 01 Sep 2025 03:24:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d48760d1c9sm6924944f8f.17.2025.09.01.03.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 03:24:23 -0700 (PDT)
Message-ID: <c126af74-b502-4b19-b209-858830a62e40@redhat.com>
Date: Mon, 1 Sep 2025 12:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] vfio/pci.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-17-mark.caveayland@nutanix.com>
 <d02ef0f5-3c52-7a8a-dc29-1a8c28e70b50@eik.bme.hu>
 <bc37692f-da9b-44e9-b4db-6ab7edbeaaaf@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <bc37692f-da9b-44e9-b4db-6ab7edbeaaaf@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 8/29/25 13:07, Mark Cave-Ayland wrote:
> On 15/07/2025 14:38, BALATON Zoltan wrote:
> 
>> On Tue, 15 Jul 2025, Mark Cave-Ayland wrote:
>>> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
>>> accessing pdev directly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>> hw/vfio/pci.c | 202 ++++++++++++++++++++++++++++++--------------------
>>> 1 file changed, 120 insertions(+), 82 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 1093b28df7..fb9eb58da5 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -119,6 +119,7 @@ static void vfio_intx_mmap_enable(void *opaque)
>>> static void vfio_intx_interrupt(void *opaque)
>>> {
>>>     VFIOPCIDevice *vdev = opaque;
>>> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>>
>> Don't do that. Opaque data is already type checked when it is registered for the callback and cannot be changed so additional type checking here is just a performance hit without any advantage. It's OK to do it in less frequently called functions but don't add unnecessary casts to functions that can be called a lot.
> 
> In general the QOM casts fall into the noise in a standard profile, but I can see how it could be possible they might show up in the interrupt fast path.
> 
> I'll look at getting a vfio-pci perf test set up here to see if there is a noticeable effect in this case, and if so think about what the best approach is.

Booting with 'pci=nomsi' and running iperf should give some info
on INTx performance.

Thanks,

C.


