Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573EED59D79
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 17:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU6wE-0005na-Of; Fri, 12 Dec 2025 12:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6wD-0005mR-7L; Fri, 12 Dec 2025 12:28:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vU6wB-00047I-Jn; Fri, 12 Dec 2025 12:28:16 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCF5Ah3007030;
 Fri, 12 Dec 2025 17:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=QpAL1Q9JjHBRrjCO1aAEWlFIoA/J21bk9AxeDwe4jC4=; b=bKb9PFcvo78u
 9gnrdlMjVuEneGF1Xsr3D8EpdKrjeMVTTEygDFGL9r5kLMPfXQtzHCWcaCZ7B/KQ
 yaXjIOvav6EGiqC9T1Ij4KH5PK5H0sFODGm0GZZLTkS0r+n1JWEHLKDc8Zk5QiPd
 /NSj1AZJ88+lXge5pDMoENm+VRl9ce4pA0/lrMaMIVzBYGiPWf49Of+KpyuMXJM3
 H3OzOGdoE25BQ7Cir82uJjLebu514bromqc1Quz0WzPm7yAsbAWfv4+vue8bxmj3
 xfscoqezao6R6EDc+Vlb0Nh5I/uFS38IByH+fbPsWSp2SUZBT2mixUsxBTjbUNQv
 0IN6JhG+iQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0kepsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:28:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BCHG2F6012493;
 Fri, 12 Dec 2025 17:28:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0keps4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:28:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BCGrJx4028156;
 Fri, 12 Dec 2025 17:28:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6yd8gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Dec 2025 17:28:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BCHS8vC20447824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Dec 2025 17:28:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 875F958065;
 Fri, 12 Dec 2025 17:28:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DED25805D;
 Fri, 12 Dec 2025 17:28:08 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Dec 2025 17:28:07 +0000 (GMT)
Message-ID: <c9a2ae0e412009867643881e24c6dd2e82a6ffbc.camel@linux.ibm.com>
Subject: Re: [PATCH 6/6] hw/ppc: pnv_chiptod.c add vmstate support
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
Date: Fri, 12 Dec 2025 11:28:07 -0600
In-Reply-To: <20251211220926.2865972-7-calebs@linux.ibm.com>
References: <20251211220926.2865972-1-calebs@linux.ibm.com>
 <20251211220926.2865972-7-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=693c50ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=mnj8XHQIT5kTmT_5M08A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AvnhCRHIot_Tr1n0tfIUw0g06ncbe83D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfXzTt98zOqhR4B
 KAbpCDw3KFJLgjGgUpkRVF0nJiMXTRQ55iEu+BgOCb7QFGtRpXv9bNWey/jl2p+Y7ezFdgKFqDw
 STvGq5PYULy7BONi0Aj6d9Ol8LId5vHFTGY3Rw5481spJsTE8DKwC2ZjDawLGb7WL5zSN1vOa4/
 UMR/dNkKYf5quJcuzJcPXIP1NnBGIbF6qiP80W2KGsfWwnc8Y3kEszzhf0cM4k84G/yadF8mvlo
 ySZX/Yd6brei0DVFjHifUeIFFyoKSX1Uw83B2K3hhxhcq9u2nScoyyoj934ldt+LUCribBoWU1w
 Qlk802HyJMYKg4NckLbJv9RPepW3REuoFqgBnrgTnqVlJahP1L3pE+WVGdFMG9RcG/Q1kZJB+9u
 yva1d+rFO45faJ6graD8UdRbgxUH7Q==
X-Proofpoint-GUID: Fi1WlsgXmdR205sUBTLv5FJbUjwysVPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_04,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016
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

On Thu, 2025-12-11 at 16:09 -0600, Caleb Schlossin wrote:
> - Added pre_save and post_load methods to handle slave_pc_target and tod_state
> 
> Signed-off-by: Angelo Jaramillo <angeloj@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_chiptod.c         | 38 ++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/pnv_chiptod.h |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index f887a18cde..9dc5942ca0 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -37,6 +37,7 @@
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_xscom.h"
>  #include "hw/ppc/pnv_chiptod.h"
> +#include "migration/vmstate.h"
>  #include "trace.h"
>  
>  #include <libfdt.h>
> @@ -341,6 +342,8 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                            " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
>                            " invalid slave address\n", val);
>          }
> +        /* Write slave_pc_target to a uint64_t variable for vmstate support. */
> +        chiptod->tx_ttype_ctrl = val;
>          break;
>      case TOD_ERROR_REG:
>          chiptod->tod_error &= ~val;
> @@ -613,6 +616,40 @@ static void pnv_chiptod_unrealize(DeviceState *dev)
>      qemu_unregister_reset(pnv_chiptod_reset, chiptod);
>  }
>  
> +static int vmstate_pnv_chiptod_pre_save(void *opaque)
> +{
> +    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
> +    chiptod->tod_state_val = (uint8_t)chiptod->tod_state;
> +    return 0;
> +}
> +
> +static int vmstate_pnv_chiptod_post_load(void *opaque)
> +{
> +    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
> +    if (chiptod->tx_ttype_ctrl != 0) {
> +        pnv_chiptod_xscom_write(chiptod, TOD_TX_TTYPE_CTRL_REG << 3,
> +                                chiptod->tx_ttype_ctrl, 8);
> +    }
> +    chiptod->tod_state = (enum tod_state)chiptod->tod_state_val;
> +    return 0;
> +}
> +
> +static const VMStateDescription pnv_chiptod_vmstate = {
> +    .name = TYPE_PNV_CHIPTOD,
> +    .version_id = 1,
> +    .pre_save = vmstate_pnv_chiptod_pre_save,
> +    .pre_load = vmstate_pnv_chiptod_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BOOL(primary, PnvChipTOD),
> +        VMSTATE_BOOL(secondary, PnvChipTOD),
> +        VMSTATE_UINT64(tod_error, PnvChipTOD),
> +        VMSTATE_UINT64(pss_mss_ctrl_reg, PnvChipTOD),
> +        VMSTATE_UINT64(tx_ttype_ctrl, PnvChipTOD),
> +        VMSTATE_UINT8(tod_state_val, PnvChipTOD),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -621,6 +658,7 @@ static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
>      dc->unrealize = pnv_chiptod_unrealize;
>      dc->desc = "PowerNV ChipTOD Controller";
>      dc->user_creatable = false;
> +    dc->vmsd = &pnv_chiptod_vmstate;
>  }
>  
>  static const TypeInfo pnv_chiptod_type_info = {
> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
> index 466b06560a..3e5e3b02b2 100644
> --- a/include/hw/ppc/pnv_chiptod.h
> +++ b/include/hw/ppc/pnv_chiptod.h
> @@ -41,6 +41,8 @@ struct PnvChipTOD {
>      uint64_t tod_error;
>      uint64_t pss_mss_ctrl_reg;
>      PnvCore *slave_pc_target;
> +    uint64_t tx_ttype_ctrl;
> +    uint8_t tod_state_val;
>  };
>  
>  struct PnvChipTODClass {


