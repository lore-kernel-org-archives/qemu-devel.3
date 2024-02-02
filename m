Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD544C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuYh-0005By-5l; Fri, 02 Feb 2024 09:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVuYa-0005Be-AI
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:30:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVuYX-00030E-KA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:30:16 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412DqkxO026267; Fri, 2 Feb 2024 14:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tBxLPmLGvEtNx6c9VPjEN/ez6mpDL0mYh8iNzgu5+zk=;
 b=jT7KYlUThmiztqZQYhQYiOKkV6rAl7mbmbkQQNi/aErL8GbrBadBb8Gp6F1KMRj2IdfW
 Ez7aF2HkjMBvjzk6D8c//FNSsB+bg2TTScfGMgAXRO+xUGFH6tk13UyKDGb3eD3VcLLJ
 RiKkz5KKOjiIvh2dLK7OkyNTYV4co1y04YUieHTTcKIFL+KzzwP1A9dFNb7pIHBoaAkF
 8VhvkLVab3fSZTc5ejLD9Lm9VC41zj+RqiOZ7CbvpGYzYcM/6/Rs0zGZN2Flf/b4VAme
 JbDbnRHvo0euTwsucHVG+MRMJQ2fwvkq4CtiX8SmG41BmPP5wBtQAGTIcDr/luVC2JeD Ag== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w11ng0x5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:30:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412EDl77011237; Fri, 2 Feb 2024 14:30:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwecm3g45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 14:30:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412EU5BF14615188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 14:30:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 092A52004B;
 Fri,  2 Feb 2024 14:30:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE40920040;
 Fri,  2 Feb 2024 14:30:04 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 14:30:04 +0000 (GMT)
Message-ID: <15c1169df667446df5d2fa10ed51d4ae8c6d1f56.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] gdbstub: Implement catching syscalls
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Date: Fri, 02 Feb 2024 15:30:04 +0100
In-Reply-To: <8734uckswx.fsf@draig.linaro.org>
References: <20240116094411.216665-1-iii@linux.ibm.com>
 <20240116094411.216665-2-iii@linux.ibm.com>
 <8734uckswx.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JQWNwypOukMc7X838ztgGxLSpef0Mtaf
X-Proofpoint-ORIG-GUID: JQWNwypOukMc7X838ztgGxLSpef0Mtaf
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020105
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

On Thu, 2024-02-01 at 17:15 +0000, Alex Benn=C3=A9e wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>=20
> > GDB supports stopping on syscall entry and exit using the "catch
> > syscall" command. It relies on 3 packets, which are currently not
> > supported by QEMU:
> >=20
> > * qSupported:QCatchSyscalls+ [1]
> > * QCatchSyscalls: [2]
> > * T05syscall_entry: and T05syscall_return: [3]
> >=20
> > Implement generation and handling of these packets.
> >=20
> > [1]
> > https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Pa=
ckets.html#qSupported
> > [2]
> > https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Pa=
ckets.html#QCatchSyscalls
> > [3]
> > https://sourceware.org/gdb/current/onlinedocs/gdb.html/Stop-Reply-Packe=
ts.html
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0gdbstub/gdbstub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +++
> > =C2=A0gdbstub/internals.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0gdbstub/user-target.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 5 ++
> > =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 104
> > ++++++++++++++++++++++++++++++++++-
> > =C2=A0include/gdbstub/user.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 29 +++++++++-
> > =C2=A0include/user/syscall-trace.h |=C2=A0=C2=A0 7 ++-
> > =C2=A06 files changed, 151 insertions(+), 5 deletions(-)

[...]

> > @@ -499,3 +517,87 @@ void gdb_syscall_handling(const char
> > *syscall_packet)
> > =C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_packet(syscall_packet);
> > =C2=A0=C2=A0=C2=A0=C2=A0 gdb_handlesig(gdbserver_state.c_cpu, 0);
> > =C2=A0}
> > +
> > +static bool should_catch_syscall(int num)
> > +{
> > +=C2=A0=C2=A0=C2=A0 switch (gdbserver_user_state.catch_syscalls_state) {
> > +=C2=A0=C2=A0=C2=A0 case GDB_CATCH_SYSCALLS_NONE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > +=C2=A0=C2=A0=C2=A0 case GDB_CATCH_SYSCALLS_ALL:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > +=C2=A0=C2=A0=C2=A0 case GDB_CATCH_SYSCALLS_SELECTED:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (num < 0 || num >=3D GDB=
_NR_SYSCALLS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn test_bit(num,
> > gdbserver_user_state.catch_syscalls_mask);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +void gdb_syscall_entry(CPUState *cs, int num)
> > +{
> > +=C2=A0=C2=A0=C2=A0 char reason[32];
> > +
> > +=C2=A0=C2=A0=C2=A0 if (should_catch_syscall(num)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(reason, sizeof(rea=
son), "syscall_entry:%x;",
> > num);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_handlesig_reason(cs, gd=
b_target_sigtrap(), reason);
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +void gdb_syscall_return(CPUState *cs, int num)
> > +{
> > +=C2=A0=C2=A0=C2=A0 char reason[32];
> > +
> > +=C2=A0=C2=A0=C2=A0 if (should_catch_syscall(num)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(reason, sizeof(rea=
son), "syscall_return:%x;",
> > num);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_handlesig_reason(cs, gd=
b_target_sigtrap(), reason);
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
>=20
> I'm not super keen on re-introducing snprintf's as we've been slowly
> eradicating them from the code base. How about:
>=20
> =C2=A0=C2=A0=C2=A0 g_autoptr(GString) reason =3D g_string_printf("syscall=
_return:%x;",
> num);
> =C2=A0=C2=A0=C2=A0 gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);

Ok.

> > +
> > +void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
> > +{
> > +=C2=A0=C2=A0=C2=A0 enum GDBCatchSyscallsState catch_syscalls_state;
> > +=C2=A0=C2=A0=C2=A0 const char *param =3D get_param(params, 0)->data;
> > +=C2=A0=C2=A0=C2=A0 GDBSyscallsMask catch_syscalls_mask;
> > +=C2=A0=C2=A0=C2=A0 bool catch_syscalls_none;
> > +=C2=A0=C2=A0=C2=A0 unsigned int num;
> > +=C2=A0=C2=A0=C2=A0 const char *p;
> > +
>=20
> Perhaps a little comment:
>=20
> =C2=A0 /* terminating with 0/1 to disable/enable all */
>=20
> > +=C2=A0=C2=A0=C2=A0 catch_syscalls_none =3D strcmp(param, "0") =3D=3D 0;
> > +=C2=A0=C2=A0=C2=A0 if (catch_syscalls_none || strcmp(param, "1") =3D=
=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.catch_=
syscalls_state =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat=
ch_syscalls_none ? GDB_CATCH_SYSCALLS_NONE :
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GDB_CATCH_SYSCALLS_A=
LL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_packet("OK");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0 /* otherwise decode the following list of syscalls... */
>=20
> ?

Ok.

>=20
> > +=C2=A0=C2=A0=C2=A0 if (param[0] =3D=3D '1' && param[1] =3D=3D ';') {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 catch_syscalls_state =3D GD=
B_CATCH_SYSCALLS_SELECTED;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(catch_syscalls_mask,=
 0,
> > sizeof(catch_syscalls_mask));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (p =3D &param[2];; p++)=
 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(qemu_strtoui(p, &p, 16, &num) || (*p && *p !=3D
> > ';')) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(num >=3D GDB_NR_SYSCALLS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Fall back to reporting all syscalls. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 catch_syscalls_state =3D GDB_CATCH_SYSCALLS_ALL;
>=20
> Is this the right thing or maybe we should error because gdb sent us
> something strange? In fact you could do:

I would keep this, because the size of GDBSyscallsMask is chosen
somewhat arbitrarily, and it's nice to have a fallback. The spec allows
this:

    Note that if a syscall not in the list is reported, GDB will still
    filter the event according to its own list from all corresponding
    catch syscall commands. However, it is more efficient to only
    report the requested syscalls.=20

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qemu_str=
toui(p, &p, 16, &num) ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (*p && *p !=3D ';') ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 num >=3D GDB_NR_SYSCALLS) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gdb_put_packet("E00");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> and skip the goto err
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } e=
lse {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 set_bit(num, catch_syscalls_mask);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!*p) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Could this be in the for loop?
>=20
> =C2=A0 for(p =3D &param[2]; *p; p++)

The idea behind this is to catch the empty syscall list, which I
believe is not a valid syntax. I will add a comment.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbserver_user_state.catch_=
syscalls_state =3D
> > catch_syscalls_state;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(gdbserver_user_state=
.catch_syscalls_mask,
> > catch_syscalls_mask,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sizeof(catch_syscalls_mask));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdb_put_packet("OK");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > +err:
> > +=C2=A0=C2=A0=C2=A0 gdb_put_packet("E00");
> > +}
> > diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
> > index d392e510c59..68b6534130c 100644
> > --- a/include/gdbstub/user.h
> > +++ b/include/gdbstub/user.h
> > @@ -10,9 +10,10 @@
> > =C2=A0#define GDBSTUB_USER_H
> > =C2=A0
> > =C2=A0/**
> > - * gdb_handlesig() - yield control to gdb
> > + * gdb_handlesig_reason() - yield control to gdb
> > =C2=A0 * @cpu: CPU
> > =C2=A0 * @sig: if non-zero, the signal number which caused us to stop
> > + * @reason: stop reason for stop reply packet or NULL
> > =C2=A0 *
> > =C2=A0 * This function yields control to gdb, when a user-mode-only
> > target
> > =C2=A0 * needs to stop execution. If @sig is non-zero, then we will send
> > a
> > @@ -24,7 +25,18 @@
> > =C2=A0 * or 0 if no signal should be delivered, ie the signal that
> > caused
> > =C2=A0 * us to stop should be ignored.
> > =C2=A0 */
> > -int gdb_handlesig(CPUState *, int);
> > +int gdb_handlesig_reason(CPUState *, int, const char *);
> > +
> > +/**
> > + * gdb_handlesig() - yield control to gdb
> > + * @cpu CPU
> > + * @sig: if non-zero, the signal number which caused us to stop
> > + * @see gdb_handlesig_reason()
> > + */
> > +static inline int gdb_handlesig(CPUState *cpu, int sig)
> > +{
> > +=C2=A0=C2=A0=C2=A0 return gdb_handlesig_reason(cpu, sig, NULL);
> > +}
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * gdb_signalled() - inform remote gdb of sig exit
> > @@ -39,5 +51,18 @@ void gdb_signalled(CPUArchState *as, int sig);
> > =C2=A0 */
> > =C2=A0void gdbserver_fork(CPUState *cs);
> > =C2=A0
> > +/**
> > + * gdb_syscall_entry() - inform gdb of syscall entry and yield
> > control to it
> > + * @cs: CPU
> > + * @num: syscall number
> > + */
> > +void gdb_syscall_entry(CPUState *cs, int num);
> > +
> > +/**
> > + * gdb_syscall_entry() - inform gdb of syscall return and yield
> > control to it
> > + * @cs: CPU
> > + * @num: syscall number
> > + */
> > +void gdb_syscall_return(CPUState *cs, int num);
> > =C2=A0
> > =C2=A0#endif /* GDBSTUB_USER_H */
> > diff --git a/include/user/syscall-trace.h b/include/user/syscall-
> > trace.h
> > index 557f881a79b..b48b2b2d0ae 100644
> > --- a/include/user/syscall-trace.h
> > +++ b/include/user/syscall-trace.h
> > @@ -11,6 +11,7 @@
> > =C2=A0#define SYSCALL_TRACE_H
> > =C2=A0
> > =C2=A0#include "exec/user/abitypes.h"
> > +#include "gdbstub/user.h"
> > =C2=A0#include "qemu/plugin.h"
> > =C2=A0#include "trace/trace-root.h"
> > =C2=A0
> > @@ -20,7 +21,7 @@
> > =C2=A0 * could potentially unify the -strace code here as well.
> > =C2=A0 */
> > =C2=A0
> > -static inline void record_syscall_start(void *cpu, int num,
> > +static inline void record_syscall_start(CPUState *cpu, int num,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 abi_long arg1, abi_long
> > arg2,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 abi_long arg3, abi_long
> > arg4,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 abi_long arg5, abi_long
> > arg6,
> > @@ -29,11 +30,13 @@ static inline void record_syscall_start(void
> > *cpu, int num,
> > =C2=A0=C2=A0=C2=A0=C2=A0 qemu_plugin_vcpu_syscall(cpu, num,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg1, arg2, arg3, arg4,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg5, arg6, arg7, arg8);
> > +=C2=A0=C2=A0=C2=A0 gdb_syscall_entry(cpu, num);
> > =C2=A0}
> > =C2=A0
> > -static inline void record_syscall_return(void *cpu, int num,
> > abi_long ret)
> > +static inline void record_syscall_return(CPUState *cpu, int num,
> > abi_long ret)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
> > +=C2=A0=C2=A0=C2=A0 gdb_syscall_return(cpu, num);
>=20
> This clean-up belongs in a separate patch.

Ok.

>=20
> > =C2=A0}
>=20


