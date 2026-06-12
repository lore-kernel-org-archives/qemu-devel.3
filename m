Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3C9CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXvs2-0001I1-LO; Fri, 12 Jun 2026 03:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wXvs0-0001Gi-46; Fri, 12 Jun 2026 03:00:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wXvry-0002AD-IG; Fri, 12 Jun 2026 02:59:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BM037V1363883; Fri, 12 Jun 2026 06:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=SoQhs5IBwsmBNZu0QxxcnSQ5YWdxop
 PMjg7aDd0u5a4=; b=Mysy+/LoSOOudNV2bqQPQU+apEtCA6TpUBK3HM6uTx/X+r
 RSB55RB65PYERtSeLpGIsISkgnZalGQYSQkVcpeJ8OmrAEQkL98/5B8gtuZqqyr1
 WzYbYUrf9HUDEy8VHT2t8/Knu/A9ENQZbuaJrHIQ43NPvZGEemxgIF+fWBQHsNeS
 ZQASWzKsp50XdlQAHa9IMl1GJbrSXfo5t3qJz3FmMz5rw1Up7Y0wPWNM+ku7mOZJ
 w1p6hegxII7Za9kkS6bS4lcC0wPtMAmCDUV4z0dpzcGF55050i4PWrp9ISXkMfyq
 TVimQ+mZVoJIR4R2v66Fqka32WEo3XWbrW2UxJjg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dyau5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 06:59:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65C6ngr8023906;
 Fri, 12 Jun 2026 06:59:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08xpqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jun 2026 06:59:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65C6xdFq39715188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jun 2026 06:59:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D344920043;
 Fri, 12 Jun 2026 06:59:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7175C20040;
 Fri, 12 Jun 2026 06:59:37 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 12 Jun 2026 06:59:37 +0000 (GMT)
Date: Fri, 12 Jun 2026 12:29:43 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Penney <matt@matthewpenney.net>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/qtest/libqtest: Use GLib functions for proper
 const correctness
Message-ID: <20260612122835.ede570b2-b5-amachhiw@linux.ibm.com>
Mail-Followup-To: qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Matthew Penney <matt@matthewpenney.net>, 
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
References: <20260522082555.54918-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522082555.54918-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HQSYbt1hHjS48LAXLEGCbwsHB-PuyFEK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA1OCBTYWx0ZWRfX0v+BWkq5yxyo
 ZRAc+48G+7zKeZzb+SZAmi06TfxOu6vxBp0y+CI2DTIgAbj6xoyUElQAp6KyZqvI8rTQLmW1rQu
 iLzzsUn0fUgrcFveP2ymtuKYdtAh6zXTCgDWLV+XoJj30FifCBCNP3a6yX1aUNk8eWp3XB6Ew84
 TlbpbdD+JcRe683rCkMiMzYvWzwxgfFwEbjWVKOX03q8c7S3b/iIkppw0lvhj3GmD0yt1vBEm2B
 Za4r9MWzDjYIHhWJxJ8WRB3B1IYxYZJIgWs1olTf638MUx9IRiOYHmbRFksBw25qq74rHG/Ea2B
 NHkuRuyzwEv9PUADIPXQY3uex4CA0suxyRIbdgizYzjbAvMvsBzJZ0g94gPj7cJ04nf1IxP2yCn
 MRoiAHXFkPPG7VH+x+VB/kr68c9AHdLreG17dPXguU0oQYTydX/1f8FV6hOOX8+oRDtJtEDDxGX
 ypn0ZcdC6DbTWa1NvNQ==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2bae60 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Rm5dszXykPjf8xqRIG0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA1OCBTYWx0ZWRfX5wOYX/Il0J3H
 KShSzXUap+ycQfTtcOYQVvoImEb8DHqBD8fEh/J5XVZoOpgzD0UyLZXBGuap5yiJvZc53hGxNmF
 2UZGFHuQWMQSSfn2lB/63etAamFh4rM=
X-Proofpoint-ORIG-GUID: HQSYbt1hHjS48LAXLEGCbwsHB-PuyFEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120058
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Fabiano, Laurent,

Did you have any review comments on this patch?

Shall this be picked via your tree?

Thanks,
Amit

On 2026/05/22 01:55 PM, Amit Machhiwal wrote:
> While commit e68da5b7a2cd ("tests/qtest: fix discarded const qualifier
> warning") addressed the immediate strstr() warning by making 'found'
> const, there's still a room for improvement: getenv() returns char *, but
> environment strings are semantically read-only and should be treated as const
> throughout their lifetime.
> 
> Replace getenv() with g_getenv() and strstr() with g_strstr_len() to
> maintain const correctness from source to use. This approach:
> 
> - Uses g_getenv() which returns const gchar *, matching the read-only
>   semantics of environment variables
> - Employs g_strstr_len() for consistent use of GLib string functions,
>   aligning with QEMU conventions
> - Eliminates all const-correctness warnings with strict compilers
> 
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> v2:
> - Rebased on top of e68da5b7a2cd ("tests/qtest: fix discarded const qualifier warning")
> - Split from previous patch series and sent as standalone patch
> - Updated commit message to clarify relationship with prior fix
> - Retaining tags from previous version as no major changes
> 
>  tests/qtest/libqtest.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index b1e06ea364ec..cb80ab23182a 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -2145,8 +2145,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
>  
>  bool qtest_verbose(const char *domain)
>  {
> -    const char *log = getenv("QTEST_LOG");
> -    const char *found;
> +    const gchar *found, *log = g_getenv("QTEST_LOG");
>  
>      assert(domain);
>  
> @@ -2172,11 +2171,11 @@ bool qtest_verbose(const char *domain)
>           *  QTEST_LOG=<domain1>,-<domain2> (only false for domain2)
>           *  allows other separators, except - and +
>           */
> -        found = strstr(log, domain);
> +        found = g_strstr_len(log, -1, domain);
>  
>          if (found) {
>              /* reject options given twice */
> -            assert(!strstr(found + strlen(domain), domain));
> +            assert(!g_strstr_len(found + strlen(domain), -1, domain));
>  
>              if (found > log) {
>                  ptrdiff_t i = found - log - 1;
> @@ -2190,7 +2189,7 @@ bool qtest_verbose(const char *domain)
>               * If filtering out a specific domain, all others are
>               * enabled.
>               */
> -            return !!strstr(log, "-");
> +            return !!g_strstr_len(log, -1, "-");
>          }
>      }
>  
> 
> base-commit: f5a2438405d4ae8b62de7c9b39fac0b2155ee544
> -- 
> 2.50.1 (Apple Git-155)
> 
> 

