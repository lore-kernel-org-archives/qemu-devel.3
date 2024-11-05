Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70BED2B944
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Lxs-00060i-3W; Tue, 05 Nov 2024 10:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8Lxq-00060a-LH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:59:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8Lxo-00077y-Rr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:59:30 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5FeIJD013536;
 Tue, 5 Nov 2024 15:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Hsdld+
 N9E6cabUvfrCv0TY4uyedfekpsm/YWCjyf0+M=; b=R7fO+COMc0waZPvQmTmd23
 47WLCrWf0uWEXXpq8Wz5/Lsxp/ZQ3UZ7sKaB/eg59yshrTZuXunVyAX0CXhFvyVt
 T9SzfoOsqTKpZXCbJp9Q5MqMeXuyYLP/57UzWP/a10kUufHES1Gr5nDiJGA53vpC
 wNHS0h4awWQivgFwivPj3n46msf6ygUs+7L221deVfjkaJ5bzKw51EH62cKQVrf7
 +nsjnYZbB0msnvD4KuabsDJgjSk8aERur6gWAnZ53saLA6LIeMIcgHS3PcrN8P9e
 JMs0VbJJ5hnZE9EZyd0tGVEVC46sMvJZWQw1KT+ld7C4025WR83O3cGMwpS1h5AQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qp6x02h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 15:59:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A58NYTj012288;
 Tue, 5 Nov 2024 15:59:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140vbnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 15:59:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5FxLId21234036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 15:59:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B720120040;
 Tue,  5 Nov 2024 15:59:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD67D20049;
 Tue,  5 Nov 2024 15:59:20 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2024 15:59:20 +0000 (GMT)
Message-ID: <13e848ebce3d673ad48376a3ab14bbd25356549e.camel@linux.ibm.com>
Subject: Re: [PATCH] linux-user: Fix setreuid and setregid to use direct
 syscalls
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Helge Deller <deller@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Riku Voipio
 <riku.voipio@linaro.org>, qemu-devel@nongnu.org
Date: Tue, 05 Nov 2024 16:59:20 +0100
In-Reply-To: <Zyo2jMKqq8hG8Pkz@p100>
References: <Zyo2jMKqq8hG8Pkz@p100>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J9lYoR72SX7MuSEJurNm5gI-nG8StnG6
X-Proofpoint-GUID: J9lYoR72SX7MuSEJurNm5gI-nG8StnG6
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=675
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050121
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

On Tue, 2024-11-05 at 16:15 +0100, Helge Deller wrote:
> The commit fd6f7798ac30 ("linux-user: Use direct syscalls for
> setuid(),
> etc") added direct syscall wrappers for setuid(), setgid(), etc since
> the
> system calls have different semantics than the libc functions.
>=20
> Add and use the corresponding wrappers for setreuid and setregid
> which
> were missed in that commit.
>=20
> This fixes the build of the debian package of the uid_wrapper library
> (https://cwrap.org/uid_wrapper.html) when running linux-user.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

I should've checked the other syscalls when fixing setgroups recently.
Seems like with this patch, linux-user will no longer call glibc
functions that use INLINE_SETXID_SYSCALL().

