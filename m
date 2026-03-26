Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1A710A1E68
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ii3-0002XM-5m; Thu, 26 Mar 2026 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5ihr-0002WY-AP; Thu, 26 Mar 2026 07:16:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5ihp-00016F-K7; Thu, 26 Mar 2026 07:16:55 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q1s7pQ1687734; Thu, 26 Mar 2026 11:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=MQ1ES5O+WFAXFoKKM1jsiMvJVQBSRn
 vmyZK2oQV7mtA=; b=pi31fMAI+rtmgSRXhGUu/Rt6Q1P0ObcGtpT9hydgjqtWNV
 uzTfa8KGQ/dVLkZwD0Xu3v32cZQfDdgy3HUmCvGDEPE1Rltj5LfFAdtr7Jhqe+jC
 7PS0Vc0BOUwoQPlYgVgRCtFjTgu6A0XGLrQQ7xX43DhStnV92mjNE5GP86Tqt9gf
 AuAbbA6TIprvSCSXc20PBb00g51XXghMmmpvNb0ARzuOCPDff5IDiXMUKsep3R1O
 QsA8vnzUoejlOkPfwFzj0cwPQIeFcH9p4ovGqP93tw8/xL3d+BDJp69H8ygmGGXh
 Ym4cSHFhOaAZZEjfcbr6WYOIDSqFcGyplM5Y6BLA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky0bump-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 11:16:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q8GEN8004407;
 Thu, 26 Mar 2026 11:16:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c2ae3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 11:16:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QBGiER44237082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 11:16:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5D6F2004B;
 Thu, 26 Mar 2026 11:16:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44C1920040;
 Thu, 26 Mar 2026 11:16:41 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Mar 2026 11:16:41 +0000 (GMT)
Date: Thu, 26 Mar 2026 16:46:39 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ppc/pnv: generate dtb after machine initialization is
 complete
Message-ID: <acUTurZoQJf8jRhJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260324135026.247418-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324135026.247418-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA3NCBTYWx0ZWRfX7PBHo9yBRKZ8
 lFmotDzOTw5rjSQXJIqQSKBdUTzVVxtd1iycYb1K1tJ3JcRs9jH6jnBwBz3wo2NTpUG6BAm6rD9
 8RjlaXvfHkKHG5xLwBtmeyArWAYZcmmUmX64j/zteWcrpeK7u6WFky9F7TsZ6/aZMNZJmkkWaup
 HnBi9QoR7eacD5sb9Yvg4tHV0FXoG7KKS0FZLkRo9dlIwaeFn8w8IbdfN6i26uuzmsiRUZDjkBE
 ODMEfBT9w92wj3BxFe2C4c2bz11JYqyLBhQ98rVQxMEVhqMO504S+GnwFGtbU66Cso4ePKiacin
 5gJct+5mVn6yFIvOKVLbjBT7gBfZyN/WUCZ03cgc8At/Frnf/bqXPTjRxCEX9oRFRWU2H44VuDK
 M8JD+5+cLvd/jQmNIaijzAmXU50QIoxoWoVLFVCoPtImS9x8rX7eKiYDjcm8Sr8QrSsoUk1uHvm
 BEf8ttaNSF+S6e9YqGQ==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c515a0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=WM5r8-xwWLsYA99Q0PsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: WdtHMMKnimmzyNKYjqsOKLdV9FnxAHxp
X-Proofpoint-GUID: WdtHMMKnimmzyNKYjqsOKLdV9FnxAHxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 26/03/24 07:20PM, Shivang Upadhyay wrote:
> <...snip...>
>
> +static void pnv_machine_init_done(Notifier *notifier, void *data)
> +{
> +    PnvMachineState *pnv = container_of(notifier, PnvMachineState, machine_init_done);
> +    MachineState *machine = MACHINE(pnv);
> +
> +    if (!machine->fdt) {
> +        machine->fdt = pnv_dt_create(machine);
> +        _FDT((fdt_pack(machine->fdt)));
> +    }
> +}
> +
>  static void pnv_init(MachineState *machine)
>  {
>      const char *bios_name = machine->firmware ?: FW_FILE_NAME;
> @@ -1244,10 +1255,8 @@ static void pnv_init(MachineState *machine)
>          pmc->i2c_init(pnv);
>      }
>  
> -    if (!machine->fdt) {
> -        machine->fdt = pnv_dt_create(machine);
> -        _FDT((fdt_pack(machine->fdt)));
> -    }
> +    pnv->machine_init_done.notify = pnv_machine_init_done;
> +    qemu_add_machine_init_done_notifier(&pnv->machine_init_done);
>  }
>  
>  /*

Thanks for fixing it. Just adding few more info from what I see.
OPAL was stuck at cec-power-down, since it expects an ipmi-bt device for
shutdown to work in QEMU.

So, the issue was not directly due to missing BMC device, rather due to
missing 'isa-ipmi-bt' device, which the patch does fix, and hence the
issue is fixed.

But still the dts we have is different from what we should have at
pnv_reset. Adding a pnv_dt_create at the end of pnv_reset, as it used to
be before, gives me a 'bmc' node also in device tree.

	$ diff /tmp/dts.machinedone /tmp/dts.pnvreset 
	16a17,33
	>       bmc {
	> 
	>               sensors {
	>                       #size-cells = <0x00>;
	>                       #address-cells = <0x01>;
	> 
	>                       sensor@0 {
	>                               ipmi-sensor-type = <0x23>;
	>                               ipmi-entity-instance = <0x01>;
	>                               ipmi-entity-id = <0x23>;
	>                               ipmi-sensor-reading-type = <0x6f>;
	>                               compatible = "ibm,ipmi-sensor";
	>                               reg = <0x00>;
	>                       };
	>               };
	>       };
	> 

This isn't handled at machine_init_done as 'pnv->bmc' is not set at this
time

Two ways to fix it:
1. Have pnv_dt_create in pnv_reset as well, like previously
2. Move the pnv_bmc_find code in pnv_reset to pnv_init

What do you say ?

> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -111,6 +111,8 @@ struct PnvMachineState {
>  
>      bool         big_core;
>      bool         lpar_per_core;
> +
> +    Notifier     machine_init_done;

One minor note, all other machines in qemu use 'machine_done' as the
notifier name, but I am good with 'machine_init_done' also, as this
makes more sense to me.

Thanks,
- Aditya G


