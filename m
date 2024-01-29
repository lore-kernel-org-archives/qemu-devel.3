Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8E1C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUO6M-0005M2-IA; Mon, 29 Jan 2024 04:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUO6K-0005Lg-IT
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:38:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUO6I-0001GF-Na
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:38:48 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T9WOUP001750; Mon, 29 Jan 2024 09:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=GEcFEBslE2SP+vjWwG6AuAa6iXvhb0lDiGobMrDcIr8=;
 b=kuOR1lJfX49l0o7+AzWSs8RZHw6YQ1zJOBm4vEzLvlhC10OBQvSKjiYWEqwijeg0mRrb
 5Ve6dPhhNeaq6PLQTrJMUw4ukMlcw3Z3sAr4fm59Xh5iIEgy0VQcUd4wPL6XedXD7yde
 nM6MpRMK6P4MF5tjcenD2F2crp3Sgat+V9+ORGEldzqlSw0MkjP82YtWac5c4q380zAX
 0sEYghyal5Yffa57eyDdHQjERTLys3D1xpPnhhNMoui7R3MkF5z1DKiu4xLESq9HzDbp
 OyRPpE/Np7M+Ihx39o28H4sBGTHMPxikDSR4rqtKeOsbE1qTTqSuXOaFSVgxraQaEIXf zQ== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx9fkr4ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:38:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T8QnmN010501; Mon, 29 Jan 2024 09:38:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nfbcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:38:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40T9ce4b13042218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 09:38:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA8B620043;
 Mon, 29 Jan 2024 09:38:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89BEA20040;
 Mon, 29 Jan 2024 09:38:40 +0000 (GMT)
Received: from heavy (unknown [9.179.7.240])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 29 Jan 2024 09:38:40 +0000 (GMT)
Date: Mon, 29 Jan 2024 10:38:39 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 14/33] tests/tcg: Factor out gdbstub test functions
Message-ID: <g7577f222gcnmo44yxojk2vs43avvpasl675zj5yappkic2szo@gew77smmvm3d>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
 <20240128044213.316480-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128044213.316480-15-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9yJVnj5EYU4-NBKrmX2aDneJHUItA5jl
X-Proofpoint-ORIG-GUID: 9yJVnj5EYU4-NBKrmX2aDneJHUItA5jl
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=521
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290069
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jan 28, 2024 at 02:41:54PM +1000, Richard Henderson wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Both the report() function as well as the initial gdbstub test sequence
> are copy-pasted into ~10 files with slight modifications. This
> indicates that they are indeed generic, so factor them out. While
> at it, add a few newlines to make the formatting closer to PEP-8.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20240109230808.583012-3-iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/guest-debug/run-test.py                 |  7 ++-
>  tests/guest-debug/test_gdbstub.py             | 56 +++++++++++++++++++
>  tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   | 34 +----------
>  tests/tcg/aarch64/gdbstub/test-sve.py         | 33 +----------
>  tests/tcg/multiarch/gdbstub/interrupt.py      | 47 ++--------------
>  tests/tcg/multiarch/gdbstub/memory.py         | 39 +------------
>  tests/tcg/multiarch/gdbstub/registers.py      | 41 ++------------
>  tests/tcg/multiarch/gdbstub/sha1.py           | 38 ++-----------
>  .../multiarch/gdbstub/test-proc-mappings.py   | 39 +------------
>  .../multiarch/gdbstub/test-qxfer-auxv-read.py | 37 +-----------
>  .../gdbstub/test-thread-breakpoint.py         | 37 +-----------
>  tests/tcg/s390x/gdbstub/test-signals-s390x.py | 42 +-------------
>  tests/tcg/s390x/gdbstub/test-svc.py           | 39 +------------
>  13 files changed, 94 insertions(+), 395 deletions(-)
>  create mode 100644 tests/guest-debug/test_gdbstub.py

Alex had issues with this and the next patch, I posted an update that
hopefully resolves them:

https://lore.kernel.org/qemu-devel/20240129093410.3151-1-iii@linux.ibm.com/

