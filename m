Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88098D17129
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 19:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2y8N-0006Pi-1G; Mon, 21 Oct 2024 15:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t2y8K-0006PT-RY
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:32:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t2y8I-00008n-J7
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 15:32:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDm3WB002383;
 Mon, 21 Oct 2024 19:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VzFRvg
 avEHHR/fooFO0yReuqwqVDIULKsuIJJxSXjEo=; b=exWyd8Fsqyx0rsW9ZJTccH
 FmoFMe4XVoI4dqpixsP7c4TT0esJsjai+CNk1IHfP5FC/oBqwjzjwFuUb+UxSBlp
 L2i6FoApPENOHcXhK0SYmLYZpdre02KySHW5wVxIWZVxURE6KZSSr8k9xrnC9H6C
 IIxq/4kew4OqTpMbMAedTijk7G2AxJ0Lft6b8RdnA24a7fraT7KQXo9gF7A79zSY
 3y6ND57MZiBlRTQyVxc1+zKWTGodsZl92xxMGY4zCUimFWwFxyRq08lyIh3Znmy/
 LjP47rDPSaipQJU0Hr9IOjw4OfgkNUJHvmX+hlZRABit3S4tCTxLXPMvW2aPt8vA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmb5j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 19:31:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGwfIR023829;
 Mon, 21 Oct 2024 19:31:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cst0ymsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Oct 2024 19:31:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49LJVtBd53477724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2024 19:31:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BFA020043;
 Mon, 21 Oct 2024 19:31:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EA7820040;
 Mon, 21 Oct 2024 19:31:54 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2024 19:31:54 +0000 (GMT)
Message-ID: <cd561063296a9e42053d7e1c07cf49617938466a.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: Stop using exit() in the gdbstub testcases
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Gustavo Romero <gustavo.romero@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Mon, 21 Oct 2024 21:31:53 +0200
In-Reply-To: <e22adb4e-86a2-43aa-a9f4-2e9f40bb4d87@linaro.org>
References: <20241021150153.487057-1-iii@linux.ibm.com>
 <CAFEAcA9W6Fb-gvCx268xV+CV7LyWJwCQGqkKFpGQjdT+WiAEUQ@mail.gmail.com>
 <e22adb4e-86a2-43aa-a9f4-2e9f40bb4d87@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OxBRv9ex2dguasFK6DyTwXD9Tc1rHbuU
X-Proofpoint-GUID: OxBRv9ex2dguasFK6DyTwXD9Tc1rHbuU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 2024-10-21 at 16:08 -0300, Gustavo Romero wrote:
> Hi,
>=20
> On 10/21/24 12:08, Peter Maydell wrote:
> > On Mon, 21 Oct 2024 at 16:02, Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >=20
> > > GDB 15 does not like exit() anymore:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 (gdb) python exit(0)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 Python Exception <class 'SystemExit'>: 0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 Error occurred in Python: 0
> > >=20
> > > Use the GDB's own exit command, like it's already done in a
> > > couple
> > > places, everywhere.
> >=20
> > This is the same bug that commit 93a3048dcf4565 is
> > fixing, but it looks like we didn't catch everywhere.
>=20
> Yep.
>=20
> So maybe now change in test_gdbstub.py this line:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 gdb.execute(f"exit {fail_count}")
>=20
> to use the new gdb_exit()?

Thanks for taking a look! I think I'm already doing this here?

@@ -62,4 +68,4 @@ def main(test, expected_arch=3DNone):
         pass
=20
     print("All tests complete: {} failures".format(fail_count))
-    gdb.execute(f"exit {fail_count}")
+    gdb_exit(fail_count)

> BTW, last news from this issue is that it seems to be fixed
> in GDB 15.2 [0] (I haven't tried it). However, the fix using
> gdb.exit(n) is still correct.

Interesting, I didn't realize this was a bug and not a design
change. Still, given that the buggy GDBs are out there, I'd prefer to
have this change.

> Acked-by: Gustavo Romero <gustavo.romero@linaro.org>
>=20
>=20
> Cheers,
> Gustavo
>=20
> [0] https://sourceware.org/bugzilla/show_bug.cgi?id=3D31946


