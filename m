Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CD0C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 10:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzYRS-0001W3-3T; Tue, 01 Apr 2025 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tzYRO-0001VW-Js; Tue, 01 Apr 2025 06:01:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tzYRL-0004rG-MF; Tue, 01 Apr 2025 06:01:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5319lmZt012220;
 Tue, 1 Apr 2025 10:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kGumWv
 hrzQ7/TGFbJdH5Lnz6XqQizoK1UIIjgaDDUig=; b=g2h4F3Yn27PVomJ8wARCpi
 lNEVNOnm14/G5rgEsbvJBY9PQlt12KDEgyq9Znx/Gwrqeq23IVAdW4qBO1ZvKnbg
 HswE6nkRE0/uXkMhNRGknos13VPX1P9HYjXGReUvPpFlRjwfE076GbHwE5CosgrI
 pE0os0WFemzn5cxtXixt/b9PMncN6704z1ghKmLtn5bu9T9LBL2gxcVdzpd0NXp1
 QBiTu8Ko0Zs7Biojp9wRrgm5JJYeyypDiPiJfJeGOtmnbBqbBELe2JYIl7slKCSV
 MICV7C63CuLoJ4Fx4ZIXHrfO6bOLvDDZtlgHKvLv7QWzx1+3buLkzQuPqJPZjxtg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r290jvag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 10:01:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 531A0tsX008076;
 Tue, 1 Apr 2025 10:01:41 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r290jva6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 10:01:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5317GJGC019392;
 Tue, 1 Apr 2025 10:01:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6t26h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 10:01:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 531A1b4945875600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Apr 2025 10:01:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44E862005A;
 Tue,  1 Apr 2025 10:01:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94D6B2004F;
 Tue,  1 Apr 2025 10:01:35 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.109.199.128])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  1 Apr 2025 10:01:35 +0000 (GMT)
Date: Tue, 1 Apr 2025 15:31:29 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] target/ppc: Deprecate Power8E and Power8NVL
Message-ID: <fk3bm7neihwf2dkvgpw3xjdjdvds7ajxl5xy5t5ve23czxuzgm@6sh5sqglvf6z>
References: <20250329142641.2502003-1-adityag@linux.ibm.com>
 <9eca6d79-7910-43df-850a-bc55a701d964@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eca6d79-7910-43df-850a-bc55a701d964@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oh66ZhJ6OC4pcoCkTuyy1hm9l-0v8iTx
X-Proofpoint-GUID: oBhOraIg2capL7Mms5-66qLPF3xCFvMe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/03/31 08:41AM, Cédric Le Goater wrote:
> On 3/29/25 15:26, Aditya Gupta wrote:
> > Power8E and Power8NVL variants are not of much use in QEMU now, and not
> > being maintained either.
> > 
> > Newer skiboot might not be able to boot Power8NVL since skiboot v7.0
> > 
> 
> It is worth mentioning commit c5424f683ee3 ("Remove support for
> POWER8 DD1") too. In fact, I prefer the cover letter section below
> for a commit log.
> 
> This commit log is not mentioning the introduction of POWERPC_DEPRECATED_CPU.
> I suggest adding an extra patch for it.

Got it. Sure will include that mention in patch deprecating 8e/8nvl.

> 
> > Deprecate the 8E and 8NVL variants.
> > 
> > After deprecation, QEMU will print a warning like below when the
> > CPU/Chips are used:
> > 
> >      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
> >      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
> >      ...
> >      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
> >      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
> >      ...
> >      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
> >      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
> >      ...
> 
> This is not very useful and it belongs to a patch adding
> POWERPC_DEPRECATED_CPU.

Got it.

> 
> > Also, print '(deprecated)' for deprecated CPUs in 'qemu-system-ppc64
> > --cpu ?':
> > 
> >      $ ./build/qemu-system-ppc64 --cpu help
> >        ...
> >        power8e_v2.1     PVR 004b0201 (deprecated)
> >        power8e          (alias for power8e_v2.1)
> >        power8nvl_v1.0   PVR 004c0100 (deprecated)
> >        power8nvl        (alias for power8nvl_v1.0)
> >        power8_v2.0      PVR 004d0200
> >        power8           (alias for power8_v2.0)
> >        power9_v2.0      PVR 004e1200
> >        power9_v2.2      PVR 004e1202
> 
> 
> ditto.

Got it.

> 
> > Suggested-by: Cédric Le Goater <clg@kaod.org>
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > 
> > ---
> > Cover Letter
> > ============
> 
> 
> Why don't you use --cover-letter instead ? The rational would be at
> the beginning.

Sure, I will from next time. I generally write a small cover letter with
the patch for single patches, and use --cover-letter for multiple patch
series.

> 
> > Power8E and Power8NVL are not maintained, and not useful to qemu, and
> > upstream skiboot also has removed support till Power8 DD1.
> > Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
> > to be exact:
> > 
> >      commit c5424f683ee3 ("Remove support for POWER8 DD1")
> > 
> > No direct way to deprecate the pnv chips, a field like deprecation_note
> > could be added, but felt not needed as the chip will only get used if
> > the user requests corresponding 8E / 8NVL CPU, which will print
> > deprecation warning.
> > 
> > Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> > which will throw the deprecation warning. So just deprecating CPUs should
> > be enough.
> 
> Please separate the changes, one patch for POWERPC_DEPRECATED_CPU,
> another for PowerNV deprecation. More CPUs could be deprecated.

By PowerNV deprecation, you mean Power8E/8NVL CPUs right ?

Like there's no powernv8e machine as such, and powernv8e chip doesn't
have a way to deprecate. I can add a 'deprecation_note' kind of field,
but feel that is unnecessary, as it only gets used when power8e CPU is
used, which will show one deprecation warning already.

> 
> Also, we have time : the QEMU 10.1 development phase has not started
> and the soft freeze should be around July. No rush needed.

Sure, thanks for the detail

Thanks,
- Aditya G

> 
> Thanks,
> 
> C.


