Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D84C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 01:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Bhe-0001Mm-Op; Tue, 22 Sep 2026 21:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9Bhc-0001M8-Pt; Tue, 22 Sep 2026 21:23:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9Bhb-0001vs-Bt; Tue, 22 Sep 2026 21:23:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7NiI1157856; Wed, 23 Sep 2026 01:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T80ly9
 I9mI4k3nbaLOMcl6o695+5o8ItIcH4WxOqh48=; b=ZSc78KJmub/AcAuTCWhdL6
 0cbR1789/u9M4QRyajwyX2FMS6N4d0B4IXmgIGGqcBP/D/gTBsAZvwwc5bXsfEmM
 889OpHYTr6NcDObiU8Dfk5cjWVXjHydTy7fCJ+Bw00wxirNES4p5gYongeAHak8E
 yxq7mnu4rjH1xbbPWjgsiSiarqE63GoKsOjLRGS1J/91F7Es3CLLG7JnqJ8zbi93
 774aKn0hn98UWhg4TRoTQCt7sh/pfJs3KGNYaGxvn+EC0YZwERWdpbirpOS5S+aE
 jah3FZ6Bk20WeljXCR4tat+WjPz4KNbDSG96Moow49coaYaPOpLHx1oXARqCyCfQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv8aub-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 01:23:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MN7TFg4187956; Wed, 23 Sep 2026 01:23:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyc02g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 01:23:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N1NAWE30278168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 01:23:10 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DD8B5808F;
 Wed, 23 Sep 2026 01:23:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C94ED5807F;
 Wed, 23 Sep 2026 01:23:09 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 01:23:09 +0000 (GMT)
Message-ID: <cf4e0ba0-a636-496e-b9aa-ecf315e86d14@linux.ibm.com>
Date: Tue, 22 Sep 2026 21:23:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] s390x/css: Use datastream pointer for checking
 no-data CCWs
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260922201526.2383047-1-farman@linux.ibm.com>
 <20260922201526.2383047-9-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260922201526.2383047-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cFML3b7ZkfpUOTWZxRrie5xOoSQcP3bu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX7jjE1qnZNBOc
 fe6GGKmbz7KoKBWJ87JpfInzFv6HiGI8ZIXYMgrqru6Wjn0MhgdO8nmnCeJz0fRzJSywAFKQ/Pz
 78dk6Yv4BhhNtm+MH1qOPJXnyU4Rdc8=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab32a00 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=BuE5HkMHh6W_FLq2WlkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: cFML3b7ZkfpUOTWZxRrie5xOoSQcP3bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAwNCBTYWx0ZWRfX5JNdKKL4F6i0
 G1vouRLC326d8ukAXKRrIgzbz0tBgR7brj/iLUD5YO6WU7yB02qhLYFX5de7Ii+pqPo4neNG7JW
 x60g6D3JyW3i2izJk0R7EOfkFSS0tRgUKQVVAqM2CTuA7FM3EzR+3GvOMtbPagQLjZYBit0hs2D
 Hiy2U97PyJzjKe2Fw8MS7cLyJtJ+hl1Glz7IkaiiZkO986RzelPP81v0RlhOw+GtcJbv29thI40
 zEL7ycmU6hUV3CUC4jJxeTBjC+3u5wPpkdQUTYtRq1BL7Z79Z9XJc9Z3T4UKyr2/pK/nTk4begp
 yD2lXX1Ki7HoriTvNY57RQMfNm4sgXPkYL0iYckNeBAmJ3gM7/oyxrRPb+PW0oxNE6f87VfAS3G
 RL9Wq/Thk317JNwsn+R7ZU0f2njsTueiq9sA0dzZQiaBLLc6O/ADPE77nj/nPLrcC5gv6FfDvHs
 GBDy3VHbbJ40au2Ytdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230004
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/22/26 4:15 PM, Eric Farman wrote:
> The channel subsystem will reject channel programs that incorporate
> 256 CCWs without a data transfer, but the existing check to account
> for this only does so for CCWs with a data address of zero. Other
> valid CCWs that wouldn't transfer data are not accounted for.
> 
> Rather than re-inventing the wheel, use the output of the datastream
> at the end of the entire CCW parsing tree to indicate whether data
> was moved or not.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



