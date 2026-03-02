Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9EFC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzWJ-000570-UD; Mon, 02 Mar 2026 04:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vwzWF-0004wl-Sn; Mon, 02 Mar 2026 04:24:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vwzWE-0007yt-83; Mon, 02 Mar 2026 04:24:51 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 621AGQmO726661; Mon, 2 Mar 2026 09:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=wMppmKkjzbTSu5/FVyVnJ0/MQMIc2J
 Esx1DOSIgXpAk=; b=q+JOJom0/d7JPxfgEXeIaA7k1HvEjslNbZ0jv8pNQPy6a0
 dph/55jhY/n+F79tTQPP+P/NqTc1z9A8MIeEbd1qQ7j7HKEfj+8vmyaDmU/+1p5Q
 kSESUlzAy8AynFPKnVPAPIE4jm1gHRhP2PTWVt7HIpkXGB2m9+8UCSsfNrEy69wp
 MGlZ9hzt0DWyrbCIRZlkk1kgTqfc1xn5ISUENJ0WLaYi7zhF3yuV/hUca4FKQrHv
 kf3pgnVdPPqhSWEh+Xk7rrJgb3+vnRTZ5+JpBfl+QuZgN9sTneHD4cu4IqlaZ+Ul
 Pmf8dzU8LbjERfoKpOEB58xsusPfRDxAtG7YiPhQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcnr24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 09:24:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6229BRlu003284;
 Mon, 2 Mar 2026 09:24:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xw9tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Mar 2026 09:24:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6229OUFD37487096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Mar 2026 09:24:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C081C20043;
 Mon,  2 Mar 2026 09:24:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3F5D20040;
 Mon,  2 Mar 2026 09:24:28 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.79.204.232])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  2 Mar 2026 09:24:28 +0000 (GMT)
Date: Mon, 2 Mar 2026 14:54:26 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
Message-ID: <7yq2eac5yzsx2ve2nwbs7uhjguemravsimtm26dkgppeczqmix@wtrwux3aeswg>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
 <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <648a3687-6356-8063-b4d4-a0bbc332dd0c@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648a3687-6356-8063-b4d4-a0bbc332dd0c@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: UMVxnkpU0AvNELA3WBrrxwXM9IAeMni0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3OCBTYWx0ZWRfX2IeXQVxpjCQ1
 GmyrNW42JfW/HWMBA0GyUEdRrED0G8D27iLZ1ijhQXKMGEHCQhmjK8PcV20U7aryRvUsz2usyJy
 PlB3qVGzzgoGo0ht4Puwlz0unzj5uRDbn86A1jbxHx1sC1atCvihzc0Pkiww/KDwR5XEALrKWxU
 HWWRF+nP8ENGhtGmqgjLdhToBdiqAOcQIZ+vej4MEWSvk04WiPfQ2X2CyPADEAPrV8pCPCeafws
 y4iOfnL4y5ZmipDaa2VetEKl1qXQX2aWDdOFpAAvRLwdFD9beEPAXQ4Mnfz9rKh4gbG3nwJdmju
 I0V139D0LQhKI7Xgh8KqqSgfo5YSOQIWTEM23hG7Zx+B4Hlx3dsdRpwSr4oWwGwLuVc22TBIjJL
 byFfiZtJN2U7xTU9yIjADH3C14AKMpBHLgL1B9wJZG51JmYcqP09dl+ESXlcCb/h0VOLQR8Bsia
 EdBmj/e7Fl7K52rdyBA==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a55754 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=OmxVkkl3oSMogOC1_KYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: NVV281ExK2trG4GekwNtyGbg2_5PGUmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020078
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Hi Bolaton,

Thanks for taking the time to review.

On Fri, Feb 27, 2026 at 04:53:56PM +0100, BALATON Zoltan wrote:
> On Fri, 27 Feb 2026, Aditya Gupta wrote:
> > On 26/02/27 02:05PM, BALATON Zoltan wrote:
> > > On Fri, 27 Feb 2026, Aditya Gupta wrote:
> > > > On 26/02/27 03:43PM, shivang upadhyay wrote:
> > > > > > <...snip...>
> > > > > > 
> > > > > > Q: can the generated DBT genuinely be different on a
> > > > > > subsequent reset than it was when QEMU first starts?
> > > > > > The comments in the pnv_reset() code seem to suggest it,
> > > > > > but on the other hand the code as written will only
> > > > > > call pnv_dt_create() and update machine->fdt once on first
> > > > > > reset, not on later resets. So perhaps the comment is
> > > > > > just confusingly worded ?
> > > > > 
> > > > > Yes, I am not much familiar with the design here. But, as per
> > > > > 
> > > > > my current understanding of this code, DTB content should not
> > > > > 
> > > > > not be changed.
> > > > 
> > > > To add to this, yes, normally reset path doesn't change the device tree,
> > > > since all reboots are the same as the first boot.
> > > > 
> > > > As of upstream this is true, I don't see dtb changing between resets.
> > > 
> > > Isn't VOF allowing clients to do setprop that would be changing the device
> > > tree? Some settings are stored there so maybe it can be changed by the guest
> > > that should be preserved between reboots?
> > 
> > By VOF did you mean the pseries f/w ?
> 
> I don't know much about these machines. I meant Virtual Open Firmware in
> QEMU or SLOF which it can replace. But maybe this is only used by spapr so
> does not affect pseries but in spapr there's spapr_vof_setprop() which looks
> like it can change the fdt. Maybe it's handled differently on pseries, I
> don't know.
Yes, Vof/Slof firmware are only used for pseries.
for pnv we use skiboot.lid firmware.
> 
> > i don't see anything changing the dt in powernv as of now, but
> > for some edge case, where that is possible (will be possible atleast
> > after mpipl support is merged), we can always update the fdt in below 2
> > if cases in pnv_reset:
> > 
> >    > if (machine->fdt) {
> >    >     fdt = machine->fdt;
> >    > } else {
> >    >     fdt = pnv_dt_create(machine);
> >    >     /* Pack resulting tree */
> >    >     _FDT((fdt_pack(fdt)));
> >    > }
> > 
> > machine->fdt will never be NULL since it's being set in pnv_init
> > should we just do pnv_dt_create on every pnv_reset ?
> 
> I don't know either but wasn't original code meant to either create an fdt
> or take what the user specified with -dtb option or similiar? In that case
> maybe you don't want to override the user specified dtb but I could be wrong
> about what this is meant to do as I have no idea whatsoever about these
> machines.
I think I should just remove all the fdt changing stuff from cpu_reset.
Becasue nothing is using it as of now. We can introduce it with mpipl patches.
That would make the code easier to understand there.
> 
> Regards,
> BALATON Zoltan


~Shivang.

