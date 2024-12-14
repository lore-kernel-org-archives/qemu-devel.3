Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5BEE7717F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 00:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMFjB-000795-LN; Fri, 13 Dec 2024 19:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tMFj9-00078W-Hw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 19:09:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tMFj7-00061Z-GA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 19:09:47 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDNwLZv032739;
 Sat, 14 Dec 2024 00:09:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=v7Vhh6
 sW5VxPBRWIJJJLrf9CMCK1v9svUNJsqkCRHs4=; b=YDT2oKJTyZZ+Wp610zHgL+
 BKHPehDJx20N8QTby4DjQtCb9wx9SfIjE+Q1QG7jSLTLFre9NKmmNOd0mfDNy21K
 Cn6iUHxWs7CKuuGEJmIIbtuyB0MuwkqStdgMv+gNIQ9307OH8M5ZWiYvDZeMrH3A
 O0UXKtgWLt/gdUy5hzlGbZciu1DEYK0hwHOVLmHlfK6Pb+E9vD7e6cWum/K0/kD4
 3dJWzuDegPONKFwa5gmr+0y/tTA7/14pjBdkk31h39Gmzu6eSsNHOI2n54PjEh8/
 L0xHe/xMDcF/N2XhUQy086RZhIu6OdTvuOmm4pZGsgYlboUyB0WRCWqDp08EpUtg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gy2h010w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Dec 2024 00:09:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDNssjQ032739;
 Sat, 14 Dec 2024 00:09:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pt0k2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 14 Dec 2024 00:09:41 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BE09eXc39125622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 14 Dec 2024 00:09:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1FAA58052;
 Sat, 14 Dec 2024 00:09:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6462A5805D;
 Sat, 14 Dec 2024 00:09:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 14 Dec 2024 00:09:40 +0000 (GMT)
Message-ID: <7a655f83-8a29-4edc-a8d8-a700fcda378a@linux.ibm.com>
Date: Fri, 13 Dec 2024 19:09:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 61/71] hw/tpm: Constify all Property
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-66-richard.henderson@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241213190750.2513964-66-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3lqGb2z4bdY_yHMDXArfrpyKxSIH0CmH
X-Proofpoint-GUID: 3lqGb2z4bdY_yHMDXArfrpyKxSIH0CmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130171
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 12/13/24 2:07 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   hw/tpm/tpm_crb.c        | 2 +-
>   hw/tpm/tpm_spapr.c      | 2 +-
>   hw/tpm/tpm_tis_i2c.c    | 2 +-
>   hw/tpm/tpm_tis_isa.c    | 2 +-
>   hw/tpm/tpm_tis_sysbus.c | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 5cd5a2533b..2bf6e7ffe9 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -226,7 +226,7 @@ static const VMStateDescription vmstate_tpm_crb = {
>       }
>   };
> 
> -static Property tpm_crb_properties[] = {
> +static const Property tpm_crb_properties[] = {
>       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>       DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> index 5f7a0dfc61..e15b67dd45 100644
> --- a/hw/tpm/tpm_spapr.c
> +++ b/hw/tpm/tpm_spapr.c
> @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_spapr_vtpm = {
>       }
>   };
> 
> -static Property tpm_spapr_properties[] = {
> +static const Property tpm_spapr_properties[] = {
>       DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
>       DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
> index c5548b0a45..b27af230cd 100644
> --- a/hw/tpm/tpm_tis_i2c.c
> +++ b/hw/tpm/tpm_tis_i2c.c
> @@ -491,7 +491,7 @@ static int tpm_tis_i2c_send(I2CSlave *i2c, uint8_t data)
>       return 1;
>   }
> 
> -static Property tpm_tis_i2c_properties[] = {
> +static const Property tpm_tis_i2c_properties[] = {
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateI2C, state.be_driver),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 21109edcaa..9b2160972a 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -91,7 +91,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
>       return tpm_tis_reset(s);
>   }
> 
> -static Property tpm_tis_isa_properties[] = {
> +static const Property tpm_tis_isa_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
>       DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 967f264634..88c1f1e478 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -90,7 +90,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>       return tpm_tis_reset(s);
>   }
> 
> -static Property tpm_tis_sysbus_properties[] = {
> +static const Property tpm_tis_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
>       DEFINE_PROP_END_OF_LIST(),


