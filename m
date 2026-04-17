Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB77F436BD
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmCO-0002Wt-Ay; Fri, 17 Apr 2026 12:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wDmCI-0002W1-1X; Fri, 17 Apr 2026 12:37:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wDmCA-0003Sf-5q; Fri, 17 Apr 2026 12:37:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4dJi2554320; Fri, 17 Apr 2026 16:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mw/ehf
 leFYUkccHaA5HTTdq5Ks1IMbaQpYudDXXTfvU=; b=QeNXUZLykLrdInf3NX5yeA
 zyzQD5ontmxpwpWxP4K5IDJBlP32b8cpZXyd8XsENhlNN4j60dL46cgz/YNKXEwq
 vIhRvIfwdRt8tgK6ca8dkh6rmVXpIE3n4B+UbZpXWp18ODrmV9bhjtEOWR1ByyCO
 YxNPQ8aSFeKH7cg/lQIKzS3TKBfANXCyMbz29ET8buWXw8jiIaHPHpqaPUWVQaRo
 nNKB7K8yT00nIdUT8ykqtzXm3nzJPutvztQn0N9C1JnouqOx/MSXK82eVMDJJpu/
 TGOny6xHnyNyaMo+6KVKw0qGIBHGzwdjc9q0ECwxfDOryQBs3+KTC6AaRFJL6EAw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nun42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 16:37:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HCXYZ2004569;
 Fri, 17 Apr 2026 16:37:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kqwqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 16:37:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HGbMXF20775444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 16:37:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B20495804E;
 Fri, 17 Apr 2026 16:37:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB6CD58056;
 Fri, 17 Apr 2026 16:37:21 +0000 (GMT)
Received: from [9.61.14.120] (unknown [9.61.14.120])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 16:37:21 +0000 (GMT)
Message-ID: <5d8b2da4-e726-42f0-be6f-f9de4587fe22@linux.ibm.com>
Date: Fri, 17 Apr 2026 12:37:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Update s390 trees
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260417152236.1305333-1-farman@linux.ibm.com>
 <20260417152236.1305333-2-farman@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260417152236.1305333-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vNWIRKDEZ2f5nY4kxDeFJAO5m1gSka9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE2NCBTYWx0ZWRfX2sB62Rm/Auvo
 oekGDzEAgCddzJdUK4WxfZoWATKnwVCrweGofX0/DSImtntHlV+sJayOFnXLwAckrbTKKXYxDcv
 7vCYSTBTT4g1+HMrzVmRL5wS6Z0fPfmURlMxSfy/WVD9Yni1Pl+xt09vYKZ4x3qPuNlNX0dakeL
 4aXNYnfTtOjKy+PTHBmfGmWyv5WVM0Wo5ih/ydrjnOqV4Yl4caCtapxpy0Z1Ohc0iR6p6QSr02M
 fOXOvdzBlNE4tXQmSQN3Kfum6VlMqqLxGxgSUGzEHOITnS09BLW32okLmpoAz73lEzRJGjLFcW9
 rjiipAG87cf628Eil2BbVjqtB84dP7wiD11ng56ZaQ5hpVSD5+CSjYQws4fhvMIhAGyIrYy4M4i
 c2B4wfmpskb6QtuD8u65UxoZkDEPwt6LANxsDw9NMylQ1E4clplTSPxAytDLfe+dz+KqE6BgQMB
 nrQ3f87ar26W8XUICgQ==
X-Proofpoint-ORIG-GUID: vNWIRKDEZ2f5nY4kxDeFJAO5m1gSka9t
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e261c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=WcAcPcHNUQQzoJ0tM-4A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170164
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/17/26 11:22 AM, Eric Farman wrote:
> Move Cornelia's git tree from virtio-ccw to the overall
> s390 architecture group, since all the subgroups funnel
> up through that.
> 
> Remove Christian's tree from the subgroups, since they are
> not specified consistently across areas but also haven't
> been used in ~6 years.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Thanks Eric.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced8..cdec4872d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -126,6 +126,7 @@ F: docs/system/target-s390x.rst
>  F: docs/system/s390x/
>  F: tests/qtest/migration/s390x/
>  K: ^Subject:.*(?i)s390x?
> +T: git https://gitlab.com/cohuck/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  MIPS general architecture support
> @@ -500,7 +501,6 @@ F: target/s390x/kvm/
>  F: target/s390x/machine.c
>  F: target/s390x/sigp.c
>  F: gdbstub/gdb-xml/s390*.xml
> -T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  X86 KVM CPUs
> @@ -1854,7 +1854,6 @@ F: hw/s390x/
>  F: include/hw/s390x/
>  F: configs/devices/s390x-softmmu/default.mak
>  F: tests/functional/s390x
> -T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  S390-ccw boot
> @@ -1868,7 +1867,6 @@ F: pc-bios/s390-ccw/
>  F: pc-bios/s390-ccw.img
>  F: docs/devel/s390-dasd-ipl.rst
>  F: tests/functional/s390x/test_pxelinux.py
> -T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  S390 PCI
> @@ -2468,8 +2466,6 @@ M: Eric Farman <farman@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/virtio-ccw*.[hc]
>  F: hw/s390x/vhost-*-ccw.c
> -T: git https://gitlab.com/cohuck/qemu.git s390-next
> -T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  virtio-dmabuf


