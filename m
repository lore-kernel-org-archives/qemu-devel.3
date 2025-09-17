Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F05CAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uytJA-0001nt-OM; Wed, 17 Sep 2025 10:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uytJ5-0001jl-Rf; Wed, 17 Sep 2025 10:38:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uytJ0-0004yU-SR; Wed, 17 Sep 2025 10:38:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HA51un024765;
 Wed, 17 Sep 2025 14:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=qNAMA3wEIUYi4aQQomqvFIWuy5L9M9lXu6JOeU4U3ZU=; b=dakeekFSbGHT
 IKTuMK9jHXGxsXhxYIpItrMSX2a0SZr0s6NqPRXdEfZNxzzgIgitAxcKnXC1NTdX
 e6TcoTsyFyhDc7TxwZqFbKjbVtuzJmo3KV/eIDsrbfNfMtdBt9kDVXKwOJ+C/5VC
 t5dDp2od0X1OjkqAdTgJDZ7k4xBVSuyFBh7o/lpSEdQCnUnc0wFEiji+lV9o0QHP
 kY6P404/hCKK0leA/z+a+Y4bPc/aNDp+IQl/Di26lNp1Z76iutKkLkaAMMv1ePLD
 ndRnw/f4ijaLKOktAhckqRQTiwv2k4dLP3B6lC5/fau0N6s2I94GGuLXFQQPexqH
 NYimmLwReQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qm3gf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 14:38:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58HE1BMQ024422;
 Wed, 17 Sep 2025 14:38:42 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qm3gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 14:38:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEVks3018821;
 Wed, 17 Sep 2025 14:38:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mhhkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 14:38:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HEceUk2884132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 14:38:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D569358050;
 Wed, 17 Sep 2025 14:38:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7022458045;
 Wed, 17 Sep 2025 14:38:40 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 14:38:40 +0000 (GMT)
Message-ID: <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
From: Miles Glenn <milesg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Date: Wed, 17 Sep 2025 09:38:40 -0500
In-Reply-To: <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
 <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
 <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2i2ElZZxxzhO9oQlyJTlpHQAGYdxd4FI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX3yKK+qBF5ked
 PqBi+lACIjkxuv3cQUZob5LR6Hxo//ZkWTrnWsGWvuHRdgpF74I3KzGhmC7OcM+XOQ/VBy0PMge
 xfVwCg/46ku01XF4plFopvaYmkHNKt82fA32n8aYvMeliWAadeMUqYQK66TnLrWSQjpccjVta2N
 QT3VF+/SCPwHTgZjSnpu5QiSxcgoDrhb6bTwP3/RONDhXirolte8u8M2uTSF1xOWUQ3L9R9qDTX
 ituCI+7r8zRsgoLYb/AUeFdYXTJTrsYKFpLENm+5WCKH4HkqQu6f34bnl/55A/nYkasaI9brbxA
 exWjyl0cqWP3K2Ai23BoURPg3dgRSDKKdRJVX2FAe/+VkOSJtIrNgHxzLeNHLoHBsnMpBEb+qiG
 wERr/D/B
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cac7f3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=jRLB2SoPAAAA:8
 a=VnNF1IyMAAAA:8 a=ec9CdHf8enWibHZLAwkA:9 a=QEXdDO2ut3YA:10
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-GUID: JhiLN_Q2sVjbhoYeAmcuTT5sHGTLfKL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2025-09-17 at 08:20 +0200, Thomas Huth wrote:
> On 17/09/2025 06.57, Harsh Prateek Bora wrote:
> > 
> > On 9/12/25 22:17, Glenn Miles wrote:
> > > Adds the following instructions exclusively for
> > > IBM PPE42 processors:
> > > 
> > >    LSKU
> > >    LCXU
> > >    STSKU
> > >    STCXU
> > >    LVD
> > >    LVDU
> > >    LVDX
> > >    STVD
> > >    STVDU
> > >    STVDX
> > >    SLVD
> > >    SRVD
> > >    CMPWBC
> > >    CMPLWBC
> > >    CMPWIBC
> > >    BNBWI
> > >    BNBW
> > >    CLRBWIBC
> > >    CLRWBC
> > >    DCBQ
> > >    RLDICL
> > >    RLDICR
> > >    RLDIMI
> > > 
> > > A PPE42 GCC compiler is available here:
> > > https://github.com/open-power/ppe42-gcc
> > > 
> > > For more information on the PPE42 processors please visit:
> > > https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
> > > 
> > > Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> > > ---
> > > Changes from v3:
> > >    - Removed copy of CHECK_VDR
> > >    - Refactored ld/st instructions
> > > 
> > >   target/ppc/insn32.decode            |  66 ++-
> > >   target/ppc/translate.c              |  29 +-
> > >   target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
> > >   3 files changed, 750 insertions(+), 10 deletions(-)
> > >   create mode 100644 target/ppc/translate/ppe-impl.c.inc
> > > 
> > 
> > <snip>
> > 
> > > diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ 
> > > ppe-impl.c.inc
> > > new file mode 100644
> > > index 0000000000..792103d7c2
> > > --- /dev/null
> > > +++ b/target/ppc/translate/ppe-impl.c.inc
> > > @@ -0,0 +1,665 @@
> > > +/*
> > > + * IBM PPE Instructions
> > > + *
> > > + * Copyright (c) 2025, IBM Corporation.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +
> > > +#if !defined(TARGET_PPC64)
> > > +static bool vdr_is_valid(uint32_t vdr)
> > > +{
> > > +    const uint32_t valid_bitmap = 0xf00003ff;
> > > +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
> > > +}
> > > +
> > > +static bool ppe_gpr_is_valid(uint32_t reg)
> > > +{
> > > +    const uint32_t valid_bitmap = 0xf00027ff;
> > > +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
> > > +}
> > > +#endif
> > > +
> > > +#define CHECK_VDR(CTX, VDR)                             \
> > > +    do {                                                \
> > > +        if (unlikely(!vdr_is_valid(VDR))) {             \
> > > +            gen_invalid(CTX);                           \
> > > +            return true;                                \
> > > +        }                                               \
> > > +    } while (0)
> > > +
> > > +#define CHECK_PPE_GPR(CTX, REG)                         \
> > > +    do {                                                \
> > > +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
> > > +            gen_invalid(CTX);                           \
> > > +            return true;                                \
> > > +        }                                               \
> > > +    } while (0)
> > > +
> > > +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
> > > +
> > > +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
> > > +    do {                                                \
> > > +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
> > > +            gen_invalid(CTX);                           \
> > > +            return true;                                \
> > > +        }                                               \
> > > +    } while (0)
> > > +
> > > +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
> > > +{
> > > +#if defined(TARGET_PPC64)
> > > +    return false;
> > > +#else
> > 
> > If we are building the PPE42 instructions only for !TARGET_PPC64, does
> > it still make it usable with qemu-system-ppc64?
> 
> As explained in an earlier thread already, qemu-system-ppc64 is a superset 
> of qemu-system-ppc. Thus the ppe42 stuff should work in qemu-system-ppc64, too.
> 
>   Thomas
> 

Ah, yes, I don't think I fully understood the ramifications of Thomas's
statements earlier.  Looks like I'll need to scrub the code to ensure
that PPE42 can run even if TARGET_PPC64 is defined.

Cedric, this requires me to change my response to your request to add
the check for TARGET_PPC64 inside the is_ppe() function.  I will need
to leave that function as-is if we want PPE42 to be supported in both
targets.  Will you be ok with that?

Thanks,

Glenn



