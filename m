Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB25C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7JK-0001mX-0M; Tue, 07 Jul 2026 11:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wh7J0-0001iv-CZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:01:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wh7Iy-00053x-RV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:01:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667CIM8e2898153; Tue, 7 Jul 2026 15:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tP8FpW
 X7vACUhwRoOrdlVRGMZ8kvp3PdfiM5DpjV3Jg=; b=gQczm87AJCRg0O/zk4JzBF
 pYU0HwThBu03W0ExuuRj24Ebf/wjHthNwC2YbPgo899abxvUoHOEAL68Tn/EnmvW
 DMtqvhApZ7fmIYJ5yqqDXjjDKTHzRlAJWabCSiNvNVAqifCApbh2o6OBIupimPd0
 0dRdsEbrjTMPHo+QQ0hwb5u0q+Qdd/NfVLg8oxi8CEk8uKWc9+aGdz4Jd5YQ60yB
 5MzYuoIdjx5PNesahrOG6kpqc90BpAalYTSJETKWxO/CAARajjQ48jmmmJbcFzbK
 5IGBKOO5sn43Iyh7xfVxYwhz/WftQutmHxRCPV60/nbXjDGmB4m8L5es8dx9tH1A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdrc16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 15:01:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667EndHe001286;
 Tue, 7 Jul 2026 15:01:36 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq3h7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 15:01:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667F1af63146408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 15:01:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03D555805D;
 Tue,  7 Jul 2026 15:01:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A85A58043;
 Tue,  7 Jul 2026 15:01:35 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 15:01:35 +0000 (GMT)
Message-ID: <28305b69-e56d-4d1e-b166-a3cfc845805d@linux.ibm.com>
Date: Tue, 7 Jul 2026 11:01:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/tpm: gate PPI support on tpm-tis-device behind
 a device property
To: Mohammadfaiz Bawa <mbawa@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20260619093140.832136-1-mbawa@redhat.com>
 <20260619093140.832136-3-mbawa@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260619093140.832136-3-mbawa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0NSBTYWx0ZWRfX/gsoi7iNOTvX
 y5hGIvwrJH5yfQjz2jwd7U1yVYG9W5qsyVBkPHxrabJ1d6/ZZYTWeo1mv6EECVb42nDinrKgDUr
 nMrXKexaVqZG+TrChUd+1QDWJPubCCY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0NSBTYWx0ZWRfX0uh1aaVUTd6w
 KciMBOIGXfv9YS0sTf+q1+ZzGNiALrYs0aGm39q3y2P4d+qXMLb5SdIlAijtczMSXh6eRtX/67m
 U85JtR12d4qf+CrceOlGa7+f5re6jwfusBRRISWdbNujJtNYo5bCZQo594DX601g5F+W1MyhrAP
 I3ErvRNOYUNGVKdU4CLbVg15R1WYk1LhcJ5Luj2rO+CXb30/dxdHfDsGhJtjpN+ntk2PlwG97n5
 d2vC+yxGoPBn7nINU3cOcjLg9QP+wrXIU8vL1wts6OWWXkU1DnlHqB/SIaXHbTtPCjHvHKp4qbT
 aQw0QvxHxNpJBAurZRN8V8W3lqFafSIlmGX9kDEnCfDGaizC1KwbDKhHxU18C5qwvc83EEN7jcr
 4XY2tyNDByV9VmyawygN++01pst5YQ==
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4d14d1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=c6C4oUa-qvCB5CF-hhwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wlPt0etdlJwXajAlm1pgk3PtzOrXeHiT
X-Proofpoint-ORIG-GUID: wlPt0etdlJwXajAlm1pgk3PtzOrXeHiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
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



On 6/19/26 5:31 AM, Mohammadfaiz Bawa wrote:
> Add a "ppi" boolean property (default: true) to tpm-tis-device.
> When ppi=off the RAMBlock is never registered and the migration
> stream omits "tpm-ppi", restoring backward compatibility.
> 
> Move sysbus_init_mmio() calls from instance_init to realizefn so
> the memory regions are initialized before being registered.  When
> ppi=off, the PPI MMIO region is simply not exposed.
> 
> Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM64 virt")
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   hw/tpm/tpm_tis.h        |  1 +
>   hw/tpm/tpm_tis_sysbus.c | 18 +++++++++++-------
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index 1531620bf9..6ac9804050 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -76,6 +76,7 @@ typedef struct TPMState {
>       size_t be_buffer_size;
>   
>       TPMPPI ppi;
> +    bool ppi_enabled;
>   } TPMState;
>   
>   extern const VMStateDescription vmstate_locty;
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 16bb17874b..a7b0002d82 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -94,6 +94,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>   static const Property tpm_tis_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> +    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, true),
>   };
>   
>   static void tpm_tis_sysbus_initfn(Object *obj)
> @@ -101,9 +102,7 @@ static void tpm_tis_sysbus_initfn(Object *obj)
>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
>       TPMState *s = &sbdev->state;
>   
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>       sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
>   }
>   
>   static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
> @@ -122,14 +121,19 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    s->ppi.buf = qemu_memalign(host_page_size,
> -                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
>       memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
>                             s, "tpm-tis-mmio",
>                             TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
> -    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
> -                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
> -    vmstate_register_ram(&s->ppi.ram, dev);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> +
> +    if (s->ppi_enabled) {
> +        s->ppi.buf = qemu_memalign(host_page_size,
> +                                   ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
> +        memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
> +                                          TPM_PPI_ADDR_SIZE, s->ppi.buf);
> +        sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->ppi.ram);
> +        vmstate_register_ram(&s->ppi.ram, dev);
> +    }
>   }
>   
>   static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



