Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB76C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tptzs-0000Vr-5m; Wed, 05 Mar 2025 14:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tptz2-0000RU-7z; Wed, 05 Mar 2025 14:00:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tptyy-0008RH-VS; Wed, 05 Mar 2025 14:00:43 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525E3Bd4032416;
 Wed, 5 Mar 2025 19:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xH60vG
 NtP/vozSSxGLHObkblP4X2JFT84Na6100RxSA=; b=DagZCCvEk3ddYZCzDJnWP3
 sTe/Oro2su6rUjIBlg84cofILXydexSrmbGM6O8YV1iwVnLLWeIyAOLvvyS4FMBi
 nMJ/IDTtSW5/nNQuCJRHKce3EAFXE0fbWBLxqsV9BHrx+iamPcOJVL+7Ohze6RAw
 0tKPxpTrpSedlhPRzawDuW2GqaGevplqF3/2sQNfqq/rVqfGYuaVZO+gxceRcJ8i
 CLWM0zwsAjBn3cPh9AftlXxK/YhQwYPmeueCy2lR3TJX03ItRIKyHxXda7V+92vS
 TKaqEi+mjGzdsivVopQv8wAMiJyrREMy0toNa7Pph1+9iBe1aDlAlDp7UH59plFA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456r1psk78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 19:00:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525Hc0Wa008958;
 Wed, 5 Mar 2025 19:00:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxymhqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Mar 2025 19:00:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 525J0SRt29688504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Mar 2025 19:00:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C24EC2004F;
 Wed,  5 Mar 2025 19:00:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D58620040;
 Wed,  5 Mar 2025 19:00:28 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.48.105]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Mar 2025 19:00:28 +0000 (GMT)
Message-ID: <dd6a3b1487abdb16202d435aa1f8d8c34454b0bc.camel@linux.ibm.com>
Subject: Re: [PATCH qemu v2 2/3] hw/s390x: add SCLP event type CPI
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Shalini Chellathurai Saroja
 <shalini@linux.ibm.com>, qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Wed, 05 Mar 2025 20:00:28 +0100
In-Reply-To: <01508dbb-7ee5-4c5b-87c9-667bc296fdbf@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-2-shalini@linux.ibm.com>
 <01508dbb-7ee5-4c5b-87c9-667bc296fdbf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L98NyU96BBme4DUDitgDJQ3ti6mhcErS
X-Proofpoint-GUID: L98NyU96BBme4DUDitgDJQ3ti6mhcErS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=879 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2025-03-05 at 19:04 +0100, Thomas Huth wrote:

[...]

> > +
> > +static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_b=
uf_hdr)
> > +{
> > +    ControlProgramIdMsg *cpi =3D container_of(evt_buf_hdr, ControlProg=
ramIdMsg,
> > +                                            ebh);
> > +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(qdev_get_machine());
> > +
> > +    ascii_put(ms->cpi.system_type, (char *)cpi->data.system_type, 8);
> > +    ascii_put(ms->cpi.system_name, (char *)cpi->data.system_name, 8);
> > +    ascii_put(ms->cpi.sysplex_name, (char *)cpi->data.sysplex_name, 8)=
;
> > +    ms->cpi.system_level =3D be64_to_cpu(cpi->data.system_level);
>=20
> Can we be confident that system_level is always properly aligned?

It has offset 40 from the start of a heap allocation, so yes, but it is far
from obvious so I wouldn't mind ldq_be_p.

> Otherwise it's maybe better to use ldq_be_p() instead?
>=20
>   Thomas
>=20
>=20

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

