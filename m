Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EFBC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQyj-0004Ce-TM; Tue, 18 Aug 2026 17:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wwQyi-0004CN-EG; Tue, 18 Aug 2026 17:04:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wwQyg-0003KG-U8; Tue, 18 Aug 2026 17:04:12 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJWD9q139986; Tue, 18 Aug 2026 21:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=luBTwG
 IsnJ9bMdo2topTHad4bPLOW2hOIGzMvhulDTA=; b=AvBM4vK1oR3HBh+R10fcRi
 H4YHtGSQ3jfXEp7M7cPcoOTSyDj0JpQ8wCVQJJVuA0R/XR5Uek6mfa8GG5PzgD1g
 2dSsi8yM3JU9Xsb5GkEVVW9DMLQt8u2D1QSZBLPgWL9yJbUW+/+DgNySl/yK8E4v
 lgFa8FXbuHMbRdQlAIfFIesX8QmyxwIquBPqqesm9KLhfkRMsi8eyGLKcO/HxVyX
 PYVQEC3DkVyWU0owTxlkJCR+cL/YFuqR87q9CfZvbf+j1viqQP+iDU0kza6hSNtm
 rVwrHJixhx19fpr2Y0JdzIGtlOo9fYR7aXm+5IM5Lzy15ZMyY9NCRMaRmTDbC7yQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2eheafp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 21:04:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKuHP1032659;
 Tue, 18 Aug 2026 21:04:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngd8wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 21:04:07 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IL45ES27984414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 21:04:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2335C5805A;
 Tue, 18 Aug 2026 21:04:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C6CF58051;
 Tue, 18 Aug 2026 21:04:04 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 21:04:04 +0000 (GMT)
Message-ID: <9a2b34d7-7dc0-4dd6-84b6-3e444ed37c51@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:04:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] s390x/css: Fix css stsch detection to go beyond 8192
 devices
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260814152226.1834819-1-borntraeger@de.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260814152226.1834819-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1NCBTYWx0ZWRfX7Xy6dhcbbKo2
 MwH2kbaOmY+SeX3SFHAZbXLfkdyk4aW7hI6oi7Ma1Z8w4e58CQvIYEAbW9xL5ARIye5wUZF8Udr
 +x1EjgwVE+45Ip2i7i6+dxLZHLpqVqFkMo+4AyhKlRNvoGJwEc5SNBuLWaAvWp8KqNKY/hXLB3P
 33Tyl0Rkx0TmZ17sRBkhMdB0ckH/9Vc4DTm3uxcJ+T6vSPPWfkyMBapsV8JUSea7otv72cLLm5x
 Flxf1P87Z0G6ioZgnEpWzoGeWkGDxS20OZDh1sLmvJjlKcKchDHrhR6oh+ZzlXaVPOCjUR3uV9h
 vkRw0kwDMHPbJCcg7ls43z2xykVAnvVRnlBYi8QA0aQoXspzqA+awG2/3f2rYQRnLOvM0ubSykb
 F6GGUhL8PtJuHIN8+n7tWAzr+22XQbF1hqZPY8vo5EHnZdqEG79xYbSK6fB64cSx1iVR9P6Ygf9
 h/fSHKgmLz0pbvJXF4Q==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a84c8c8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=RoCUfBOtFCEzv88T6vwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dV2j7uTBLZhK6muNC1XK--TT5aoUeR1i
X-Proofpoint-GUID: dV2j7uTBLZhK6muNC1XK--TT5aoUeR1i
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1NCBTYWx0ZWRfX+IPsFae4uKSm
 VPiiela/5xMVLu0w0MkJYoJVHxttqmZCPdiUiOSeUtBs8CEvjhFW5ebIWWDiaytXWKlvfRONNiI
 wS8IiZ9pgiyr7FWV6R/obK+zVwz3sns=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180154
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

On 8/14/26 11:22 AM, Christian Borntraeger wrote:
> From: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> find_last_bit expects a size in bits and not in words. the calculation
> limits the number of guest devices to 8192.  This probably does not
> matter in reality, its wrong anyway.
> 
> Fixes: df1fe5bb49241 ("s390: Virtual channel subsystem support")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



