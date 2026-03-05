Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B85F3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyB4O-0000iA-1F; Thu, 05 Mar 2026 10:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vyB4L-0000ds-WF
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:56:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiju.jose@huawei.com>)
 id 1vyB4I-0001H7-G5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:56:57 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fRYyf72HNzJ468G;
 Thu,  5 Mar 2026 23:55:06 +0800 (CST)
Received: from dubpeml500006.china.huawei.com (unknown [7.214.146.138])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B88440086;
 Thu,  5 Mar 2026 23:55:43 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml500006.china.huawei.com (7.214.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 15:55:43 +0000
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Thu, 5 Mar 2026 15:55:42 +0000
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "mst@redhat.com"
 <mst@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>, Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH 1/3] hw/cxl: Add fixes in maintenance and memory sparing
Thread-Topic: [PATCH 1/3] hw/cxl: Add fixes in maintenance and memory sparing
Thread-Index: AQHcqDjl+n1WyBY0OkmLRK3mH9eWFbWfzVoAgABSUiA=
Date: Thu, 5 Mar 2026 15:55:42 +0000
Message-ID: <dd4ddc17b4c3431e9b90afff7a750084@huawei.com>
References: <20260227223207.972-1-shiju.jose@huawei.com>
 <20260227223207.972-2-shiju.jose@huawei.com>
 <20260305105746.00000529@huawei.com>
In-Reply-To: <20260305105746.00000529@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.246.152]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56; envelope-from=shiju.jose@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shiju Jose <shiju.jose@huawei.com>
From:  Shiju Jose via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


>-----Original Message-----
>From: Jonathan Cameron <jonathan.cameron@huawei.com>
>Sent: 05 March 2026 10:58
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; mst@redhat.com;
>peter.maydell@linaro.org; dave@stgolabs.net; Linuxarm
><linuxarm@huawei.com>
>Subject: Re: [PATCH 1/3] hw/cxl: Add fixes in maintenance and memory spari=
ng
>
>On Fri, 27 Feb 2026 22:32:04 +0000
><shiju.jose@huawei.com> wrote:
>
>> From: Shiju Jose <shiju.jose@huawei.com>
>Hi Shiju,
>
>Perhaps a more specific title would help people understand quickly what ty=
pe of
>fix this is?
>
>Something like:
>hw/cxl: Fix handling of component ID to not assume it is a string.
Hi Jonathan,

Thanks for the feedback. I will change the title and add fixes tag (was not=
 sure
need fixes tag as in kernel).

Thanks,
Shiju
>
>
>>
>> Add following fixes to the commit: hw/cxl: Add support for Maintenance
>> command and Post Package Repair (PPR).
>That just wants to be a reference to the fixes tag.
>
>>
>> 1. In cxl_create_mem_sparing_event_records(), replace strncpy with
>> memcpy to solve coverity warning because full size of the array to use
>> as length in strncpy to copy the entire component id data, which is 16 b=
ytes.
>I wouldn't necessarily focus on the coverity issue bit of this, but rather=
 that it's
>not a string so memcpy is the correct function to use.  Then flag it as as=
 being
>identified as a result of the coverity warning.
>>
>> 2. In cxl_maintenance_insert(),
>>  - replace strncpy with memcpy in to copy full data because component id=
 is
>>    16 bytes data.
>>  - remove memset which is not required.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>
>The original patch is upstream, so need a Fixes tag. I can't remember how =
we
>mark coverity issue closures, so look for a similar patch and copy that st=
yle.
>Maybe just a Closes tag for Peter's email pointing it out.
>
>Code looks good.
>
>> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 4 ++--
>>  hw/mem/cxl_type3.c         | 4 +---
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index c83b5f90d4..9c99422cd4 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -1994,8 +1994,8 @@ static void
>cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
>>          stw_le_p(&event_rec.column, ent->column);
>>          event_rec.sub_channel =3D ent->sub_channel;
>>          if (ent->validity_flags & CXL_MSER_VALID_COMP_ID) {
>> -            strncpy((char *)event_rec.component_id, (char *)ent->compon=
ent_id,
>> -                    sizeof(event_rec.component_id));
>> +            memcpy(event_rec.component_id, ent->component_id,
>> +                   sizeof(event_rec.component_id));
>>          }
>>      } else if (sparing_pi) {
>>          event_rec.flags =3D CXL_MSER_FLAGS_QUERY_RESOURCES; diff --git
>> a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c index
>4739239da3..3cb1096e16
>> 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -1767,7 +1767,6 @@ static void cxl_maintenance_insert(CXLType3Dev
>*ct3d, uint64_t dpa,
>>          }
>>      }
>>      m =3D g_new0(CXLMaintenance, 1);
>> -    memset(m, 0, sizeof(*m));
>>      m->dpa =3D dpa;
>>      m->validity_flags =3D 0;
>>
>> @@ -1804,8 +1803,7 @@ static void cxl_maintenance_insert(CXLType3Dev
>*ct3d, uint64_t dpa,
>>          m->validity_flags |=3D CXL_MSER_VALID_SUB_CHANNEL;
>>      }
>>      if (component_id) {
>> -        strncpy((char *)m->component_id, component_id,
>> -                sizeof(m->component_id) - 1);
>> +        memcpy(m->component_id, component_id,
>> + sizeof(m->component_id));
>>          m->validity_flags |=3D CXL_MSER_VALID_COMP_ID;
>>          if (has_comp_id_pldm && is_comp_id_pldm) {
>>              m->validity_flags |=3D CXL_MSER_VALID_COMP_ID_FORMAT;


