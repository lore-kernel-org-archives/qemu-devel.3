Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD441D6101C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlT61-00030R-E2; Thu, 29 Jan 2026 09:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlT60-0002ya-AW
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlT5y-00027R-Q2
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769697246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9mlY1msb6dy2PbzWNVBoK0DrtsspTlrODhqVr18Pcas=;
 b=EpqE8W/cgMRutFZ7THg4ZosfqY9h2dtMIgdoppoX06gnfzW6A+AvRjmWr6KahUyHt9WT1t
 szXBfqe+KvDD2mSsrSQDQRT9UbMdxGJbO23D7IiUTEZez6vxPsFYN2kvGHfmGudy1J896n
 EvbXLiDwohPDpiNz2NCmqu/dHv/QuAw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-DODyfYgkP_yBh1UoegDMKg-1; Thu, 29 Jan 2026 09:34:04 -0500
X-MC-Unique: DODyfYgkP_yBh1UoegDMKg-1
X-Mimecast-MFC-AGG-ID: DODyfYgkP_yBh1UoegDMKg_1769697243
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4804157a3c9so13607725e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769697243; x=1770302043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9mlY1msb6dy2PbzWNVBoK0DrtsspTlrODhqVr18Pcas=;
 b=eqWP3eo73U+zYJIhacntb0BcSgF3audPfGp+EX7+HMzEfDZf9klA1UIi6Ir1Q1Td9U
 cdzNWpfpIk5C6573IwCrWFkNpQqDId8rcIpjrt9MeW2BySv5fRnTlNihxq4DXq2CKSLr
 iLtW/FRItQPTEmRMRSM/uXO+giq3mKIIqk6OshcEhuOQW82MwvtzL3JQffFd4aOPt7/W
 R6T9P6VFZTKVS7giV/4hcay/PIvCHV/2YKUT0FJeqliISXnGuuDKzQ+uwhiZoFRiIoIm
 3PoSOo9J4FFUaPnPqnzx20y0fULgnMJvdW9x5a+Y9J+erJOHbpHLTXXn3J24FjK7Ieor
 SbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769697243; x=1770302043;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9mlY1msb6dy2PbzWNVBoK0DrtsspTlrODhqVr18Pcas=;
 b=rwOT4mTEUJPvODySlns3PvHO7trGdDnhI7fLm0Orm4nujqc5j+AdfqNRo3YzsBWgjS
 BW5CRSRzB/DcJXN8SKzKJollMsVmazCeWqpiypsr6KGtdHDPpxC+aRHAMnzAzNV8Gf5P
 f9YfAHM0igaKA/VCB43TQ2In4wHezMCEQS7RDK8NDGxRaSCH2U/RWQ2sDSIVAtUl9I6q
 MWXR+HxpltZWma4pF9467kpy0xaZ8htVO5aBh+ZRUtaRl6MSs/M4cZNd/RKbgRCOp0Pk
 1pCMHWvPsfHhUcw0O1aX4eXuyXglSZZiUWcTOMAqeQ/XFMVCENT1LXR4PyuFwK366aNW
 Ecjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqvlxFZ+DhNDHmPXsdDV28Z0ve09fgByh8UgmC+ssUlcF5E3p/1yu+VcpHus0xLgk3lbD/k6y1FPjj@nongnu.org
X-Gm-Message-State: AOJu0YxD0SENFz5czQHilL6ZLWpS9ctEbV8BMwHkp2rMO6E+32ziX/GK
 EGnE35IxN786B0H7WbAUNwR1+FUj0E9IkT0+dPUAsmMowq+D0ytd6SDsR8rweS8A602xvDFaHQZ
 bJLXpKRUxo61lEUU0zSRXu9RROgCkgholf1sXRBsXLneS3Sqh3j1O5HqW
X-Gm-Gg: AZuq6aI0IH7HAlVaf2bnydidCSClfcYlaORXGvEeoIFl6dZFxEF2FM3EYmBB1ykN4iR
 oUoXdnsF5juctkj+lc5pZdZ0zKpSdBLgs5AT/5Zxa2G8/s7FLYQAmAwgPZt9QxnkP3Z669agIl7
 vd/kGqbjRgVVCpYEy9C9CgUh44qPW6okWh6IzPWwrON2IyAjY/+jq1EFkHWt7J9wmO7t3LlHwjI
 Xe/PJ3mMdSSltLE5qe6ETg3ib/XwmqQl1C63HfrIvGQ6F3IPUrKIrjgLLqMWjr1nd8ylh0saHyH
 TNuBsaino2GOYhN08rsXpmEWqALvH7ySFwFa3y7d229KlZk4jh9v8Y7LCh2Zta78Gk7WJfU1LV3
 SZCaJ2u8=
X-Received: by 2002:a05:600d:8445:20b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-48069c54b8bmr92379625e9.21.1769697243249; 
 Thu, 29 Jan 2026 06:34:03 -0800 (PST)
X-Received: by 2002:a05:600d:8445:20b0:47d:3ffa:5f03 with SMTP id
 5b1f17b1804b1-48069c54b8bmr92379335e9.21.1769697242872; 
 Thu, 29 Jan 2026 06:34:02 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5dddb2asm5639195e9.8.2026.01.29.06.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 06:34:02 -0800 (PST)
Message-ID: <463b1607-fb5c-443b-8e2e-1540a354c7fb@redhat.com>
Date: Thu, 29 Jan 2026 15:34:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] s390x: Add definitions for PCI IPL type
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-9-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define a new PBT code and IPLB layout in preperation for supporting PCI device
> IPL on s390x.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/qipl.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 6dc12dd859..8d3c83a80b 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -23,6 +23,7 @@
>   enum S390IplType {
>       S390_IPL_TYPE_FCP = 0x00,
>       S390_IPL_TYPE_CCW = 0x02,
> +    S390_IPL_TYPE_PCI = 0x04,
>       S390_IPL_TYPE_PV = 0x05,
>       S390_IPL_TYPE_QEMU_SCSI = 0xff
>   };
> @@ -108,6 +109,14 @@ struct IplBlockQemuScsi {
>   } QEMU_PACKED;
>   typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>   
> +struct IplBlockPci {
> +    uint32_t reserved0[76];
> +    uint8_t  opt;
> +    uint8_t  reserved1[3];
> +    uint32_t fid;
> +} QEMU_PACKED;
> +typedef struct IplBlockPci IplBlockPci;
> +
>   union IplParameterBlock {
>       struct {
>           uint32_t len;
> @@ -123,6 +132,7 @@ union IplParameterBlock {
>               IplBlockFcp fcp;
>               IPLBlockPV pv;
>               IplBlockQemuScsi scsi;
> +            IplBlockPci pci;
>           };
>       } QEMU_PACKED;
>       struct {

Reviewed-by: Thomas Huth <thuth@redhat.com>


