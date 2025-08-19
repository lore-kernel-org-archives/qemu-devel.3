Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E7BCA0EE9
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 06:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoGGD-0007WD-64; Tue, 19 Aug 2025 02:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uoGG7-0007Uk-EO; Tue, 19 Aug 2025 02:55:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1uoGG5-0003Zk-CE; Tue, 19 Aug 2025 02:55:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IN8bdu009937;
 Tue, 19 Aug 2025 06:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ZL9I3dAeUBwSSmd2Mm3A1/nztviYjj
 4MAp6ZmZRWY+U=; b=IgGViYQVGZ6HylRIhF4KhwrVKkHoBBajEoRpPNLgHQU/VX
 S+tsuJuLChOQU0dnN+UuX3/GO3qHY2EInirL8PMMK+arM1VCeRPoOMZFNo6GNDYx
 FkzBr35MImRlO5uDQh3Vd9TvrG5rGeQRbZQ66511UdW6lKeEdg063f9gtSL5BpzF
 4D6GD6IwW21CVfvDywYX97zB4QgowzMSRrchv13niSEMfLKmt7S/rukWDJpoXPpy
 5ElkUO+ujRb/Q2utBMrRS/BRuDKZgaAzZN5i4i+oALP56GrCDHkiMKEfBm24DRU1
 IFAFHmvU8WXpQHZcV1aZA/e0pbDbr2McmMw1bs8Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhny5a5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 06:55:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57J6egom006442;
 Tue, 19 Aug 2025 06:55:45 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhny5a4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 06:55:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57J6HaEn003162;
 Tue, 19 Aug 2025 06:55:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm8x4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 06:55:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57J6teqe19005850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 06:55:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEFFE20043;
 Tue, 19 Aug 2025 06:55:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 810CB20040;
 Tue, 19 Aug 2025 06:55:38 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown
 [9.204.207.58])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 19 Aug 2025 06:55:38 +0000 (GMT)
Date: Tue, 19 Aug 2025 12:25:33 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 pbonzini@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 vaibhav@linux.ibm.com, nicholas@linux.ibm.com
Subject: Re: [PATCH v2] hw/ppc/spapr_hcall: Return host mitigation
 characteristics in KVM mode
Message-ID: <aKQf5dYMEsjfPaXa@li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com>
References: <20250417111907.258723-1-gautam@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417111907.258723-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbqJzJ55 c=1 sm=1 tr=0 ts=68a41ff2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=voM4FWlXAAAA:8 a=VnNF1IyMAAAA:8
 a=WI5HHvvhWpJfBEWMsrIA:9 a=CjuIK1q_8ugA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: f1CBjWWrY0tXtanfq553VbP_n2cSEyTQ
X-Proofpoint-GUID: sS8IRelWu9tR4f4aR83vp9FLpt8r9YfJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfX8cy78OUZ2VTx
 VAZ9IhW5ZalLrFw1x7mYWtZvNMrzQEQ3INs4F0IZmweG+p+mErnosEsia+iUTJHfAiuwBdxpAHR
 BMhHWQ5r07MHzCJX+H6RifvZ34Qp1lWTQAYLfcYAcvOmpZGYcSjZxnpCDgwbDhuB+/7p2Vl6oio
 03H9r5HnxpI3aHFy23PcK6Pg2clnF8N2mdOjiruC8UPJsJxK05sK24qsX7gyXyB1SHvsXrkccXF
 GTkywvqCAObHAxMvBbZTHnW4Af0U3vlRKQUOPnqqsjuLP6e8aa1kdw9oROeTykB9bQGDLu0+1lD
 epXZ05MzVPtSThvc4chPbu2rfECYVQuwSU7kzIl8yX8QWwSjie+hGuvKkjztm6cqzODwfCxU7Rk
 kGhS5gh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


+ Nicholas M (Forgot to include the text in the prev mail, please ignore
that)

On Thu, Apr 17, 2025 at 04:49:03PM +0530, Gautam Menghani wrote:
> Currently, on a P10 KVM guest, the mitigations seen in the output of
> "lscpu" command are different from the host. The reason for this
> behaviour is that when the KVM guest makes the "h_get_cpu_characteristics"
> hcall, QEMU does not consider the data it received from the host via the
> KVM_PPC_GET_CPU_CHAR ioctl, and just uses the values present in
> spapr->eff.caps[], which in turn just contain the default values set in
> spapr_machine_class_init().
> 
> Fix this behaviour by making sure that h_get_cpu_characteristics()
> returns the data received from the KVM ioctl for a KVM guest.
> 
> Perf impact:
> With null syscall benchmark[1], ~45% improvement is observed.
> 
> 1. Vanilla QEMU
> $ ./null_syscall
> 132.19 ns     456.54 cycles
> 
> 2. With this patch
> $ ./null_syscall
> 91.18 ns     314.57 cycles
> 
> [1]: https://ozlabs.org/~anton/junkcode/null_syscall.c
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> Handle the case where KVM_PPC_GET_CPU_CHAR ioctl fails
> 
>  hw/ppc/spapr_hcall.c   |  6 ++++++
>  include/hw/ppc/spapr.h |  1 +
>  target/ppc/kvm.c       | 13 ++++++++++---
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 5e1d020e3d..d6db1bdab8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1402,6 +1402,12 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>      uint8_t count_cache_flush_assist = spapr_get_cap(spapr,
>                                                       SPAPR_CAP_CCF_ASSIST);
>  
> +    if (kvm_enabled() && spapr->chars.character) {
> +        args[0] = spapr->chars.character;
> +        args[1] = spapr->chars.behaviour;
> +        return H_SUCCESS;
> +    }
> +
>      switch (safe_cache) {
>      case SPAPR_CAP_WORKAROUND:
>          characteristics |= H_CPU_CHAR_L1D_FLUSH_ORI30;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index af4aa1cb0f..c41da8cb82 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -280,6 +280,7 @@ struct SpaprMachineState {
>      Error *fwnmi_migration_blocker;
>  
>      SpaprWatchdog wds[WDT_MAX_WATCHDOGS];
> +    struct kvm_ppc_cpu_char chars;
>  };
>  
>  #define H_SUCCESS         0
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 3efc28f18b..fec7bcc347 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2499,7 +2499,8 @@ bool kvmppc_has_cap_xive(void)
>  
>  static void kvmppc_get_cpu_characteristics(KVMState *s)
>  {
> -    struct kvm_ppc_cpu_char c;
> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    struct kvm_ppc_cpu_char c = {0};
>      int ret;
>  
>      /* Assume broken */
> @@ -2509,18 +2510,24 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
>  
>      ret = kvm_vm_check_extension(s, KVM_CAP_PPC_GET_CPU_CHAR);
>      if (!ret) {
> -        return;
> +        goto err;
>      }
>      ret = kvm_vm_ioctl(s, KVM_PPC_GET_CPU_CHAR, &c);
>      if (ret < 0) {
> -        return;
> +        goto err;
>      }
>  
> +    spapr->chars = c;
>      cap_ppc_safe_cache = parse_cap_ppc_safe_cache(c);
>      cap_ppc_safe_bounds_check = parse_cap_ppc_safe_bounds_check(c);
>      cap_ppc_safe_indirect_branch = parse_cap_ppc_safe_indirect_branch(c);
>      cap_ppc_count_cache_flush_assist =
>          parse_cap_ppc_count_cache_flush_assist(c);
> +
> +    return;
> +
> +err:
> +    memset(&(spapr->chars), 0, sizeof(struct kvm_ppc_cpu_char));
>  }
>  
>  int kvmppc_get_cap_safe_cache(void)
> -- 
> 2.49.0
> 

