Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C5E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVcFI-0002N8-Az; Wed, 08 Jan 2025 15:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcFF-0002Mk-Tf
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:01:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcFE-0000V8-9Q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:01:37 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508DAwOV023766;
 Wed, 8 Jan 2025 20:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3Ig29D
 ZdBipUErEHNhSaHtnqgP27qJwuQklG1G86lDo=; b=lp9Qk050RFnEyrWd2NFZgh
 2MJVRgH5SPYNm2HdPwL1m9ztS1uKPa4lZf6zRm343XAct2rHl6rbTzrMqJal6Y7N
 IYL+b6+azSXTnKWFux5IPtdYg39NPgit55ROjatc1edmHlQNHzmDmnTYohSGc2mD
 WrRL6eIWhVafeNNWGlpUG0GQgV9O2jFyOYkblUmY5Vvr37+EGPlyCKTm0Se0Cw8z
 zcAHpG8cBCAhDHa+7nGZShD14dvO4QW8OmWVj/C8CuZnZ6WPNJaZ3obB07dg3T1U
 vyCUlLDOg/nZPzTdap/55UCuYjuW4mLwmpjU/Ur03vdLRVjfyISN7Q/g/W8vL5Wg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj4y5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:01:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508GoeGo013663;
 Wed, 8 Jan 2025 20:01:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap1fwd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:01:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508K1THj25625162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 20:01:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28C2B20043;
 Wed,  8 Jan 2025 20:01:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6BD520040;
 Wed,  8 Jan 2025 20:01:28 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 20:01:28 +0000 (GMT)
Message-ID: <41ce9f8d17ee06a5be8a7268f86a2c79e6246e0a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] gdbstub: propagate Error to gdbserver_start (and
 other device setups)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Laurent
 Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 08 Jan 2025 21:01:28 +0100
In-Reply-To: <20250108180515.1471177-1-alex.bennee@linaro.org>
References: <20250108180515.1471177-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pq0vGJgEqJUcCUBYuvryAzNkn8L43cOm
X-Proofpoint-ORIG-GUID: Pq0vGJgEqJUcCUBYuvryAzNkn8L43cOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=579 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 2025-01-08 at 18:05 +0000, Alex Benn=C3=A9e wrote:
> This started as a clean-up to properly pass a Error handler to the
> gdbserver_start so we could do the right thing for command line and
> HMP invocations. To that end everything that used
> foreach_device_config() and failed was also an immediate exit case so
> I mechanically tweaked all the helper functions and simplified some.
>=20
> Currently an RFC, I suspect we want to rename the foreach function to
> something more pithy like foreach_device_config_or_exit().

I agree with such a rename, adding comments like /* failure will exit
via error_fatal */ everywhere is not optimal.

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0include/exec/gdbstub.h |=C2=A0 8 +++-
> =C2=A0gdbstub/system.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 +++++----=
-
> =C2=A0gdbstub/user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20=
 +++++----
> =C2=A0linux-user/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +--
> =C2=A0monitor/hmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0system/vl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 98 ++++++++++++++++------------------------
> --
> =C2=A06 files changed, 70 insertions(+), 86 deletions(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>



