Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522C1D36137
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Q4w-0005Qu-GJ; Tue, 05 Nov 2024 15:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t8Q4s-0005Q9-T1; Tue, 05 Nov 2024 15:23:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1t8Q4k-000103-Gl; Tue, 05 Nov 2024 15:23:02 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5JeTQB026507;
 Tue, 5 Nov 2024 20:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6L7chL
 wQJEWYHaadkUwZQaQp1d+2KlgXljtSnPv8hFY=; b=MoXcSaqz7kuBOjv1pQojwW
 SYltpcFlIvIMWRky1yMVaRekJPfJNZBe+B2OrdwjMhnSMaFXHGp6iOmvQHd/zkCM
 hZBsso0yrMP2RYKCKb+96vMOqK2eWhJQN8Wx2XPkqJ2ZxFQOo+c6QsklHCczpP9C
 fJrE6q3CakRF/F4t6IS+/2opEsaoE/lzYd+i/qhF35Ktv7UBmYWWx3C7/dbZFzyk
 O7tnilUbZrB8pdrP9I0YaJUdyX9mOkwpnHXtDocz7CGgcXeyDD7KVFQPxAN4FEgD
 2TxIq2cPjIi/hsjgHHeL9+vBLVI6aRCfsLHQXvG7RlJ1W91p3v/GmuW9NyarPo3Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qsqg85fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 20:22:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5Hhg14032050;
 Tue, 5 Nov 2024 20:22:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmmse4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 20:22:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5KMiCP9306766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 20:22:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA30058053;
 Tue,  5 Nov 2024 20:22:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F367258043;
 Tue,  5 Nov 2024 20:22:43 +0000 (GMT)
Received: from [9.61.16.77] (unknown [9.61.16.77])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  5 Nov 2024 20:22:43 +0000 (GMT)
Message-ID: <8b6d8bf1-d116-4a1f-ba89-e8b0faa5ff2b@linux.ibm.com>
Date: Tue, 5 Nov 2024 15:22:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/19] s390x: Add individual loadparm assignment to CCW
 device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com, Sebastian Mitterle <smitterl@redhat.com>,
 Boqiao Fu <bfu@redhat.com>
References: <20241020012953.1380075-1-jrossi@linux.ibm.com>
 <20241020012953.1380075-15-jrossi@linux.ibm.com>
 <fc4fc429-6084-4b6d-aeb7-2948aa9df3b6@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <fc4fc429-6084-4b6d-aeb7-2948aa9df3b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rrhGOPGjpEv4StlXjOKK6eCIWWRZQGXc
X-Proofpoint-ORIG-GUID: rrhGOPGjpEv4StlXjOKK6eCIWWRZQGXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=900 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/31/24 4:45 AM, Thomas Huth wrote:
> On 20/10/2024 03.29, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Add a loadparm property to the VirtioCcwDevice object so that different
>> loadparms can be defined on a per-device basis for CCW boot devices.
>>
>> The machine/global loadparm is still supported. If both a global and 
>> per-device
>> loadparm are defined, the per-device value will override the global 
>> value for
>> that device, but any other devices that do not specify a per-device 
>> loadparm
>> will still use the global loadparm.
>>
>> It is invalid to assign a loadparm to a non-boot device.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   hw/s390x/ccw-device.h       |  2 ++
>>   hw/s390x/ipl.h              |  3 +-
>>   include/hw/s390x/ipl/qipl.h |  1 +
>>   hw/s390x/ccw-device.c       | 46 +++++++++++++++++++++++++
>>   hw/s390x/ipl.c              | 68 ++++++++++++++++++++++---------------
>>   hw/s390x/s390-virtio-ccw.c  | 18 +---------
>>   hw/s390x/sclp.c             |  9 ++---
>>   pc-bios/s390-ccw/main.c     | 10 ++++--
>>   8 files changed, 102 insertions(+), 55 deletions(-)
>>
>> diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
>> index 5feeb0ee7a..1e1737c0f3 100644
>> --- a/hw/s390x/ccw-device.h
>> +++ b/hw/s390x/ccw-device.h
>> @@ -26,6 +26,8 @@ struct CcwDevice {
>>       CssDevId dev_id;
>>       /* The actual busid of the virtual subchannel. */
>>       CssDevId subch_id;
>> +    /* If set, use this loadparm value when device is boot target */
>> +    uint8_t loadparm[8];
>>   };
>>   typedef struct CcwDevice CcwDevice;
>>   diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index fa394c339d..b670bad551 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -21,7 +21,8 @@
>>     #define DIAG308_FLAGS_LP_VALID 0x80
>>   -int s390_ipl_set_loadparm(uint8_t *loadparm);
>> +void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp);
>> +void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp);
>>   void s390_ipl_update_diag308(IplParameterBlock *iplb);
>>   int s390_ipl_prepare_pv_header(Error **errp);
>>   int s390_ipl_pv_unpack(void);
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 0ef04af027..b67d2ae061 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -18,6 +18,7 @@
>>     #define QIPL_ADDRESS  0xcc
>>   #define LOADPARM_LEN    8
>> +#define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>>     /*
>>    * The QEMU IPL Parameters will be stored at absolute address
>> diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
>> index 14c24e3890..230cc09e03 100644
>> --- a/hw/s390x/ccw-device.c
>> +++ b/hw/s390x/ccw-device.c
>> @@ -13,6 +13,10 @@
>>   #include "ccw-device.h"
>>   #include "hw/qdev-properties.h"
>>   #include "qemu/module.h"
>> +#include "ipl.h"
>> +#include "qapi/visitor.h"
>> +#include "qemu/ctype.h"
>> +#include "qapi/error.h"
>>     static void ccw_device_refill_ids(CcwDevice *dev)
>>   {
>> @@ -37,10 +41,52 @@ static bool ccw_device_realize(CcwDevice *dev, 
>> Error **errp)
>>       return true;
>>   }
>>   +static void ccw_device_get_loadparm(Object *obj, Visitor *v,
>> +                                 const char *name, void *opaque,
>> +                                 Error **errp)
>> +{
>> +    CcwDevice *dev = CCW_DEVICE(obj);
>> +    char *str = g_strndup((char *) dev->loadparm, 
>> sizeof(dev->loadparm));
>> +
>> +    visit_type_str(v, name, &str, errp);
>> +    g_free(str);
>> +}
>> +
>> +static void ccw_device_set_loadparm(Object *obj, Visitor *v,
>> +                                 const char *name, void *opaque,
>> +                                 Error **errp)
>> +{
>> +    CcwDevice *dev = CCW_DEVICE(obj);
>> +    char *val;
>> +    int index;
>> +
>> +    index = object_property_get_int(obj, "bootindex", NULL);
>> +
>> +    if (index < 0) {
>> +        error_setg(errp, "LOADPARM is only valid for boot devices!");
>> +    }
>> +
>> +    if (!visit_type_str(v, name, &val, errp)) {
>> +        return;
>> +    }
>> +
>> +    s390_ipl_fmt_loadparm(dev->loadparm, val, errp);
>> +}
>> +
>> +static const PropertyInfo ccw_loadparm = {
>> +    .name  = "ccw_loadparm",
>> +    .description = "Up to 8 chars in set of [A-Za-z0-9. ] to pass"
>> +            " to the guest loader/kernel",
>> +    .get = ccw_device_get_loadparm,
>> +    .set = ccw_device_set_loadparm,
>> +};
>> +
>>   static Property ccw_device_properties[] = {
>>       DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
>>       DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
>>       DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
>> +    DEFINE_PROP("loadparm", CcwDevice, loadparm, ccw_loadparm,
>> +            typeof(uint8_t[8])),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>
>  Hi Jared,
>
> while doing more tests with these new boot order patches, I realized 
> that really *all* virtio-ccw devices now have a "loadparm" property, 
> also devices like virtio-gpu and virtio-tablet, where it does not make 
> sense at all.
>
> Wouldn't it be better to add this property only to the virtio-ccw-blk 
> device?
>
> Also, is there a way to specify the "loadparm" property for 
> virtio-scsi devices? It does not seem to be available for "scsi-hd" ?
>
>   Thomas
>

Hi Thomas,

Yes, the loadparm applies to all CCW devices.  I tried to point this out 
in the
cover letter of V2, but I guess it wasn’t clear what I meant, so I apologize
for not bringing more attention to it.  But also yes, as a result of this,
non-CCW type devices do not have the loadparm attribute, which is why
scsi-hd is not included.

The attribute could be implemented on a device-type basis, but it would 
not be
*only* virtio-blk-ccw.  Any device that can generate an IPLB could set the
loadparm.  I agree, though, that it doesn’t really make sense for some 
device
types like virtio-gpu since they cannot have the prerequisite bootindex.

I’ll try to quickly put together a more efficient implementation of the
loadparm that isn't too disruptive.

Regards,
  Jared Rossi

