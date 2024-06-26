Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5425C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 03:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMJly-0004lL-5q; Tue, 25 Jun 2024 23:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sMJlr-0004j5-Ny; Tue, 25 Jun 2024 23:56:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sMJlo-0001BR-8o; Tue, 25 Jun 2024 23:56:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q3tEra032369;
 Wed, 26 Jun 2024 03:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 y3CtWwmYVSUFX9bmpC8t3+/76GfqGLNk28TQLOnoQvQ=; b=TDEdPv+hE07v2ad9
 BIGPxXZPYS+/Lyi/vNrybi9sWl9guJ9tiDo5miVH+VIQTzTJmWoMn/JhsRa+b6zU
 tvetR5kB3ii9vEiCCzlG6D4JHk7XvWRQwd11XtpQMr+oWd74i1dYfi74LpXQsTNs
 dpzTUP6lnW9Hb94Fiw5kVQBZgOFULEFS+a9rTHwcGpiuT0jkDgpbMVd7tSfaxW3z
 Pcl2u53lt0KtaQh1U50oipBHkztsjHxqKbPV2+w5X3IjSaBxGAF9gqsk2ECfpf4j
 lIc+K/tNSoWR7JD2q67G2xEpo6vsy66fvtryMojjBf72aIQEBVW5lz4xqhJ8C0ec
 aCwUQw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4009str6qr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 03:56:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q3uPZ0001257;
 Wed, 26 Jun 2024 03:56:25 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4009str6qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 03:56:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45Q2uHTc032606; Wed, 26 Jun 2024 03:56:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn39qgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 03:56:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45Q3uKkM54526316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 03:56:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B44820043;
 Wed, 26 Jun 2024 03:56:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70E522004B;
 Wed, 26 Jun 2024 03:56:18 +0000 (GMT)
Received: from [9.124.217.74] (unknown [9.124.217.74])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2024 03:56:18 +0000 (GMT)
Message-ID: <65126343-344e-47a0-bf63-7df43b0051ca@linux.ibm.com>
Date: Wed, 26 Jun 2024 09:26:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, harshpb@linux.ibm.com, 
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 zhenzhong.duan@intel.com, qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
 <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
 <ba376f81-2175-4e3d-bda0-4b08b2ae5158@redhat.com>
 <7b553db9-4d29-4cfe-8874-3c87ad862c74@linux.ibm.com>
 <449a8a0a-6149-45af-bfa0-bf7fb29e27c6@redhat.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <449a8a0a-6149-45af-bfa0-bf7fb29e27c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x5JjgMMMPGGQ64F7Llq5a5qmoT-HJDy5
X-Proofpoint-GUID: 4UBSX0fGImu9Qc25tzwvf3p0mlJE_4lX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_01,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260029
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 6/21/24 8:40 PM, Cédric Le Goater wrote:
> On 6/21/24 4:47 PM, Shivaprasad G Bhat wrote:
>>
>> On 6/21/24 2:19 PM, Cédric Le Goater wrote:
>>>
>>> Could you please describe the host/guest OS, hypervisor, processor
>>> and adapter ?
>>>
>> Here is the environment info,
>>
>>
>> pSeries:
>>
>> Host : Power10 PowerVM  Lpar
>>
>> Kernel: Upstream 6.10.0-rc4 + VFIO fixes posted at 
>> 171810893836.1721.2640631616827396553.stgit@linux.ibm.com
>
> Great. You should report there too and probably send a PR to Alex to
> contribute your changes to the vfio tests.

Could you clarify which tree you are referring to ? I see his tree

https://github.com/awilliam/tests is bit old and updated recently, however

I have been using those tests for my unit testing.


>
>> Hypervisor : KVM on PowerVM & 
>
> OK. So, this is using the newer nested v2 implementation.

Yes. However, this was working for userspace before too with limitations

like DMA windows were being borrowed, and no customization

of window size etc.


> With the
> legacy XICS IRQ controller or XIVE ? in-kernel device or emulated ?

Emulated XIVE.

>
>> also tried without KVM using TCG
>
> Ah nice. Good to know that real HW passthrough works in TCG also.
>
>> Guest : 6.8.5-301.fc40.ppc64le Fedora 40 distro kernel
>>
>> Adapter: Non-Volatile memory controller: Samsung Electronics Co Ltd 
>> NVMe SSD Controller PM173X
>>
>> PowerNV:
>>
>> Host: Power9 Baremetal
>>
>> Kernel: kernel-core-6.9.4-200 - Fedora 40 distro kernel
>
> Is there a requirement on the kernel version ? Would an older debian
> 6.1 work for instance ?

This went through cycles of breakage and fixes. It worked on 5.18(not sure

about older ones before that), and broke afterwards. Recently fixed

and working from 6.4, broken on 6.7. Fixed and working in 6.8

onwards now.


>
>> Hypervisor: KVM
>>
>> Guest : 6.8.5-301.fc40.ppc64le - Fedora 40 distro kernel
>>
>> Adapter: Non-Volatile memory controller: Samsung Electronics Co Ltd 
>> NVMe SSD Controller PM173X
>
> Nice. XIVE I suppose. 

Yes.


> What about TCG ?

Yes, TCG too works, missed to mention.


Thanks,

Shivaprasad

> Thanks a lot,
>
> C.
>

