Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028DFC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x60zS-0005P3-4g; Mon, 14 Sep 2026 03:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x60zO-0005OQ-GZ; Mon, 14 Sep 2026 03:20:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x60zM-0004fz-7H; Mon, 14 Sep 2026 03:20:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E620HM1243556; Mon, 14 Sep 2026 07:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eakFab
 f0S3DYZaDXbPkA0O5rOUJY/iFdMyBNf04aScg=; b=iDBhGoysffzspNurlwbS+F
 zx6L4fXW34OCGuQui7Hi5wvpCDEw71enCqRw7ohKLLNPJuOYT5O5gKMcV1Nffj/q
 o8XFtU9SSGUrxoAZJFLI/33Z1GUnhHnK2NN7c0e4EuSNvUq72qLspcqJ5rvcX4JD
 86QWiIMXDcE61/5Ka1eHL/5Xhr1jwkgY+SxY60p425hUX8kxn4CJ2DhTr4jhkXqh
 bvNPXXSOYeINbZN00iGCAWuGYnczD49QvkJI+zew6Lp5EsHcSAU1KtuGAUYOsL6y
 poSzEe36rBX/LyoTJFScpVU+DBYNQdTF7Fv8vnUHXJmiRQoqxTX1a2MUNDez9cxg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcuqk6f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:20:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5o2FS1805292; Mon, 14 Sep 2026 07:20:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry49wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:20:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68E7KJeA54526384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 07:20:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18F6B20043;
 Mon, 14 Sep 2026 07:20:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEE022004B;
 Mon, 14 Sep 2026 07:20:16 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 07:20:16 +0000 (GMT)
Date: Mon, 14 Sep 2026 12:58:01 +0530
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
Subject: Re: [PATCH v5 31/62] ppc/spapr-caps: convert to QAPI-aware property
 registration
Message-ID: <20260914125709.32fc3bf4-08-amachhiw@linux.ibm.com>
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
 <20260911-qom-qapi-v5-31-7732a55b7760@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-qom-qapi-v5-31-7732a55b7760@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX/MjKSIPtW1LX
 o5026QYbDAcrJoE1YAVBEWy1UqTi9UqbIXi7BhpuKZ12bHKslO3IrII/bbbdNpushrVMuUBdogY
 GEjdSlE2utYulixcQJB8vZ6jWTFw6dk=
X-Proofpoint-ORIG-GUID: QNDeV_hKLzeb4BUpHevnWb6z-8-iI3r2
X-Proofpoint-GUID: _Tt-aPJsph7VYhWkOjbRwvM6nIAu7FMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX+HHLsgh9SpDM
 LORRUiK1i8/3C04xvWbJySPKMTDpWBHZ6KclR7rTvGHH8mn0DjCwmh10EKr7/h7fMMWba+Rdq0v
 Bf9TwBrJ/vnhLoV88LSxBJ02q3RB+FuXq1tI0yYCUa3Lsra0k2vhcO+R9/OcbhDcyCIfi/rtYGV
 rwELbQVkcdM5kGW6eMBhh1ukRHRPrIrylwKN7PD2Yas7LXIpgUcRPmSlxuBZe/GeMuLgs0ewutX
 /5pCzl5PAZK0iCPc3+1D3SP2PPGlzAQ20zJNzE4YloLDSqteq3vhKoHXnFi8Ll8LcqqlD/8S4hv
 o0pdUjZDFcA4nwoN5fDJN56k5bUz7YRhaAjDZeTqFx3rf59mjdaWn9WMBWQ8hstVKjQiXWS4Cgv
 +HkR2Jgn2BUKljCYhLaeJNKXe3vpCrVsjykeCd0lpZ7W62eBxv0WiIpwBwNnA8YOQQ2lAKpIFGs
 z3hJqvbpj6ZAQjRo3mw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa7a039 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=4OYFiqDFVgDF6Dc6gsgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/09/11 08:35 PM, Marc-André Lureau wrote:
> Replace the type string in SpaprCapabilityInfo with a QAPITypeInfo
> pointer and switch spapr_caps_add_properties() from
> object_class_property_add() to object_class_property_add_qapi().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ppc/spapr_caps.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 103b17364feb..e622c79eb52a 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -24,6 +24,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "system/hw_accel.h"
> @@ -59,7 +60,7 @@ typedef struct SpaprCapabilityInfo {
>      /* Getter and Setter Function Pointers */
>      ObjectPropertyAccessor *get;
>      ObjectPropertyAccessor *set;
> -    const char *type;
> +    const QAPITypeInfo *type;

Clean conversion; with patch 30 landing first, the full capability_table is now
consistent.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>      /* Possible values if this is a custom string type */
>      SpaprCapPossible *possible;
>      /* Make sure the virtual hardware can support this capability */
> @@ -725,7 +726,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_HTM,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_htm_apply,
>      },
>      [SPAPR_CAP_VSX] = {
> @@ -734,7 +735,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_VSX,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_vsx_apply,
>      },
>      [SPAPR_CAP_DFP] = {
> @@ -743,7 +744,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_DFP,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_dfp_apply,
>      },
>      [SPAPR_CAP_CFPC] = {
> @@ -752,7 +753,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_CFPC,
>          .get = spapr_cap_get_string,
>          .set = spapr_cap_set_string,
> -        .type = "string",
> +        .type = &str_type_info,
>          .possible = &cap_cfpc_possible,
>          .apply = cap_safe_cache_apply,
>      },
> @@ -762,7 +763,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_SBBC,
>          .get = spapr_cap_get_string,
>          .set = spapr_cap_set_string,
> -        .type = "string",
> +        .type = &str_type_info,
>          .possible = &cap_sbbc_possible,
>          .apply = cap_safe_bounds_check_apply,
>      },
> @@ -774,7 +775,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_IBS,
>          .get = spapr_cap_get_string,
>          .set = spapr_cap_set_string,
> -        .type = "string",
> +        .type = &str_type_info,
>          .possible = &cap_ibs_possible,
>          .apply = cap_safe_indirect_branch_apply,
>      },
> @@ -784,7 +785,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_HPT_MAXPAGESIZE,
>          .get = spapr_cap_get_pagesize,
>          .set = spapr_cap_set_pagesize,
> -        .type = "size",
> +        .type = &size_type_info,
>          .apply = cap_hpt_maxpagesize_apply,
>          .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
>      },
> @@ -794,7 +795,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_NESTED_KVM_HV,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_nested_kvm_hv_apply,
>      },
>      [SPAPR_CAP_NESTED_PAPR] = {
> @@ -803,7 +804,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_NESTED_PAPR,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_nested_papr_apply,
>      },
>      [SPAPR_CAP_LARGE_DECREMENTER] = {
> @@ -812,7 +813,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_LARGE_DECREMENTER,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_large_decr_apply,
>          .cpu_apply = cap_large_decr_cpu_apply,
>      },
> @@ -822,7 +823,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_CCF_ASSIST,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_ccf_assist_apply,
>      },
>      [SPAPR_CAP_FWNMI] = {
> @@ -831,7 +832,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_FWNMI,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_fwnmi_apply,
>      },
>      [SPAPR_CAP_RPT_INVALIDATE] = {
> @@ -840,7 +841,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_RPT_INVALIDATE,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_rpt_invalidate_apply,
>      },
>      [SPAPR_CAP_AIL_MODE_3] = {
> @@ -849,7 +850,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_AIL_MODE_3,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_ail_mode_3_apply,
>      },
>      [SPAPR_CAP_DAWR1] = {
> @@ -858,7 +859,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .index = SPAPR_CAP_DAWR1,
>          .get = spapr_cap_get_bool,
>          .set = spapr_cap_set_bool,
> -        .type = "bool",
> +        .type = &bool_type_info,
>          .apply = cap_dawr1_apply,
>      },
>  };
> @@ -1069,9 +1070,9 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
>          g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
>          g_autofree char *desc = g_strdup(cap->description);
>  
> -        object_class_property_add(klass, name, cap->type,
> -                                  cap->get, cap->set,
> -                                  NULL, cap);
> +        object_class_property_add_qapi(klass, name, cap->type,
> +                                       cap->get, cap->set,
> +                                       NULL, cap);
>  
>          object_class_property_set_description(klass, name, desc);
>      }
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
> 

