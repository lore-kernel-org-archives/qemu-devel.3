Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAD3CEFD03
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDe4-0002N0-JU; Tue, 06 Jan 2026 15:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdDe1-0002Kw-Tv; Tue, 06 Jan 2026 15:27:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vdDdz-0005Y1-PX; Tue, 06 Jan 2026 15:27:09 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606IjBMD016351;
 Tue, 6 Jan 2026 20:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cb2WxN
 LuWw2dQ63QmN3BfiF8rhlsfuGYQu9vaDnlXGE=; b=mzG32giV9LTuouNnWfCXw9
 0zT1tZ8cQScKxvV6tIrdzNQf3o8pz71SCuHprzXA+tOfbcHNZyG0FiG/RjL68C56
 68ESKDj7YeYO+35FuHull2k/4GhNe8WSw6khiKifTaunwfYQhVA2szVUQ9LEKWCz
 F7KqhI0MtLvvnnF8z1mGxtA43PgMzjAuYw2Vcj9F+5aw5yrav7iY05oxVMUESKzz
 +DMcaROYJRtEEFI/m0jjab69ELxYyQJeKcQaA7KUweiQ/QeK+B6Ia36sPaAx+kXP
 8LGaQuiUpWtPK0iwmkUBU4k2xwe+StyFpCCovFeSFuvzpfd3mAZpc120dr84iTpw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu65pww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 20:27:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606K4YMI012581;
 Tue, 6 Jan 2026 20:26:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjd94b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 20:26:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606KQvha31064666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 20:26:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E373E5805A;
 Tue,  6 Jan 2026 20:26:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F4645805D;
 Tue,  6 Jan 2026 20:26:56 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.176]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 20:26:56 +0000 (GMT)
Message-ID: <a769b0f810374aaf527aeeb8b89cae2f6ad1cade.camel@linux.ibm.com>
Subject: Re: [PATCH 0/8] target/s390x: Use explicit big-endian LD/ST API
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich	 <iii@linux.ibm.com>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Halil Pasic
 <pasic@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier	 <laurent@vivier.eu>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Farhan Ali	 <alifm@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Anton Johansson	 <anjo@rev.ng>, "Michael S. Tsirkin"
 <mst@redhat.com>
Date: Tue, 06 Jan 2026 15:26:55 -0500
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695d7014 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=panRrKRUgiQaOmd9SNUA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YGtAKjXqKzM5aI9OFvLzdLoN0hxqhz4t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3NiBTYWx0ZWRfX11nIDdD1bs64
 n0rmzmQTx73/mLjHTotNG9ph2lV1rNjLOBGDtigS1z0BG1iYXdkEHIVxwGkn5Cre0YTmV2psDsF
 UYm7mgW9zyM2bbPqZ4nrcqdQATCHYpRDi0KI1pGyzwzREobiCQXoctJ747MAnIiR7Hxhio7m2IO
 b71U5jF/QM+q2MwAXQA8zZVpznxhy3nDGrPt9QDuHgq3vo0dEKZGUIrEs83xoFD+M5VnntJzX0o
 TcyqvjQAEsIZljQJ6CjyQ5EztkzXP/fn8YVvOGt7D6A5X4A2w5tvb9luXGsHA4Zklpo6tWu/874
 lh+sLIBc0tNrjstWtFgO2TQZXSdSq8pzQKvrzTNwd74WL8wiVkSqdofya6H0LIxdSj6+ntplJS4
 KMKaieGuERmHfEE/WmDBetuP7umb+8kDvM0Bxq6dNLtmEdgOruZZMLXI068FikQBqD7YoB6Zb8Q
 F+P9vir4IMAuAJ+KC3g==
X-Proofpoint-GUID: YGtAKjXqKzM5aI9OFvLzdLoN0hxqhz4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060176
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2025-12-24 at 17:20 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> S390x is big-endian. Use the explicit 'big'
> endianness instead of the 'native' one.
> Forbid further uses of legacy APIs.
>=20
> tag: https://gitlab.com/philmd/qemu/-/tags/endian_s390x-v1
> CI: https://gitlab.com/philmd/qemu/-/pipelines/2231223066
>=20
> Philippe Mathieu-Daud=C3=A9 (8):
>   hw/s390x: Use explicit big-endian LD/ST API
>   target/s390x: Use explicit big-endian LD/ST API
>   target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
>   target/s390x: Replace MO_TE -> MO_BE
>   target/s390x: Inline cpu_ld{uw,l}_code() calls in EX opcode helper
>   target/s390x: Use big-endian variant of cpu_ld/st_data*()
>   target/s390x: Inline translator_lduw() and translator_ldl()
>   configs/targets: Forbid S390x to use legacy native endianness APIs

For the series:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
>  configs/targets/s390x-linux-user.mak |   1 +
>  configs/targets/s390x-softmmu.mak    |   1 +
>  target/s390x/tcg/insn-data.h.inc     |  54 +++++-----
>  hw/s390x/css.c                       |  24 ++---
>  hw/s390x/s390-pci-bus.c              |   4 +-
>  hw/s390x/virtio-ccw.c                |  24 ++---
>  target/s390x/cpu-system.c            |   2 +-
>  target/s390x/gdbstub.c               |  26 ++---
>  target/s390x/kvm/kvm.c               |   8 +-
>  target/s390x/mmu_helper.c            |   3 +-
>  target/s390x/tcg/excp_helper.c       |  16 +--
>  target/s390x/tcg/mem_helper.c        |  71 +++++++------
>  target/s390x/tcg/translate.c         | 144 +++++++++++++--------------
>  target/s390x/tcg/vec_helper.c        |   8 +-
>  target/s390x/tcg/translate_vx.c.inc  |  38 +++----
>  15 files changed, 215 insertions(+), 209 deletions(-)

