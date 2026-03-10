Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE594EB1054
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyRf-0000mY-Gr; Tue, 10 Mar 2026 10:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzyRa-0000hp-7M; Tue, 10 Mar 2026 10:52:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzyRY-0007ef-L8; Tue, 10 Mar 2026 10:52:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A75pHK1561657; Tue, 10 Mar 2026 14:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4EyWwc
 +8ZnGWg7PZ77LlViCtaNcXAcREDRlWWUBFyfM=; b=tno2qc2qBAvNEuUwLxnIFu
 qiks0pnyoYLrSfwYBzgo0Hgngu2h97KuWmxGma6RxzVTUoHhNMD2NgAp4gwyjnOV
 XcBVV0zvidUj1tDCyExneCikiHyAzHPMagvDYE8l4VBYqv70l1GJrYsU80WFCgHQ
 oJW3jpjyfXUCj1dahkvSSIABw51sZpql9+qeFVsr0YbXrU1yxx2SNsZnuBWADgjt
 0mYNz+mut73tWxhkm13wEJGUiEblvmORQjaF2oy+avGQ2OtpuDnyHCfQ/gMusAiL
 qXXSXb3+nPRptx4O+jkSTsTylayh6alyUr9OoCeNDg2A1LHbi61VPGp+XiEVfbdg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmbdt5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:52:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AAtSlT021389;
 Tue, 10 Mar 2026 14:52:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbssnys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:52:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AEqDHg45547802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 14:52:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D284520040;
 Tue, 10 Mar 2026 14:52:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22DA020049;
 Tue, 10 Mar 2026 14:52:11 +0000 (GMT)
Received: from [9.124.215.249] (unknown [9.124.215.249])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 14:52:10 +0000 (GMT)
Message-ID: <e09883a8-7157-4b2e-a11b-2545d5efe85b@linux.ibm.com>
Date: Tue, 10 Mar 2026 20:22:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] Implement MPIPL for PowerNV
To: Sourabh Jain <sourabhjain@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Hari Bathini <hbathini@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
 <d828f5f5-f79f-436a-bd84-ab8c270725a8@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <d828f5f5-f79f-436a-bd84-ab8c270725a8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: w06GAAA_LX28e2KgSKUj5mQhgkrdlBQi
X-Proofpoint-ORIG-GUID: 3_XAuUbNlgCPoVBCIa4mLYcr9U5HUYOh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyNiBTYWx0ZWRfX/aRPGbQzR59D
 TErenghP/cTE9eNI9JV5VLT0leiUAbHvv3RWxkQf2uOO09YFr0pQC0IMcMjCha3fUrSohHtEEf5
 ruM0G7BryshpLbmV2dcRLeFERyh5ra3+b3WDTur9xdPO3YcBe9o+iJhbc1UtMwh72QDS2RaW4/h
 QLPkzp4AkZn4dHGYnzgHqogkSTnxAfqoDUfnbb/jFSa+2YbRTACU1RZWS+Ymp4R5HIimf03Ncen
 7tKDGzehgJdBZ8Xj+wlIzfcNvQfDVCsxuM+dMBRVgF6G07rq4VZJNZJmqDG9PQaCWv/J1xGpJj2
 Du88Bm4fSkzzHWXk+ary2IOoPNtBnu7B/XWDcj433q4ivfV9uXgdQSLs/Be+GcFq9meLzfAKtWf
 xIm7lxdTv75BZ+zfde9H8eaQXuSj6zcktJVQWBeewwOEnp8rn7AKQkNOCZoX5YCbO7GP9JyLgx9
 iJU9LWrAgD1ORahMe3w==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b03022 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=WzblKziCi-pPldmMIboA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/03/26 20:20, Sourabh Jain wrote:

> Thanks for adding fadump support on PowerNV platform.
>
> The whole patch series looks good to me.
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thank you for the detailed reviews Sourabh !


- Aditya G



