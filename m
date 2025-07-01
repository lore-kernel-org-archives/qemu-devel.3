Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A5C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUb8-00035w-UY; Tue, 01 Jul 2025 02:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUb6-00034t-Pa
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUb1-0002dA-Eh
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751351757;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEAXJZgTb2fievGW6M0Ej3NJhxsSWJzOazjMlpWKRlI=;
 b=Klbofnt0Sj44qX+MXUbsqQHPFAUJQ+2kRM8zkgaS2zsZbZwGSV+2LN/YSgEQK5ZkNgOHMV
 rVGYIo+LtadPc7GfaeS8UpQEG8wRSzNdodUHvZIRlwtsR4FAVAyDxxAxc6uyOtjpSikoGI
 U/PYCQO+uPPD6SgW0BLVQBuY41GAre4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-N30ruBleOUq6nHC2e4tgbw-1; Tue, 01 Jul 2025 02:35:55 -0400
X-MC-Unique: N30ruBleOUq6nHC2e4tgbw-1
X-Mimecast-MFC-AGG-ID: N30ruBleOUq6nHC2e4tgbw_1751351755
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1011402f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 23:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751351754; x=1751956554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEAXJZgTb2fievGW6M0Ej3NJhxsSWJzOazjMlpWKRlI=;
 b=jGWhJ8vsh7m7b1YTrnR8FhvhGj9cISD2Go7xjk6fLRTt2IEAGr9QEwpkXqDdbl0Xy4
 XV2p2f+OGanI8Wik29gbEyM+iKwmduo1nCmyYQMhHvqpsYZUFdSrYR0pnlQKUEHL6dFO
 GCRZ7qMxLnHSf6lFcqzupfiqZvwtJQk8hVHJHefq360YN6tgIMXl2KDzpGo7rvLmL9Vl
 JgKSVZFR0K+izGcgosxLPCl19Gna8GiLfZvMW2cIfkbx8yfv4cFUUYQcFPmfLEB83L7i
 /JkvEA7PIM3KhX6X4j2XkN9RqNGL/VkkzS3juWRm6k5veNSyhFQLvqoYFbDcLPKIERfB
 w3yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK0UxUuTCakb762ipvK0FmjUzzktPIB5H1LvwHOC1+o0cuIo5V02Yu25HSzxDtm1Mh6At/kC7K/yab@nongnu.org
X-Gm-Message-State: AOJu0YyVqvChbu1USkpGI/+BEnh9MKrkwM2HIMgPfLt3HIim8auOXfPH
 MzPTcXrbzp17szLWtTE/lTGbIxLmCv6HU2Oz7wrQMoLhHgZKxlwQwna6evbaNdYLPvw5astqh3y
 bJdbytMaalwtpf9rGgel+2y+qzTcuLalHNclfZILjNuUpXQcxPoTEWk5z
X-Gm-Gg: ASbGncs/o/+NqJh73BhUBUvEjUYoHtnH7KBEjDceSEhY1FBEVwiFaxvTQQfSmH3YiIp
 K84eeDflF2VqKILQyFMmiGpZTPAKn6jAARwtx3oRLyDygvXdpUiO6oV1S8Xp649E+ft+FR4Xlxj
 4CRTAO9Ghu/ufyCVK2TkUSI98KG7md9XNVeWYXPPlTHb9YfkxHdKIAQZjCEom1vZCvD1EKPPT1h
 SOLdNzzQV28oINTRT+2CNO+SCAh++EHQZszgcs0A9bcmmAHRZ9AeYuP6Vm6AjreTG0FEEBwRnhU
 LofzMFXI220x8r+KcnUiYQY+BzMnnmFo8gcFTabMoAkJvrVVQMQJoCKmav+26/ow4361cA==
X-Received: by 2002:a05:6000:4211:b0:3a4:ff01:218a with SMTP id
 ffacd0b85a97d-3a90038ba79mr12310679f8f.50.1751351754547; 
 Mon, 30 Jun 2025 23:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNMPO1sDt+f0bjFZ0PY5Vow9U1WhNyA1Ozd2O1bCO37a49RMXzuMiCiRY3ez0+I2eu2oKjYQ==
X-Received: by 2002:a05:6000:4211:b0:3a4:ff01:218a with SMTP id
 ffacd0b85a97d-3a90038ba79mr12310642f8f.50.1751351754086; 
 Mon, 30 Jun 2025 23:35:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ac6ee0d0b9sm6601661f8f.18.2025.06.30.23.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 23:35:53 -0700 (PDT)
Message-ID: <e8fa6035-4130-4a68-922a-67028e470bfa@redhat.com>
Date: Tue, 1 Jul 2025 08:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] qtest/bios-tables-test: Update tables for smmuv3
 tests
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-12-shameerali.kolothum.thodi@huawei.com>
 <43abd1f9-0b5d-4824-82a5-dcce5b323749@redhat.com>
 <690db58e248a46dd83c641b9ec4ac616@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <690db58e248a46dd83c641b9ec4ac616@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/30/25 9:11 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Friday, June 27, 2025 1:36 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; imammedo@redhat.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
>> gustavo.romero@linaro.org; Linuxarm <linuxarm@huawei.com>; Wangzhou
>> (B) <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v5 11/11] qtest/bios-tables-test: Update tables for
>> smmuv3 tests
>>
>> Hi Shameer,
>>
>> On 6/23/25 11:42 AM, Shameer Kolothum wrote:
>>> For the legacy smmuv3 test case, IORT has a single SMMUV3 node and a
>>> Root Complex node with three ID mappings of which two points to the
>>> SMMUv3 node and the remaining one points to ITS.
>> You don't describe DSDT at all below, just IORT. I don't know whether it is
>> mandated though
> I don't think DSDT is required as the code changes we want to test is
> IORT related only.

OK. Then I would add in the commit msg the DSDT is not impacted by the
way the SMMU is instantiated.

Thanks

Eric
>
>>> ...
>>> [030h 0048   1]                         Type : 00
>>> [031h 0049   2]                       Length : 0018
>>> [033h 0051   1]                     Revision : 01
>>> [034h 0052   4]                   Identifier : 00000000
>>> [038h 0056   4]                Mapping Count : 00000000
>>> [03Ch 0060   4]               Mapping Offset : 00000000
>>>
>>> [040h 0064   4]                     ItsCount : 00000001
>>> [044h 0068   4]                  Identifiers : 00000000
>>>
>>> [048h 0072   1]                         Type : 04
>>> [049h 0073   2]                       Length : 0058
>>> [04Bh 0075   1]                     Revision : 04
>>> [04Ch 0076   4]                   Identifier : 00000001
>>> [050h 0080   4]                Mapping Count : 00000001
>>> [054h 0084   4]               Mapping Offset : 00000044
>>>
>>> [058h 0088   8]                 Base Address : 0000000009050000
>>> [060h 0096   4]        Flags (decoded below) : 00000001
>>>                              COHACC Override : 1
>>>                                HTTU Override : 0
>>>                       Proximity Domain Valid : 0
>>> [064h 0100   4]                     Reserved : 00000000
>>> [068h 0104   8]                VATOS Address : 0000000000000000
>>> [070h 0112   4]                        Model : 00000000
>>> [074h 0116   4]                   Event GSIV : 0000006A
>>> [078h 0120   4]                     PRI GSIV : 0000006B
>>> [07Ch 0124   4]                    GERR GSIV : 0000006D
>>> [080h 0128   4]                    Sync GSIV : 0000006C
>>> [084h 0132   4]             Proximity Domain : 00000000
>>> [088h 0136   4]      Device ID Mapping Index : 00000000
>>>
>>> [08Ch 0140   4]                   Input base : 00000000
>>> [090h 0144   4]                     ID Count : 0000FFFF
>>> [094h 0148   4]                  Output Base : 00000000
>>> [098h 0152   4]             Output Reference : 00000030
>>> [09Ch 0156   4]        Flags (decoded below) : 00000000
>>>                               Single Mapping : 0
>>>
>>> [0A0h 0160   1]                         Type : 02
>>> [0A1h 0161   2]                       Length : 0074
>>> [0A3h 0163   1]                     Revision : 03
>>> [0A4h 0164   4]                   Identifier : 00000002
>>> [0A8h 0168   4]                Mapping Count : 00000004
>>> [0ACh 0172   4]               Mapping Offset : 00000024
>>>
>>> [0B0h 0176   8]            Memory Properties : [IORT Memory Access
>> Properties]
>>> [0B0h 0176   4]              Cache Coherency : 00000001
>>> [0B4h 0180   1]        Hints (decoded below) : 00
>>>                                    Transient : 0
>>>                               Write Allocate : 0
>>>                                Read Allocate : 0
>>>                                     Override : 0
>>> [0B5h 0181   2]                     Reserved : 0000
>>> [0B7h 0183   1] Memory Flags (decoded below) : 03
>>>                                    Coherency : 1
>>>                             Device Attribute : 1
>>> [0B8h 0184   4]                ATS Attribute : 00000000
>>> [0BCh 0188   4]           PCI Segment Number : 00000000
>>> [0C0h 0192   1]            Memory Size Limit : 40
>>> [0C1h 0193   2]           PASID Capabilities : 0000
>>> [0C3h 0195   1]                     Reserved : 00
>>>
>>> [0C4h 0196   4]                   Input base : 00000000
>>> [0C8h 0200   4]                     ID Count : 000001FF
>>> [0CCh 0204   4]                  Output Base : 00000000
>>> [0D0h 0208   4]             Output Reference : 00000048
>>> [0D4h 0212   4]        Flags (decoded below) : 00000000
>>>                               Single Mapping : 0
>>>
>>> [0D8h 0216   4]                   Input base : 00001000
>>> [0DCh 0220   4]                     ID Count : 000000FF
>>> [0E0h 0224   4]                  Output Base : 00001000
>>> [0E4h 0228   4]             Output Reference : 00000048
>>> [0E8h 0232   4]        Flags (decoded below) : 00000000
>>>                               Single Mapping : 0
>>>
>>> [0ECh 0236   4]                   Input base : 00000200
>>> [0F0h 0240   4]                     ID Count : 00000DFF
>>> [0F4h 0244   4]                  Output Base : 00000200
>>> [0F8h 0248   4]             Output Reference : 00000030
>>> [0FCh 0252   4]        Flags (decoded below) : 00000000
>>>                               Single Mapping : 0
>>>
>>> [100h 0256   4]                   Input base : 00001100
>>> [104h 0260   4]                     ID Count : 0000EEFF
>>> [108h 0264   4]                  Output Base : 00001100
>>> [10Ch 0268   4]             Output Reference : 00000030
>>> [110h 0272   4]        Flags (decoded below) : 00000000
>>>                               Single Mapping : 0
>>>
>>> For the smmuv3-dev test case, IORT has two SMMUV3 nodes and a Root
>>> Complex node with ID mappings of which two points to two different
>>> SMMUv3 nodes and remianining ones pointing
>> remaining. Still difficult to parse for me ;-)
> Ok 😊. I will rephrase as suggested in the previous one.
>
> Thanks,
> Shameer


