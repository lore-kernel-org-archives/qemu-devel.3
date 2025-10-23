Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93F5CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtfB-00077P-Jp; Thu, 23 Oct 2025 07:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtf9-00077A-3C; Thu, 23 Oct 2025 07:39:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtf6-0000wx-2P; Thu, 23 Oct 2025 07:39:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N2LVvW024779;
 Thu, 23 Oct 2025 11:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Tq6Tl1
 mbu+J9F6Ay1Mhb05hd2w8W9D8diyz3nyQm/10=; b=Hqdv6GP5aqsd4TkMzovkym
 cU50BzUtoAvHL+iVogMzwamxmJJXAi1q0EfTszwhMto5q0yltvFq9drksLCXeuck
 Ry9qGMOLMaIfVfJvfMA6bkRRTxfqUaF2mjsgENaTtlrWeUlX7+9fGKWBCB69hS+q
 K2L5WHxotqERQAz21T2/ubw5Aqa/g119AsXIgsrSjdnQEwQ8F3mTUkfHIyYrUq/n
 jIASU4MDUz+Kf1SEmO4SSJT3p4N72OhcETKrFOODHd02Wm1EIK1ISjN45j0R9WFb
 5rnRVkybwqWgpb00Aum4MlyGqo3Ze5VxUJ4Ea/7P2ozB3JYSVmvSVm8jJVdwwkZw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrc7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:39:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NBdFk9005595;
 Thu, 23 Oct 2025 11:39:15 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrc7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:39:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9FJu2014848;
 Thu, 23 Oct 2025 11:39:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdp4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:39:14 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBdErE22938248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:39:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5156958059;
 Thu, 23 Oct 2025 11:39:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F31A58057;
 Thu, 23 Oct 2025 11:39:12 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:39:12 +0000 (GMT)
Message-ID: <764df5c7-55d3-48ec-a28b-0c837e13c595@linux.ibm.com>
Date: Thu, 23 Oct 2025 17:09:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1761176219.git.balaton@eik.bme.hu>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <cover.1761176219.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7xRt52b85ILU
 MZCoCyjyI/1ACSllB3UnGOtXtAbvaNXOlu6Mf4BJriQg3fEXEi1HWvzBuItEijTzlQr8JoAUohH
 Hd5gqHnz4bmxszhe8mW5+TH6iwYsM+lIY982//IWG4YeN1zV6+5TwWRLtRz6XDkFC0HKuOqsCg0
 ZJAdohVTzgO7N/Jc6iNRijPc6JYk+/h1ZYRdXQzBTwQJll3DQ5ca0KmK16bnCC/kwMB2wJbVbTC
 4Wy2j+WuVYeCZRgSVGIn6onM3mNDCR6RRDIEm+GsqE/KQDO1E8KJUsa6m7ZKM7KPWRTbZ5W9/+S
 aoRtpaxrfAVIaBE2fGqfqW82wzFjwvTy+JoQjR77Pleb263IXeTpnJH7wr7owwdgwm0gGTNAtAk
 3QpcR455JOCLX/taZmobZIRMGWAIRQ==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa13e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AtbYnQlxtsojCQpLmmEA:9 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: ubUdIbvXRRfMehBa-l_Ir7RMqDdOibNb
X-Proofpoint-ORIG-GUID: vTb7DxvuQf0ItIgb812_g9Wsee_xsh0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/23/25 05:36, BALATON Zoltan wrote:
> This series changes how the fdt for VOF is generated in pegasos2 by
> moving the static parts to a dtb and only generate the changing parts
> such as memory size and PCI devices programmatically. This simplifies
> the code and allows simply adding emulation of Pegasos I which has a
> different north bridge and slightly different memory map but otherwise
> very similar and can be emulated by reusing parts from the amigaone
> machine. The machine was tested with a Pegasos I ROM image and MorphOS.
> 
> The first VOF patch (submitted separetely before, the reviewed v3 is
> included here) fixes handling the name property in VOF that cannot be
> represented in a dts as that always takes the path as the name and
> cannot accept an explicit name property but we need the name property
> to appear when guest queries properties which previously was worked
> around by adding it to every node.
> 
> Regards,
> BALATON Zoltan

Queued.

