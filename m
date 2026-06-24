Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC776CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOlc-0007Pi-AN; Wed, 24 Jun 2026 10:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcOla-0007PA-MI; Wed, 24 Jun 2026 10:39:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcOlY-0002zC-Tb; Wed, 24 Jun 2026 10:39:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAmhCW718393; Wed, 24 Jun 2026 14:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+Ft7Pp
 kjN5pKGFDHK6GMtcKuVmn6gXqBIT6M4oiH0Ww=; b=hnTYTbaqJgffzPOkiTHD2y
 2EZ27uzO6+mdOAZYRqDeVCD/1cRY5NjK+74mtF4sGsZUiEt/PCFRU2HPgh6POHK0
 KBSpXSNM4cAlzQBSLIQG+scfqgFPme7qvxd8IO/rUc9u9Zip3Vq6W2gz2K+9lpKh
 hqRRYRPaJ/UIF5LJxnFeT0ftNpkTvX2EnOFDjlp2xA0A1N0y1Mau/117XYmAacWM
 2QqL0O5a37hyInol0yuuOdQU95IR8sEqsew7JN7rzdznvCDUV1tatzs1XFltgiat
 Lcb0pQwvcDH2agfo8/LKVAasfS54FDREQbbtHbBjrkca+XOiEwOihHGdkvWkbG5g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3mt0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 14:39:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEYoDX023220;
 Wed, 24 Jun 2026 14:39:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyrswm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 14:39:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OEddHO42533286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 14:39:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 331FB20043;
 Wed, 24 Jun 2026 14:39:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC09F20040;
 Wed, 24 Jun 2026 14:39:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 14:39:38 +0000 (GMT)
Message-ID: <8bbe6ff3-624f-4466-bf67-246a84c1809a@linux.ibm.com>
Date: Wed, 24 Jun 2026 16:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/18] target/s390x: Support cpacf sha256
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-5-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bec2f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=STxvwRUYNqjuMKLQNtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX2mxZrl2KHf9W
 aAVdTS7Pls9o3YvNQKxApv/PtWhVYuCWDLsCWUetweGGvUngxxNVqwFnpKcldi7yCQcBmsIfdnb
 Jdrw/H+lILT+QV6W+0ouB6sFro+ymTg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX2hUFFxyn39fJ
 5y7kXl+M4XBzdGaeuiKF9ssdlx+1ULMwnahloK+zxiR2nedq1x8XdovUJoYGHGEbO/Li9Qfw57t
 7RteWvnRfNYc3qq2lxbcW/PL+k/uChfWCxriY07tWzUzGHok3BYxKWc0lqkOwF8pcf1W/lLQYQa
 CmOIwd/ZdyxfimTkdKcw8cZTTXScdIDEGv9j0yldcq9NyV8J4zIbAsX3nulpu+ja4EZJb4YR/Wx
 hh4kWgZWrYp3g3X6jpl79K+v0iT31jXKNxKv2rlE+zcdlNTDOrOvBcH9BsfzT1WuGK7dh4CZ5lN
 XmbVsSHBUX9qRCEpQU2Tah9AZHtznq3zSQyhuQFeS/vjlNinovB3ViPuXntn1lxZIUTXWimpoIU
 bA/NMSXRTTx9v9LemLT+K+0HvDJOLw==
X-Proofpoint-ORIG-GUID: 5sVcjEtsyWGFLTETlfmXTWWFP7Sa6Vso
X-Proofpoint-GUID: 5sVcjEtsyWGFLTETlfmXTWWFP7Sa6Vso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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



On 6/24/26 10:10, Harald Freudenberger wrote:
> Add a new file cpacf_sha256.c which implements sha256.
> Add support for the sha256 subfuction for CPACF kimd and klmd.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   5 +
>   target/s390x/tcg/cpacf_sha256.c  | 232 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   8 ++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 248 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_sha256.c

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

