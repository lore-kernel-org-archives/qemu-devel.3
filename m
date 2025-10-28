Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD46CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 07:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDeFw-0006FM-22; Tue, 28 Oct 2025 03:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDeFt-0006EF-U1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:36:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDeFq-0005Kb-Gj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 03:36:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2n1Yn002617;
 Tue, 28 Oct 2025 07:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pI2vw8
 /X4T+4mGe2zMaGH5fubM9qLeWAlkicDqa/uD0=; b=oPTXcnDPlkJ9RZvptqBqRT
 jE8eVcZjkHYsl74YiTDvfi5xst3kAM1MQK8b05gAduqFvyU5J5UNg6h3TT9hUyXZ
 3AEGia/Hi+7qZ3syMbhEJ4MlqIInwEVcjzmE91sOF4pSzq5muv3BFo0Npup01Jgb
 nTVHqqkCBBtDzYr4XH7qXSZ3LTkB5wFDt3jTskSkd4eeMBJw8aPj6XPSXH3HcfNw
 Aa6gdJxM0Sl6FEoVo0cwBFupINI2lNQN5uRWJxwSr5s8KihkcxdNzznkpXex13f0
 fM5NtPM/Y2FDWgZt3MQUbWVIJYabj+1WiSzTfcqxbMY/gLmtkmARElQPVYuJpLQw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81tk92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 07:36:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S7UVrg023524;
 Tue, 28 Oct 2025 07:36:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xhngm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 07:36:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59S7aLtN38338872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 07:36:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE5720049;
 Tue, 28 Oct 2025 07:36:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C23D920040;
 Tue, 28 Oct 2025 07:36:19 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.28.67])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Oct 2025 07:36:19 +0000 (GMT)
Date: Tue, 28 Oct 2025 13:06:14 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 qemu-devel@nongnu.org, sourabhjain@linux.ibm.com, shivangu@linux.ibm.com
Subject: Re: [PATCH 2/2] hw/ppc: Fix memory leak in get_cpu_state_data()
Message-ID: <4kof4anqdtbanmoillntmeo6gqgnr4noizmf4ugkarc2ejl72l@cc6ncrvwrgrj>
References: <20251028065815.84156-1-shivangu@linux.ibm.com>
 <20251028065815.84156-2-shivangu@linux.ibm.com>
 <94cebbf2-5883-4fa7-9b86-f8bf0f3332c1@linaro.org>
 <5f16773a-e7f6-445a-a69e-ddeb62e61760@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f16773a-e7f6-445a-a69e-ddeb62e61760@linaro.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=6900727a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=t_OyuiPTES2zf-S82qoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DF4Fq74-uXnj6tSktO09aBBPhE6IMM3i
X-Proofpoint-GUID: DF4Fq74-uXnj6tSktO09aBBPhE6IMM3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfXyufUcAe4qds7
 8eT+Mebfa5VdusCjzTe//K5QaFEmpK3tINgyVqSL1ltth9i0RvO+YKw+SlHPyKbCB4Zk5ReoQZO
 JkX8GvdzPaAMJMZanlgT7N/V9dn+1nytrmG8LbWc6VEGGpEJkgfIpV8rCElvldkhN2hg8pUY3Ym
 xCJzKewnXksOgNh8dXUP0qgbH8Zy0MCvvcJY7vqwnNCVFsqqoHc0fKdra512SOqVRnIPDVa/GKh
 f4TS+SBwAve5IXdsNLmjKUS72lgt8blQ7PNTHHroGhBKBUh2lHDJlI/pZHY1JQ3eLOnHVQdsG2T
 4LHZ97tTDozevORQARWLJujs5cRCFnyF5Fv/XbAtAyxhblVVdcaWfU2MugMPStJcTZ37MiyDNAx
 uiHCx4cWbAWVMrq1Az57n5ZW5HoWfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
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

On Tue, Oct 28, 2025 at 08:30:05AM +0100, Philippe Mathieu-Daudé wrote:
> On 28/10/25 08:12, Philippe Mathieu-Daudé wrote:
> > Hi Shivang,
> > 
> > On 28/10/25 07:58, Shivang Upadhyay wrote:
> > > Fixes coverity (CID 1642024)
> > > 
> > > Cc: Aditya Gupta <adityag@linux.ibm.com>
> > > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > > Link: https://lore.kernel.org/qemu-devel/
> > > CAFEAcA_Bm52bkPi9MH_uugXRR5fj48RtpbOnPNFQtbX=7Mz_yw@mail.gmail.com/
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > > ---
> > >   hw/ppc/spapr_fadump.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> > > index 883a60cdcf..49d2f862a1 100644
> > > --- a/hw/ppc/spapr_fadump.c
> > > +++ b/hw/ppc/spapr_fadump.c
> > > @@ -453,7 +453,7 @@ static FadumpRegEntry
> > > *populate_cpu_reg_entries(CPUState *cpu,
> > >   static void *get_cpu_state_data(uint64_t *cpu_state_len)
> > >   {
> > >       FadumpRegSaveAreaHeader reg_save_hdr;
> > > -    FadumpRegEntry *reg_entries;
> > > +    g_autofree FadumpRegEntry *reg_entries;
> > 
> > g_autofree pointers have to be NULL-initialized. I don't remember why,
> > likely CPP warnings.
> 
> Ah, see for example commit c8f48b120b3:
> 
>   As mentioned in docs/devel/style.rst "Automatic memory deallocation":
> 
>   * Variables declared with g_auto* MUST always be initialized,
>     otherwise the cleanup function will use uninitialized stack memory
> 
> and for full context, commit 821f2967562 ("docs: document use of
> automatic cleanup functions in glib").
Hi Philippe,

Thanks for fix and explaination.
I'll send out v2 soon.

~Shivang.

