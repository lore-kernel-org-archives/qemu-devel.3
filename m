Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF674CEFCE2
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 17:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdARg-0006Tt-HU; Tue, 06 Jan 2026 12:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAQc-0005np-NF; Tue, 06 Jan 2026 12:01:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAQa-0005Ji-VG; Tue, 06 Jan 2026 12:01:06 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6064XndU006801;
 Tue, 6 Jan 2026 17:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=hOZA84mGuA1L1+49bepHJk8Y1ECL62nTsW2lPRPbCAc=; b=aUAOuL9jxNnS
 qQBa1GLjfKlC6kXxDHFe3s/AoyzWQzW9v61el0QEgqd8C39ctPsxykJfQhVinXaV
 o8yPAlHj785DsiJ6f0Z9oQ16+Lpx2Vcxf634j7FeJRFZWiaGTv+jMY5n0NXcEQpZ
 3VndHO6YFZECaWk2ldKdMmsSR+Q1KRqQvu2FJ8DyYjeUN0k0XkHRnEwlkt3EPS61
 yQ/IKz8/VDGlhGcMrMqhGEDhdEIthR3UVTYbW8j++7uIz9Fh7tvJwu0PLdvW7LsN
 An/63VKXIG8T5kEDYCxba7UxbiR5rbLK6MTgSLj6BrfpwzD3yuuQSHW5JErAeTbt
 TVEFaJpCxw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtm1vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 17:01:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606GstRA019560;
 Tue, 6 Jan 2026 17:01:02 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtm1vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 17:01:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606FXLr9015202;
 Tue, 6 Jan 2026 17:01:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdescq13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 17:01:02 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606H10Eq66453932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 17:01:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BA7A5805F;
 Tue,  6 Jan 2026 17:01:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B63358059;
 Tue,  6 Jan 2026 17:00:59 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 17:00:59 +0000 (GMT)
Message-ID: <a16b12c3a5553a2e5f866e8162a9e74d164620ad.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/pnv: Add OCC FLAG registers
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 chalapathi.v@linux.ibm.com
Date: Tue, 06 Jan 2026 11:00:59 -0600
In-Reply-To: <20251218200353.301866-5-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-5-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d3fcf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=gJvJ13wZk_tzsm1i31wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Wg3fgoo5Ji78qFL1gAZoYNIvzQXpABfA
X-Proofpoint-ORIG-GUID: A9I2iN3271mLF3Vo7xI3jXsQLAWy089e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfXyCV5NkAjIsje
 5X1Aco6VY3gXcwru4T19uZZzEUSdw7FsLYNOHmqEWMkWm8V9+a5G7Pz7+so5Qy6HX62rTt1pSnP
 2ANeW/zp3Ijh0nuFXHp+nQKlXSJmiXjmW2Enm605qsM3/xHnZhdHhHYMVViB4Yw+cF8SWWIdgVd
 R8D5goZqzDuVDmg68pLsJkPjTJklkLIVlA3lW/pF3FGt2HTfynJq48AxabHJ3kdFWTdzXl6NaEU
 Y6mAwy8B7u3rb2JX8re6VPibnc3Qup3QFhdHNaDFks/Bw36EwxV3MYx7Ml1wayz4JF9yRhMJhhw
 qGhLIPqnxMvkeYy+UXuxBwz58LHK4bcrET+qsgiLU5OS+1ySCrSR37teTICQKNnFN7SVtn+tEmY
 z4Q/56IoHO1bnq6kML6ZW/jvFj9GocR5aOZmgq3QyznA/zAptkfVeaXyc1yC+SgYjzCpN469PTF
 L7VPehe7PcBm+93tP6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2025-12-18 at 14:03 -0600, Caleb Schlossin wrote:
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
> +     */
> +    flag_num = (offset - P9_OCCFLG0) / 3;
> +    flag_type = (offset - P9_OCCFLG0) % 3;
> +
> +    if (read) {
> +        if (flag_type) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "OCC: Write only register: Ox%"
> +                      PRIx32 "\n", offset);
> +            return;
> +        }
> +        *val = occ->occflags[flag_num];
> +    } else {
> +        switch (flag_type) {
> +        case SCOM_TYPE_RW:
> +            occ->occflags[flag_num] = *val;
> +            break;
> +        case SCOM_TYPE_WO_CLEAR:
> +            occ->occflags[flag_num] &= ~(*val);
> +            break;
> +        case SCOM_TYPE_WO_OR:
> +            occ->occflags[flag_num] |= *val;
> +        }
> +    }
> +}
>  
>  static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
>                                            unsigned size)
> @@ -207,8 +250,11 @@ static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
>      case P9_OCB_OCI_OCCMISC:
>          val = occ->occmisc;
>          break;
> +    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
> +        rw_occ_flag_regs(occ, offset, 1, &val);
> +        break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register read: Ox%"
>                        HWADDR_PRIx "\n", addr >> 3);
>      }
>      return val;
> @@ -229,9 +275,12 @@ static void pnv_occ_power9_xscom_write(void *opaque, hwaddr addr,
>          break;
>      case P9_OCB_OCI_OCCMISC:
>          pnv_occ_set_misc(occ, val);
> -       break;
> +        break;
> +    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
> +        rw_occ_flag_regs(occ, offset, 0, &val);
> +        break;
>      default:
> -        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register write: Ox%"
>                        HWADDR_PRIx "\n", addr >> 3);
>      }
>  }
> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> index 013ea2e53e..8c9f1416eb 100644
> --- a/include/hw/ppc/pnv_occ.h
> +++ b/include/hw/ppc/pnv_occ.h
> @@ -47,6 +47,10 @@ struct PnvOCC {
>      /* OCC Misc interrupt */
>      uint64_t occmisc;
>  
> +    /* OCC Flags */
> +#define NR_FLAG_REGS 8
> +    uint32_t occflags[NR_FLAG_REGS];
> +
>      qemu_irq psi_irq;
>  
>      /* OCCs operate on regions of HOMER memory */


