Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CABCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXMt-0001z9-Hg; Fri, 19 Sep 2025 05:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzXMb-0001wu-Bb
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzXMT-0008CY-KG
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758273896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PXFw3uShH4U+BL+W34BoRWty4Z8Xo7M93f3yFLOSdsA=;
 b=GmO1xi5imd5QwhZYjD/E/Cv+lVqRWtddMB8o7ecR4iKpY+eoA2iYCpZ4q29X7i2qPc7Jmw
 PqS52HHnle75p4DoyLKa+WE4VORWQQLMHV6V7gnBTFYHIQOa6B9Uzv/9A972r8dtP7brqv
 8Epls6FYiDgBkknpYK0P8N+2i/KrMaw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-N1H9uOp6Nb6C7_lbf8VK4g-1; Fri, 19 Sep 2025 05:24:54 -0400
X-MC-Unique: N1H9uOp6Nb6C7_lbf8VK4g-1
X-Mimecast-MFC-AGG-ID: N1H9uOp6Nb6C7_lbf8VK4g_1758273893
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45f2b0eba08so11643115e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758273893; x=1758878693;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXFw3uShH4U+BL+W34BoRWty4Z8Xo7M93f3yFLOSdsA=;
 b=CvNzMe73k97aXB/m5AWYHW4q0JuZGsnuh/45KymLp08h2QGzxKnItYgUBEcfh1U0kx
 IMUhj4bAMLwm0exX6/D5HRudZjmzoK9gYZ5zznNyfyfea0NM+9vgBprUFyNaElkV2OO6
 Root3oBmQH2H+b5MPNCo4kmtHc7ICGFoDEJ5T7fC5Z0h/tbAvZhYmLYjlSM95QMOi/+b
 Uf+B6vno56HSUD1RK4ChaJgTPq5oH3xs1Gup2V6Wk37gtIJBTaLoxyRn/FJDVrxSLz2+
 kHvlnIuRW3i/+2yeebhqyUk3KoNLTND+MgtbrsywdyrHsQfbvgb+fq4tVPA7i70t1Ele
 ze8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrWqSQDvsU/KKsoI4W4YLflrNvAEfT8D56fniaBOtDwd9gJcbkKG/m8vQwEq7j7IdIfxgbluU8qhdo@nongnu.org
X-Gm-Message-State: AOJu0YxsdgVSUvzUx7xvE8/zIquFHz3BC+OxY4UUMAGNbmHfpcAPMMnn
 UCOW/kLee6l4Iqwkz3UGT8m9xSdFX4igmdMK3iGnYXVvPSWh4le1WGI8fl6mq7F87c8ZBntSNiK
 6s3o/JFrU3ktULSR7lqJljpdReT14YTD1Mkf+7qiD7WDn0G4qMdmB6k5H
X-Gm-Gg: ASbGncuBOMh65ISJM/MYoOX97orUb5caob6TyXl8S6XxFr68ulAgCeT7hxqCVc4hlj9
 fVUHcSyBOHxtrFrus+vbjeX2XBhxaSdMCReCLELcpPtHMo4DUJg+QVGBWYneCELs8EDcxftPlnC
 cQLyxGyqtlOzXlXkS6HPruwQwXLvvGZCZjFsYgjnu9jdIudLDH7HxWJxnqg3N2pi0UIQ5hRMNFD
 7Heksrq98NqKCD6zMMEUBy70wOoYWfUmW9zt+h+qt32wuUXE83Q6WMx8Uj0CL35Cd1ixbAl00uH
 4VutC+dbPczUO9rBqIZ9cyf+t56mr4dUG5JRKqjyZFuuV8+StX/vJg46RN0AQO1BV3jSwUcEpTi
 UPPg=
X-Received: by 2002:a05:600c:4fc3:b0:45d:e285:c4d7 with SMTP id
 5b1f17b1804b1-467e7f7d3f4mr21290225e9.9.1758273893165; 
 Fri, 19 Sep 2025 02:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6XEK51e6tug0cGBgGAWrGnKiqdnVa8N9J1a0t+uOKc2aX54Nl5MSt1xhhd8BOL5RcquuHQg==
X-Received: by 2002:a05:600c:4fc3:b0:45d:e285:c4d7 with SMTP id
 5b1f17b1804b1-467e7f7d3f4mr21289965e9.9.1758273892745; 
 Fri, 19 Sep 2025 02:24:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f1549285c9sm391630f8f.52.2025.09.19.02.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 02:24:52 -0700 (PDT)
Message-ID: <8019c941-e67d-4288-bb75-ff18a917464a@redhat.com>
Date: Fri, 19 Sep 2025 11:24:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PATCH] vfio/common: Work around kernel overflow bug
 in DMA unmap
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <154707542737.22183.7160770678781819267.stgit@gimli.home>
 <cd287f5c-796e-4172-9537-b00991a95391@redhat.com> <aMx8T5-u6Uj64Vgx@x1.local>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aMx8T5-u6Uj64Vgx@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/25 23:40, Peter Xu wrote:
> On Thu, Sep 18, 2025 at 10:55:47PM +0200, Cédric Le Goater wrote:
>> Alex, Peter,
>>
>> On 1/10/19 00:10, Alex Williamson wrote:
>>> A kernel bug was introduced in v4.15 via commit 71a7d3d78e3c which
>>> adds a test for address space wrap-around in the vfio DMA unmap path.
>>> Unfortunately due to overflow, the kernel detects an unmap of the last
>>> page in the 64-bit address space as a wrap-around.  In QEMU, a Q35
>>> guest with VT-d emulation and guest IOMMU enabled will attempt to make
>>> such an unmap request during VM system reset, triggering an error:
>>>
>>>     qemu-kvm: VFIO_UNMAP_DMA: -22
>>>     qemu-kvm: vfio_dma_unmap(0x561f059948f0, 0xfef00000, 0xffffffff01100000) = -22 (Invalid argument)
>>>
>>> Here the IOVA start address (0xfef00000) and the size parameter
>>> (0xffffffff01100000) add to exactly 2^64, triggering the bug.  A
>>> kernel fix is queued for the Linux v5.0 release to address this.
>>>
>>> This patch implements a workaround to retry the unmap, excluding the
>>> final page of the range when we detect an unmap failing which matches
>>> the requirements for this issue.  This is expected to be a safe and
>>> complete workaround as the VT-d address space does not extend to the
>>> full 64-bit space and therefore the last page should never be mapped.
>>>
>>> This workaround can be removed once all kernels with this bug are
>>> sufficiently deprecated.
>>
>> Have we waited long enough ? what does "sufficiently deprecated" mean ?
>> Is it related to the linux stable updates ?
> 
> Alex might be the best to define it.
> 
> To me, it doesn't sound a major issue to have it even forever just in case
> someone was using a broken v4.15..v5.0 kernel.  It's pretty small, limited
> and self contained workaround.

So it seems it is not that useful anymore for upstream kernels
and downstream should have done the required backports.

> Any blockers on this?
No.

If we could remove the workaround in QEMU, we would be able to
refactor some of the code unmapping DMAs to make it common
between the VFIO IOMMU Type1 and IOMMUFD backends.


Thanks,

C.



