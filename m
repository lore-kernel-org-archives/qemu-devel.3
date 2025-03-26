Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93160C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 17:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txURW-0001eY-7h; Wed, 26 Mar 2025 13:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txURT-0001dq-UN; Wed, 26 Mar 2025 13:21:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txURR-00032K-JH; Wed, 26 Mar 2025 13:21:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QH3hHs011342;
 Wed, 26 Mar 2025 17:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bMaGXZ
 hkF7umsd8a1YUjUyYM/Jc0+0rNhjO4+zltAB4=; b=YQb+cKuQYImzW08sOVlPMn
 ALT4az64yolH87DGFVcM66MJQVbrKRU6WN3K0tC6dVzOrXeiaY6sZZElgF/qlgc9
 GbJdgKNglbnxoEHWS6i0NSJvJnLEeoq1L8OwdwEdILgAabXK3hSTlVDb5XBxQ92u
 VevK5CTMVWdhp9q1aO5ntW4UZMYFE3NqWCJsaur1qDL+/KBUEnDhYO6u9gf+wby5
 aLhFe1gWG3aBfzvxDstzgDHx55hvjHP+HYYzPHChFn0xW7hDOGEEVXjgT/Lwn0E8
 vxObwvTOgo3UwojuB7dmEe0RDbS0bWgqP/mj4WI6uCuDM7/GKPIZxYbp7kYQQ85Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3nqn8ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 17:21:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QHLEeQ015452;
 Wed, 26 Mar 2025 17:21:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3nqn8hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 17:21:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QH5DKZ030352;
 Wed, 26 Mar 2025 17:21:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7hthmff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 17:21:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52QHL99T29950482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 17:21:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFB4C2004B;
 Wed, 26 Mar 2025 17:21:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 277CA20040;
 Wed, 26 Mar 2025 17:21:08 +0000 (GMT)
Received: from [9.39.30.126] (unknown [9.39.30.126])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Mar 2025 17:21:07 +0000 (GMT)
Message-ID: <4ef14a73-576b-47c1-b1c0-bc7b234fac87@linux.ibm.com>
Date: Wed, 26 Mar 2025 22:51:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] ppc/pnv: Introduce Power11 PowerNV machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-8-adityag@linux.ibm.com>
 <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
 <8567b41e-f2b8-413c-93b8-15c74788c171@linux.ibm.com>
 <5a08e139-a18d-4aae-836f-0ec0bb8fadc9@kaod.org>
 <6d610966-cdc0-42c2-abb8-e80b4be1178d@linux.ibm.com>
 <6e830dd1-88c1-4029-bae7-d2817d95262f@kaod.org>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <6e830dd1-88c1-4029-bae7-d2817d95262f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: leIALaCp6Gpq-YqRxfL-6zZPXjWKbo3c
X-Proofpoint-GUID: 4eLobgZwx2iFCUaNg445MU8oXJgWD_Au
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=920 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26/03/25 13:39, Cédric Le Goater wrote:

> On 3/25/25 18:38, Aditya Gupta wrote:
>> <...snip...>
>>
>> On 25/03/25 22:45, Cédric Le Goater wrote:
>>> One nice about it IIRC was being able to tune the number of
>>> PHBs per chip, which reduced booting time (for 16s) and also
>>> provided support to test various chip configs. Check that first.
>>>
>> I tried some variations of 'device_add/device_del'. Unable to see how 
>> to dynamically add/remove phbs.
>
> I don't think hotplug works, this would require FW support, only
> coldplug is supported : devices should be defined on the command
> line.


Got it. Thanks for mentioning this, found a bug in my patch:


     $ ./build/qemu-system-ppc64 -nographic -M powernv11 -nodefaults 
-serial mon:stdio -device pnv-phb -device pnv-phb-root-port
     <$QEMU_DIR>/include/hw/ppc/pnv_chip.h:110:PNV10_CHIP: Object 
0x564afddb5e00 is not an instance of type pnv10-chip
     [1]    1253963 IOT instruction (core dumped) 
./build/qemu-system-ppc64 -nographic -M powernv11 -nodefaults -serial  
-devic

Happens due to 'pnv_pec_add_phb' assuming phb5 to be related to pnv10:


     if (phb->version == 4) {
         Pnv9Chip *chip9 = PNV9_CHIP(chip);

         pecs = chip9->pecs;
     } else if (phb->version == 5) {
         Pnv10Chip *chip10 = PNV10_CHIP(chip);

         pecs = chip10->pecs;
     }


Top of my mind, hacky ways come up to differentiate Pnv11Chip and 
Pnv10Chip, other (still hacky) might be to add "pecs" as a property to 
the chip objects and get it that way, still feels hacky.

Can't pass extra args (pecs) to the function, without handling this 
pnv10 vs pnv11 in the callers.


Is adding a callback to PnvChipClass->get_pecs a good idea, similar to 
xive callbacks on the chipclass ?

Will think of alternate ways. Thanks.


>
>>
>> Do you have any options to device_add/del which I can try, I want to 
>> see if the dynamic addition/removal of PHB changes if i remove that 
>> '_allow_dynamic_sysbus_dev' call.
>>
>>
>>> Also, you should add functional tests for the powernv11 machine.
>>>
>>> See under tests/functional/test_ppc64_powernv.py.
>>>
>> Currently the test uses op-build kernels, which don't support 
>> Power11, working on that side, will post as soon as op-build creates 
>> a new release with p11 support (any linux >= 6.9).
>
> And is that planned ? I doubt it since open-power boxes are out
> of business.
>
> You could use a buildroot image instead. :
>
> https://github.com/buildroot/buildroot/blob/master/configs/qemu_ppc64le_powernv8_defconfig
>
I was thinking there should be. I will ask.


Thanks,

- Aditya Gupta

> Thanks,
>
> C.
>

