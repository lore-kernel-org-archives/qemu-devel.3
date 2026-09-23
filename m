Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7A9C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Utg-000371-Tx; Wed, 23 Sep 2026 17:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9Uta-00036B-1U; Wed, 23 Sep 2026 17:52:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9UtY-0004Qq-5P; Wed, 23 Sep 2026 17:52:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NK5iZ2158282; Wed, 23 Sep 2026 21:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SiaCQa
 VHjMcdCU4YpLxFtP5mIleVtvc/3FbOjCQTIvQ=; b=e6TWU8AkJAU2gglXWd9L99
 VmYjgaVjyaA4utejThZC/ioTdBo7e/Nu0pC6OUeI9Hh+MHpBnYvSCzokOsiDsJTi
 XcaK7e+IPoTe781kQV/K3SsO70gENPStZSlsj1EnOzV9D8LYbL4F0NGB8aHEKxY+
 BAKQdngC8r0qb85+/U7pqAbOheJBF0wWbZWwN4yQh3g2p2wfNSYaggIfJiG6y40n
 MlAKDP3b0aBXjXCn27g/svkw3D6oOwHt12QqKk7WGOkT9P3BV59RDj3I4poTjq2O
 Mvy6ZZs81KpdfSD1JmkdabbTwySdDoX4dnI02jsTqeMtCRlPhLqZ6YtP92IsWmHA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ntk1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 21:52:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NJmjZo901734; Wed, 23 Sep 2026 21:52:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jtyj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 21:52:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NLqiLP28181198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 21:52:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DB0958065;
 Wed, 23 Sep 2026 21:52:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB00B58052;
 Wed, 23 Sep 2026 21:52:43 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 21:52:43 +0000 (GMT)
Message-ID: <d8a0b367-42cd-4887-a2ae-cf7f389e7af7@linux.ibm.com>
Date: Wed, 23 Sep 2026 17:52:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Extend comment about PV cpu load state
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com, borntraeger@de.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org
References: <20260923082146.62803-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260923082146.62803-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LtKOJW9joWidVxNOcy5CgC0KqOL3OL3M
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab44a2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=lRyusxPUYzjeSrJwpx0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4NiBTYWx0ZWRfX1YC0TcFqBM2r
 yGKYDcg04ss2HSHbWa7KE0BH42YUu3DyXneNDOR/sMYy/HVFiWT/s35Z9hyeB6ok4rI7zUbBxyy
 zktN7WmYqBi/RFQGNknq4c0k/bh/+AlTdFDackLgwOKN0h1+vFk80v57G0FkSC1QsXAvoqvDNr8
 Mr1Zdq7Fw9Z9KUdYkNRDRPHFdaYO3lrWsmhrV+xsW5oyVpe7bwS44i0O7qylX64F9bqen7Gyz95
 iEwzBAL6U8exYysd2Rf1e3F9Ntf1Qe/CszA6ZvXp666ZlSABayIBswn9Pj2H31mUq+48Pni09nv
 1Rn0lfaOLD7QfN9IuuBniYmtmJzuZxG3B6yONDo9c5wVhX0Ydr0ELeHhAR9EvUJU76vp8KyVd8K
 W00OJguItEDDQyAsC+F+AdEUAviW7fMTFstddRfXVhPafTZd9dl1Yrpa1VztCUuj+pQFadgDaa/
 WEXHWiLn072jVhmgjNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4NiBTYWx0ZWRfXwhNunNjNsKny
 Yoq+zYSjnm+9a7X+aBqgs1kDt38prISpTq648lTwkxEAF8ui5fb2Y/IR2ozchVwfLwtQbRJr3/d
 GEWpDUob6HJtTGL7NsMGuCxOj79CuwE=
X-Proofpoint-GUID: LtKOJW9joWidVxNOcy5CgC0KqOL3OL3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230086
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

On 9/23/26 4:20 AM, Janosch Frank wrote:
> When implementing PV in KVM we chose to add the cpu load state to the
> mp state solely to have a way to keep the UV happy. The UV requires us
> to set that state before running the boot cpu since entering that
> state sets the initial PSW.
> 
> Since entering that state in KVM only sets off the UV call which
> causes the initial PSW load and does not set the KVM tracking to
> operating, we need a second set mp state to reach operating state.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


