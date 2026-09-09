Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1360DC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jwe-00026k-CM; Wed, 09 Sep 2026 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x4Jwd-000265-2N; Wed, 09 Sep 2026 11:10:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x4Jwa-0003IF-Js; Wed, 09 Sep 2026 11:10:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689B1STU3802117; Wed, 9 Sep 2026 15:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Vi4Pw6
 c44tgzhIkJLO4stjBo2IBpfPtQNNrId3RrOg4=; b=HzNW06SMXjCzyaMvMfEAOF
 D0XGEBfsd8IXo7Ldp0HNYxOub6jneoYfq240Son9b1Ig9ZawhK/sgGq6zpONtdCS
 S2MQcxxBTDbth5FEB2lSoX7AMvH1YQm06QS22x7vBfsOI+8Xo03XB0yP4q9ZUmPv
 4aYxfIPJcCNbELywidaUQlEKg45kxybYdJfPO4f5r5ZLvRZC6wtkTxn7H6HL4Mqj
 2TKmwtlcfFQVKKqG6AxjkRsyQo4xX1KK09D5S1b+sIU5Kj4k3/TR9aLMSAxclCOd
 t1T1lxb+al+MCyANZt3QsCcGZ2kVwD/W6Hzq9thNkOn9z8Ghiu9FK/5KO21mE4GQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkxqfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 15:10:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689EuITU001749;
 Wed, 9 Sep 2026 15:10:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yjr3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 15:10:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689FAV3l41681154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 15:10:31 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A616458065;
 Wed,  9 Sep 2026 15:10:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F3B658063;
 Wed,  9 Sep 2026 15:10:30 +0000 (GMT)
Received: from [9.61.96.29] (unknown [9.61.96.29])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 15:10:30 +0000 (GMT)
Message-ID: <5c9a80bd-b6d7-4e1f-8c35-c0c8412cbfa8@linux.ibm.com>
Date: Wed, 9 Sep 2026 11:10:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-2-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2OCBTYWx0ZWRfX7H9qz0W+urWR
 WGSyMBxRoxKLmVeRogXnWt4mh1p8qq/L5bSmAKPJ5fccpuCqtW0Uvh2GeDSmoZbHceZXICXStWZ
 14/dge6Dkco/SJ75Yxa6HrKr6Oz8Xhw=
X-Proofpoint-ORIG-GUID: DKLobhszLGBEGu3FwPrAQ9Kd9VAdaYhE
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa176ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_q_ucG0t3VmhI-TeMEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2OCBTYWx0ZWRfX4C2CPTcUCbz/
 nSrCJFZ/FvCCrcim2kjaE+eQwFQHD1GKUekTlEDkxfhjBOsW5B6VN33WJjV5RVv6OyFiX8o8e0N
 BgDExjB/F8vZevqWkhj/pn4rxK8y5YfUKUuxY+rUSwtqN0ooJron5Xw0cpqpI3O2cjNtM4deUot
 AjpCDhN4HpCWitFd28ay/UDMX5VpHiiL0RCYuvgHB7dKP/1afIuAf4lwahSdqKfyyS5dAMBlHhB
 sMOXfz2zAZOVaRddTMTj0pz3Q1FeavHQs0Xz8lmRg9oEKZrtkq/RpJDwmDDNj8RASbbDJlnWV0B
 KGiZMR+dLb/1vJx8vLHTbx/uhPfnQkwopmJddwvkFDr/LerdZpmfebVMaGX6qblFfwXr5XmdxIs
 G4ZbnDcnSmUTdCrZYLmcanszghcqJUYx1pIIaA3fWvWkIJFOnRLnD1zuybflT22jSZleIXkhXFU
 h7m/RZyQFigfmV3amwQ==
X-Proofpoint-GUID: DKLobhszLGBEGu3FwPrAQ9Kd9VAdaYhE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090168
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Move CCW-specific virtio_setup() and find_net_dev() to virtio-ccw.c
> to decouple the generic net boot logic from the CCW transport.
> Also update the error message on failure to specify "ccw net device".
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>




