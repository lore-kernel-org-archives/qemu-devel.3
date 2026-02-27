Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC564FD7F8E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvv1e-0001Mc-RH; Fri, 27 Feb 2026 05:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvv1b-0001LK-Ji; Fri, 27 Feb 2026 05:24:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vvv1Z-0004At-Ul; Fri, 27 Feb 2026 05:24:47 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R7NO5X2233752; Fri, 27 Feb 2026 10:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=7xfyTa9sQ3M4DMPjio99fcyitWU2v9
 BSiWB1gwLSzUA=; b=MgwQ9cGMREWebBfUxsdzO6FgqU+AH8oeF5DYOcYG4KzydJ
 BrpctUpsNv33O4Q+yia8b7vthUdV4riKVTDvj8a88PpCAOiYE1/5WQzTf16aqj0L
 MurVYIlY4m1t4/BmrxzO4sMb9D7glmCP2M1zzR+QlaDrCQ2H9cVdXQYqMk9r3b/v
 yBggAf2c1MrKlC26zrC/2/xqgdOtqoFiNR6fSXmsd5f174ybIYLqereIGRodZzVB
 w22egZN+TyuhHKkLFC4FlYRdGCAbEbuWqzSTI67dUdRJZm16pRSnQiXwUNMAivdG
 ERsrK3SVBGpv6kh6H02taKNzuLt9YSi9WViHI/2A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf472caft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 10:24:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61R76xdA001653;
 Fri, 27 Feb 2026 10:24:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1nhnpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 10:24:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61RAObkq37814680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Feb 2026 10:24:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC3DE2004F;
 Fri, 27 Feb 2026 10:24:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F5FD2004D;
 Fri, 27 Feb 2026 10:24:34 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.210.232])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 27 Feb 2026 10:24:34 +0000 (GMT)
Date: Fri, 27 Feb 2026 15:54:31 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: shivang upadhyay <shivangu@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
Message-ID: <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DQsEx-rS80VXSAEy4uqHu_nxmXtOyqIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NyBTYWx0ZWRfX14K8qhhssziR
 yq5ni35ngC6HM41fHRDddkWuocWcDsB4gtWkMI9CcqeB75cxFkmlYVAxVV50e0EpYr5a6fO/q4R
 LtwuoJBLVkGdUVbIKDbOjnTVvmZEKyo8LVbqc/1kEND391zME2erCDtk9P9I45gkHgW8IamrBNM
 1r6k4jbr7jU0szZyan9Jsuk4jznpW9P7DRcltF6k/ptZo8OdDF9YdH/uk3gBJ9XDRaEfHPUqzk3
 v3xZpa36qDRfnALgBKkuvjc7ej/dkirbT7pV6WCFjEk0516F+NPmN+JY8OdiFTJfQp1lTx8DAhG
 TnZ9mI/fo7yYyfIud+whgP0npBDHTWVD8voyzXrWIIkQyvx3/fIZs0tU2atU2VmUfP1Ho5oCjft
 Vy4r7Fc0M77wme6ZZEpAqHjoOi6QtXseAcckQaN2B4ql6iaWX7ExyvNDfJNPMherVCeCpkuOjWo
 AwMAHOF2VCIin968ozg==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=69a170ea cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vgz_7i7j5wqnLQ5aguMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: W6SmiBSbmHom9rUVgQ4Gld83ge5--sHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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

On 26/02/27 03:43PM, shivang upadhyay wrote:
> > <...snip...>
> >
> > Q: can the generated DBT genuinely be different on a
> > subsequent reset than it was when QEMU first starts?
> > The comments in the pnv_reset() code seem to suggest it,
> > but on the other hand the code as written will only
> > call pnv_dt_create() and update machine->fdt once on first
> > reset, not on later resets. So perhaps the comment is
> > just confusingly worded ?
> 
> Yes, I am not much familiar with the design here. But, as per
> 
> my current understanding of this code, DTB content should not
> 
> not be changed.

To add to this, yes, normally reset path doesn't change the device tree,
since all reboots are the same as the first boot.

As of upstream this is true, I don't see dtb changing between resets.

One case where reset path does change the device tree compared to
pnv_init part is Memory-Preserving IPL (MPIPL), which is a
dump-collection feature in powernv for collecting dumps after kernel
crashes.
This is not merged yet in upstream, and is currently in discussion [1].

I am okay with the dead if condition in pnv_reset to be removed for now,
we can add it later for mpipl purpose if needed.

[1]: https://lore.kernel.org/qemu-devel/20260225124633.1841222-1-adityag@linux.ibm.com/

Thanks,
- Aditya G


