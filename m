Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9B7E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW0mE-0003hy-Oh; Thu, 09 Jan 2025 17:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tW0mC-0003ho-UD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:13:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tW0mB-0002Mt-FF
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:13:16 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509BswCb016811;
 Thu, 9 Jan 2025 22:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dW9vuz
 5E54LOg9sHr6EP5GfO2y4mMfufqxn+5V4VeLE=; b=HrKcJXA0uFqawDiC94T1dD
 KCkjFXupmoiX1rneMgxXgUNbNFeFDq/24kiC8JxlUNI6jDA+15gybS4FIEQC9LeJ
 gBt1m/BRW/Q40fqLPWwlxwspJ4P9J/h4TsoSwYuXDPBZk4cTZQzkIDSA8IR3ONA0
 F7KX9QChM0/8qtwa4rP0o+nF18lkqgvPCB8XQLhatXXBH/6Nx609BXhso3KHzTBv
 ds3pUyxHNFUkABNZ5GKwJpfOxDwtZF9UVlCnA2M1eay+8GJqlIM6ae4xNhFfX6di
 I75zVyho3Hkasc5YjY1tEN5OsZnILaRnPds0M339PPuQKzuHywvWu6SWXsP1U/7g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4423ghwbke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 22:13:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 509JtYIs003630;
 Thu, 9 Jan 2025 22:13:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfatfheh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 22:13:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 509MD41Q56099224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jan 2025 22:13:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A03320063;
 Thu,  9 Jan 2025 22:13:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 927302005A;
 Thu,  9 Jan 2025 22:13:03 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jan 2025 22:13:03 +0000 (GMT)
Message-ID: <031fe2f37f83c241d1bbea36e6131f4b5f0aefd8.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] linux-user: Only include 'exec/tb-flush.h' header
 when necessary
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Riku
 Voipio <riku.voipio@iki.fi>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Date: Thu, 09 Jan 2025 23:13:03 +0100
In-Reply-To: <20250102182521.65428-2-philmd@linaro.org>
References: <20250102182521.65428-1-philmd@linaro.org>
 <20250102182521.65428-2-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bOD-W35CANW1ytHU17b9aF1cfxv5nDbr
X-Proofpoint-ORIG-GUID: bOD-W35CANW1ytHU17b9aF1cfxv5nDbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxlogscore=599 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2025-01-02 at 19:25 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Very few source files require to access "exec/tb-flush.h"
> declarations, and except a pair, they all include it
> explicitly. No need to overload the generic "user-internals.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> =C2=A0linux-user/user-internals.h | 1 -
> =C2=A0linux-user/mmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> =C2=A0linux-user/syscall.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 =
+
> =C2=A03 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


