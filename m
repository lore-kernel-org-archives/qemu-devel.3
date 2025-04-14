Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FB8C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KPh-0003H3-P1; Mon, 14 Apr 2025 10:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4KPf-0003GW-3o; Mon, 14 Apr 2025 10:03:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1u4KPc-0001ye-JR; Mon, 14 Apr 2025 10:03:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAtPJC029154;
 Mon, 14 Apr 2025 14:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=D+Gf5iytaA3bbAOcceCiur8MFjBK7O
 VB5L6pspQjmt0=; b=cBfRxaXCX/ApbDYCpkx0SHhP38O8zMNRgELZPXsT6yMcBh
 jp7erVc21j2OjKv5+JN4/6bOrztkxA9XSOH0sdk27t5gVVnCnmxOoGEluxeSpJf7
 TijhfjpdtxIT2zWO8MQEqDIbZHH/9V4Zht1COcUrTwT14P0rjQSC8BqRdfLXHUvj
 PJQiNA/gyFI28w52RA93bVC4zlJis/MTF7tqWVbN8a0ptIXi/vrtMLKa2LfAV2UX
 +Fb9GhLvXGFlvtSAuAOgKgor3kdpzu0krpCGJ1bSjfQhz4q8lvGnSpyBZI3dMWov
 dq3GIM4I9eKQ9AZty0MnY/U4FaPhhzKlYy9inK/w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460ndsuj7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 14:03:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EB1wJd024888;
 Mon, 14 Apr 2025 14:03:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gt6tx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 14:03:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EE3g4R50332020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 14:03:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 414F92004B;
 Mon, 14 Apr 2025 14:03:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15E8820043;
 Mon, 14 Apr 2025 14:03:42 +0000 (GMT)
Received: from osiris (unknown [9.155.199.163])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Apr 2025 14:03:42 +0000 (GMT)
Date: Mon, 14 Apr 2025 16:03:40 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 3/3] target/s390x: Return UVC cmd code, RC and RRC
 value when DIAG 308 Subcode 10 fails to enter secure mode
Message-ID: <20250414140340.61624-E-seiden@linux.ibm.com>
References: <20250411092233.418164-1-ggala@linux.ibm.com>
 <20250411092233.418164-4-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411092233.418164-4-ggala@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: epX6Y5Pfa29ZzRvIjZWiOK1SDw3FGGm3
X-Proofpoint-ORIG-GUID: epX6Y5Pfa29ZzRvIjZWiOK1SDw3FGGm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140102
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 11, 2025 at 11:22:33AM +0200, Gautam Gala wrote:
> Extend DIAG308 subcode 10 to return the UVC RC, RRC and command code
> in bit positions 32-47, 16-31, and 0-15 of register R1 + 1 if the
> function does not complete successfully (in addition to the
> previously returned diag response code in bit position 47-63).
> 
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
>  hw/s390x/ipl.c             | 11 ++++++----
>  hw/s390x/ipl.h             |  5 +++--
>  hw/s390x/s390-virtio-ccw.c | 24 +++++++++++++++------
>  target/s390x/kvm/pv.c      | 44 +++++++++++++++++++++++++-------------
>  target/s390x/kvm/pv.h      | 27 ++++++++++++++++-------
>  5 files changed, 76 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ce6f6078d7..4f3e3945f1 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -676,7 +676,8 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
>  
> -int s390_ipl_prepare_pv_header(Error **errp)
> +int s390_ipl_prepare_pv_header(Error **errp, uint16_t *pv_cmd,
> +                               uint16_t *pv_rc, uint16_t *pv_rrc)

`Error **errp` should be the last argument. (multiple locations)

...
  
> +struct diag308response {
> +    uint16_t pv_cmd;
> +    uint16_t pv_rrc;
> +    uint16_t pv_rc;
> +    uint16_t diag_rc;
> +};
> +

I think Qemu style wants you to use CamelCase here.
See e.g `390CcwMachineState` below


>  static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
>                                Error **errp)
>  {
> @@ -364,7 +371,10 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
>      ram_block_discard_disable(false);
>  }
>  

...

> @@ -452,6 +462,7 @@ static void s390_machine_reset(MachineState *machine, ResetType type)
>  {
>      S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
>      enum s390_reset reset_type;
> +    struct diag308response resp;

Reverse Christmas tree.

>      CPUState *cs, *t;
>      S390CPU *cpu;
>  

...

