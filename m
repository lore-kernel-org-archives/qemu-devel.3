Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C566AC98306
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9zV5-00055y-Vj; Fri, 25 Sep 2026 02:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zUt-00055d-II; Fri, 25 Sep 2026 02:33:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zUq-00006W-V8; Fri, 25 Sep 2026 02:33:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4aaLB3084343; Fri, 25 Sep 2026 06:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PHLsQP
 0sUUmgmgSFcROSVdlmQOaSJMjj4YGfXT3lYzA=; b=c9zN9VOQlUzxRWljzdboad
 D0KCRDswbZezSpZ287cHvGbRBaonpATMcno063IKPdKmFuME7+YUPb8mDEkevdlN
 aZVOaCdP67W9g5oShfZv4fF8Gsk718Z68J+GyRTzfxWVwVoEJ9+9iBc6qIkgTE8r
 Y2rX2hza54NEPN8aymODEj9NIZ6qOwcdKlDKqMKgDOh+2ov2VaFs3G6NVJn8A9HE
 Ow87oDkzEAAzQuSYcr3XCXtpjOKpLt4g18z7z5rhfH1Nc6WHsyIVD/fqEBLWoByc
 +jBTE52xR2bG4fWR6S5K4JnwEr5yJlNyhOeclGCrVwZh7XscHCHAJjs5/b3dd1lQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqvkva-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:33:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4lgIY3288275; Fri, 25 Sep 2026 06:33:18 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe21bs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:33:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P6XHhb28312216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 06:33:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A8EB58043;
 Fri, 25 Sep 2026 06:33:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0499158059;
 Fri, 25 Sep 2026 06:33:09 +0000 (GMT)
Received: from [9.43.103.81] (unknown [9.43.103.81])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 06:33:08 +0000 (GMT)
Message-ID: <9749716e-f527-4e13-80ad-3d4158a0facf@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:03:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/8] ppc/spapr: add block device backend to VOF
 open/read/write/seek services
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, avnish@linux.ibm.com
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-6-uverma@linux.ibm.com>
 <4b39b097-4c88-4510-8b2e-8ffb6fd47aac@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <4b39b097-4c88-4510-8b2e-8ffb6fd47aac@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab615af cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=4Ta1ijMdNn7WbP78VVsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfXxBEdW4Lr+/Aw
 Amfdu/sEmERb/gkRvGyEXDvW/KyIfC8vGG2wEkYtGPRUX+3nQtIoUB8pmmajvqCWYvm9MOJ8OGG
 TH7sHX9adnTZcOvgZ2HwC7vebT6iwk+9psVi7Cgde9AoGnLBZAaQ5g3cVC45n1qtnMxQ+3I93N+
 rb5gXPdi9+yAwBpisFyoTXTaUMFfH1K34Bc1GKpBzK+jP19wfYnMyM3AkdBvvfY792VUVkPLwzt
 g4RI4vaR075LH982FRH6LlLfOja+idyNdhpzFt5KkRruW0KG6lMEkKEvS6sHd3cbHeN/9i3/sOE
 +V8PyAz2wze+WxFxWaaMKjBBtSwjm7GJ7BNoXi2zKah3RSS3IkIPlezypp9Ls36zaxZFTcZmEmn
 /7+QZz2G/FeUQvo/lJY9qSsEMOrTJ+EFNP05Tj97GzZPSIqVZukcvCzk3baCz+iIpSvNEYxvebO
 7S3kfCiwt8JAZbNMwBQ==
X-Proofpoint-ORIG-GUID: O5rzjzInaJn7XG08XqVPEJnle1edlKQn
X-Proofpoint-GUID: aXjMj78uZ-ai2EADH6iKS_c7I4ljwtP3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNCBTYWx0ZWRfX+61eTSR0mg5B
 x6vsM3DBeXsoKwqW3Pp077V4P6jHDxS4FqmwNsilmWu7mhCQ8HXNHVSyZ4Gy5vpf4evihd/HxpU
 y8XJcbtqCkNIlvzOKd1ROm3P7l4ZJCo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250024
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 9/18/26 10:53 AM, Narayana Murty N wrote:
> Hi Utkarsh,
> 
> On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
>> From: Utkarsh Verma <uverma@linux.ibm.com>
>>
>> Extend the VOF client interface to support block device I/O through the
>> sPAPR SCSI disk, which is needed by bootloaders such as GRUB during VOF
>> disk boot.
>>
>> Add BlockBackend and position tracking fields to OfInstance and use them
>> in vof_seek(), vof_write() and vof_read() to extend their functionality
>> to handle block devices as well.
>>
>> In vof_do_open(), detect FDT nodes named "disk@<srp-lun>" and resolve
>> the SRP LUN encoding to the matching SCSIDevice/BlockBackend by scanning
>> id/channel/lun.
>>
>> Add vof_seek() to implement the OpenFirmware "seek" client service,
>> which was previously missing.
>>
>> AI-used-for: code
>> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
>> ---
>>   hw/ppc/trace-events |   2 +
>>   hw/ppc/vof.c        | 116 +++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 117 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index dbdcfada26..a61398ecb2 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -78,6 +78,7 @@ vof_error_unknown_service(const char *service, int 
>> nargs, int nret) "\"%s\" args
>>   vof_error_unknown_method(const char *method) "\"%s\""
>>   vof_error_unknown_ihandle_close(uint32_t ih) "ih=0x%x"
>>   vof_error_unknown_path(const char *path) "\"%s\""
>> +vof_error_seek(uint32_t ih) "ih=0x%x"
>>   vof_error_write(uint32_t ih) "ih=0x%x"
>>   vof_error_read(uint32_t ih) "ih=0x%x"
>>   vof_finddevice(const char *path, uint32_t ph) "\"%s\" => ph=0x%x"
>> @@ -92,6 +93,7 @@ vof_interpret(const char *cmd, uint32_t param1, 
>> uint32_t param2, uint32_t ret, u
>>   vof_package_to_path(uint32_t ph, const char *tmp, int ret) "ph=0x%x 
>> => %s len=%d"
>>   vof_instance_to_path(uint32_t ih, uint32_t ph, const char *tmp, int 
>> ret) "ih=0x%x ph=0x%x => %s len=%d"
>>   vof_instance_to_package(uint32_t ih, uint32_t ph) "ih=0x%x => ph=0x%x"
>> +vof_seek(uint32_t ih, uint64_t pos) "ih=0x%x pos=0x%"PRIx64
>>   vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] 
>> \"%s\""
>>   vof_read(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] 
>> \"%s\""
>>   vof_avail(uint64_t start, uint64_t end, uint64_t size) 
>> "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index 45c197df9f..b1c574aabf 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -11,6 +11,7 @@
>>   #include CONFIG_DEVICES /* CONFIG_PSERIES */
>>   #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>   #include "qemu/timer.h"
>>   #include "qemu/range.h"
>>   #include "qemu/units.h"
>> @@ -24,6 +25,8 @@
>>   #include "trace.h"
>>   #include "hw/ppc/spapr_vio.h"
>> +#include "hw/scsi/scsi.h"
>> +#include "system/block-backend.h"
>>   #include <libfdt.h>
>>   /*
>> @@ -46,6 +49,8 @@ typedef struct {
>>   typedef struct {
>>       char *path; /* the path used to open the instance */
>>       uint32_t phandle;
>> +    BlockBackend *blk;
>> +    uint64_t pos; /* current position for seek operations */
>>       void *vty;
>>   } OfInstance;
>> @@ -449,6 +454,7 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, 
>> int offset, const char *path)
>>   {
>>       uint32_t ret = PROM_ERROR;
>>       OfInstance *inst = NULL;
>> +    const char *node_name;
>>       if (vof->of_instance_last == 0xFFFFFFFF) {
>>           /* We do not recycle ihandles yet */
>> @@ -461,10 +467,42 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, 
>> int offset, const char *path)
>>       ++vof->of_instance_last;
>>       inst->path = g_strdup(path);
>> +    inst->blk = NULL;
>> +    inst->pos = 0;
>>       inst->vty = NULL;
>> +    node_name = fdt_get_name(fdt, offset, NULL);
>> +
>> +    if (node_name && strncmp(node_name, "disk@", 5) == 0) {
>> +        uint64_t srp_lun;
>> +        uint32_t id, channel, lun;
>> +        BlockBackend *blk;
>> +
>> +        if (qemu_strtou64(node_name + 5, NULL, 16, &srp_lun) == 0) {
>> +            id      = (srp_lun >> 56) & 0x3f;
>> +            channel = (srp_lun >> 53) & 0x7;
>> +            lun     = (srp_lun >> 48) & 0x1f;
>> +
>> +            for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
>> +                DeviceState *attached = blk_get_attached_dev(blk);
>> +                SCSIDevice *sdev;
>> +
>> +                if (!attached) {
>> +                    continue;
>> +                }
>> +                sdev = (SCSIDevice 
>> *)object_dynamic_cast(OBJECT(attached),
>> +                                                         
>> TYPE_SCSI_DEVICE);
>> +                if (sdev && sdev->id == (int)id &&
>> +                    sdev->channel == (int)channel &&
>> +                    sdev->lun == (int)lun) {
>> +                    inst->blk = blk;
>> +                    break;
>> +                }
>> +            }
> Shouldn't vof_do_open() first resolve that specific vSCSI controller/ 
> SCSIBus and then find the SCSIDevice on that bus, rather than searching 
> the global BlockBackend list?
> 
> Patch 8 already has code for resolving a v-scsi path to its SCSIBus; it 
> seems like the block-open path should use the same topology-aware lookup.
> 
Sorry, my bad. Will use the same vof_find_vscsi_bus() function to 
resolve the vSCSI bus and search for the matching id, channel and lun on 
that bus. Will fix in v2.

>> +        }
>> +    }
>> +
>>   #ifdef CONFIG_PSERIES
>> -    const char *node_name = fdt_get_name(fdt, offset, NULL);
>>       if (node_name && strncmp(node_name, "vty", 3) == 0) {
>>           uint8_t discard_buf[VOF_VTY_BUF_SIZE];
>>           MachineState *ms = MACHINE(qdev_get_machine());
>> @@ -601,6 +639,25 @@ static uint32_t vof_write(Vof *vof, uint32_t 
>> ihandle, uint32_t buf,
>>           return PROM_ERROR;
>>       }
>> +    if (inst->blk) {
>> +        g_autofree uint8_t *blkbuf = g_malloc(len);
>> +        int ret;
>> +
>> +        if (VOF_MEM_READ(buf, blkbuf, len) != MEMTX_OK) {
>> +            trace_vof_error_write(ihandle);
>> +            return PROM_ERROR;
>> +        }
>> +        ret = blk_pwrite(inst->blk, inst->pos, len, blkbuf, 0);
> Does VOF disk boot require block-device writes at all?
> 
> The series description talks about GRUB discovering the disk and reading 
> the kernel/initrd. If writable OF disk instances are not required for 
> boot, could we avoid exposing disk writes entirely?
> 
> If write support is required, this should also honour read-only backend 
> state and propagate blk_flush() errors rather than discarding them.

I added the write functionality because grub can record the selected 
menuentry in the saved_entry of grubenv file which requires a write 
operation, also editing the files from GRUB prompt requires the write 
functionality.
But will honour the backend's read-only state before attempting 
blk_pwrite(), and propagate blk_flush() errors through trace messages in v2.

>> +        if (ret < 0) {
>> +            trace_vof_error_write(ihandle);
>> +            return PROM_ERROR;
>> +        }
>> +        blk_flush(inst->blk);
>> +        inst->pos += len;
>> +        trace_vof_write(ihandle, len, "(disk)");
>> +        return len;
>> +    }
>> +
>>   #ifdef CONFIG_PSERIES
>>       if (inst->vty) {
>>           uint32_t total_written = 0;
>> @@ -646,6 +703,26 @@ static uint32_t vof_read(Vof *vof, uint32_t 
>> ihandle, uint32_t buf,
>>           return PROM_ERROR;
>>       }
>> +    if (inst->blk) {
>> +        g_autofree uint8_t *tmp = g_malloc(len);
> len comes from the OF client call, i.e. from the guest.
> 
> This means the guest can request an allocation up to UINT32_MAX before 
> either the block layer or guest-memory access is attempted.
> 
> I don't think blk_pread()/blk_pwrite() can be relied on for validating 
> this because the potentially huge host allocation has already happened 
> before those calls.
> 
> Could we instead use a small bounded bounce buffer and process the 
> request in chunks?
> 
> The maximum should preferably come from an existing QEMU block/I/O 
> convention rather than an arbitrary large allocation.
> 
Will fix in v2.

> Thanks,
> Narayana Murty N.
>> +        int ret;
>> +
>> +        ret = blk_pread(inst->blk, inst->pos, len, tmp, 0);
>> +        if (ret < 0) {
>> +            trace_vof_error_read(ihandle);
>> +            return PROM_ERROR;
>> +        }
>> +
>> +        if (VOF_MEM_WRITE(buf, tmp, len) != MEMTX_OK) {
>> +            trace_vof_error_read(ihandle);
>> +            return PROM_ERROR;
>> +        }
>> +
>> +        inst->pos += len;
>> +        trace_vof_read(ihandle, len, "(disk)");
>> +        return len;
>> +    }
>> +
>>   #ifdef CONFIG_PSERIES
>>       if (inst->vty) {
>>           uint8_t tmp[VOF_VTY_BUF_SIZE];
>> @@ -675,6 +752,41 @@ static uint32_t vof_read(Vof *vof, uint32_t 
>> ihandle, uint32_t buf,
>>       return 0;
>>   }
>> +static uint32_t vof_seek(Vof *vof, uint32_t ihandle, uint32_t pos_hi,
>> +                         uint32_t pos_lo)
>> +{
>> +    OfInstance *inst = (OfInstance *)
>> +        g_hash_table_lookup(vof->of_instances, 
>> GINT_TO_POINTER(ihandle));
>> +    uint64_t pos = ((uint64_t)pos_hi << 32) | pos_lo;
>> +
>> +    if (!inst) {
>> +        trace_vof_error_seek(ihandle);
>> +        return PROM_ERROR;
>> +    }
>> +
>> +    if (inst->blk) {
>> +        int64_t size = blk_getlength(inst->blk);
>> +
>> +        if (size < 0) {
>> +            trace_vof_error_seek(ihandle);
>> +            return PROM_ERROR;
>> +        }
>> +
>> +        if (pos > (uint64_t)size) {
>> +            trace_vof_error_seek(ihandle);
>> +            return PROM_ERROR;
>> +        }
>> +
>> +        inst->pos = pos;
>> +        trace_vof_seek(ihandle, pos);
>> +        return 0;
>> +    }
>> +
>> +    /* VTY and other devices don't support seek */
>> +    trace_vof_error_seek(ihandle);
>> +    return PROM_ERROR;
>> +}
>> +
>>   static void vof_claimed_dump(GArray *claimed)
>>   {
>>       int i;
>> @@ -985,6 +1097,8 @@ static uint32_t vof_client_handle(MachineState 
>> *ms, void *fdt, Vof *vof,
>>           ret = vof_package_to_path(fdt, args[0], args[1], args[2]);
>>       } else if (cmpserv("instance-to-path", 3, 1)) {
>>           ret = vof_instance_to_path(fdt, vof, args[0], args[1], 
>> args[2]);
>> +    } else if (cmpserv("seek", 3, 1)) {
>> +        ret = vof_seek(vof, args[0], args[1], args[2]);
>>       } else if (cmpserv("write", 3, 1)) {
>>           ret = vof_write(vof, args[0], args[1], args[2]);
>>       } else if (cmpserv("read", 3, 1)) {
> 
> 
Regards,
Utkarsh


