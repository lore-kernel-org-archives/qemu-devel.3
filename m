Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7572EC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Fs4-00077f-L9; Thu, 17 Sep 2026 13:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x7Frl-00075d-Vp; Thu, 17 Sep 2026 13:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x7Frj-0006Sc-Jm; Thu, 17 Sep 2026 13:25:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HE1ZqU2552517; Thu, 17 Sep 2026 17:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZhRO44
 pQ+QA9p/9/u/dqoX92YK2ABahcrfoW7wALdIQ=; b=TQNQpp4fAxiahD87EL8fyV
 izjMWU6OXHbQLslNjCXBj7jU8y5/Lwwo+xmYr4SxhlNDvHQmPHL5eyGd15NtT/Hg
 tv+CZq5gSDI9emYIF8sKCkrhqupwepfExMyN3Bxe7M65QmeBSQ/0Vc35k11pIkvx
 rZLt9/WtYwYfq+ZkOLOPkuFVJdBzt9jC9lKPeQfSS6VYo7U0RShBVWndtQHNBfQF
 yq8v5QbX7t2kM9U955UHu5xI8XxrD3tsKu2BWbgaygUM4J2XtbJTNdwTsA04fzb+
 Z3GQxGyonOOaB8H888CxAPM1+x28549UTA93wy8xMoDd0jjgjWKOcRcf1hW/rQgw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j3ks6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:25:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH9HZ63494069; Thu, 17 Sep 2026 17:25:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjkgv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:25:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HHPYlZ25952966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 17:25:35 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA5F65805D;
 Thu, 17 Sep 2026 17:25:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4F85805A;
 Thu, 17 Sep 2026 17:25:33 +0000 (GMT)
Received: from [9.61.246.38] (unknown [9.61.246.38])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 17:25:33 +0000 (GMT)
Message-ID: <7a2ec98c-6756-4c9f-8f86-1b0db94c8053@linux.ibm.com>
Date: Thu, 17 Sep 2026 10:25:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260911152137.676602-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX9O7I+AD2AyIr
 g5WdeEAtc5tUJqFD9imle8HXa9CESuyZxZa81QSMSrFK0Fz2qmIi5YnWWcz2nVjliL6+zBLpHyG
 j64ioL4o1KYqq1aei9sCWh/jHcx9FEHjcOKsEe+j4c4HxJ4OJhAslW13oerDWnq9skN/vWRew5q
 tVlgwP3DyDwFI7TbTN5c5oBmqYj5Uo6Djck2GM9ga5T/jXtM1EbdTt0Anh8Oq92lyTpEEgkekcn
 Gdk4rEIVMDLLzCizDadAxLJr+8gDF9xii27300KLi+51K6+P8cT6M/j3gOwE7BhGfgtbwzknB3+
 JQMmnlOLIDgSHq51W2QFHAuCWxFHePwWkYDcXNYVr8eYFq/jdKGJonExhgsrlkYvRmbJOZ9e0yz
 9woHpDxdKe5MHybELDTLHH+CiP3fDbnoPX73I1kdFLAg30+Thc0YaEzgaKw2fkKTQQOXJXBxzEv
 a4SVoau8zgs/cEsNcbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX4b9FLXdy8xVG
 nerTjd1PlGb0d3QjEg6WgBwJZwF9j7kV1UhJOeW4wb2tP8qcNLnWZsypo2+F5M4koYYZv3IT3C0
 0aXUHf2SntfS9nYIEUsMfqSKyVy+e/Y=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aac2290 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=QOwgTxH7XjkeUotP0VgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5ayKlrhBqY9c9wGV6U41yhSv3qJo60Vo
X-Proofpoint-GUID: 5ayKlrhBqY9c9wGV6U41yhSv3qJo60Vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170243
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
> @@ -1303,11 +1380,22 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           pbdev = S390_PCI_DEVICE(dev);
>           pbdev->fid = 0;
>           QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
> -        g_hash_table_remove(s->zpci_table, &pbdev->idx);
> +        /*
> +         * If this QEMU is running a migrated guest, and was configured with
> +         * more zpci devices than the source QEMU, extra zpci devices could be
> +         * excluded from zpci_table and invisible to the guest and have
> +         * pbdev->idx values duplicating those of active devices. If the
> +         * pbdev being unplugged is such, the zpci_table entry for pbdev->idx
> +         * can find a different pbdev which we must not remove.
> +         */
> +        if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
> +            g_hash_table_remove(s->zpci_table, &pbdev->idx);
> +        }

If we are migrating, won't we re-create the exact same state and devices 
on the target host? Is it possible that the target QEMU can have more 
devices than source?


>           if (pbdev->dma_limit) {
>               s390_pci_end_dma_count(s, pbdev->dma_limit);
>           }
>           g_hash_table_destroy(pbdev->iotlb);
> +        s390_clear_zpci_migration_blocker(pbdev);
>           qdev_unrealize(dev);
>       }

