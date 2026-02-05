Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28240ECD9A8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6ta-0004E9-FU; Thu, 05 Feb 2026 16:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6tY-0004Dt-VT; Thu, 05 Feb 2026 16:28:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6tX-0002DG-7A; Thu, 05 Feb 2026 16:28:12 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615ETrFm028582;
 Thu, 5 Feb 2026 21:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=k/jtVP
 ivlQcnRwkwqVpnt01k7ikYWiZuk2rXGv2O+wM=; b=BvRSnFptDvAX6M/5eagZuj
 7I7aDOdR5jcIocZmYIpxLDrtY4I4Ha9FjsNet6YpyhSXcA4lNEAiSi08I0AdlIVl
 t87k+/vtaDDUBxNUobB4L+wiwpfTFLlBcsw1zYqURU2Qs9Xj9N6j6RsHB1qKBALz
 sz9crtsFnqxFoXQu8KrXIlC9z1oCB3zkCv6Y/kkg6+M2NR7yT8LJnxTmrA0/C9p2
 75/I+fKLfhUrGNw86yXWhcy3B1xYPSwtBLoz6JWWDy7vCH6wfMF4aF5vA2MkZ4R1
 yD1S2IqNzKEaZWlC7cTr8i0R4xlLwDMxIlBh1FiaEbAbTo1RILkWcDxTEqnyfkig
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986rv2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:28:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615K9Gql025706;
 Thu, 5 Feb 2026 21:28:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2n3gm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:28:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 615LS4Ze22741646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Feb 2026 21:28:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37B4D5805D;
 Thu,  5 Feb 2026 21:28:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6409D58059;
 Thu,  5 Feb 2026 21:28:01 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.67]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Feb 2026 21:28:01 +0000 (GMT)
Message-ID: <6fb69264ceeff3dee08cd0f295a9ff3322212fba.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/9] target/s390x: Un-inline KVM Protected
 Virtualization stubs
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Matthew Rosato	
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, David
 Hildenbrand	 <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Anton Johansson	 <anjo@rev.ng>, Richard Henderson
 <richard.henderson@linaro.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 05 Feb 2026 16:28:00 -0500
In-Reply-To: <20260204182722.44062-6-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-6-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfX0nInJabfu0YT
 InXOJG1WiyQEM6kO2HSzHvXKknaWWBsMtI9NbysNB8xt3w9bAQSCaeA3bdhxMQm30wr7b0EiMy5
 3fa1IB5HuHirfZ1B0gCYTDZH+XIS5qYzb94ao9ac83/ieiX4diundsqU29bELSSJDpMu6uLVePb
 2KUgGyxwBCNdQeZa+p3o8I0sgVlJ+aOK3D70H5dPdouKsvz9WbxPFomM0T33Ak8CNwG61GnHtOY
 Hes3r/kYXakDyVoZZKb2MTUJjcvEZzIWVlH6rZa/JCVjm3y1/khL5JDhZ3rdWKNceozQO/sn8mx
 aKAPZW4R0o+EIrzMlyxMKuQ29BHSV1t/zJKVl/PLVkGorctI/RyRFBPQ5ljHP6S767naiVXIqEb
 mdJbRtEffVr/BzzOsUjiYFYL5SCSgp3EQgeUKxmYOZCIShsm/44kEmnY2YkS5RIBFqccJEnlYul
 IzmlZFz6rEKNZiW+d3w==
X-Proofpoint-GUID: Yl8MkwVwk_X43V8m9y7fDdJoimj36W0q
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=69850b67 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=JGbXeRc44ytq_BG_GvEA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Yl8MkwVwk_X43V8m9y7fDdJoimj36W0q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
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
> By removing the target-specific 'CONFIG_KVM' definition this
> header can be used by files in meson common_ss[].
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/s390x/kvm/pv.h    | 27 ------------
>  target/s390x/kvm/stubs.c | 94 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 27 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

