Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DBCCDE002
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcesV-00036Y-FC; Thu, 25 Jun 2026 03:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcesS-00036G-6c; Thu, 25 Jun 2026 03:52:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcesP-0002dW-9S; Thu, 25 Jun 2026 03:51:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mRFQ2977805; Thu, 25 Jun 2026 07:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=hsKRRPRmY1SDTHNlTNLTPMQ3hngl1a
 grhEXwv033niI=; b=WIDgcDMY4nXTNI5ozuRpmUJKruPZZutrzLG6tHcg4tp+Kt
 9KK1bFVCk8Wu12wbZUHQbnARzkb3Z+YZTiYC726TekAKglYsgp6GsvbW5BX+6D/S
 zR9urq1zQESYvkZ/Z5BnP9tDbynOldqJJmMZ4/wkj2ojoTu08IaK+SOYJjCycHr0
 OvlYj++SOTkUbBMufFacIPQnAk65C8ntyKDkXf+ST8Qv3i/Y0t8tFYEEP2/4UKvO
 eSWDR5/3A+G/UQjtbuGqM05uLfd2YfzVyJ+TaqyaJifPHmUFsgUDX6WVWzwzxxFT
 7L5qzysTPZL0pIX0kal40HQLi+BYLZtILNWfUIPw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4rmsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:51:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P7YmTm023943;
 Thu, 25 Jun 2026 07:51:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qn9me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:51:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P7pmiL50987376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 07:51:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C4F2004E;
 Thu, 25 Jun 2026 07:51:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 240EE20040;
 Thu, 25 Jun 2026 07:51:46 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.178]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2026 07:51:45 +0000 (GMT)
Date: Thu, 25 Jun 2026 13:21:43 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: Re: [PATCH 1/2] ppc/pnv: avoid regenerating DTB if external DTB is
 present
Message-ID: <ajzdgJ_PzoHE7VSj@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260623063156.1110370-2-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623063156.1110370-2-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfXwewjykW/i9WG
 1s+tORY1C1+uIMJcaURRdUHsF8bqVrzQ1dkUCxStzQ/YFc1hMNEntJufOK3wUkk28DZxj0YYk1d
 NPb++hQC50Ydm3+Z90yJaQzpbKC1rVg=
X-Proofpoint-ORIG-GUID: _75Dme_TZc1KnM1I-vVi4HDbbcu9YBxZ
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3cde19 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=MacDSDUIfHXgkWtIPksA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX/yoevy+0ZUQK
 /f0IA7HLmyrqIBSSeEJ9cToUDkx0lo9q+2GRAyACrZim0aRoMpy9H30kfRBXoeD+8REsgibrKHi
 XkAy+HQnnECNUvScJSt5Gn5GV6IPB8c9UYqkJClW3ZH4CHScxSA3enZhc4LSGy8guIU40EFm+IO
 jsovSDsmC2182y7GKDURTEKAyLpE+ayXD55JBuYEWJALWVD7ah9kBnDj8jeCPgbxMXPBJCOXKhH
 91ZfenFeIjqdRH0xTquk6r/pLINCpBUOzrL7i8rlzTot3FJimRCYaTHGrrAv3m4sT+bk6OAkQwV
 QpcbtHu8ZcMmozXon4KMYiuatVSh4sD/1p0dv3R8kX9BzxS95YdiGUyStTe1Q2R02r85JOaVTqM
 K0YOTJfOcQuQTkaSUAde7XWbn2lqUYhfYIchgp//A5d8ysZcY8kY02zf4mnsShfxUDf+QMH+tJ4
 Y8Vx3wJjfa6WdFUyEMw==
X-Proofpoint-GUID: i8-WM3M_UbTUo-fVD1rE82gmSd5eGOd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

On 26/06/23 12:01PM, Shivang Upadhyay wrote:
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  hw/ppc/pnv.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 62812f22f8..6a636b5192 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -803,8 +803,14 @@ static void pnv_reset(MachineState *machine, ResetType type)
>          mpipl_write_succeeded = do_mpipl_write(pnv);
>      }
>  
> -    /* Regenerate device tree */
> -    fdt = pnv_dt_create(machine);
> +    if (machine->dtb) {
> +        int file_size; /* discard */
> +        fdt = load_device_tree(machine->dtb, &file_size);
> +    } else {
> +        /* Regenerate device tree */
> +        fdt = pnv_dt_create(machine);
> +    }
> +

load_device_tree is being done in pnv_init also, how about this ?

	/* only create new dt if -dtb wasn't explicity passed */
	if (!machine->dtb) {
		pnv_dt_create
		fdt_pack
	}

also, keep this before the mpipl block, ie. after qemu_devices_reset ?

Thanks,
- Aditya G


