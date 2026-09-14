Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A47C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x61DE-0001IL-Na; Mon, 14 Sep 2026 03:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x61DA-0001HZ-Ta; Mon, 14 Sep 2026 03:34:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x61D8-0007Bg-KG; Mon, 14 Sep 2026 03:34:44 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E61dJn1073482; Mon, 14 Sep 2026 07:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mQa98I
 aU7My5VQjVnF7ikrI1jzmeJ+v71TzL14wdxtM=; b=BtnlTAwNJyxVVWeicqYUwD
 yA1v8Ih1GEqfcu3ZHMKZ1XLnABH7GWI2QuDThFS5Yn4kOZzWkOkKaacScW9UIiQa
 MEw0H+jx409DQgpqXPblhXmwW54QsOn+kO/YS+Q3KRazV07LJvWnFQ2h2RSxig/o
 DGrvF+y8Ip0xxazTOjrfXBF1IWEfWW81sMzLOXChW67yUqWmWH8HqtJm0tjRqLVq
 kZ9eq3emKolYCTvqkc6r0eB+5mOiZFbrqaWMLrDWc18zAcWGWX5c0J9IgvwktaMX
 2D+ZUTpOQ/fYkQMpLyAtgQo9SX9gnHxpO6fIQuPvrjP6evw+XhBl5QfHYAnxMRCQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hfyrt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:34:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5o2J41805292; Mon, 14 Sep 2026 07:34:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry4bkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 07:34:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68E7YXe027853118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 07:34:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA39220040;
 Mon, 14 Sep 2026 07:34:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BA9E20043;
 Mon, 14 Sep 2026 07:34:28 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 14 Sep 2026 07:34:27 +0000 (GMT)
Date: Mon, 14 Sep 2026 13:12:13 +0530
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
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v5 40/62] qom: replace object_property_add_tm with
 StructTm QAPI type
Message-ID: <20260914131054.221bddd2-26-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-40-7732a55b7760@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-qom-qapi-v5-40-7732a55b7760@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfX/WHARVlp2qPv
 tJgytX6t2dsEiqNzso0U1YvdEf6agfZ4yUZJN71bduMpjKJk+28u0vPZCdBn6fLCE82XZ0a794E
 zxzVHVDAiUmSNAG7bI/uG/m2xcCdu9B9bRq7GX6diSCneOHi5NVSIZRgjzfEDhYwxvpRdSTs+QH
 kK8scs1eZDmmzh4XWPbR+jJk24cPmvdWTb6uh/R6FeBIcXPwRU7IU+ZfYlL5zbvSkh1BkFw5xdA
 PIItUb62kPcMkO7wlOnWUk/9UJKpGCd4UaeFrJ7Fxr0FByCKNVIg/R8Omx8pk7YlgrCHHhzvJve
 L9J0S/K0nmgRL6UEAPf40A0aChuFffAcXJpA11PbUqLF0TUqE0jw0J2oaxsJMQKx/JEuPAvCx3K
 O6v+x6OzCtmVjN51SMD87dISSdg1xmJSW8sbNa8eZvIsldhuy+1KvFY9YLM5A5yshpX1DI2H0Ka
 PfAJ4w+3/MSx7o0wWIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwNiBTYWx0ZWRfXzTiv1cmR3Mcv
 Css5fHrveNu/kCHUPO5gdH/raWxLV006EEorEfDfbWHwJPafTkg5cB0SwIguwqBbEGYQ0+yz4pC
 DD/nT8Zw0y+0Be7fNVinQVTqjqE0OnI=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa7a38f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=hNSeHEs8RWfzZh7QNDEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: NIdb6z_qnVu9Op9Zuq7LjT-JgnL1YrZM
X-Proofpoint-GUID: fBpKG-uBzfVeR3_bEKv7B4iFnphC191u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140106
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
> Define a StructTm QAPI struct in common.json matching the existing
> "struct tm" property wire format (tm_year, tm_mon, tm_mday, tm_hour,
> tm_min, tm_sec as int32).
> 
> Convert the two callers (mc146818rtc and spapr_rtc) to use
> object_property_add_qapi() with a standard ObjectPropertyAccessor
> that populates a StructTm and calls the generated visitor.
> 
> Remove object_property_add_tm(), object_class_property_add_tm(),
> the TMProperty type, and the property_get_tm() helper from
> qom/object.c, along with their declarations in object.h.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ppc/spapr_rtc.c   | 18 +++++++++++---

Wire format is preserved; the positional compound literal initialiser matches
the field order in the QAPI definition.  For spapr rtc changes:

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

>  hw/rtc/mc146818rtc.c | 16 +++++++++---
>  include/qom/object.h | 29 ----------------------
>  qapi/common.json     | 28 +++++++++++++++++++++
>  qapi/pragma.json     |  1 +
>  qom/object.c         | 69 ----------------------------------------------------
>  6 files changed, 57 insertions(+), 104 deletions(-)
> 
> diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
> index 1f7d2d8f898b..a4a2b3237e26 100644
> --- a/hw/ppc/spapr_rtc.c
> +++ b/hw/ppc/spapr_rtc.c
> @@ -33,6 +33,9 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
> +#include "qapi/qapi-type-infos-common.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "qapi/visitor.h"
>  #include "qemu/cutils.h"
>  #include "qemu/module.h"
>  
> @@ -131,9 +134,17 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, SpaprMachineState *spapr,
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
>  
> -static void spapr_rtc_qom_date(Object *obj, struct tm *current_tm, Error **errp)
> +static void spapr_rtc_qom_date(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
>  {
> -    spapr_rtc_read(SPAPR_RTC(obj), current_tm, NULL);
> +    struct tm value;
> +    StructTm tm, *tmp = &tm;
> +
> +    spapr_rtc_read(SPAPR_RTC(obj), &value, NULL);
> +
> +    tm = (StructTm) { value.tm_year, value.tm_mon, value.tm_mday,
> +                      value.tm_hour, value.tm_min, value.tm_sec };
> +    visit_type_StructTm(v, name, &tmp, errp);
>  }
>  
>  static void spapr_rtc_realize(DeviceState *dev, Error **errp)
> @@ -150,7 +161,8 @@ static void spapr_rtc_realize(DeviceState *dev, Error **errp)
>      rtc_ns = qemu_clock_get_ns(rtc_clock);
>      rtc->ns_offset = host_s * NANOSECONDS_PER_SECOND - rtc_ns;
>  
> -    object_property_add_tm(OBJECT(rtc), "date", spapr_rtc_qom_date);
> +    object_property_add_qapi(OBJECT(rtc), "date", &StructTm_type_info,
> +                             spapr_rtc_qom_date, NULL, NULL, NULL);
>  }
>  
>  static const VMStateDescription vmstate_spapr_rtc = {
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index ba396435d1af..328dd038f167 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -42,6 +42,8 @@
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-misc.h"
> +#include "qapi/qapi-type-infos-common.h"
> +#include "qapi/qapi-visit-common.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
>  
> @@ -854,12 +856,19 @@ static const MemoryRegionOps cmos_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> -static void rtc_get_date(Object *obj, struct tm *current_tm, Error **errp)
> +static void rtc_get_date(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
>  {
>      MC146818RtcState *s = MC146818_RTC(obj);
> +    struct tm value;
> +    StructTm tm, *tmp = &tm;
>  
>      rtc_update_time(s);
> -    rtc_get_time(s, current_tm);
> +    rtc_get_time(s, &value);
> +
> +    tm = (StructTm) { value.tm_year, value.tm_mon, value.tm_mday,
> +                      value.tm_hour, value.tm_min, value.tm_sec };
> +    visit_type_StructTm(v, name, &tmp, errp);
>  }
>  
>  static void rtc_realizefn(DeviceState *dev, Error **errp)
> @@ -1019,7 +1028,8 @@ static void rtc_class_initfn(ObjectClass *klass, const void *data)
>      device_class_set_props(dc, mc146818rtc_properties);
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  
> -    object_class_property_add_tm(klass, "date", rtc_get_date);
> +    object_class_property_add_qapi(klass, "date", &StructTm_type_info,
> +                                   rtc_get_date, NULL, NULL, NULL);
>  }
>  
>  static const TypeInfo mc146818rtc_info = {
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 6d84bbb25bb5..4bedf17b6c8f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -2080,35 +2080,6 @@ object_class_property_add_qapi(ObjectClass *klass,
>                                 ObjectPropertyRelease *release,
>                                 void *opaque);
>  
> -/**
> - * object_property_add_tm:
> - * @obj: the object to add a property to
> - * @name: the name of the property
> - * @get: the getter or NULL if the property is write-only.
> - *
> - * Add a read-only struct tm valued property using a getter function.
> - * This function will add a property of type 'struct tm'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_property_add_tm(Object *obj, const char *name,
> -                            void (*get)(Object *, struct tm *, Error **));
> -
> -/**
> - * object_class_property_add_tm:
> - * @klass: the object class to add a property to
> - * @name: the name of the property
> - * @get: the getter or NULL if the property is write-only.
> - *
> - * Add a read-only struct tm valued property using a getter function.
> - * This function will add a property of type 'struct tm'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
> -                            const char *name,
> -                            void (*get)(Object *, struct tm *, Error **));
> -
>  typedef enum {
>      /* Automatically add a getter to the property */
>      OBJ_PROP_FLAG_READ = 1 << 0,
> diff --git a/qapi/common.json b/qapi/common.json
> index af7e3d618a7c..928ba0ba2c63 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -228,3 +228,31 @@
>  ##
>  { 'enum': 'EndianMode',
>    'data': [ 'unspecified', 'little', 'big' ] }
> +
> +##
> +# @StructTm:
> +#
> +# Broken-down time.  Field semantics match C ``struct tm``.
> +#
> +# @tm_year: years since 1900
> +#
> +# @tm_mon: months since January (0-11)
> +#
> +# @tm_mday: day of the month (1-31)
> +#
> +# @tm_hour: hours since midnight (0-23)
> +#
> +# @tm_min: minutes after the hour (0-59)
> +#
> +# @tm_sec: seconds after the minute (0-59, 60-61 for leap seconds)
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'StructTm',
> +  'data': {
> +    'tm_year': 'int32',
> +    'tm_mon': 'int32',
> +    'tm_mday': 'int32',
> +    'tm_hour': 'int32',
> +    'tm_min': 'int32',
> +    'tm_sec': 'int32' } }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 342cedc42e76..9be2819a46bd 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -109,6 +109,7 @@
>          'QKeyCode',                 # send-key, input-sent-event
>          'QapiErrorClass',           # QMP error replies
>          'SshHostKeyCheckMode',      # blockdev-add, -blockdev
> +        'StructTm',                 # qom-get of RTC date property
>          'SysEmuTarget',             # query-cpu-fast, query-target
>          'UuidInfo',                 # query-uuid
>          'VncClientInfo',            # query-vnc, query-vnc-servers, ...
> diff --git a/qom/object.c b/qom/object.c
> index bbaa999ae0c9..a0e3af61ae29 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2632,75 +2632,6 @@ object_class_property_add_qapi(ObjectClass *klass, const char *name,
>      return prop;
>  }
>  
> -typedef struct TMProperty {
> -    void (*get)(Object *, struct tm *, Error **);
> -} TMProperty;
> -
> -static void property_get_tm(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    TMProperty *prop = opaque;
> -    Error *err = NULL;
> -    struct tm value;
> -
> -    prop->get(obj, &value, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    if (!visit_start_struct(v, name, NULL, 0, errp)) {
> -        return;
> -    }
> -    if (!visit_type_int32(v, "tm_year", &value.tm_year, errp)) {
> -        goto out_end;
> -    }
> -    if (!visit_type_int32(v, "tm_mon", &value.tm_mon, errp)) {
> -        goto out_end;
> -    }
> -    if (!visit_type_int32(v, "tm_mday", &value.tm_mday, errp)) {
> -        goto out_end;
> -    }
> -    if (!visit_type_int32(v, "tm_hour", &value.tm_hour, errp)) {
> -        goto out_end;
> -    }
> -    if (!visit_type_int32(v, "tm_min", &value.tm_min, errp)) {
> -        goto out_end;
> -    }
> -    if (!visit_type_int32(v, "tm_sec", &value.tm_sec, errp)) {
> -        goto out_end;
> -    }
> -    visit_check_struct(v, errp);
> -out_end:
> -    visit_end_struct(v, NULL);
> -}
> -
> -ObjectProperty *
> -object_property_add_tm(Object *obj, const char *name,
> -                       void (*get)(Object *, struct tm *, Error **))
> -{
> -    TMProperty *prop = g_malloc0(sizeof(*prop));
> -
> -    prop->get = get;
> -
> -    return object_property_add(obj, name, "struct tm",
> -                               get ? property_get_tm : NULL, NULL,
> -                               property_release_data,
> -                               prop);
> -}
> -
> -ObjectProperty *
> -object_class_property_add_tm(ObjectClass *klass, const char *name,
> -                             void (*get)(Object *, struct tm *, Error **))
> -{
> -    TMProperty *prop = g_malloc0(sizeof(*prop));
> -
> -    prop->get = get;
> -
> -    return object_class_property_add(klass, name, "struct tm",
> -                                     get ? property_get_tm : NULL,
> -                                     NULL, NULL, prop);
> -}
>  
>  static char *object_get_type(Object *obj, Error **errp)
>  {
> 
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
> 

