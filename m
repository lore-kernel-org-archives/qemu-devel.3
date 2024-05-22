Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CFEC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9odS-0004Qt-Tc; Wed, 22 May 2024 12:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1s9odR-0004Nz-69; Wed, 22 May 2024 12:16:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1s9odM-0006Ry-MH; Wed, 22 May 2024 12:16:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MFIewn013202; Wed, 22 May 2024 16:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VPqxrUXGBFG7uYUDGVLFyxiwKpqX6xPwReLGS59yy10=;
 b=aVYath5Qyk5q2NboioYJeDd5hQqZNyFkWjfX+alB4v1UgcneAUgbBovaR4vtkX8J46vB
 5WMb5gL+T4L4fVARZKVALmF5z1FYPbRiSyNKYL87LZvTFAss/Wqn4ISngMiqNB9JCatV
 6Q+cFMyVIvES0pb0rB8VkWnc/+F0AKpbaGJV+3MzRBXfyMWDziVWq4K2lee1sXkSLQ1t
 7muX8TuQpi3fQA2Dq3J1oUDJjCMHQR2HfAgB6NOnrE9S2MLyf3lHbQrN7IMIFJijHFne
 OqtMq8XnVbq4ndb/P1X2oFFdy3ntJzkZWoSyqFabc2Cp+3AezMZweK59cdE7m/tgsvaC cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9k7tg5js-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 16:15:52 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MGFpZb005524;
 Wed, 22 May 2024 16:15:51 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9k7tg5jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 16:15:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MFaKuZ008226; Wed, 22 May 2024 16:15:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vm4gfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 16:15:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44MGFktB33030710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2024 16:15:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D88602004F;
 Wed, 22 May 2024 16:15:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D286620040;
 Wed, 22 May 2024 16:15:43 +0000 (GMT)
Received: from [9.195.36.46] (unknown [9.195.36.46])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 May 2024 16:15:43 +0000 (GMT)
Message-ID: <22634714-47ea-4421-9c2d-1ca61f25879c@linux.ibm.com>
Date: Wed, 22 May 2024 21:45:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, harshpb@linux.ibm.com,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 zhenzhong.duan@intel.com, qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <30e9ce3e-08d4-4ab4-b734-d7a7fb0639a9@kaod.org>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <30e9ce3e-08d4-4ab4-b734-d7a7fb0639a9@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8qw0fbzXBGPkZ2UZT4X6-0Nmk5SkOtt-
X-Proofpoint-GUID: AmHDQJd935HmMxHojaJidgT9U-t0g043
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220110
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/13/24 17:53, Cédric Le Goater wrote:
> Hello Shivaprasad,
>
> On 5/9/24 21:14, Shivaprasad G Bhat wrote:
>> The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
>> spapr container)" began to use the newly introduced VFIOSpaprContainer
>> structure.
>>
>> After several refactors, today the container_of(container,
>> VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
>> not allocated. On PPC64 systems, this dereference is leading to 
>> corruption
>> showing up as glibc malloc assertion during guest start when using vfio.
>>
>> Patch adds the missing allocation while also making the structure 
>> movement
>> to vfio common header file.
>>
>> Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr 
>> container)"
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> ---
>>   hw/vfio/container.c           |    6 ++++--
>>   hw/vfio/spapr.c               |    6 ------
>>   include/hw/vfio/vfio-common.h |    6 ++++++
>>   3 files changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 77bdec276e..ecaf5786d9 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -539,6 +539,7 @@ static int vfio_connect_container(VFIOGroup 
>> *group, AddressSpace *as,
>>   {
>>       VFIOContainer *container;
>>       VFIOContainerBase *bcontainer;
>> +    VFIOSpaprContainer *scontainer;
>
> We should do our best to avoid any direct use of ppc related attributes
> in the common VFIO code. This comment also applies to VFIO_SPAPR_TCE*
> which are still there because the clean up is not finished. So, this
> proposal will have to be reworked.
>
Sure.
> The first step is to finish the QOMification of VFIOContainer, so
> that the VFIOContainer instance is created in vfio_connect_container()
> with :
>
>     container = qdev_new(iommu_type_name);

This requires the VFIOContainer to be a DeviceState object.

The existing base class TYPE_VFIO_IOMMU is an InterfaceClass.

I attempted VFIOContainer object declaration with TYPE_VFIO_IOMMU,

like

OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY)


>
> This means reworking this part (and vfio_set_iommu()) :
>
>     ...
>     container = g_malloc0(sizeof(*container));
>     container->fd = fd;
>     bcontainer = &container->bcontainer;
>
>     if (!vfio_set_iommu(container, group->fd, space, errp)) {
>         goto free_container_exit;
>     }
>     ...
>
> VFIOSpaprContainer can then implement its own .init_instance() handler
> to allocate/initialize attributes required by the pseries machines.


With my above changes,

I see the instance_init() is not supported for the InterfaceClass with the

checks from below

commit 422ca1432f7b44f2a9f3ad94a65d36927da021fa
Author: Marc-André Lureau <marcandre.lureau@redhat.com>
Date:   Wed Sep 12 16:53:03 2018 +0400

     qom/object: add some interface asserts

Did you suggest me something else?


Thank you,

Shivaprasad

>
> While doing this, please try to reduce the use of ->iommu_type which
> is a design shortcut. I would like to completely remove it at some
> point.
>
> Thanks,
>
> C.
>
>
>
>
>
>
>
>>       int ret, fd;
>>       VFIOAddressSpace *space;
>>
>> @@ -611,7 +612,8 @@ static int vfio_connect_container(VFIOGroup 
>> *group, AddressSpace *as,
>>           goto close_fd_exit;
>>       }
>>
>> -    container = g_malloc0(sizeof(*container));
>> +    scontainer = g_malloc0(sizeof(*scontainer));
>> +    container = &scontainer->container;
>>       container->fd = fd;
>>       bcontainer = &container->bcontainer;
>>
>> @@ -675,7 +677,7 @@ unregister_container_exit:
>>       vfio_cpr_unregister_container(bcontainer);
>>
>>   free_container_exit:
>> -    g_free(container);
>> +    g_free(scontainer);
>>
>>   close_fd_exit:
>>       close(fd);
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 0d949bb728..78d218b7e7 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -24,12 +24,6 @@
>>   #include "qapi/error.h"
>>   #include "trace.h"
>>
>> -typedef struct VFIOSpaprContainer {
>> -    VFIOContainer container;
>> -    MemoryListener prereg_listener;
>> -    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>> -} VFIOSpaprContainer;
>> -
>>   static bool 
>> vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>>   {
>>       if (memory_region_is_iommu(section->mr)) {
>> diff --git a/include/hw/vfio/vfio-common.h 
>> b/include/hw/vfio/vfio-common.h
>> index b9da6c08ef..010fa68ac6 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -82,6 +82,12 @@ typedef struct VFIOContainer {
>>       QLIST_HEAD(, VFIOGroup) group_list;
>>   } VFIOContainer;
>>
>> +typedef struct VFIOSpaprContainer {
>> +    VFIOContainer container;
>> +    MemoryListener prereg_listener;
>> +    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>> +} VFIOSpaprContainer;
>> +
>>   typedef struct VFIOHostDMAWindow {
>>       hwaddr min_iova;
>>       hwaddr max_iova;
>>
>>
>

