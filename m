Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14833CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 08:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcf2p-0000BK-CW; Thu, 25 Jun 2026 04:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcf2l-0000A9-JB; Thu, 25 Jun 2026 04:02:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcf2j-0005xy-Oe; Thu, 25 Jun 2026 04:02:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3nsVO3188232; Thu, 25 Jun 2026 08:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=8Aycy+D2uE1hS4xmDoymm8urCLCU/E
 B08P4Rasr1joM=; b=gk+cFADgaaAzyoANqduAKbyLw87cjtkbxJIapf3jAG3obp
 9s9rfWMLCYdYDdj5nCmPSu5VBPvPwmgORxYtYCOmXcrHxeAqnEXSRU46moKyx7DN
 HPFZYThhI3roKcDSHWi5YQNbbIgkmrEcc2y7ZNRfdzOf8OY6yh8Y/BlChoYXT6ma
 bsE/GYw/12F9bt1Z1SFNKieQ6vB23Yimfelwtpc7D5zpiFff5edGn5QnT74b2oBi
 CsF80yRdnSP41+7XcPXxWFloqZq1U+jf1SghwEVcXzM4T66aaoRrbL71cOpXz1vk
 jJCUJaKr4tps6PBA4w5FZ/hab+bQDdcSnlbOby1w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr0jb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 08:02:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P7ngB4011106;
 Thu, 25 Jun 2026 08:02:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phn1x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 08:02:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P82L7g46727480
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 08:02:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D070A20043;
 Thu, 25 Jun 2026 08:02:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C61D2004B;
 Thu, 25 Jun 2026 08:02:15 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.178]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2026 08:02:15 +0000 (GMT)
Date: Thu, 25 Jun 2026 13:32:12 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Message-ID: <ajzesh0mi46P8xyL@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3ce093 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ID6ng7r3AAAA:8 a=d17XFfZyTC1U6MJi_PwA:9 a=CjuIK1q_8ugA:10
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX70cxWOEAXkwb
 MXW417G8Eh/CRFb7Xp99gcdk1LDPDjc8Ik5DIRoHPD3bNnfbJ65Rwo6x5Bm9LZ88oVqeZSdzccO
 lbjbf3WfKkUCvnLz4n8ioYLk932u66+QvFlMWtrqz9tLWlKvPSphAf1W/1KSBBFlHtw5mIXdtKQ
 zefJ2rhfDeAecR+kKUn4VgeFRuGeWb+PKfXpqYe4NK3p+oF7rG4m+XqSvhzFQqPCzM4v55eWXTO
 2bUhKB2aBEoibKMI/M7wK8bhSuR6vF6afBGZFbFjppAnPiOy7KV7u+CbAFMMePkKXK1zJifT4n7
 u7OKNGX5bAjptdDlmW0n86ODVtEreA7WoQosqbWQ8Z4P7uqvURx1A++kLshfn2pZZdstsGeqXvQ
 eg9SJCSVgMoxqcC+GuROQKCAfN6tFXhZbdqQG3Jzx46SIEdSTwUHywTANXQRiUqDY+XvPeN+7L4
 PRIV/H+jsZSXhBea86Q==
X-Proofpoint-GUID: NjtrDFiYsxH9hBndFZuRtJaG61xuIkqF
X-Proofpoint-ORIG-GUID: d4XiJ8fxdDnmkkmH4Wwg6Op_6kMixptP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX0nDmyfI6UQlV
 X64Hm53fHD3yjfMp+eUTBnSTz5KtCb5rki3sBW7DVBFOEU2OQXy+c9L+RNBgLpTcBRJ0YHVvJfP
 Cy07UBOV2TLK8+8+4tcfVySZivc66Fo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 26/06/17 04:50AM, Saif Abrar wrote:
> Hello,
> This patchset resolves the review comments for v4:
> https://lore.kernel.org/qemu-devel/20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com/
> 
> Thanks to all the reviewers for their efforts.
> 
> Major updates include the following:
> - Rename to phb5.
> - New file for common definitions used in tests/qtest/pnv-* files.
> - Initializing PnvPHB4Class members within class_init method.
> - Updated IODA3 PCT table max size to 128, each with 2 entries.
> - Multiple general cleanups.
> 
> Tested with 'make check-qtest' , 'make check-functional-ppc64' and 'make check'.

Please don't keep Rbs of people unless explicitly given by them, see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

Generally two things:
1. Rbs are explicitly given (replied to your patch) by person reviewing
it. If they reply with Rb on your cover letter, saying it's for the
whole series, that Rb can be kept on all patches in the series
2. If you feel your patch has significant changes, generally Rbs are to
be removed. Reviewers will be happy to send the Rbs again. I will let
other reviewers respond if they disagree.

As suggested by Harsh, would be good to rebase it on top of PHB5 patch
from jishnu, will help keep PHB5 (P10) and PHB4 (P9) separate.

Will be going through the patches.

Thanks,
- Aditya G


