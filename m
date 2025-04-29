Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF845C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9s3v-0004sz-A6; Tue, 29 Apr 2025 17:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9s3u-0004sn-IF
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:00:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9s3s-0002gE-7M
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:00:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TEZ7g5007218;
 Tue, 29 Apr 2025 21:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sWlS9Y
 chdxAbklALs9JP/9cKZ4H2HfyVF+FUN8UVWv0=; b=bm/cv/M9GwehZDXONudN/M
 dNPuhjF2pO91xppigfnWz/aMlEF/HbdCU2o9DVhFmKvKkfVqwLc045jBb7PQ98w4
 YesNeOw+vqETG+qi2vTdreJTuOpwx1SwEukhOcwp6BcBDSDPah82ujgLSqaqn8/K
 gEreWSAK6yG/ceO8744caAmwmOyjCUdS6hJ+h8PDJEOLdwlkDXN8BDwg88eEjtY2
 iZwdwh8i/CrUQbZFSn7j5Q629r7JuNX01I8nEJFZVUouZxRhpXNgQ9Fc5UK7uAyj
 E3RnYfgStkFAO/zsV5DdwDyUTSxURYicyCYGN5DLP+F57XDsp0N7SYxYRoChOUFw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46akn0vwnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 21:00:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53THNKvC000717;
 Tue, 29 Apr 2025 21:00:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpd3ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 21:00:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TL0CkD5571264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 21:00:12 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58B5058066;
 Tue, 29 Apr 2025 21:00:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C011E58068;
 Tue, 29 Apr 2025 21:00:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 21:00:11 +0000 (GMT)
Message-ID: <e719e095-5767-4425-a390-763c4948c2e7@linux.ibm.com>
Date: Tue, 29 Apr 2025 17:00:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests: add /qdev/free-properties test
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-6-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250429140306.190384-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AeCxH2XG c=1 sm=1 tr=0 ts=68113dde cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=go1J4WAMvHytxnLkwVkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fPFNQpBFQG4n3-izr8NxOXIpksflVj9z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MiBTYWx0ZWRfXyr/0PF7vk+hB
 GdppmyewttNjW6OTua50mTSZI6as0S0tNlTQ33rubzTuaSLuE5bv2t0oeOR/h9gogRmbBAzgEh+
 fVvpnLCtwiDW47lxpe0XNiGEbhfFrseWECt2lHj1D1PwsxJkdJSyjHk8buE1BWolhjsFMRYSpt1
 Dju6n6VlF70FYLnmuQWGITpu+3g5x3NeNiD7zf2jDa3us/yu6/2xlWxWe2hEi+gldI8gCVObfQu
 jdKQklPgNrSdOz/5jx5mKlrW4BCBpJavd13cR/zpYWireyfhUrF6NyB6XJ8pWqatVuuBbSPRrtn
 mVzmfIEqMTEDF98RUIqMcC+L+SrUHj7oeORC3LGEPRE8riBfaEIErWtbA0QIo419N+8/4ZBsH/u
 I/HvgD0e9qcbDGpbSj8LZ+CLoLLt0h0rrYEZhInWyOkj5c+wOdYBPjsM2em+fTfxy56TOn06
X-Proofpoint-GUID: fPFNQpBFQG4n3-izr8NxOXIpksflVj9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290152
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 4/29/25 10:03 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add a simple qdev test to check that allocated properties get free with

get freed

> the object. This test exhibited array leaks before the fixes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/unit/test-qdev.c | 96 ++++++++++++++++++++++++++++++++++++++++++
>   tests/unit/meson.build |  1 +
>   2 files changed, 97 insertions(+)
>   create mode 100644 tests/unit/test-qdev.c
> 
> diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
> new file mode 100644
> index 0000000000..2b4c9dd643
> --- /dev/null
> +++ b/tests/unit/test-qdev.c
> @@ -0,0 +1,96 @@
> +#include "qemu/osdep.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +
> +
> +#define TYPE_MY_DEV "my-dev"
> +typedef struct MyDev MyDev;
> +DECLARE_INSTANCE_CHECKER(MyDev, STATIC_TYPE,
> +                         TYPE_MY_DEV)
> +
> +struct MyDev {
> +    DeviceState parent_obj;
> +
> +    uint32_t prop_u32;
> +    char *prop_string;
> +    uint32_t *prop_array_u32;
> +    uint32_t prop_array_u32_nb;
> +};
> +
> +static const Property my_dev_props[] = {
> +    DEFINE_PROP_UINT32("u32", MyDev, prop_u32, 100),
> +    DEFINE_PROP_STRING("string", MyDev, prop_string),
> +    DEFINE_PROP_ARRAY("array-u32", MyDev, prop_array_u32_nb, prop_array_u32, qdev_prop_uint32, uint32_t),
> +};
> +
> +static void my_dev_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = NULL;
> +    device_class_set_props(dc, my_dev_props);
> +}
> +
> +static const TypeInfo my_dev_type_info = {
> +    .name = TYPE_MY_DEV,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(MyDev),
> +    .class_init = my_dev_class_init,
> +};
> +
> +/*
> + * Initialize a fake machine, being prepared for future tests.
> + *
> + * Realization of anonymous qdev (with no parent object) requires both
> + * the machine object and its "unattached" container to be at least present.
> + */
> +static void test_init_machine(void)
> +{
> +    /* This is a fake machine - it doesn't need to be a machine object */
> +    Object *machine = object_property_add_new_container(
> +        object_get_root(), "machine");
> +
> +    /* This container must exist for anonymous qdevs to realize() */
> +    object_property_add_new_container(machine, "unattached");
> +}
> +
> +static void test_qdev_free_properties(void)
> +{
> +    MyDev *mt;
> +
> +    mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
> +    object_set_props(OBJECT(mt), &error_fatal,
> +                     "string", "something",
> +                     "array-u32", "12,13",
> +                     NULL);
> +    qdev_realize(DEVICE(mt), NULL, &error_fatal);
> +
> +    g_assert_cmpuint(mt->prop_u32, ==, 100);
> +    g_assert_cmpstr(mt->prop_string, ==, "something");
> +    g_assert_cmpuint(mt->prop_array_u32_nb, ==, 2);
> +    g_assert_cmpuint(mt->prop_array_u32[0], ==, 12);
> +    g_assert_cmpuint(mt->prop_array_u32[1], ==, 13);
> +
> +    object_unparent(OBJECT(mt));
> +    object_unref(mt);
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    type_register_static(&my_dev_type_info);
> +    test_init_machine();
> +
> +    g_test_add_func("/qdev/free-properties",
> +                    test_qdev_free_properties);
> +
> +    g_test_run();
> +
> +    return 0;
> +}
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index d5248ae51d..99f59f4ceb 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -159,6 +159,7 @@ if have_system
>         'test-qdev-global-props': [qom, hwcore]
>       }
>     endif
> +  tests += {'test-qdev': [qom, hwcore]}
>   endif
>   
>   if have_ga and host_os == 'linux'

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


