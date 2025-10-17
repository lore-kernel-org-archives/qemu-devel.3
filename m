Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB88CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gZH-0004ZM-Ev; Fri, 17 Oct 2025 05:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9gZE-0004XW-K5; Fri, 17 Oct 2025 05:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v9gZ9-0001x1-OB; Fri, 17 Oct 2025 05:16:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8rvET001283;
 Fri, 17 Oct 2025 09:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=85T4/z
 IhtbpqUbW0+/zwsZHL0FaAv+MH/SZ5cJdr/qI=; b=lIxmOnRp35FtAa87Wy0oEr
 6OqTZkrdAQKlQhQtwqNtZdZAvjgNnnMU6/z0uH6D3xSx4Vx34y9xZXGBigPJ6WE+
 uqND0zAwrnfrOPrExq/0oo7e0JSEe0fLeAx3sPtRwHckybUrCGJYnO7CEH9jn4kw
 8Zg4FjS3qiM8x64HiVLx206N9oOlrNTBo3zWJZQ7CDn3X7zvGEIlGl20x0G1N1RF
 pRuRwuUgZOib1MmpdkaTTf7lA4c91UyTIXQ+SE+7NNLdyx65p/2c5qPokzRfNho1
 X8II6APFKrcwksPxbCLsMF6yGP4BUMJ/nARyP/ndHnoe0/fPkwbBYmA44TwyzOxg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8c89y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 09:15:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59H9FZ3F027973;
 Fri, 17 Oct 2025 09:15:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8c899-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 09:15:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8ujoS016967;
 Fri, 17 Oct 2025 09:15:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32kbyfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 09:15:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59H9FWdS9306706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 09:15:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E52158075;
 Fri, 17 Oct 2025 09:15:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F9D95805A;
 Fri, 17 Oct 2025 09:15:26 +0000 (GMT)
Received: from [9.39.26.64] (unknown [9.39.26.64])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 09:15:26 +0000 (GMT)
Message-ID: <95e1cffb-30c6-45a8-910e-79f1d5b2602f@linux.ibm.com>
Date: Fri, 17 Oct 2025 14:45:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20251016131159.750480-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20251016131159.750480-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mOBILxKxDXHE0ovow_jl3z8Ccevx9Sis
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX3/plEuKjV0+B
 MscHQwTRXd16jUjaC+OljDSO92iRTirYQxIRlw/VhBEzXXSoqDAZrJmcwCOnavk91HoEPmbytK3
 TQ7gAUbH0v15ir2aGfB9HMpwjjcLG3rnIL1pxj1dlePWQTlSvCMSvbg4WAHipnaR1gU7C9rN5s6
 N6jwAYkqrXD/QSiXHdxckDHdJHPhk8Towyb3iGv6Lr6QYwr+4qvee/8IGJMHnGc/HPLXLyaBx00
 NORvRUreWG20V6akXq9dm1R89CurAUiXIaDtYqSNIp0nRQ911VyUG/XOfIqgl2Kh7nUbfLkIGic
 EvXaBVWC1J9GKBhMkd4wnk3tXT994WpROtfRQKpgFbN3FrVRzVK57Y+ZGuIri0k8ZkyzBGZyQsO
 qWBP8Vuxf8Yus5yXZaBBp/OZV4r3wA==
X-Proofpoint-GUID: 4wUJMb03kLA-4p-4TNJ5TcQwNy2UA8ql
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f20938 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=1eYIXUnFdi7DqYaC8d4A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/16/25 18:41, Peter Maydell wrote:
> Currently our security policy defines a "virtualization use case"
> where we consider bugs to be security issues, and a
> "non-virtualization use case" where we do not make any security
> guarantees and don't consider bugs to be security issues.
> 
> The rationale for this split is that much code in QEMU is older and
> was not written with malicious guests in mind, and we don't have the
> resources to audit, fix and defend it.  So instead we inform users
> about what the can in practice rely on as a security barrier, and
> what they can't.
> 
> We don't currently restrict the "virtualization use case" to any
> particular set of machine types.  This means that we have effectively
> barred ourselves from adding KVM support to any machine type that we
> don't want to put into the "bugs are security issues" category, even
> if it would be useful for users to be able to get better performance
> with a trusted guest by enabling KVM. This seems an unnecessary
> restriction, and in practice the set of machine types it makes
> sense to use for untrusted-guest virtualization is quite small.
> 
> Specifically, we would like to be able to enable the use of
> KVM with the imx8 development board machine types, but we don't
> want to commit ourselves to having to support those SoC models
> and device models as part of QEMU's security boundary:
> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> 
> This patch updates the security policy to explicitly list the
> machine types we consider to be useful for the "virtualization
> use case".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> changes v1->v2: updated the list:
>   * remove isapc
>   * remove ppc, mips, mips64 (no machines supported)
>   * list pseries as only supported ppc64 machine
>   * list virt as only supported riscv32, riscv64 machine
> 
> I believe the list to now be correct, and I think we generally
> had some consensus about the idea on the v1 patch discussion, so
> this one is a non-RFC patch.
> 
> ---
>   docs/system/security.rst | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index f2092c8768b..53992048e65 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -35,6 +35,32 @@ malicious:
>   Bugs affecting these entities are evaluated on whether they can cause damage in
>   real-world use cases and treated as security bugs if this is the case.
>   
> +To be covered by this security support policy you must:
> +
> +- use a virtualization accelerator like KVM or HVF
> +- use one of the machine types listed below
> +
> +It may be possible to use other machine types with a virtualization
> +accelerator to provide improved performance with a trusted guest
> +workload, but any machine type not listed here should not be
> +considered to be providing guest isolation or security guarantees,
> +and falls under the "non-virtualization use case".
> +
> +Supported machine types for the virtualization use case, by target architecture:
> +
> +aarch64
> +  ``virt``
> +i386, x86_64
> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
> +s390x
> +  ``s390-ccw-virtio``
> +loongarch64:
> +  ``virt``
> +ppc64:
> +  ``pseries``

LGTM.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> +riscv32, riscv64:
> +  ``virt``
> +
>   Non-virtualization Use Case
>   '''''''''''''''''''''''''''
>   

