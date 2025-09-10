Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9D9CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 14:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwLiG-0002If-2r; Wed, 10 Sep 2025 10:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uwLiC-0002Hn-Gi; Wed, 10 Sep 2025 10:22:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uwLi1-0006Ls-Mp; Wed, 10 Sep 2025 10:22:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9osS3029387;
 Wed, 10 Sep 2025 14:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=rxq47v46PUJuMRMvu9OGbEk2cZgm8/3CX7wLCL97qLs=; b=bldcx4Aofm3k
 8ypsqQpwr0JntGMdnNCQRCWCZfm9yOZjNCz/wL5w0NlLmxacU4WTfmyszFWXyGAH
 WzpInQABaO48bn9/2tM9kiqKd3fEOyJz6wqr4WQF99vk2aeaoPFEu2l2ahpwPB8w
 jIpBmOnutBE6HqevPegoQjHYQviCnpYnVsh0ZZKfHqQzlxB4k9OnkqT7tZ5IsA8D
 AJ2eopnjyc9W0k6CfTb3Rltbl/7dxRdgmiySI/cJAysafNF/luY+wfZRsS2NaGJ1
 hXKCnJw4bC3arOqAn4AT3BUjqNhy8eKOyn51u3SiGIjMi8lcHZSE3nh8ZODALMAs
 yXumk0tsSw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffes8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 14:21:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AEItP6022775;
 Wed, 10 Sep 2025 14:21:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffes87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 14:21:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AD5qHa020495;
 Wed, 10 Sep 2025 14:21:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp1119p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 14:21:54 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58AELq9c19727004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Sep 2025 14:21:53 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABE8458055;
 Wed, 10 Sep 2025 14:21:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0803E58059;
 Wed, 10 Sep 2025 14:21:52 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Sep 2025 14:21:51 +0000 (GMT)
Message-ID: <b18882d811ef82b9825d83d7de368e04a051ce99.camel@linux.ibm.com>
Subject: Re: [PATCH v3 8/9] hw/ppc: Add a test machine for the IBM PPE42 CPU
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 thuth@redhat.com, rathc@linux.ibm.com, richard.henderson@linaro.org
Date: Wed, 10 Sep 2025 09:21:51 -0500
In-Reply-To: <ce46413b-dab9-4ffc-9e6e-078c6b2ed6b9@redhat.com>
References: <20250908200028.115789-1-milesg@linux.ibm.com>
 <20250908200028.115789-9-milesg@linux.ibm.com>
 <ce46413b-dab9-4ffc-9e6e-078c6b2ed6b9@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SVRmV47O-NFl_NWZ1zyZWUoo9UC2UYfK
X-Proofpoint-GUID: KT9Mxe_5Mp9BUUvWhO5b0hojunITAK_D
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c18984 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=up-X0YpDAAAA:8 a=20KFwNOVAAAA:8 a=14Q3UDedklbQJ-9NY7oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=86FmjZgct7XXK6GGpxvI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX4SssA8GF32Lf
 IlJBEhQvkiiGh92q+m/n62jGNW5ZqVdKET8CreBQM1IbrQNF5wye6+sAE5ZQIYtTGASV8UZspug
 OKWEUgeL4AfYXWJEXDDJlOIaskmfzUa27te3GNegpiJMYwFRBxcP8Jmp36pruvy0ClXwCKEGCBf
 r1ICNFVjQzfBOVuD5s8/HaBLRyI1wsjvX+Fa3cPWqlamHymjQhxNiZ6b5Ey4N+RszPHlSY8ITtt
 Kr+eK9lRVSM91PvELyqO/+sOmRGtzyXxURPJqBjbRPBuhJfeTqLkMVKugt8UQabRqb7LDWOm2PI
 gb0EDrb/2t45EzcCS10Dg6+MEwPSseofzMGmITP3n6Nsq3zqwINQnIwZwU8emTECmVhtgA3BL2Y
 y6mMEY5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_02,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 2025-09-10 at 09:10 +0200, Cédric Le Goater wrote:
> On 9/8/25 22:00, Glenn Miles wrote:
> > Adds a test machine for the IBM PPE42 processor, including a
> > DEC, FIT, WDT and 512 KiB of ram.
> > 
> > The purpose of this machine is only to provide a generic platform
> > for testing instructions of the recently  added PPE42 processor
> > model which is used extensively in the IBM Power9, Power10 and
> > future Power server processors.
> > 
> > Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> > ---
> > 
> > Changes from v2:
> >    - Moved decrementer changes to distinct commit
> >    - Introduced a specific MachineState for the ppe42 Machine
> >    - Use qdev_realize to create the machine
> >    - Use valid_cpu_types to determine validity of CPU
> >    - Changed machine ram limit from 2GB to 512KB
> > 
> >   MAINTAINERS            |   6 +++
> >   hw/ppc/Kconfig         |   9 ++++
> >   hw/ppc/meson.build     |   2 +
> >   hw/ppc/ppe42_machine.c | 102 +++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 119 insertions(+)
> >   create mode 100644 hw/ppc/ppe42_machine.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a07086ed76..52fa303e0a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1531,6 +1531,12 @@ F: include/hw/pci-host/grackle.h
> >   F: pc-bios/qemu_vga.ndrv
> >   F: tests/functional/test_ppc_mac.py
> >   
> > +PPE42
> > +M: Glenn Miles <milesg@linux.ibm.com>
> > +L: qemu-ppc@nongnu.org
> > +S: Odd Fixes
> > +F: hw/ppc/ppe42_machine.c
> > +
> >   PReP
> >   M: Hervé Poussineau <hpoussin@reactos.org>
> >   L: qemu-ppc@nongnu.org
> > diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> > index ced6bbc740..3fdea5919c 100644
> > --- a/hw/ppc/Kconfig
> > +++ b/hw/ppc/Kconfig
> > @@ -44,6 +44,15 @@ config POWERNV
> >       select SSI_M25P80
> >       select PNV_SPI
> >   
> > +config PPC405
> > +    bool
> > +    default y
> > +    depends on PPC
> > +    select M48T59
> > +    select PFLASH_CFI02
> > +    select PPC4XX
> > +    select SERIAL
> 
> Does the machine need all the above support ?

No, it only needs PPC4XX.  I'll remove the others.

> 
> > +
> >   config PPC440
> >       bool
> >       default y
> > diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> > index 9893f8adeb..170b90ae7d 100644
> > --- a/hw/ppc/meson.build
> > +++ b/hw/ppc/meson.build
> > @@ -57,6 +57,8 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
> >     'pnv_n1_chiplet.c',
> >   ))
> >   # PowerPC 4xx boards
> > +ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
> > +  'ppe42_machine.c'))
> >   ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
> >     'ppc440_bamboo.c',
> >     'ppc440_uc.c'))
> > diff --git a/hw/ppc/ppe42_machine.c b/hw/ppc/ppe42_machine.c
> > new file mode 100644
> > index 0000000000..2cfce2503f
> > --- /dev/null
> > +++ b/hw/ppc/ppe42_machine.c
> > @@ -0,0 +1,102 @@
> > +/*
> > + * Test Machine for the IBM PPE42 processor
> > + *
> > + * Copyright (c) 2025, IBM Corporation.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/units.h"
> > +#include "qemu/error-report.h"
> > +#include "system/address-spaces.h"
> > +#include "hw/boards.h"
> > +#include "hw/ppc/ppc.h"
> > +#include "system/system.h"
> > +#include "system/reset.h"
> > +#include "system/kvm.h"
> > +#include "qapi/error.h"
> > +
> > +#define TYPE_PPE42_MACHINE MACHINE_TYPE_NAME("ppe42_machine")
> > +typedef MachineClass Ppe42MachineClass;
> > +typedef struct Ppe42MachineState Ppe42MachineState;
> > +DECLARE_OBJ_CHECKERS(Ppe42MachineState, Ppe42MachineClass,
> > +                     PPE42_MACHINE, TYPE_PPE42_MACHINE)
> > +
> > +struct Ppe42MachineState {
> > +    MachineState parent_obj;
> > +
> > +    PowerPCCPU cpu;
> > +};
> > +
> > +static void main_cpu_reset(void *opaque)
> > +{
> > +    PowerPCCPU *cpu = opaque;
> > +
> > +    cpu_reset(CPU(cpu));
> > +}
> > +
> > +static void ppe42_machine_init(MachineState *machine)
> > +{
> > +    Ppe42MachineState *pms = PPE42_MACHINE(machine);
> > +    PowerPCCPU *cpu = &pms->cpu;
> > +
> > +    if (kvm_enabled()) {
> > +        error_report("machine %s does not support the KVM accelerator",
> > +                     MACHINE_GET_CLASS(machine)->name);
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    /* init CPU */
> > +    object_initialize_child(OBJECT(pms), "cpu", cpu, machine->cpu_type);
> > +    if (!qdev_realize(DEVICE(cpu), NULL, &error_fatal)) {
> > +        return;
> > +    }
> > +
> > +    qemu_register_reset(main_cpu_reset, cpu);
> > +
> > +    /* This sets the decrementer timebase */
> > +    ppc_booke_timers_init(cpu, 37500000, PPC_TIMER_PPE);
> > +
> > +    /* RAM */
> > +    if (machine->ram_size > 512 * KiB) {
> > +        error_report("RAM size more than 512 KiB is not supported");
> > +        exit(1);
> > +    }
> 
> In case of resend, the RAM size could be tested sooner (after kvm_enabled()).
> 

Sure, I'll move it up.

> > +    memory_region_add_subregion(get_system_memory(), 0xfff80000, machine->ram);
> > +}
> > +
> > +
> > +static void ppe42_machine_class_init(ObjectClass *oc, const void *data)
> > +{
> > +    MachineClass *mc = MACHINE_CLASS(oc);
> > +    static const char * const valid_cpu_types[] = {
> > +        POWERPC_CPU_TYPE_NAME("PPE42"),
> > +        POWERPC_CPU_TYPE_NAME("PPE42X"),
> > +        POWERPC_CPU_TYPE_NAME("PPE42XM"),
> > +        NULL,
> > +    };
> > +
> > +    mc->desc = "PPE42 Test Machine";
> > +    mc->init = ppe42_machine_init;
> > +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("PPE42XM");
> > +    mc->valid_cpu_types = valid_cpu_types;
> > +    mc->default_ram_id = "ram";
> > +    mc->default_ram_size = 512 * KiB;
> > +}
> > +
> > +static const TypeInfo ppe42_machine_info = {
> > +        .name          = TYPE_PPE42_MACHINE,
> > +        .parent        = TYPE_MACHINE,
> > +        .instance_size = sizeof(Ppe42MachineState),
> > +        .class_init    = ppe42_machine_class_init,
> > +        .class_size    = sizeof(Ppe42MachineClass),
> > +};
> > +
> > +static void ppe42_machine_register_types(void)
> > +{
> > +    type_register_static(&ppe42_machine_info);
> > +}
> > +
> > +type_init(ppe42_machine_register_types);
> > +
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks,
> 
> C.
> 

Thank you for your help!

Glenn



