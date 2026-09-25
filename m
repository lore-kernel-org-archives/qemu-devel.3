Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E092C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA9Jw-0006Oi-DV; Fri, 25 Sep 2026 13:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xA9Jf-0006NE-Kf; Fri, 25 Sep 2026 13:02:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xA9Jd-0004IT-Ol; Fri, 25 Sep 2026 13:02:31 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5P641513362; Fri, 25 Sep 2026 17:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qbRin2
 1tr1oZdqP0jK8ak1b3O4BSv2QQ9fqyTxymj/E=; b=C8WKjqSf8LRETCB+gXFKYJ
 iNMM5gT0ABAQFm/wzgIIkxDEMZZrkyOCXcm6M843O/mhdMoy9yCTkRgz4Az76AWX
 fStGDkdkr0rGD5XbZEKx3yZI2eKfvRfyQ9LVkpduha8hgCcqJxW3wusY1wvNb9oG
 wJsQXgk92jnhMULTQ82K6U2sWV7UgetUf79BmLa2R93JaB4HYM/BmFR6cyWc0vHW
 m4jw474SXCKJDji8pDm5FIs4AOEGVHq3EXFu77olVpiKnwoxhpeJ3ShS6t8U+e7V
 2bT7Fuy6fGic2E1EZOkWN8Mlv5bVrlbENH5iriP6dBh9F5hN4iqNA5CWXGPln5Nw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsr5as-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 17:02:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG35aj4184422; Fri, 25 Sep 2026 17:02:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qu8e0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 17:02:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PH2PPZ46334318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 17:02:25 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29B4E58066;
 Fri, 25 Sep 2026 17:02:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8CC658043;
 Fri, 25 Sep 2026 17:02:23 +0000 (GMT)
Received: from [9.61.148.101] (unknown [9.61.148.101])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Sep 2026 17:02:23 +0000 (GMT)
Message-ID: <8778e484-7789-40d9-abfe-7e84c34d4444@linux.ibm.com>
Date: Fri, 25 Sep 2026 13:02:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] tests/functional/s390x: Add tests for virtio net
 PCI in test_pxelinux.py
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924222949.147720-1-zycai@linux.ibm.com>
 <20260924222949.147720-9-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260924222949.147720-9-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab6a923 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=I5qeRYr2U79j_5RURzYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: 7aor_qBBXkX4-eZfSiKlLENfxaV-LEDr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX9ZPSntkHkcGY
 FKeWsn39WgpNBq4JENGzZD95Zg2Jt2Q8bZkSl6JR/x4VkC/2kEibUU+me86BsswtS1cPswJQqMS
 LkZmefw+AOfWOQGySkJt1qXp4RTzFo1U9JlbGNEGxUuiBy6M66Hre5PAwn63A39hj5vmFZ6Qpd1
 qabU6SDD/HYQpwDXnaAO6SrTtqeIgNQHuIJ9muAWADexCi9xOaCeWmr4ZrvKLtNamx052phrmzi
 X0R40JnOF3RDp2fodgbyEQdvmT7jrAjjITV75uP7BVylQYHEB95vut1SC7UE7qa7pDUsZZZAnxi
 c4V0VsqqJrOfwwqfWXWTkYiVQeymqWkt3TPoAqu8wHSuKwmo0btqV4o4nS0YJ0Kq8kuMWF0jNhj
 2EkmZgYQvHNd6FCwi+38V/uZIfMpXEKiXRiz0c5wKLXjI5/uxRxL1WFHiqT2WCnHvUdC26ABa02
 QQcoSaGTdLuU0q8zJUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfXwxi1LdNMyhOc
 /1s0Gi1Ndfne+nKuffuFcXJkOmklNoUPM4+Aos6JC5/rLtZCJWandkTZdC/PCK2d6BPl380oaGm
 nsw+esvRprYg3tDB7INvw3Sq04GYpIo=
X-Proofpoint-GUID: 7aor_qBBXkX4-eZfSiKlLENfxaV-LEDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250066
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



On 9/24/26 6:29 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> extending the pxelinux functional tests.
>
> This patch adds PCI variants of all existing pxelinux tests to verify
> that virtio-net-pci devices work correctly for network booting.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

