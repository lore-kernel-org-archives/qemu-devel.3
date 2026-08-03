Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781CCC55184
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqr9j-00088W-3r; Mon, 03 Aug 2026 07:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr9h-000881-F0; Mon, 03 Aug 2026 07:48:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wqr9g-0003md-0R; Mon, 03 Aug 2026 07:48:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672LliQi243692; Mon, 3 Aug 2026 11:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RzEx4k
 JuT1J8RDZdySVcvzwT7AWviLmLd7Oluz3iehc=; b=YeGO8f4n4/umHmEVSw5I7j
 Po5LvgtjT2yNip+hIGZhDy1Sy0+g2Cq7HDslgXZ1OKq6CpbtQWeFSqbJmJpdPB6x
 B52hCfi/VI91of4ETjhyBm8q8UsW0idnj3+DFDI/hjuEsJI3w307AUnZq2wFAj9X
 RO3yQfJqa63EGyiatOVMu4umgWl6I8Nw1EMpLdc0nbRLykM/5L2kff1E6safmq2u
 PItuiTAGVQR45bS4irmMr0DgOZtbugz5AwcwdT+KooilR7ojcoJPQn6JLjfnVcE1
 3ZSpCzegkCYhNS2E3fVWQc4Ga6fbtK3KZMZ2cQ+e6QNaULmoCdylUZ3Ej+05dXQg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4rge5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:48:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673Bfbw3005885;
 Mon, 3 Aug 2026 11:48:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtycx69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:48:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 673BmMaG12517710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Aug 2026 11:48:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF16F20043;
 Mon,  3 Aug 2026 11:48:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4038A20040;
 Mon,  3 Aug 2026 11:48:22 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.49.55])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Aug 2026 11:48:22 +0000 (GMT)
Message-ID: <8a86acad-103f-4b57-8946-3f7611735a8d@linux.ibm.com>
Date: Mon, 3 Aug 2026 13:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/s390x: Convert op_st64 to op_st
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-12-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260731185628.23161-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX64jGBackQ4a0
 AL+fyVr74bAl6BsOGC5RdsKwkegQmyS2bn0IoVX5hJCgxOQH+8gGTOqR9/CtU8IjtictmCo3H4w
 fVAp0aB/xnsjwtB3J9I7hrEzSxQVVkI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwNSBTYWx0ZWRfX1G4F4AE45lpX
 dzuC065zh3Ju2i0MFL5AN3S62lY0K8KDDyrDPiu0+pBQLL0u51Wc1j8UqeOV9T0ubZYU0foj+EQ
 cF/0P63LBc3Pd21nhpJreRSKRZl4zawABnVh/jyB/XNWXFyUTTPrmsggOq1INp7HC29ol6xSO4D
 1nNJzUZFVI2SRFGro8WOhOLOViUyPgfOy5f4f85UyI4rKf88igfHuUEpAD6UE2TASsLu6jMf0Ql
 dDv+bG7CTeCz6QChn2GQxJwORpG9jPqgFInPuN8GohiqHUbmltp9hP3fAlEK7gZPtaf4BDzBfYt
 GdUUkoYxV30wJe5URkqtKZWdS78FXENATtH3G2BaBe3PzMf/MOVxctQnIfuwW6wnzqgKhU5nIDA
 Oc8JGc3P6Y8TrPVAaGTnHPviO6htR9e2lANUQ0UbWsbnXof/LEq+lYcTFoyibaZBNVjFb0thxDB
 f0guAycpoKIZQkGCbdg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a708009 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=vtlFLEGkmGI1kn2-6cgA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: frYa_WN_IKgZs0UoXQNacR9b6UdyTx20
X-Proofpoint-GUID: frYa_WN_IKgZs0UoXQNacR9b6UdyTx20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/31/26 20:56, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 7 -------
>   target/s390x/tcg/insn-data.h.inc | 8 ++++----
>   2 files changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



