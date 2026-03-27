Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6563310F2840
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69Bu-0007pO-6H; Fri, 27 Mar 2026 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w69Bs-0007oh-Kp; Fri, 27 Mar 2026 11:33:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w69Bq-0008R2-Nr; Fri, 27 Mar 2026 11:33:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RF0ISr3850414; Fri, 27 Mar 2026 15:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/YZ0Ly
 4c4KrV1x9rNR9OAW3uMj5iYre+VmmbyihamrA=; b=PcJ2fkq8ES8Ix/Ra+fj7nI
 Dd8HUdl2jnZCZGNcB9IYWv5wRihUSNrFUGSHCBljy1XMJPGn47okGQnkMrb6uMaY
 QPopf6y3N3BXuGYfTPFy0lkdmBQ6jmJ0G7JskOMMrxlYAPrvKTpRTlTZbq7dwA6Q
 jgzdIZYibOIiaIa/+dsELjcZIAORcwXOlhlKK9lBY5C8Gbrjx1CTE7/mUmgBU1BZ
 5dUr/30dWyzWrHC22cBK45JnzC98TrdP1KAwFYcEJ56E+AALmqS9NoFHqfdnkhfC
 Xc1F/7/5HvZOUmNu+RRz1qKzPdJV70s/kZjqqwqv09P8t/trdFQpBi7CI5pPDPXw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqtx9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:33:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62REs4qB031583;
 Fri, 27 Mar 2026 15:33:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nt860q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:33:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RFXUnt28770966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 15:33:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B09A5805E;
 Fri, 27 Mar 2026 15:33:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 689FE58052;
 Fri, 27 Mar 2026 15:33:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 15:33:29 +0000 (GMT)
Message-ID: <59933dce-f3b9-4eee-b694-15bb894c3f26@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:33:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/acpi/tpm: parameterize PPI base address in
 tpm_build_ppi_acpi
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, mohamed@unpredictable.fr
References: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
 <20260327-tpm-tis-sysbus-ppi-v2-2-d8ec84d25dbc@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260327-tpm-tis-sysbus-ppi-v2-2-d8ec84d25dbc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: QsCJO1kGmO2tfiGhPqaOM_JQUwUq2-vh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX4Xi6DJdYbM7g
 bi/fbt96fxRkOZawgoec9RgV4jmXBE+cxv3s/7Mtc6dlMRPpM1/VhfkW99q/MhJStfitXayCjsb
 QEegeeooOe5jvNkgVH0KeR+k0bBMaK7YWzMux1erR68qOAgRjpEVBjbTMyB+3uFixM2HKHqd6Qx
 hXx/4XUQISFPq9JLdtCnBiisJax66Tp7mLyS9CqA90MkO/4Kjmuu7HjyX1WUXWob2NmYDAjXK/V
 qtIhky9W5Iyz/5QBcAwJQoPQTj2VsrIyQhLvlO46hv3DoLc4UKXpWp+WNHQVe+mUwaiCyoowPXE
 GJHgz7owMj3YHXTKWEFjqni3cboIXR72fk3CLCFCdjxFrz6ZE7ghV2cCOPVilxX1RXxq+/tTeoQ
 xDgSmzJ+slILU+SltlceCBKtj/ae/0L6vxkXwoLfw7AFHYCBpVXs2YD3luRqTuh9GBFfmsatzdt
 EFBToI3P+PZMNl0c9iQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c6a34c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=ODhlqupQsFDcI_HUKJIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: R_sjn1WpLxJ8U7pn7RAWlhnIzlB2_5tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 3/27/26 7:48 AM, Mohammadfaiz Bawa wrote:
> Add a ppi_base parameter to tpm_build_ppi_acpi() instead of
> hardcoding TPM_PPI_ADDR_BASE. This prepares for ARM64 support where
> PPI memory is dynamically allocated by the platform bus and the
> address is not known at compile time.
> 
> Update the x86 ISA TIS caller to pass TPM_PPI_ADDR_BASE explicitly.
> No behavioral change.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>

You need to adapt this call as well.

../hw/i386/acpi-build.c: In function ‘build_dsdt’:
../hw/i386/acpi-build.c:1222:9: error: too few arguments to function 
‘tpm_build_ppi_acpi’; expected 3, have 2
  1222 |         tpm_build_ppi_acpi(tpm, dev);
       |         ^~~~~~~~~~~~~~~~~~
In file included from ../hw/i386/acpi-build.c:45:
/home/stefanb/dev/qemu-tpm/include/hw/acpi/tpm.h:254:6: note: declared here
   254 | void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base);
       |      ^~~~~~~~~~~~~~~~~~



> ---
>   hw/acpi/tpm.c         | 8 ++++----
>   hw/tpm/tpm_tis_isa.c  | 2 +-
>   include/hw/acpi/tpm.h | 3 ++-
>   3 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
> index cdc022753659af102e56ea4148423b94de1531f6..c4ff2f8cb836c16b00f70865bf55781d5c402aa2 100644
> --- a/hw/acpi/tpm.c
> +++ b/hw/acpi/tpm.c
> @@ -20,7 +20,7 @@
>   #include "qapi/error.h"
>   #include "hw/acpi/tpm.h"
>   
> -void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
> +void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base)
>   {
>       Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
>           *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
> @@ -40,7 +40,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>        */
>       aml_append(dev,
>                  aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
> -                                    aml_int(TPM_PPI_ADDR_BASE + 0x100),
> +                                    aml_int(ppi_base + 0x100),
>                                       0x5A));
>       field = aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
>       aml_append(field, aml_named_field("PPIN", 8));
> @@ -56,7 +56,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>       aml_append(dev,
>                  aml_operation_region(
>                      "TPP3", AML_SYSTEM_MEMORY,
> -                   aml_int(TPM_PPI_ADDR_BASE +
> +                   aml_int(ppi_base +
>                              0x15a /* movv, docs/specs/tpm.rst */),
>                              0x1));
>       field = aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
> @@ -78,7 +78,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
>   
>           aml_append(method,
>               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
> -                aml_add(aml_int(TPM_PPI_ADDR_BASE), op, NULL), 0x1));
> +                aml_add(aml_int(ppi_base), op, NULL), 0x1));
>           field = aml_field("TPP1", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
>           aml_append(field, aml_named_field("TPPF", 8));
>           aml_append(method, field);
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 61e95434f5b824fa99f0a2aff7f151e87ea631ed..e30bef49558673f4c857c02dae059ce3361a1bc7 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -162,7 +162,7 @@ static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
>        */
>       /* aml_append(crs, aml_irq_no_flags(isadev->state.irq_num)); */
>       aml_append(dev, aml_name_decl("_CRS", crs));
> -    tpm_build_ppi_acpi(ti, dev);
> +    tpm_build_ppi_acpi(ti, dev, TPM_PPI_ADDR_BASE);
>       aml_append(scope, dev);
>   }
>   
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d2bf6637c5424b92ad99f5baa938fd6cea3520bf..2ab186a7455593df205a7ffecbea2abdfdbd11d5 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -20,6 +20,7 @@
>   #include "hw/core/registerfields.h"
>   #include "hw/acpi/aml-build.h"
>   #include "system/tpm.h"
> +#include "exec/hwaddr.h"
>   
>   #ifdef CONFIG_TPM
>   
> @@ -250,7 +251,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>    */
>   #define TPM_I2C_INT_ENABLE_MASK   0x0
>   
> -void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev);
> +void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base);
>   
>   #endif /* CONFIG_TPM */
>   
> 


