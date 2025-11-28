Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF61AD116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 17:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP2EF-0003R7-DM; Fri, 28 Nov 2025 12:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vP2E4-0003Oc-7Y; Fri, 28 Nov 2025 12:25:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vP2E2-0002lG-1g; Fri, 28 Nov 2025 12:25:43 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS936kh012028;
 Fri, 28 Nov 2025 17:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6baC0E
 mwzuGpa4di08UxiAgfdt7DyGm7GSwVLWzrlFY=; b=M7uM+uj9M8jfgwM4Y2D56Z
 LIxUsKrGBbCG4LqIkqhDYczEGrBYkpIOo7EYnHVh3eLuf13eQlYicr9npJW0S8iq
 vaZ6kxs03ZRvoF3l5tWSELxo4jqGW+CZT2IYrbLwt539Xq8sdhiOdVlVryJb/dKO
 30mIjnlh7hBTdawkSPdtIK5K7DLz1iFfarlLnjCOhlNYBKOHZ/0zRVktwdKx1jA3
 4n8YOox6+TQRGzkLzUywbBVA8i2Jp5niBLywO6Zq717D6NvOfTtzQ4GaLVrgncmw
 Y0K4m4SwyO4r7+T4XfxreX0fxSImVYplkTubTy9qURTGirgC0NwvK++/kucCa95g
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kkdqw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Nov 2025 17:25:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASGeDqu014286;
 Fri, 28 Nov 2025 17:25:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgnp364-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Nov 2025 17:25:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5ASHPbvl28246640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Nov 2025 17:25:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F1A92004B;
 Fri, 28 Nov 2025 17:25:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07B7E20043;
 Fri, 28 Nov 2025 17:25:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.1.154])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Nov 2025 17:25:36 +0000 (GMT)
Message-ID: <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Date: Fri, 28 Nov 2025 18:25:36 +0100
In-Reply-To: <20251128133949.181828-1-thuth@redhat.com>
References: <20251128133949.181828-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pJF_CFevjZLuN80vBi2_lQurbPTlgnjk
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=6929db13 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=IiOegyf4PpqN7GcWN-cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pJF_CFevjZLuN80vBi2_lQurbPTlgnjk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX81vZG6wlhCGk
 K+BdxP13Szc2pktqC3YNt0pVrm9NtACAD/l5n6G1iaKCoD525xmCJF7i67Bt5XTR7EyEHW0YMRj
 oTMYn0kO5kjBfdY+FEXV8NlUiBMUj5oVurHF54tXP8LOVzPvH+bN8HadY/jXXbMuNWTZJlz2EIE
 DsCXy25V3dEZC/KElTKaapR+f8HN2G/28aeUF7TdtmGcHT9LZFkYm8TGBf3WUCrTI91itZzfAPD
 9Fx9LDVUDrlxh5UDKi1bX+PvFUT8DLWXaoORYXWjpovDZkmEi1HNoKGIrZAMkX/yMIy5IkBYGJa
 vtb97MmtjI4qPmOqwbqDVvJkTZVKghoiURGW7QIMnwmR2BKpqC6CxbO37LPcgJVlHGxQdqjVpp5
 EV4KL8plhXO53COo8cOINDa+Us6UoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> We just have to make sure that we can set the endianness to big
> endian,
> then we can also run this test on s390x.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0Marked as RFC since it depends on the fix for this bug (so it canno=
t
> =C2=A0be merged yet):
> =C2=A0
> https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-218212818891@r=
edhat.com
> /
>=20
> =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 +++-
> =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
> ++++++++++++++++++++
> =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
> =C2=A0create mode 100755 tests/functional/s390x/test_reverse_debug.py

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


I have a simple fix which helps with your original report, but not
with this test. I'm still investigating.

--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -52,6 +52,14 @@ static int cpu_pre_save(void *opaque)
         kvm_s390_vcpu_interrupt_pre_save(cpu);
     }
=20
+    if (tcg_enabled()) {
+        /*
+         * Ensure symmetry with cpu_post_load() with respect to
+         * CHECKPOINT_CLOCK_VIRTUAL.
+         */
+        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
+    }
+
     return 0;
 }

