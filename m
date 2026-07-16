Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B028C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkTKM-0004HW-68; Thu, 16 Jul 2026 17:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTKK-0004Gy-KM; Thu, 16 Jul 2026 17:09:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wkTKJ-0002AO-9Z; Thu, 16 Jul 2026 17:09:04 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GKBqxP4130227; Thu, 16 Jul 2026 21:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VJhXCL
 YXLlIibIlf4e+lSfQ5uddyhyNEkPixBjsXZQI=; b=HLcQ6mcFhs23/2fFteij99
 Qof1UroOlQQNOnMIlrqoqWeprkfrrsifIybHSIWANPTA7SaB+Gm1gDOyls8abCbm
 N3MlGy6MdEd8R3xN9S9PbiEi6zbZW06MGbbYOrZWKzJ4ibREz/lxK9IETzQTHQAu
 ubvpvYBOB2LYCEBQHl6kKONtktxL0uzeHCC/fCb9iDueN5RhEgM2TbPTchU5wiGt
 BtfLaWq78pRXRX8+exx2AOD8jnna88SERryrSJ+EFLS62EYI7VSpnKFFfi8raw8g
 PJcdTexUQ5idUi5LKCAcLcisrjRwCYnM19/niVyaapTD/OK2ZhqTWVZRKeLdC73w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2aj9xd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:09:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GL4bWa012522;
 Thu, 16 Jul 2026 21:08:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qf209-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 21:08:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GL8vUa41877856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 21:08:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DC7320043;
 Thu, 16 Jul 2026 21:08:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A96420040;
 Thu, 16 Jul 2026 21:08:57 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.65.221])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 21:08:57 +0000 (GMT)
Message-ID: <7396fc58-8692-4003-844b-88b124b318df@linux.ibm.com>
Date: Thu, 16 Jul 2026 23:08:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/51] system: Validate flags in cpu_watchpoint_insert
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-23-richard.henderson@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260710205401.836304-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfX/1s09l/DWQ9p
 L6cx4lRH9cbRvOJzlCtZk1DOTGLbgju/9GhCGeOW4jq6Yx0EGZZytz0OcNO6k85t6ypYXeTtwYM
 ygn8PqSa/LrzSECgOVQbX3gfH8Hm/zY=
X-Proofpoint-GUID: 44fA0hdDax-WWPQHZ-2JGv6fB9YcSVxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMSBTYWx0ZWRfXytYIb989Y6qH
 SuBpexVJ84uxWd2dU8Paxafmpt32gugkVPbHvKjHALjIsNW9uh2xfleWI9bRVSAim/DskeRYfq8
 PST3zrzv0ulG2MUJoCYjv7GRwUfznD6R4DMHcRQZZadIjSH1uqx18DAlkuqHPv4EioRcuqDf1IF
 U+eHYJnaMMsc/8dIHyY+mtlilHYDlMHShxZdq/9yHW855lpT4EdeD6vuSK4NLs1f/L1uojWTYky
 xxvaht87W0dxmObGarUzmZAD3ytGzAxvCsOYN5XE7cQmm78O+HhzY72JfcmWQwgvE+Quc1QMk0C
 pHYVgkdQAsKspgYK7CO011/HooMMTh9rbovn0lw1HnzmNXbz7J8ZYgMlxxfOPlV4g0DHga5PoX1
 /2Z1DoBL2YyMA+U5C6S45IjBhk7MJYmAPJC89Fec0sErQASunLwcjpqE4MstTwOdOw16iLoMd5R
 gEi2REFI7dKAhZiE1Tw==
X-Proofpoint-ORIG-GUID: Yt1n6dpGi5sqXFYqqpm2jw1hTcMS7OlB
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a59486c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=YsH3jjYhZO1Zdoctmk0A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160211
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



On 7/10/26 22:53, Richard Henderson wrote:
> Flags must watch reads, writes, or both.
> Flags must specify GDB or CPU but not both.
> Flags must not contain extraneous bits.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/watchpoint.c | 3 +++
>   1 file changed, 3 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>


