Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32581C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 21:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9tag-0008O7-Tv; Wed, 22 May 2024 17:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1s9taf-0008Nu-ER; Wed, 22 May 2024 17:33:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1s9tad-0003bO-4M; Wed, 22 May 2024 17:33:41 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MJYPvQ010805; Wed, 22 May 2024 21:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IMqElwi0abLxaAl74iWOXoz/Aekb4pZ+hcxSRFDLf3A=;
 b=IIwAFG7IsFLZQqGe9Oa1TyIbZeHQBaIjCjCEtD0/X6muZ0eVnOFhKhoQaJcDTPSavMt2
 CRCGuzLG+A9B5m5uUEyz5CSbDw/qqslGW/pKE6BGc2RZ+4+Q/dTfCjND4bii6esC6w3u
 ojQ1ochvQhsa2l4VIn8pArFLjtsA7ERZeno1nq06/svFDm7ouZGDxE/BMDGJu/bZgkbB
 rhghF7HEEKfhghNhXkUrm8K9lizJFrCV0B/kf9/3rb7Wc4KW0IeI7vxOfRFui3zuctEq
 9hrMKolMaOSCkOS8KClqeSU4W/SFO9xNORLYtwR6Js1yHZEGMzSAOpEe4C92iVcgVNWL HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9pyer7sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 21:33:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MLXZIV021756;
 Wed, 22 May 2024 21:33:35 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9pyer7sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 21:33:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MJGj07007818; Wed, 22 May 2024 21:33:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c35tke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 21:33:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44MLXV6u34800334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2024 21:33:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56F3220043;
 Wed, 22 May 2024 21:33:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB8F520040;
 Wed, 22 May 2024 21:33:30 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 May 2024 21:33:30 +0000 (GMT)
Message-ID: <ada367dd66c9376b7ed8ca357f5e33ccd9fdfa29.camel@linux.ibm.com>
Subject: Re: [PATCH 04/14] target/s390x: Record separate PER bits in TB flags
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, david@redhat.com, thuth@redhat.com
Date: Wed, 22 May 2024 23:33:30 +0200
In-Reply-To: <20240502054417.234340-5-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
 <20240502054417.234340-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 36VoRUfj37iwpKQST2CJsTUEAKsbRNlv
X-Proofpoint-GUID: -x2O82dtmrlFu6EuovN3kT2M0uZcXZBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_12,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=709 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Record successful-branching, instruction-fetching, and
> store-using-real-address.=C2=A0 The other PER bits are not used
> during translation.=C2=A0 Having checked these at translation time,
> we can remove runtime tests from the helpers.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0target/s390x/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 42 ++++++++++++++++++++++++--------
> --
> =C2=A0target/s390x/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++----
> =C2=A0target/s390x/tcg/misc_helper.c | 21 +++++++----------
> =C2=A0target/s390x/tcg/translate.c=C2=A0=C2=A0 | 10 ++++----
> =C2=A04 files changed, 61 insertions(+), 34 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

