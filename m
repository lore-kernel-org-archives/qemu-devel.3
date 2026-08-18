Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108D3C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLDw-00019D-4j; Tue, 18 Aug 2026 10:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wwLDn-00011C-Ck; Tue, 18 Aug 2026 10:55:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wwLDl-0000NI-Qn; Tue, 18 Aug 2026 10:55:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3V1t455030; Tue, 18 Aug 2026 14:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QKISus
 lf5S+89fB0v2+9SckDYm7pYiTv/IckFHNgX5Q=; b=j7A4DqXq03XQXXSHte3t+Q
 CSP02cubQI8lxmmSLEq71sI9zhJh7C9acMBy3awsTuoXimYv7zwo/whyL9/u48/u
 RhHhsbNpgtr+q/ba+RNqBhvKsA+310ZGnwKKA5DcyYhBj+boNswb1bJPCCIKGOGG
 Wyz1za6/dHW2oIpEGeQZrLzRBuIWkkHW65nPzwa1NIAUtdUM27ZX/8uySImUqped
 +vAggn20m587sqMXyrM2PgU/32NkbhB4D8y29KupYbCb7a0H+d3uP2Nk0RuH/v9q
 hUZSDsqcDbKGdIX5MltV2III2ODLTJRud82W3EkxKpttNDWwTbnyIm8ZXtl/hXfg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3rx7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 14:55:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfPiY014779;
 Tue, 18 Aug 2026 14:55:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek3s3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 14:55:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IEtFnD36962616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 14:55:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21F1C5805F;
 Tue, 18 Aug 2026 14:55:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3253758054;
 Tue, 18 Aug 2026 14:55:13 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 18 Aug 2026 14:55:13 +0000 (GMT)
Message-ID: <ac7fd323-d338-4e67-b39c-f0a435e11aee@linux.ibm.com>
Date: Tue, 18 Aug 2026 10:55:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 34/34] MAINTAINERS: Add secure IPL files to S390-ccw
 boot group
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
 <20260730214624.2328883-35-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260730214624.2328883-35-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 730F7Qyy2Q1mFDf_z2n_GTFqjdAcZ6-s
X-Proofpoint-ORIG-GUID: 730F7Qyy2Q1mFDf_z2n_GTFqjdAcZ6-s
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0/BhyVsg+/dz
 TleoWGlh6Uksg0MmiqRy90TBbJ8rnNlOBPEhWq5g6GZDmlUJ5U1z631tz0p9xesvIgrue//WoyP
 NEeTmjMAj5H5GNNySEP052GuZ3DZjQc=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a847255 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=jZOY1T4vawHwXQVYJRMA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX2QuBoEiIJ5Wa
 4JQYMym+D2A8lt+WKiWRyDpYJbeztGO9JAaLqa/T6TDXLBSzQyM1xV8Iu2lswPE0d7xtlnsXXcy
 N3WNWMykuBq7f8N3NCc8pT0D+gMO10J7ZO8tbv0K/oud+yX0PHP5CX2Ug2ct6DNs3CFIerin3G9
 37xgzGA6fOrGzOpu16dAwkmXgB+t1bN45b4yt4cW0QAw6xeyvOez3I+7wATk5hqxb8kpaoE5qvX
 UcIG12mWZD7QK3hpOkxgJIa1eLCfX/UlBurvEDpvhO7GvBQue8q1uzfED7vA2sxO5gXRxPPFjE5
 DeKbk5WCUoyZxHRMVOg7ghS6Vs6/QNhnINo+0bLtSnVY1MbErTXxHx8Uc7xQpiTttyS86m+zI+a
 ED+WtM1TxSHcphZd+XFedrtwwXi8Y3j7sT2OHFzoRG982WnUL8DZv9QenbeutIYM/tMpv4TwJX7
 /Q1YoiXcyrJD0J5ATjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 7/30/26 5:46 PM, Zhuoying Cai wrote:
> Add entries for the files introduced by the secure IPL series (cert-store,
> diag headers, documentation, and functional test) to the S390-ccw boot
> maintainer group.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218..0742076861 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1926,10 +1926,15 @@ R: Christian Borntraeger <borntraeger@linux.ibm.com>
>   R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/ipl.*
> +F: hw/s390x/cert-store.[ch]
> +F: include/hw/s390x/ipl/
>   F: pc-bios/s390-ccw/
>   F: pc-bios/s390-ccw.img
>   F: docs/devel/s390-dasd-ipl.rst
> +F: docs/specs/s390x-secure-ipl.rst
> +F: docs/system/s390x/secure-ipl.rst
>   F: tests/functional/s390x/test_pxelinux.py
> +F: tests/functional/s390x/test_secure_ipl.py
>   L: qemu-s390x@nongnu.org
>   
>   S390 PCI


