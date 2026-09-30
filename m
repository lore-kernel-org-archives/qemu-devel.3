Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87516CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBv35-0001mt-7p; Wed, 30 Sep 2026 10:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv2z-0001dH-2o; Wed, 30 Sep 2026 10:12:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1xBv2x-0002FV-5O; Wed, 30 Sep 2026 10:12:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5LIw3170659; Wed, 30 Sep 2026 14:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yuMB4N
 AJz3x3vEHe5Q2VBLrFXVWCuUKjHjVi7wQiny0=; b=cySHT4ecxfxST6qyLru/Me
 j48KOKK9CKwy5QMdkVjxjFamJRdXcLvFbyNUB2OeL0SIbaGRVY6srqRr03i+hgAZ
 wH68PctNvleFGcW6wPsi41rHa/2hUWuTj2E8xAnldrGcwf7YkjcJybYdoH11rzeB
 7N5fikG9fnUB2e6pTbz2RWOJp0I9TfEdPhvTODMd0VNO8IeelAu+BLKi7d8Zv1OX
 TWEmm9Wq0H17jyu0ZqX980MIu905CrxlXRlEbgaulA1BDlfcfpsjObJ0oWZxgwYr
 EmR1BmiYFftosXz6biUf1UXOab/CrOcwBaBb1V6ULGah1NJ/h7hxkxd5JVQtus4w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5ddct-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:12:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38YA3541488; Wed, 30 Sep 2026 14:12:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpc589-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:12:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEC6p917171130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:12:07 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C56E358056;
 Wed, 30 Sep 2026 14:12:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4693B5803F;
 Wed, 30 Sep 2026 14:12:05 +0000 (GMT)
Received: from [9.40.186.87] (unknown [9.40.186.87])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:12:05 +0000 (GMT)
Message-ID: <b3b04f49-1826-4138-a72f-3c45fdea30d6@linux.ibm.com>
Date: Wed, 30 Sep 2026 09:12:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] pnv/phb5: Implement IODA PCT table
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-9-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-9-saif.abrar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX2SES20+qB1aq
 3MMBJGbUWH9tFXKquhhGl8r3gF2Cff3gGmoewDMEq1z5YnPE7ChZ2HlsEc7rsDl8xHW49slAnan
 cSVTnGbN8Q+ICeDFeyTQFZG3MYkPBRM=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd18b9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=rAZGm_byyrVIENPIFAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: 7b-SYHNOzGc-y9YdAyndupzbgbU9ktXR
X-Proofpoint-ORIG-GUID: 3cMId6xdz2M0aMgf41OS29y79vvHSKv3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NiBTYWx0ZWRfX7K+S/pvNaXhs
 0HEb7InaKbJ9rvPApdWPvrvBl7qFgESplCe42Z43kwnNhkVjiz8rf4YwKXo4IbUodHlGxUnSWgG
 f7ytAs3xQs3/I6flY4Y3Ae+RNP3kr/GrP/LFQyahruRhrtKSFCJRopl8eQJ85SsJHg/+nilBDNi
 p7yglz/1PRi1ucauq43Bpk7SBLmSMToQL4ydpkou1s76VY+sab0Geqxf4/Pi3PkgAexZOO9YwOA
 qjZo/kJ4VTKqNqmiSO5EklyBTif7+nDNDEfeoyOud7iZtLICHpPhlZvTrGjK4wrbQXOkYUMTc1z
 s8SzbovXD/dLut+ywK4NdmB1MuB157o12PuPrIoa91vae065rieTwffcA5X1SysOnmekTvN+2uM
 wzRF9bJLpdXEksBbPeGR/LsGcMt2Uru3S+XBHIcW0Tn1hQMZVzIzBar5TPLM2rPvdBfEkNUWyam
 n2ZEV2xhUPC0dolEHwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
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

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 8/31/26 7:30 AM, Saif Abrar wrote:
> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> 
> IODA PCT table is implemented
> without any functionality, being a debug table.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/pci-host/pnv_phb4.c              | 7 +++++++
>  include/hw/pci-host/pnv_phb4.h      | 2 ++
>  include/hw/pci-host/pnv_phb4_regs.h | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 56952a6200..5f84550a7c 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -264,6 +264,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
>          mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
>          mask -= 1;
>          break;
> +    case IODA3_TBL_PCT:
> +        tptr = phb->ioda_PCT;
> +        mask = phb->big_phb ? PNV_PHB4_MAX_PCT : (PNV_PHB4_MAX_PCT >> 1);
> +        mask -= 1;
> +        break;
>      case IODA3_TBL_RCAM:
>          mask = phb->big_phb ? 127 : 63;
>          break;
> @@ -362,6 +367,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
>      /* Handle side effects */
>      switch (table) {
>      case IODA3_TBL_LIST:
> +    case IODA3_TBL_PCT:
> +        /* No action for debug tables */
>          break;
>      case IODA3_TBL_MIST: {
>          /* Special mask for MIST partial write */
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 33e11a3fe8..8d5822f339 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
>  #define PNV_PHB4_MAX_LSIs          8
>  #define PNV_PHB4_MAX_INTs          4096
>  #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
> +#define PNV_PHB4_MAX_PCT           (128 * 2)
>  #define PNV_PHB4_MAX_MMIO_WINDOWS  32
>  #define PNV_PHB4_MIN_MMIO_WINDOWS  16
>  #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
> @@ -138,6 +139,7 @@ struct PnvPHB4 {
>      /* On-chip IODA tables */
>      uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
>      uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
> +    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
>      uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
>      uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
>      uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index 9ad6713d37..897c869d20 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -478,6 +478,7 @@
>  
>  #define IODA3_TBL_LIST          1
>  #define IODA3_TBL_MIST          2
> +#define IODA3_TBL_PCT           3
>  #define IODA3_TBL_RCAM          5
>  #define IODA3_TBL_MRT           6
>  #define IODA3_TBL_PESTA         7


