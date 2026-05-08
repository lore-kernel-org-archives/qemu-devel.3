Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1787BCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 10:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIIS-00079S-G4; Fri, 08 May 2026 06:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wLIIQ-00079A-NF
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wLIIO-0006io-Qj
 for qemu-devel@nongnu.org; Fri, 08 May 2026 06:19:02 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647Ho4CY1446669; Fri, 8 May 2026 10:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=fX2JvlCFJSLnuL7j+lUZ+7/srAQIa7
 i8NI0oHFiHQVQ=; b=Gv+ah6Um+9IwSZ3f3e1sjn8aqOK7zSUmFk3azldQJpnJpm
 a/42BYEfERwkYfFs5+t5DWtYDJoqSeHFIOh3rp6lr8NKMGe7N3HTF37e4H4KyJph
 ma2BFtnhWgySEQwTK1KvVABpMeCzdNOszYI/jr3lV/Oeu8ZI/r8c9cKS2nvUdilG
 FlB6lJn+7x5aRJBQYjzmLh7WFniJABKL4m8Wh/PiSGA3qUnKWxQYhOeTrEm9cTCd
 BLd8DCdTs85GQOaUJNtHkg55j7kb9trMQyQlmSAzHrjvmEWsxq+PemZycQXJT99A
 VdF4SW6raiCHfXgWAox/yI4qUxec/F4gmS55MD4g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7u7jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 10:18:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648A9Q52012163;
 Fri, 8 May 2026 10:18:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hfp96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 10:18:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648AIqrx31064672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 10:18:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D5B72005A;
 Fri,  8 May 2026 10:18:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB22C20040;
 Fri,  8 May 2026 10:18:48 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.21.105])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  8 May 2026 10:18:48 +0000 (GMT)
Date: Fri, 8 May 2026 15:48:44 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PULL 06/13] pnv/mpipl: Set thread entry size to be allocated by
 firmware
Message-ID: <af23vJuBrukZ2EHI@shivang.upadyay>
References: <20260429183310.12455-1-harshpb@linux.ibm.com>
 <20260429183310.12455-7-harshpb@linux.ibm.com>
 <CAFEAcA8L3CXj1gc3dXehhZWd5rPyuF6bykNR5Oy=u0ZWyR2sLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8L3CXj1gc3dXehhZWd5rPyuF6bykNR5Oy=u0ZWyR2sLg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfXwkkhKXYyPoW/
 xqW73gEjWOjTmq3T+LJkES/uRjydbYeTqWBkJoD61cchfwhf20GwS80xQODKRh/K2hT29d8Nk/Q
 n67wMNcig8NwhGr9+Zid0do6SumXKmxYgKbWC+3nXoMm8RgFSlU8doEVJoXHoFujYW+O7JAmu2M
 3bB88NQAmXQCNh/MKyBsSlcRv4KaOQya5gABc0PBOjTIJ0ORX94enIofyWagZFggwq+AFUJ0h/f
 mGkbA2witr7IRvJN42xk3m1NilqyloHTNKCKUt4PZ+2Khq9hh67vMmPBtrzzRRndkzmA/vFcGem
 SZPNB6WdtRcgXBTBmZ6I9tI3JjyUxxVOO3vE7wP9yqy1mJczNFEKc/79AfDwG7O3+xJgrmnQwOd
 nJhvkWI2hjNNrqoVfcRh75YAO2jq1sBUsDBFkiPOPWRUId+KN+rWEZhJYyVMCLejyU9T5iINOCg
 bkulrD4NIvXtwT6njBA==
X-Proofpoint-GUID: mjKAnloXfRfXJJgtqRnvgXOxEtbyIt_3
X-Proofpoint-ORIG-GUID: mjKAnloXfRfXJJgtqRnvgXOxEtbyIt_3
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fdb891 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3MYzMO3vcf9sDPJt79AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080104
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Peter,

On Fri, May 08, 2026 at 10:15:10AM +0100, Peter Maydell wrote:
> On Wed, 29 Apr 2026 at 19:35, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
> >
> > From: Aditya Gupta <adityag@linux.ibm.com>
> >
> > Set the "Thread Register State Entry Size" that is required by firmware
> > (OPAL), to know size of memory to allocate to capture CPU state, in the
> > event of a crash
> >
> > Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
> > Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > Link: https://lore.kernel.org/qemu-devel/20260424083837.214947-7-adityag@linux.ibm.com
> > Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> Hi; Coverity points out an issue with this change (CID 1658041):

Thanks for reporting, I'll look into this.
> 
> >  static void pnv_reset(MachineState *machine, ResetType type)
> >  {
> > +    PnvMachineState *pnv = PNV_MACHINE(machine);
> >      void *fdt;
> >
> >      qemu_devices_reset(type);
> >
> > +    if (!pnv->mpipl_state.is_next_boot_mpipl) {
> > +        /*
> > +         * Set the "Thread Register State Entry Size", so that firmware can
> > +         * allocate enough memory to capture CPU state in the event of a
> > +         * crash
> > +         */
> > +
> > +        MpiplProcDumpArea proc_area;
> 
> Here we don't initialize the struct...
> 
> > +
> > +        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
> > +        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
> > +
> > +        /* These are to be allocated & assigned by the firmware */
> > +        proc_area.alloc_addr = 0;
> > +        proc_area.alloc_size = 0;
> > +
> > +        /* These get assigned after crash, when QEMU preserves the registers */
> > +        proc_area.dest_addr = 0;
> > +        proc_area.act_size = 0;
> 
> ...and here we don't fill in all the fields; we don't set
> the reserved, reserved2 or reserved3 fields to anything.
> This means that we will write data to the guest which is
> potentially random host data from the stack.
> 
> I think I'd suggest fixing this by initializing the struct in
> one go, like this:
> 
>     MpiplProcDumpArea proc_area = {
>        .version = PROC_DUMP_AREA_VERSION_P9,
>        .thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState)),
>        [set alloc_addr = 0 etc here if you like, or rely on
>         the "fields not listed are zero-inited"]
>     };
> 
> (In fact because we use -ftrivial-auto-var-init=zero the compiler
> will zero init this for us anyway, but we can make Coverity
> happy anyway.)

Thanks for suggesting the fix too.

~Shivang.

