Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3893C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yVi-0000nW-80; Tue, 08 Sep 2026 12:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x3yVg-0000n8-4g
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:17:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x3yVd-0004Ni-Oo
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:17:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688F1OXa1232701; Tue, 8 Sep 2026 16:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oNjlC6
 FROkYFVP7j8nZbMO+081enrKl+wt/sNufHfDQ=; b=N6vA4wP5dNSmSciBAvpZaG
 8al8kxNzb14llFGuzljEiNSeJhlCwQ7yWLXAsWusRhDJ4JPVK3XajdAOEHnRcAe+
 XzZPFK2hIYo5SPSVdYmp7TLpPo6Crm1NV0rFbWc5W1KfNc2AZ9ziTP5TRCxC+7ca
 ybtN7xSrC6HXcgE0aB+S2fBL7wpnBZq033eVL5fQh3E8oCLOI+wfVH+yzty97gZl
 hpGwibgFQbl9F6XcqPqFdsr410LJyC1LL603a2hXAGSOHwhwJLoITv2WMxriheSM
 hLyUPK2+4fBrRWJEYKBJ7LA57uiAJWZysnUBOxPNKW3LZ8+oVuzNI8lHVJGgqiaw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf40bh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:17:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GBF4c014116;
 Tue, 8 Sep 2026 16:17:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03ycrue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 16:17:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 688GH6ew7602792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Sep 2026 16:17:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C76958065;
 Tue,  8 Sep 2026 16:17:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC91D5805D;
 Tue,  8 Sep 2026 16:17:05 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Sep 2026 16:17:05 +0000 (GMT)
Message-ID: <80c743a2-e241-4187-9bce-a1cc22445b15@linux.ibm.com>
Date: Tue, 8 Sep 2026 12:17:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 67/75] qdev: convert PropertyInfo definitions to use
 qapi_type
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
 <20260904-qom-qapi-v4-67-a985f168e938@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260904-qom-qapi-v4-67-a985f168e938@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: icHC5OW7iFp097P4_VSfepwwILs5UrUa
X-Proofpoint-GUID: 4_MmHNzLHOOr1S90bkyAxZ7Pp3vHvNlo
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa03504 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=ULvi3PbT2xsdihy8b-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MyBTYWx0ZWRfX5lCTdJebkb8u
 C+3YbnG83tjYU7krKMgVgcA+m3jZ4cHJBm0puemxorG6hjoM4tg8XeaDXnAkzU9CmWfG1ubx6Mh
 W3GMF7BU7Xv0cwnse8/TxqxmMbBJk1hfsvZvY4gIVysMpdcWmtbo13dKZWmShQU9hIABbRRTQYR
 jE+MsjkLzUig4R+oYKMpryVNrYTH6Y4P16RGJSSngHrgK5uRKqWJU4OaGPQZFPMqkBVXlok5Udt
 LF48SRgesEoENifDpoSbzheFGzce5/fQHWt3iPzM2A+mvaRHC33Oky+mCNrl6lLk8MdbZiK9EyH
 Fv/aIzEe85TmFKPmDDDmZymt5//IwO7gHtSpeuB/p/pmRGgmR93gbhE6jYt2g5DmQRKcfQ8l/tC
 26VbAaxE9YvEjazTZHyrsA3Cjj8r9EuippFtLPgsUR6rKzyEPbMjbtgPlGYT+4qb4hZuHkOVVfu
 O5H3FwTeDCr7/RoquvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MyBTYWx0ZWRfX4FnsXmTZoTKe
 aWd3FSiX6zBl+y5akpmvkKXRl1cRtHySGb+Aoj1SdkgP04OeSqvlicF6TwrrW5JExqygN/sMZF9
 uiO2x7gA1FW5woy9HxleMgXLvmqGSW8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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



On 9/4/26 3:58 PM, Marc-André Lureau wrote:
> Convert the remaining PropertyInfo definitions outside hw/
> 
> After this patch, all PropertyInfo definitions have .qapi_type set,
> except qdev_prop_link (uses .create) and qdev_prop_array (refactored
> in the next patches).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   backends/spdm-socket.c  | 4 ++--
>   backends/tpm/tpm_util.c | 3 ++-
>   migration/options.c     | 4 +++-
>   target/sparc/cpu.c      | 3 ++-
>   4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
> index 826efc276dcd..4a4307975965 100644
> --- a/backends/spdm-socket.c
> +++ b/backends/spdm-socket.c
> @@ -17,6 +17,7 @@
>   #include "hw/core/qdev-properties.h"
>   #include "hw/core/qdev-properties-system.h"
>   #include "hw/core/qdev-prop-internal.h"
> +#include "qapi/qapi-type-infos-sockets.h"
>   
>   static bool read_bytes(const int socket, uint8_t *buffer,
>                          size_t number_of_bytes)
> @@ -253,9 +254,8 @@ void spdm_socket_close(const int socket, SpdmTransportType transport_type)
>   }
>   
>   const PropertyInfo qdev_prop_spdm_trans = {
> -    .type = "SpdmTransportType",
> +    .qapi_type = &SpdmTransportType_type_info,
>       .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
> -    .enum_table = &SpdmTransportType_lookup,
>       .get = qdev_propinfo_get_enum,
>       .set = qdev_propinfo_set_enum,
>       .set_default_value = qdev_propinfo_set_default_value_enum,
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index 264bff22a91a..ecbc771baa6f 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -30,6 +30,7 @@
>   #include "system/tpm_backend.h"
>   #include "system/tpm_util.h"
>   #include "trace.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>   
>   /* tpm backend property */
>   
> @@ -77,7 +78,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
>   }
>   
>   const PropertyInfo qdev_prop_tpm = {
> -    .type  = "str",
> +    .qapi_type = &str_type_info,
>       .description = "ID of a tpm to use as a backend",
>       .get   = get_tpm,
>       .set   = set_tpm,
> diff --git a/migration/options.c b/migration/options.c
> index d2575edb6cbe..78d4d4818514 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -31,6 +31,8 @@
>   #include "ram.h"
>   #include "options.h"
>   #include "system/kvm.h"
> +#include "qapi/qapi-builtin-type-infos.h"
> +#include "qapi/qapi-type-infos-common.h"
>   
>   /* Maximum migrate downtime set to 2000 seconds */
>   #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
> @@ -287,7 +289,7 @@ static void set_default_value_tls_opt(ObjectProperty *op, const Property *prop)
>    * TYPE_MIGRATION's TLS options.
>    */
>   const PropertyInfo qdev_prop_StrOrNull = {
> -    .type  = "StrOrNull",
> +    .qapi_type = &StrOrNull_type_info,
>       .get = get_StrOrNull,
>       .set = set_StrOrNull,
>       .release = release_StrOrNull,
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index ae9bdca9df82..d0354a4d02af 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -30,6 +30,7 @@
>   #include "tcg/tcg.h"
>   #include "fpu/softfloat.h"
>   #include "target/sparc/translate.h"
> +#include "qapi/qapi-builtin-type-infos.h"
>   
>   //#define DEBUG_FEATURES
>   
> @@ -948,7 +949,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
>   }
>   
>   static const PropertyInfo qdev_prop_nwindows = {
> -    .type  = "int",
> +    .qapi_type = &int_type_info,
>       .description = "Number of register windows",
>       .get   = sparc_get_nwindows,
>       .set   = sparc_set_nwindows,
> 


