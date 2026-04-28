Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F360AFF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHi0S-0004s2-Ni; Tue, 28 Apr 2026 08:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHi0Q-0004ru-Gy
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 08:57:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHi0O-0006lt-AI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 08:57:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S6ulRU2943552; Tue, 28 Apr 2026 12:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=l3mQZj
 XC4YJigCUt2rxyN+JGJYonLurAvhVLeoJbD8Y=; b=CT4dXg2XebtfydV8D9C+v6
 E2uffpXdbjCl3n25YmCM8ydxQ/GPMlVoxgpW6l9oFovMXbpeOuuNW5SpIzCGvDvF
 Q85zJPdmvj6jMDXCaEegv0X+fiafowHZMS1YlYTBuunGN6sUVquF5qOXZR86ziJl
 Zm7d8t0aXqe9rUeIoQijoFntWE9qo9qhphFduHsgubFGnb7XEmbVjK+Ze9o0ywpk
 qbZpYYC4HwQkUu2TpWqQNcGkxYJbiFClN7whKX+20JXsxilHyQewz+1AVnKehE3M
 GoMU5hfaXxABQIdK00NbggAzdyWw2WCt8AXaSb6Ti1j8qmMmQ0FD9U+vpeRwoeDg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb55h0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 12:57:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCcoS0012901;
 Tue, 28 Apr 2026 12:57:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamy9g31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 12:57:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SCvWpB12124762
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 12:57:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4161858064;
 Tue, 28 Apr 2026 12:57:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCB465805F;
 Tue, 28 Apr 2026 12:57:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 12:57:31 +0000 (GMT)
Message-ID: <84607c2e-1da9-43d2-8a5b-e50e91c0f8ba@linux.ibm.com>
Date: Tue, 28 Apr 2026 08:57:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
To: armenon@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
 <afBbLDmdYFY5feJx@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afBbLDmdYFY5feJx@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0aebd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=Veu011aRk9TlpGnrHNoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX4TOUZ3zJUUrY
 O2Ymrbw4OuWQsARXNf4+4IIR+1nvIy6SDRJcePYatCLdoTXoqgGz0UyuME4LxI82hMViDaRR+TL
 vAiVDfmcl/8LTaBFnaGMaQNUjb1aDuBshy3wBWf149wylwFfbQD+qSyfyLej3IE2JdvJIRY4R0l
 LEJjLJvmZAN/3jic+Qxn9Mi3iJVKLA44dw7AXiMxHzcz2pPP2oJPgpcZcwFa8jJcu+JhNhzYAUG
 2OyKLvmEQXZBxBgqOag88fPSdAUVmn//gVSmWBCeyxSaQh8rfANINpzWCXV9AaIrTr5ZK9WsJqM
 Z816FFpQYaT+l8pchCPs/O7hvBQN+qTOP7CsbY+tGY0vnQnwoM84/I79ov13/2dd9PyjkZu9PgR
 mJBIBphJdK95kMVe5QLlDTbQS58ck+3expU6q4vGaOlpmZKKdNy7p5a+3uI/sI1m/P4Dwjul3f+
 hQGfvbbPAB7xRBjUIPw==
X-Proofpoint-GUID: mJAeKoQavfxzyWqSyUXnptNHVx9n_QSp
X-Proofpoint-ORIG-GUID: mJAeKoQavfxzyWqSyUXnptNHVx9n_QSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280118
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



On 4/28/26 3:01 AM, Arun Menon wrote:
> Hi Stefan,
> 
> Thank you for taking a look.
> 
> On Mon, Apr 27, 2026 at 04:49:04PM -0400, Stefan Berger wrote:
>>
>>
>> On 4/27/26 4:01 PM, Arun Menon wrote:
>>> From: Arun Menon <armenon@redhat.com>
>>>
>>> The TPM TIS buffer is currently a fixed-size static array. Change this
>>> to a dynamically allocated heap block. The buffer size is now determined
>>> at runtime by querying the TPM backend.
>>
>> Do we really need this? I mean for the forseeable future 8kb should be
>> sufficient.
> 
> You are right that 8kb should be sufficient.
> I implemented this to address the TODO mentioned here:
> https://github.com/qemu/qemu/commit/e5f62d87e3c03bda6006085cf6303736fb57f5c5
> 
> That is why this patch is  deliberately posted outside the v5 series.
> It is more about future-proofing than a strict requirement. I thought it
> was worth addressing while the context was fresh. I am happy to leave it
> out if we prefer that.

Actually, go ahead. It's better than hard coding the size.

> 
>>
>>>
>>> To support VM migration,
>>> 1. Replace the static VMSTATE_BUFFER macro with pointer-based variant
>>>      VMSTATE_BUFFER_POINTER_UNSAFE, explicitly mentioning the size.
>>> 2. Introduce ext_buffer and ext_size in the migration subsection to
>>>      track allocation exceeding TPM_TIS_BUFFER_MAX. Allocate ext_buffer
>>>      using VMSTATE_VBUFFER_ALLOC_UINT32 only to be freed later after it is
>>>      appended to the main buffer.
>>>
>>> This allows us to migrate to a destination host without breaking
>>> backward compatibility. Old QEMU does not include a size field along
>>> with the buffer in the migration stream, and therefore the
>>> new QEMU is also forced to keep expecting exactly 4096 bytes.
>>>
>>> Implement a post_load hook that will validate the incoming data size
>>> from the migration stream, failing the migration if it exceeds the
>>> destination backend capacity. Add unrealize functions for the TIS interface
>>> types ISA, SysBus and I2C to ensure that the buffer is safely freed on
>>> device destruction.
>>>
>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>> ---
>>> Dependencies:
>>> This patch depends on the following patch currently in the mailing list:
>>> https://lore.kernel.org/qemu-devel/20260422103018.123608-10-armenon@redhat.com/
>>
>> I had tried to apply your v5 series to master but could not. Do you have a
>> git repo where you keep your patches?
> 
> Yes. Here is the repo: https://gitlab.com/armenon/qemu-dev/-/tree/pqc_tpm?ref_type=heads
> I have applied the GByteArray change first, followed by the 10 commits.
> 
>>
>>>
>>> Depends-on: <20260422103018.123608-10-armenon@redhat.com>
>>>
>>>    hw/tpm/tpm_tis.h        |  6 ++++-
>>>    hw/tpm/tpm_tis_common.c | 56 +++++++++++++++++++++++++++++++++++------
>>>    hw/tpm/tpm_tis_i2c.c    | 28 +++++++++++++++++++--
>>>    hw/tpm/tpm_tis_isa.c    | 31 +++++++++++++++++++++--
>>>    hw/tpm/tpm_tis_sysbus.c | 32 +++++++++++++++++++++--
>>>    5 files changed, 138 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
>>> index b2d9c0116c..c736ecedc1 100644
>>> --- a/hw/tpm/tpm_tis.h
>>> +++ b/hw/tpm/tpm_tis.h
>>> @@ -56,7 +56,9 @@ typedef struct TPMLocality {
>>>    typedef struct TPMState {
>>>        MemoryRegion mmio;
>>> -    unsigned char buffer[TPM_TIS_BUFFER_MAX];
>>> +    uint8_t *buffer;
>>> +    uint8_t *ext_buffer;
>>> +    uint32_t ext_size;
>>>        uint16_t rw_offset;
>>>        uint8_t active_locty;
>>> @@ -82,6 +84,8 @@ extern const VMStateDescription vmstate_locty;
>>>    extern const MemoryRegionOps tpm_tis_memory_ops;
>>>    int tpm_tis_pre_save(TPMState *s);
>>> +int tpm_tis_post_load(TPMState *s);
>>> +int tpm_tis_ext_buffer_post_load(TPMState *s);
>>>    void tpm_tis_reset(TPMState *s, bool ppi_enabled);
>>>    enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
>>>    void tpm_tis_request_completed(TPMState *s, int ret);
>>> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
>>> index 43e68410f8..c9c4dd1190 100644
>>> --- a/hw/tpm/tpm_tis_common.c
>>> +++ b/hw/tpm/tpm_tis_common.c
>>> @@ -270,7 +270,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
>>>        uint16_t len;
>>>        if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
>>> -        len = MIN(tpm_cmd_get_size(&s->buffer),
>>> +        len = MIN(tpm_cmd_get_size(s->buffer),
>>>                      s->be_buffer_size);
>>>            ret = s->buffer[s->rw_offset++];
>>> @@ -317,7 +317,7 @@ static void tpm_tis_dump_state(TPMState *s, hwaddr addr)
>>>               "tpm_tis: result buffer : ",
>>>               s->rw_offset);
>>>        for (idx = 0;
>>> -         idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
>>> +         idx < MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
>>>             idx++) {
>>>            printf("%c%02x%s",
>>>                   s->rw_offset == idx ? '>' : ' ',
>>> @@ -383,7 +383,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
>>>            if (s->active_locty == locty) {
>>>                if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
>>>                    val = TPM_TIS_BURST_COUNT(
>>> -                       MIN(tpm_cmd_get_size(&s->buffer),
>>> +                       MIN(tpm_cmd_get_size(s->buffer),
>>>                               s->be_buffer_size)
>>>                           - s->rw_offset) | s->loc[locty].sts;
>>>                } else {
>>> @@ -754,7 +754,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
>>>                    /* we have a packet length - see if we have all of it */
>>>                    bool need_irq = !(s->loc[locty].sts & TPM_TIS_STS_VALID);
>>> -                len = tpm_cmd_get_size(&s->buffer);
>>> +                len = tpm_cmd_get_size(s->buffer);
>>>                    if (len > s->rw_offset) {
>>>                        tpm_tis_sts_set(&s->loc[locty],
>>>                                        TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
>>> @@ -818,9 +818,10 @@ void tpm_tis_reset(TPMState *s, bool ppi_enabled)
>>>        int c;
>>>        s->be_tpm_version = tpm_backend_get_tpm_version(s->be_driver);
>>> -    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
>>> -                            TPM_TIS_BUFFER_MAX);
>>> +    s->be_buffer_size = tpm_backend_get_buffer_size(s->be_driver);
>>> +    s->buffer = g_realloc(s->buffer, MAX(s->be_buffer_size,
>>> +                          TPM_TIS_BUFFER_MAX));
>>
>> With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the backend says
>> so -- hm...
> 
> TPM_TIS_BUFFER_MAX is still 4096.

Oh, I had still based my patches on your TPM_TIS_BUFFER_MAX increase to 
8192 bytes. Let me fixes this along with a few other things. I will let 
you know.

I have another series that I will post now that can be applied to 
master. It's adding a test for TIS over I2C but I will need to extend 
that one also with the large transfer test case then.



