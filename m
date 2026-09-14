Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3995FC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x61ER-0001pI-TE; Mon, 14 Sep 2026 03:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x61EN-0001p1-GI; Mon, 14 Sep 2026 03:36:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x61EM-0007cP-0S; Mon, 14 Sep 2026 03:35:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E61o2E1220237; Mon, 14 Sep 2026 07:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rHdNjv
 klaWW7LOdnsOvLuDLEDH/0mFVVAEcI9FYaYWs=; b=bYpRcmo5LSCGq1CeSnyp+f
 WAnbBlrGDnANYCeKZn0dja0zGNjExNk0cdXxR5j+4feXuH6OPzxqtmOKlLgtok6b
 l6OFWAgwIah0VSw/f5Oc9Mf6LdC93+w55cvx+DHR47KJZmVW/G619mfx42NuS8Ct
 yLPltNd8E7E8juggWW6W8YMvFJZ+0SG1N7DdvU+14wuZQD6GB7ouMSN0Qp0fNevY
 mGYkLEK+KpFseXw4qZgp2GVs8Xg3os/NhFZxc9TbdWeFNSuRzVQeCtoKOQNp4TJU
 G38/qFnhhybAlSR057yJI+HA4oJIby/Z+93QrS4PSDLgeMOCrb4F1gKPbavyFBsA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4qtr8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:35:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5o4tM1813958; Mon, 14 Sep 2026 07:35:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pvs6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:35:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68E7ZnVg33817032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 07:35:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A95A92004F;
 Mon, 14 Sep 2026 07:35:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5152420040;
 Mon, 14 Sep 2026 07:35:47 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 07:35:47 +0000 (GMT)
Date: Mon, 14 Sep 2026 13:13:32 +0530
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
Subject: Re: [PATCH v5 43/62] hw/ppc/spapr_drc: convert fdt property to
 QAPI-aware registration
Message-ID: <20260914131311.70e5114b-43-amachhiw@linux.ibm.com>
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
 <20260911-qom-qapi-v5-43-7732a55b7760@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-qom-qapi-v5-43-7732a55b7760@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: x4jsmUU4TikMTctdfLYimTIQgjtqHnRc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfX2nvnmkouQoMY
 pWdTLNmFfZfNhSseBQ3kmAWaCKb5cc7jUbEZiOJqupPLWIVzTwbj1EDdmCIUOAZTQuVFyWGuAhi
 YmfZnO4BY19FH0yM7iCrFwD90b7gLOk=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa7a3da cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=Kck8WXiTZL7W0J7KWMoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: LF_Vov4HJKhkaTSyR1AVXhHOmsF1ZXjm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfX/0+I99hgsIpS
 nWLCi4fPUtkLysYEhpjE4iopCwYR0IbKEaWzS9a9Q1EJXWFqQ6iGPhM00BNvOllamgqmLbJ5gZg
 mLh3Yovo2bSrLXRUZjGs48grRqGLa/751GoL2QGzNydnEv0u7cMohgm587jVJHBL/Y9aICtGOmK
 e9EBJJrQQt0PKm95+G7gVLdPbbo8uCc07t1JNxGGvrQ5ct087NJ70Dbj9ju1+t+qKbodBgZk3La
 hglouU0ieptjcfiqGUzJSl2tM23YpvVypwZx1SB5rrE/QYLFp0RTeKXnh2yo+N+IX/4i73ec/UL
 8ZlbT76PcQMbsJNjymkXvMbXgm8Z2qfDsbCit3E5/h6CvaEMPSghgzwb0wLfNB473Xq0kdONMS9
 WFQmzc2QG80VGP4eua//Cqvmj5U2Eu3VDVfeMqwCK+l71L/REqYBmMOOZQR3jyI3YstlWlZghii
 c2iaV+UsXdatsB2tweA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140106
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

On 2026/09/11 08:35 PM, Marc-André Lureau wrote:
> Use object_property_add_qapi() with any_type_info for the "fdt"
> property, since the FDT structure is dynamically shaped at runtime and
> cannot be represented as a static QAPI type.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ppc/spapr_drc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 64f9ca29b02e..740149ffdf3e 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -587,7 +587,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
>      object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
>      object_property_add_qapi(obj, "index", &uint32_type_info, prop_get_index,
>                          NULL, NULL, NULL);
> -    object_property_add(obj, "fdt", "struct", prop_get_fdt,
> +    object_property_add_qapi(obj, "fdt", &any_type_info, prop_get_fdt,

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>                          NULL, NULL, NULL);
>      drc->state = drck->empty_state;
>  }
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
> 

