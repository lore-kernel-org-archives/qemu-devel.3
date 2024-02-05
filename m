Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D8AC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvl6-0005vq-Jr; Mon, 05 Feb 2024 04:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWvl3-0005vZ-Av
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:59:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWvl1-0008E7-37
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:59:21 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41582qaD020091; Mon, 5 Feb 2024 09:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dsftFmy7NyD0k9ltQrqLn8OrI65XfeLu70iT4Q4JkLo=;
 b=R1YUOjqkOnozW8Oy9nVSEyQeeuVaTgStgp8hYKKFh5XhteYuG/QwSPRqfRy+dk3FUfrv
 6bBDBEftJRFDfNb20KT9WoFQh9xnLq2jsWxAWJ2K+AzN/KfigKESAr+DLqq5BN8+Sc59
 wGzMzyjCJGBaobZfwKViFFYkUwqkRTXaVETgGuoMXD+Mku5WW6g2tqO0gqHkF8hwFgmm
 1suAu4JpONFDOw+Bsmjsu5UOt6OkLetMFrJh7pH8oPNu/pIEnknpmmt5qv/RxHdJPX8U
 LHyBJ8LCGRZIeqLXruqETshkeZ8IR7qEzKYN5gfiAmIpUhx6nWilHosA0z+egSexOAnF CA== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2utm2gc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 09:58:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4156wKXJ008818; Mon, 5 Feb 2024 09:58:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206y7tv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 09:58:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4159w4D127198112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 09:58:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03A0820043;
 Mon,  5 Feb 2024 09:58:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE11220040;
 Mon,  5 Feb 2024 09:58:03 +0000 (GMT)
Received: from heavy (unknown [9.171.32.247])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Feb 2024 09:58:03 +0000 (GMT)
Date: Mon, 5 Feb 2024 10:58:02 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: Re: [PATCH] tests/tcg: Fix the /proc/self/mem probing in the
 PROT_NONE gdbstub test
Message-ID: <3l3ji62l3lfu5cqx4ik3bxiwano6mmdmtlmmtymwemhmj2i7or@ghrmcocuk3cb>
References: <20240131220245.235993-1-iii@linux.ibm.com>
 <ca3d3143-67e7-4c4c-b12d-3768c8191b3b@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3d3143-67e7-4c4c-b12d-3768c8191b3b@tls.msk.ru>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bX5_pdVjtLopXpJO2nz8zHi-ZhEsnfJP
X-Proofpoint-ORIG-GUID: bX5_pdVjtLopXpJO2nz8zHi-ZhEsnfJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=619 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Sat, Feb 03, 2024 at 11:48:44PM +0300, Michael Tokarev wrote:
> 01.02.2024 01:02, Ilya Leoshkevich wrote:
> > The `if not probe_proc_self_mem` check never passes, because
> > probe_proc_self_mem is a function object, which is a truthy value.
> > Add parentheses in order to perform a function call.
> > 
> > Fixes: dc84d50a7f9b ("tests/tcg: Add the PROT_NONE gdbstub test")
> 
> FWIW (it's too late already and this commit has landed in master),
> commit "tests/tcg: Add the PROT_NONE gdbstub test" is 82607a73f8
> not dc84d50a7f9b.
> 
> /mjt

Sorry about that; I thought that checkpatch catches such issues and
didn't double check - but apparently this is a relatively new addition
to the kernel checkpatch, which did not find its way into the qemu
checkpatch yet.

