Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7242EC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl5-0004Kw-0M; Wed, 14 May 2025 11:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD7t-0006xy-Uo; Wed, 14 May 2025 10:30:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD7s-0006Yw-7F; Wed, 14 May 2025 10:30:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9F7PY012993;
 Wed, 14 May 2025 14:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Zk5xGW
 TduyZAIC1pHbaHtHom4aaDgnI1xvc3weydQvA=; b=OSNdWklzY6obHwIao1SnyI
 8lk0EaXD+VsyaJIsJQYlFkX/p+qJKhHRCJxbdoiSVrVmt1UjEJ7LtL6HfAKlkQ5z
 UONrRC/MhyKQBotfIQd7BEnsNYAE8aVa7CZ9iecL31rpG638x5Lpow1Hjg4G4gfs
 6YfyTyauuJ1kxDO5hCwDveV8+SON3Hj0tZ+y3L23XuG8uLzwQQ/oMGu2hBg0vA/o
 fUohOxpVE8VNpbSQMzoiirG0/vnnbkzT2e0os+iOeX9IYuVEI0ohACI9aDvl4uL/
 JTIdORTIDHdtYlUdajgdFtEv0uFdzZHIzDsPNYNCtxywZTDkYg2h+xhky0rPY7Fg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9hfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEUQrA003052;
 Wed, 14 May 2025 14:30:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9hfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDJo7X026954;
 Wed, 14 May 2025 14:30:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpcn66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:30:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEUOnN19137120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:30:24 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 658C25805A;
 Wed, 14 May 2025 14:30:24 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0790858056;
 Wed, 14 May 2025 14:30:24 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:30:23 +0000 (GMT)
Message-ID: <ef160918-289d-4dd1-be8e-55c6bc62f853@linux.ibm.com>
Date: Wed, 14 May 2025 09:30:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/50] ppc/xive: Fix PHYS NSR ring matching
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-7-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824a902 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=cvhWS9GGLzrGVX_1QB8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BOAfwvPB3D67cUCAcI1tHJCeLu3X43b5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX3Waiwi50rC2k
 Ez77kGfmHyznJfHV6H3GWYNonfxnLQNgrWiJL++b0HDwi7H3Xkd7NOf4ExeXOvKbymhE9eY2cx1
 UbhgRiTrZ5s56FwaN2KgKtSRjmdkaG3PtXQOAHJ9poesyRHABaSsQrxvcS4eFXiiOYCncMhSy8g
 5dACtfG7P2GvyNJ8rqtA+lgEykRmwzR8ZS2bwO/LpI17Jwmjmstg4BiU1sF7UAew9+eaaDDtmkf
 Pi4qWWaKYcp7j9k1uqZG37QOKOYMI0a9MWZqXFvbVBJ6T5530TbmB0z/H2kV3ghEONm4FzyW0m3
 7zP/fjogrtgH0wNjnNev9O8op2NDJwc1ssbyj03SHV8M6iM9kE0cXkE6SAoGWeNaYtJDQn4eBKc
 NONPHvGSAkfzsryKThm/16xCIzJ2IVg5FxIpgvO5gXK+ODC1S6eJjKTPmjavA4QI6q+lmLr2
X-Proofpoint-GUID: lyQMzDHxCdv9UQ4dmEK4xVm-KyRrxsq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=941 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:34 -0400
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

Looks good.

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> Test that the NSR exception bit field is equal to the pool ring value,
> rather than any common bits set, which is more correct (although there
> is no practical bug because the LSI NSR type is not implemented and
> POOL/PHYS NSR are encoded with exclusive bits).
> 
> Fixes: 4c3ccac636 ("pnv/xive: Add special handling for pool targets")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 80b07a0afe..cebe409a1a 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -54,7 +54,8 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>          uint8_t *alt_regs;
> 
>          /* POOL interrupt uses IPB in QW2, POOL ring */
> -        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
> +        if ((ring == TM_QW3_HV_PHYS) &&
> +            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
>              alt_ring = TM_QW2_HV_POOL;
>          } else {
>              alt_ring = ring;


