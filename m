Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891B9107BCD5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w16k2-0007p3-Cr; Fri, 13 Mar 2026 13:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w16jz-0007oX-TO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:56:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w16jv-0004K8-Qx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:56:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DFshcr1279244; Fri, 13 Mar 2026 17:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rPmFLc
 2+zATj6qZ4BbEWUTE1Kd5LUm0aFQhOI0NXIq0=; b=YRxdQe65HCONx49w/ENYo5
 ZNPfIi5flDlu7k9rXnuNik7McVboPT0ak5E/EZPTUIzBvAFh/XNLXOr/YV4dBOHJ
 k5iklPivoCO/1AsMP/lqEQlpOJWLrSzpOAGpg6ToEPTGFYGwbx7Qo0Tce6CIYm+B
 TcPWxiWpsUL8lVbhq02n6GtBRyfhiw8j0CIaLE4m5MxH6pOlFViuw/Yo4jz/PZ2X
 Fbita7eTxg4wjfuMGlL0gXOKxMfUJR1XiPP8Irvao/bsU3omKwmRRAbEfywkeCMg
 VTqmNtRUmfmvSw4fLj9RwVpF2KbIZRoLw1CYZLk+i4snX68Ltb5oyHP5fYzlnyYw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92h35g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 17:55:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DFUZAP006042;
 Fri, 13 Mar 2026 17:55:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qqbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 17:55:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DHtLd920841046
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 17:55:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09F415803F;
 Fri, 13 Mar 2026 17:55:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2D335804E;
 Fri, 13 Mar 2026 17:55:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 17:55:42 +0000 (GMT)
Message-ID: <13d34783-8255-44f9-8f49-005f18a60c2e@linux.ibm.com>
Date: Fri, 13 Mar 2026 13:55:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] hw/tpm: Implement TPM CRB chunking logic
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
 <20260312041650.181411-5-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260312041650.181411-5-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rIv2MM2SC4bZfSeVtEszbIj7eDT_safO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0MCBTYWx0ZWRfX6IjyeGKDBuSi
 gZygGpeecRmuPMvSLV1piBetiesHi4ajGBlyC+g7kO1AghItsAEgASY8NFVi+AbcJ8Q6ctJ4OjW
 zLQh2n/hXaz3tQAbP3uXKe6KbnpmkxQwwiIj27mk9Ybvf46VIGXM1s04MlfM0z2aPW09UnVm6Xk
 zXQc/qCTZ/mc/huEmY9QEMtsswgEP+n0NjG00zxnXHsAL5XOpUB2iO3QIL5erxHEloirAE4kO66
 IwZN4vDCI5SyLovDzcXlozZ7Wq+CKCqdJmKAEfPt+2yJrr/XB/rzzAF/r09yGv3y0aBNskWsq2R
 jJp96cOxtsmWs+Ubp78+UTOq9Wuyf4Nh5HFjVc+a+dzR6aNVPWLJiUHAv9oLw5/MYt9OtpTKCS4
 ejs+PJi2G8IFoDkeV6flU8lhINRxkgxqj7+9PKgWZ1Ke5bTnzBjiyRBEJtHpPcn4M1SWQew9hCa
 zhfR8rZYfK9cS7V6SDQ==
X-Proofpoint-GUID: rIv2MM2SC4bZfSeVtEszbIj7eDT_safO
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b44fa1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=xt6ew7UTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=cY52DLsLcFSHDffHsoUA:9 a=QEXdDO2ut3YA:10
 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/12/26 12:16 AM, Arun Menon wrote:
> - Add logic to populate internal TPM command request and response
>    buffers and to toggle the control registers after each operation.
> - The chunk size is limited to CRB_CTRL_CMD_SIZE which is
>    (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER). This comes out as 3968 bytes
>    (4096 - 128 or 0x1000 - 0x80), because 128 bytes are reserved for
>    control and status registers. In other words, only 3968 bytes are
>    available for the TPM data.
> - With this feature, guests can send commands larger than 3968 bytes.
> - Refer section 6.5.3.9 of [1] for implementation details.
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/tpm/tpm_crb.c | 138 +++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 122 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 5ea1a4a970..845f9c6c9f 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -17,6 +17,7 @@
>   #include "qemu/osdep.h"
>   
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "system/address-spaces.h"
>   #include "hw/core/qdev-properties.h"
> @@ -65,6 +66,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>   #define CRB_INTF_CAP_CRB_CHUNK 0b1
>   
>   #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> +#define TPM_HEADER_SIZE 10
>   
>   enum crb_loc_ctrl {
>       CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
> @@ -80,6 +82,8 @@ enum crb_ctrl_req {
>   
>   enum crb_start {
>       CRB_START_INVOKE = BIT(0),
> +    CRB_START_RESP_RETRY = BIT(1),
> +    CRB_START_NEXT_CHUNK = BIT(2),
>   };
>   
>   enum crb_cancel {
> @@ -122,6 +126,58 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
>       return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
>   }
>   
> +static bool tpm_crb_append_command_request(CRBState *s)

A short description of what is being appended from where would be helpful.

> +{
> +    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> +    uint32_t to_copy = 0;
> +    uint32_t total_request_size = 0;
> +
> +    /*
> +     * The initial call extracts the total TPM command size
> +     * from its header. For the subsequent calls, the data already
> +     * appended in the command_buffer is used to calculate the total
> +     * size, as its header stays the same.
> +     */
> +    if (s->command_buffer->len == 0) {
> +        total_request_size = tpm_cmd_get_size(mem);
> +        if (total_request_size < TPM_HEADER_SIZE) {
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS, tpmSts, 1);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +            tpm_crb_clear_internal_buffers(s);
> +            error_report("Command size '%d' less than TPM header size '%d'",
> +                         total_request_size, TPM_HEADER_SIZE);
> +            return false;
> +        }
> +    } else {
> +        total_request_size = tpm_cmd_get_size(s->command_buffer->data);
> +    }
> +    total_request_size = MIN(total_request_size, s->be_buffer_size);
> +
> +    if (total_request_size > s->command_buffer->len) {
> +        uint32_t remaining = total_request_size - s->command_buffer->len;
> +        to_copy = MIN(remaining, CRB_CTRL_CMD_SIZE);
> +        g_byte_array_append(s->command_buffer, (guint8 *)mem, to_copy);
> +    }
> +    return true;
> +}
> +
> +static void tpm_crb_fill_command_response(CRBState *s)


Also a short description for this function would be helpful.

> +{
> +    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> +    uint32_t remaining = s->response_buffer->len - s->response_offset;
> +    uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
> +
> +    memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
> +
> +    if (to_copy < CRB_CTRL_CMD_SIZE) {
> +        memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> +    }
> +
> +    s->response_offset += to_copy;
> +    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +}
> +
>   static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>                                  uint64_t val, unsigned size)
>   {
> @@ -152,20 +208,48 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>           }
>           break;
>       case A_CRB_CTRL_START:
> -        if (val == CRB_START_INVOKE &&
> -            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> -            tpm_crb_get_active_locty(s) == locty) {
> -            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> -
> -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
> -            s->cmd = (TPMBackendCmd) {
> -                .in = mem,
> -                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
> -                .out = mem,
> -                .out_len = s->be_buffer_size,
> -            };
> -
> -            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +        if (tpm_crb_get_active_locty(s) != locty) {
> +            break;
> +        }
> +        if (val & CRB_START_INVOKE) {
> +            if (!(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
> +                if (!tpm_crb_append_command_request(s)) {
> +                    break;
> +                }
> +                ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
> +                g_byte_array_set_size(s->response_buffer, s->be_buffer_size);
> +                s->cmd = (TPMBackendCmd) {
> +                    .in = s->command_buffer->data,
> +                    .in_len = s->command_buffer->len,
> +                    .out = s->response_buffer->data,
> +                    .out_len = s->response_buffer->len,
> +                };
> +                tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +            }
> +        } else if (val & CRB_START_NEXT_CHUNK) {
> +            /*
> +             * nextChunk is used both while sending and receiving data.
> +             * To distinguish between the two, response_buffer is checked
> +             * If it does not have data, then that means we have not yet
> +             * sent the command to the tpm backend, and therefore call
> +             * tpm_crb_append_command_request()
> +             */
> +            if (s->response_buffer->len > 0 &&
> +                s->response_offset < s->response_buffer->len) {
> +                    tpm_crb_fill_command_response(s);
> +            } else {
> +                if (!tpm_crb_append_command_request(s)) {
> +                    break;
> +                }
> +            }
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +        } else if (val & CRB_START_RESP_RETRY) {
> +            if (s->response_buffer->len > 0) {
> +                s->response_offset = 0;
> +                tpm_crb_fill_command_response(s);
> +            }
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
>           }
>           break;
>       case A_CRB_LOC_CTRL:
> @@ -205,13 +289,36 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
>   static void tpm_crb_request_completed(TPMIf *ti, int ret)
>   {
>       CRBState *s = CRB(ti);
> +    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
>   
>       ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
>       if (ret != 0) {
>           ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
>                            tpmSts, 1); /* fatal error */
> +        tpm_crb_clear_internal_buffers(s);
> +    } else {
> +        uint32_t actual_resp_size = tpm_cmd_get_size(s->response_buffer->data);
> +        uint32_t total_resp_size = MIN(actual_resp_size, s->be_buffer_size);
> +        g_byte_array_set_size(s->response_buffer, total_resp_size);
> +        s->response_offset = 0;
> +
> +        /*
> +         * Send the first chunk. Subsequent chunks will be sent using
> +         * tpm_crb_fill_command_response()
> +         */
> +        uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, s->response_buffer->len);
> +        memcpy(mem, s->response_buffer->data, to_copy);
 > +> +        if (to_copy < CRB_CTRL_CMD_SIZE) {
> +            memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> +        }
> +        s->response_offset += to_copy;
>       }
>       memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
> +    g_byte_array_set_size(s->command_buffer, 0);
>   }
>   
>   static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
> @@ -288,8 +395,7 @@ static void tpm_crb_reset(void *dev)
>       s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
>       s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
>   
> -    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
> -                            CRB_CTRL_CMD_SIZE);
> +    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
>   
>       if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
>           exit(1);

With the two short description added:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


