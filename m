Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928A6C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZTD-0006F8-3L; Fri, 21 Jun 2024 04:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sKZTB-0006Ee-7e; Fri, 21 Jun 2024 04:18:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sKZT9-00029w-4t; Fri, 21 Jun 2024 04:18:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L6T2o4021288;
 Fri, 21 Jun 2024 08:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 eMDQpIRQ6U4mikxtmiffxSdtAKb9Mxngrxgp8Lc0sVY=; b=km/3M5/cvQTHIcrO
 ee9eUsDOW+4L1VxJAoXizIK7yayGBv6crKStqIkEwJZANSt7fSvjM3lcGjX5fQ5Z
 GcLKxLFxV8sTGXS/t2cSINJc9EVcg0+ZpwEzIXh0iJuK9LBigPwcJQ9dY2nhCzNS
 cpKGQOh7i3g5NNJ4dACikvi58J54MCmJf2N1cACflsJEK7IZo5DuCRMxS6EspOXm
 IvWPw/mSMATojdnMVGvbm10UUyFBue7R/0H/geceZ/3YPN/N4mafRJBR2uuNI+OJ
 6s8OxYDxYqOLJlivjvniLCz08iYI8GCq5nbXJOf8vgthqSu3GChO19/PqBsgWHJj
 T+q5fQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw49k08fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 08:17:55 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45L8HtJ0022714;
 Fri, 21 Jun 2024 08:17:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw49k08ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 08:17:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45L7N0Sl030990; Fri, 21 Jun 2024 08:17:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yvrssws81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 08:17:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45L8Ho2b48890294
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 08:17:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 554A420043;
 Fri, 21 Jun 2024 08:17:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57FB820040;
 Fri, 21 Jun 2024 08:17:47 +0000 (GMT)
Received: from [9.195.33.84] (unknown [9.195.33.84])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2024 08:17:47 +0000 (GMT)
Message-ID: <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
Date: Fri, 21 Jun 2024 13:47:45 +0530
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
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dwP6vjZwPMUClTpkIwd2IewkPG5-MBf9
X-Proofpoint-ORIG-GUID: ezCO1fWh8ZFMox4dizS8UP7d0eMrYwVt
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_02,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Cédric,

On 6/20/24 6:37 PM, Cédric Le Goater wrote:
> Shivaprasad,
>
> On 5/9/24 9:14 PM, Shivaprasad G Bhat wrote:
>> The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
>> spapr container)" began to use the newly introduced VFIOSpaprContainer
>> structure.
>>
>> After several refactors, today the container_of(container,
>> VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
>> not allocated. On PPC64 systems, this dereference is leading to 
>> corruption
>> showing up as glibc malloc assertion during guest start when using vfio.
>>
>> Patch adds the missing allocation while also making the structure 
>> movement
>> to vfio common header file.
>>
>> Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr 
>> container)"
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>
> Could you please give vfio-9.1 a try ? Thanks,
>
Yes. This is working fine for ppc64.


Thank you!


Regards,

Shivaprasad


> C.
>
> https://github.com/legoater/qemu/commits/vfio-9.1
>
<snip>

