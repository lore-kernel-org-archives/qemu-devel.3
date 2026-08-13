Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75D7C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuR7b-0002Zl-JY; Thu, 13 Aug 2026 04:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuR7F-0002RS-Ve; Thu, 13 Aug 2026 04:48:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuR7E-0000w0-4H; Thu, 13 Aug 2026 04:48:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D61bJq1527742; Thu, 13 Aug 2026 08:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qSh4Gr
 TtvRttjUuQ4Xp8H8nAqI7U8DtSSwyfL7xUPrM=; b=cyNIAEht7/ipLe4lnwbX0Y
 cNlnbRJYUzxIrbt7/hXe4B4reRx60wCvSl7CjgqkTkgHYXOHZBPP/dOvF27gXzjy
 xYnNhUaxeiCCzdtpL6c94wLJB3s58Y7DuVHfmv2/vshUO2C7UySmT9rV8As2p4cX
 kp1Uj7SFOfKc80ebS86rfFqpnsn62BaYOlcHNcNjXsGJmE6pSNaQl2hCGX8plRzi
 aB3tdHRjw2N6GUDhvK8PwjLCSgZfDy2phhfXZV7JXAsKDShdiIFKgh/CIxw72UW3
 rawwKhVwI08AMKdPyYG3r0eXErvs1sBu0HkBFVsdpZHxZGb4+GkA/ZekF9XNLt4w
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9y3v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 08:48:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D8fLYn011563;
 Thu, 13 Aug 2026 08:48:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gj56b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 08:48:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67D8mRPP46137600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Aug 2026 08:48:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A02D320049;
 Thu, 13 Aug 2026 08:48:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9C4120040;
 Thu, 13 Aug 2026 08:48:24 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 13 Aug 2026 08:48:24 +0000 (GMT)
Date: Thu, 13 Aug 2026 14:17:52 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header
 changes
Message-ID: <20260813141558.717561f0-33-amachhiw@linux.ibm.com>
Mail-Followup-To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, 
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Vaibhav Jain <vaibhav@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
 <20260812170854.58709-2-amachhiw@linux.ibm.com>
 <an1zrUhbu_RYkJ-y@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an1zrUhbu_RYkJ-y@kunlun.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfXzubfC/l65KHd
 q5kYpONM8fI+DGFl7zuHmiszVhveH4tVRL///hSRhZNZyfBtAj6oWBUSaAPgoQB4m3oQ1ldRWzS
 2fv5PCdtvFMvTwFlsKQ7qwWNIGiE1OUGpNRIfDae+q/kN42ahVedsOFa+0gF3ZxWoCIHVfuGLM7
 4Dv8gZR6OH7o/dUD1Oqwy2wEQpJyQZONuBMh2n2cFCCxLdN0+bgl+O8Nnkq4lxlWzxosvAtnFA/
 R6DrY29wQfeXuZQPIFBHo4J4aFvxPXex7hdrgcQEa6Q6Zo7kKrH0ly8tZfviCIwk00SkrLPgruK
 EWuM3CcGEr2uHEtqfRmrAzvCxVHUCSwTNSZSE+VNyktYyjRO4+28Z2JQ0XGBoBoTb1ft0hBhad8
 OqMQVBmwZfMrUGOBclSwxfdELqbCt0ELjKJrf1DLHb2gbYaXL+Y0ro3QpvMAgTrJ76gwqWF/sED
 XZ5xddnz77VxDFv+UjA==
X-Proofpoint-ORIG-GUID: wPRGG4IJV_tXH3Hj5HTzZj-dZJ7dPRIR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1OCBTYWx0ZWRfX4Lr4XPUc66hF
 IyJ63Ctvptic8CpK0ZNZByiSF4/pLJW8jCdrPyp124WpQ0r7/KceRX2Xa5ThKEkPmJNLjUc547W
 DhdrFe/Bmb8Nzwo6JvL4jjGz+mxj4ZA=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7d84e0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-yLZjq0usqvOWjqILtoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: wb2FP9HZQ2qYH3KOL7OFzIt2l99BgNs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130058
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

Hi Michal,

On 2026/08/13 09:35 AM, Michal Suchánek wrote:
> Hello,
> 
> some version of the kernel patches seems to be merged in the powerpc
> tree now.
> 
> Cant his be merged now or is a refresh required?

The Linux series which introduced the UAPI changes is still in ppc/next
and yet to be merged upstream. I believe the header sync can only be
done once the patches are merged in mainline.

Thanks,
Amit

> 
> Thanks
> 
> Michal
> 
> On Wed, Aug 12, 2026 at 10:38:52PM +0530, Amit Machhiwal wrote:
> > This is a temporary patch intended for review and testing purposes only.
> > It syncs the QEMU linux-headers with the kernel v9 changes that introduce
> > the KVM_PPC_GET_COMPAT_CAPS ioctl for querying host CPU compatibility
> > capabilities. The struct kvm_ppc_compat_caps places 'size' as the first
> > field as required by copy_struct_from/to_user() versioning, with
> > KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) defined as the frozen version-floor
> > constant. The capability number is KVM_CAP_PPC_COMPAT_CAPS (250) and
> > the ioctl is defined as _IO so the ioctl number remains stable if the
> > struct grows in future versions. Capability bit definitions for POWER9,
> > POWER10, and POWER11 compatibility modes are also included.
> > 
> > The actual header sync will be done via scripts/update-linux-headers.sh
> > once the kernel changes [1] are merged upstream.
> > 
> > [1] https://lore.kernel.org/all/20260808161148.66673-1-amachhiw@linux.ibm.com/
> > 
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > No changes in this version.
> > 
> >  linux-headers/asm-powerpc/kvm.h | 19 +++++++++++++++++++
> >  linux-headers/linux/kvm.h       |  3 +++
> >  2 files changed, 22 insertions(+)
> > 
> > diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
> > index 077c5437f521..2c229fe0562c 100644
> > --- a/linux-headers/asm-powerpc/kvm.h
> > +++ b/linux-headers/asm-powerpc/kvm.h
> > @@ -437,6 +437,25 @@ struct kvm_ppc_cpu_char {
> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
> >  };
> >  
> > +/* For KVM_PPC_GET_COMPAT_CAPS */
> > +struct kvm_ppc_compat_caps {
> > +	__u64	size;			/* Size of this structure */
> > +	__u64	flags;			/* Reserved for future use */
> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> > +};
> > +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> > +
> > +/*
> > + * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
> > + * These bits indicate which processor compatibility modes are supported.
> > + */
> > +#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
> > +#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
> > +#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
> > +#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
> > +					 KVM_PPC_COMPAT_CAP_POWER10 | \
> > +					 KVM_PPC_COMPAT_CAP_POWER11)
> > +
> >  /*
> >   * Values for character and character_mask.
> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index dd52e2a65bfd..aea4ab5c6953 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -986,6 +986,7 @@ struct kvm_enable_cap {
> >  #define KVM_CAP_S390_KEYOP 247
> >  #define KVM_CAP_S390_VSIE_ESAMODE 248
> >  #define KVM_CAP_S390_HPAGE_2G 249
> > +#define KVM_CAP_PPC_COMPAT_CAPS 250
> >  
> >  struct kvm_irq_routing_irqchip {
> >  	__u32 irqchip;
> > @@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
> >  /* Available with KVM_CAP_COUNTER_OFFSET */
> >  #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
> >  #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
> > +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> > +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
> >  
> >  /* ioctl for vm fd */
> >  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
> > 

