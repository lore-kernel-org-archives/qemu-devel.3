Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732B0C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x60xX-00043y-Fl; Mon, 14 Sep 2026 03:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x60xN-00043P-46; Mon, 14 Sep 2026 03:18:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x60xL-000421-G6; Mon, 14 Sep 2026 03:18:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E61mb63528160; Mon, 14 Sep 2026 07:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=M3q+3B
 pnln3UJRny9EG4NlwhQCV6NJjA7YHzoTxKO5k=; b=n+O24EYdMj3lgPzPEslY8e
 hurRGnEhdv8QH584ihapMNQUPqayDuarHfnTCM8MxTw97CUGXD34xFSnG4eOgyX1
 /tCM2H0ODkmY0Q4jFvjnchoBBFfEDsSquhf4l/4QxLFjUpdS3wuHHSVAD3k1yfUG
 BOJ6phAtel1Ctt/LTThImEo9PzPYP5DQYElzm9wF1LW4D13UGgVkFPB7Ty2pAjlw
 XkQPA8LyhejNR5ZD9prlEndjR/XPwPhEEzQF7UN0Gj2YNJ5Qdp27p9DdgjgKH2V5
 OfmYCz1vrDK1MR8/18S5YCS7JGbPolK68davKcEajVc4kkzDwBBNCoX0U8ncKouQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdpyr2m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:18:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5o2N31805295; Mon, 14 Sep 2026 07:18:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry49nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:18:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68E7I11J9240990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 07:18:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D60020043;
 Mon, 14 Sep 2026 07:18:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AF302004B;
 Mon, 14 Sep 2026 07:17:59 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 07:17:59 +0000 (GMT)
Date: Mon, 14 Sep 2026 12:55:44 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 30/62] hw/ppc/spapr_caps: fix property type name
Message-ID: <20260914125231.b5029ef4-c8-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-30-7732a55b7760@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-qom-qapi-v5-30-7732a55b7760@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX6ZYOjI1AkSyA
 xAnMfB0Ws7J2aViQB0B307tKy4ayVW4nU+IDwCLkF2NgCfxboHiFyyPM/7gjkDvH0Nw2QpYywZi
 qGppQB3RVYv98QmKgdTIlIvGWkclnOZP36qFbXsJPmdyFnxPAQK0j7Q6aX74Fg0PZdubgXGXTIL
 PRxQbVfbwjaqXxLFVLYYrYHdoDx2iXbU0vx8scTOLwV+JZdZYatLqKRzzykT8CXmELnb2GxdwGw
 LKIVCJilc+AVSw0ZEqJhQWAE3k2zjA4Ew5kQ0cTRVPsePrXQsoYlP4BEFgV9Vk0xzvTywh08Ew4
 K8fkvou4wdzR8Bg63CQ/yyKejd0Lg4X4zDOoGXFB8xctt2sZa8J59QEs75ht/yArNRyTt30LlEo
 xkSkJ1zaaDXCnpH/Xlq+OcNUEdjkZCUQOa5c2jOzc81X9vasC78+ClGwT01E7U8uoVONoYZV/Tr
 5locTFyx6EhWkFVt8vA==
X-Proofpoint-GUID: 1yGKIMd8VsjFIHy3F5VEx87pwEcBvmA7
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa79fae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=7aV8F40rmipMVjx5j7MA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: Zm7ZBLQcEmT10JVotVIewQe4s0BU4JS0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX+NsEAWpLf1/+
 ClnI8dFTj4ldGhVWKlMxxx3UJNFHq8+PT6xgFQSauVqetm2rxtjPdTr7TBVRD7FrrFth3zbwvNQ
 x6tDxRFyrHyX/kJTnG1QhMFb/Qf0T0U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Marc,

On 2026/09/11 08:35 PM, Marc-André Lureau wrote:
> The getter/setter use visit_type_size(). Fix the type name mismatch.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ppc/spapr_caps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 0d659e9b0251..103b17364feb 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -784,7 +784,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_HPT_MAXPAGESIZE,
>          .get = spapr_cap_get_pagesize,
>          .set = spapr_cap_set_pagesize,
> -        .type = "int",
> +        .type = "size",

Thanks for addressing the HPT_MAXPAGESIZE type fix from v4.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>          .apply = cap_hpt_maxpagesize_apply,
>          .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
>      },
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
> 

