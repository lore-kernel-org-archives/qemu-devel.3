Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B27D3B7C1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 09:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFro2-0000NB-JU; Tue, 26 Nov 2024 04:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tFro0-0000JS-5I; Tue, 26 Nov 2024 04:24:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1tFrnx-0001D1-Pq; Tue, 26 Nov 2024 04:24:23 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ0qc5b001323;
 Tue, 26 Nov 2024 09:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CXCPij
 +CpvPI+EzRSI7tOqQabILwsDPinX+hT4Ybcfs=; b=QbjpqvORwFPP2G8NH6mwQO
 2fxs6yguiArG5hn99eNAI4BfJy73cZecycbjw6P64531gGqLP0quoRxKlbbaSeBG
 qB/hlen4Y9L88mpODx6aZB6n6hyW4+ChPhAEe2NL4Sfl1wFUe3wodg2LaSepBcDC
 Y46zgO1VgsmEydRIgFii4eK2Jo9NEw9/awZeQjkcszmOFpyw8crhW8FHkJm1rW1u
 fsJvNWafTb6V03opAEJILEsRr+mdCo+fybeXjkB1VE51GWA0C+JTQw1YvNcKZZDV
 L/eHOgcGdYEj99Ur22Xx8wDmHNOsrSuEN4YjFDhKnJutmO4QRTa4ibEfKzLrewxQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nd37u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Nov 2024 09:24:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQ9HbgN002240;
 Tue, 26 Nov 2024 09:24:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386nd37q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Nov 2024 09:24:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8OARf000866;
 Tue, 26 Nov 2024 09:24:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433sry94cv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Nov 2024 09:24:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AQ9ODPs64094584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2024 09:24:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9FAA2004B;
 Tue, 26 Nov 2024 09:24:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A60220043;
 Tue, 26 Nov 2024 09:24:12 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Nov 2024 09:24:12 +0000 (GMT)
Message-ID: <3f1f56122cde6ac457f774b79fa4ba4113a38a33.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias [regression]
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>, Richard
 Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de, qemu-stable@nongnu.org
Date: Tue, 26 Nov 2024 10:24:12 +0100
In-Reply-To: <Z0V0undiZVtHIy7z@atmark-techno.com>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
 <Z0V0undiZVtHIy7z@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3VsB6oA851dkFmYmPTjFT9RJcP2fpCS9
X-Proofpoint-ORIG-GUID: RJgquBcHWQ_KOcXZQSMWvrpIsX71M3iH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1011 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411260070
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 2024-11-26 at 16:11 +0900, Dominique MARTINET wrote:
> This commit is fairly old, but this appears to cause a segfault for
> older versions of ldconfig:
> ```
> $ docker run --rm --platform linux/arm64/v8 -ti
> docker.io/debian:bullseye-slim ldconfig
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault (core dumped)
> ```
>=20
> The segfault happens inside ldconfig code (code_gen_buffer in qemu's
> backtrace), so I'm not sure how to debug that further, but it doesn't
> reproduce in bookworm's ldconfig so that is something that was
> "fixed"
> in glibc at some point.
>=20
> If someone needs to run older debian releases with a newer qemu that
> might be a problem in the future?
>=20
> [we might need to run old containers once every few years to rebuild
> old
> projects in a similar environment they were built on, so would
> eventually need to work around this problem somehow]
>=20
>=20
> The failure can be reproduced just running `qemu-aarch64
> ./path/to/ldconfig` on an extracted container so it was easy to
> bisect
> and I've got down to this commit; hence replying here directly with
> involved people.
> ------
> commit aec338d63bc28f1f13d5e64c561d7f1dd0e4b07e
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:=C2=A0=C2=A0 Wed Aug 16 10:32:18 2023 -0700
>=20
> =C2=A0=C2=A0=C2=A0 linux-user: Adjust brk for load_bias
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 PIE executables are usually linked at offset 0 and are
> =C2=A0=C2=A0=C2=A0 relocated somewhere during load.=C2=A0 The hiaddr need=
s to
> =C2=A0=C2=A0=C2=A0 be adjusted to keep the brk next to the executable.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Cc: qemu-stable@nongnu.org
> =C2=A0=C2=A0=C2=A0 Fixes: 1f356e8c013 ("linux-user: Adjust initial brk wh=
en
> interpreter is close to executable")
> =C2=A0=C2=A0=C2=A0 Tested-by: Helge Deller <deller@gmx.de>
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> =C2=A0=C2=A0=C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org>
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Richard Henderson <richard.henderson@li=
naro.org>
> ------
>=20
> I've done my share of debugging linux-user last week[1] so I'll leave
> this
> as is for now, I've downgraded to (a non-static-pie build of) 7.1 for
> our build machine and am not in immediate trouble.
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1053101
>=20
> If this doesn't get much interest I might try to pick at it further
> in
> a couple of weeks, assuming it's something we can/want to fix on qemu
> side.
>=20
> Thanks,

Hi,

I think this is
https://gitlab.com/qemu-project/qemu/-/issues/1913

Best regards,
Ilya

