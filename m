Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522BCCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 19:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9U59-0003N7-O7; Thu, 16 Oct 2025 15:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1v9U57-0003Ma-H7; Thu, 16 Oct 2025 15:56:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1v9U52-0005Co-GZ; Thu, 16 Oct 2025 15:56:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GJUsm8021066;
 Thu, 16 Oct 2025 19:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OFRUe+
 KQLx1qH7G6gwBkYLooMFYglCx8Q6DJSdtJOo4=; b=cXAPqsTRVvP0QiYndWtCti
 9+yYBiIl4LFfwzOIHqhVJnXh4snYYkUZW4dN77GTxkxwL907kdesFpFdffCkG5tR
 5u+vMB2bcFOCtXuX0WgES34T/EFAIUvJARJ51IcLo6rDXl8GKiof096zPKkGmgzP
 uQ3CogAR7tlAjdvURbf5STKwA5L2Mz/Ph3n7jlTSMZZdyDzfDbOJySJZtSk5UflT
 YCv5kUEyVdiD4X5o9zuFu1r+04TbzW2sOHyHF2kwBzM7atkYtysxQ9TtWU1Pi7r4
 mTqmr8JFYhHLUwwDFxP6s7rz7UhalyIWEA35YSgWM21gVcNTmuu1gyuBpRflxx5A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0bnjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 19:55:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59GJt3r7026270;
 Thu, 16 Oct 2025 19:55:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0bnjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 19:55:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GHHp9X016996;
 Thu, 16 Oct 2025 19:55:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k7j01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 19:55:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GJtn5918088256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 19:55:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B807E20396;
 Thu, 16 Oct 2025 19:55:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0B0B20395;
 Thu, 16 Oct 2025 19:55:48 +0000 (GMT)
Received: from [9.87.132.104] (unknown [9.87.132.104])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 19:55:48 +0000 (GMT)
Message-ID: <40098bb1-c18c-426f-8f54-c96eb2f2a6ec@linux.ibm.com>
Date: Thu, 16 Oct 2025 21:55:48 +0200
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
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20251016131159.750480-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251016131159.750480-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XgqHhEQunIwWbHzOi09u1_iefJvJ9vnZ
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f14dc9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=hpkoLDSOn8IH4pMs9ZkA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXxDxr04yJED2n
 RggN8pDsgl6ncqcktP9QV3r801bqqRRecVxASYE0tMfJy/FkIyGkhNoy9+/Rw9DYOLN9ZFA3/7Z
 t/12AUk0O3p3QQROC1ncJrAr/BFCwVmmMRAZxNojnbsI41hDLCqXG+x4/s3/sDyf23mqwhrdzr3
 1ek4BhVrKl74SNbC+zFiOI3LKK+zn9+fdN12mtk+sW1qbkH7r63bFoQ3DQi054ZBNkm9D9FI4Hs
 bMKLRLUd+n2xJizZV5ak7Af7keHlJhZyAF7R6jq7FeKFNyObl4r5zq+Pdib5dJibRh3aGplSJFk
 K24adEq/1yjPQUCgO/FGK3i2V3+np4d/HsgScrPl/hvWY+vKaNxIDQ11AYyVwvds7t1k5pO21HX
 opLnVNRv4Gn/9pjem3Zk/3E4ZcFzZQ==
X-Proofpoint-GUID: cKb9Iw_uv-SgysYy0v7VcGYaU1CHOUKt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 16.10.25 um 15:11 schrieb Peter Maydell:
[...]
> +Supported machine types for the virtualization use case, by target architecture:
> +
> +aarch64
> +  ``virt``
> +i386, x86_64
> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``
> +s390x
> +  ``s390-ccw-virtio``

Makes sense for the s390x case.
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>


