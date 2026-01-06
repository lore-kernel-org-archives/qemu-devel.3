Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8743CE9D7D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdAOd-0004gh-3P; Tue, 06 Jan 2026 11:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAOU-0004ea-Rn; Tue, 06 Jan 2026 11:58:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAOS-0004Az-4h; Tue, 06 Jan 2026 11:58:53 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6064Dpq9031543;
 Tue, 6 Jan 2026 16:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=VGmKB85RmCnsMtce9I47RZOcDo1Ank1LUjFkYGiIKEM=; b=FkKpVtygLnjG
 mvF5xBbzX4SDrLQwwO12xB7SAM+aFyRNBSdPfLFjESsNtKG7ZM/RCGkSWZpxi7l2
 ruDk6xKPEnrX6VduMjk4vJgDK/xsCqARHMI976gDD+TF2r8is6BHf4gXwJOKC522
 eGXJ+FA+u9WQzZ8YRtufZTKcBEpDJSU+0Zr+3n3aZeDuTxJkXdWJJ7NqaaUJ+r7/
 krwxCnLu/KLbneooLHXCupykekiSETct7iOSDzbEZEVoA6KV4unEivBPli5HOGMN
 0fK+MD2kldbaUkcF5qFoIqYwo3m53rgnRFJc6ho+j9pD2xf4DSpt4ISIKU59Aj5o
 vC8ABDiOpA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu64x82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:58:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606Gwnsh012330;
 Tue, 6 Jan 2026 16:58:49 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu64x7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:58:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606EEq9a019411;
 Tue, 6 Jan 2026 16:58:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg51486g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:58:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606GwkIE37749302
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 16:58:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D30C58054;
 Tue,  6 Jan 2026 16:58:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 020255805A;
 Tue,  6 Jan 2026 16:58:46 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 16:58:45 +0000 (GMT)
Message-ID: <592d42050fdbdba45f395487d8ee80de0ff247ca.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] ppc/pnv: Support for SECURITY_SWITCH XSCOM register
 access
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 chalapathi.v@linux.ibm.com
Date: Tue, 06 Jan 2026 10:58:45 -0600
In-Reply-To: <20251218200353.301866-3-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-3-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695d3f49 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=TRwDyEk3oLEpmU-Z7y4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: k8PKbma4iC30Bv-npq2i9tyraB6iMF4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfX6ALOCHnVSgLX
 LvVy/R1/HKWG+1hbX9zs8R2k3S9LQA9aVYC+ojgdxoIg45gChD/uE0xBHK4W0p3NX82H8eCf40O
 ysdbwj6c94zIiU3ySiDPxhfFTO1UvbnZmgiCIvRgXoidpTn5wNAZpJtd6Qoe7wD4HH5Bw623LL4
 +wuRD/BPcnceKkSIPNr3qscBvYCJspPYn+WXGWGyHAd2Bvwkhvg1PV9EyNOCUkmEh7hkgUJOEia
 ZtOIHA9oPEuxDFrk3kzxpiuKspIKCBWnUFESjkcbRSZnvcO1sXqexLZ4fhCvpRNBp+GCR1Aqk9m
 kCUA5IpFnY70SStJpiCR9LtkzlA9V8mXpyXgz5R9HvmUO0T7oQEh12w+em9OWJfumCopYxGRFcT
 qi9Dply3ylUVxQuDyc8i/KsX6uuOFhJuqF6G4y8ATUUZgg72qS5fNS4rCc0Z/AHe8TcGljRSyaE
 g974iJH3vQnBphKMtKw==
X-Proofpoint-GUID: QJomRFMJk4U4MgA67dSLmRLpm-roCGou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2025-12-18 at 14:03 -0600, Caleb Schlossin wrote:
> Power Hypervisor code requires access to the SECURITY_SWITCH
> XSCOM register at MMIO address 0x80028 (scom address 0x10005).
> Adding basic read support for now so that is doesn't cause
> error messages to be posted.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index fbfec829d5..308430def7 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -61,6 +61,8 @@ static uint32_t pnv_xscom_pcba(PnvChip *chip, uint64_t addr)
>  static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>  {
>      switch (pcba) {
> +    case 0x10005:       /* SECURITY SWITCH */
> +        return 0;
>      case 0xf000f:
>          return PNV_CHIP_GET_CLASS(chip)->chip_cfam_id;
>      case 0x18002:       /* ECID2 */


