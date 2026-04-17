Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97723F436B9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDlsu-0008UP-Oi; Fri, 17 Apr 2026 12:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wDlss-0008TR-0h; Fri, 17 Apr 2026 12:17:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wDlsq-0006fo-14; Fri, 17 Apr 2026 12:17:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H7Un1w127659; Fri, 17 Apr 2026 16:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+NwT30
 ODTXEYQL4EkpDPTbcGWWIK3L/fWtYBESgAkS4=; b=KObSOxIpiDeXFPDbZOZKbT
 JADv26dI9d3xCL1vLpn6ZGVmtDfiUe0ha1H7n3BMhRnKGfAxvI/+qLuegRJsWZwN
 hVh+oK6CTfMpg7IxNmwp9b2N5mCRkcABWAdTkFSCG1pAJpfE1rlxLpXKvb2317fd
 ADYl1aZ4SOle5vHPai/i/OExI15mRA6rfCZNnvqESJQV90G5cINeNfbPl+k/+ZVh
 pn+1ch0QXG30KAIPZRZx7pMec0vpUP5UwRGXSdb0GnG34GM7LThe6yI/9/BuKMJu
 L4N19pWAPnw8u/B8Qe/I+8/0R/lhMxPLyyXOmu/dyAX4xA2ixPNR2V06f/YdBlbQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pt6u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 16:17:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HFNdJB031240;
 Fri, 17 Apr 2026 16:17:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10yr245-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Apr 2026 16:17:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63HGHO7a38928888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Apr 2026 16:17:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 337352004D;
 Fri, 17 Apr 2026 16:17:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB2642004B;
 Fri, 17 Apr 2026 16:17:23 +0000 (GMT)
Received: from [9.111.60.146] (unknown [9.111.60.146])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Apr 2026 16:17:23 +0000 (GMT)
Message-ID: <55fe102a-a7eb-4325-94e1-a4afe7279dfa@linux.ibm.com>
Date: Fri, 17 Apr 2026 18:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Update s390 trees
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260417152236.1305333-1-farman@linux.ibm.com>
 <20260417152236.1305333-2-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260417152236.1305333-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2itoNqVo1fYCUNERwJMMUxQ7MW0hn76k
X-Proofpoint-ORIG-GUID: 2itoNqVo1fYCUNERwJMMUxQ7MW0hn76k
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e25d19 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=WcAcPcHNUQQzoJ0tM-4A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE2NCBTYWx0ZWRfX/7hnVE8RaZ6i
 Jqs7eNy+BE8WJXl/mB90XbbtFZBbFS1f1xl8lpixyBMwGm/3C4P4abr/VaUmNOYNU81ax2ccnr3
 OrJnFmLXT9IDzbhjLP33ItoIQ5Mq52gVw7bvz951Ts7wUsSI23ZsOZFJKEsLzBVeooDCt26Oti3
 ZaUDm7i4iI//Yd72YPNCeeDWX7dLf5pLbw/h3wNHx0KFyDRst0qitirP6lt1QZvnlu8dIB6RSU3
 t8DEzzHzmljeTUiMLgMZYPqplJ6DiTMdP4fg2WXmTy/Qd44f1h0GHg1/mjDgD62JSbFVC/xq5rf
 u2IUEGsxI7PUqmtT0wiPjvBQowXSnZHSQmJMHR/gn7vjVH85Tjp8QS4B9CQvQiaisINUT4f6/3Y
 hquXgsA2eVhRg0K6wa6VTpHIaW0YZf+4Z7rg/9WMgQ77GEBMJ6Ojq0mIAL1vTx4jZHJJEIrxMYn
 uo6oqKZg+86uVE49JKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170164
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 17.04.26 um 17:22 schrieb Eric Farman:
> Move Cornelia's git tree from virtio-ccw to the overall
> s390 architecture group, since all the subgroups funnel
> up through that.
> 
> Remove Christian's tree from the subgroups, since they are
> not specified consistently across areas but also haven't
> been used in ~6 years.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   MAINTAINERS | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced8..cdec4872d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -126,6 +126,7 @@ F: docs/system/target-s390x.rst
>   F: docs/system/s390x/
>   F: tests/qtest/migration/s390x/
>   K: ^Subject:.*(?i)s390x?
> +T: git https://gitlab.com/cohuck/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   MIPS general architecture support
> @@ -500,7 +501,6 @@ F: target/s390x/kvm/
>   F: target/s390x/machine.c
>   F: target/s390x/sigp.c
>   F: gdbstub/gdb-xml/s390*.xml
> -T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   X86 KVM CPUs
> @@ -1854,7 +1854,6 @@ F: hw/s390x/
>   F: include/hw/s390x/
>   F: configs/devices/s390x-softmmu/default.mak
>   F: tests/functional/s390x
> -T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   S390-ccw boot
> @@ -1868,7 +1867,6 @@ F: pc-bios/s390-ccw/
>   F: pc-bios/s390-ccw.img
>   F: docs/devel/s390-dasd-ipl.rst
>   F: tests/functional/s390x/test_pxelinux.py
> -T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   S390 PCI
> @@ -2468,8 +2466,6 @@ M: Eric Farman <farman@linux.ibm.com>
>   S: Supported
>   F: hw/s390x/virtio-ccw*.[hc]
>   F: hw/s390x/vhost-*-ccw.c
> -T: git https://gitlab.com/cohuck/qemu.git s390-next
> -T: git https://github.com/borntraeger/qemu.git s390-next
>   L: qemu-s390x@nongnu.org
>   
>   virtio-dmabuf


