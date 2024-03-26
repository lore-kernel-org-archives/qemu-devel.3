Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437D8C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 10:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3m6-0000NR-R1; Tue, 26 Mar 2024 06:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rp3m0-0000N1-Hf
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:11:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rp3lx-0001ju-Su
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 06:11:16 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42Q8KQcV008499; Tue, 26 Mar 2024 10:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tWoUaKKgCnEZaLrz7llZyHIbd7zBuqouZigLMVNUlS0=;
 b=Wsqsmzk/eCjXvCXfERxhUMGhSz+ZuefAsNvBUYE9HVU1hHV7O81DTh1hY1TeuIqsJLIe
 G70LTCP6dEzY/l4eY1P+xdRb5hnOkkUyrdGXzNZfnkgX7XlrHDl+W1dR+jykGDc4iE3m
 alc0XZh4blqDPPyoPmsG/I96gnc+ga2W+gewdjo+Y1b3Ey9g0dt/1c69EG1zHtoIdZcA
 ugquQMeL36IwZjmkY5C0Mz0ca9zVPID+gswYvSDH7sg9hyGBt1Rl/MA84JmZcVOzMU0e
 kOY4obArmSpb0+6gPpB8oUFGvD71C1sBd27zmQtzrx2xoOxdLg1V8iP/fdUo76svatNb 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3kb117yd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 10:11:10 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42QA7p0P030007;
 Tue, 26 Mar 2024 10:11:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3kb117xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 10:11:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42Q86Qxi011321; Tue, 26 Mar 2024 10:10:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmkxnas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 10:10:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42QAAifx15401594
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Mar 2024 10:10:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59C0358052;
 Tue, 26 Mar 2024 10:10:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB9DD58045;
 Tue, 26 Mar 2024 10:10:41 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Mar 2024 10:10:41 +0000 (GMT)
Message-ID: <2a335c28-6f3a-40c3-b2d6-0fe44dcde14a@linux.ibm.com>
Date: Tue, 26 Mar 2024 15:40:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gavin Shan <gshan@redhat.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-2-pbonzini@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20240325141422.1380087-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sa_s3rWzr-Qs1aZ4kffrPysehC5Nr0K4
X-Proofpoint-ORIG-GUID: c-Yq5EYThw6qSLBT7k7AdJZ9CMooLSR0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260069
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/25/24 19:44, Paolo Bonzini wrote:
> Add 9.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/boards.h        |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   hw/arm/virt.c              | 11 +++++++++--
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 17 ++++++++++++++---
>   hw/i386/pc_q35.c           | 14 ++++++++++++--
>   hw/m68k/virt.c             | 11 +++++++++--
>   hw/ppc/spapr.c             | 17 ++++++++++++++---

For spapr:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   10 files changed, 83 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 8b8f6d5c00d..50e0cf4278e 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -425,6 +425,9 @@ struct MachineState {
>       } \
>       type_init(machine_initfn##_register_types)
>   
> +extern GlobalProperty hw_compat_9_0[];
> +extern const size_t hw_compat_9_0_len;
> +
>   extern GlobalProperty hw_compat_8_2[];
>   extern const size_t hw_compat_8_2_len;
>   
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 27a68071d77..349f79df086 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -198,6 +198,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>   /* sgx.c */
>   void pc_machine_init_sgx_epc(PCMachineState *pcms);
>   
> +extern GlobalProperty pc_compat_9_0[];
> +extern const size_t pc_compat_9_0_len;
> +
>   extern GlobalProperty pc_compat_8_2[];
>   extern const size_t pc_compat_8_2_len;
>   
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a9a913aeadb..c9119ef3847 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3223,10 +3223,17 @@ static void machvirt_machine_init(void)
>   }
>   type_init(machvirt_machine_init);
>   
> -static void virt_machine_9_0_options(MachineClass *mc)
> +static void virt_machine_9_1_options(MachineClass *mc)
>   {
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
> +DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
> +
> +static void virt_machine_9_0_options(MachineClass *mc)
> +{
> +    virt_machine_9_1_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
> +}
> +DEFINE_VIRT_MACHINE(9, 0)
>   
>   static void virt_machine_8_2_options(MachineClass *mc)
>   {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 37ede0e7d4f..a92bec23147 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -33,6 +33,9 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "audio/audio.h"
>   
> +GlobalProperty hw_compat_9_0[] = {};
> +const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
> +
>   GlobalProperty hw_compat_8_2[] = {
>       { "migration", "zero-page-detection", "legacy"},
>       { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e80f02bef41..461fcaa1b48 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -78,6 +78,9 @@
>       { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
>       { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
>   
> +GlobalProperty pc_compat_9_0[] = {};
> +const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
> +
>   GlobalProperty pc_compat_8_2[] = {};
>   const size_t pc_compat_8_2_len = G_N_ELEMENTS(pc_compat_8_2);
>   
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 18ba0766092..8850c49c66a 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -513,13 +513,26 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                                        "Use a different south bridge than PIIX3");
>   }
>   
> -static void pc_i440fx_9_0_machine_options(MachineClass *m)
> +static void pc_i440fx_9_1_machine_options(MachineClass *m)
>   {
>       pc_i440fx_machine_options(m);
>       m->alias = "pc";
>       m->is_default = true;
>   }
>   
> +DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
> +                      pc_i440fx_9_1_machine_options);
> +
> +static void pc_i440fx_9_0_machine_options(MachineClass *m)
> +{
> +    pc_i440fx_9_1_machine_options(m);
> +    m->alias = NULL;
> +    m->is_default = false;
> +
> +    compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
> +    compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
> +}
> +
>   DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
>                         pc_i440fx_9_0_machine_options);
>   
> @@ -528,8 +541,6 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>   
>       pc_i440fx_9_0_machine_options(m);
> -    m->alias = NULL;
> -    m->is_default = false;
>   
>       compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
>       compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index c7bc8a2041f..6e1180d4b60 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -365,12 +365,23 @@ static void pc_q35_machine_options(MachineClass *m)
>                        pc_q35_compat_defaults, pc_q35_compat_defaults_len);
>   }
>   
> -static void pc_q35_9_0_machine_options(MachineClass *m)
> +static void pc_q35_9_1_machine_options(MachineClass *m)
>   {
>       pc_q35_machine_options(m);
>       m->alias = "q35";
>   }
>   
> +DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
> +                   pc_q35_9_1_machine_options);
> +
> +static void pc_q35_9_0_machine_options(MachineClass *m)
> +{
> +    pc_q35_9_1_machine_options(m);
> +    m->alias = NULL;
> +    compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
> +    compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
> +}
> +
>   DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
>                      pc_q35_9_0_machine_options);
>   
> @@ -378,7 +389,6 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
>   {
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>       pc_q35_9_0_machine_options(m);
> -    m->alias = NULL;
>       m->max_cpus = 1024;
>       compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
>       compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index b8e5e102e6b..09bc9bdfefb 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -357,10 +357,17 @@ type_init(virt_machine_register_types)
>       } \
>       type_init(machvirt_machine_##major##_##minor##_init);
>   
> -static void virt_machine_9_0_options(MachineClass *mc)
> +static void virt_machine_9_1_options(MachineClass *mc)
>   {
>   }
> -DEFINE_VIRT_MACHINE(9, 0, true)
> +DEFINE_VIRT_MACHINE(9, 1, true)
> +
> +static void virt_machine_9_0_options(MachineClass *mc)
> +{
> +    virt_machine_9_1_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
> +}
> +DEFINE_VIRT_MACHINE(9, 0, false)
>   
>   static void virt_machine_8_2_options(MachineClass *mc)
>   {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c417f9dd523..ab0cf496d61 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4805,14 +4805,25 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>       type_init(spapr_machine_register_##suffix)
>   
>   /*
> - * pseries-9.0
> + * pseries-9.1
>    */
> -static void spapr_machine_9_0_class_options(MachineClass *mc)
> +static void spapr_machine_9_1_class_options(MachineClass *mc)
>   {
>       /* Defaults for the latest behaviour inherited from the base class */
>   }
>   
> -DEFINE_SPAPR_MACHINE(9_0, "9.0", true);
> +DEFINE_SPAPR_MACHINE(9_1, "9.1", true);
> +
> +/*
> + * pseries-9.0
> + */
> +static void spapr_machine_9_0_class_options(MachineClass *mc)
> +{
> +    spapr_machine_9_1_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
> +}
> +
> +DEFINE_SPAPR_MACHINE(9_0, "9.0", false);
>   
>   /*
>    * pseries-8.2
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index b1dcb3857f0..67e8b0b05e8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -859,14 +859,26 @@ bool css_migration_enabled(void)
>       }                                                                         \
>       type_init(ccw_machine_register_##suffix)
>   
> +static void ccw_machine_9_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_9_1_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(9_0, "9.1", true);
> +
>   static void ccw_machine_9_0_instance_options(MachineState *machine)
>   {
> +    ccw_machine_9_1_instance_options(machine);
>   }
>   
>   static void ccw_machine_9_0_class_options(MachineClass *mc)
>   {
> +    ccw_machine_9_1_class_options(machine);
> +    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>   }
> -DEFINE_CCW_MACHINE(9_0, "9.0", true);
> +DEFINE_CCW_MACHINE(9_0, "9.0", false);
>   
>   static void ccw_machine_8_2_instance_options(MachineState *machine)
>   {

