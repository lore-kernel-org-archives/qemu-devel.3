Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8B5C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 16:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyCMG-0000om-I5; Fri, 28 Mar 2025 12:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tyCM5-0000ni-FP; Fri, 28 Mar 2025 12:14:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1tyCM2-0005Tf-GH; Fri, 28 Mar 2025 12:14:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SCRuoJ011179;
 Fri, 28 Mar 2025 16:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RHDZXk
 4BKNFCQ9WAa8i9qag5x/ll1/870SqJIvG4AUI=; b=sZuKOaPWMQYEkwaaqcFzZd
 5jpXP76WYiawKEmrVqNcDilYocgg1+n6pgd2ZsSA5TbWcv3VKDJX4t8kQNJ/D7AK
 2RhgwsIGQxyPwpBauFnBBiDRhI/996NL9XYRN3skV2CmAVF/Uuz5mG4xdc29cqUl
 gjUS0EFOlN/ccJrM2hi7VBBk94+zsCV2pFTqbAAAFFZ26TJl9vtLGquP3b3nEfIW
 1DU7wyllMcKI8gq2j9+ly2UcooRdVQ1tqyfNvtPDeiWoBAXrDAS7YZvvIAap0fSY
 +y0CC3b/JqNXVrwIj2PA34A8zR16jKdFtc2jZse2H5OkaWCm/okMzL7sk8Qeobsw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nut2h6rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 16:14:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52SGBNP4031016;
 Fri, 28 Mar 2025 16:14:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45nut2h6re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 16:14:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52SEDDi2009694;
 Fri, 28 Mar 2025 16:14:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rm2x04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Mar 2025 16:14:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52SGEIp159638028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Mar 2025 16:14:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAFD820040;
 Fri, 28 Mar 2025 16:14:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2FE92004B;
 Fri, 28 Mar 2025 16:14:17 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.171.51.25]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Mar 2025 16:14:17 +0000 (GMT)
Message-ID: <d3f978823d97b329993f9374422ea4effdd8eae4.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/functional: Remove semicolons at the end of lines
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, Niek Linnenbank
 <nieklinnenbank@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Date: Fri, 28 Mar 2025 17:14:17 +0100
In-Reply-To: <20250327201305.996241-1-thuth@redhat.com>
References: <20250327201305.996241-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zfvsikr9uEtEKouFlrW8MJr63R8qiH4L
X-Proofpoint-GUID: uugSM969TBSxLUMZUA6RB4vtWp4VsmzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_08,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=827
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503280111
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2025-03-27 at 21:13 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> Yes, we are all C coders who try to write Python code for testing...
> but still, let's better avoid semicolons at the end of the lines
> to keep "pylint" happy!
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

[...]

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

