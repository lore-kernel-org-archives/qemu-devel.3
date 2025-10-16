Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F37CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UZ1-0005KT-5D; Thu, 16 Oct 2025 16:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9UYz-0005HQ-1g; Thu, 16 Oct 2025 16:27:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9UYv-0001cj-Vw; Thu, 16 Oct 2025 16:27:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GGvdgl021824;
 Thu, 16 Oct 2025 20:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=J4Q0TuVbzHck793OJUBnq83iLEscOS
 wUSy6Yo/Xc6DE=; b=X+xLMxR8ZbMfHaP3MayBan1tHH7o1tWg75l+W8bH3uOBSX
 3lb63QedBaxymIR1bT/vSzbghm6MwE4b4V6/NnHjo2Ccka6By+SlpZHl5HVe9Nrk
 J9/vZrJBPR7lnF8zrTM6u2zR2NLXTB5CJ07/GohfApXIljJVqrrgseUFmkQ09BAI
 9nrO38NmQ6yNdjhznRetSvWN4zCrY/viLXTnKTMnl4SK8erSmux46xdCWbMhwDQ8
 Cs22L3vvQZvtqDepw2xL0k2ceoqafn1MTjWzIV+CceE4HABwbDds6YTGO11Tr8pV
 nnkZIqMBZ84SpHsi+dfq86mFfN/TyMt8FAfpJpJw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0btw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 20:26:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GKQusS029736;
 Thu, 16 Oct 2025 20:26:56 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0btw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 20:26:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHRoFD028069;
 Thu, 16 Oct 2025 20:26:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9exrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 20:26:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GKQpPF59638062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 20:26:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AE2F20075;
 Thu, 16 Oct 2025 20:26:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B6C620073;
 Thu, 16 Oct 2025 20:26:49 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.26.252])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Oct 2025 20:26:48 +0000 (GMT)
Date: Fri, 17 Oct 2025 01:56:46 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 5/5] hw/ppc: Pass errp to load_image_targphys() and
 report errors
Message-ID: <aPFVBuFLHCdcxPoy@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-8-vishalc@linux.ibm.com>
 <2b8acd7a-59eb-bc0c-13c2-de650afe28cc@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b8acd7a-59eb-bc0c-13c2-de650afe28cc@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gdWVjxNi8ac9vboP9xJB3ottGxrnfNu7
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f15510 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=N5XcTDuVFYzu4Ex11mUA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX4leuQzV/8pQU
 iQLV36Bgh/aLErg/kjtG7+C7HbcmH3qZ/F4YOk6MGsFilfsz5dryNkWVgj2RK5PfZvv9SXe8TgW
 wapd2jWv6jFqGJol4g6i9y9sZagHikfUDZwhSqnRUXhKNVCurw8kpB2Xl9jwyfmO++9wObZLeG2
 1P1j8hekQeqjiyQIncwQkgkoHgDG5gBVhpO1DzXFeXXJ2ph4pvs53hDo4ycVhP+HMcwvZQcABar
 SCukYb+vya9oSNvEfGFq3dV/AOPlOihlob1orAvoi9kh67HZw+HRBSO/36S/Wq8CINK936F4uWt
 rSagVopDyb0Wqn4Vhr7ZDCXVVablkQVX98BGeDrzVG6W5+G/jSj9Tf9R+FLuwb/5C+x1kfy/5Ls
 ncU4LOQkkPas9ed/WOrGeYHznWksjw==
X-Proofpoint-GUID: g3RLHiZfEkrG0cnOkc08BrVGBr5Pn3yc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 09:27:36PM +0200, BALATON Zoltan wrote:
> On Thu, 16 Oct 2025, Vishal Chourasia wrote:
> > Pass errp to load_image_targphys() calls in ppc machine initialization
> > to capture detailed error information when loading firmware, kernel,
> > and initrd images.
> > 
> > Use error_reportf_err() instead of error_report() to print the
> > underlying error details along with context about which image failed
> > to load.
> > 
<snipped>
> > diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> > index 7fa14fd0e6..d4703f79da 100644
> > --- a/hw/ppc/pegasos2.c
> > +++ b/hw/ppc/pegasos2.c
> > @@ -129,6 +129,7 @@ static void pegasos2_init(MachineState *machine)
> >     int i;
> >     ssize_t sz;
> >     uint8_t *spd_data;
> > +    Error *errp = NULL;
> > 
> >     /* init CPU */
> >     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> > @@ -164,10 +165,10 @@ static void pegasos2_init(MachineState *machine)
> >                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
> >     if (sz <= 0) {
> >         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
> > -                NULL);
> > +                                 &errp);
> >     }
> >     if (sz <= 0 || sz > PROM_SIZE) {
> > -        error_report("Could not load firmware '%s'", filename);
> > +        error_reportf_err(errp, "Could not load firmware '%s': ", filename);
> 
> We can get here with *errp == NULL if load_elf did not fail but tried to
> load a too large image. Is that a problem? It's the same in prep.c. Mac
> machines also try different formats but those only check for size < 0 so
> maybe not a problem there.
> 

/* return < 0 if error, otherwise the number of bytes loaded in memory */
ssize_t load_elf(const char *filename,

load_elf returns number of bytes. 

Yes, this is a problem. If load_elf() succeeds but the returned value
is greater than PROM_SIZE, then *errp == NULL and this would cause a
segmentation fault when trying to report the error.

Any location where an error check is performed based on a condition
other than *errp (such as size checks) runs the risk of segmentation
fault.

> >         exit(1);
> >     }
> >     g_free(filename);
> > @@ -260,10 +261,10 @@ static void pegasos2_init(MachineState *machine)
> >         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
> >         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
> >         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
> > -                                 machine->ram_size - pm->initrd_addr, NULL);
> > +                                 machine->ram_size - pm->initrd_addr, &errp);
> >         if (sz <= 0) {
> > -            error_report("Could not load initrd '%s'",
> > -                         machine->initrd_filename);
> > +            error_reportf_err(errp, "Could not load initrd '%s': ",
> > +                              machine->initrd_filename);
> >             exit(1);
> >         }
> >         pm->initrd_size = sz;
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index a3e5203970..88668a700e 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1015,6 +1015,7 @@ static void pnv_init(MachineState *machine)
> >     char *chip_typename;
> >     DriveInfo *pnor;
> >     DeviceState *dev;
> > +    Error *errp = NULL;
> > 
> >     if (kvm_enabled()) {
> >         error_report("machine %s does not support the KVM accelerator",
> > @@ -1069,9 +1070,10 @@ static void pnv_init(MachineState *machine)
> >     }
> > 
> >     fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> > -                                    NULL);
> > +                                    &errp);
> >     if (fw_size < 0) {
> > -        error_report("Could not load OPAL firmware '%s'", fw_filename);
> > +        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
> > +                          fw_filename);
> >         exit(1);
> >     }
> >     g_free(fw_filename);
> > @@ -1082,10 +1084,10 @@ static void pnv_init(MachineState *machine)
> > 
> >         kernel_size = load_image_targphys(machine->kernel_filename,
> >                                           KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> > -                                          NULL);
> > +                                          &errp);
> >         if (kernel_size < 0) {
> > -            error_report("Could not load kernel '%s'",
> > -                         machine->kernel_filename);
> > +            error_reportf_err(errp, "Could not load kernel '%s': ",
> > +                              machine->kernel_filename);
> >             exit(1);
> >         }
> >     }
> > @@ -1094,10 +1096,10 @@ static void pnv_init(MachineState *machine)
> >     if (machine->initrd_filename) {
> >         pnv->initrd_base = INITRD_LOAD_ADDR;
> >         pnv->initrd_size = load_image_targphys(machine->initrd_filename,
> > -                                  pnv->initrd_base, INITRD_MAX_SIZE, NULL);
> > +                                  pnv->initrd_base, INITRD_MAX_SIZE, &errp);
> >         if (pnv->initrd_size < 0) {
> > -            error_report("Could not load initial ram disk '%s'",
> > -                         machine->initrd_filename);
> > +            error_reportf_err(errp, "Could not load initial ram disk '%s': ",
> > +                              machine->initrd_filename);
> >             exit(1);
> >         }
> >     }
> > diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> > index 7c66912c10..9e55e56ee0 100644
> > --- a/hw/ppc/ppc440_bamboo.c
> > +++ b/hw/ppc/ppc440_bamboo.c
> > @@ -141,6 +141,7 @@ static void bamboo_init(MachineState *machine)
> >     DeviceState *uicdev;
> >     SysBusDevice *uicsbd;
> >     int success;
> > +    Error *errp = NULL;
> > 
> >     if (kvm_enabled()) {
> >         error_report("machine %s does not support the KVM accelerator",
> > @@ -243,11 +244,11 @@ static void bamboo_init(MachineState *machine)
> >     if (initrd_filename) {
> >         initrd_size = load_image_targphys(initrd_filename, RAMDISK_ADDR,
> >                                           machine->ram_size - RAMDISK_ADDR,
> > -                                          NULL);
> > +                                          &errp);
> > 
> >         if (initrd_size < 0) {
> > -            error_report("could not load ram disk '%s' at %x",
> > -                         initrd_filename, RAMDISK_ADDR);
> > +            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
> > +                              initrd_filename, RAMDISK_ADDR);
> >             exit(1);
> >         }
> >     }
> > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > index edd3da7102..f8cf6dc16e 100644
> > --- a/hw/ppc/prep.c
> > +++ b/hw/ppc/prep.c
> > @@ -250,6 +250,7 @@ static void ibm_40p_init(MachineState *machine)
> >     uint32_t kernel_base = 0, initrd_base = 0;
> >     long kernel_size = 0, initrd_size = 0;
> >     char boot_device;
> > +    Error *errp = NULL;
> > 
> >     if (kvm_enabled()) {
> >         error_report("machine %s does not support the KVM accelerator",
> > @@ -280,10 +281,10 @@ static void ibm_40p_init(MachineState *machine)
> >     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> >                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
> >     if (bios_size < 0) {
> > -        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, NULL);
> > +        bios_size = load_image_targphys(filename, BIOS_ADDR, BIOS_SIZE, &errp);
> >     }
> >     if (bios_size < 0 || bios_size > BIOS_SIZE) {
> > -        error_report("Could not load bios image '%s'", filename);
> > +        error_reportf_err(errp, "Could not load bios image '%s': ", filename);
> >         return;
> >     }
> >     g_free(filename);
> > @@ -381,10 +382,10 @@ static void ibm_40p_init(MachineState *machine)
> >         kernel_size = load_image_targphys(machine->kernel_filename,
> >                                           kernel_base,
> >                                           machine->ram_size - kernel_base,
> > -                                          NULL);
> > +                                          &errp);
> >         if (kernel_size < 0) {
> > -            error_report("could not load kernel '%s'",
> > -                         machine->kernel_filename);
> > +            error_reportf_err(errp, "could not load kernel '%s': ",
> > +                              machine->kernel_filename);
> >             exit(1);
> >         }
> >         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
> > @@ -395,10 +396,10 @@ static void ibm_40p_init(MachineState *machine)
> >             initrd_size = load_image_targphys(machine->initrd_filename,
> >                                               initrd_base,
> >                                               machine->ram_size - initrd_base,
> > -                                              NULL);
> > +                                              &errp);
> >             if (initrd_size < 0) {
> > -                error_report("could not load initial ram disk '%s'",
> > -                             machine->initrd_filename);
> > +                error_reportf_err(errp, "could not load initial ram disk '%s': ",
> > +                                  machine->initrd_filename);
> >                 exit(1);
> >             }
> >             fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_base);
> > diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> > index 68d3eacbff..a5cb8e0738 100644
> > --- a/hw/ppc/sam460ex.c
> > +++ b/hw/ppc/sam460ex.c
> > @@ -262,6 +262,7 @@ static void sam460ex_init(MachineState *machine)
> >     struct boot_info *boot_info;
> >     uint8_t *spd_data;
> >     int success;
> > +    Error *errp = NULL;
> > 
> >     cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> >     env = &cpu->env;
> > @@ -495,10 +496,10 @@ static void sam460ex_init(MachineState *machine)
> >         initrd_size = load_image_targphys(machine->initrd_filename,
> >                                           RAMDISK_ADDR,
> >                                           machine->ram_size - RAMDISK_ADDR,
> > -                                          NULL);
> > +                                          &errp);
> >         if (initrd_size < 0) {
> > -            error_report("could not load ram disk '%s' at %x",
> > -                    machine->initrd_filename, RAMDISK_ADDR);
> > +            error_reportf_err(errp, "could not load ram disk '%s' at %x: ",
> > +                              machine->initrd_filename, RAMDISK_ADDR);
> >             exit(1);
> >         }
> >     }
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 9e17b5a31d..0be542c888 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2824,9 +2824,10 @@ static void spapr_machine_init(MachineState *machine)
> >         error_report("Could not find LPAR firmware '%s'", bios_name);
> >         exit(1);
> >     }
> > -    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, NULL);
> > +    fw_size = load_image_targphys(filename, 0, FW_MAX_SIZE, &errp);
> >     if (fw_size <= 0) {
> > -        error_report("Could not load LPAR firmware '%s'", filename);
> > +        error_reportf_err(errp, "Could not load LPAR firmware '%s': ",
> > +                          filename);
> >         exit(1);
> >     }
> > 
> > @@ -3090,10 +3091,10 @@ static void spapr_machine_init(MachineState *machine)
> >                                                      spapr->initrd_base,
> >                                                      load_limit
> >                                                      - spapr->initrd_base,
> > -                                                     NULL);
> > +                                                     &errp);
> >             if (spapr->initrd_size < 0) {
> > -                error_report("could not load initial ram disk '%s'",
> > -                             initrd_filename);
> > +                error_reportf_err(errp, "could not load initial ram disk '%s': ",
> > +                                  initrd_filename);
> >                 exit(1);
> >             }
> >         }
> > diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> > index 00d9ab7509..a7d3de62fa 100644
> > --- a/hw/ppc/virtex_ml507.c
> > +++ b/hw/ppc/virtex_ml507.c
> > @@ -195,6 +195,7 @@ static void virtex_init(MachineState *machine)
> >     qemu_irq irq[32], cpu_irq;
> >     int kernel_size;
> >     int i;
> > +    Error *errp = NULL;
> > 
> >     /* init CPUs */
> >     cpu = ppc440_init_xilinx(machine->cpu_type, 400000000);
> > @@ -253,7 +254,7 @@ static void virtex_init(MachineState *machine)
> >             /* If we failed loading ELF's try a raw image.  */
> >             kernel_size = load_image_targphys(kernel_filename,
> >                                               boot_offset,
> > -                                              machine->ram_size, NULL);
> > +                                              machine->ram_size, &errp);
> 
> What checks and reports errp? Was something left out here?
The error check was missing here. After reviewing the code, it seems a
check should be added. I will add it in the next version.

Thanks,
vishalc

> 
> Regards,
> BALATON Zoltan
> 
> >             boot_info.bootstrap_pc = boot_offset;
> >             high = boot_info.bootstrap_pc + kernel_size + 8192;
> >         }
> > @@ -265,11 +266,11 @@ static void virtex_init(MachineState *machine)
> >             initrd_base = high = ROUND_UP(high, 4);
> >             initrd_size = load_image_targphys(machine->initrd_filename,
> >                                               high, machine->ram_size - high,
> > -                                              NULL);
> > +                                              &errp);
> > 
> >             if (initrd_size < 0) {
> > -                error_report("couldn't load ram disk '%s'",
> > -                             machine->initrd_filename);
> > +                error_reportf_err(errp, "couldn't load ram disk '%s': ",
> > +                                  machine->initrd_filename);
> >                 exit(1);
> >             }
> >             high = ROUND_UP(high + initrd_size, 4);
> > 
> 

