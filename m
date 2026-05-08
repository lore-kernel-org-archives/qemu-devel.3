Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FDBCD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 12:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLKeT-0005GK-SN; Fri, 08 May 2026 08:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wLKeH-0005FS-Rd; Fri, 08 May 2026 08:49:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1wLKeG-0007KG-0T; Fri, 08 May 2026 08:49:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647L6Me12725335; Fri, 8 May 2026 12:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VsWJ8A
 6U2EVK/QEcdXVYGlbwQPpyo1yGqdr8/7xf524=; b=EeEKO9xSCosqaYNWWYyfQY
 gKUmI7+wa6rFOQPO/2UOeUtEeI4V5tyX6FZV1BM0DgQHVvb/PkTrtusMg+Zupr88
 uFjNUZEYrc4d/HibOkIR76eplC/NrgJavTQNWlp/cyuY1pe/lN8oaAdTuHzDbAQ0
 gvKTJJE+b4Bk8HClQhx7niotHrHMaSeca3fr3prGZIlLWdAOVz0r4/0+NOZM9IwJ
 u/x0Uy3nU4P1XNzG/A+wqdGm5+rA+xO+lAFxoCFmMOJ8pZzrshN5JSeQJ5BgCfh7
 hG7I1TIu/0d5JnymKf7DhhHDZZuL3r4+8tkhY+zh4mm0dRTM/3yaG6X0uLqNx6Kg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y52egu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 12:49:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648CdYgd026663;
 Fri, 8 May 2026 12:49:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk860b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 12:49:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648CnTMc8651386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 12:49:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A788580FB;
 Fri,  8 May 2026 12:49:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3C68580F0;
 Fri,  8 May 2026 12:49:28 +0000 (GMT)
Received: from [9.61.244.117] (unknown [9.61.244.117])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 12:49:28 +0000 (GMT)
Message-ID: <1410c8e8-5d4d-4bac-a7b3-67bdc6d39b42@linux.ibm.com>
Date: Fri, 8 May 2026 07:49:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add self as maintainer for XIVE
To: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260507154530.364296-1-milesg@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260507154530.364296-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzMSBTYWx0ZWRfXwULt01EiW6uy
 KAzMVkDpUFmdYsHQyV+me1YOfYVyCidbGSxl63RVFsVUhN8mpvpRtLE5x0VxB465gMJg2rO6PPM
 dz8ey1svS4y82B0m2jhQ52qdK6zSB5PDgxHbnjUlZeNo0eY0A+BVBA16a9/fzOkmViVUunxUHM2
 StC8hwOVvCb2UuypuyHLZDf9t9C1EHUI0BbUqt/aIf9YV5vjOWnL7F26m8wzFRqF3/KJsyrkFBF
 KoVDJQTLKbo6dt0SqwbCnCM1ohhzbSYzs9eEGsiVEO2TZGTa4PGrVV2anBEliYYnpCvjKkDmMck
 EnnGtFtaWiw50igO2+hyEY0+PEmLFgnn931zVFnbrf9K7VxUwAnetNZfWECDBPZbMav1Tbh36hF
 3hPs4IQwmiVBFWs8BqU8/u5TLA29h/qg0Nz8v497mCRn6q2YYIJumkaCEwPm5eJiaKMjnenYjB+
 OxApHSdZvOpGtCV0xmQ==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fddbdb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=c2Y0Sgk3J4KVTCVD5-AA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: hRjWQjR3OZJuA8mXVRNqxSIky5rNYEp_
X-Proofpoint-ORIG-GUID: hRjWQjR3OZJuA8mXVRNqxSIky5rNYEp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 5/7/26 10:45 AM, Glenn Miles wrote:
> Adding self as maintainer for XIVE
> 
> Signed-off-by: Glenn Miles (milesg@linux.ibm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d3d645953..37fb460a2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2877,8 +2877,8 @@ F: tests/qtest/libqos/fw_cfg.c
>  F: tests/qtest/fw_cfg-test.c

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

>  
>  XIVE
> +M: Glenn Miles <milesg@linux.ibm.com>
>  R: Gautam Menghani <gautam@linux.ibm.com>
> -R: Glenn Miles <milesg@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/*/*xive*


