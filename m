Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374EFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weclL-00054O-8m; Tue, 30 Jun 2026 14:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weclE-00054A-45; Tue, 30 Jun 2026 14:00:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weclC-00023e-IE; Tue, 30 Jun 2026 14:00:39 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEJ18H2171785; Tue, 30 Jun 2026 18:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qLAv8U
 zgisPnzBxX7ZiNVAqmxsAi3ZNKQ9Z87qUYKqk=; b=kZwzvoR/DrwUWZmiarpWPF
 g3NsrivnqHd1NQKBEb3xq8zKttoiUveeY3RMq4afRTgxfHDMQMUFRR93qdhU4hSu
 QmktBa7XpvMkfB8JCjKOcraB7rSF8u/Wc45DhYSyvLKZF2LjLdu95UCnIrOHwkut
 rSePPdNZKo23HSgaQ3hPh+iGdW+r6HcM8G+XrTYlmyFgIWTfP8AvW2HEqyDEcArV
 JcwJOz0AfIeU84X+i8qzC40/Ypl6YAfhgxv+8/tYM8LYBQ4/Uf70pP98tewhbzmp
 AHy9fhKGEgjItKy88apC3btYYEX0AbgeHqEYrZ4oE0DT7YT6zCmyj4TQz/Z6R/PQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf01yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:00:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UHnnWe003552;
 Tue, 30 Jun 2026 18:00:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gbds8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:00:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UI0Otw45351236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 18:00:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9C882004B;
 Tue, 30 Jun 2026 18:00:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2495B20040;
 Tue, 30 Jun 2026 18:00:19 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.22.48])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 18:00:18 +0000 (GMT)
Message-ID: <68e984f0dbd50a97a4395158285be27af57f1d6a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] riscv/debug: migrate debug_check_breakpoint to
 use GTree breakpoints
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
Date: Tue, 30 Jun 2026 23:30:18 +0530
In-Reply-To: <7a1ac883-82d0-441a-817f-440875f71afe@linaro.org>
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
 <20260630171555.114844-3-shivangu@linux.ibm.com>
 <7a1ac883-82d0-441a-817f-440875f71afe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a44043e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ZpYWSNbrAvm0fTdKT3EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ts7yfdNlaPiOUSDhwXRoh_Qc9tdluxJB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX4cao23K5Lz7T
 2VjdWBE9lCXYwpbD2Hfyf7iex5zsuskKeGdCoGO1As119eXLhy+ebAkILL/XWZpR85SP+e4+Q+S
 2yweALmb0IS5mbej/nPwvlH1l+kVEfiPVMRnZwuFZrfoN4DmlSiIe8XjOAaXXdW4KbPPqzWC7ho
 OEr+w58gOWLn+BA4NbqzyWcO9ovZt3kVzTNQhrOK7sX8/liUm6EaBEe4SN/gP3U13Qw7dAGOnao
 GsUVjRpBDGQrF8bCgcOqh0OzsnLw1t4AXHMY/gUf7XaZOg91P0iBxPtLeDZJBeTt2DmUQu/lhxs
 7w6aYtyzpGB4S29pawYO0stn5JG03YEduDFMEWBjjiI2wObM1gPap+OpBlD5B3vq4N7/n9aW0UX
 BBRLuSlNEwgwUHo/KCM2PO7kcSYSNckd4TiHV2HfeZTDw3/dizeG6IKUepcHt7Da/+azGS+FvKb
 dYZlLqrkC1Aq0ybbgrQ==
X-Proofpoint-GUID: uUDkgLsPs98jGTr0gm3PnmPsaueQtYyp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX9gQ8wyOWh3Ey
 9jbHcuj2MmsDNx1EYQBY8nHz+3HY6rGmrWF5PuKR8sjmU8F1aBIx/YvQvkGeid4y1yZlm8poeHj
 CSVDGaVDfI0SGSXoQ8tcqe7JCFcUtWI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300170
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-06-30 at 10:33 -0700, Richard Henderson wrote:
> > =C2=A0=C2=A0 target/riscv/debug.c | 71 +++++++++++++++++++++++++-------=
------
> > ------
> > =C2=A0=C2=A0 1 file changed, 41 insertions(+), 30 deletions(-)
>=20
> (1) This can't be a separate patch, because the first patch can't
> compile
Sure, Ill fix that. Its just found this riscv case only in all archs
build, so it put it saperatly. ill squash it with main patch.

> (2) You can't use a global variable for bp_found.
>=20

I could'nt find any looping mechanism in GTree. I think there is only
g_tree_foreach. Maybe i can pass it as `user_data`.=20


>=20
> r~

Regards
~Shivang.

