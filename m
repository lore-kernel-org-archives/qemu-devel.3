Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF4DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbpu-0001JC-V5; Tue, 14 Jul 2026 08:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbpt-0001IP-9k; Tue, 14 Jul 2026 08:02:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjbpr-0007lT-JC; Tue, 14 Jul 2026 08:02:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBg2WI1134850; Tue, 14 Jul 2026 12:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0oUm2J
 fcr0108qecry6v9pejLzfJATbuNlStxoQmzvA=; b=svO3vhlJcDkocmV2IEXr6N
 j/5pf3aEi6qEAvY1eNDy9ql4leEta1o2gApeUVZg/uJrfNOKScdv+rhiy4CH2nEg
 FevHuIJqjgYSHO/vRU5FXUf37AL05cYmq0AsyrIFLFN5QhaE64slwNr1mKiIENKQ
 GP0ki1OoW5w8VhjKqt1OzkVPk9/S6dqxAT88lm68QFd0pHLDEEqN7pQ2QFq8uiK0
 ACVVqNpjdsUXuCnr1H8A7B6wS2LGVoa2D4EU0rPcvev4skV+YnuXrzbVvu84U1de
 yK/MkrUC7la+CbuQMfgWOslM5ZSnCiI5cwKiMQeeZWPHGxIjfSPvYXi6dPC6l9Jg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a5fjr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:01:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EBni8l023920;
 Tue, 14 Jul 2026 12:01:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy2a9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 12:01:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EC1s4X31851160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 12:01:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88B9020040;
 Tue, 14 Jul 2026 12:01:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 355E520049;
 Tue, 14 Jul 2026 12:01:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.75.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 12:01:54 +0000 (GMT)
Message-ID: <33187980-d8d8-43f4-a138-34c67fa63d8b@linux.ibm.com>
Date: Tue, 14 Jul 2026 14:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/17] tests/tcg/s390x: Add tests for CPACF
 instructions
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260710152906.80207-1-freude@linux.ibm.com>
 <20260710152906.80207-18-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710152906.80207-18-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXzgqhbWhM37re
 zNqzRfSfUluOU9cANy9sbwA7qCyaIG3ml8ZXetj6nhw7vIXArbs465IaH6vEBdu0Ikzza75Rqh5
 sTetWbMgCNebo/QRGD1/usMzouMhA68=
X-Proofpoint-GUID: p3pPZrwt3-UDlf31IbCxsCK5Qap3MYLr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEyMiBTYWx0ZWRfXxIhoewyWOD/v
 +2TiafnqYQnBMdD6oAzYGBYJpIcaWeWrlUq2szMRL+erL0EgRlu3b/r5lMUZ8FayLJdfuxhjUwC
 8jo7cqAxTyVLLLp0vj5tW6kPAFh9Ky2BLdHfA994M0E0QYl1SBe/g4lTszochVPMbZAZnEYwe4n
 56sBEDBKEnZuX6JLgatwOmZiABge/4zI5ODZI6NxPiBqqgVSra5stJE6L17yzudyrUlrY5Rlc9w
 mYG/z+6iLbjMpPA1/RNqIgMjCfBU1zt1pcCluM1INCsNZFnGjLpbungEzUDX3D5IXZk4b8vVHdL
 ybxy8afo6n0gRVotoRJDXL98+Te6XdPCXDIFB8JBIdmlQ6Mi+gbr+0Ay1jtgzwCSCs17j967Cmq
 8ET3NYMLhE3QKUIdRAZ52EKkgclxbxDoPbBHL09P7jjWaO80PKIhPNdc5SDF1l2mmh1lFlGRym9
 yEY/V+jXGhn8MQQlt4A==
X-Proofpoint-ORIG-GUID: p3pPZrwt3-UDlf31IbCxsCK5Qap3MYLr
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a562537 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ow17IZp0XGAzbqrRrHkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140122
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/10/26 17:29, Harald Freudenberger wrote:
> Add simple tests for the CPACF instructions implemented:
> - kdsa - minimal as only query is implemented
> - kimd - query, sha256, sha512
> - klmd - query, sha256, sha512
> - km - query, aes 128, 192, 256 with clear and prot key
> - kmac - minimal as only query is implemented
> - kmc - query, aes 128, 192, 256 with clear and prot key
> - kmctr - query, aes 128, 192, 256 with clear and prot key
> - pcc - query, xts aes 128, 256 and prot key xts aes 128, 256
> - prno - query, trng
> No test for pckmo as this is a privileged instruction.
> No test for kma, kmf, kmo as these instructions are currently
> not implemented at all.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/cpacf.h        |   7 +
>   tests/tcg/s390x/Makefile.target |   9 +
>   tests/tcg/s390x/cpacf-kdsa.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kimd.c    | 166 +++++++++
>   tests/tcg/s390x/cpacf-klmd.c    | 206 +++++++++++
>   tests/tcg/s390x/cpacf-km.c      | 590 ++++++++++++++++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmac.c    |  58 ++++
>   tests/tcg/s390x/cpacf-kmc.c     | 351 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-kmctr.c   | 360 +++++++++++++++++++
>   tests/tcg/s390x/cpacf-pcc.c     | 245 +++++++++++++
>   tests/tcg/s390x/cpacf-prno.c    | 131 +++++++
>   tests/tcg/s390x/cpacf.h         | 571 +++++++++++++++++++++++++++++++
>   12 files changed, 2752 insertions(+)
>   create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
>   create mode 100644 tests/tcg/s390x/cpacf-kimd.c
>   create mode 100644 tests/tcg/s390x/cpacf-klmd.c
>   create mode 100644 tests/tcg/s390x/cpacf-km.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmac.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmc.c
>   create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
>   create mode 100644 tests/tcg/s390x/cpacf-pcc.c
>   create mode 100644 tests/tcg/s390x/cpacf-prno.c
>   create mode 100644 tests/tcg/s390x/cpacf.h

I get failures when running these on a real z17, for example:

$ ./cpacf-kdsa
test_kdsa_query failed
cpacf-kdsa: 1 failures

