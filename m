Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7787C46CD2
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSq2m-0001yI-Jv; Wed, 24 Jan 2024 22:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rSq2k-0001wW-TQ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:04:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rSq2i-0004e3-Ms
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:04:42 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40P2gOHe007880; Thu, 25 Jan 2024 03:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zX3eajORneZ+i+d/3wnbNiXSZaw7uVQiUa5q6xik00c=;
 b=V/QM4xAb113twfuY6DeJSnLqd/aBAPPJwxeafmwC/hzpDcxZCNfQV+bA3Sz2zlKmLLKj
 U+tBRr+6nXoqyjIjs2Q9k8Wr8ZOZbnI7GG8VmMEoVAVw++7zQvg3FnKWyZk5NWAutbQ2
 7lwbi1F/r1rUrMdVY2g+JZ3PJiSr+iLIKwCVoBBbIRvbEVLNDH7luX4b3u2Cz9oAnPLt
 TRko6B8SMbpboPMOrMfKYlIfxnKoaMzZ2uDZKzmp8qBEHJTVaTNSsEaX2S8RVXbW7Rvq
 /x2jw9RFwk9mq4c8JpMgpxte9k1MUHvWFh9Vs1+erzy+2mHHtRq4bJgTX2S56FeRwaBt AA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuf3arbw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 03:04:37 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40P2oXOq025241;
 Thu, 25 Jan 2024 03:04:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vuf3arbvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 03:04:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40P2eCLZ022438; Thu, 25 Jan 2024 03:04:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0m9rs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jan 2024 03:04:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40P34XUC8323636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jan 2024 03:04:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FB9C2004B;
 Thu, 25 Jan 2024 03:04:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A9AD20043;
 Thu, 25 Jan 2024 03:04:33 +0000 (GMT)
Received: from [9.179.10.76] (unknown [9.179.10.76])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jan 2024 03:04:33 +0000 (GMT)
Message-ID: <3e32f06d1f4b35c3b5c67434593f466995a38c87.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/4] accel/tcg: Move perf and debuginfo support to tcg
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Date: Thu, 25 Jan 2024 04:04:32 +0100
In-Reply-To: <3aad97e2-7a2d-4629-bca2-0e5a0f439082@linaro.org>
References: <20240124075609.14756-1-philmd@linaro.org>
 <20240124075609.14756-5-philmd@linaro.org>
 <3aad97e2-7a2d-4629-bca2-0e5a0f439082@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q3Hco0Yv9cxQuokORVSarfgri8ptdqFT
X-Proofpoint-ORIG-GUID: W7AkzegcoFM0mOjKwcrE1DeI6lZ2GqVA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=975
 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 2024-01-25 at 07:11 +1000, Richard Henderson wrote:
> On 1/24/24 17:56, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Ilya Leoshkevich <iii@linux.ibm.com>
> >=20
> > tcg/ should not depend on accel/tcg/, but perf and debuginfo
> > support provided by the latter are being used by tcg/tcg.c.
> >=20
> > Since that's the only user, move both to tcg/.
> >=20
> > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Message-ID: <20231208003754.3688038-5-iii@linux.ibm.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > =C2=A0 {accel/tcg =3D> tcg}/debuginfo.h | 4 ++--
> > =C2=A0 {accel/tcg =3D> tcg}/perf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++=
--
>=20
> Headers should be in include/tcg/.
>=20
> > --- a/accel/tcg/translate-all.c
> > +++ b/accel/tcg/translate-all.c
> > @@ -63,7 +63,7 @@
> > =C2=A0 #include "tb-context.h"
> > =C2=A0 #include "internal-common.h"
> > =C2=A0 #include "internal-target.h"
> > -#include "perf.h"
> > +#include "tcg/perf.h"
>=20
> Since it is used from accel/tcg/,
>=20
> > =C2=A0 #include "tcg/insn-start-words.h"
> > =C2=A0=20
> > =C2=A0 TBContext tb_ctx;
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index e7a9b3775b..b8e52f3fb0 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -62,7 +62,7 @@
> > =C2=A0 #include "hw/boards.h"
> > =C2=A0 #include "qemu/cutils.h"
> > =C2=A0 #include "sysemu/runstate.h"
> > -#include "accel/tcg/debuginfo.h"
> > +#include "tcg/debuginfo.h"
>=20
> ... and hw/core/.
>=20
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> r~

Can it be that this is the rebased v3?
v4 seems to have these issues fixed:

https://patchew.org/QEMU/20231212003837.64090-1-iii@linux.ibm.com/

