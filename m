Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054E9C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmTIY-0003Ao-2p; Wed, 22 Jul 2026 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wmTIQ-00037T-2G; Wed, 22 Jul 2026 05:31:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <freude@linux.ibm.com>)
 id 1wmTIN-0006Ax-Ck; Wed, 22 Jul 2026 05:31:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M9CVvF3566839; Wed, 22 Jul 2026 09:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Vxo2MO/kcF7SP1jM0Htd6hEJPuGB3wCtc5IbomObr7o=; b=tKoOi949ZK60
 evaNJRtOYLGCLLA+I5fmZMEvs8PL/TejvdMvOv208MTU6wHasmpumaUGwimlN5PU
 aUug4KfHRxGv87LwJlN4fovFouNrI3IrDgk/GHke0lmeYbtihOVpR3TwvX+GXKx6
 Vzr8j1QO34KNmH01DVn1NYfIaMqOHH97/1P3rCxhGVSWyywiw3jD3L85NkeUqUHc
 zaDg7o8Zsm02CbuNFDsdAAY/UOBCBJnhn3FL3Hkl7cv+6Vf6m5XPN24wlNuEwjhE
 2mpPnFtpfmh2NDtIN6yU94GYpfFil0ZBiM2e+zusfPI/1DhnaW4duEXcENwFJY02
 mqXCltlxgA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g8vsm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 09:31:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M9JieR003568;
 Wed, 22 Jul 2026 09:31:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gee79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2026 09:31:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66M9VDx532965126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2026 09:31:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C951B5804E;
 Wed, 22 Jul 2026 09:31:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14D625803F;
 Wed, 22 Jul 2026 09:31:13 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2026 09:31:12 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 11:31:12 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] tests/tcg/s390x: Test PRNO TRNG interruptibility
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260714191948.342204-3-iii@linux.ibm.com>
References: <20260714191948.342204-1-iii@linux.ibm.com>
 <20260714191948.342204-3-iii@linux.ibm.com>
Message-ID: <a522efe874b5b8cd2950734003c68e5e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4NyBTYWx0ZWRfX+HcnTd6l2IDr
 4eo814HcYO4lbDh61M77vM3vM/5NIH4nnh/vmMLuWUAN0Hs80AcOKMJAH/2JJqERNVkrrwAWSuV
 lFl6iFgqPbD27yS74Mdf0GYmSqtmcGfwESG3fFN6+UqVmSDDPo7dMzRO1nyFlJRf0hTzSeOdcUG
 J9ECgI2M5UMjmbUopjC9OvLWfHoO38Y3/DkyenG0Fz3YdcrCufB5QtLcGTiFeN4xslf/K6rxbyP
 qjPHUqR8QZKXFb+iWZ9aSEq6EfKtbhtC1VZkltzL1BkFRoPo+DqxZIJIJX8Nx/G7eL28dRYJ8cw
 uGpLnrnXpCR88zhXc8QpF0+GgF84O9i/SfbLBCtg6MkYxQi1CCQ9zbkv7htBYrYzqhIzXj9iK2y
 +zNNYj8rLaOSafFTkhdLfkp7/r7mzCtvXFJSXA7b552JrJmmqgOmPWsRHoFcIsvCaNYTtawlCuQ
 g7IB+NPMtYE1C5R7YZw==
X-Proofpoint-GUID: 0ZPMVpzuXiePuhrD6O7alCsmbaAyhOMv
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a608de3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=XRK_m0zysxwyDDjYutMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4NyBTYWx0ZWRfX59wBVWJDmi5x
 ZP3BZ4k6ng/bTbj81ypfitdL5aHOjUBkoruEGqWjh4ZC1lHeC8g6Xa9xKNTUPxd50v0MkaKhPdN
 jO1sickkTR6x4uT07FaEKfKyY5e4aps=
X-Proofpoint-ORIG-GUID: 0ZPMVpzuXiePuhrD6O7alCsmbaAyhOMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=freude@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: freude@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-07-14 21:17, Ilya Leoshkevich wrote:
> Add a small test that issues a large PRNO TRNG request while a timer is
> running, and checks that the timer interrupts it several times.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/s390x/Makefile.target |  1 +
>  tests/tcg/s390x/prno-trng.c     | 67 +++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 tests/tcg/s390x/prno-trng.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target 
> b/tests/tcg/s390x/Makefile.target
> index 0ca030ded01..48cba4cdfa4 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -75,6 +75,7 @@ Z13_TESTS+=vcksm
>  Z13_TESTS+=vstl
>  Z13_TESTS+=vrep
>  Z13_TESTS+=precise-smc-user
> +Z13_TESTS+=prno-trng
>  $(Z13_TESTS): CFLAGS+=-march=z13 -O2
>  TESTS+=$(Z13_TESTS)
> 
> diff --git a/tests/tcg/s390x/prno-trng.c b/tests/tcg/s390x/prno-trng.c
> new file mode 100644
> index 00000000000..43eea5db1dc
> --- /dev/null
> +++ b/tests/tcg/s390x/prno-trng.c
> @@ -0,0 +1,67 @@
> +/*
> + * Test that PERFORM RANDOM NUMBER OPERATION TRNG is interruptible.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/time.h>
> +#include <asm/ucontext.h>
> +
> +static unsigned char buf1[16 * 1024 * 1024];
> +static unsigned char buf2[16 * 1024 * 1024];
> +
> +static volatile sig_atomic_t interrupted;
> +
> +static void sigprof_handler(int sig, siginfo_t *info, void *ucontext)
> +{
> +    struct ucontext *uc = ucontext;
> +    unsigned long addr = uc->uc_mcontext.regs.psw.addr;
> +
> +    if (*(unsigned short *)(addr - 4) == 0xb93c) {
> +        interrupted++;
> +    }
> +}
> +
> +static void prno_trng(void *b1, unsigned long l1, void *b2, unsigned 
> long l2)
> +{
> +    register unsigned long r0 asm("r0") = 114;  /* TRNG */
> +    register unsigned long r2 asm("r2") = (unsigned long)b1;
> +    register unsigned long r3 asm("r3") = l1;
> +    register unsigned long r4 asm("r4") = (unsigned long)b2;
> +    register unsigned long r5 asm("r5") = l2;
> +
> +    asm volatile("0: ppno %[r2],%[r4]\n"  /* prno alias for old 
> toolchains */
> +                 "   jo 0b"
> +                 : [r2] "+r" (r2), [r3] "+r" (r3)
> +                 , [r4] "+r" (r4), [r5] "+r" (r5)
> +                 : "r" (r0)
> +                 : "cc", "memory");
> +}
> +
> +int main(void)
> +{
> +    struct itimerval it = {
> +        .it_interval = { .tv_usec = 10000 },  /* 0.01s */
> +        .it_value = { .tv_usec = 10000 },
> +    };
> +    struct sigaction act = {
> +        .sa_sigaction = sigprof_handler,
> +        .sa_flags = SA_SIGINFO,
> +    };
> +    int err;
> +
> +    err = sigaction(SIGPROF, &act, NULL);
> +    assert(err == 0);
> +    err = setitimer(ITIMER_PROF, &it, NULL);
> +    assert(err == 0);
> +
> +    prno_trng(buf1, sizeof(buf1), buf2, sizeof(buf2));
> +    printf("interrupted %d times\n", interrupted);
> +    assert(interrupted >= 3);
> +
> +    return EXIT_SUCCESS;
> +}

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

