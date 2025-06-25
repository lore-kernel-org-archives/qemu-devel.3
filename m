Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD05C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUPz5-0003sa-3O; Wed, 25 Jun 2025 09:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uUPz1-0003qP-VP; Wed, 25 Jun 2025 09:16:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uUPyv-00018A-Qf; Wed, 25 Jun 2025 09:16:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9dPd7025215;
 Wed, 25 Jun 2025 13:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=P2pj/z
 BpydAAkWH+5WPEhdbre6H3SXHrMVY6hJ9WJJ4=; b=AniML4Z1AgsE4pOrhTLNGJ
 iSnTkLVPJEuSlQj/d68rCSugr50SAyaENb00FQlQrpFt69Z7EOqKQLv0bxQxGxcV
 2XurgxMLmFeh8wNyIGXgvuUknUwTJTVfB9O8mtxS0oJcqL77jWJv3J3skn9vLm+/
 DLZYsLj6Mw2IubsdA8fflxz6JHUw9T1TpdnyJaUCEjjUqKi/F7Cy8BJey8+TUSyj
 X53wAojEZKcebfe0VDCxe3UOYGd0EvBD0x98niQfzFUJnNZwNLxMIdjuXXrChByI
 5Z9HEcI9lMUQOk2+K/zZGHyTV2RA+J5jkTjjYY/+UCbMt5t5CXQrvUtnD9HyNzPA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63y93q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 13:16:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9YFoQ030552;
 Wed, 25 Jun 2025 13:16:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7f01jek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 13:16:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55PDFxWh33882674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Jun 2025 13:15:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 424565805B;
 Wed, 25 Jun 2025 13:15:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6210358055;
 Wed, 25 Jun 2025 13:15:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.169.210]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Jun 2025 13:15:58 +0000 (GMT)
Message-ID: <e1c8da1cf78e911fcdf1855a6c381dbe96048c0a.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/s390x/ccw-device: Fix memory leak in loadparm setter
From: Eric Farman <farman@linux.ibm.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 qemu-s390x@nongnu.org, qemu-trivial@nongnu.org
Date: Wed, 25 Jun 2025 09:15:57 -0400
In-Reply-To: <20250625082751.24896-1-kwolf@redhat.com>
References: <20250625082751.24896-1-kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5MSBTYWx0ZWRfX6+e2lqDpDHPP
 xch1JXu292so/10grFSOaxmcVGl+fihJBbG6C/NjZNMwp+2jEQw5Q8OqGbn0oOjg3yfgUqD22vy
 Le8U8DGvoRENCH+JZAMTYuFN7OzNSdJkLwcXDar4/kjevnm+DwtUQy/dzQUe9bt6BL3IThIWPVH
 +vj9KnKGhcdcCuTJ8hXB7lQd+SKYlADeQkWNQ8qHKsivVdu4JFGjPSGfl6ckZBEnT2Tse924oMi
 ssnHC+N4NuPokdtQUUdlAMuvBVwnS0h0BKiTQ3Sb1ecuWh7vLRWpffmW3iCbFq5VZ5B9qw2uOgk
 APiAT+hQn8iiLMt2x+PGMfo80+jPG68Uz7F+AJIRrqE3sgOEYtRRNgdHg9/JWFJakZBe3DTkwpj
 +9cxcrTUUgdwpjCsr963Vjh2Ig7cUwvVPXzbqpFAvMbvBO0UUQq80hJtwGOErMXG7gf3KrgK
X-Proofpoint-ORIG-GUID: 1wpTPFPrUUjS8u1dEymkM-ml8_KCsfYt
X-Proofpoint-GUID: 1wpTPFPrUUjS8u1dEymkM-ml8_KCsfYt
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685bf691 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=4aWnE0LmemOYjQLa29cA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=910 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250091
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2025-06-25 at 10:27 +0200, Kevin Wolf wrote:
> Commit bdf12f2a fixed the setter for the "loadparm" machine property,
> which gets a string from a visitor, passes it to s390_ipl_fmt_loadparm()
> and then forgot to free it. It left another instance of the same problem
> unfixed in the "loadparm" device property. Fix it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/s390x/ccw-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

