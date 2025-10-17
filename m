Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C67CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ddy-0001ur-7A; Fri, 17 Oct 2025 02:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9ddw-0001uf-MD; Fri, 17 Oct 2025 02:08:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1v9ddt-00077s-3w; Fri, 17 Oct 2025 02:08:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H0lQOO023890;
 Fri, 17 Oct 2025 06:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Ts8OrNXXjCSPh2hpnpxdgWJmoFQndH
 63C72/KNLB2QE=; b=AI8q0afo5wlRP7mviNksQy+opa0rE4GXFiLpFTH07HslWM
 54xwHYcAR2tjj8x9KLiMZi7bn5D7/ksalF+p9jpdkVthBDIOLvp1/4fqTfTUm2lE
 +KG9vDCBdip7Gmw6HYPcuJoZgT0ivdKIXgjssZQXhwKs5Hst1ylvd5GDYEs0NpjI
 O22tBWl9QCXMKWrcAeNu8hRIXdc/ElaTkgcj/lqF+Fjix+bGLsww6ihdCmZ0NInq
 6a+TLBHeZoGmalbR+/kz8anRcTwJ8PE7GTyaQ7LNWLdIRpBzgGuqXv9AZv3VepZG
 SwVYBcvjkJeQcaDIC9yAjoljt62l40v0Ep19c49w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxprnbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 06:08:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H603Wu016874;
 Fri, 17 Oct 2025 06:08:37 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49tfxprnbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 06:08:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H4DFEG015204;
 Fri, 17 Oct 2025 06:08:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jshvxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 06:08:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H68WKw6422826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 06:08:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B85CD2004F;
 Fri, 17 Oct 2025 06:08:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92EF42004B;
 Fri, 17 Oct 2025 06:08:30 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.22.45])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 06:08:30 +0000 (GMT)
Date: Fri, 17 Oct 2025 11:38:27 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 5/5] hw/ppc: Pass errp to load_image_targphys() and
 report errors
Message-ID: <aPHdWxH8plRC-L4P@linux.ibm.com>
References: <20251016173502.1261674-1-vishalc@linux.ibm.com>
 <20251016173502.1261674-8-vishalc@linux.ibm.com>
 <2b8acd7a-59eb-bc0c-13c2-de650afe28cc@eik.bme.hu>
 <aPFVBuFLHCdcxPoy@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPFVBuFLHCdcxPoy@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H1vMmJ_DFRki94wCTz0flgdLhUlXknbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDEyNSBTYWx0ZWRfX18ftpuvimCde
 bu+6NW3VPDZchARqgwPET+lQIbaOV+gZ9P5/VvC4+zs8sotFZdkK/du8Vdm56iJ6pkC1Kj9L9HF
 22GzwxGWIE23MpIL7qS/PyfTobeRBr1mxQsUMIcIPtUM+wdnO3bqoBji1r3MfDlkl6r+3oS4WPd
 h+Gqpdu27D54wDbyoPV46AAVZhbjIKP3dafZ2uzWAmy4RpeGtgxdeQgtY3JSkSlJcbPqwriaBoO
 65ZWJ5UdwDfBd0LARTGjCw4+05/SGjogE0e4FVV4g8IHWJ8o61HGPVvmG0mMz8x2W1gr2AXEjJp
 y/ONiG73HkjHUBlX8rgNYfmzZxCi85sDlzabQij6zZvoXI0igxivMo23ORuBzH2Y4rwkQKLD+kI
 dwxTHZRrYfZtEJC6/tiEltvbvBru9Q==
X-Authority-Analysis: v=2.4 cv=R+wO2NRX c=1 sm=1 tr=0 ts=68f1dd66 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CpeQKDSbbSTg7OkXVzQA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: F71FCfflqHbM1p99exAOsAbU0HAsCcU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510150125
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

On Fri, Oct 17, 2025 at 01:56:46AM +0530, Vishal Chourasia wrote:
> On Thu, Oct 16, 2025 at 09:27:36PM +0200, BALATON Zoltan wrote:
> > On Thu, 16 Oct 2025, Vishal Chourasia wrote:
> > > Pass errp to load_image_targphys() calls in ppc machine initialization
> > > to capture detailed error information when loading firmware, kernel,
> > > and initrd images.
> > > 
> > > Use error_reportf_err() instead of error_report() to print the
> > > underlying error details along with context about which image failed
> > > to load.
> > > 
> <snipped>
> > > diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> > > index 7fa14fd0e6..d4703f79da 100644
> > > --- a/hw/ppc/pegasos2.c
> > > +++ b/hw/ppc/pegasos2.c
> > > @@ -129,6 +129,7 @@ static void pegasos2_init(MachineState *machine)
> > >     int i;
> > >     ssize_t sz;
> > >     uint8_t *spd_data;
> > > +    Error *errp = NULL;
> > > 
> > >     /* init CPU */
> > >     pm->cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
> > > @@ -164,10 +165,10 @@ static void pegasos2_init(MachineState *machine)
> > >                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
> > >     if (sz <= 0) {
> > >         sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE,
> > > -                NULL);
> > > +                                 &errp);
> > >     }
> > >     if (sz <= 0 || sz > PROM_SIZE) {
> > > -        error_report("Could not load firmware '%s'", filename);
> > > +        error_reportf_err(errp, "Could not load firmware '%s': ", filename);
> > 
> > We can get here with *errp == NULL if load_elf did not fail but tried to
> > load a too large image. Is that a problem? It's the same in prep.c. Mac
> > machines also try different formats but those only check for size < 0 so
> > maybe not a problem there.
> > 
> 
> /* return < 0 if error, otherwise the number of bytes loaded in memory */
> ssize_t load_elf(const char *filename,
> 
> load_elf returns number of bytes. 
> 
> Yes, this is a problem. If load_elf() succeeds but the returned value
> is greater than PROM_SIZE, then *errp == NULL and this would cause a
> segmentation fault when trying to report the error.
> 
> Any location where an error check is performed based on a condition
> other than *errp (such as size checks) runs the risk of segmentation
> fault.
I will be sending out modifications addressing these in the next
version.

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index d4703f79da..14b679d032 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -168,7 +168,10 @@ static void pegasos2_init(MachineState *machine)
                                  &errp);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
-        error_reportf_err(errp, "Could not load firmware '%s': ", filename);
+        if (!errp) {
+           error_setg(&errp, ": exceeds max supported file size %lu", PROM_SIZE / MiB);
+        }
+        error_reportf_err(errp, "Could not load firmware '%s'", filename);

Similarly for other files too. 


> 
> > >         exit(1);
> > >     }
> > >     g_free(filename);
> > > @@ -260,10 +261,10 @@ static void pegasos2_init(MachineState *machine)
> > >         pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
> > >         pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
> > >         sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
> > > -                                 machine->ram_size - pm->initrd_addr, NULL);
> > > +                                 machine->ram_size - pm->initrd_addr, &errp);
> > >         if (sz <= 0) {
> > > -            error_report("Could not load initrd '%s'",
> > > -                         machine->initrd_filename);
> > > +            error_reportf_err(errp, "Could not load initrd '%s': ",
> > > +                              machine->initrd_filename);
> > >             exit(1);
> > >         }
> > >         pm->initrd_size = sz;
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index a3e5203970..88668a700e 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -1015,6 +1015,7 @@ static void pnv_init(MachineState *machine)
> > >     char *chip_typename;
> > >     DriveInfo *pnor;
> > >     DeviceState *dev;
> > > +    Error *errp = NULL;
> > > 
> > >     if (kvm_enabled()) {
> > >         error_report("machine %s does not support the KVM accelerator",
> > > @@ -1069,9 +1070,10 @@ static void pnv_init(MachineState *machine)
> > >     }
> > > 
> > >     fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
> > > -                                    NULL);
> > > +                                    &errp);
> > >     if (fw_size < 0) {
Also, we replace checks on size with errp.

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 88668a700e..4c94bc319d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1071,7 +1071,7 @@ static void pnv_init(MachineState *machine)

     fw_size = load_image_targphys(fw_filename, pnv->fw_load_addr, FW_MAX_SIZE,
                                     &errp);
-    if (fw_size < 0) {
+    if (errp) {
         error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
                           fw_filename);
         exit(1);

Similarly, at other locations.

Thanks,
vishalc

> > > -        error_report("Could not load OPAL firmware '%s'", fw_filename);
> > > +        error_reportf_err(errp, "Could not load OPAL firmware '%s': ",
> > > +                          fw_filename);
> > >         exit(1);
> > >     }
> > >     g_free(fw_filename);
> > > @@ -1082,10 +1084,10 @@ static void pnv_init(MachineState *machine)
> > > 
> > >         kernel_size = load_image_targphys(machine->kernel_filename,
> > >                                           KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE,
> > > -                                          NULL);
> > > +                                          &errp);
> > >         if (kernel_size < 0) {
> > > -            error_report("Could not load kernel '%s'",
> > > -                         machine->kernel_filename);
> > > +            error_reportf_err(errp, "Could not load kernel '%s': ",
> > > +                              machine->kernel_filename);
> > >             exit(1);
> > >         }
> > >     }
<snipped>
> > > diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> > > index 00d9ab7509..a7d3de62fa 100644
> > > --- a/hw/ppc/virtex_ml507.c
> > > +++ b/hw/ppc/virtex_ml507.c
> > > @@ -195,6 +195,7 @@ static void virtex_init(MachineState *machine)
> > >     qemu_irq irq[32], cpu_irq;
> > >     int kernel_size;
> > >     int i;
> > > +    Error *errp = NULL;
> > > 
> > >     /* init CPUs */
> > >     cpu = ppc440_init_xilinx(machine->cpu_type, 400000000);
> > > @@ -253,7 +254,7 @@ static void virtex_init(MachineState *machine)
> > >             /* If we failed loading ELF's try a raw image.  */
> > >             kernel_size = load_image_targphys(kernel_filename,
> > >                                               boot_offset,
> > > -                                              machine->ram_size, NULL);
> > > +                                              machine->ram_size, &errp);
> > 
> > What checks and reports errp? Was something left out here?
> The error check was missing here. After reviewing the code, it seems a
> check should be added. I will add it in the next version.
> 

