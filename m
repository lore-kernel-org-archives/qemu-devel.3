Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F71D73EAA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 01:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vldex-0007W5-22; Thu, 29 Jan 2026 20:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vldev-0007VC-9O; Thu, 29 Jan 2026 20:50:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vldet-0001k6-Ls; Thu, 29 Jan 2026 20:50:53 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEtDJ5024531;
 Fri, 30 Jan 2026 01:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dj7zvB
 3OpZw6pmEXLr8tGZ/mNzbsF64b8wgevn5HPJg=; b=QTp/RQPYCjBV62vcQYjOYk
 ktPF0Hw225f7oOLxNstKwL4qG/Q+O9mz7dpVPk16vpQfDPgKF2kIdmzTQA9JfRjV
 Mgf+8pKw8Mwqr+yVXxlfgl4VfwHp51q0FYhZKxyOWKsEQXHlAu7kdJh12FQJ8LwO
 MVb2K1OiQJ4/eH8hlvEpmJ5zRrMsVys2/bJPj+XgK0ZCn75tMK2HaOZbtkUKowKT
 8cbC0Zm3fLv0A8S6AzLVMwcR8XLbepagSzYE9eiBaHy1utaHrX6C+Z4DV/2mnXXz
 qrAHUu1Dh95NNcaD4oIDE9+O7WRSQfjCu0HZNibGgqRIaCZmIH5fvVA/4/keHORw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtuqg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 01:50:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60U06Uwp019653;
 Fri, 30 Jan 2026 01:50:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dnceju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jan 2026 01:50:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60U1ojSn64225720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jan 2026 01:50:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B839658055;
 Fri, 30 Jan 2026 01:50:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC6255804B;
 Fri, 30 Jan 2026 01:50:44 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.76.202]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jan 2026 01:50:44 +0000 (GMT)
Message-ID: <9afdd5c9af9540609542814d9a583437589db4bf.camel@linux.ibm.com>
Subject: Re: [PATCH v3 06/14] include/hw/s390x: Move CLP definitions for
 easier BIOS access
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Thu, 29 Jan 2026 20:50:44 -0500
In-Reply-To: <1c899641213407613647adcc10ce1d5b10f3fce9.camel@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-7-jrossi@linux.ibm.com>
 <1c899641213407613647adcc10ce1d5b10f3fce9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 33GEq0F9DzWmJWKN1EYOyvkRERqOgn6V
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697c0e78 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=RLiWjzvH3RyVQvlK388A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 33GEq0F9DzWmJWKN1EYOyvkRERqOgn6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAxMiBTYWx0ZWRfX38GT3igzisi0
 zEBGIcwdWc8WcL4ukOewMRsVInMuz8hrHOzk/aUmUDtkQ4p4/wVEcwxm14KjV0NlwDyclB57WbX
 6uZK/7jYRakmL+kyfTKIpmtj2vDmQKPcehurmOW04hhHR+E/vR4lIV/1DPWHc7KYu22AIBU/Dc4
 4NHouyS7YRKd+U+sEYDUhSyi4cd6CVrySnVBZSl1PDY2KPaJkKsV6L+ivFC4yvsjBFqA1eqj+CN
 6ftUoISzU2fmn8u22sfvQ6vvQKm6H91vDD11/gyXbIbDMqFNne3OoYQPwKZSAwxhe3N7+s4ayiK
 JzIK1iu3rlp9rV/jpVGEcz9fiEqKP4Sb0paqsChLjITqjmGQkC+zExMibJ//1acsGDOyv9tmx48
 w+ljB4bnm4L7larBx3nEfsG3yVPGwxvU5lJamM2rQdfLIUpRbZhLm9FQnFv5NpsTf8FIcUR3N2N
 2e2BWfWhO9vgBFTrKnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300012
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

On Thu, 2026-01-29 at 16:46 -0500, Eric Farman wrote:
> On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
> > From: Jared Rossi <jrossi@linux.ibm.com>
> >=20
> > Move the s390-pci-clp definitions into the "ipl" sub-directory, which i=
s visible
> > to the s390-bios.  This allows the bios to reuse the architected defini=
tions and
> > prevents code duplication.
> >=20
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> > ---
> >  hw/s390x/s390-pci-vfio.c                  | 2 +-
> >  include/hw/s390x/{ =3D> ipl}/s390-pci-clp.h | 0
> >  include/hw/s390x/s390-pci-bus.h           | 2 +-
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> >  rename include/hw/s390x/{ =3D> ipl}/s390-pci-clp.h (100%)
>=20
> Reviewed-by: Eric Farman <farman@linux.ibm.com>

Actually, small nit that popped into my head on the drive home... Could you=
 update MAINTAINERS so
that we don't lose the PCI CLP header file from the S390 PCI group?

