Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977D0C54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMqi-0001cH-Kp; Tue, 20 May 2025 09:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uHMqb-0001bi-LF; Tue, 20 May 2025 09:17:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1uHMqU-0005nt-U1; Tue, 20 May 2025 09:17:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IVS7016915;
 Tue, 20 May 2025 13:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nThyK6
 uIi1s2lzN1UfV9xQQqAiKx+0kYoYjbI39PmnM=; b=rkJxNef9Pu0HPfP3s3D/lX
 KSQfycRnNqlo5Apv5+OKeqluRQivQ33W04zbhYlMoC/TV3XtLpDVvoqe/AP+OJMz
 a89uhkoNdNUJC7Nqf3EP/7B5hnFIMgsCnE8+NsRBTeDMkYum5RZ4GVLtE2C6fGEQ
 Z0ytzEEWMFViXDdSRJgY2MP5711FLffqGeBBtBE2R24KtD1TbrHuJsFWQy5Sz71P
 FERa1NkWSUPWLqEUnBJznWqYvAy3pyhYWUSZOcKALpvgD+ua4yZDMc8KHGOavPT+
 ni6fQx0jrT68SZvR87ITnLBgXCAWDZFyvzkr09AMfJI22gS7WT3xbB2LV1F/O9Xg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbssyxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 13:17:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBBvqZ007183;
 Tue, 20 May 2025 13:17:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q70kbuvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 13:17:20 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54KDHJcJ63439110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:17:19 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03B0158053;
 Tue, 20 May 2025 13:17:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2798858043;
 Tue, 20 May 2025 13:17:18 +0000 (GMT)
Received: from [9.61.255.60] (unknown [9.61.255.60])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 May 2025 13:17:18 +0000 (GMT)
Message-ID: <95f61ae5-089f-41bb-aa34-e5db1af31214@linux.ibm.com>
Date: Tue, 20 May 2025 06:17:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 4/4] s390: implementing CHSC SEI for AP config
 change
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-5-rreyes@linux.ibm.com>
 <d95ae850-a6d4-4a26-8bae-3c4619fe25f2@linux.ibm.com>
 <779b2cc9-a028-4b59-b72d-e361647996ea@redhat.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <779b2cc9-a028-4b59-b72d-e361647996ea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwNSBTYWx0ZWRfXxdJsa3Qr4LwF
 qCm4ywcDrBrPBGRGucXCuGxifaVRAMPRlr90If+CbLVA0/VCtfhQVIGN/4t+VMlrrEqh/2RoOFu
 rijV27pvQ+cJA/EVYfvqkDErrHtnwIA04CP1luXnGR6JcP1am4Fd+xyco91fT/QluQaMOqqt5vo
 XWLeqkvZ5BPB8Qoy9E/MYEt/GDEpURbX6XpE7c9eGy0ud7gyFzpUPnh7oZ8T/8UvWxaxS9vnmr9
 95hpwnYGNGxmTL2A9aZrlnARP1bg6akoHAwrwd/VbQ76byo4QX71CUZwYxjunDlm2/gpevotG+C
 9H6X619rBtu7ItDDMjSbAbBmUar0tOFT4iFrwfj7GbNpRWnoibgHCafwlMqTjd9Jwv8NLxaqAIZ
 5v1K4IolA1hZY8g3geFTzJK+t523O4nQ6Ls8pkiW0KiFNg7kD54jV1tRFA8Vh4jQ4rI3/J4N
X-Proofpoint-ORIG-GUID: S43A88hrC5DEDPqRm-w1IAYDCGHNVNKE
X-Proofpoint-GUID: S43A88hrC5DEDPqRm-w1IAYDCGHNVNKE
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c80e1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=MewQnREuTKWl2ofUSXwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=811
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

>>> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
>>> new file mode 100644
>>> index 0000000000..e2dacff959
>>> --- /dev/null
>>> +++ b/hw/s390x/ap-stub.c
>>> @@ -0,0 +1,25 @@
>>> +/*
>>> + * VFIO based AP matrix device assignment
>>> + *
>>> + * Copyright 2025 IBM Corp.
>>> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 
>>> or (at
>>> + * your option) any later version. See the COPYING file in the 
>>> top-level
>>> + * directory.
>
> FYI, I dropped the redundent license boilerplate. See [1].
>
> C.
>
> [1] 
> https://github.com/legoater/qemu/commit/8db3dbac401c56da6e865dcba1304f305555c22d
>
No problem! Thank you Cedric

