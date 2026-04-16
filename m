Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4484AF8A160
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDM7D-00050O-Au; Thu, 16 Apr 2026 08:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDM79-000509-2l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:46:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDM77-0001Hr-Fp
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:46:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GAjgrC2405341; Thu, 16 Apr 2026 12:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YMUJHb
 pg37DnMsxAsxZ5Axr0cXw0H/W2S5MviRaqf0k=; b=hq8AuvK5zyLnGhzt+B4KUG
 wycA5pnpOAiaDFCagv2+Q8bnGYzdMBqwHbcR+I9QVV2uH8QmagRCdc1FrkQL9Ca1
 H6fcyph/9khu2i8CZWCd8cV7eSPirbUCjHQh1bHwCHYvROrUIxF5xahso3kzlCBx
 L8gm3KZA4shrXogTBzg3bvVzFUqG7L0BwQm8FvjyYQ5XBcDU0LxGOyJCS3wfm8F7
 Edq+PxL3WS/2kWLm0lmgxTn3N4yV0iDHT/bqUH86MLbck4nj1xCpPQme2hJ+zm4J
 Pd5u6dnqjalnT65OFdlcaJufSER3AxTOj4rNGCXbnd0ZFJ7MfHt1R2PG1DPobHQQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kchkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:46:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCEL92004175;
 Thu, 16 Apr 2026 12:46:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kjsnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:46:31 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GCkUcp22020760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 12:46:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 624545805D;
 Thu, 16 Apr 2026 12:46:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D327B58052;
 Thu, 16 Apr 2026 12:46:29 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.88.215]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 12:46:29 +0000 (GMT)
Message-ID: <06f5489cfb331d828d40d0f89de5597bb4b89a1c.camel@linux.ibm.com>
Subject: Re: [PATCH v3 01/27] stubs: Rename monitor* -> qmp* files
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Markus Armbruster	
 <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr.
 David Alan Gilbert"	 <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Apr 2026 08:46:29 -0400
In-Reply-To: <20260414003001.97571-2-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-2-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SsL_BdJiq1TPZF46INdyLElqOanSdljD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExNyBTYWx0ZWRfX0FTgoxOGWfzD
 k96k74ebHR7qHMg4ek2exzMLzkrlB6cyrPQd47ZYPzDFuVQDVzUYf0xOANkU3oHmPG8q4sSe4Xk
 G6wfqUSUWIGcTvDaMdA3d14bsb1rN0vKZhD9MVYzpMmeDf4zaUa9ZU5ykf2t0pE/nUTCIY+YtfO
 2COmS01Usk3yFFRqCR3QaX7JWj/FXoBc972zFCpznhjCjXyJPLpQ3jq4BndE66jkCjLHURXkUGs
 oGSovCQV4+tRvutQclEZtDIBqQ8lUyQFBB3RDFdRC1UuAKforo6gDjGKHiv/53svOmHVuwXzjue
 WuHzpUeKdEqVokSEuRaWfw5w9wSLsk2Xn6XGbxjBUtzETScf/cYwg07o71kxYfTjv/tdulPjQY+
 aPFPqT7/W9bi+JS2eVjqpyxuOrLjwP4DCyV9wHt5CK3XL3ZUwOh6Synm2jegJA/TAdlZqB44jsX
 j+rc+fNddrRwvyft2AA==
X-Proofpoint-ORIG-GUID: SsL_BdJiq1TPZF46INdyLElqOanSdljD
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e0da27 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=_w79pUj0oFpe7l4fBOIA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160117
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

On Tue, 2026-04-14 at 02:29 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
> These files aren't about human monitor but QMP, so rename them
> for clarity using the 'qmp-' prefix instead of 'monitor-'.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  MAINTAINERS                                      |  6 ++++++
>  stubs/{monitor-arm-gic.c =3D> qmp-arm-gic.c}       |  0
>  ...nitor-cpu-s390x-kvm.c =3D> qmp-cpu-s390x-kvm.c} |  0
>  stubs/{monitor-cpu-s390x.c =3D> qmp-cpu-s390x.c}   |  0
>  stubs/{monitor-cpu.c =3D> qmp-cpu.c}               |  0
>  stubs/{monitor-i386-rtc.c =3D> qmp-i386-rtc.c}     |  0
>  stubs/{monitor-i386-sev.c =3D> qmp-i386-sev.c}     |  0
>  stubs/{monitor-i386-sgx.c =3D> qmp-i386-sgx.c}     |  0
>  stubs/{monitor-i386-xen.c =3D> qmp-i386-xen.c}     |  0
>  stubs/meson.build                                | 16 ++++++++--------
>  10 files changed, 14 insertions(+), 8 deletions(-)
>  rename stubs/{monitor-arm-gic.c =3D> qmp-arm-gic.c} (100%)
>  rename stubs/{monitor-cpu-s390x-kvm.c =3D> qmp-cpu-s390x-kvm.c} (100%)
>  rename stubs/{monitor-cpu-s390x.c =3D> qmp-cpu-s390x.c} (100%)
>  rename stubs/{monitor-cpu.c =3D> qmp-cpu.c} (100%)
>  rename stubs/{monitor-i386-rtc.c =3D> qmp-i386-rtc.c} (100%)
>  rename stubs/{monitor-i386-sev.c =3D> qmp-i386-sev.c} (100%)
>  rename stubs/{monitor-i386-sgx.c =3D> qmp-i386-sgx.c} (100%)
>  rename stubs/{monitor-i386-xen.c =3D> qmp-i386-xen.c} (100%)

Acked-by: Eric Farman <farman@linux.ibm.com>

