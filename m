Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AD7D42BBF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvYP-0001Ea-K7; Tue, 12 Nov 2024 13:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tAvYM-0001D3-It
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:23:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tAvYI-0003IP-J2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:23:48 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACIAPV4028085;
 Tue, 12 Nov 2024 18:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E+UyhZ
 63WJDcVRCiEeSdFE7Ystc+gJHlypql91UTYLk=; b=ge4ibZc1DzClIkzZDDlm+J
 Ff6UMjzmAbHUZZmPnAjBC9CcvZFVzmMrmh6aTFl21VLdAWUPCUGjWanj24f3HFby
 HUlBpT+0J28C6J+UDRiAlGnPghIAqc1yEe8CrndI25WQYFDQlQv0aPzUngf0I7hN
 LzALZl3XlDVpGsssIUrvSJxZmKqBygECtF4iumqR7ivldZYyrU6eB42AUE0Okix8
 tk9c3l+y1AY8FrJK3vePhglpE6xqPVcQqpusFC7u3+Yu5usH/HSkY/KeDlBNJegN
 +/PLoqvSlU7+iIlcU9tiJCORFYVeL5ZCFg8GmVa1qvfJ2GEBX+bLMNjI6bQKv/dw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vc2901r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 18:23:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACHZ20Y029698;
 Tue, 12 Nov 2024 18:23:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjkuu4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 18:23:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACINcqB54460766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 18:23:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33C122004D;
 Tue, 12 Nov 2024 18:23:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D6FF20043;
 Tue, 12 Nov 2024 18:23:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 18:23:37 +0000 (GMT)
Message-ID: <c741c9d92729ef51334fd50bd014796f983789e9.camel@linux.ibm.com>
Subject: Ping: [PATCH v2] tests/tcg: Stop using exit() in the gdbstub testcases
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Gustavo
 Romero <gustavo.romero@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Date: Tue, 12 Nov 2024 19:23:36 +0100
In-Reply-To: <20241022113939.19989-1-iii@linux.ibm.com>
References: <20241022113939.19989-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m70zxgPTbmBH5xty9zM1icb-tWA-aeIq
X-Proofpoint-ORIG-GUID: m70zxgPTbmBH5xty9zM1icb-tWA-aeIq
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120145
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

On Tue, 2024-10-22 at 13:37 +0200, Ilya Leoshkevich wrote:
> GDB 15 does not like exit() anymore:
>=20
> =C2=A0=C2=A0=C2=A0 (gdb) python exit(0)
> =C2=A0=C2=A0=C2=A0 Python Exception <class 'SystemExit'>: 0
> =C2=A0=C2=A0=C2=A0 Error occurred in Python: 0
>=20
> Use the GDB's own exit command, like it's already done in a couple
> places, everywhere. This is the same fix as commit 93a3048dcf45
> ("tests: Gently exit from GDB when tests complete"), but applied to
> more places.
>=20
> Acked-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1:
> https://lore.kernel.org/qemu-devel/20241021150153.487057-1-iii@linux.ibm.=
com/
> v1 -> v2: Mention 93a3048dcf45 (Peter, Gustavo, Philippe).
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Collect A-b and R-=
b.
>=20
> =C2=A0tests/guest-debug/test_gdbstub.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++=
++++---
> -
> =C2=A0tests/tcg/multiarch/gdbstub/interrupt.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0tests/tcg/multiarch/gdbstub/prot-none.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0tests/tcg/multiarch/gdbstub/test-proc-mappings.py |=C2=A0 4 ++--
> =C2=A04 files changed, 16 insertions(+), 10 deletions(-)

Hello,

I would like to ping this fix, and also the s390x FMA NaN fix
series [1].

Best regards,
Ilya

[1]
https://lore.kernel.org/qemu-devel/20241023000147.34035-1-iii@linux.ibm.com/

