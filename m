Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F7D0C611
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Ko9-0007Gu-1V; Fri, 25 Oct 2024 09:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t4Ko7-0007Gg-4k; Fri, 25 Oct 2024 09:56:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t4Ko5-0005NA-9H; Fri, 25 Oct 2024 09:56:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P1vDZ4032766;
 Fri, 25 Oct 2024 13:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XDdWFE
 doyf+bDyOtm6x1DL2wTiz+trKQK15UAFaioc8=; b=fOalB/43pMo+mP4mS7OYin
 cj5iq3lHKNSYlDOzshr+wtbICrLkgkRK5xATiZBeUTZr1O06zvYisGD/v40dknta
 L7mpAOdba4Bcnz4eBffOnVPFItMPqXjuN6aqIk9GbSEOS6pFZ57v5MEDz3AHlA2/
 TCSAD/Ma/pEzCpiuB/yX11R3Km5wzbau5PuW50s7EKVBRf0DEhQ4rF8I2nlSlP8Q
 ftBlqYoJ3ZP5n+K+LDn1c9BjOOsJz+QW48Juhu/2HJzE/wUw+9h9ojEUpdU8y+0o
 2iaIS5fFpyPNEPb+Yhps4zci7hFAZRijwoOieC6GNuRygejGlAdB1KLfVkYNKeHw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g246twxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 13:56:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PATLle001542;
 Fri, 25 Oct 2024 13:56:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9nxtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 13:56:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49PDuf8d55312820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 13:56:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A2E720043;
 Fri, 25 Oct 2024 13:56:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1B4620040;
 Fri, 25 Oct 2024 13:56:39 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 13:56:39 +0000 (GMT)
Message-ID: <d86a9773348aed57d8f9759e05ea287c36364013.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] linux-user/ppc: Fix sigmask endianness issue in
 sigreturn
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
Date: Fri, 25 Oct 2024 15:56:38 +0200
In-Reply-To: <5cc9130c-5b9a-4e86-a609-9ab16d3529e0@tls.msk.ru>
References: <20241017125811.447961-1-iii@linux.ibm.com>
 <20241017125811.447961-2-iii@linux.ibm.com>
 <5cc9130c-5b9a-4e86-a609-9ab16d3529e0@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PL__AbGTmAgbpX4rZUaeCjMLLoNvFP6k
X-Proofpoint-GUID: PL__AbGTmAgbpX4rZUaeCjMLLoNvFP6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=938 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410250106
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

On Fri, 2024-10-25 at 16:53 +0300, Michael Tokarev wrote:
> 17.10.2024 15:54, Ilya Leoshkevich wrote:
> > do_setcontext() copies the target sigmask without endianness
> > handling
> > and then uses target_to_host_sigset_internal(), which expects a
> > byte-swapped one. Use target_to_host_sigset() instead.
> >=20
> > Fixes: bcd4933a23f1 ("linux-user: ppc signal handling")
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 linux-user/ppc/signal.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> > index a1d8c0bccc1..24e5a02a782 100644
> > --- a/linux-user/ppc/signal.c
> > +++ b/linux-user/ppc/signal.c
> > @@ -628,7 +628,7 @@ static int do_setcontext(struct target_ucontext
> > *ucp, CPUPPCState *env, int sig)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!lock_user_struct(VERIFY_READ, mcp, =
mcp_addr, 1))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0 target_to_host_sigset_internal(&blocked, &set);
> > +=C2=A0=C2=A0=C2=A0 target_to_host_sigset(&blocked, &set);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_sigmask(&blocked);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restore_user_regs(env, mcp, sig);
>=20
> Shouldn't this change be picked for all stable releases too?
> Yes, the issue is very old so probably does not have big impact,
> but it looks like it should be okay to fix it finally?
>=20
> I'm picking it up, please let me know if I shouldn't.
>=20
> Thanks,
>=20
> /mjt

I think it's worth taking it, since it leads to weird qemu-user
crashes. I actually intended to Cc: stable here and forgot to do it,
so thanks for bringing this up.

