Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC52CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4ZQ-0004OR-TC; Tue, 24 Sep 2024 08:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1st4ZP-0004Ng-3b
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:23:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1st4ZM-0003Ii-SO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:23:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O0J6mZ000452;
 Tue, 24 Sep 2024 12:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 vQx+NAOxlFNX2/wrO6WP58coECFfSO8iOX+GyIXiCe4=; b=XaKI3Ybfv4zxvxtJ
 xdfxI5bcULw4lW8Ra5VOiVF/KpycLl7iXKcQGi13UwiQBBRoSJk6xchrS6hreY47
 /NT6GQR8ako9ict9b45C38TlY20CKzDaU9U9gC/QMY8gg2ivMWHlV/wUT6ZmeMUR
 FwC0tXJl8mm7cfY/aocG+gXVZroK2HyDH50yssoEG0+ptAbe4yS79gObLxJgqkIo
 e2J+LJ2DQKN4A5V2fNrx60YicD0Hcc6p7bnHEbyhORaIrW/a9i+mITeGoYhR+hUi
 /l68QTyM6+p2P6bJkYqQ92d9WmWLLDoxmdQis2o1wjVdB6R7wY7QsJ/hcCszd+mf
 ktQGzw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna9urw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2024 12:23:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48OCN1wm026340;
 Tue, 24 Sep 2024 12:23:01 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna9urk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2024 12:23:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAVpOf012507;
 Tue, 24 Sep 2024 12:23:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpuxh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2024 12:22:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48OCMwHv53150148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Sep 2024 12:22:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 022E920043;
 Tue, 24 Sep 2024 12:22:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66DEC20040;
 Tue, 24 Sep 2024 12:22:57 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Sep 2024 12:22:57 +0000 (GMT)
Message-ID: <c0d81e09bd1ce5ee49dcb48715102efe2a1dbcb8.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/docker: Fix microblaze atomics
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Mahesh
 Bodapati <mbodapat@xilinx.com>
Date: Tue, 24 Sep 2024 14:22:57 +0200
In-Reply-To: <87wmj1clmh.fsf@draig.linaro.org>
References: <20240919152308.10440-1-iii@linux.ibm.com>
 <87wmj1clmh.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ilZXJD3gwv745yua7taTYmiYaNSh6rTw
X-Proofpoint-ORIG-GUID: 71erkQ2f2Z_hLpNYSpPDf3nh1Zm_j_ho
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2024-09-24 at 12:54 +0100, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> (add Mahesh to CC)
>=20
> > GCC produces invalid code for microblaze atomics.
> >=20
> > The fix is unfortunately not upstream, so fetch it from an external
> > location and apply it locally.
>=20
> Queued to testing/next, thanks.
>=20
> However I didn't see any tests failing so I'm curious where you saw
> the
> problem? Would it be worth adding an atomics test (microblaze or
> generic) to catch this?

It's very reliably caught by the new test that I'm proposing as a part
of this series:

https://lore.kernel.org/qemu-devel/20240923162208.90745-19-iii@linux.ibm.co=
m/T/#u

>=20
> Also for the Microblaze guys is there any push to upstream the
> patches
> you have into GCC or have an easily distributively binary build we
> could
> convert our dockerfiles to?
>=20
> >=20
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0.../debian-microblaze-cross.d/build-toolchain.sh=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8
> > ++++++++
> > =C2=A0tests/docker/dockerfiles/debian-toolchain.docker=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7
> > +++++++
> > =C2=A02 files changed, 15 insertions(+)



