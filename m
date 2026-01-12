Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F3BD277CD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEks-0003lk-1o; Mon, 12 Jan 2026 05:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfEko-0003l2-Bn; Mon, 12 Jan 2026 05:02:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfEki-0005NY-Qn; Mon, 12 Jan 2026 05:02:28 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BMnJ9v005567;
 Mon, 12 Jan 2026 10:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+Y2Dg8
 hSpllWP3qmIwKxvOs/zTpFX4Ea+WKcIVNGdoA=; b=lVELo7cM6y056vCvhdmBAQ
 uFxSZW55f+1tQQUuokoN/2xwWabxeDVQJMfuwZoSH24d2ChVHz5tWD7lhHzvdQmQ
 55CbnuM7vhQAq3K5cCHFMVQONNViK1hIgi9OznNU6XCPNlXsPDIkAs8BqMD0tv2M
 3WyoDOwRHmll4UDc6n45qpHYjFhhK1ljNAEUmJAUt+3QClqeoxKrhxAZWFZ5OLCW
 44aat61kj5atGxBYxlWI98+1ibA3qu8JUhcaDkivJZHanIps5xGq/R8iT+y7ZgHN
 jQ9Dpdb4soxZBhFKhV+n6kbjzHLcwePFliRnaBtYqlzOoQ+J1pZNROL0hn8QVW4g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxekg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 10:02:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60C9q6HB012477;
 Mon, 12 Jan 2026 10:02:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6gxekd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 10:02:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C68ZPE025809;
 Mon, 12 Jan 2026 10:02:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kk57bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 10:02:20 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CA2JRO20709966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:02:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 518A75804B;
 Mon, 12 Jan 2026 10:02:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3874058059;
 Mon, 12 Jan 2026 10:02:15 +0000 (GMT)
Received: from [9.43.47.93] (unknown [9.43.47.93])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:02:14 +0000 (GMT)
Message-ID: <1301eb7b-31d8-476f-a12a-06470a349771@linux.ibm.com>
Date: Mon, 12 Jan 2026 15:32:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/ppc: Snapshot support for several ppc devices
Content-Language: en-GB
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, angeloj@linux.ibm.com
References: <20260105160138.3242709-1-calebs@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260105160138.3242709-1-calebs@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4GnIaiS_Jf94UpDbUfvifGnX3UZmEGo6
X-Proofpoint-ORIG-GUID: KnjmueZE5NRm5ubnGTBoySCphr6ps5xJ
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6964c6ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=9wFYLoDXZmjOZB_5e3UA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA3NyBTYWx0ZWRfX9cDI6Hv+053o
 0kKj8NbEgLkj/AhPYjpsb/YztGewzg/AJ+yZrLvgZesqSasG0w8q9J1NkX+u4Yd1e2SDMbkEY1X
 RtSPkMgJXVUvCbjw2Ol+YkwTm4BPO1uKSeLy8HCoWlPnOcCE7VPHsrUpw0ugmRgdtBaByVOtALE
 1+8GDeAjcyXNQ61oE8T76GZBK4uhcDUYEAn5I9zRhtU1UyOh0qPbxJI49iRv6mYDsE7cfoR0/Sk
 htZK2nL3ssUfi3BErV8oJf/jumaHky5Hbeq6vp/OYOU/pRgBNfHQv/zSUzBsJE+E0MQE/a4et6a
 XAu1DMfl4VafWJbtAtZIUzjC4NIE9LE0k4o14d+Ek+24lIJ49S9uLX4hngJpI+3/1wrQkSdyREl
 gCUHmVHFkgb/5nKsFpghjm4/ttwad5VS5+7r+bCY9c0R8N2KabqbUNp2NYIO+RWYCK3Mh4lc2NR
 /ycFLrjWu19HnCmghkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120077
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 05/01/26 9:31 pm, Caleb Schlossin wrote:
> Updates in V4:
> - Rebase and fix patch apply failures
> 
> Updates in V3:
> - pnv_psi: Remove PSI_DEBUG section as it was not used
> - pnv_psi: Add missing post_load and vmstate info
> 
> Updates in V2:
> - Added new patch set for PnvPsi support as it fits with the rest
> - Added vmstate support for Power8 and Power9 for LPC
> - Fixed pnv_core.c commit message
> 
> Tested:
> passed make check
> 
> Thanks,
> Caleb
> 
> For the series:
> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
> Reviewed-by: Chalapathi V<chalapathi.v@linux.ibm.com>

For some reason b4 is not picking above tags even with -S (to avoid
email match check), but I have picked. Usually, consider applying R-b
tags on individual patches in next iteration, once received for series
on previous iteration.

Queued.

Thanks
Harsh

