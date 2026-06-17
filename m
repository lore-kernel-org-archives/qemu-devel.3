Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DD4CD98F3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 18:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZvD3-0007YA-Gb; Wed, 17 Jun 2026 14:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZvD2-0007Xl-FV; Wed, 17 Jun 2026 14:41:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wZvD1-0005Kr-3H; Wed, 17 Jun 2026 14:41:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmGuW1106668; Wed, 17 Jun 2026 18:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Bq9RWo
 K2AS2sr4l19gfq4tl/I72wi0JKc9NHhRCylzs=; b=tHLts1ZSnpKKCDjhEEYcoF
 nJM3QYQT2g95PN+SibG7QMkxp9yd2ze/zA6nJ2sCilBvLW5y116B27eAiFlEhEd/
 97rXK+GdbytgZW/szLmZ1kB4ygz9YCmWR6GNVFtNWjfJlMzAdITJviagxYkAPPYM
 Luwp+FjEsUos2FxwyqNVMEqIDRdzgOjx7nlp3KxWLZw/3SU6feInFrDgeHUumIQB
 GCJfWluZg9Duoor/Qe1yp4r0BH+mO0z7aKaif6/xvUVN08ycFEgC0BA/etrXDmh4
 V2/Y1WksAkJvSlQxbhixD/XQ6O0Kg0poiD55Qq7A4d2/v0tAMLbBZYJtvzyaBFqQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtmh3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 18:41:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HIYbk6015500;
 Wed, 17 Jun 2026 18:41:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvamk6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 18:41:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65HIfmmU66978288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 18:41:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE11758052;
 Wed, 17 Jun 2026 18:41:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC90D58062;
 Wed, 17 Jun 2026 18:41:47 +0000 (GMT)
Received: from [9.61.108.75] (unknown [9.61.108.75])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 17 Jun 2026 18:41:47 +0000 (GMT)
Message-ID: <75249d56-b83c-44eb-b161-1cec6580a115@linux.ibm.com>
Date: Wed, 17 Jun 2026 14:41:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
 <20260617164035.70788-3-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260617164035.70788-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mU1aXTM45r460urYCI_DhfMIauU-3N75
X-Proofpoint-GUID: mU1aXTM45r460urYCI_DhfMIauU-3N75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE3NyBTYWx0ZWRfX2n1K5tEEdfbD
 1iaUf5fUb9HH8GPagy9Jf7obIg9g9S4T75mrG9ZRfQbVW02Bj341NKpnpk3EgkKOb2t6TRBn0OD
 +5XjpRI1gn7uaQOKGWF1LEHSysHgnfMbWEVNv/XpDESfe8rkG6GtNud0hBHy3D2yrpLDPRQ72Vc
 yOhHQequZmWV+cQBCJlQzP5FcpLLwkI0BNIHNUvm7BhKl7SvuY9trvylIqUy8BPnsFfkkHMzO/P
 9Gi7mwx/D5HqudRsBVeGM8a57ZHPStgWAeHx4KKePP4hG4nwWo/OGptnlD5CKGSdZypx94Djj0Z
 mBP23Y4Cq3yYnREQJJ/sKG91Iy8GfhcKweWv5VboVP6EwX22eFdBrv4LMwZa1lrnvsdZGhIUaEP
 Xa0hbEmFpzBFPU8GF3T9vwVcgqeLT02dcVR+9s1zQoIaCT8V5YWQVMB9ZcImGu6uS7jzakSO9oo
 24ehBw8a0G7sJtP1kog==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE3NyBTYWx0ZWRfX6RMY8zDm4cxc
 tpcxeetBUuE86JGxXgyfRA5KprdIu1C9fvbkLoJorIAi99HzHhtc80CUHy1ai8hMStp9dn5Xm+Z
 8u1C/J0XiXeninWXMTv0jXMmmbBsiNY=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a32ea6f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=IOEvM4RB4t4QhUxhUvkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170177
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


On 6/17/26 12:40 PM, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> cpu_physical_memory_read() and cpu_physical_memory_write() are
> legacy (see commit b7ecba0f6f6), replace by address_space_read()
> and address_space_write() respectively, accessing the per-vCPU
> address space instead of the global &address_space_memory one.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20260616020839.19104-6-philmd@oss.qualcomm.com>
> ---
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

