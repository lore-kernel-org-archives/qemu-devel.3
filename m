Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09419ECD9A8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6vs-0005WR-Jz; Thu, 05 Feb 2026 16:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6vp-0005VW-Ql; Thu, 05 Feb 2026 16:30:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6vl-0002Y8-0N; Thu, 05 Feb 2026 16:30:32 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615JvtMl003772;
 Thu, 5 Feb 2026 21:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KwkLfg
 MSG1lhxpigIeC9zadLYx/9E3qwqtZ6XL84oqM=; b=e/LT6glilKeOWnSzT4hhHN
 OcV7ZS6cifUzoRcbP62CZIusT7EbgR70L4iK0+JaKn7/LSEtUVOsE196ZRqZzdFs
 y8sG+NUO6N8KLto+tq1fJotIEDlKyRpNJabFQaN5BGsZPEN9uuKGDkLu6r95FZ3f
 jTozkjkfJM1lkLMUsc1sufzqH53aaRKKu3Jm2FjhxDaS0k7A2j1X+AuloiH5+39i
 2i76DN/KpXm21RdnuMyv0B6w+CkML24coQNMmvLqg5H+eeahrW4hmGJwqBKJfdrp
 +FIv5t8beLMze+NtCj1FhpKT8TBL9aMI1shDt6IND6MC+CRpiFw23UtBaY//7CvA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6rx18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:30:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615JREQ3009198;
 Thu, 5 Feb 2026 21:30:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1veybn8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:30:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 615LU1B928246684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Feb 2026 21:30:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E66A5805A;
 Thu,  5 Feb 2026 21:30:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0330958051;
 Thu,  5 Feb 2026 21:30:20 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.67]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Feb 2026 21:30:19 +0000 (GMT)
Message-ID: <cc3e7f8d68212d507a189101d2f9439583b5b42c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 6/9] target/s390x: Add more unreachable KVM stubs
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Matthew Rosato	
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, David
 Hildenbrand	 <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Anton Johansson	 <anjo@rev.ng>, Richard Henderson
 <richard.henderson@linaro.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 05 Feb 2026 16:30:19 -0500
In-Reply-To: <20260204182722.44062-7-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-7-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mmSQ46wlIwVr-1GHu94xRe9fYbKbj1fN
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69850bf0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=8uOG2d9HJ2BkeSRSA20A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mmSQ46wlIwVr-1GHu94xRe9fYbKbj1fN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfXxbtHH9E4O56Y
 QKofN3NQ9oLN+2vS0P9eLwOEj+gNrilVhQXgUDJKVjYeCTv8VRT4WRHZxGqec9RREJNuEBn4Z65
 Ej1rhuxa0jiktoWEliYOmizdlbXVSLWtYhnSuJHsmiI/wcmiJ18eInVCoesSt4fgaFIGqHq/1MO
 CKgOYNHTm+FvZZiTT8oWACsuZfQvZ3gOsxE4t1wLUZUZgayqfQ8/3YTjAAFE/Csl8lhhW1lTyq7
 hIg1YBGP8U8/XjuBvfVSV8S+54xJEn75O9oy3/88NRKKonLfc1kjgkPE/dERqcCgPuFN7MLvhf1
 Rwhq5vi8GhGLUsjaORl0+gNuikWwjSZzVXnvw1bjok3ArCR05NMnWUclSKn5wI9f/pWbl9qwXG2
 ztTPpL0yu+U7ceDq9S2+WXZmkSqi9/H8dMZ9vwkIFauPYnVYLYPY0pyutBqFRmH8Vbn82CbcIDj
 mMMKOhCglUMhDkdxXsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Next patch will move s390x system objects from the target
> specific source set to the common one. Unfortunately the
> kvm_enabled() macro won't be evaluable at built-time
> anymore. Add stubs for KVM symbols unreachable at runtime.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/kvm/stubs.c | 76 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

