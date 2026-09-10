Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946B9C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jmA-0005Sy-Dr; Thu, 10 Sep 2026 14:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x4jm9-0005SS-0r; Thu, 10 Sep 2026 14:45:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x4jm7-0005TN-2e; Thu, 10 Sep 2026 14:45:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIVZsN2548424; Thu, 10 Sep 2026 18:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yZ0OSc
 WZg8qXgoi8BMBXkIwWPyCO99YxHLvxZOAhZKs=; b=JZwV3XoZAqURM0cQL4rdVq
 u2hSVF0HhWf9q/5uwuTZtEqZrmUXF5nylsXqWwuFQw/ZhHGGhvVkkzy7bF1mKnLw
 JVi4PCJQ8Mzw1ELAPkSpXzUN4MF9TO7M089vEHJ6uTOazsfxdEgH4r5MfGzGZ1sq
 hk5AskBOeqAOW+QopfSkoQLfgmXdwo5Fns461zV0Fqi63z5cmeGAu5Fnxk7diTlh
 ygTv/BNKir8u/1yU9sCsBpHnqmbCG3ltYlM4fZIJLtVTjlATJMQLIwfYNoZBgQ20
 gZB/VmYXzwz+Cy+IA7za/YRpXEdtlzFKWhI0ckerEK8/z8/FkIKHzEFBv04906Jw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8q6q7c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 18:45:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIZBk5447279; Thu, 10 Sep 2026 18:45:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtf9tv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 18:45:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68AIjJd545613322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Sep 2026 18:45:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1CB02004F;
 Thu, 10 Sep 2026 18:45:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BD6F20040;
 Thu, 10 Sep 2026 18:45:17 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 10 Sep 2026 18:45:17 +0000 (GMT)
Date: Fri, 11 Sep 2026 00:23:02 +0530
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
Subject: Re: [PATCH v4 30/75] ppc/spapr-caps: convert to QAPI-aware property
 registration
Message-ID: <20260911000458.a11b142b-df-amachhiw@linux.ibm.com>
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
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-30-a985f168e938@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904-qom-qapi-v4-30-a985f168e938@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VceWiG9R5P7rDzK6pk0skopLG9RokiaN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIyOSBTYWx0ZWRfX0ymxZoJj0TdN
 Z5su+eN5/Nh8vL0lU+2aDbtZ/qpRcnUqGIbxZF24DZLz8L5cQh7zRHyr6z7EXsdmWCHHL9qoqf+
 8xa8Ua/OI4CDgVQ4UM9OmIwnD4ZayXg=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa2fac4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=bn9aj2a_gXV3IQsBOqkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIyOSBTYWx0ZWRfXzG1Vu566dYHr
 +zQOUIXnSZijJetDhsvjFB4z2o0tcnVw7d67598kN47PaVwJKnmPS6TDCKlWFeHGTDL3xcZ6Gkz
 1EqKunGk7lcxQrPwQxPk6iCE5zPZ7tMjElfQHi2o1ENb9Y+XxUoN8IPOrWOuJk6hdjm9MIcF73m
 +cDso45N+RT48f87fRUbVKJRNmqlwuFPouD955VXfSf81Abw+d0xdBleNH5WfENn2u4ZaypmuCQ
 VN+RS1vAuL8qkkBgkTQUExC/QLC0yLbsmLlGYQZW+r53QCvf2Ibh97oLF9hCfs+GBVBVkxZzZjs
 0BmS4YWBR+uZG0HlhN5eZ9T22tsiy8PBq795xRYNCywXG3Ox8lOWlVfQj/zor1QGB1LXWq69nDM
 fNO3/fc/cU2Odvchh1Ijuy/FAdRQdjmlkXUXw1SkKyX3f6hlIzhbQtIojpl2dsNj+Bit2Wf+N+N
 fiOVt2UTnPX1/cgiTrw==
X-Proofpoint-GUID: 30f0tYH9bRAYRQBS8Mgp_Ao1pidsWSu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100229
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

On 2026/09/04 11:58 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

The patch itself looks correct, but the commit message is missing a body.  At
minimum, it should describe what is being converted and why.

One thing worth calling out explicitly is `SPAPR_CAP_HPT_MAXPAGESIZE`.  This is
not a purely mechanical conversion: the old property type string was `"int"`,
while `spapr_cap_get_pagesize()` and `spapr_cap_set_pagesize()` use
`visit_type_size()`.  Thus, the property has effectively had size semantics
despite the old `"int"` type string.

Switching this to `&size_type_info` therefore also fixes a pre-existing mismatch
between the property's declared type and the visitor used by its getter/setter.
This seems worth documenting in the commit message so that future readers
understand that the change is intentional.

The conversion itself, including the switch to
`object_class_property_add_qapi()` in `spapr_caps_add_properties()`, looks
correct to me.

Thanks,
Amit

> ---
>  hw/ppc/spapr_caps.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 0d659e9b0251..e622c79eb52a 100644
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
> -        .type = "int",
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

