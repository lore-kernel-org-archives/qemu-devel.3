Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43BCFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHStM-0004yh-G3; Mon, 27 Apr 2026 16:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHStG-0004wZ-MF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:49:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHStC-0008D3-AO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:49:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RIWAc6811499; Mon, 27 Apr 2026 20:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LPeKYL
 MvcY77CiSIPm1Y0H7wBkGochZhwYnfepkhDPo=; b=WxE9+OaaAm7+rgfdLNT95M
 PQR27xZJkVUGyzVn+itKRn5vwyg3l6t/vDnO6cN3P2Ggl9PuNmfizgwe9Xo2p9Pf
 LaaqXuyTR7Iq62sHX375+X2Nic9XUeFg/1xtGAwoQSEtQUnphgIcZdnD/I7aieIQ
 ZZg82N8s4u1y8VipzLC/57DLaYapDAlqYafYIhIOU/4ED+FHXa5vAZtyAfRwNY26
 APIcMXZR+gN5uyY4Ew5JGrqpkvF5vQAjiMqF1pOei5+GZBQWvA346DmK5/BwpoCO
 hsoMLWF1DRcOBiesXB8iTZ9aRpN1LQSktZwS/+lKQ/RH1eLwDam+9OA90vpKlEhQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb52fkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:49:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RKcmuM017681;
 Mon, 27 Apr 2026 20:49:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq70tc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:49:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63RKn53o33489646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 20:49:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD42758052;
 Mon, 27 Apr 2026 20:49:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE585805E;
 Mon, 27 Apr 2026 20:49:05 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 20:49:05 +0000 (GMT)
Message-ID: <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
Date: Mon, 27 Apr 2026 16:49:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20260427200134.453022-1-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260427200134.453022-1-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69efcbc3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=SvRv-rtrRAkuRqVAnvwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIyMSBTYWx0ZWRfXyt9ksJGg8Xkl
 qVcZJ3RYqSsIxSpgIBOGyez6XfeeWBEXC47IdMkacULYlLJzG74/6CQ7t49ZWTViHeXZvove46x
 3E2yCsV7GoCMdttDFvdRZ2NJ4f9UyKNG2M7cRI0Vm1XrJfNv34k5R++uB1HbK495GfBc1QYA/uA
 PfL78dkKWHeeMAdLi76m+w/bbOQGYJcK9PP4xWrZ0iU7A+oQ106fr37yJ6kv16rIGgInrWNeNZ8
 4IU54UNd4p//kcXMgOUpBd3D7/+KSv+RyJqPVqGN2J2B7mf1cNDUt90ETlLCA3EROYxIKraLovX
 nPZWSbX/faL8Yc/G0sptFK5VsQmD/PmrLuEL+du3GVHSb2BR8dK4wsFh9cbCaAtZYT6V4dXRH/d
 9V5KjrTtt4SozQ77t7yHzQ+WR97f3xqmn0IeNV4nvmCGMM6kofNZJN08ZmC5DED3lhKzLfs3o/r
 xrVhkZWv/1nbfe9wrCA==
X-Proofpoint-GUID: t8lkF1UIzfUPo4eNlG---3ywNNCFptN0
X-Proofpoint-ORIG-GUID: t8lkF1UIzfUPo4eNlG---3ywNNCFptN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270221
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



On 4/27/26 4:01 PM, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> The TPM TIS buffer is currently a fixed-size static array. Change this
> to a dynamically allocated heap block. The buffer size is now determined
> at runtime by querying the TPM backend.

Do we really need this? I mean for the forseeable future 8kb should be 
sufficient.

> 
> To support VM migration,
> 1. Replace the static VMSTATE_BUFFER macro with pointer-based variant
>     VMSTATE_BUFFER_POINTER_UNSAFE, explicitly mentioning the size.
> 2. Introduce ext_buffer and ext_size in the migration subsection to
>     track allocation exceeding TPM_TIS_BUFFER_MAX. Allocate ext_buffer
>     using VMSTATE_VBUFFER_ALLOC_UINT32 only to be freed later after it is
>     appended to the main buffer.
> 
> This allows us to migrate to a destination host without breaking
> backward compatibility. Old QEMU does not include a size field along
> with the buffer in the migration stream, and therefore the
> new QEMU is also forced to keep expecting exactly 4096 bytes.
> 
> Implement a post_load hook that will validate the incoming data size
> from the migration stream, failing the migration if it exceeds the
> destination backend capacity. Add unrealize functions for the TIS interface
> types ISA, SysBus and I2C to ensure that the buffer is safely freed on
> device destruction.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
> Dependencies:
> This patch depends on the following patch currently in the mailing list:
> https://lore.kernel.org/qemu-devel/20260422103018.123608-10-armenon@redhat.com/

I had tried to apply your v5 series to master but could not. Do you have 
a git repo where you keep your patches?

> 
> Depends-on: <20260422103018.123608-10-armenon@redhat.com>
> 
>   hw/tpm/tpm_tis.h        |  6 ++++-
>   hw/tpm/tpm_tis_common.c | 56 +++++++++++++++++++++++++++++++++++------
>   hw/tpm/tpm_tis_i2c.c    | 28 +++++++++++++++++++--
>   hw/tpm/tpm_tis_isa.c    | 31 +++++++++++++++++++++--
>   hw/tpm/tpm_tis_sysbus.c | 32 +++++++++++++++++++++--
>   5 files changed, 138 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index b2d9c0116c..c736ecedc1 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -56,7 +56,9 @@ typedef struct TPMLocality {
>   typedef struct TPMState {
>       MemoryRegion mmio;
>   
> -    unsigned char buffer[TPM_TIS_BUFFER_MAX];
> +    uint8_t *buffer;
> +    uint8_t *ext_buffer;
> +    uint32_t ext_size;
>       uint16_t rw_offset;
>   
>       uint8_t active_locty;
> @@ -82,6 +84,8 @@ extern const VMStateDescription vmstate_locty;
>   extern const MemoryRegionOps tpm_tis_memory_ops;
>   
>   int tpm_tis_pre_save(TPMState *s);
> +int tpm_tis_post_load(TPMState *s);
> +int tpm_tis_ext_buffer_post_load(TPMState *s);
>   void tpm_tis_reset(TPMState *s, bool ppi_enabled);
>   enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
>   void tpm_tis_request_completed(TPMState *s, int ret);
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index 43e68410f8..c9c4dd1190 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -270,7 +270,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
>       uint16_t len;
>   
>       if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
> -        len = MIN(tpm_cmd_get_size(&s->buffer),
> +        len = MIN(tpm_cmd_get_size(s->buffer),
>                     s->be_buffer_size);
>   
>           ret = s->buffer[s->rw_offset++];
> @@ -317,7 +317,7 @@ static void tpm_tis_dump_state(TPMState *s, hwaddr addr)
>              "tpm_tis: result buffer : ",
>              s->rw_offset);
>       for (idx = 0;
> -         idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
> +         idx < MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
>            idx++) {
>           printf("%c%02x%s",
>                  s->rw_offset == idx ? '>' : ' ',
> @@ -383,7 +383,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
>           if (s->active_locty == locty) {
>               if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
>                   val = TPM_TIS_BURST_COUNT(
> -                       MIN(tpm_cmd_get_size(&s->buffer),
> +                       MIN(tpm_cmd_get_size(s->buffer),
>                              s->be_buffer_size)
>                          - s->rw_offset) | s->loc[locty].sts;
>               } else {
> @@ -754,7 +754,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>                   /* we have a packet length - see if we have all of it */
>                   bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
>   
> -                len = tpm_cmd_get_size(&s->buffer);
> +                len = tpm_cmd_get_size(s->buffer);
>                   if (len > s->rw_offset) {
>                       tpm_tis_sts_set(&s->loc[locty],
>                                       TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
> @@ -818,9 +818,10 @@ void tpm_tis_reset(TPMState *s, bool ppi_enabled)
>       int c;
>   
>       s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
> -    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
> -                            TPM_TIS_BUFFER_MAX);
>   
> +    s->be_buffer_size = tpm_backend_get_buffer_size(s->be_driver);
> +    s->buffer = g_realloc(s->buffer, MAX(s->be_buffer_size,
> +                          TPM_TIS_BUFFER_MAX));

With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the backend 
says so -- hm...

>       if (ppi_enabled) {
>           tpm_ppi_reset(&s->ppi);
>       }
> @@ -873,6 +874,45 @@ int tpm_tis_pre_save(TPMState *s)
>        */
>       tpm_backend_finish_sync(s->be_driver);
>   
> +    if (s->be_buffer_size > TPM_TIS_BUFFER_MAX) {
> +        s->ext_size = s->be_buffer_size - TPM_TIS_BUFFER_MAX;
> +        s->ext_buffer = s->buffer + TPM_TIS_BUFFER_MAX;
> +    } else {
> +        s->ext_size = 0;
> +        s->ext_buffer = NULL;
> +    }
> +    return 0;
> +}
> +
> +int tpm_tis_post_load(TPMState *s)
> +{
> +    if (s->rw_offset > s->be_buffer_size) {
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +int tpm_tis_ext_buffer_post_load(TPMState *s)
> +{
> +    /*
> +     * Calculate the maximum extension buffer size allowed, by comparing
> +     * the destination VM's backend capacity with TPM_TIS_BUFFER_MAX.
> +     */
> +    uint32_t max_ext = s->be_buffer_size > TPM_TIS_BUFFER_MAX ?
> +                       s->be_buffer_size - TPM_TIS_BUFFER_MAX : 0;
> +
> +    if (s->ext_size > max_ext) {
> +        /*
> +         * Source buffer size is greater than what the destination backend
> +         * allows
> +         */
> +        g_clear_pointer(&s->ext_buffer, g_free);
> +        return -EINVAL;
> +    }
> +    if (s->ext_size > 0) {
> +        memcpy(s->buffer + TPM_TIS_BUFFER_MAX, s->ext_buffer, s->ext_size);
> +        g_clear_pointer(&s->ext_buffer, g_free);
> +    }
>       return 0;
>   }
>   
> @@ -901,7 +941,7 @@ bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s)
>       case TPM_TIS_STATE_READY:
>           return false;
>       case TPM_TIS_STATE_RECEPTION:
> -        return s->rw_offset >= 4096;
> +        return s->rw_offset >= TPM_TIS_BUFFER_MAX;

This cannot be right.

For PQC support we extended the 4096 byte buffer from 4096 bytes to 8192 
byte but only want to store the 2nd 4096 bytes if necessary and to keep 
backwards compatibility.

This function was called to determine whether more than 4096 bytes were 
either written to the buffer by the OS driver or received from the TPM 
as a response so that we now would have to send the additional 2nd 4096 
bytes. But TPM_TIS_BUFFER_MAX is 8192.



 >       case TPM_TIS_STATE_EXECUTION:>           /*
>            * TPM is executing: we cannot know the size of TPM response.
> @@ -909,7 +949,7 @@ bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s)
>            */
>           return false;
>       case TPM_TIS_STATE_COMPLETION:
> -        return (tpm_cmd_get_size(&s->buffer) >= 4096);
> +        return (tpm_cmd_get_size(s->buffer) >= TPM_TIS_BUFFER_MAX);

Not good, either.

>       }
>       return false;
>   }
> diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
> index f48938e3a1..41a5486497 100644
> --- a/hw/tpm/tpm_tis_i2c.c
> +++ b/hw/tpm/tpm_tis_i2c.c
> @@ -103,6 +103,10 @@ static int tpm_tis_i2c_post_load(void *opaque, int version_id)
>   {
>       TPMStateI2C *i2cst = opaque;
>   
> +    if (tpm_tis_post_load(&i2cst->state) < 0) {
> +        return -1;
> +    }
> +
>       if (i2cst->offset >= 1) {
>           tpm_tis_i2c_to_tis_reg(i2cst, i2cst->data[0]);
>       }
> @@ -117,13 +121,23 @@ static bool tpm_tis_ext_buffer_migration_needed_i2c(void *opaque)
>       return tpm_tis_ext_buffer_migration_needed(&i2cst->state);
>   }
>   
> +static int tpm_tis_ext_buffer_post_load_i2c(void *opaque, int version_id)
> +{
> +    TPMStateI2C *i2cst = opaque;
> +
> +    return tpm_tis_ext_buffer_post_load(&i2cst->state);
> +}
> +
>   static const VMStateDescription vmstate_tpm_tis_ext_buffer_i2c = {
>       .name = "tpm-tis/ext_buffer",
>       .version_id = 0,
>       .needed = tpm_tis_ext_buffer_migration_needed_i2c,
>       .pre_save = tpm_tis_i2c_pre_save,
> +    .post_load = tpm_tis_ext_buffer_post_load_i2c,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateI2C, 4096),

Here we instructed the buffer to be written from 4096 bytes to 8192 
bytes, so the 2nd part. I don't think your changes are changing it to 
anything equivalent.

> +        VMSTATE_UINT32(state.ext_size, TPMStateI2C),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(state.ext_buffer, TPMStateI2C, 0, NULL,
> +                                     state.ext_size),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -134,7 +148,8 @@ static const VMStateDescription vmstate_tpm_tis_i2c = {
>       .pre_save  = tpm_tis_i2c_pre_save,
>       .post_load  = tpm_tis_i2c_post_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateI2C, 4096),

This was supposed to store the first 4096 bytes of the buffer to keep 
backwards compatibility. And the 2nd 4096 bytes were only supposed to be 
written if found necessary.

> +        VMSTATE_BUFFER_POINTER_UNSAFE(state.buffer, TPMStateI2C, 0,
> +                                      TPM_TIS_BUFFER_MAX),
>           VMSTATE_UINT16(state.rw_offset, TPMStateI2C),
>           VMSTATE_UINT8(state.active_locty, TPMStateI2C),
>           VMSTATE_UINT8(state.aborting_locty, TPMStateI2C),
> @@ -535,6 +550,14 @@ static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void tpm_tis_i2c_unrealizefn(DeviceState *dev)
> +{
> +    TPMStateI2C *i2cst = TPM_TIS_I2C(dev);
> +    TPMState *state = &i2cst->state;
> +
> +    g_clear_pointer(&state->buffer, g_free);
> +}
> +
>   static void tpm_tis_i2c_reset(DeviceState *dev)
>   {
>       TPMStateI2C *i2cst = TPM_TIS_I2C(dev);
> @@ -555,6 +578,7 @@ static void tpm_tis_i2c_class_init(ObjectClass *klass, const void *data)
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
>   
>       dc->realize = tpm_tis_i2c_realizefn;
> +    dc->unrealize = tpm_tis_i2c_unrealizefn;
>       device_class_set_legacy_reset(dc, tpm_tis_i2c_reset);
>       dc->vmsd = &vmstate_tpm_tis_i2c;
>       device_class_set_props(dc, tpm_tis_i2c_properties);
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 4999de1c61..7fbdfb96e6 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -49,6 +49,12 @@ static int tpm_tis_pre_save_isa(void *opaque)
>       return tpm_tis_pre_save(&isadev->state);
>   }
>   
> +static int tpm_tis_post_load_isa(void *opaque, int version_id)
> +{
> +    TPMStateISA *isadev = opaque;
> +    return tpm_tis_post_load(&isadev->state);
> +}
> +
>   static bool tpm_tis_ext_buffer_migration_needed_isa(void *opaque)
>   {
>       TPMStateISA *isadev = opaque;
> @@ -56,13 +62,23 @@ static bool tpm_tis_ext_buffer_migration_needed_isa(void *opaque)
>       return tpm_tis_ext_buffer_migration_needed(&isadev->state);
>   }
>   
> +static int tpm_tis_ext_buffer_post_load_isa(void *opaque, int version_id)
> +{
> +    TPMStateISA *isadev = opaque;
> +
> +    return tpm_tis_ext_buffer_post_load(&isadev->state);
> +}
> +
>   static const VMStateDescription vmstate_tpm_tis_ext_buffer_isa = {
>       .name = "tpm-tis/ext_buffer",
>       .version_id = 0,
>       .needed = tpm_tis_ext_buffer_migration_needed_isa,
>       .pre_save = tpm_tis_pre_save_isa,
> +    .post_load = tpm_tis_ext_buffer_post_load_isa,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateISA, 4096),
> +        VMSTATE_UINT32(state.ext_size, TPMStateISA),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(state.ext_buffer, TPMStateISA, 0, NULL,
> +                                     state.ext_size),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -71,8 +87,10 @@ static const VMStateDescription vmstate_tpm_tis_isa = {
>       .name = "tpm-tis",
>       .version_id = 0,
>       .pre_save  = tpm_tis_pre_save_isa,
> +    .post_load = tpm_tis_post_load_isa,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateISA, 4096),
> +        VMSTATE_BUFFER_POINTER_UNSAFE(state.buffer, TPMStateISA, 0,
> +                                      TPM_TIS_BUFFER_MAX),
>           VMSTATE_UINT16(state.rw_offset, TPMStateISA),
>           VMSTATE_UINT8(state.active_locty, TPMStateISA),
>           VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
> @@ -157,6 +175,14 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
>                    TPM_PPI_ADDR_BASE, OBJECT(dev));
>   }
>   
> +static void tpm_tis_isa_unrealizefn(DeviceState *dev)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(dev);
> +    TPMState *state = &isadev->state;
> +
> +    g_clear_pointer(&state->buffer, g_free);
> +}
> +
>   static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
>   {
>       Aml *dev, *crs;
> @@ -196,6 +222,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, const void *data)
>       tc->model = TPM_MODEL_TPM_TIS;
>       tc->ppi_enabled = true;
>       dc->realize = tpm_tis_isa_realizefn;
> +    dc->unrealize = tpm_tis_isa_unrealizefn;
>       device_class_set_legacy_reset(dc, tpm_tis_isa_reset);
>       tc->request_completed = tpm_tis_isa_request_completed;
>       tc->get_version = tpm_tis_isa_get_tpm_version;
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index c29f43bdce..ad8cfa85b1 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -49,6 +49,13 @@ static int tpm_tis_pre_save_sysbus(void *opaque)
>       return tpm_tis_pre_save(&sbdev->state);
>   }
>   
> +static int tpm_tis_post_load_sysbus(void *opaque, int version_id)
> +{
> +    TPMStateSysBus *sbdev = opaque;
> +
> +    return tpm_tis_post_load(&sbdev->state);
> +}
> +
>   static bool tpm_tis_ext_buffer_migration_needed_sysbus(void *opaque)
>   {
>       TPMStateSysBus *sbdev = opaque;
> @@ -56,13 +63,23 @@ static bool tpm_tis_ext_buffer_migration_needed_sysbus(void *opaque)
>       return tpm_tis_ext_buffer_migration_needed(&sbdev->state);
>   }
>   
> +static int tpm_tis_ext_buffer_post_load_sysbus(void *opaque, int version_id)
> +{
> +    TPMStateSysBus *sbdev = opaque;
> +
> +    return tpm_tis_ext_buffer_post_load(&sbdev->state);
> +}
> +
>   static const VMStateDescription vmstate_tpm_tis_ext_buffer_sysbus = {
>       .name = "tpm-tis/ext_buffer",
>       .version_id = 0,
>       .needed = tpm_tis_ext_buffer_migration_needed_sysbus,
>       .pre_save  = tpm_tis_pre_save_sysbus,
> +    .post_load = tpm_tis_ext_buffer_post_load_sysbus,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateSysBus, 4096),
> +        VMSTATE_UINT32(state.ext_size, TPMStateSysBus),
> +        VMSTATE_VBUFFER_ALLOC_UINT32(state.ext_buffer, TPMStateSysBus, 0,
> +                                     NULL, state.ext_size),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -71,8 +88,10 @@ static const VMStateDescription vmstate_tpm_tis_sysbus = {
>       .name = "tpm-tis",
>       .version_id = 0,
>       .pre_save  = tpm_tis_pre_save_sysbus,
> +    .post_load = tpm_tis_post_load_sysbus,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateSysBus, 4096),
> +        VMSTATE_BUFFER_POINTER_UNSAFE(state.buffer, TPMStateSysBus, 0,
> +                                      TPM_TIS_BUFFER_MAX),
>           VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
>           VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
>           VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
> @@ -156,6 +175,14 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>       vmstate_register_ram(&s->ppi.ram, dev);
>   }
>   
> +static void tpm_tis_sysbus_unrealizefn(DeviceState *dev)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> +    TPMState *state = &sbdev->state;
> +
> +    g_clear_pointer(&state->buffer, g_free);
> +}
> +
>   static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -166,6 +193,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
>       tc->model = TPM_MODEL_TPM_TIS;
>       tc->ppi_enabled = true;
>       dc->realize = tpm_tis_sysbus_realizefn;
> +    dc->unrealize = tpm_tis_sysbus_unrealizefn;
>       device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
>       tc->request_completed = tpm_tis_sysbus_request_completed;
>       tc->get_version = tpm_tis_sysbus_get_tpm_version;


