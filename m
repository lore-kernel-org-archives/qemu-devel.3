Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A8EC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOKEC-0001Bp-C7; Mon, 01 Jul 2024 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sOKE7-0001BA-CW; Mon, 01 Jul 2024 12:50:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1sOKE5-00073t-6f; Mon, 01 Jul 2024 12:50:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461G0twG014419;
 Mon, 1 Jul 2024 16:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 Juct1V7VXjoUMB3eviy6VtLHMnRw3VBBqFFdi3Wc+rw=; b=oe89fTh48ey0quej
 e8EZaHmeY2G72KlYN11c80s7eL2u9pkj1aWzX5lIKDC5gwOGohH+l/cYEQe1Lkal
 yzto6b8gy1Gr7++w+/SX7mgYF3mc7KlaPpVEu/ZayBoSUVGfMoZOS1yJcMxdDPXa
 gHevZnqrOCZCD3d6/kLKJvhf3sUhLF03cBSehLVXpoOeHdb84TAwlcHKD7Mb3oWS
 E6JnK0D5n03p4bZsx7P8bjuvCA6pDPeBsKCox/NpIwRyb2E81jIDJhKdwA5Q9dx5
 6uDcfjA1KdQz3Y+vOL/sqks1oglNzz/Xx9EX2wsKXeg+teNcQXgUvy0+eRERY8a+
 wUw5zg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403yjjr421-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jul 2024 16:49:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 461GnHDK007617;
 Mon, 1 Jul 2024 16:49:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403yjjr41w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jul 2024 16:49:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 461FofjL030030; Mon, 1 Jul 2024 16:49:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402x3mr615-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jul 2024 16:49:16 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 461GnCJe56557830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jul 2024 16:49:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 121E42004B;
 Mon,  1 Jul 2024 16:49:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD35220040;
 Mon,  1 Jul 2024 16:49:09 +0000 (GMT)
Received: from [9.43.17.204] (unknown [9.43.17.204])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jul 2024 16:49:09 +0000 (GMT)
Message-ID: <922a1782-8530-459c-80ba-b376c6a859e5@linux.ibm.com>
Date: Mon, 1 Jul 2024 22:19:08 +0530
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
 <65126343-344e-47a0-bf63-7df43b0051ca@linux.ibm.com>
 <8ba04617-f18d-4c84-8bed-d3ddfa87d5b7@redhat.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <8ba04617-f18d-4c84-8bed-d3ddfa87d5b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Sh9dOQofPtw9fWHt05CMQ5bVIFgVNKjB
X-Proofpoint-ORIG-GUID: 2sXqiKUk7sqRtXN5_firVHVCx-O9AWd-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_16,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407010124
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

On 6/28/24 4:07 PM, Cédric Le Goater wrote:
> ...
>
>> Could you clarify which tree you are referring to ? I see his tree
>>
>> https://github.com/awilliam/tests is bit old and updated recently, 
>> however
>>
>> I have been using those tests for my unit testing.
>
> Yes, this tree.
>
Thanks!
> ...
>
>> This went through cycles of breakage and fixes. It worked on 5.18(not 
>> sure
>>
>> about older ones before that), and broke afterwards. Recently fixed
>>
>> and working from 6.4, broken on 6.7. Fixed and working in 6.8
>>
>> onwards now.
>
> Good. It should be fixed in the next debian.
>
>
>> Yes, TCG too works, missed to mention.
>
> and a TCG guest under an intel host ? This used to work.
>

Yes. pSeries TCG guest on intel host works too.


Regards,

Shivaprasad



