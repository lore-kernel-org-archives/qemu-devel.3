Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2755CE9D7D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 17:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdAPU-00054G-NT; Tue, 06 Jan 2026 11:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAPS-000535-V7; Tue, 06 Jan 2026 11:59:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAPR-00051w-5u; Tue, 06 Jan 2026 11:59:54 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606F2x8S028393;
 Tue, 6 Jan 2026 16:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Ic2h+SRB+tnT6X5+5cBVSIlETXheks95s13Pb6LWDfc=; b=SJi4camy6fWX
 4ntdr3Cir/HgspJ4OTNoaQJenJwwFMWAU51wQ44XhwjAuwG7amcboArejJRbOQZl
 p+OOwbxa2EfWsYUUDuA2q9tWasIcnaJDzncbvbnpNdrv7Zg7Ti/bxjMt3q71RKMc
 poznDgatuZEzryfSsvbVuogjjupMHNiHYDFktw6uLJfss4acXKok1/+wdALsxlvL
 XQ06lKwlMFyAbToW7RY+jqG1aPYdqE6PhE8qNy+KsdODihDXbAb1Gy/9C7udXmTc
 SH80B2vOCu3ixvtA9sU3D5Bv1iCCkZgMeqALOiEQeefknSy0MHGMQ864aDfeqE9g
 tVnbpXw57A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtm1nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:59:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606GvZeG025646;
 Tue, 6 Jan 2026 16:59:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtm1nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:59:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606GLbsv005264;
 Tue, 6 Jan 2026 16:59:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexk4fpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:59:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606GxnDQ28836580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 16:59:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C4EB58062;
 Tue,  6 Jan 2026 16:59:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2BD55805A;
 Tue,  6 Jan 2026 16:59:48 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 16:59:48 +0000 (GMT)
Message-ID: <eb6226b9390fe2fcc6aaee3882af7607f13c94b8.camel@linux.ibm.com>
Subject: Re: [PATCH 3/4] ppc/pnv: Add unimplemented quad and core regs
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 chalapathi.v@linux.ibm.com
Date: Tue, 06 Jan 2026 10:59:48 -0600
In-Reply-To: <20251218200353.301866-4-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-4-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695d3f87 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwmPzSXVq4500yFet8UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ewf2m9m_JmN24P_EG9k6wW_2S5LBCQ7M
X-Proofpoint-ORIG-GUID: SJh39qtSACB5lbN24nvIf-G0iRtFhFwd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfX/y4j6oh2R1E6
 U+dd5IlPxguXV8ZzryQb2hcxEl+oxp7bRIVpqG0WQxFuFyiTnjBpXXxCTe7difdJ9zttvzcd+dO
 Sj31xh0DPNjaIzMvyFIzeUIB7fZPGW/cNrHFyFNmttcCy0OLtzwrKyq5Zmr1aYlue0pxHlMvomv
 oATISecPm4W4Hrf2cwKVi47WIN79Z6i8LBOcNquZ7qnll6aak/A+/NnNasSLIoyYKIr3dOCpkHL
 MLwQDaZeMdFCqBhH0PbLurZcgS21pcxYLjCV2+5lucftYDw10mYJiXt9EOYsIsYAw7nBCP60FWz
 AH4vCspgKS0O82ibQM1SNHCwFG7NE9ZR8PiH1h9Gyr6K9POsUKOxgju1n6l5lSCFR08/UOGqYM/
 M/6w7gT5Ljl2mJZRTepnTqzqe5AxHb+HJhCJ9JL7nhYdJ9BiAvPUkqxU/TadmtXYYVkP7Gvqz6p
 JdPHO5fkr3p2sUoPi7Q==
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
> This commit adds the read/write functionality for few core and
> quad registers.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index fb2dfc7ba2..84a2fa6364 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -184,10 +184,18 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>   * POWER10 core controls
>   */
>  
> +#define PNV10_XSCOM_EC_IMA_EVENT_MASK       0x400
>  #define PNV10_XSCOM_EC_CORE_THREAD_STATE    0x412
>  #define PNV10_XSCOM_EC_CORE_THREAD_INFO     0x413
> +#define PNV10_XSCOM_EC_CORE_FIRMASK         0x443
> +#define PNV10_XSCOM_EC_CORE_FIRMASK_AND     0x444
> +#define PNV10_XSCOM_EC_CORE_FIRMASK_OR      0x445
>  #define PNV10_XSCOM_EC_CORE_DIRECT_CONTROLS 0x449
>  #define PNV10_XSCOM_EC_CORE_RAS_STATUS      0x454
> +#define PNV10_XSCOM_EC_SPATTN_OR            0x497
> +#define PNV10_XSCOM_EC_SPATTN_AND           0x498
> +#define PNV10_XSCOM_EC_SPATTN               0x499
> +#define PNV10_XSCOM_EC_SPATTN_MASK          0x49A
>  
>  static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>                                             unsigned int width)
> @@ -223,6 +231,19 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
>              }
>          }
>          break;
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +        return 0;
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Write only register, ignoring "
> +                              "xscom read at 0x%08x\n", __func__, offset);
> +        break;
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        return 0;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                        offset);
> @@ -283,6 +304,15 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
>          }
>          break;
>  
> +    case PNV10_XSCOM_EC_IMA_EVENT_MASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_OR:
> +    case PNV10_XSCOM_EC_CORE_FIRMASK_AND:
> +    case PNV10_XSCOM_EC_SPATTN_OR:
> +    case PNV10_XSCOM_EC_SPATTN_AND:
> +    case PNV10_XSCOM_EC_SPATTN:
> +    case PNV10_XSCOM_EC_SPATTN_MASK:
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                        offset);
> @@ -568,6 +598,23 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>   * POWER10 Quads
>   */
>  
> +#define P10_XSCOM_EQ3_MODE_REG1         0x1160a
> +#define P10_XSCOM_EQ3_NCU_SPEC_BAR_REG  0x11650
> +#define P10_XSCOM_EQ3_HTM_MODE          0x11680
> +#define P10_XSCOM_EQ3_HTM_IMA_PDBAR     0x1168b
> +#define P10_XSCOM_EQ2_MODE_REG1         0x1260a
> +#define P10_XSCOM_EQ2_NCU_SPEC_BAR_REG  0x12650
> +#define P10_XSCOM_EQ2_HTM_MODE          0x12680
> +#define P10_XSCOM_EQ2_HTM_IMA_PDBAR     0x1268b
> +#define P10_XSCOM_EQ1_MODE_REG1         0x1460a
> +#define P10_XSCOM_EQ1_NCU_SPEC_BAR_REG  0x14650
> +#define P10_XSCOM_EQ1_HTM_MODE          0x14680
> +#define P10_XSCOM_EQ1_HTM_IMA_PDBAR     0x1468b
> +#define P10_XSCOM_EQ0_MODE_REG1         0x1860a
> +#define P10_XSCOM_EQ0_NCU_SPEC_BAR_REG  0x18650
> +#define P10_XSCOM_EQ0_HTM_MODE          0x18680
> +#define P10_XSCOM_EQ0_HTM_IMA_PDBAR     0x1868b
> +
>  static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
>  {
> @@ -575,6 +622,23 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>      uint64_t val = -1;
>  
>      switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
> +        return 0;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
>                        offset);
> @@ -589,6 +653,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
>      uint32_t offset = addr >> 3;
>  
>      switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                        offset);


