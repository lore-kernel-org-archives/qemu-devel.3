Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06673CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbpCG-0004gq-2b; Mon, 22 Jun 2026 20:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wbpCE-0004gO-7z; Mon, 22 Jun 2026 20:40:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wbpCC-0003iM-JF; Mon, 22 Jun 2026 20:40:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmFSO3990915; Tue, 23 Jun 2026 00:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=13gals
 kfvIqb9KKy68EqsQwb8oFKOdDcVeuxT61uyXw=; b=O8rCEJcXeYA8bYgQ7CKAKJ
 n/IwfcngiI++CcDeH6tb0u+ykOcB/DPo1y/72DBHt4/FKcSEJy3MYHS/GxsbNhQc
 wwvC5STheaUZLWxo5YmvxzHxuWgBW3dmvVD7L/xoRC3G5x0qKpYw5iAa/IpObW5a
 XT6I+g0Txwu0jliCwtmVxeNhBIo/z/7LYc/DWlJzjRLxGuAoE/1u81YN/+0xKSbV
 TpGGNcpL6Ce13H03w91j6ssOWbyQKQ5pxahbi3ULCRGBTzKC+/wrTUqIbKByAI3P
 DxztyBIwwR22hoYFzxW9BLeUSt4nlfbPQEc16+Nw+JpVGqYPV0XFXc4ID0pga/2Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3c0he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:40:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0Yew0020225;
 Tue, 23 Jun 2026 00:40:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q90kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:40:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0eqoc2491106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:40:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 172795805C;
 Tue, 23 Jun 2026 00:40:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 389D75805A;
 Tue, 23 Jun 2026 00:40:51 +0000 (GMT)
Received: from [9.61.116.241] (unknown [9.61.116.241])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 23 Jun 2026 00:40:51 +0000 (GMT)
Message-ID: <88fe72e4-fff9-420c-a7e4-25514af08059@linux.ibm.com>
Date: Mon, 22 Jun 2026 20:40:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] s390x: Enable boot menu for virtio pci device
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, nrb@linux.ibm.com
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-6-jrossi@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260623002539.126124-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a39d616 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=tEIbNsbp61D0166_-loA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX7f5Wd0irFeVz
 BVULgM7FaDYb8eAGykfhBwccnrbtwlBa+Eit8PHvqCTtFwVgL4UksdejgV/aE9D54y8Zy5rZoHJ
 tAGoR4dsE9nzqbOJNpAtprSLCO3ZCLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfX9KU++b89n2CL
 cJH5xqKgca52ysCrJgXL1aO0lvhcFK4thW+1BAmbR7pcbRVe3dL5IrcuQ8vPyKiUOEy9hjljmsw
 aoYUFyR5XxjRUM1rQKsnW915wHtHg6c5vu2K8mR8EVaEJIcVqoQ+eIC8XosNgO1h3Vuhx83OEzi
 UXUh40qyW0htnDmRztFJ1h39qlf2ifo7ZzPwPB1+1J1JJpou+xP8RB8HeE5u2SbD5FFrcCtP3Jx
 9AqJzbYXcefoXV0DzmpVbaorvNPrE37c4AsJenvNiaU+6yAzPofKT4edvzB46VdjmJNDQS35HOy
 okMwVeFMJjezNEPIUn6QF9cookZmC8C46Xrwa6I8VLirEDOFhAUjNL7xcmSiWRxOgMf3HmVmjl4
 lwyBh5pptiiQoza8VEeswQulsVxdOEcRpKVbJGsVmKbaJ9tl7Vb5D8dqUgJk8WRkVvyVWlroos2
 vsHvbrupZ5pXwE+Sbvg==
X-Proofpoint-ORIG-GUID: UAa_werPjNQx1e1DYeApKi5EAhYLOOV_
X-Proofpoint-GUID: UAa_werPjNQx1e1DYeApKi5EAhYLOOV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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

Please disregard <jrossi@us.ibm.com>
It should be:

signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

On 6/22/26 8:25 PM, jrossi@linux.ibm.com wrote:
> From: Zhuoying Cai <zycai@linux.ibm.com>
>
> Add S390_IPL_TYPE_PCI to the boot menu handling logic to enable
> interactive boot menu support for virtio PCI devices on s390x.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> signed-off-by: Jared Rossi <jrossi@us.ibm.com>
> ---
>   hw/s390x/ipl.c          | 1 +
>   pc-bios/s390-ccw/main.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 4cca21c621..d5fdc3ea0f 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -315,6 +315,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>               return;
>           }
>           break;
> +    case S390_IPL_TYPE_PCI:
>       case S390_IPL_TYPE_QEMU_SCSI:
>           break;
>       default:
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 567e97bf32..be83d598e2 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -185,6 +185,7 @@ static void menu_setup(VDev *vdev)
>   
>       switch (vdev->ipl_type) {
>       case S390_IPL_TYPE_CCW:
> +    case S390_IPL_TYPE_PCI:
>       case S390_IPL_TYPE_QEMU_SCSI:
>           menu_set_parms(qipl.qipl_flags & BOOT_MENU_FLAG_MASK,
>                          qipl.boot_menu_timeout);


