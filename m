Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85EDCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgsn-0000jF-MX; Tue, 28 Oct 2025 06:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDgse-0000in-TE
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:24:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDgsZ-0002OJ-PG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:24:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S1jww7012355;
 Tue, 28 Oct 2025 10:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6oZvff
 zAMiM/4rjBrHmWvX4GL05h3L9uWngW00B7nNE=; b=LoDz5yuonCFwJpijTILS40
 y7qvA1wpfHAplBXVkhTXgqw8qFqpxocJt1ObF585t5iRMt/20tJi0aoZUROV3YCi
 lix7A5d3Gm9qmecaRNXY8MBrxbh/+Urpnhu8WSRx2dLKH6RYeCHUk4pZRLhBHMwL
 k4B9jD2eL9cAcwmpf3TKrVEga6xmiilJEwym8XuHUemDUhRJCJ9tuMpm5E3DvxMJ
 kkXLHETIQVbKnptNPxZo012/ss4af4zWd6s7YaxZkDNxX2vxrwCyonfva6F+8IAV
 1WOFXPniFjZn1yO0gF9vQa0oJV0ESWs4LWBJ1T3/Io5DsgjI4P4kHAiasSb3V7bw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81u9f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:24:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S9GvgE009477;
 Tue, 28 Oct 2025 10:24:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j1yu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 10:24:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59SAORaB31785416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 10:24:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC5EF2004E;
 Tue, 28 Oct 2025 10:24:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 174572004B;
 Tue, 28 Oct 2025 10:24:26 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.28.67])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Oct 2025 10:24:25 +0000 (GMT)
Date: Tue, 28 Oct 2025 15:54:23 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 qemu-devel@nongnu.org, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
Message-ID: <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
 <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=690099e0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=f6qUK-sOgbnvm6HaT88A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: HUyaupbnD2B5A44nGL0QRH9fEP_x3Q0N
X-Proofpoint-GUID: HUyaupbnD2B5A44nGL0QRH9fEP_x3Q0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX2f7UYjRyHMZP
 c0Mo3o7CQh0NaSVO8q55fT8C4Wf1jQxnHBI7jV264djAXzpyaxQCPHTJel/SZfKlbrQcrXyc2Cp
 nsVqJdPbP3j5AGbn4MYFR7BWbA1dJfs9xcnCqqlC86rJWD92RaABCfSC4UzK8m5Samyu1bJFEGs
 ItnmWX0LB9hhEYcIOGoQbiZPLIDDQscFGZWfzXJAFvdgZD2wBdM6TC3DSS06ydWy4KJtsmyXc+J
 yzPaYypROxdE0YyShNa3vPwIiRuzu8YAn3h3SxVgb1agLq8atKrh2q5emDjZJ5GEKXP0wOdY25r
 dOyBdWUxoqOhgzRX0k9NidcpRg+z7tEQi05BQTz2rkyc9IYMZV9/MU+ULvvyvNpnK28ybJn9OOY
 H9Ao02RPsXO4r3PvR2k/szmQI+RvBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 09:35:40AM +0100, Philippe Mathieu-Daudé wrote:
> On 28/10/25 09:05, Shivang Upadhyay wrote:
> > Fixes coverity (CID 1642026)
> > 
> > Cc: Aditya Gupta <adityag@linux.ibm.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> >   hw/ppc/spapr_fadump.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> > index fa3aeac94c..883a60cdcf 100644
> > --- a/hw/ppc/spapr_fadump.c
> > +++ b/hw/ppc/spapr_fadump.c
> > @@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
> >           qemu_log_mask(LOG_GUEST_ERROR,
> 
> FWIW host heap exhaustion is not really a *guest* error, because the
> guest can not control it.
Hi, Philippe


Thanks for the review. There are following log level defined in log.h

	....

	#define CPU_LOG_TB_OUT_ASM (1u << 0)
	#define CPU_LOG_TB_IN_ASM  (1u << 1)
	#define CPU_LOG_TB_OP      (1u << 2)
	#define CPU_LOG_TB_OP_OPT  (1u << 3)
	#define CPU_LOG_INT        (1u << 4)
	#define CPU_LOG_EXEC       (1u << 5)
	#define CPU_LOG_PCALL      (1u << 6)
	#define CPU_LOG_TB_CPU     (1u << 8)
	#define CPU_LOG_RESET      (1u << 9)
	#define LOG_UNIMP          (1u << 10)
	#define LOG_GUEST_ERROR    (1u << 11)
	#define CPU_LOG_MMU        (1u << 12)
	#define CPU_LOG_TB_NOCHAIN (1u << 13)
	#define CPU_LOG_PAGE       (1u << 14)
	/* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
	#define CPU_LOG_TB_OP_IND  (1u << 16)
	#define CPU_LOG_TB_FPU     (1u << 17)
	#define CPU_LOG_PLUGIN     (1u << 18)
	/* LOG_STRACE is used for user-mode strace logging. */
	#define LOG_STRACE         (1u << 19)
	#define LOG_PER_THREAD     (1u << 20)
	#define CPU_LOG_TB_VPU     (1u << 21)
	#define LOG_TB_OP_PLUGIN   (1u << 22)
	#define LOG_INVALID_MEM    (1u << 23)

	....

Which one do you recommend we use? or May we introduce a `LOG_HOST_ERROR`,
if that's more appropriate.

Thanks
~Shivang.
> 
> >               "FADump: Failed allocating memory (size: %zu) for copying"
> >               " reserved memory regions\n", FADUMP_CHUNK_SIZE);
> > +        return false;
> >       }
> >       num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
> 

