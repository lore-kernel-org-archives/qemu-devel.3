Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF3EC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKpv-0002nO-5P; Wed, 26 Aug 2026 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wzKpt-0002mP-9m; Wed, 26 Aug 2026 17:07:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1wzKpr-0003Y5-PW; Wed, 26 Aug 2026 17:07:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QL1hA53280729; Wed, 26 Aug 2026 21:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qzbj63
 frSG0xTtcIMBD4cug6oFQBZQa0JZaf2Inz4uI=; b=HGoL0BXervh+08WEGqaZ12
 ipRg4RktGLNTGcIh6bwGfGyCVASVZx+wrrsYqYU/Uux+rp3euOo+W/F3Km3SFEfd
 NmBOnSbxQ9gI1YUjxXGcTusvC3ejUxlai3c3V6PQnnp6RvVxZSzHTGZxl/6ju1mp
 fYXFdmbXT2DTy/ua1MT7G413blsDl6Jh7WppiIzKwbNUu7Ld+/kOJZrmDErM4mCK
 02gBROfCh1mmPaoKTnzL5BlQ+7csMKCNpU6yR0XiT8bB0+87rqbw9l326D67VotU
 ifCI7mOiM5WtA1H/6VUoPtwvUZRtQFBt/9JEOTNWc7gAacOp0UWCGPUCRbcc8yvg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73er168h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:06:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QKuJ2d032575;
 Wed, 26 Aug 2026 21:06:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qcdnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 21:06:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QL6vGd62849502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 21:06:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B4E958056;
 Wed, 26 Aug 2026 21:06:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF35758045;
 Wed, 26 Aug 2026 21:06:55 +0000 (GMT)
Received: from [9.61.176.10] (unknown [9.61.176.10])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 21:06:55 +0000 (GMT)
Message-ID: <624174d3-5cb0-43dc-8f1b-e952f2e808a7@linux.ibm.com>
Date: Wed, 26 Aug 2026 12:26:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio net
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260818205324.580199-1-zycai@linux.ibm.com>
 <20260818205324.580199-2-zycai@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260818205324.580199-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _sFJX7WIbPkA-2dXu7A9BrbgOusQdx1s
X-Proofpoint-ORIG-GUID: _sFJX7WIbPkA-2dXu7A9BrbgOusQdx1s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX9UMpPcT4sK4W
 JQJb/ctt8j0IN1Zzd0AC1V3oPNv8l9f8uFYCPhJnwWjmPZmcCFkY0GE48GTLNkDSwoezfdst/na
 9s9s4YuGs7pIAZ5L5Gzlmiim3eli07dAe8Ih4txmn7VW1yv0yMc2nBKOsjhg3VIoB+5GjrWHvQw
 d4vbvlHAm173HU4MbJed5nEqLhmLQgVQobdQlP8StyGp7Bh+/0b1hLRfpsKD3UEZFqpum3N6IpN
 H9kuc4fQ05nAtcK1+BSm7zuvRtw5663NZStp+fQLddTU8G7zeZCMHENCVHCKyUZDdrveuDffj90
 +nQiqqasB8QeL3dEuxajaJuW2jA40blhab51YUnvBImdtGsNoYkZbo0jtr9q58K8hKJa0ygCu+a
 HkkVOWYsSLqO9NecQYyiZUZHbn4QeIj1yC+ygGUngwgJDUoewxoy/gU8Z7u0rA4bBw1CMe+9gBd
 mp79ABTx4mBMRF+Z3fg==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f5573 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=s6Fv5G7j1F1L_gFTlCUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3NiBTYWx0ZWRfX1h/M9BGSmO2V
 qGAJ/sEzJjuzDuXRhGZdYy++oe/ClJHiZjwoycK+dB0GBelKDHn5GWxwx9rYSF2LNsWxOzZ3b9V
 Vc8ENo0CHRwCzN8pGYx7jGZ10nr1Id8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/18/26 4:53 PM, Zhuoying Cai wrote:
> Refactor network device setup to separate virtio-ccw from
> generic virtio-net logic for easier reuse of existing virtio
> functions with non-CCW devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/netmain.c    | 64 +----------------------------------
>   pc-bios/s390-ccw/virtio-ccw.c | 62 +++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/virtio-ccw.h |  1 +
>   pc-bios/s390-ccw/virtio-net.c | 10 ++++++
>   pc-bios/s390-ccw/virtio.h     |  1 +
>   5 files changed, 75 insertions(+), 63 deletions(-)
> ...

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

