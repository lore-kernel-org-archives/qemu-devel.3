Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78933CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 14:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Jq2-0003eL-HY; Thu, 02 Oct 2025 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jpq-0003XI-3P; Thu, 02 Oct 2025 09:59:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1v4Jpc-0004DD-7D; Thu, 02 Oct 2025 09:59:04 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592ARNMX004212;
 Thu, 2 Oct 2025 13:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=azPaSz
 4JhiYlR1sbBhza5U8L0F2Pnw++GO2toOuqNHE=; b=HD1m9rA+WGhRkvGUYjUSa0
 rOuJuouS96xLqe3fej+FEHMdMyCjc99ddoAFvCJ6N7K2bz5ci/ZR0EMOBCfyWfT/
 oVel2uTgQbGVL4KYkn4laPlhAuBgO+HDaKSlZxP/DoWKQJJQCedopOerW0VBVXZu
 EjhG5YGhjO6RScCxJWCyFb25CaIAI/GHXzrTZMIVf9/b3g3s9OlB7Z+O/W2Kb4CB
 q2fVfBu0bIoOLLpBxUiqhmGq9nyU6ogkg8hUekjYGYFQr7oDEhwNOWwn7MZ6ATy8
 xL7UnNB1jglPKqy+Wk7bsCo2dQUkKrR58eT2UBi+s0NaM10arlsIZJ0+YiXT681g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bhvvfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 13:58:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 592D6O3O003599;
 Thu, 2 Oct 2025 13:58:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmy6cd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 13:58:38 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 592Dwb6s32244434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 13:58:37 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EAEF5804E;
 Thu,  2 Oct 2025 13:58:37 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8ADA5803F;
 Thu,  2 Oct 2025 13:58:35 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.134.141]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 13:58:35 +0000 (GMT)
Message-ID: <8d8ad6d2aee64a3c9db7a0096c4712d70860fa59.camel@linux.ibm.com>
Subject: Re: [PATCH v1] s390x/pci: fix interrupt blocking by returning only
 the device's summary bit
From: Eric Farman <farman@linux.ibm.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com
Date: Thu, 02 Oct 2025 09:58:35 -0400
In-Reply-To: <20251001154004.71917-1-jhkim@linux.ibm.com>
References: <20251001154004.71917-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68de850f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=zDjPMwzhIzfscW9YWh8A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfXwTapjVs7oaIn
 Lmgtrh6vrCDEX7B10GYcNwM+VW3+KndPMxuSeQCH/h57ayLLIqG+alRZvou5zUB9aUrUKVvpijP
 vi8qFT3/xzWSnEHBXxcNQYX6JlCQD90ycGYvPGM5srQfPSUOgoGKEDsl7mMCGx3blobp05NQ1Z5
 wrL6ZlPlWm6r987zj1jR/rkUc8g9q+CxBNokEzmJcakMlE1PLSZvnCN1xzRDXXBZHYTVZGWk4vq
 0DR8RaNy2SotEDHYeBZnClrEdvnrmkqO43wuR1OImGi2TIfMag6S4fevy5w42a5tGbW8msESBrV
 CcPlZ4u/SZU5f9WgOf2qfAExn6PNVRNNfJzhwNYL2AvnzZoxKUvXrvfurK3lHoisheWFLPFRPLr
 gMijytyIBYDNyWIqLSWpLgHLSXMLsQ==
X-Proofpoint-GUID: fQ8kkrgBTb8gLcqyBi56QBgbR9RGHi3J
X-Proofpoint-ORIG-GUID: fQ8kkrgBTb8gLcqyBi56QBgbR9RGHi3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2025-10-01 at 10:39 -0500, Jaehoon Kim wrote:
> Previously, set_ind_atomic() returned the entire byte containing
> multiple summary bits. This meant that if any other summary bit in the
> byte was set, interrupt injection could be incorrectly blocked, even
> when the current device's summary bit was not set. As a result, the
> guest could remain blocked after I/O completion during FIO tests.
>=20
> This patch replaces set_ind_atomic() with set_ind_bit_atomic(), which
> returns true if the bit was set by this function, and false if it was
> already set or mapping failed. Interrupts are now blocked only when
> the device's own summary bit was not previously set, avoiding
> unintended blocking when multiple PCI summary bits exist within the
> same byte.
>=20
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

