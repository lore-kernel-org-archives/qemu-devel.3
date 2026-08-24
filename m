Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E517C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySem-0000ed-B2; Mon, 24 Aug 2026 07:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wySek-0000e8-Ex
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:15:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wySei-0004hg-LB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:15:58 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O9WBvr1536243; Mon, 24 Aug 2026 11:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=7fE0EvgkG89C1fNDvBI0IaQBaDJSj+
 jQhlRX+ZYlK4M=; b=l+yVc8RUphVULjNgyGNLbmUpNv3ceNL4GRBuCygKFG684D
 vXpn9ahEvDOfDNlmqQdZwO0pjTIWn9/4qrkRMTdTWRcR0x/Ie+oERlgBOtp+NIXz
 +tGz0VTDhUtmBvFrqUSdvEYbiZVoIukavt6aryNilFWZtUL9eRBWuFZmcwmI3QCH
 pYuApX8i7GW/h7LyFz2YFpbMLGkXlObVPA+ZDggfJpX1YyCHNX79lD1c1kyb5+jt
 qDK3B7+I0ER8UynU6wJiIeqSNfIhb5CT4TqWO1KsTIA056rbXdAmb0FhJm0LHhcC
 QwVAC3WJ9G+qXcmAgCZoc6165Ez82wUAi4XVOFKA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx0p7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 11:15:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OBBIqZ031600;
 Mon, 24 Aug 2026 11:15:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgwe37-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 11:15:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OBFnat51249426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 11:15:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2202320049;
 Mon, 24 Aug 2026 11:15:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C2EC20040;
 Mon, 24 Aug 2026 11:15:46 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 24 Aug 2026 11:15:46 +0000 (GMT)
Date: Mon, 24 Aug 2026 16:45:43 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
Message-ID: <20260824164442.c2943bd9-7e-amachhiw@linux.ibm.com>
Mail-Followup-To: qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260819045924.11732-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819045924.11732-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MiBTYWx0ZWRfX6W1Y27d4MsjJ
 wyJuFjh/locVd9PcLPOt9TiAPl82GmztCgE4JHax/c6XtxGid5AVDOgegRHXZNWNAH/PEBF44Y/
 x969mML+clgnUGRv8vySapgTUMvqB+Y=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8c27e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=7XnC1fpkjExzw9auK74A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qcnxhUkGFSfH1SH601jki6madvvgIFXL
X-Proofpoint-GUID: qcnxhUkGFSfH1SH601jki6madvvgIFXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MiBTYWx0ZWRfX/G4bDefC99tC
 4XUsoRAe44BLdV5LNDe813Gsz3KmCq0x+s3HZ5o2QeTMzsurQbmEiGcly6GtZ7NaLSOvKsf4+jV
 VDQuYqksMvbg2hX6qnGt3JLcJaIdhV4Aih5KE9h8gOhO7xVGdo5ScIaj4pIkVHmSvnn3jqs7ie9
 iCRu0kYr+4DlIHdSjrySXJTAighNrWGdB1Qqa6uCMW/3jbYZ2XoK6fOiv6ppI4gRCa1ILfh4ymA
 Nb23GXvvtPw5uYTF4yThZAeO8tS8okmcoy88i6Pvt2gaD2RikwbNqbRFQQRCVhXRRgHQzt1Nks4
 nR/eL5WMs9h74WOH6HRO//iYkAZvgiXupCAvrzuDenwZy3KGddaEYwhVCmS+7fSSE3GNdWKcNKT
 aptH46WIVOb2kwrT2+arK32XikEZMfGk6gBJjVIz80lxzbi/zhkOTsWteGh++UC334U5WnwqV8p
 SUgTFcFO4NXgVyiFXvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240092
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

On 2026/08/19 10:29 AM, Amit Machhiwal wrote:
> Sync linux headers from Linux kernel commit 1200d84f4c0a
> ("Merge tag 'powerpc-7.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux").
> 
> This picks up the new KVM_CAP_PPC_COMPAT_CAPS capability for powerpc,
> which introduces:
> - struct kvm_ppc_compat_caps: reports processor compatibility modes
>   supported by the host (POWER9, POWER10, POWER11)
> - KVM_PPC_GET_COMPAT_CAPS ioctl (KVMIO 0xb8)
> - KVM_CAP_PPC_COMPAT_CAPS (cap #250) in linux/kvm.h
> 
> The sync is needed to get the corresponding Qemu series[1] merged.
> 
> [1]: https://lore.kernel.org/all/20260812170854.58709-1-amachhiw@linux.ibm.com/
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  include/standard-headers/linux/const.h  |  4 ++--
>  linux-headers/asm-arm64/unistd_64.h     |  1 +
>  linux-headers/asm-generic/unistd.h      |  6 +++++-
>  linux-headers/asm-loongarch/unistd_64.h |  1 +
>  linux-headers/asm-mips/unistd_n32.h     |  1 +
>  linux-headers/asm-mips/unistd_n64.h     |  1 +
>  linux-headers/asm-mips/unistd_o32.h     |  1 +
>  linux-headers/asm-powerpc/kvm.h         | 18 ++++++++++++++++++
>  linux-headers/asm-powerpc/unistd_32.h   |  1 +
>  linux-headers/asm-powerpc/unistd_64.h   |  1 +
>  linux-headers/asm-riscv/unistd_32.h     |  1 +
>  linux-headers/asm-riscv/unistd_64.h     |  1 +
>  linux-headers/asm-s390/unistd_64.h      |  1 +
>  linux-headers/asm-x86/unistd_32.h       |  1 +
>  linux-headers/asm-x86/unistd_64.h       |  1 +
>  linux-headers/asm-x86/unistd_x32.h      |  1 +
>  linux-headers/linux/const.h             |  4 ++--
>  linux-headers/linux/kvm.h               |  3 +++
>  18 files changed, 43 insertions(+), 5 deletions(-)
> 

CI link: https://gitlab.com/amachhiw/qemu/-/pipelines/2784536213 (Passed)

Thanks,
Amit

