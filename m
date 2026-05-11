Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CECD37B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 12:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMPag-0006MH-2I; Mon, 11 May 2026 08:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wMPaG-0006LG-Dt; Mon, 11 May 2026 08:18:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vaibhav@linux.ibm.com>)
 id 1wMPaB-0005MR-E7; Mon, 11 May 2026 08:18:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B3T7fH411676; Mon, 11 May 2026 12:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=0K53jjqfae16cP28A9TaGc3hdifIcE
 X/yzHPUrsaOSw=; b=kyHNcO7MwOuLE9C4LdEKkokWGy/TP6ai4tDy+k/BRgPtpF
 NFRM3FeE/IOvFEv6jnyrTdMUt0/OMu/0ksoez899I0icekRbI7B1XoQwqw6eTUdt
 QrVaMaRWyytKsEUYsXlOoQo1sAiNROC7aUyBJiWOgID8XBaUYxJjtgRzx6P8MGdm
 Vw1ns08KMZIRmuYfZ9zJhT6BSpY8DGjgrWt5s2SFUOP5d7HDLFaZJfxOOW5+U0ER
 lA3Du3Hm76t00wwNYXeXH1dRjfpvS6pjfYek6OrDM5XPJwaNa+EcEBK/UvlGqrnu
 9do1cVXDBa24DtNvBZQZ0tpO2g1rAwreorekCuoA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqr4a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 12:17:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BC9LV2023927;
 Mon, 11 May 2026 12:17:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg4yxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 12:17:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BCHqBi30605962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 12:17:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 674FF5805E;
 Mon, 11 May 2026 12:17:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24FBA58050;
 Mon, 11 May 2026 12:17:47 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.25.174])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with SMTP;
 Mon, 11 May 2026 12:17:46 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation);
 Mon, 11 May 2026 17:47:45 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Chinmay Rath
 <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH] target/ppc/kvm: Fix const violation when trimming CPU
 alias suffix
In-Reply-To: <20260504134344.38958-1-amachhiw@linux.ibm.com>
References: <20260504134344.38958-1-amachhiw@linux.ibm.com>
Date: Mon, 11 May 2026 17:47:45 +0530
Message-ID: <87se7yuoly.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEzNCBTYWx0ZWRfX1WVo1hcAhzi9
 GmoMSO/ZV/NIEUyE3CzTYXpJ/8bTH/FWCvB38oH+mvVuepfLIvAvX/SWoxWESdG2wRiJYOs0MU/
 rxpgvoCrlJhJPjmDjKkDApJB2Dk9rv7d39EZzWR7qe40p/F1j928wlxhbICbEQ+Gd9B+XUNU4VP
 hjiDWjyeq5CZgJi/60Y14SUybr5LNcXvFw7jfKqs8YeBAwVlWDPDlsrmNox2zHWDgJCGLXoj/Lh
 mURp63j/ql/8GkFxE+90AMm0sXvOvm5MApxvWsM+p+ozcIEnfyVIYl2aacyh07gqHBhEjF/wtpp
 68I616DQ21cuRighZW5Z4148NCoPO0Qj+Ry00i12E/QiDfB92gcolFBuq6uZUEUbM677Cp5y5jQ
 BWAzsQ+qbwQcrKhawAAi4YMsVZblhONdcWqEm3pwNuqNm8LyVIeW1jmZwgY9vWaYwOo+XqeQMWD
 A6+dJl5E/SOvsHPqdNA==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a01c8f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=T9yhNPrwiyhr9k64Qx8A:9
X-Proofpoint-ORIG-GUID: j-v9Gxpy9f7k_K6ifG5sIEFQZ2Z7a2vc
X-Proofpoint-GUID: 2a_VYNzaguWeEnFp87X4b2HBHanWI1TI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vaibhav@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Amit,

Thanks for reporting this an proposing a fix. My review comments below:


Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> GCC 16 tightens diagnostics around const correctness and now correctly
> rejects attempts to modify strings referenced through const-qualified
> pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
> is defined as const char *, but the code was using strstr() on it and
> then modifying the returned pointer in-place to strip
> POWERPC_CPU_TYPE_SUFFIX.
>
> This results in a write through a pointer derived from const data,
> triggering a build failure with GCC 16:
>
>   error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>         suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
>                ^
>
This looks more like an aliasing issue for the pointer returned by
g_strdup and it being used between const and non-const contexts.


> Fix this by duplicating the model string into a mutable buffer using
> g_strdup(), storing it in the alias table, and then performing the
> suffix truncation on the mutable copy.
>
> This preserves the existing behavior while avoiding modification of
> const data and ensures compatibility with newer compilers.

I think the better approach would be to avoid modifying the value
returned by g_strdup before its assigned to 'ppc_cpu_alias[i].model'
struct member.

>
> No functional change intended.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  target/ppc/kvm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 25c28ad089c6..e71e5c0117da 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2654,10 +2654,12 @@ static int kvm_ppc_register_host_cpu_type(void)
>      dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
>      for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
>          if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
> +            char *model;
>              char *suffix;
>  
> -            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
> -            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
> +            model = g_strdup(object_class_get_name(oc));
while we are at it lets also handle ENOMEM error and trickle it back to arch_kvm_init()

> +            ppc_cpu_aliases[i].model = model;
> +            suffix = strstr(model, POWERPC_CPU_TYPE_SUFFIX);
>              if (suffix) {
>                  *suffix = 0;
>              }
>
> base-commit: ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1
> -- 
> 2.50.1 (Apple Git-155)
>
>

I have done the above proposed changes in a separate patch which i will
post in some time.

-- 
Cheers
~ Vaibhav

