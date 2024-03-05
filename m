Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A618C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQ1S-0006Vu-8j; Tue, 05 Mar 2024 03:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rhQ1Q-0006Uv-2t; Tue, 05 Mar 2024 03:19:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rhQ1N-0004zI-8U; Tue, 05 Mar 2024 03:19:35 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42582aV8005250; Tue, 5 Mar 2024 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r2QTAwrKW1RH/bswUotMXz+8/tGhRPp6rl9J/4aI+XU=;
 b=ULjdWdvnuMGde2bblRT3sSf05U+2cHM5X3gJjVoU16HKcK9RACYBMR73gVmvtabRrMVF
 AiyMy5HrUftX6mLBadD029gNcmmIW1KVLfNE7pJyahLwP2O2ikq/UcHRhRb706GicYYz
 r5srykeRj9lT25hUjLa+UVeW9U3CjDnjPNswPn8hzIS/TjL0PgCNs/HbZ/NfojHgPy06
 cDJ5TXs250PLauIhRJfJ9TxRsVoxLDqeSoo/hDdwkJha0DBnNYBZ0/n8dxHPdMUcriPF
 jlZmI6xqDuQiGeFfQX/BL7Nkbo1N9fC7iXYvcYDRdUlq6+Po1dY3m+pjY19Wa946ZFEX og== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnyhdrf5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:19:26 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42582Wlf005018;
 Tue, 5 Mar 2024 08:19:25 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wnyhdrf57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:19:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42567gp3010877; Tue, 5 Mar 2024 08:19:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh525r64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 08:19:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4258JKrh8389284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Mar 2024 08:19:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F7DF5805D;
 Tue,  5 Mar 2024 08:19:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DD4C58043;
 Tue,  5 Mar 2024 08:19:17 +0000 (GMT)
Received: from [9.109.243.35] (unknown [9.109.243.35])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Mar 2024 08:19:17 +0000 (GMT)
Message-ID: <5128319f-ed58-40ef-8ac2-eb31e21c5d19@linux.ibm.com>
Date: Tue, 5 Mar 2024 13:49:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
References: <20240220083609.748325-1-harshpb@linux.ibm.com>
 <20240220083609.748325-12-harshpb@linux.ibm.com>
 <CZFS2TVTOKU5.3ISRK1DE1O89R@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CZFS2TVTOKU5.3ISRK1DE1O89R@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ezOu30IwWLeykMmkJJpda0yBcH-7XAEI
X-Proofpoint-ORIG-GUID: yGG4PrhzkLYbwTEStOyDBPB2_IVIlNxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050064
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Nick,

On 2/27/24 15:40, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 6:36 PM AEST, Harsh Prateek Bora wrote:
>> Introduce the nested PAPR hcalls:
>>      - H_GUEST_GET_STATE which is used to get state of a nested guest or
>>        a guest VCPU. The value field for each element in the request is
>>        ignored and on success, will be updated to reflect current state.
> 
> This is a bit hard to parse. The value fields are destinations for
> values to be stored (from the point of view of the caller), which is
> familiar to most get or read type APIs.
> 
> I don't think you need to say it's ignored. The value it contains is
> ignored and overwritten, but the field itself is not actually ignored :)
> 
> Patch looks okay though.

Sure, updating the commit log to make it more clear.

> 
>>      - H_GUEST_SET_STATE which is used to modify the state of a guest or
>>        a guest VCPU. On success, guest (or its VCPU) state shall be
>>        updated as per the value field for the requested element(s).
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr.h        |   3 +
>>   include/hw/ppc/spapr_nested.h |  23 +++
>>   hw/ppc/spapr_nested.c         | 267 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 293 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 82b077bdd2..aabc32f268 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -366,6 +366,7 @@ struct SpaprMachineState {
>>   #define H_OVERLAP         -68
>>   #define H_STATE           -75
>>   #define H_IN_USE          -77
>> +#define H_INVALID_ELEMENT_VALUE            -81
>>   #define H_UNSUPPORTED_FLAG -256
>>   #define H_MULTI_THREADS_ACTIVE -9005
>>   
>> @@ -589,6 +590,8 @@ struct SpaprMachineState {
>>   #define H_GUEST_SET_CAPABILITIES 0x464
>>   #define H_GUEST_CREATE           0x470
>>   #define H_GUEST_CREATE_VCPU      0x474
>> +#define H_GUEST_GET_STATE        0x478
>> +#define H_GUEST_SET_STATE        0x47C
>>   #define H_GUEST_DELETE           0x488
>>   
>>   #define MAX_HCALL_OPCODE         H_GUEST_DELETE
>> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
>> index 492302a21d..1b7e55f12a 100644
>> --- a/include/hw/ppc/spapr_nested.h
>> +++ b/include/hw/ppc/spapr_nested.h
>> @@ -224,6 +224,10 @@ typedef struct SpaprMachineStateNestedGuest {
>>   #define HVMASK_MSR                    0xEBFFFFFFFFBFEFFF
>>   #define HVMASK_HDEXCR                 0x00000000FFFFFFFF
>>   #define HVMASK_TB_OFFSET              0x000000FFFFFFFFFF
>> +#define GSB_MAX_BUF_SIZE              (1024 * 1024)
>> +#define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000
>> +#define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
>> +#define GUEST_STATE_REQUEST_SET              0x2
>>   
>>   #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
>>       .id = (i),                                     \
>> @@ -312,6 +316,25 @@ typedef struct SpaprMachineStateNestedGuest {
>>   #define GSE_ENV_DWM(i, f, m) \
>>       GUEST_STATE_ELEMENT_MSK(i, 8, f, copy_state_8to8, m)
>>   
>> +struct guest_state_element {
>> +    uint16_t id;
>> +    uint16_t size;
>> +    uint8_t value[];
>> +} QEMU_PACKED;
>> +
>> +struct guest_state_buffer {
>> +    uint32_t num_elements;
>> +    struct guest_state_element elements[];
>> +} QEMU_PACKED;
>> +
>> +/* Actual buffer plus some metadata about the request */
>> +struct guest_state_request {
>> +    struct guest_state_buffer *gsb;
>> +    int64_t buf;
>> +    int64_t len;
>> +    uint16_t flags;
>> +};
>> +
>>   /*
>>    * Register state for entering a nested guest with H_ENTER_NESTED.
>>    * New member must be added at the end.
>> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
>> index faba27dd50..aba4b25da6 100644
>> --- a/hw/ppc/spapr_nested.c
>> +++ b/hw/ppc/spapr_nested.c
>> @@ -8,6 +8,7 @@
>>   #include "hw/ppc/spapr_nested.h"
>>   #include "mmu-book3s-v3.h"
>>   #include "cpu-models.h"
>> +#include "qemu/log.h"
>>   
>>   void spapr_nested_init(SpaprMachineState *spapr)
>>   {
>> @@ -999,6 +1000,140 @@ void spapr_nested_gsb_init(void)
>>       }
>>   }
>>   
>> +static struct guest_state_element *guest_state_element_next(
>> +    struct guest_state_element *element,
>> +    int64_t *len,
>> +    int64_t *num_elements)
>> +{
>> +    uint16_t size;
>> +
>> +    /* size is of element->value[] only. Not whole guest_state_element */
>> +    size = be16_to_cpu(element->size);
>> +
>> +    if (len) {
>> +        *len -= size + offsetof(struct guest_state_element, value);
>> +    }
>> +
>> +    if (num_elements) {
>> +        *num_elements -= 1;
>> +    }
>> +
>> +    return (struct guest_state_element *)(element->value + size);
>> +}
>> +
>> +static
>> +struct guest_state_element_type *guest_state_element_type_find(uint16_t id)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(guest_state_element_types); i++)
>> +        if (id == guest_state_element_types[i].id) {
>> +            return &guest_state_element_types[i];
>> +        }
>> +
>> +    return NULL;
>> +}
>> +
>> +static void log_element(struct guest_state_element *element,
>> +                        struct guest_state_request *gsr)
>> +{
>> +    qemu_log_mask(LOG_GUEST_ERROR, "h_guest_%s_state id:0x%04x size:0x%04x",
>> +                  gsr->flags & GUEST_STATE_REQUEST_SET ? "set" : "get",
>> +                  be16_to_cpu(element->id), be16_to_cpu(element->size));
>> +    qemu_log_mask(LOG_GUEST_ERROR, "buf:0x%016lx ...\n",
>> +                  be64_to_cpu(*(uint64_t *)element->value));
>> +}
>> +
>> +static bool guest_state_request_check(struct guest_state_request *gsr)
>> +{
>> +    int64_t num_elements, len = gsr->len;
>> +    struct guest_state_buffer *gsb = gsr->gsb;
>> +    struct guest_state_element *element;
>> +    struct guest_state_element_type *type;
>> +    uint16_t id, size;
>> +
>> +    /* gsb->num_elements = 0 == 32 bits long */
>> +    assert(len >= 4);
>> +
>> +    num_elements = be32_to_cpu(gsb->num_elements);
>> +    element = gsb->elements;
>> +    len -= sizeof(gsb->num_elements);
>> +
>> +    /* Walk the buffer to validate the length */
>> +    while (num_elements) {
>> +
>> +        id = be16_to_cpu(element->id);
>> +        size = be16_to_cpu(element->size);
>> +
>> +        if (false) {
>> +            log_element(element, gsr);
>> +        }
>> +        /* buffer size too small */
>> +        if (len < 0) {
>> +            return false;
>> +        }
>> +
>> +        type = guest_state_element_type_find(id);
>> +        if (!type) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,"Element ID %04x unknown\n", id);
>> +            log_element(element, gsr);
>> +            return false;
>> +        }
>> +
>> +        if (id == GSB_HV_VCPU_IGNORED_ID) {
>> +            goto next_element;
>> +        }
>> +
>> +        if (size != type->size) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,"Size mismatch. Element ID:%04x."
>> +                          "Size Exp:%i Got:%i\n", id, type->size, size);
>> +            log_element(element, gsr);
>> +            return false;
>> +        }
>> +
>> +        if ((type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_READ_ONLY) &&
>> +            (gsr->flags & GUEST_STATE_REQUEST_SET)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,"trying to set a read-only Element "
>> +                          "ID:%04x.\n", id);
>> +            return false;
>> +        }
>> +
>> +        if (type->flags & GUEST_STATE_ELEMENT_TYPE_FLAG_GUEST_WIDE) {
>> +            /* guest wide element type */
>> +            if (!(gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE)) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a guest wide "
>> +                              "Element ID:%04x.\n", id);
>> +                return false;
>> +            }
>> +        } else {
>> +            /* thread wide element type */
>> +            if (gsr->flags & GUEST_STATE_REQUEST_GUEST_WIDE) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "trying to set a thread wide "
>> +                              "Element ID:%04x.\n", id);
>> +                return false;
>> +            }
>> +        }
>> +next_element:
>> +        element = guest_state_element_next(element, &len, &num_elements);
>> +
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool is_gsr_invalid(struct guest_state_request *gsr,
>> +                                   struct guest_state_element *element,
>> +                                   struct guest_state_element_type *type)
>> +{
>> +    if ((gsr->flags & GUEST_STATE_REQUEST_SET) &&
>> +        (*(uint64_t *)(element->value) & ~(type->mask))) {
>> +        log_element(element, gsr);
>> +        qemu_log_mask(LOG_GUEST_ERROR, "L1 can't set reserved bits i"
>> +                      "(allowed mask: 0x%08lx)\n", type->mask);
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>>   static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
>>                                                SpaprMachineState *spapr,
>>                                                target_ulong opcode,
>> @@ -1244,6 +1379,136 @@ static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
>>       return H_SUCCESS;
>>   }
>>   
>> +static target_ulong getset_state(SpaprMachineStateNestedGuest *guest,
>> +                                 uint64_t vcpuid,
>> +                                 struct guest_state_request *gsr)
>> +{
>> +    void *ptr;
>> +    uint16_t id;
>> +    struct guest_state_element *element;
>> +    struct guest_state_element_type *type;
>> +    int64_t lenleft, num_elements;
>> +
>> +    lenleft = gsr->len;
>> +
>> +    if (!guest_state_request_check(gsr)) {
>> +        return H_P3;
>> +    }
>> +
>> +    num_elements = be32_to_cpu(gsr->gsb->num_elements);
>> +    element = gsr->gsb->elements;
>> +    /* Process the elements */
>> +    while (num_elements) {
>> +        type = NULL;
>> +        /* log_element(element, gsr); */
>> +
>> +        id = be16_to_cpu(element->id);
>> +        if (id == GSB_HV_VCPU_IGNORED_ID) {
>> +            goto next_element;
>> +        }
>> +
>> +        type = guest_state_element_type_find(id);
>> +        assert(type);
>> +
>> +        /* Get pointer to guest data to get/set */
>> +        if (type->location && type->copy) {
>> +            ptr = type->location(guest, vcpuid);
>> +            assert(ptr);
>> +            if (!~(type->mask) && is_gsr_invalid(gsr, element, type)) {
>> +                return H_INVALID_ELEMENT_VALUE;
>> +            }
>> +            type->copy(ptr + type->offset, element->value,
>> +                       gsr->flags & GUEST_STATE_REQUEST_SET ? true : false);
>> +        }
>> +
>> +next_element:
>> +        element = guest_state_element_next(element, &lenleft, &num_elements);
>> +    }
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +static target_ulong map_and_getset_state(PowerPCCPU *cpu,
>> +                                         SpaprMachineStateNestedGuest *guest,
>> +                                         uint64_t vcpuid,
>> +                                         struct guest_state_request *gsr)
>> +{
>> +    target_ulong rc;
>> +    int64_t len;
>> +    bool is_write;
>> +
>> +    len = gsr->len;
>> +    /* only get_state would require write access to the provided buffer */
>> +    is_write = (gsr->flags & GUEST_STATE_REQUEST_SET) ? false : true;
>> +    gsr->gsb = address_space_map(CPU(cpu)->as, gsr->buf, (uint64_t *)&len,
>> +                                 is_write, MEMTXATTRS_UNSPECIFIED);
>> +    if (!gsr->gsb) {
>> +        rc = H_P3;
>> +        goto out1;
>> +    }
>> +
>> +    if (len != gsr->len) {
>> +        rc = H_P3;
>> +        goto out1;
>> +    }
>> +
>> +    rc = getset_state(guest, vcpuid, gsr);
>> +
>> +out1:
>> +    address_space_unmap(CPU(cpu)->as, gsr->gsb, len, is_write, len);
>> +    return rc;
>> +}
>> +
>> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
>> +                                         SpaprMachineState *spapr,
>> +                                         target_ulong *args,
>> +                                         bool set)
>> +{
>> +    target_ulong flags = args[0];
>> +    target_ulong lpid = args[1];
>> +    target_ulong vcpuid = args[2];
>> +    target_ulong buf = args[3];
>> +    target_ulong buflen = args[4];
>> +    struct guest_state_request gsr;
>> +    SpaprMachineStateNestedGuest *guest;
>> +
>> +    guest = spapr_get_nested_guest(spapr, lpid);
>> +    if (!guest) {
>> +        return H_P2;
>> +    }
>> +    gsr.buf = buf;
>> +    assert(buflen <= GSB_MAX_BUF_SIZE);
>> +    gsr.len = buflen;
>> +    gsr.flags = 0;
>> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>> +        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
>> +    }
>> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>> +        return H_PARAMETER; /* flag not supported yet */
>> +    }
>> +
>> +    if (set) {
>> +        gsr.flags |= GUEST_STATE_REQUEST_SET;
>> +    }
>> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
>> +}
>> +
>> +static target_ulong h_guest_set_state(PowerPCCPU *cpu,
>> +                                      SpaprMachineState *spapr,
>> +                                      target_ulong opcode,
>> +                                      target_ulong *args)
>> +{
>> +    return h_guest_getset_state(cpu, spapr, args, true);
>> +}
>> +
>> +static target_ulong h_guest_get_state(PowerPCCPU *cpu,
>> +                                      SpaprMachineState *spapr,
>> +                                      target_ulong opcode,
>> +                                      target_ulong *args)
>> +{
>> +    return h_guest_getset_state(cpu, spapr, args, false);
>> +}
>> +
>>   void spapr_register_nested_hv(void)
>>   {
>>       spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
>> @@ -1267,6 +1532,8 @@ void spapr_register_nested_papr(void)
>>       spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
>>       spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
>>       spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
>> +    spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
>> +    spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
> 
> Are these also supposed to to add unregister calls?

Yes, all unregistrations shall be added with registrations in v5.

regards,
Harsh

> 
> Thanks,
> Nick
> 

