Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A901F9EDC4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX7g-0006TV-Fe; Wed, 22 Apr 2026 08:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wFX7e-0006Nf-Rm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:56:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wFX7Y-0006wP-M4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:56:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M1uh5O1820599; Wed, 22 Apr 2026 12:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HbTRHM
 FRf0mTNT6qJQarBXFh8cez21T5c5lTnNl8Yuk=; b=CxVdXu8TJuVTQnOeuY1kr4
 qp/IkNBPXWQmacn9fMsT52IWsApCGnFCqQJ7AhP7s3ZNBVdnavSNpOEWDoegPk4w
 dvjdbfswcoKKN97h/2TxyV1a7FHQfqfHkUHJQ4Tpoch667fza9BSTuKrMHMJqQSn
 T0+I5pt9AqdVU24mMnU8tEHRD59Ai/2enDVOzVgllDSLpcM02eYCsjwLEZuEFVcn
 nYzrP38SBLy05I5WGZ2klZisAv2AO/5D43aFvQ82jCjh3iQ9YRETePh49MAr29Rf
 xlIMM2egy3z1B0fbM1cSDR9jJnH9Fr6E/9gfBa1Khpf2pJmG+2KyOOBRAa8zF/hw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3k8tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 12:55:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MCoGmg006139;
 Wed, 22 Apr 2026 12:55:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky297a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Apr 2026 12:55:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63MCto9941419424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Apr 2026 12:55:50 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 846955806A;
 Wed, 22 Apr 2026 12:55:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6A1A58052;
 Wed, 22 Apr 2026 12:55:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Apr 2026 12:55:49 +0000 (GMT)
Message-ID: <b0805c65-28b0-4b65-b87a-829ae0b3d605@linux.ibm.com>
Date: Wed, 22 Apr 2026 08:55:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] hw/tpm: Add internal buffer state for chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-4-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260422103018.123608-4-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: p7fvOH5KUFGfITfiltcJ1rTtnf7VK8Rh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyMyBTYWx0ZWRfX/sxH0xPJ17MG
 wgSt1dnJSSTc/ZskAuUPuSj2eIa+aaP1/3gHaHK7hXXUv+7WBe9eIgthUexk6YpHR6shfRmWEPP
 lzLu5EKQF6tNeFYoTNDcS8zL6VJz7urpMU8RCQemEWneDgkFMu2RlsWkZUm1Tu6y1GlNcfMS5yL
 W40bCdWRmaSNnYRc6wnvTkxlRC4pDDgJ6BybCjznr7slNiPgAXLThVIOmdJgKuffEDnkr1FQkAl
 +/1vSzLT/jlTuErVLHDIN1DmxQA9DjGTtvBMq6g5GS9Cex5SE3vancPm7e8ywdVXRxJZHZny4s1
 Ubb7K89io3BzbNlNmFqEpC82KHu00UpLEdh1MrEKOBH/D6LXVkvTjnaRqbLDBQnGxmiOUcqXHd0
 vaNK2KTGjfSr+8iO7J8xMwGFwXDIsW0SRl0osT1Hj2yDNPSyoOjhSvstX2FkZyfmGBR9DMha1Wb
 CLiA1X3TKbhIKNXkEvQ==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e8c558 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=xChQcTWAEkxHroGfpTYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nd9HcfGslOr-6Xbdr9GgwIyQNGlfGF0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/22/26 6:30 AM, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> - Introduce GByteArray buffers to hold the command request and response
>    data during chunked TPM CRB transactions.
> - Add helper function to clean them.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/tpm/tpm_crb.c | 33 +++++++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 7edfbf8f8a..e7ec9d0679 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -38,10 +38,13 @@ struct CRBState {
>       TPMBackend *tpmbe;
>       TPMBackendCmd cmd;
>       uint32_t regs[TPM_CRB_R_MAX];
> +    size_t be_buffer_size;
>       MemoryRegion mmio;
>       MemoryRegion cmdmem;
>   
> -    size_t be_buffer_size;
> +    GByteArray *command_buffer;
> +    GByteArray *response_buffer;
> +    uint32_t response_offset;
>   
>       bool ppi_enabled;
>       TPMPPI ppi;
> @@ -87,6 +90,13 @@ enum crb_cancel {
>   
>   #define TPM_CRB_NO_LOCALITY 0xff
>   
> +static void tpm_crb_clear_internal_buffers(CRBState *s)
> +{
> +    g_byte_array_set_size(s->response_buffer, 0);
> +    g_byte_array_set_size(s->command_buffer, 0);
> +    s->response_offset = 0;
> +}
> +
>   static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>                                     unsigned size)
>   {
> @@ -136,9 +146,11 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>           }
>           break;
>       case A_CRB_CTRL_CANCEL:
> -        if (val == CRB_CANCEL_INVOKE &&
> -            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> -            tpm_backend_cancel_cmd(s->tpmbe);
> +        if (val == CRB_CANCEL_INVOKE) {
> +            if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> +                tpm_backend_cancel_cmd(s->tpmbe);
> +            }
> +            tpm_crb_clear_internal_buffers(s);
>           }
>           break;
>       case A_CRB_CTRL_START:
> @@ -243,6 +255,7 @@ static void tpm_crb_reset(void *dev)
>           tpm_ppi_reset(&s->ppi);
>       }
>       tpm_backend_reset(s->tpmbe);
> +    tpm_crb_clear_internal_buffers(s);
>   
>       memset(s->regs, 0, sizeof(s->regs));
>   
> @@ -309,6 +322,9 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(get_system_memory(),
>           TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
>   
> +    s->command_buffer = g_byte_array_new();
> +    s->response_buffer = g_byte_array_new();
> +
>       if (s->ppi_enabled) {
>           tpm_ppi_init(&s->ppi, get_system_memory(),
>                        TPM_PPI_ADDR_BASE, OBJECT(s));
> @@ -321,12 +337,21 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>       }
>   }
>   
> +static void tpm_crb_unrealize(DeviceState *dev)
> +{
> +    CRBState *s = CRB(dev);
> +
> +    g_clear_pointer(&s->command_buffer, g_byte_array_unref);
> +    g_clear_pointer(&s->response_buffer, g_byte_array_unref);
> +}
> +
>   static void tpm_crb_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
>   
>       dc->realize = tpm_crb_realize;
> +    dc->unrealize = tpm_crb_unrealize;
>       device_class_set_props(dc, tpm_crb_properties);
>       dc->vmsd  = &vmstate_tpm_crb;
>       dc->user_creatable = true;

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


