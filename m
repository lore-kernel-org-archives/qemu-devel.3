Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F83C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9bT-0006MY-1S; Tue, 04 Aug 2026 03:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wr9bP-0006LS-8P; Tue, 04 Aug 2026 03:30:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wr9bN-000279-CE; Tue, 04 Aug 2026 03:30:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6741J4at3633768; Tue, 4 Aug 2026 07:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=VAzdkY0FhVatErfRtKHtfpFZ4GJe9P
 Ao5SAMhtPg3dk=; b=qDdKuz2YpnsKMpYjBNQnYWLGfNgvYOZJzdnKJCFn9UxpeI
 9oh/+SH8CSxLn4969LJx0Zh1n4q+nUi1Ju9TDxg4rkCc7VKI+RBOrtllNTQ/iJYS
 aA18EkOQSj77+CN0rn8VXghPlvWHg/GqE+9EbRmMJ1HfNI38X8/ZdOu7trDjwsn2
 VUrHYCwzXwT7Dtsha+A39PsUWbuWP9bP8gN4Jdr/ocrpJahOi5mZzKzCVFsxp7pk
 k87cGGcKmilsAFyQTs7Vmo/VsezG2AepniGV1ciyCR2yqw5KEs6twW1gkieW1ClF
 oHQvP3xSw+5li6C4frqCEHqepWh33F9DWXnWaQAQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3vp83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 07:30:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747QMbN016408;
 Tue, 4 Aug 2026 07:30:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw11n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 07:30:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6747U8Rq31785304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 07:30:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AD5F2004D;
 Tue,  4 Aug 2026 07:30:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA51420043;
 Tue,  4 Aug 2026 07:30:03 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.39.29.19])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  4 Aug 2026 07:30:03 +0000 (GMT)
Date: Tue, 4 Aug 2026 13:00:00 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/3] ppc/kvm: Handle CPU compatibility mode correctly
 for nested guests
Message-ID: <anGU-FnmEcxvXOsZ@Unknown_32:98:3c:96:ca:91>
References: <20260701052341.62289-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701052341.62289-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a719505 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=B_FdNE4XmUi8kz3hM70A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3vyM7DjiShDHmGkLCUf6-rgjguqOm3Jn
X-Proofpoint-GUID: Tc8di1H-Yy-fJ89SG5CDPY3qWhzA9YJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfXyZKodADTpNu0
 GSrOHIhV1Moi6rNX46AcbhWQrMBUg5oM1Pk2dG4GR7ZGTcyVUlxJyOSJmvyCLM6rm43Wkhzsu7p
 Nx6X6wLXHuK00x4oktxB5eRyFwZiRao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX4Ci6mcPP5Fb/
 ffjDtXbeG2g+BQS72lPCMDsg3Svt7rl8hywT4v6g1TPVuHSOCboZLV6QXw+xnDw0N5b+L1AD2Bl
 A7r0Uhi1/RFaOdj2rNqjATsffamK5MnSWhozd/BG/kOEJJKATLFADDNIUAWK5Ggf7IRpNSok1fw
 /YkpEfW1Fy61IjgxPz4dXsrr+zckspkd7MbGLvluOEM88ojT4wshW/eEVGVN4ejel1i7LX4w3o2
 HoedvijwTZlcvitaV5R3SlZnemTNWbXiJINQCMAy66xD4bC7M0olTTH0rFJeZ8FlL4l+aivV0//
 y2ZA/1yoAAYe9c6CS8BJLzxQboAH19kGtb5Rrr5kElBvljecrl85cVfLutkkKQAsJ4eAH5t/cjB
 KPFAQ3dpLKw9I4QO/iSTOEeySOI2eGrKimSs8RmzXMkvD9RQ4bH3e8qLtSuSKr0gxJ7t2K8WBCh
 0+tDp64uhOKD8/F7N+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

I tested this series with different compat mode settings for KVM on LPAR
and KVM on PowerNV.

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam

