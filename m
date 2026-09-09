Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFBCC79FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jv5-0001ZS-7M; Wed, 09 Sep 2026 11:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x4Jv3-0001ZF-Ii; Wed, 09 Sep 2026 11:09:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x4Jv2-0002xw-3u; Wed, 09 Sep 2026 11:09:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689B1uga3840306; Wed, 9 Sep 2026 15:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jigoyW
 DRlPOEjrxGgioffJiBbCI7eNJmTAyEBij/ieU=; b=HM+pcSSJNv69WTD56tNAYx
 jpkoSfBCkb8vtGqZJa+IT+Cfp9gbuBZFZAbZx9glzs8LHhB+9us88mbIxhCqbkFv
 V/Xc7IXdg2cqdSCp5LAksib0FemFYxBa54zCvHPhokT4NMXSqRNipKFyeWkhnsW7
 IgM5ybxEvRCJFFSeYsbf1iYEL1zINxUG5hduHvTYlPl0sQbzuPWuMXVWKevEUU2f
 IpRQFhPZqActLug4vr4kPzLY3u9luDKRWNjO2GubdzFyJHfSSKQ8CVRjEYaGN3/k
 JDJwnhGF2skhroc8Mwl2Bxhlkfd7S9UsGvZIUv0IaxGJNZo47MujhWwDqm/oQLCw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf69e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 15:08:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689EuI7H024745;
 Wed, 9 Sep 2026 15:08:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwhav9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 15:08:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689F8uE365405316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 15:08:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E48AD5806B;
 Wed,  9 Sep 2026 15:08:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 868795806A;
 Wed,  9 Sep 2026 15:08:54 +0000 (GMT)
Received: from [9.61.96.29] (unknown [9.61.96.29])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 15:08:54 +0000 (GMT)
Message-ID: <86ed2c8a-ad68-4323-88cc-4bcd26fbcfc1@linux.ibm.com>
Date: Wed, 9 Sep 2026 11:08:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] pc-bios/s390-ccw: Add dynamic net header size
 handling
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-3-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-3-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dgXFFr6KhG3R-YDYo5xTgRtGdj3lFQpQ
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa1768a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=WjaA0fo2-EED3nBzAJwA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2OCBTYWx0ZWRfXxMpORITrxNZn
 A0+Zn7qxngwr6KOGAmF807a5yBv66V185BeXd4RR/u4UShb9QAt6+lpAnnS6PnV9CC7K4tO45v4
 /YWkgbJax9UbUr6KmOuOl6IH7gF0NGw=
X-Proofpoint-ORIG-GUID: dgXFFr6KhG3R-YDYo5xTgRtGdj3lFQpQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2OCBTYWx0ZWRfXyEr6Ez0r6sqQ
 4PDCLXAyRfrtYbWOlfp3V5IoX+NfMrCPIhwUCJijSCybzllnDq33d/lSAdiUn4LthXpSPvIjjGT
 wrORLeMwalM815cqFLTbQXycJyCJXJbsyAOUbRf8p7XFxL3hKyQ6Y7vBaJ3QsOJD3IoEu+nqfoK
 e/PtkMElXWhr0nGS33yGOEoPRzOHY27tbT6ayjhNWFT3UL0JegFSzgAI0VByM1LrSlt97nLj6ZB
 saFyTK6spoNSoymet4nF+xbz64tCiHqH6o+LavxpAHDgjYEoIU/PUe5wHJmp/vhcROoomTRuK6Z
 Dv1qZDYZ8QOlHlCpEltVupTRECrP1pG3hUoU1DjGrAkxnFCU5FkiuqgH7bfyQBfn3HOYAadXD8p
 YPU7JCdYt7yiUasTu2MnmSD5XWKDFC7t+0csLe4IrFgdrgThuShF4Ngn+3OOx1680E9rjfL0FxI
 TKDpIu2ZzT2CuKgOOww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090168
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> The virtio-net device used a fixed header size that did not account for
> the num_buffers field used in VirtIO 1.0 or for the mergeable receive
> buffers feature.
> 
> Use dynamic header sizing: 10 bytes for legacy mode and 12 bytes for
> VirtIO 1.0 or when VIRTIO_NET_F_MRG_RXBUF is enabled. This ensures
> correct packet handling across different VirtIO configurations.
> 
Since you're already touching this patch based on Jared's comment, maybe
add a small blurb here that you are replicating the same structure
mappings as defined in the uapi.

Thanks,
Matt

