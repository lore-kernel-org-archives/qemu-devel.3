Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130B2ECD9A6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6p0-0001x9-Jd; Thu, 05 Feb 2026 16:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6oy-0001wc-Q5; Thu, 05 Feb 2026 16:23:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo6ox-0001jd-9w; Thu, 05 Feb 2026 16:23:28 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61593R0S030016;
 Thu, 5 Feb 2026 21:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ih1tkF
 QGLhGSruBGvfONpF/B2jGaSQ7E0ZFQjAwRy/E=; b=brHTnlSHikC4Iz5Nh6bCtC
 J8hd9FYDVoIpusbGj7JiXLlfZThVo3d6oqeb05ST5wPib67a4aUn5kj6WQGeOepS
 bYBQE8Aj+PVnRtWdgp4vNaTdaNpGzqNgSKFGsH1ggrH2E0OVURyzpi4AEkQmiyX5
 4r61+HBT21MhCcLyovCcW4vHvo4LSAKVKJ5KORwDXAnBW/9HjSE/lj/V+1c5gXul
 JUgqeXv9tr/9MsHTKEpoVM6tpt0HwO1jsFy+1SUMMClB2NYj/ifaXoD3nCk+JdZn
 E27WBlFltlbTUBqBCCmwe/7tkxIzFJ992F83D9NfyoNV7WUxXUBDh2Brm87WXUkQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6rwb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:23:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615H8Bbo005933;
 Thu, 5 Feb 2026 21:23:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9jk9c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:23:18 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 615LNHqk32309960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Feb 2026 21:23:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 285535805D;
 Thu,  5 Feb 2026 21:23:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4429E58053;
 Thu,  5 Feb 2026 21:23:15 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.67]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Feb 2026 21:23:15 +0000 (GMT)
Message-ID: <208252b02ee6b5cd5a5ace98edd23a90e1fd7e18.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Matthew Rosato	
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, David
 Hildenbrand	 <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Anton Johansson	 <anjo@rev.ng>, Richard Henderson
 <richard.henderson@linaro.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 05 Feb 2026 16:23:14 -0500
In-Reply-To: <20260204182722.44062-2-philmd@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-2-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WANB2rr1G1lJgbTMkivgUwkuqIPECbDU
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69850a47 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=ggoZYnHCubUy7uL1hNIA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WANB2rr1G1lJgbTMkivgUwkuqIPECbDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfXytgo62o1Nw94
 9pS/a63ZzCbFHasBDDTZQseUnlKw/SL3/lOLRgK0d+zYO7OHxS0/t0Ve8SRF3w/9m1eqFw59Lpk
 fr58G0TfiCpaWGFmsT3PNjG0lQaIRMbUE2kU1OG07lBphED3WDWLsWtqiOD7WDWCoEnIhdLwktr
 V6l4ycgCsTKlfb33IxxGh3d7kBM+iwzj12Q7Spiw5+NAjVYUcrW/Xm6lJI7t3035jq4uYc2sNkJ
 wlvqX2EzwUlTUbkiPR95lVTJBKSY0G08ED8XySx55D+/iKf15tVXd93UL19WTfazkmHYnlvKt5b
 7+wYwx2dT834kgGzNVD6rHn5oKMCkrd0Kn7kXlNlrKVz2R9xgQnhLQ3C/302sj76Sq01bP3Bmq8
 k2VFzRpwIp2iYvJLXDBG3iMKGL3wtHz66htaSchNu2WG6PYE9u6Jy+/1rSxNS59XiEtmpRxmpPm
 NApfhJ7V4Vc4u2nnbOA==
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

$SUBJECT should be s/ldl/ldq/

On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> address_space_read/write() is meant for accessing random
> amount of memory blobs.  When the access size is known,
> use the address_space_ld/st() API which can directly swap
> endianness.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/s390x/mmu_helper.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

