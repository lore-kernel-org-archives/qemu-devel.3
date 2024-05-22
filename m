Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4897C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 20:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9srg-0000u4-56; Wed, 22 May 2024 16:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1s9srZ-0000td-IV; Wed, 22 May 2024 16:47:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1s9srV-0004NA-SZ; Wed, 22 May 2024 16:47:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MJqiEB014023; Wed, 22 May 2024 20:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1PtpkeMyCTIeC2nLrDkzNCNlA58W/N5kbhbo/vva/ow=;
 b=ZqqPSoGcjvK3QR8Q8pwso4haSGSaTpk3OWT8hshNM+CjKRE2JsXWjq0maTcBEXU4MwY+
 3hEaGzJ1iBN6Sn1yucEohimrBRXdjD7QwMF7641Nm8b6ROesjhr0UK6pDPlj+/bf5OcC
 6gHCjniQ2bQcb/CfJeMXZfJtWPYy3vTYrsIv1zbQRby8SMPLdUeYDwwx400b/vDBwlnW
 YiRD+P8nganouy8ZErOu6otyRVasKA2grB9jphLOLpUOP3sS9ZX8Y7s566vMRXKdT7vB
 inqwP9URUO+zBpI2e+YDv0/04p7EhMoklPoUeSB6k+tE6FGPZP8X+g7XJ1MPca95P5EV 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9q85r3ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 20:46:58 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MKkvnE028555;
 Wed, 22 May 2024 20:46:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9q85r3rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 20:46:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MHVMLS026447; Wed, 22 May 2024 20:46:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y785mnx77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 20:46:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44MKkq9O46858714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2024 20:46:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FB4420043;
 Wed, 22 May 2024 20:46:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B4E320040;
 Wed, 22 May 2024 20:46:52 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 May 2024 20:46:52 +0000 (GMT)
Message-ID: <08ad6fe68c7b96ee36527ea740e89c8e54b57c5d.camel@linux.ibm.com>
Subject: Re: [PATCH 01/14] target/s390x: Do not use unwind for
 per_check_exception
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, david@redhat.com, thuth@redhat.com
Date: Wed, 22 May 2024 22:46:51 +0200
In-Reply-To: <20240502054417.234340-2-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
 <20240502054417.234340-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NgfNsvRM3ML6IcnU71RDpNhhnYEfLISH
X-Proofpoint-GUID: rPFZJP8ta2v4SuWWJzO6WeOEx5BqcgV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_11,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=529 impostorscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 2024-05-01 at 22:44 -0700, Richard Henderson wrote:
> Using exception unwind via tcg_s390_program_interrupt,
> we discard the current value of psw.addr, which discards
> the result of a branch.
>=20
> Pass in the address of the next instruction, which may
> not be sequential.=C2=A0 Pass in ilen, which we would have
> gotten from unwind and is passed to the exception handler.
> Sync cc_op before the call, which we would have gotten
> from unwind.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0target/s390x/helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0target/s390x/tcg/excp_helper.c |=C2=A0 2 +-
> =C2=A0target/s390x/tcg/misc_helper.c | 23 ++++++++++++++++++++---
> =C2=A0target/s390x/tcg/translate.c=C2=A0=C2=A0 | 13 +++++++------
> =C2=A04 files changed, 29 insertions(+), 11 deletions(-)

IIUC this fixes the contents of old PSW so that it matches the
following wording from PoP:

  When a PER interruption is caused by branch-
  ing, the PER address identifies the branch
  instruction (or execute-type instruction, as appro-
  priate), whereas the old PSW points to the next
  instruction to be executed.

whereas currently old PSW =3D unwind(GETPC()) =3D branch instruction.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

