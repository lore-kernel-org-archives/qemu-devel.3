Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A45CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 05:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLEEB-0003VL-F6; Fri, 08 May 2026 01:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wLEE7-0003V6-9J; Fri, 08 May 2026 01:58:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wLEE4-00068D-Ck; Fri, 08 May 2026 01:58:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6483JfLf3967125; Fri, 8 May 2026 05:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=l4L6gyFKPXWS4JtGDTKyu+skuDf9o/
 +7ZvgjuXgSz84=; b=Wfk65P17gHuHij1nLf2guVA/4jY/TQF9e7FMmQ/BV6K5AY
 VhA5t+jh/5QYI5smTnUwnrpyZQG9jTX9AN2+PHGNpWnGD2z62MaN/U8QVydfWBjO
 WO7j5TSPjo9CL/gBCv9RhF+brAIkWwzIwwW8yFAyHbm2hrmmgoVlIsYTS6S4HM+j
 7mMqVjmFZqSNWCioA7hOHsHcEMst6q7dsOw1chz8oF3KBoGFxzi8tFGCsTkJ5W+X
 g7lzlS32uO3xAYJVdEzUFqxE3WWEjtU3K4+tNBPdxuYE/VGNJChihClXoGeMLdcp
 7UbkvUwHiERT6GFRZZh0bsVgUT4misJgtSGlkJ+w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7t9jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 05:58:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6485sN9a022767;
 Fri, 8 May 2026 05:58:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgprcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 05:58:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6485w7Tx20840760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 05:58:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9A2120043;
 Fri,  8 May 2026 05:58:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33EAB20040;
 Fri,  8 May 2026 05:58:04 +0000 (GMT)
Received: from Amits-MacBook-Pro.local (unknown [9.39.21.199])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri,  8 May 2026 05:58:03 +0000 (GMT)
Date: Fri, 8 May 2026 11:27:59 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
Message-ID: <20260508110407.6eeeb01e-d6-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20260504134344.38958-1-amachhiw@linux.ibm.com>
 <af1ynfIuksZKDFau@Gautams-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1ynfIuksZKDFau@Gautams-MacBook-Pro.local>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA1MyBTYWx0ZWRfX8BjIcEQuF5Gt
 amZFZD6erdK6XIbEVK+0PealQUKf+wRSytqjAJ+lf0vvmD94rwbJ1D26zI1kpcbubf7mS8gYDkr
 C/dWxNZEWS8O2NISaepBuyC/dGasnnPk3EMCRL843ur6is1coAMN/CDd9jcdZoOvTUYNh1x4whA
 1jIGwKyl5qkkFa22BoiB3avAlI25/vi0qEpJCK0gYIbA4acfQ+qhytHine0jCS8zSLRh+4VdrSB
 b02h/1Bmte1O6iiXN4Rcywg5hXOXRtfymLE38sJbA/eyWC/O9EJbVOHHnuYw2Z4buWNWRzyEtO9
 Vr3MB7Y1oWJNfCeOHtagfMhuz0OBisqaoDnvSnW0haTfoqxSU4UHxCFk9wdI1wYc9LKtT6SO9du
 xphrglEWICQE0SGQLBtrLgbOK1sNHGDywRt7dTJohKJIXouzwsgQNVEnl4rIMsNWYWDnOzQDYp5
 E0g6ANVDb+KANDuqAVQ==
X-Proofpoint-GUID: nUR91scsPLY2BKqxhXb9i0krL0wJTTKU
X-Proofpoint-ORIG-GUID: aeTqjDdasM9EArhfYfsmEILMQaREgtXe
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fd7b74 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=7JIn7IvpgBoFcJ94maEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080053
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Gautam,

Thanks for taking a look. Please find my response inline below:

On 2026/05/08 10:50 AM, Gautam Menghani wrote:
> On Mon, May 04, 2026 at 07:13:44PM +0530, Amit Machhiwal wrote:
> > GCC 16 tightens diagnostics around const correctness and now correctly
> > rejects attempts to modify strings referenced through const-qualified
> > pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
> > is defined as const char *, but the code was using strstr() on it and
> > then modifying the returned pointer in-place to strip
> > POWERPC_CPU_TYPE_SUFFIX.
> > 
> > This results in a write through a pointer derived from const data,
> > triggering a build failure with GCC 16:
> > 
> >   error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> >         suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> >                ^
> > 
> > Fix this by duplicating the model string into a mutable buffer using
> > g_strdup(), storing it in the alias table, and then performing the
> > suffix truncation on the mutable copy.
> > 
> > This preserves the existing behavior while avoiding modification of
> > const data and ensures compatibility with newer compilers.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >  target/ppc/kvm.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 25c28ad089c6..e71e5c0117da 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2654,10 +2654,12 @@ static int kvm_ppc_register_host_cpu_type(void)
> >      dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
> >      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
> >          if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> > +            char *model;
> >              char *suffix;
> >  
> > -            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> > -            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> > +            model = g_strdup(object_class_get_name(oc));
> > +            ppc_cpu_aliases[i].model = model;
> > +            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
> >              if (suffix) {
> >                  *suffix = 0;
> >              }
> > 
> 
> A const char * variable is ideally supposed to point to an immutable
> string. But even with this fix, the string that
> "ppc_cpu_aliases[i].model" points to is being changed after assignment.

Thanks, I get your point. The write in my version is to the mutable buffer
returned by g_strdup(), so it is not strictly a const write. I had originally
trimmed the duplicated buffer before assigning it to ppc_cpu_aliases[i].model,
but later reordered it to stay closer to the existing flow. Still, I agree with
the suggested cleaner ordering. I will update it in the next revision.

Thanks,
Amit

> Would the below diff (untested) be a better fix?
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 41bd03ec2a..a84e4b4636 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2654,13 +2654,14 @@ static int kvm_ppc_register_host_cpu_type(void)
>      dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>          if (strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> -            char *suffix;
> +            char *suffix, *model;
>  
> -            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> -            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> +            model = g_strdup(object_class_get_name(oc));
> +            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
>              if (suffix) {
>                  *suffix = 0;
>              }
> +            ppc_cpu_aliases[i].model = model;
>              break;
>          }
>      }

