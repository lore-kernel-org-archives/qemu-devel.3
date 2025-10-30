Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231E0CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETYi-0001Ck-5k; Thu, 30 Oct 2025 10:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vETYc-0001BQ-Ql
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:23:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vETYS-0005x2-Dy
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:23:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCq3aJ019735;
 Thu, 30 Oct 2025 14:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=08oIkZ
 wp8NU/7yOzJBZxggYCHLahv2VIIl94oHOJJpw=; b=aEdJjkmSAI8hIxk2pmDedy
 rD2clvmmOyS3B8IfGMLdA16r4Mz5MXR2CDJu37UYpYxti5/DkElaGxfOHWgekYeu
 APyq66dGTzGNKNRuqJOdmaiBPntg3gK9kR8B87uJxSi1UQ1Vv5th4H+XE7o9n6zo
 yyLpgNbvOQ8LrAMGu4jQo5x7zbg0eqrKPCrmPlGLYoiuLdC7wYPOWhxCF2EGR6kw
 gd7Dupbtzca22nBPIPkUj5P3M1MRDomkcznnieW/bTHb4e+5/mMBfxwYpzo7A7vt
 xz0hfPLAs5DT/J/YxBJnke7+0x0haLebWkfbPrMEv8/RHdIKLfD7ASm7d/TvAK3A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34agrkrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 14:23:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDGoT9018742;
 Thu, 30 Oct 2025 14:23:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwh243-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 14:22:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59UEMuo631719828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 14:22:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16CCA20043;
 Thu, 30 Oct 2025 14:22:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD2E020040;
 Thu, 30 Oct 2025 14:22:52 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.29.84])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 30 Oct 2025 14:22:52 +0000 (GMT)
Date: Thu, 30 Oct 2025 19:52:48 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 peter.maydell@linaro.org, adityag@linux.ibm.com, qemu-devel@nongnu.org,
 sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 1/2] hw/ppc: Fix missing return on allocation failure
Message-ID: <fz5bixswyqecp2tgbobkz2vlncuhdm4cxagdndn77qpprltssl@opqtjw4ixgpk>
References: <20251028080551.92722-1-shivangu@linux.ibm.com>
 <20251028080551.92722-2-shivangu@linux.ibm.com>
 <8d5a8cce-d769-4cd8-9753-7e9ad37d8a47@linaro.org>
 <dio77m3m5jj6ccgqpswkifiqztf5fz45qsjpspu2yszgwrfgha@mcwjruxszkn5>
 <47ac6382-3270-4179-8455-43cee36a9ca9@linux.ibm.com>
 <c089e14f-69a3-fe9c-cc80-b0c7bba4105a@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c089e14f-69a3-fe9c-cc80-b0c7bba4105a@eik.bme.hu>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K+gv3iWI c=1 sm=1 tr=0 ts=690374c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=Rw2pgWYzqnU3bIbjUzIA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: 95HuYYwxjWni-wT8AFvzHK6KX1CuuNrM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX7r6y/IXQwY3t
 +IXY6FBDVynSjoOdvlvVskgxuXXmmNeLUTLQltWOGwJEWm38qU8S2yHauNR6wIIsQnJnGLCufi+
 J9tjIneLnmCZyocEd5InIzDVFapYH8j5Hyhm5h+ZnuEzAhA1uoqKWUtplkBT8L7YiVteva54/nt
 AM6hxxojFBjFczPiMDtEDNSqZFCq64SjcxrEUtR/RfnxFk4f/YXiAe+vPoDz2HZKclxfMGLwq+d
 CSwUInO5UkwGqRjUV1Ng+6t7SrSBFdr5D1iw1NE++uMUxjmYMSMPF9xNFLGNx4N2hdnyf+38zcX
 80lC5rKTlnhrwG99sxKjl1swDtFV6ECaD+a5Ug1dexzrPWuLkLON817LZIF28Mi5lG3TpHsV3DG
 qEnNkNiU11EkDkYpcoHB+OLWne57Jg==
X-Proofpoint-GUID: 95HuYYwxjWni-wT8AFvzHK6KX1CuuNrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Thu, Oct 30, 2025 at 12:09:44PM +0100, BALATON Zoltan wrote:
> On Thu, 30 Oct 2025, Harsh Prateek Bora wrote:
> > On 10/28/25 15:54, Shivang Upadhyay wrote:
> > > On Tue, Oct 28, 2025 at 09:35:40AM +0100, Philippe Mathieu-Daudé wrote:
> > > > On 28/10/25 09:05, Shivang Upadhyay wrote:
> > > > > Fixes coverity (CID 1642026)
> > > > > 
> > > > > Cc: Aditya Gupta <adityag@linux.ibm.com>
> > > > > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > > > > Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
> > > > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > > > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > > > > ---
> > > > >    hw/ppc/spapr_fadump.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> > > > > index fa3aeac94c..883a60cdcf 100644
> > > > > --- a/hw/ppc/spapr_fadump.c
> > > > > +++ b/hw/ppc/spapr_fadump.c
> > > > > @@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
> > > > >            qemu_log_mask(LOG_GUEST_ERROR,
> > > > 
> > > > FWIW host heap exhaustion is not really a *guest* error, because the
> > > > guest can not control it.
> > > Hi, Philippe
> > > 
> > > 
> > > Thanks for the review. There are following log level defined in log.h
> > > 
> > > 	....
> > > 
> > > 	#define CPU_LOG_TB_OUT_ASM (1u << 0)
> > > 	#define CPU_LOG_TB_IN_ASM  (1u << 1)
> > > 	#define CPU_LOG_TB_OP      (1u << 2)
> > > 	#define CPU_LOG_TB_OP_OPT  (1u << 3)
> > > 	#define CPU_LOG_INT        (1u << 4)
> > > 	#define CPU_LOG_EXEC       (1u << 5)
> > > 	#define CPU_LOG_PCALL      (1u << 6)
> > > 	#define CPU_LOG_TB_CPU     (1u << 8)
> > > 	#define CPU_LOG_RESET      (1u << 9)
> > > 	#define LOG_UNIMP          (1u << 10)
> > > 	#define LOG_GUEST_ERROR    (1u << 11)
> > > 	#define CPU_LOG_MMU        (1u << 12)
> > > 	#define CPU_LOG_TB_NOCHAIN (1u << 13)
> > > 	#define CPU_LOG_PAGE       (1u << 14)
> > > 	/* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
> > > 	#define CPU_LOG_TB_OP_IND  (1u << 16)
> > > 	#define CPU_LOG_TB_FPU     (1u << 17)
> > > 	#define CPU_LOG_PLUGIN     (1u << 18)
> > > 	/* LOG_STRACE is used for user-mode strace logging. */
> > > 	#define LOG_STRACE         (1u << 19)
> > > 	#define LOG_PER_THREAD     (1u << 20)
> > > 	#define CPU_LOG_TB_VPU     (1u << 21)
> > > 	#define LOG_TB_OP_PLUGIN   (1u << 22)
> > > 	#define LOG_INVALID_MEM    (1u << 23)
> > > 
> > > 	....
> > > 
> > > Which one do you recommend we use? or May we introduce a `LOG_HOST_ERROR`,
> > > if that's more appropriate.
> > 
> > I think it would be better to have LOG_INSUFF_MEM for this case, but
> > let's hear from Philippe and others for suggestions.
> 
> If it's not a guest error but an error in QEMU then maybe error_report (or
> warn_report if it's recoverable)?
> 
> Regards,
> BALATON Zoltan
Hi

This allocation failure does not seem recoverable. Maybe Aditya can be more
right about this.

Also I noticed a pattern to use `g_malloc` for critical things instead
of `g_try_malloc`. But it will kill the full application if failure happens.
So maybe just `error_report` is fine here(?).

~Shivang.

