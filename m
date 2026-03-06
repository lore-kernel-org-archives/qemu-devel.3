Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B72F5140A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 06:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyOkQ-0004Qk-MB; Fri, 06 Mar 2026 01:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vyOkC-0004Ph-IS; Fri, 06 Mar 2026 01:33:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vyOkA-0002ji-RW; Fri, 06 Mar 2026 01:33:04 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625ISVoL2187914; Fri, 6 Mar 2026 06:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Gbjwaf8RAhXwmoEgOAYoe0Yqo1orKc
 vm2vJfMS1ADhY=; b=AWPsSwGHJjuN4plTxwP8CT99sr3PZc0t8/PaHB+RN4LZ+m
 Hh0hILPGouCDg3VxnwVNxT+IbPoum4f7xcXmh5sYal/fYlgD9KDeEeN6KDXBLUCG
 ZuYqOtQFnUVAN9s/X+D/MJMpqNz7q+BBOiIcbWmC0DDhIbmYhx75S+2NjkKCBlAU
 1/p/XH5PYOoAx8jxzV+hCBNVsZqSwQdfYT7Xn2cawE696lhUDrHURYh9THjF60y4
 8u5Jz3i/BkbRNLH0UIzSWqLcFnNvpkski6nLUm8qT9UO+ae2JifA4sAAQqV5VZpK
 OJYkbC814z0HPrhmi1iXmA7bZUdBE3ICV1ddjUyA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk46p9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 06:32:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6264XD2f010327;
 Fri, 6 Mar 2026 06:32:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6keneh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 06:32:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6266WkNF41353686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 06:32:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2130120043;
 Fri,  6 Mar 2026 06:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE7B820040;
 Fri,  6 Mar 2026 06:32:43 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.17.151]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  6 Mar 2026 06:32:43 +0000 (GMT)
Date: Fri, 6 Mar 2026 12:02:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
Message-ID: <aapz6OnPgmMevinB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
 <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <648a3687-6356-8063-b4d4-a0bbc332dd0c@eik.bme.hu>
 <7yq2eac5yzsx2ve2nwbs7uhjguemravsimtm26dkgppeczqmix@wtrwux3aeswg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7yq2eac5yzsx2ve2nwbs7uhjguemravsimtm26dkgppeczqmix@wtrwux3aeswg>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 1DulULZOp9iX-JPswfr0qE6p-I_o48-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1NyBTYWx0ZWRfX+N6QZtG0Rkv0
 2h12OpZy4avo6nXmbGr3oT83Kk7loAlSJBUVi9tPAx3LpZhHBcQtKTE5v21HuBS6t5t82CEoC10
 dGQzIqtGsi4mqO+2hiMjt97kXMsKHYOK5k+vaiDWej48X1EncpjR62VQVKFRN/GQafl/dQDLSWc
 SU1FdD2bh4WAB1Qdk/eLB5ZyfgSGeoeVo06LwgHZWEzlbrMTNTlpAoDPSzEaCC36KILMYSRAs74
 V/33KF7tsOHFsrksJSxuoip1MwUk7xoo6WgR6wfl0SYtZdBbFWcVHDzfuSZwf+59pINzgqVqCT8
 03dERrmG5dDwsG8X1Kpq5rC4Qp0sWNlaPBmRBiqC0JeBYjgnzCKw5wy7o7wMK6ZqtAfKt6Qebsr
 beS3EG4/WS4hpk+TfQLPXUIY3ZYtBrrv1ISmzHRoYi8Y9f9V9i+UlWGeD+kdh5eVo2Qh4MNyJ+d
 XEi7NX7QQcuzd9r8YzQ==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aa7513 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=W92PUgBrRGjWe7tfGusA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Zs_tmPRr2n6CtxqTcXIhZPfADe_f_E-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060057
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/03/02 02:54PM, Shivang Upadhyay wrote:
> On Fri, Feb 27, 2026 at 04:53:56PM +0100, BALATON Zoltan wrote:
> > On Fri, 27 Feb 2026, Aditya Gupta wrote:
> > > On 26/02/27 02:05PM, BALATON Zoltan wrote:
> > > > On Fri, 27 Feb 2026, Aditya Gupta wrote:
> > > > > On 26/02/27 03:43PM, shivang upadhyay wrote:
> > > > > > > <...snip...>
> > > > > > > 
> > > > > > > Q: can the generated DBT genuinely be different on a
> > > > > > > subsequent reset than it was when QEMU first starts?
> > > > > > > The comments in the pnv_reset() code seem to suggest it,
> > > > > > > but on the other hand the code as written will only
> > > > > > > call pnv_dt_create() and update machine->fdt once on first
> > > > > > > reset, not on later resets. So perhaps the comment is
> > > > > > > just confusingly worded ?
> > > > > > 
> > > > > > Yes, I am not much familiar with the design here. But, as per
> > > > > > 
> > > > > > my current understanding of this code, DTB content should not
> > > > > > 
> > > > > > not be changed.
> > > > > 
> > > > > To add to this, yes, normally reset path doesn't change the device tree,
> > > > > since all reboots are the same as the first boot.
> > > > > 
> > > > > As of upstream this is true, I don't see dtb changing between resets.
> > > > 
> > > > Isn't VOF allowing clients to do setprop that would be changing the device
> > > > tree? Some settings are stored there so maybe it can be changed by the guest
> > > > that should be preserved between reboots?
> > > 
> > > By VOF did you mean the pseries f/w ?
> > 
> > I don't know much about these machines. I meant Virtual Open Firmware in
> > QEMU or SLOF which it can replace. But maybe this is only used by spapr so
> > does not affect pseries but in spapr there's spapr_vof_setprop() which looks
> > like it can change the fdt. Maybe it's handled differently on pseries, I
> > don't know.
> Yes, Vof/Slof firmware are only used for pseries.
> for pnv we use skiboot.lid firmware.

Yes, VOF/SLOF is not involved in PowerNV, so that shouldn't be a problem
here.

> > > i don't see anything changing the dt in powernv as of now, but
> > > for some edge case, where that is possible (will be possible atleast
> > > after mpipl support is merged), we can always update the fdt in below 2
> > > if cases in pnv_reset:
> > > 
> > >    > if (machine->fdt) {
> > >    >     fdt = machine->fdt;
> > >    > } else {
> > >    >     fdt = pnv_dt_create(machine);
> > >    >     /* Pack resulting tree */
> > >    >     _FDT((fdt_pack(fdt)));
> > >    > }
> > > 
> > > machine->fdt will never be NULL since it's being set in pnv_init
> > > should we just do pnv_dt_create on every pnv_reset ?
> > 
> > I don't know either but wasn't original code meant to either create an fdt
> > or take what the user specified with -dtb option or similiar? In that case
> > maybe you don't want to override the user specified dtb but I could be wrong
> > about what this is meant to do as I have no idea whatsoever about these
> > machines.
> I think I should just remove all the fdt changing stuff from cpu_reset.
> Becasue nothing is using it as of now. We can introduce it with mpipl patches.
> That would make the code easier to understand there.

I have below suggestion for this, acknowledging peter's dead code
suggestion and balaton's concern about things changing at runtime
(would be possible if let's say adding/removing a phb is allowed from
qemu console)

This generates the fdt everytime on a pnv_reset, which might be same as
previous fdt but takes care of the cases where any device changes
between init and reset.

What do you all think on this ?

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f37..7eb4e8ac2f06 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -773,26 +773,15 @@ static void pnv_reset(MachineState *machine, ResetType type)
         }
     }
 
-    if (machine->fdt) {
-        fdt = machine->fdt;
-    } else {
-        fdt = pnv_dt_create(machine);
-        /* Pack resulting tree */
-        _FDT((fdt_pack(fdt)));
-    }
+    fdt = pnv_dt_create(machine);
+    /* Pack resulting tree */
+    _FDT((fdt_pack(fdt)));
 
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
-    /* Update machine->fdt with latest fdt */
-    if (machine->fdt != fdt) {
-        /*
-         * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
-         * the existing machine->fdt to avoid leaking it during
-         * a reset.
-         */
-        g_free(machine->fdt);
-        machine->fdt = fdt;
-    }
+    /* Free the previously allocated fdt and update with latest */
+    g_free(machine->fdt);
+    machine->fdt = fdt;
 }
 
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)


