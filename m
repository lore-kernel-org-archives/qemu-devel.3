Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9350FEFB54
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzBY-0000zw-6k; Fri, 27 Feb 2026 09:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvzBV-0000zA-Mt; Fri, 27 Feb 2026 09:51:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvzBT-0001Cy-Hb; Fri, 27 Feb 2026 09:51:17 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RAX0052348898; Fri, 27 Feb 2026 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=55kHhQC+MY/NOfkgPvrYPIdSA7tDTk
 nM0rOIlHBXho8=; b=IscQntAXLCHbGYV2LOlgNlOHDmj9Gwy1hCv4WDnQvW0OJB
 jLNbDdriBeQGReyhShp1Eq7NRSltx7KaGHpnQa1Dsy5/1JbI6AbwiGKHlHvJlveu
 gFxocnBp+RD0Ejdr/aoYYRx0zV8nw530DY/YTS0hWmWRT+sUzD8eR+mUbnaQWmdN
 ewQEPgfDbSera1Zdqv+Tq3g49rQxy3xi4b9F3IUVBff5oJOLiWr0DgrpVaC6FbdV
 ntli0ogdM+z2sikoWj1bXkxCGvzzI56pG22yZq8GpuJGgadaHWVEBjoTNTs40q0A
 PcBQP7MrBhOYIMz0lvqnGOUvTehEzmPkkuSM6aXQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch8592mwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 14:51:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RBwtSa003821;
 Fri, 27 Feb 2026 14:51:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8kaens-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 14:51:02 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61REow8Z52232472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Feb 2026 14:50:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F92B2004D;
 Fri, 27 Feb 2026 14:50:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 801B220040;
 Fri, 27 Feb 2026 14:50:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.210.232])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Feb 2026 14:50:54 +0000 (GMT)
Date: Fri, 27 Feb 2026 20:20:51 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 shivang upadhyay <shivangu@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
Message-ID: <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEzMCBTYWx0ZWRfX01Kp3V+EnoDD
 /qahMpKKPK8cNNeCt4gWNmbMnDUemoxG9DCLBomQrXgAckg5U7aPW61FOBhNX2QJ9yGn9rpexfs
 J7P1GGOQ2M6YPxKzSifJezFtwcEUAu2dJXiAgDA4OwrpViHh1oRG+ugcjZ4TXrE4qWbyLvBWu1a
 vf+It+Z/xIZjAxY4ZbD2j14icPK9gcvhnrA9Sm4Vx+gupBFN7hfd2KJOZpLWTi30lcf8UEQwTy4
 Q07HcoUPIzg1HdNkUkm0tznmgRaik+cUXO4Q5XiARwwhr+6prKrV+DWR421qRgygSO+zeX/+Yzr
 LeAeIUbKLvlzpDslm4fdJT9rD7F57956UCHYx2k4fGINdXrpmbcf4NhXoeCwdgGHUhlXEzXfw34
 QhnXLk4ypyVrjZPU431Xok8ZeFg9qNaXlIMRbf//p5fJyThXxs9ctSGsCOqYOLszUv4P7lNPwzN
 dEAw/WFSVsifHyyPozw==
X-Proofpoint-GUID: mCCLRHFEAVzms6gu0vERqP0OLnBvzd6-
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=69a1af58 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OZ5Y-U5fcf9rFpoNtcUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 8KDn4W_twThEBq7IElZ4M1vAW4dIS_yP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
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

On 26/02/27 02:05PM, BALATON Zoltan wrote:
> On Fri, 27 Feb 2026, Aditya Gupta wrote:
> > On 26/02/27 03:43PM, shivang upadhyay wrote:
> > > > <...snip...>
> > > > 
> > > > Q: can the generated DBT genuinely be different on a
> > > > subsequent reset than it was when QEMU first starts?
> > > > The comments in the pnv_reset() code seem to suggest it,
> > > > but on the other hand the code as written will only
> > > > call pnv_dt_create() and update machine->fdt once on first
> > > > reset, not on later resets. So perhaps the comment is
> > > > just confusingly worded ?
> > > 
> > > Yes, I am not much familiar with the design here. But, as per
> > > 
> > > my current understanding of this code, DTB content should not
> > > 
> > > not be changed.
> > 
> > To add to this, yes, normally reset path doesn't change the device tree,
> > since all reboots are the same as the first boot.
> > 
> > As of upstream this is true, I don't see dtb changing between resets.
> 
> Isn't VOF allowing clients to do setprop that would be changing the device
> tree? Some settings are stored there so maybe it can be changed by the guest
> that should be preserved between reboots?

By VOF did you mean the pseries f/w ?

i don't see anything changing the dt in powernv as of now, but
for some edge case, where that is possible (will be possible atleast
after mpipl support is merged), we can always update the fdt in below 2
if cases in pnv_reset:

    > if (machine->fdt) {
    >     fdt = machine->fdt;
    > } else {
    >     fdt = pnv_dt_create(machine);
    >     /* Pack resulting tree */
    >     _FDT((fdt_pack(fdt)));
    > }

machine->fdt will never be NULL since it's being set in pnv_init
should we just do pnv_dt_create on every pnv_reset ?

    > /* Update machine->fdt with latest fdt */
    > if (machine->fdt != fdt) {
    >     /*
    >      * Set machine->fdt for 'dumpdtb' QMP/HMP command. Free
    >      * the existing machine->fdt to avoid leaking it during
    >      * a reset.
    >      */
    >     g_free(machine->fdt);
    >     machine->fdt = fdt;
    > }

we can unconditionally always update the fdt on a pnv reset. should be
harmless, for the default case it will generate the same dt.

this should handle any edge case where in future if dt should change
between pnv_init/pnv_reset

What do you all say ?

Thanks,
- Aditya G

> 
> Regards,
> BALATON Zoltan
> 
> > One case where reset path does change the device tree compared to
> > pnv_init part is Memory-Preserving IPL (MPIPL), which is a
> > dump-collection feature in powernv for collecting dumps after kernel
> > crashes.
> > This is not merged yet in upstream, and is currently in discussion [1].
> > 
> > I am okay with the dead if condition in pnv_reset to be removed for now,
> > we can add it later for mpipl purpose if needed.
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20260225124633.1841222-1-adityag@linux.ibm.com/
> > 
> > Thanks,
> > - Aditya G
> > 
> > 
> > 

