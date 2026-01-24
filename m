Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D1D715C4
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjcWY-0006KQ-7Z; Sat, 24 Jan 2026 07:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcWV-0006DD-IT; Sat, 24 Jan 2026 07:13:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjcWT-0001iM-U5; Sat, 24 Jan 2026 07:13:51 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O4vNsc003250;
 Sat, 24 Jan 2026 12:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ojrkbnWsiwwbjNEKmmmaT9XAuwTjSk
 aP5qIcKHeZN5c=; b=AAX1+jzQUaci9QSVjJZoh2NeCBy3OO0eu37Sivd/XzooJy
 qi2LJGFlkisv72GfxQadRz7MJxcpsbVd0GNlc3d9dfWDNLsrQvzW0fG3buw9oNLr
 Aj9BWcPVjoWpWGXnpe5OygX1gBWJTi4loatpWEyVHE+A6tdkEUv0pYUeEMvAxWIS
 iNw/agXzrZUl1QN9IwrH45BvpVE8821asfY597DHky6DJyiyVrSw8WAHnlU4HIVU
 WKjb+8ZwDXRx/WM0vkTKo/v3H8VtaoS6tbsQcS7K35x6NwFM0RltcL1lbXsgcoqI
 C/FtWaZm01SK3j1m6hav4JUcP20Cw3oBMbPgTgKQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgm9bbq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:13:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60OCDl3F024995;
 Sat, 24 Jan 2026 12:13:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgm9bbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:13:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60O7M6jw027233;
 Sat, 24 Jan 2026 12:13:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnng06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:13:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60OCDgBc50331910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Jan 2026 12:13:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7831E20043;
 Sat, 24 Jan 2026 12:13:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B25CE20040;
 Sat, 24 Jan 2026 12:13:39 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.49]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 24 Jan 2026 12:13:39 +0000 (GMT)
Date: Sat, 24 Jan 2026 17:43:36 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
Subject: Re: [PATCH 4/4] ppc/pnv: Add OCC FLAG registers
Message-ID: <aXS2ePO8_CIenfjr@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-5-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218200353.301866-5-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6974b77c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Zrd1y-tnNs1JRDnTYlYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yCArJ0F_5gG7P0WA2bGMothoL6-xd92j
X-Proofpoint-ORIG-GUID: uBq7of47Ge3LSp5s0D7fU7kz9jDWmTnn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA5NCBTYWx0ZWRfXzA+krRtBSlPo
 hxJtK/XAT/CtIGJYOiRmAAj95+C95Dt0RsZSkz/jAFweQ1bUeXwaiFf3o/TZmdbyLhAtjqzUfcw
 oEYSGev6D2LYvhsT1ayrs/WpDsoO0qbYvNV4Coy+L3kNYsZbz+fF6zHcfI2eaS6j3+V01PWfw4d
 oTslF/Rpl8tRzGOrkt5MaUMLlmVGFrU7BHiQUTb1xxvQLPwowQ3rhxGPOZOrt048KUoMgncWkkS
 pWA1JkfLyiDFT+RHpvrq/7m4b6A3lJ29ERPxUjg2vP4wJ8moQYG8RKY4n7KY1e9cJJzIIe9s10A
 muup+KRWaeHGxm664QPJsSbMcFhk1QJkSpUCuv7z40GuSnJdzg3rKdTmQ8Pm3aoX6fCt0BtLSva
 TIUktRnYm5XrpkDtFDxgDfU+S3+iKaIJUm93qBIQkUBZBdlP6sBp2K2Ptb0sH2MKSs9ZJtS4IeN
 jROL/5njq1Rr/ML2H4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/12/18 02:03PM, Caleb Schlossin wrote:
> OCCFLG are scratch registers that can be shared with OCC firmware.
> Log reads and writes to the registers as a reminder when we run
> into more OCC code.
> 
> Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
>  include/hw/ppc/pnv_occ.h |  4 +++
>  2 files changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 24b789c191..e605ae0fbc 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -195,6 +195,49 @@ static const TypeInfo pnv_occ_power8_type_info = {
>  #define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
>  #define P9_OCB_OCI_OCCMISC_OR           0x6082
>  
> +/* OCC scratch registers for flag setting */
> +#define P9_OCCFLG0                      0x60ac
> +#define P9_OCCFLG7_OR                   0x60c3
> +
> +enum ScomType {
> +    SCOM_TYPE_RW          = 0,
> +    SCOM_TYPE_WO_CLEAR    = 1,
> +    SCOM_TYPE_WO_OR       = 2,
> +};
> +
> +static void rw_occ_flag_regs(PnvOCC *occ, uint32_t offset, bool read,
> +        uint64_t *val)
> +{
> +    int flag_num;
> +    int flag_type;
> +
> +    /*
> +     * Each OCCFLG register has SCOM0 - RW, SCOM1 - WO_CLEAR, SCOM2 - WO_OR
> +     * hence devide by 3 to get flag index and mod 3 to get SCOM type.

nitpick: s/devide/divide

> +     */
> +    flag_num = (offset - P9_OCCFLG0) / 3;
> +    flag_type = (offset - P9_OCCFLG0) % 3;

flag_num can be negative if offset is invalid, but since the function
is static, the current usage ensure that never happens. So, it's okay
with me.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


