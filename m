Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E24CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 11:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkwK-00084v-5W; Tue, 12 May 2026 07:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wMkvt-00080W-2Y; Tue, 12 May 2026 07:05:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wMkvq-0006Zt-0M; Tue, 12 May 2026 07:05:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7JET3179891; Tue, 12 May 2026 11:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ITfouI
 TeYSZkPpZg/HVipL1YmINOFfb9dk4nOja119E=; b=PUSyEjQc66O+2CHRDKux4q
 PfiugIBcwqFLMaj+wKm9Z+RVu2AuleLyFhOtooB9APx4K87FipN9+vcOBQyo1Isa
 ERwH7oPUsuAWBNYXQkatoZ2lDoTb+kZKdUpL9HU2mMLJABL6a2bb6iK9BwPTiK4v
 8Ze8/FG5EC4vMlxEIK3EPH9emgZx0S/IBEZP6Jn2w9q1whSur7lDvjQZXy0clMpZ
 eB6yc979Gnw3Er8kNgqMMNGgEXu/71269DvN78q+QCiWfkxd0eLumiMqmD0vrWSr
 V+cbOKd15B4iXtGQQvfequKAxwB6+1wn1u5frckelZiEf89+n44LkWIs/fsL9eBg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6jjb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 11:05:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CAdTk2007015;
 Tue, 12 May 2026 11:05:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjua4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 11:05:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64CB5ZYU62456192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 11:05:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 505CF2004B;
 Tue, 12 May 2026 11:05:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0123420043;
 Tue, 12 May 2026 11:05:35 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 May 2026 11:05:34 +0000 (GMT)
Message-ID: <9308b8e8-f2f8-4cd7-b25d-6f1f9573c6da@linux.ibm.com>
Date: Tue, 12 May 2026 13:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Make container ids in SysIB_15x 1-based
To: Alexandra Winter <wintera@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Richter
 <tmricht@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org
References: <20260511134909.43802-1-wintera@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260511134909.43802-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a030983 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=TaAaJw8h5JJKTkFOHx0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zoVrcjjxwH9OnhKcK4IWSr0l2KhwvfAG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwOSBTYWx0ZWRfX9Rf7xjw/nOcp
 p/l7shzICuikqr8ighhmD5K012iDTBjIaE3sdnvG3bjSWVUAxYPBI4jTKaQsU5luh0tsdeJuI7B
 uI5LUQ1z8JPtOc73jiJ2lXxuiqAJNglEJd1wErghYA6SWLloUpLR+MnVh/dEEBrcCjBtDe66Cgg
 avInNM2UUAwW8VxRVu/ds//i/8OFgFnQgFfM/CsIS1/OG6Ige6KlTClJpC06DxgBlnXRWnUib7K
 fXxQjXuLuoF2qvwVndBBLNV5Ob94ZfbNve8jgLcCKNZbcpS1o1U/QVvA9dtaL6tZKKwQBxJFpjv
 jHjuxYdl/rEL6NUE9BjFQ/1oEIsmFutT7xm7p6U8//tWn5KaE8OUI/dubDJaKSdV+XJrZH2vRQJ
 AQCkm7KLncu8/dQ4XJEpgRqgTvwuneFnShzcOQ9iXh54t9PB8XkuOLS7qIsPRMYdMQIz7DPftv6
 PXDv+DSfZNKHegyTGvw==
X-Proofpoint-ORIG-GUID: zoVrcjjxwH9OnhKcK4IWSr0l2KhwvfAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120109
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 11.05.26 um 15:49 schrieb Alexandra Winter:
> The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
> unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
> by starting the container ids at 1 for the lowest numbered container.
> 
> The qemu misbehaviour without this patch becomes obvious due to a recently
> proposed kernel fix. Older linux kernels pass the container ids from stsi
> fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
> in off-by-one values when compared to the values from HMC. A Linux kernel
> fix is being proposed to correct the sysfs topology ids by -1, so they
> start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
> fixed kernel runs on a host with a qemu without this fix, this can result
> in container ids erroneously being shown as 255.
> Example (Fixed guest on unfixed qemu):
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>    0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
>    1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
> After this fix:
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>    0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
>    1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1
> 
> Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

I guess this should go via Connys s390 tree.


> ---
>   target/s390x/kvm/stsi-topology.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
> index 301d41b68d..afd00da0e6 100644
> --- a/target/s390x/kvm/stsi-topology.c
> +++ b/target/s390x/kvm/stsi-topology.c
> @@ -90,9 +90,9 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
>       int last_drawer = -1;
>       int last_book = -1;
>       int last_socket = -1;
> -    int drawer_id = 0;
> -    int book_id = 0;
> -    int socket_id = 0;
> +    int drawer_id = 1;
> +    int book_id = 1;
> +    int socket_id = 1;
>       int n = sizeof(SysIB_151x);
>   
>       QTAILQ_FOREACH(entry, topology_list, next) {
> @@ -103,12 +103,12 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
>           if (level > 3 && drawer_change) {
>               SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
>               p = fill_container(p, 3, drawer_id++);
> -            book_id = 0;
> +            book_id = 1;
>           }
>           if (level > 2 && book_change) {
>               SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
>               p = fill_container(p, 2, book_id++);
> -            socket_id = 0;
> +            socket_id = 1;
>           }
>           if (socket_change) {
>               SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));


