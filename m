Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE49C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52yJ-00055j-3R; Fri, 11 Sep 2026 11:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x52y9-0004xX-Vl; Fri, 11 Sep 2026 11:15:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1x52y6-00021i-75; Fri, 11 Sep 2026 11:15:13 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1Yf1971235; Fri, 11 Sep 2026 15:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7KwS+Q
 FRNE2hwggQHPXN/NyUcN+XMu5JseW91IMaxCo=; b=SWDpTKtivFmu9zSMh2OUv5
 QzsF+JxgUlHG5Rq9HM0WMio/tNmHah1OZiPX/7vG/sZQn7qu1nuDjJMwErE3Wtgs
 j3HXnfWVniHuukRxtPy44Ybgn/JlfsuveqQxxhRHm3fUAfk72MiMtDJSoITeDttp
 KBe+j9qTWjfuJoVuWoPpIeUMXjsZC6NSWVZcC5EgOWAH+EM8/Tv9FU2gBm9qM9Ho
 blsv/5CQq5vcA58949IDsIuOchMsjEMnP7sYLaImlfWW72ddqFaL5oXYATjAjrjG
 oxB2xKZ7uYji6qiLcqOQUhRX9u8d6PuwdoQn2fAlu2zMXM9Evq6iosYK2MEvrMdA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qc851-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:15:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEoBfR1764919; Fri, 11 Sep 2026 15:15:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvreywq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:15:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFF5nl30147200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:15:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2C9C58056;
 Fri, 11 Sep 2026 15:15:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0945805D;
 Fri, 11 Sep 2026 15:15:04 +0000 (GMT)
Received: from [9.61.94.186] (unknown [9.61.94.186])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 11 Sep 2026 15:15:04 +0000 (GMT)
Message-ID: <a6aca4c4-ed28-4582-9f6a-ee34c5ebaa1c@linux.ibm.com>
Date: Fri, 11 Sep 2026 11:15:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 jdaley@linux.ibm.com, pbonzini@redhat.com
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
 <20260903162449.2588271-2-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260903162449.2588271-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mXq8yvyFSczroECsF7hz4ftxP5KfLTwT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX/CIh2Ww6h4UD
 mYalLS8jG2HSP39QfrQCZa1dAtTxVGuE/2dDvggR9jAs4S+1ufqNR/NP7J9obACEmo/W3h6Xlxy
 UDe7ILnI+QoCW9OvpssbDvMIbKxIEs8=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa41afb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_q_ucG0t3VmhI-TeMEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX6FCj6bNhVuol
 y1VgPvNgWIlEYY1ze1gJzxllzu3mCVcwusgy05exI49CwLef447kRXkWUhx+sC7cRI2LFkKUxpf
 xVNm4wcKblAsYbOWBoq6zG5eY3ZqvLE42P9ByR2Rbl/CVGt0Y9VsVW+NqF4IOW2zl6TwIfsxUmw
 lCiLM/ZeR+mu5j2MTMrU65FccYmcUdhcXL3WtGD/F569No3KCtdDHN5WhoOUnUlnBb6c/UdeETw
 kel/hbyl0Lph0LKuZ2OE/2kt1LlAv/909G50r3fXLj+jvsp0D35opRXF5VvN8Ifk+xKxpJ+kOfN
 FqmrSpXC/TuQPC9Nh4Pz8QjGy0wczyZ9bRcTVBLeuaGl2iAJhKEwAD3colZ0Ve80IF8IySZqXM+
 squCmqBeI7qV0BDrAsJeCI9TJvf9JD9882PIGFj5CCdJoc/o9mV0DGM4MWkV5Em1auSuigBmv0v
 gQzVjLrGP1rL4kxBoRA==
X-Proofpoint-GUID: mXq8yvyFSczroECsF7hz4ftxP5KfLTwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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


On 9/3/26 12:24 PM, Zhuoying Cai wrote:
> Move CCW-specific virtio_setup() and find_net_dev() to virtio-ccw.c
> to decouple the generic net boot logic from the CCW transport.
> Also update the error message on failure to specify "ccw net device".
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

