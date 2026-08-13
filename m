Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917B8C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRDc-0005AW-Ek; Thu, 13 Aug 2026 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuRDV-00058U-Bt; Thu, 13 Aug 2026 04:55:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuRDT-0003mv-PA; Thu, 13 Aug 2026 04:55:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D61WPw3845951; Thu, 13 Aug 2026 08:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=YWV27b2Iv+Yq7iNm4C4okEWx/iG+h4
 9dU0F6Z9jA98o=; b=OdLWOFCCAnyMTywwZn/ydFordZR8ck660Dxrkm8Z9gQ2WZ
 yeYuz9YF2oeRfa6OP9O2r1ZKFzvJZXXdBlil1cFAH4066cBrsMO0el37/id4Ghk8
 N0ZJmYz+3xJCBLI+Tx+HNpVGONyKSSluxuR2oKNA2hDmSWyiet5eshOiiO5nJMSR
 EFfpXy6I1j6/KujeT4Xr5OgfZi0l2OT6afCU/Uj0oGeOT+aP8vfeLJDSW2TKY+uE
 hYaNfzc7oEex6lGPoqkwwCb+RKZWJWc4SjXu6cnPnlGVv47s9Cl26LY6Nv11w87o
 7cn2ZsMDK2ARqFqsvwp3uCFhRNXJjuiDwHUBZODg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk072cf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 08:55:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D8fZJC008538;
 Thu, 13 Aug 2026 08:55:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk29v6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 08:55:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67D8t0ij48955852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 08:55:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4417920043;
 Thu, 13 Aug 2026 08:55:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 942F920040;
 Thu, 13 Aug 2026 08:54:57 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 13 Aug 2026 08:54:57 +0000 (GMT)
Date: Thu, 13 Aug 2026 14:24:25 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Penney <matt@matthewpenney.net>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/qtest/libqtest: Use GLib functions for proper
 const correctness
Message-ID: <20260813142314.a35f14e0-27-amachhiw@linux.ibm.com>
Mail-Followup-To: Fabiano Rosas <farosas@suse.de>, qemu-ppc@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Matthew Penney <matt@matthewpenney.net>, 
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
References: <20260522082555.54918-1-amachhiw@linux.ibm.com>
 <20260612122835.ede570b2-b5-amachhiw@linux.ibm.com>
 <874ij7kj71.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ij7kj71.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX3mn+VeMf7/Qa
 ppsAu2yhD9XL38IKrcPfl3ZVHvs35dItWC1tVf4pW6vtpJEKunPoH3eIj2gz7RFvbiXh2bnWMbH
 hKdCpMLkMc9S0G02ulTlI4WXQEOrIsYLSC3i1lKtGQwnu27PzvJwZztEl+XtFdXN3uTeLmPfPzH
 zbOwqJVMh9/7AZfoQHeT/+xs+Q8h7m7Qm7ZsiOeUz0xaHQ5oxrghlagKD2n/dn7zO9EuB/AKVpG
 lVJwS2hwn1RWGe6KZMuZ+rME35a6tAdYwqIty9h6RWhlWhiFvyndIHrB3NQqKQiVA2eD58eBww2
 DL0rzcnuFnrGYzCp3O5VB4cujsefiYHdU//ukzOVHDpL61i7L22bA4bRNfTdl/bz9o/aDqvB0nt
 S2XoVm1zr+r6oQQctWeSbuhmOGNy6Xir7OFjzeA5Yspeq5EwtVQuddJHHp1casMW0yj/egoDTZF
 nSWdfpoYZTG8jXsodkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX2dOkjF6vFPB7
 z5nvFByoKYVO0uXilX6LAfrJk9pNDcXqcLXnBi0lxgAJlfxPXZIvNXZ3C5SYcb/jUSVMPtjusdC
 o8zL2SZfTwSYabvgcDp9PmrM5r7wyG4=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7d8669 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=E09fEPM4Ae6th8StKnQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: LHvjkjrPU-MJA7ImCHVV3Adb9e2W2j40
X-Proofpoint-ORIG-GUID: LHvjkjrPU-MJA7ImCHVV3Adb9e2W2j40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130058
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Fabiano,

On 2026/06/12 10:00 AM, Fabiano Rosas wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Hi Fabiano, Laurent,
> >
> > Did you have any review comments on this patch?
> >
> > Shall this be picked via your tree?
> >
> 
> I'll take it, thanks.

I do not see it merged yet. Has it been queued yet?

Thanks,
Amit

