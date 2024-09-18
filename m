Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07FACCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 09:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqrQf-0008Dl-CZ; Wed, 18 Sep 2024 05:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sqrQd-0008Cj-1H; Wed, 18 Sep 2024 05:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sqrQb-0007VN-0g; Wed, 18 Sep 2024 05:56:54 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HJjbxi031850;
 Wed, 18 Sep 2024 09:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 nu9wanx64FU5k3I0do3V202TD2E8rqo3Vu4EhuBb7WA=; b=YmniixnjZFTVwEWF
 Qw9+kHlSOn8QUjDMjVvYFrskIuq146zNFbb49h5ZXwGLEouVS9GHAoKFcuv9lzw7
 Y+Bpg1U0hoTf5Movfy+65xheMRoXocNr0rq0sJqwJ0nZcQL09PiNu8IImV5mGBuJ
 QKW+LSv9PHJSLvQpv2kDL80lV109wDp+LCGBkJ0rOQccQNYPMbr7H/ZBLr4z6eWO
 7TqXr3a9VfXHXP0wlhRBHY19rR97VyikLZnN+Wi9uPkxcb/treTeKas8YVYqzymS
 fEZE6L8g0uz33h7SOwdADkvmTXHDXiH1ZdAV7Khhp8ujIT3UXNItaY0LDrGNMPTg
 f27QHQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ujd5s7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 09:56:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48I9um6T012866;
 Wed, 18 Sep 2024 09:56:48 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ujd5s4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 09:56:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48I8oXcO001871;
 Wed, 18 Sep 2024 09:56:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nqh3sywu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2024 09:56:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48I9ujvl44696028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2024 09:56:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B95C120049;
 Wed, 18 Sep 2024 09:56:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63D8720040;
 Wed, 18 Sep 2024 09:56:45 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2024 09:56:45 +0000 (GMT)
Message-ID: <c7416776312932df4e4c27cf040189fd098cba3c.camel@linux.ibm.com>
Subject: PING: [PATCH v2 0/2] target/ppc: Make divd[u] handler method
 decodetree compatible
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Date: Wed, 18 Sep 2024 11:56:45 +0200
In-Reply-To: <20240812085841.1583-1-iii@linux.ibm.com>
References: <20240812085841.1583-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CXTsaMgdGiLU01Jav3nQ_aYLCOKI59UT
X-Proofpoint-GUID: 5sNqpHmNzeuySJGt3mQwnT1twnKt687E
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_07,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=763 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2024-08-12 at 10:53 +0200, Ilya Leoshkevich wrote:
> v1:
> https://lore.kernel.org/qemu-devel/20240731100953.14950-1-iii@linux.ibm.c=
om/
> v1 -> v2: Add R-bs and a targeted divd[u] patch.
>=20
> Hi,
>=20
> This series contains two fixes for the same issue: divd[u] touching
> uninitialized ctx->opcode.
>=20
> Patch 1 is a catch-all solution for all issues in this class. IMHO
> it's worth having something like this until the legacy decoder is
> fully eliminated.
>=20
> Patch 2 is a targeted fix for divd[u] only.
>=20
> Best regards,
> Ilya
>=20
> Ilya Leoshkevich (2):
> =C2=A0 target/ppc: Set ctx->opcode for decode_insn32()
> =C2=A0 target/ppc: Make divd[u] handler method decodetree compatible
>=20
> =C2=A0target/ppc/translate.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)

Ping.

