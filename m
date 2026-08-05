Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82446C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrcgL-0003IB-My; Wed, 05 Aug 2026 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wrcgH-0003I3-QG; Wed, 05 Aug 2026 10:33:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wrcgF-0006jF-S8; Wed, 05 Aug 2026 10:33:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675CHiaH3875616; Wed, 5 Aug 2026 14:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=eByxXFrenY/UiVUwEA+ukdjYMFOF1y
 g8725FYyKEDA0=; b=O+zPLbn9UFJqpQhLRwvWWDGrVkuLcu6aOUXkIcIvaUB2S7
 JgqcjFn8kgQ/lKuvqFJGdcTfEJGQVLv8yvwMUffADC338EggeQ5E1qa7D8bie05+
 NoSNKO4ClVVWbMDNmKseGnFlI+oC6NAa6sqxX5cagV5yDfFRBqqfBPTBeNXlKiZQ
 RYjzpiTYyltmM7poFlPemBGXZN1uTB+Sdiee7rOKLcTNRwiV45aeY2s7x4MbNE8I
 Ll2e73/BX6UBBsO+p4cyRCyDvQuHiur5HkYxafdNL+Cj4SQYmF3/IK8mlPVkzp1t
 uSmidkTk7bT6hfs856I0UUzvMIcDmxaGiMmDvMfA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eutye1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 14:33:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675EQIwL017829;
 Wed, 5 Aug 2026 14:33:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtypq5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 14:33:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675EX0P647710698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 14:33:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D42712004E;
 Wed,  5 Aug 2026 14:33:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83FD42004B;
 Wed,  5 Aug 2026 14:32:58 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Aug 2026 14:32:58 +0000 (GMT)
Date: Wed, 5 Aug 2026 20:03:44 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] target/ppc/kvm: Use host compatibility mode for
 nested guests
Message-ID: <20260805195553.784a407c-48-amachhiw@linux.ibm.com>
Mail-Followup-To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, 
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
References: <20260804182914.83091-1-amachhiw@linux.ibm.com>
 <20260804182914.83091-4-amachhiw@linux.ibm.com>
 <bce28234-2d74-8a2d-d21f-ff1844147441@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce28234-2d74-8a2d-d21f-ff1844147441@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZeQjECD4a2YKXUo4xK4gPoHt_xrCqVr2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExNiBTYWx0ZWRfX1fBVPINxdN9t
 JJbQTYzlQt0H8fzLhTAjqN0V59HXCLY8d1srYp8m0H7vdl3vciv5kvWQezbhizwBpzBT6iEIAy1
 7S4CXfaux/K2li1YWY3mjmJ27wZoA4w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExNiBTYWx0ZWRfX2qwfOanNj+HP
 QMGNmT9xS2bAk2tmwes5XugJdbnrWjHZEXf8k6kZ7lMjqEo5zzEvBejVCWJvX+toJSrb2O83mOU
 2ludOu+wNd6l7NHyoG6Wk3YPeqkWcSOk35q7GDudl4oJKWMfVjH0V0d+rlIHAT4oFai3fm2vSXr
 ccj0aLR3C1ts5pI2wGREgrfAeFM9d72U1k5LTM5ndu6hWFCM5/YwP3qZLUxfhJpt4d625sWQrNC
 72DC4MDTRzNX+C5kSOuwt59RApeoxws1/FaM/gY99Oq+Jhv5WBx/13paoVNn5SjGQO/UMrhCfTJ
 sbf5yCIsg3IBIrheWXQ0KF/2VOMvU/VhE4C1cL6GGBZQ/5S78vOcaASGRXIs7fmwCh6xkUbgQBo
 tuq6fgQT/cGpHNTbmsYqHCG2Qsfo7sulFFvs1aaI8n2by6FrKq5SBhEilSz2OwfoE7X8uaQ/noN
 bWG2hC01T8bbLPwGWCw==
X-Proofpoint-GUID: xNRzyKEZnH7ffI9P35sCyL_CnCUCYe3p
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a7349a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=xF5bT5f_zixZ1sonTMAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050116
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi BALATON,

Thanks for reviewing this patch. Please find my response inline below.

On 2026/08/04 09:55 PM, BALATON Zoltan wrote:
> On Tue, 4 Aug 2026, Amit Machhiwal wrote:
> > On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> > a Power11 processor operating in Power10 compatibility mode). When
> > running nested KVM guests, QEMU currently derives the host CPU type
> > using mfpvr(), which reflects the physical processor version. This can
> > result in a mismatch between the CPU model used by QEMU and the
> > compatibility mode enforced by the host, leading to guest boot failures
> > such as "KVM-NESTEDv2: couldn't set guest wide elements".
> > 
> > Update kvm_ppc_get_host_cpu_class() to check if the host is running in
> > a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
> > use the compatibility PVR instead of the raw hardware PVR when selecting
> > the CPU model. This ensures that QEMU selects a CPU model consistent
> > with the host compatibility mode, allowing nested guests to boot
> > correctly.
> > 
> > The guard uses #if defined(TARGET_PPC64) to prevent build breakage on
> > ppc32 targets where the POWER9/10/11 PVR constants are not defined.
> > 
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > No changes in this version.
> > 
> > target/ppc/kvm.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> > 
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index d4c5601a00c4..aa8269186a1a 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2682,6 +2682,18 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >     uint32_t host_pvr = mfpvr();
> >     PowerPCCPUClass *pvr_pcc;
> > 
> > +#if defined(TARGET_PPC64)
> > +#ifndef CONFIG_KVM
> > +#error "CONFIG_KVM is not enabled"
> > +#endif
> 
> In meson.build:
> 
> ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
> 
> so I think this check and #error does not make sense.

You're right that kvm.c is always compiled with CONFIG_KVM enabled due
to the meson.build constraint, so the #ifndef CONFIG_KVM / #error check
can never fire. I added it as an explicit compile-time assertion to
document the assumption, but it is redundant given the build system
already enforces it. I'll drop it in the next version.

Thanks,
Amit

> 
> Regards,
> BALATON Zoltan
> 
> > +    uint32_t compat_host_pvr;
> > +
> > +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> > +    if (compat_host_pvr) {
> > +        host_pvr = compat_host_pvr;
> > +    }
> > +#endif /* TARGET_PPC64 */
> > +
> >     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
> >     if (pvr_pcc == NULL) {
> >         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
> > 

