Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B2DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 18:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFH4a-0004JB-1k; Wed, 14 May 2025 14:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH4F-00042e-9K; Wed, 14 May 2025 14:43:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1uFH4B-0003x9-OQ; Wed, 14 May 2025 14:42:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EEglul026369;
 Wed, 14 May 2025 18:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iDD27L
 o0PvJ4BEeNNmBJ6JdnzoZ6sKz7QZWQk/RsYn4=; b=Q2KyDhBetjPJrmhXNu38+n
 BN6nbsqwXw1mEKx9UUJJmEHaI55AgYy8MMRhw7KaGBCmlOs7q+Ds3J4K/q9MJXi4
 PfMdCO1P2v6iwo/Z4+rCwbkoGuR6+XiAqI59K254z1OBJ5CAhokhGvDNfiVYzPKL
 UBSnzkqscWHUIO4AH0eea3Y0y/Xp12ndvafS/3AllyTetv9Evs/VH0hieGSvdWQ6
 rfsUJ7vIN0bDRMDcwkq2kX8X7yBRtphsrOTkIGxIbawyNsP/V7dzcP3hCGVbEyzm
 BmghraTRyCxBING+iVGUkuh8v5CTg7vOyQG7upoNQGivLHwHmkkyBX8/0PiruqHw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3q9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:42:53 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EIP7F8005088;
 Wed, 14 May 2025 18:42:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst3q9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:42:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EGgdvf021396;
 Wed, 14 May 2025 18:42:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrnutv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 18:42:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EIgoZ565077576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 18:42:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6345A58056;
 Wed, 14 May 2025 18:42:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D46695804E;
 Wed, 14 May 2025 18:42:49 +0000 (GMT)
Received: from [9.10.80.143] (unknown [9.10.80.143])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 18:42:49 +0000 (GMT)
Message-ID: <e039bcad-b2fa-4192-85bd-c7b5313c4e25@linux.ibm.com>
Date: Wed, 14 May 2025 13:42:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/50] ppc/xive: Report access size in XIVE TM operation
 error logs
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-3-npiggin@gmail.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250512031100.439842-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eGsg_3l7nyKtLyrYVyLlBEbHsLzZmjRg
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824e42d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=qXEQd3BZVoUS5mX2PhoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9gzXBZZItXCIW2hXFqTLuZpteM_A6bKh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE2OSBTYWx0ZWRfX8bZBP+FFQ0Mq
 OOQRO5zsOmCkChGCvXtZ5+mo5TrdUWJLrMgdtpMuGQTJ4Svk0hiTiz9+3nyPxjdgJd+8LAT5Ofz
 B53ficNkfvt4K3bvgkIWVPiSX68lXyRaEqIn9EjETHzQ0mua/11qxuBh8F/yfYZhEeYJrLtbH2N
 NhO2X+3iNeanlO/plx4zhfn0aLZ0e63L7RbFtR4ZIM5QKkGi5S2ADDxXMrqt6aX947Y6bX4u0vQ
 Plz0Fvrf54kGgFmLjWbkdjeUPTJnr7TqmHSmLZaqwQL4uQY2yri6fnewyNO37GCEHg7Se76TMLF
 QeKE6ao7HLopkgiydVMYqLgKSdlVxR5BV6UguipSJEM4OS6RS+73tdZGhfOdv77iOPt2jpgybV1
 WWJyKmF7fbKAxSfy8G/bwPrYSHaPEThoxhG2bBoarkBQnmxmYeZDyQFsbYOcmwhfpaYg5cn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140169
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
> Report access size in XIVE TM operation error logs.

Reviewed-by: Michael Kowal <kowal@linux.ibm.com>

Thanks MAK


>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/intc/xive.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 3eb28c2265..80b07a0afe 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -326,7 +326,7 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
>        */
>       if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA @%"
> -                      HWADDR_PRIx"\n", offset);
> +                      HWADDR_PRIx" size %d\n", offset, size);
>           return;
>       }
>   
> @@ -357,7 +357,7 @@ static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
>        */
>       if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
>           qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access at TIMA @%"
> -                      HWADDR_PRIx"\n", offset);
> +                      HWADDR_PRIx" size %d\n", offset, size);
>           return -1;
>       }
>   
> @@ -688,7 +688,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>           xto = xive_tm_find_op(tctx->xptr, offset, size, true);
>           if (!xto) {
>               qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
> -                          "@%"HWADDR_PRIx"\n", offset);
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
>           } else {
>               xto->write_handler(xptr, tctx, offset, value, size);
>           }
> @@ -727,7 +727,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>           xto = xive_tm_find_op(tctx->xptr, offset, size, false);
>           if (!xto) {
>               qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
> -                          "@%"HWADDR_PRIx"\n", offset);
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
>               return -1;
>           }
>           ret = xto->read_handler(xptr, tctx, offset, size);

