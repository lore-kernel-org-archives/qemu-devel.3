Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61833C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymLw-0000dZ-1t; Tue, 25 Aug 2026 04:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wymLt-0000b4-Bt; Tue, 25 Aug 2026 04:17:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wymLr-0002NW-GU; Tue, 25 Aug 2026 04:17:49 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2Vdcp3730080; Tue, 25 Aug 2026 08:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L9reWi
 z1Pua4R9d3hgdH6esYrzzyBs8SQnb0dqU3KYE=; b=f9JhP1a1bDBJcZiq7SzjW+
 fOxrcJbx6Y/7XlGnk4cI6EuWGh6fuowRxbEdVKv+Up4A3TqXgZ9cG35keTuabX/i
 Zmj1c+8nWjjqNgvrfN2ONw3YvMFDpq8xr80Fprs3ndyeGjj8LC5UJdeWV2w5qXOV
 SYXWDMzU7CWWbKo6gUybkvhvrXWal3IxF+iS7l2WFHfwDQhlRr1MPhc4kkiVEWKV
 UJ4UkpiYs2bYdmouljz4TErQ0yQI6FCLJefTeTc3yh5SKyozpuGEU09zsET+4CYT
 1fGi8edJYJVZ85OVT0elc/xA2KcjZMVCgbdpqepGqFOJ1uW/WhWH/rzqNrGJRG4w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393xwf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:17:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P8BdcO029622;
 Tue, 25 Aug 2026 08:17:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw36yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:17:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67P8HWwZ43843844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 08:17:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F16020043;
 Tue, 25 Aug 2026 08:17:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B23B20040;
 Tue, 25 Aug 2026 08:17:31 +0000 (GMT)
Received: from [9.43.58.44] (unknown [9.43.58.44])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 08:17:31 +0000 (GMT)
Message-ID: <5889deac-c9d9-4a83-b047-c3c85d0736d4@linux.ibm.com>
Date: Tue, 25 Aug 2026 13:47:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/xive: Trigger the pending interrupt for a guest after
 migration
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: milesg@linux.ibm.com, clg@kaod.org, harshpb@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20260824070353.40016-1-gautam@linux.ibm.com>
 <a45db1dd-fef3-4ca3-aa07-953cce6193ed@linux.ibm.com>
 <ao1JL2wQ1fPBBXYQ@dhcp-9-123-15-208.bl1-in.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <ao1JL2wQ1fPBBXYQ@dhcp-9-123-15-208.bl1-in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JNQCyioCu3hDEJnY2YNjghDUpkOy7vVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2NyBTYWx0ZWRfXwQJpqvMiU4Bc
 toVOCgFdm5VZ4LtD9+A6W/P4Ly+vz8ubA+XD2ro5TeY//IRqQZ7SJQtKk/dfnRpcX8/+I/oxYS8
 +CxeYYkoN64XYS2j1mtR2OyUsQfsYDfXfmWFvrae8a5M/HXuAP5xoLEav/T9Km601e8/snxftCz
 cXgBf7tz+HaZ+y/20Pfahaw+uxk3NsgYMl55N1whaNEV9qwTLVxjzt2PirCbkdjtc9Zzidikz5E
 mOk9TcFi7bc/nHiXuNqyaeo8NRVoSs2sO9iKGnpb7O9GsoJNJ7mi5pNXuHulgNFOXefWqpQLDk0
 qgYcbdLWXm5Qr+b+t4RFGNO8Zl0i7g1iXMAH03+1HwXyci8snSVV0mQt3fc3iGy2xxR/93S3MSm
 qkVCsLz6G1N6ouYLsNvj4vx0mprt9LJuTw6XKJyn8nhfGT9kQ1GW3KnMJHZVnoS5Calm6wL3DP8
 B+XsF4P9pTUrR+/3LLg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8d4fa1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=F8TCrEr1dkVDcNW2Dv4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2NyBTYWx0ZWRfX1RLzlcEcUVl3
 8xlZzPFbTBbq6fsxXxyHnuTLEgV+tDh4jecDPiikORqmdmOSonu48nomJx6Ob2+RkEhCac1gTvB
 UVrdFQIrHSVabmNHNV82jJcD321AsK4=
X-Proofpoint-ORIG-GUID: JNQCyioCu3hDEJnY2YNjghDUpkOy7vVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250067
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Gautam,

Thanks for the clarification. That makes complete sense, since live 
migration is practically applicable only for KVM guests and LPARs, 
handling just the OS ring perfectly covers the requirement here.

Thanks for agreeing to update the commit message as well. With that 
added in v2, please feel free to add:

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Regards
~ Nikhil

