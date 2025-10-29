Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B359CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2vD-0006wX-Dz; Wed, 29 Oct 2025 05:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vE2ug-0006Qc-6Q; Wed, 29 Oct 2025 05:56:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vE2uX-000350-FW; Wed, 29 Oct 2025 05:56:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJlmpj003296;
 Wed, 29 Oct 2025 09:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vjAEIH
 Y3zJIBeHzcA92ZpkDHQAS80XPWzPwevgz/ykw=; b=ETbsdrbm04nHKrq5mNKmGh
 dPq6ckUSFjoan779SomuYIvkehCzzHqYmr7+RJpTj4EZ+xvBzWmT8H9dyUP8PCOx
 u3gsxLGUTgaU83/Xp4YtoBOwwFXJjlN7F72fjmKg+CJLHO6fQ7S9g2pRDnac7tUR
 ONV4tsR/bqJVye6ECRAuwSk0h8Ouv+KFopV3siN/VmvmJku95kYt6nvzNkcbFaxP
 r/+8wv41puhWBy4ttwNL7IoqrT5gHURrlzuc7ByDZCaYu9fcsVgO+2KNVcDrROjL
 KHDEN7+HYPDY2PVpr2N3/hcar28yb7edZ589t1tYFT+nAqpK7WNPzISRmnLweK2A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8jmn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 09:55:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T9kFsf023869;
 Wed, 29 Oct 2025 09:55:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx2nn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 09:55:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59T9ttvE53019028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 09:55:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB6920040;
 Wed, 29 Oct 2025 09:55:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBE6E2004E;
 Wed, 29 Oct 2025 09:55:54 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.92.117])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 09:55:54 +0000 (GMT)
Message-ID: <f27dace00e0e89c5b16ac555f92c976575d0c4ab.camel@linux.ibm.com>
Subject: Re: [PATCH PING v4 0/3] target/s390x: Fix missing clock-comparator
 interrupts
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Wed, 29 Oct 2025 10:55:54 +0100
In-Reply-To: <20251016175954.41153-1-iii@linux.ibm.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6901e4ae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=OyG4toH0xf4vRMlkUQMA:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: xNu8Q5dFpyAUqlt7J_FXl5eFx7mI6Vmu
X-Proofpoint-ORIG-GUID: xNu8Q5dFpyAUqlt7J_FXl5eFx7mI6Vmu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX3PG8tn8rhp/X
 CSXWdEmM2cufRfhJZRxnq8fYQR9Qq8Em/POZPRXY3wG4zLRgUJLaENSr7zrK3JvdE19Jo1/tfmm
 lwWJ77tTZZgX+hKXv0WPLdIIC4Tlgh2aNq5Cbm7zhwlZZ4WmzdzHSTJfWDgPvuA4qSW5As3Fpsf
 SbwiSWS+Gi3WhxuO5bK2ImMtnfLFHfnPI4Lz1YMlmHYg0rufbHZnW2qdEbCVe94JMe8Xu1vdhCd
 Jp0ejYQZ9wQM8aLiJ6IafPV/NwOJlT5UyfAT+32KgPc0szf8rQa9WPwtZromphh4fXdJbGF1+uS
 +noLLhhMgWe2RaVKC5CSM6eKYyusAcqH1A2FSB4DvaHLl9ZMNxX2EMyuKT4Wogeja+2xuiVWsRP
 nLdW1YhdGsylqGlPHUimgBf82dsUNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 2025-10-16 at 19:58 +0200, Ilya Leoshkevich wrote:
> v3:
> https://lore.kernel.org/qemu-devel/20251016120928.22467-1-iii@linux.ibm.c=
om/
> v3 -> v4: Add a patch for the missing address generation affecting
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts. Slight=
ly adjust the test, keep Thomas' R-b.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add Thomas' R-b to=
 the timer rearm fix.
>=20
> v2:
> https://lore.kernel.org/qemu-devel/20251015142141.3238-1-iii@linux.ibm.co=
m/
> v2 -> v3: Rearm the timer on control register load (Thomas).
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Add Thomas' R-b to=
 the test.
>=20
> v1:
> https://lore.kernel.org/qemu-devel/20251014160743.398093-1-iii@linux.ibm.=
com/
> v1 -> v2: Add Thomas' R-b.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cc: stable (Michae=
l).
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Improve formatting=
, commit messages, and test (Ilya).
>=20
> Hi,
>=20
> While trying to reproduce [1], I found two bugs in the clock
> comparator
> handling. This series fixes all three issues and adds a test.
>=20
> [1]
> https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.d=
e/
>=20
> Best regards,
> Ilya
>=20
> Ilya Leoshkevich (4):
> =C2=A0 target/s390x: Fix missing interrupts for small CKC values
> =C2=A0 target/s390x: Fix missing clock-comparator interrupts after reset
> =C2=A0 target/s390x: Use address generation for register branch targets
> =C2=A0 tests/tcg/s390x: Test SET CLOCK COMPARATOR
>=20
> =C2=A0target/s390x/tcg/mem_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 11 ++++-
> =C2=A0target/s390x/tcg/misc_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 12 +++--
> =C2=A0target/s390x/tcg/translate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++--
> =C2=A0tests/tcg/s390x/Makefile.softmmu-target |=C2=A0 1 +
> =C2=A0tests/tcg/s390x/sckc.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 63
> +++++++++++++++++++++++++
> =C2=A05 files changed, 89 insertions(+), 9 deletions(-)
> =C2=A0create mode 100644 tests/tcg/s390x/sckc.S

Hello,

I would like to ping this series.

Patches 1, 2, and 4 are already reviewed (thanks, Thomas!).
Patch 3 still needs a review.

Best regards,
Ilya

