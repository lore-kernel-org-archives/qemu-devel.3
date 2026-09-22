Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8D9C98306
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964H-0000mt-Vy; Tue, 22 Sep 2026 15:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x963w-0000aK-PU; Tue, 22 Sep 2026 15:21:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x963u-0002Qa-Tn; Tue, 22 Sep 2026 15:21:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7VaH964939; Tue, 22 Sep 2026 19:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wuubP1
 0h95L76QIfUwgSB/zzBFF12AJ5dcMI7rLodLk=; b=ACrHrGBMO9L0USNDL1QTDI
 hJm+Yz5yxhP1Sb69oloVji/omq+zhPadqJBiH8ZS0nDksmcD3Qc0E0qgIOc1S4A4
 Jk/yNJ1+0mLYRpHEuu6yif4AHqFltHroXm3g9aozD3B6jCDmCsWCqsu8jb8Y9FNN
 HtecG2/6USQwZlHgdOn8KiWWPVamGyEX0KOJKmtxPNErVi7/fWEbmb6qQy4Ri2Pg
 4uFPcNBJKtB5PELG7oIXINHCkyOeBmF61aRBSG9EVaw1wNl9ZFueiQDnwZXJgXRZ
 u+rF/Vu4DkYZShj/2YdtpN8qTu3duZDz2LyXQ+ky6VwysCaUUXQKWKO6rVhP4Kcg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1faf7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:21:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHYSp3220300; Tue, 22 Sep 2026 19:21:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vk8ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:21:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJLnHo20382226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:21:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E6BD58055;
 Tue, 22 Sep 2026 19:21:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 354B05804B;
 Tue, 22 Sep 2026 19:21:48 +0000 (GMT)
Received: from [9.61.245.87] (unknown [9.61.245.87])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 19:21:48 +0000 (GMT)
Message-ID: <cbc89fcf-a681-4301-8f0e-f6eec652fe94@linux.ibm.com>
Date: Tue, 22 Sep 2026 12:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/16] s390x/pci: implement IOMMU replay
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260922183654.798470-1-kshk@linux.ibm.com>
 <20260922183654.798470-2-kshk@linux.ibm.com>
 <03b1a9a9-dd35-4d0f-90c7-2d9eabcfc7b8@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <03b1a9a9-dd35-4d0f-90c7-2d9eabcfc7b8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oGwOl5TgD86dYMGNxDMvuDR5V1zjTeFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfXzIKnvviFTCLB
 pP0mm646cuQv6W/8OSG8bsfcm7fFNDYLRAqyPQlcyYjdgXX8ikJWjOan62PcucAcPgpy+WoLtfA
 Ew6Pj91wUzQBO/VG9cpIa8DTfB6V3gsUhFkg4GNM8jnBl3WgZ+s5XX4gIZBLNi0ZIHW6kZyLdJm
 Pqc3FS0tQGfPHJTD6MNkFFe6iuVQ9btxN/bXc0aatZ3q/gt93bWcLAYSMLW/Cpuad5x80mwqm53
 891OEOWl3GfD3c8lFRbO9cRzFL/pbXbCM+NkJDVUWMYme0bOlGwKeICA7gMOiQ6kNyTj8WWMohP
 vemqI0UzyHzcz+IYra89d9I48iMEItUCn5r5QlatKpEqgXfHFruzXhXVNcWIcX5BVRvwRC86yD4
 ZNa1ycA7higmsCOuG/2BdtfBoest1mBEpgp/D98A7PCAqbNTcorUrPXP64lgc8ljq6SnayIWyMr
 HUtIoJilMQqfUd1/kOQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2d54f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=o2LAkmTLU-qFTlt2caAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfX94EWSNouOgyv
 i3tHtckuT493i3oZEHftwsY5qv/TdZqgR3mLqP6lWty9z03fbKmLQxA6bJBTRalB5+RTxmOxASm
 YJr+uzoKznUfi3pPRumhGcq1bH5/DHY=
X-Proofpoint-GUID: oGwOl5TgD86dYMGNxDMvuDR5V1zjTeFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220280
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


On 9/22/2026 12:05 PM, Matthew Rosato wrote:
> On 9/22/26 2:36 PM, Konstantin Shkolnyy wrote:
>> From: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> There are a few scenarios where IOMMU replay can potentially be needed
>> for zPCI device, namely VFIO device reset scenarios where the guest
>> continues running and expects the contents of its IOMMU to be replayed
>> upon IOAT re-registration and migration scenarios where the destination
>> must reconstruct the IOMMU on the destination.
>>
>> zPCI migration is not supported yet, but the IOMMU replay function is
>> implemented so that it can be called both from IOMMUMemoryRegionClass
>> now and migration post_load later.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> After some discussion with me on v8, Farhan gave his review for this
> patch, looks like it got missed.
>
> I'm not aware of any changes to this patch for v9.
>
> @Farhan can you verify and reply explicitly to this patch if your review
> still holds?
>
> Thanks,
> Matt

Yeah, looks like it was missed. I replied to patch as my r-b tag still 
holds for this and there were no changes from last revision [1].

[1] 
https://lore.kernel.org/all/1a755a8a-2615-49c1-b9ef-508f3245c497@linux.ibm.com/

Thanks

Farhan



