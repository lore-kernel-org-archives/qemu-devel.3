Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB9DCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkBc-0002aK-Ih; Tue, 12 May 2026 06:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1wMkBT-0002ZD-7X; Tue, 12 May 2026 06:17:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1wMkBO-0007W0-Kg; Tue, 12 May 2026 06:17:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7NKI2611655; Tue, 12 May 2026 10:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=NYMatuf/FX44BPxbOfk4REtTIxTBRv
 4C448a868zWbQ=; b=lHGsSpAqQ7LCHNvDt5YdayxUJ9pOIEoYD6+Rs8ehbRBjkw
 VmEeKz3BoRwx8B4tvZ5rA8bSeijh2bDMETzplko6uS5JEwRupHmgqnE6YQjZfp1W
 okacmSYTPgaV6ZSa61xXt390elo4Q8rscBalN+MZCFlC5CG0bNOKZYraJgKygNSn
 +SpGkmpGr20UAUsylKoO7GPfabtmFjJNqU11X9NzV36oX5TW3P9gEAhY6BmN3l37
 YZeb0jv7n3uWiv3ZsBFxtGlPVB+v0MBxoNtqiwlqWrwCSiS0msDhoho8rGvhInBV
 XQj6SJrszWmOejz00dPB8iVDuR7vwCTslSDrMCag==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdth07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 10:17:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CA9Pvp007954;
 Tue, 12 May 2026 10:17:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgjnjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 10:17:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64CAHWS245613476
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2026 10:17:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A059D2004E;
 Tue, 12 May 2026 10:17:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44D6F20040;
 Tue, 12 May 2026 10:17:31 +0000 (GMT)
Received: from thinkpad-gg (unknown [9.87.131.112])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2026 10:17:31 +0000 (GMT)
Date: Tue, 12 May 2026 12:17:21 +0200
From: Gautam Gala <ggala@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH] target/s390x: Make container ids in SysIB_15x 1-based
Message-ID: <agL-MbrPe4_UTh35@thinkpad-gg>
References: <20260511134909.43802-1-wintera@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511134909.43802-1-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a02fe42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=oMH5tb1akUb0FxLjN7MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: x-aZJxYIY2_GeKvSbBHTyyp8plyIsFIH
X-Proofpoint-ORIG-GUID: x-aZJxYIY2_GeKvSbBHTyyp8plyIsFIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwMyBTYWx0ZWRfX4kPWq21hZjt3
 aLN4+KURCPe6lsUfGnBddaUaaDblJw5pU71026XtU7ce2dD5dxme4ZzSfhxLLW9DbLA7lAYtzCs
 eu1y61ezKV82A8naE+Aq8Aas/cYiWMBDwMNWQU05YzRkQ056S5F2wu8H5xDNLCu3ykfib5ECaLp
 epVcJ9JfV3cj/1sxDNgHQxtjnG/bxzPARtacEct0aBehZA4jpjwvz54ehcMyF6XfQo36ntwL1Z1
 hRUl4khHLdMqWtcXsc3Zaq/Lqti8y+XqMuqQOZ0J3z3w4mO6W1EO/HIdf5t7mvlY8BxSUKVF1KC
 Gabd9PVBMOiC5U0N1vK0ocQyCJqUZjw80YcpnLiMEy4VWh4H4jcIIbrt2FIVivH82GE07oM6ygv
 GsCi/ko8i9jHvSWXqKxe3/riA600SH2VTjCeHwGiprQXLg8QtgK9pncy2fbRd9b+TpiPOTqoDjn
 iPRHtNKfseF59oWRYKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, May 11, 2026 at 03:49:09PM +0200, Alexandra Winter wrote:
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
>   0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
>   1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
> After this fix:
> $ lscpu -ye
> CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
>   0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
>   1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1
> 
> Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  target/s390x/kvm/stsi-topology.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
> index 301d41b68d..afd00da0e6 100644
> --- a/target/s390x/kvm/stsi-topology.c
> +++ b/target/s390x/kvm/stsi-topology.c
> @@ -90,9 +90,9 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
>      int last_drawer = -1;
>      int last_book = -1;
>      int last_socket = -1;
> -    int drawer_id = 0;
> -    int book_id = 0;
> -    int socket_id = 0;
> +    int drawer_id = 1;
> +    int book_id = 1;
> +    int socket_id = 1;
>      int n = sizeof(SysIB_151x);
>  
>      QTAILQ_FOREACH(entry, topology_list, next) {
> @@ -103,12 +103,12 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
>          if (level > 3 && drawer_change) {
>              SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
>              p = fill_container(p, 3, drawer_id++);
> -            book_id = 0;
> +            book_id = 1;
>          }
>          if (level > 2 && book_change) {
>              SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
>              p = fill_container(p, 2, book_id++);
> -            socket_id = 0;
> +            socket_id = 1;
>          }
>          if (socket_change) {
>              SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
> -- 
> 2.39.5 (Apple Git-154)
>
Thanks, this looks correct.

Reviewed-by: Gautam Gala <ggala@linux.ibm.com>

