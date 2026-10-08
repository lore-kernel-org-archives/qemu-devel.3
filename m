Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F9CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkG8-0006Yd-N7; Thu, 08 Oct 2026 05:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xEkG4-0006Xs-NF; Thu, 08 Oct 2026 05:17:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xEkG2-0002Cv-8E; Thu, 08 Oct 2026 05:17:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987ZWL03120617; Thu, 8 Oct 2026 09:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SF2cNg
 q8B0oeRC7qRjc12NsMqqsdTqGU3BCuKhD69kI=; b=p7NswVVuWc9qsRhdKpdDwN
 T5IJ+6XFa9jBscNi9KAGaNFj4H4IxGGc1YAX1orrtpvHnUodA6MUqhJGSHrNnPGh
 01VPMB0dZhU0iI+jbw1RjjooNzwH/DeCP0MFQ38SJ6k5TO/9wfypcMY4BTzN9/Ma
 +htmUYXu8rkxxQKuxTUiYECoiqsX6HQ695DnWU67Ki+jl0HX0w6RWjhquYVuKoOA
 JNe86BV/Y35RM57ElbJWWx4RhSPEdNR3pozZyu7xiSVsnCPgJ7zH9ZPnX53bipv4
 61ezlkx1d1AmFJCi2hGus8dtI5m8OTeIuQJn1VvXnpl4sbOXj62bvjs4KY26tKiA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw2n02-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 09:17:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987Ig0S3089377; Thu, 8 Oct 2026 09:17:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5pru3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 09:17:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6989Gfgd30147234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 09:16:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 851D25805F;
 Thu,  8 Oct 2026 09:17:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F13558043;
 Thu,  8 Oct 2026 09:17:20 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 09:17:20 +0000 (GMT)
Message-ID: <38dba957-8f9b-405e-95e6-0fea48a3e3b8@linux.ibm.com>
Date: Thu, 8 Oct 2026 14:47:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/8] ppc/spapr: add VTY backend support to OF
 read/write/open services
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@amd.com,
 nnmlinux@linux.ibm.com, avnish@linux.ibm.com, pbonzini@redhat.com,
 th.huth@posteo.eu, sbhat@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, rathc@linux.ibm.com, philmd@linaro.org,
 npiggin@gmail.com, marcandre.lureau@redhat.com, fam@euphon.net,
 alex.bennee@linaro.org, richard.henderson@linaro.org
References: <20261002052605.605858-1-uverma@linux.ibm.com>
 <20261002052605.605858-5-uverma@linux.ibm.com>
 <24e395cc-09f8-36aa-9f6c-51d90f5b7bd9@eik.bme.hu>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <24e395cc-09f8-36aa-9f6c-51d90f5b7bd9@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: TjZ3aXaEk426oGa8zIvgHmCp049MUTJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX9XGThZfrG2Vg
 qzM6qTbWj/sJ7VBh4B48n2KPrt+RAac+0CLtkQTM2g6wnIToWp77M6U/2ett7EXNR1diDBtTXsB
 Orr00gySh5Ug/YuadW7XTbzpChQ/5/5y8qsVz06Aq1LblxEH4c42Wu9hs8wJ9sm+85XJtOmAZMD
 b1IOKoxvEWMJCzeK3aMbf+wAYUD4xrWVzmSktkdPKJOwAPbzJItueI2dJ58ilc7DydJfGsLDURk
 zP61pDUNypXt1LGi6L3PJoTG4XCFGc7ZuNIgxLymOJnucQBH30t3WKVSZkYamN4yuAvaLM0zWvW
 nAaAjjNCHnjulm4lWZl6ldCztY04Xj1l23AFCfK9MwVPDXYrgVrWgYWxEAWOAiQvonxb3znf9uj
 jl/7fUrpXY8sspUM6DbGj+bY1y8wpVewK2sfqPILPVTofA0pm2bNwDIjG99dZjgtNR5uvw6iDJL
 zTtszgpHu/eRRNi5upA==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac75fa9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=NfXh-FPyoLj2cRDr23sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX+Chp/ZkBwQQb
 rRaA9FsJidPvvkPaxgggs0MyggqyqjNsKzi06n3QocPd6wUQaqePPmgrn++9XBt/BUxypa+JrVF
 sVfF4Yi8LyivMqy1EimPaVi/cSmpM9U=
X-Proofpoint-ORIG-GUID: 68dMijvDlOQxXg-CIAktBFrEonEBYrpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
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

Hi Balaton,
Thank you for the review.

On 10/7/26 8:05 PM, BALATON Zoltan wrote:
> On Fri, 2 Oct 2026, uverma@linux.ibm.com wrote:
>> From: Utkarsh Verma <uverma@linux.ibm.com>
>>
>> Extend the VOF client interface to support console I/O through the 
>> sPAPR VTY
>> device, which is needed by bootloaders such as GRUB during disk boot.
>>
>> Add vof_read() to implement the OpenFirmware "read" client service, 
>> which was
>> previously missing.
>>
>> Route the OF read and write services backed by vty_getchars() and 
>> vty_putchars()
>>
>> Make vty_getchars() public similar to vty_putchars().
>>
>> AI-used-for: code
>> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
>> ---
>> hw/char/spapr_vty.c        |  2 +-
>> hw/ppc/spapr_vof.c         |  2 +
>> hw/ppc/trace-events        |  2 +
>> hw/ppc/vof.c               | 84 ++++++++++++++++++++++++++++++++++++++
>> include/hw/ppc/spapr_vio.h |  1 +
>> 5 files changed, 90 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
>> index 1dd9fb155c..2c97e0e027 100644
>> --- a/hw/char/spapr_vty.c
>> +++ b/hw/char/spapr_vty.c
>> @@ -52,7 +52,7 @@ static void vty_receive(void *opaque, const uint8_t 
>> *buf, int size)
>>     }
>> }
>>
>> -static int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
>> +int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
>> {
>>     SpaprVioVty *dev = VIO_SPAPR_VTY_DEVICE(sdev);
>>     int n = 0;
>> diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
>> index 78d5b7d5b5..3195c859a4 100644
>> --- a/hw/ppc/spapr_vof.c
>> +++ b/hw/ppc/spapr_vof.c
>> @@ -76,6 +76,8 @@ void spapr_vof_client_dt_finalize(SpaprMachineState 
>> *spapr, void *fdt)
>>     if (stdout_path) {
>>         _FDT(vof_client_open_store(fdt, spapr->vof, "/chosen", "stdout",
>>                                    stdout_path));
>> +        _FDT(vof_client_open_store(fdt, spapr->vof, "/chosen", "stdin",
>> +                                   stdout_path));
>>     }
>> }
>>
>> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
>> index 1f125ce841..dbdcfada26 100644
>> --- a/hw/ppc/trace-events
>> +++ b/hw/ppc/trace-events
>> @@ -79,6 +79,7 @@ vof_error_unknown_method(const char *method) "\"%s\""
>> vof_error_unknown_ihandle_close(uint32_t ih) "ih=0x%x"
>> vof_error_unknown_path(const char *path) "\"%s\""
>> vof_error_write(uint32_t ih) "ih=0x%x"
>> +vof_error_read(uint32_t ih) "ih=0x%x"
>> vof_finddevice(const char *path, uint32_t ph) "\"%s\" => ph=0x%x"
>> vof_claim(uint32_t virt, uint32_t size, uint32_t align, uint32_t ret) 
>> "virt=0x%x size=0x%x align=0x%x => 0x%x"
>> vof_release(uint32_t virt, uint32_t size, uint32_t ret) "virt=0x%x 
>> size=0x%x => 0x%x"
>> @@ -92,6 +93,7 @@ vof_package_to_path(uint32_t ph, const char *tmp, 
>> int ret) "ph=0x%x => %s len=%d
>> vof_instance_to_path(uint32_t ih, uint32_t ph, const char *tmp, int 
>> ret) "ih=0x%x ph=0x%x => %s len=%d"
>> vof_instance_to_package(uint32_t ih, uint32_t ph) "ih=0x%x => ph=0x%x"
>> vof_write(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] 
>> \"%s\""
>> +vof_read(uint32_t ih, unsigned cb, const char *msg) "ih=0x%x [%u] 
>> \"%s\""
>> vof_avail(uint64_t start, uint64_t end, uint64_t size) 
>> "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>> vof_claimed(uint64_t start, uint64_t end, uint64_t size) 
>> "0x%"PRIx64"..0x%"PRIx64" size=0x%"PRIx64
>>
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index 9ad1aa7626..6f6d424347 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -9,6 +9,7 @@
>>  * SPDX-License-Identifier: GPL-2.0-or-later
>>  */
>>
>> +#include CONFIG_DEVICES /* CONFIG_PSERIES */
>> #include "qemu/osdep.h"
>> #include "qemu/ctype.h"
>> #include "qemu/timer.h"
>> @@ -23,6 +24,7 @@
>> #include "qom/qom-qobject.h"
>> #include "trace.h"
>>
>> +#include "hw/ppc/spapr_vio.h"
>> #include <libfdt.h>
>>
>> /*
>> @@ -45,6 +47,7 @@ typedef struct {
>> typedef struct {
>>     char *path; /* the path used to open the instance */
>>     uint32_t phandle;
>> +    void *vty;
>> } OfInstance;
>>
>> static int readstr(hwaddr pa, char *buf, int size)
>> @@ -459,6 +462,28 @@ static uint32_t vof_do_open(void *fdt, Vof *vof, 
>> int offset, const char *path)
>>     ++vof->of_instance_last;
>>
>>     inst->path = g_strdup(path);
>> +    inst->vty = NULL;
>> +
>> +#ifdef CONFIG_PSERIES
>> +    const char *node_name = fdt_get_name(fdt, offset, NULL);
>> +    if (node_name && strncmp(node_name, "vty", 3) == 0) {
>> +        uint8_t discard_buf[VOF_VTY_BUF_SIZE];
>> +        MachineState *ms = MACHINE(qdev_get_machine());
>> +        SpaprMachineState *spapr = SPAPR_MACHINE(ms);
>> +
>> +        if (spapr && spapr->vio_bus) {
>> +            inst->vty = spapr_vty_get_default(spapr->vio_bus);
>> +            if (inst->vty) {
>> +                /* Flush any stale data from the VTY input buffer */
>> +                while (vty_getchars(inst->vty, discard_buf,
>> +                                    sizeof(discard_buf)) > 0) {
>> +                    /* discard */
>> +                }
>> +            }
>> +        }
>> +    }
>> +#endif
>> +
>>     g_hash_table_insert(vof->of_instances,
>>                         GINT_TO_POINTER(vof->of_instance_last),
>>                         inst);
>> @@ -577,6 +602,23 @@ static uint32_t vof_write(Vof *vof, uint32_t 
>> ihandle, uint32_t buf,
>>         return PROM_ERROR;
>>     }
>>
>> +#ifdef CONFIG_PSERIES
>> +    if (inst->vty) {
>> +        uint32_t total_written = 0;
>> +
>> +        for ( ; len > 0; len -= cb) {
>> +            cb = MIN(len, sizeof(tmp));
>> +            if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
>> +                return PROM_ERROR;
>> +            }
>> +            vty_putchars(inst->vty, (uint8_t *)tmp, cb);
>> +            buf += cb;
>> +            total_written += cb;
>> +        }
>> +        return total_written;
>> +    }
>> +#endif
>> +
> 
> Instead of adding #ifdefs in this file could these be implemented as 
> some functions exported by spapr_vof.c and called here without needing 
> #ifdefs? Maybe it could be part of VofMachineIfClass similar to setprop.
> 
Agreed. In v3 I will add new callbacks in VofMachineIfClass for 
vty_open, vty_read and vty_write and implement all those in spapr_vof.c 
and just call the hook from here without needing any ifdefs.

> Regards,
> BALATON Zoltan
> 
>>     for ( ; len > 0; len -= cb) {
>>         cb = MIN(len, sizeof(tmp) - 1);
>>         if (VOF_MEM_READ(buf, tmp, cb) != MEMTX_OK) {
>> @@ -594,6 +636,46 @@ static uint32_t vof_write(Vof *vof, uint32_t 
>> ihandle, uint32_t buf,
>>     return len;
>> }
>>
>> +static uint32_t vof_read(Vof *vof, uint32_t ihandle, uint32_t buf,
>> +                         uint32_t len)
>> +{
>> +    OfInstance *inst = (OfInstance *)
>> +        g_hash_table_lookup(vof->of_instances, 
>> GINT_TO_POINTER(ihandle));
>> +
>> +    if (!inst) {
>> +        trace_vof_error_read(ihandle);
>> +        return PROM_ERROR;
>> +    }
>> +
>> +#ifdef CONFIG_PSERIES
>> +    if (inst->vty) {
>> +        uint8_t tmp[VOF_VTY_BUF_SIZE];
>> +        unsigned cb = MIN(len, sizeof(tmp));
>> +        uint32_t bytes_read = vty_getchars(inst->vty, tmp, cb);
>> +        if (bytes_read > 0) {
>> +            if (VOF_MEM_WRITE(buf, tmp, bytes_read) != MEMTX_OK) {
>> +                trace_vof_error_read(ihandle);
>> +                return PROM_ERROR;
>> +            }
>> +        }
>> +        if (trace_event_get_state(TRACE_VOF_READ) &&
>> +            qemu_loglevel_mask(LOG_TRACE)) {
>> +            char trace_buf[VOF_VTY_BUF_SIZE + 1];
>> +            memcpy(trace_buf, tmp, bytes_read);
>> +            trace_buf[bytes_read] = '\0';
>> +            trace_vof_read(ihandle, bytes_read, trace_buf);
>> +        }
>> +        return bytes_read;
>> +    }
>> +#endif
>> +
>> +    /*
>> +     * For other devices, return 0 to indicate no data available.
>> +     * This allows GRUB to continue without blocking on input.
>> +     */
>> +    return 0;
>> +}
>> +
>> static void vof_claimed_dump(GArray *claimed)
>> {
>>     int i;
>> @@ -906,6 +988,8 @@ static uint32_t vof_client_handle(MachineState 
>> *ms, void *fdt, Vof *vof,
>>         ret = vof_instance_to_path(fdt, vof, args[0], args[1], args[2]);
>>     } else if (cmpserv("write", 3, 1)) {
>>         ret = vof_write(vof, args[0], args[1], args[2]);
>> +    } else if (cmpserv("read", 3, 1)) {
>> +        ret = vof_read(vof, args[0], args[1], args[2]);
>>     } else if (cmpserv("claim", 3, 1)) {
>>         uint64_t ret64 = vof_claim(vof, args[0], args[1], args[2]);
>>
>> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
>> index 0ea0dbae8b..81e7c0b91b 100644
>> --- a/include/hw/ppc/spapr_vio.h
>> +++ b/include/hw/ppc/spapr_vio.h
>> @@ -136,6 +136,7 @@ static inline int spapr_vio_dma_set(SpaprVioDevice 
>> *dev, uint64_t taddr,
>> int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
>>
>> SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
>> +int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max);
>> void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
>> void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
>> void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd);
>>
> 

Regards,
Utkarsh


