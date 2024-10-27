Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B567D13577
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 17:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t57I8-0007k0-33; Sun, 27 Oct 2024 13:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t57I4-0007js-0k; Sun, 27 Oct 2024 13:43:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t57I2-0004Xo-Ar; Sun, 27 Oct 2024 13:42:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R6obgc020826;
 Sun, 27 Oct 2024 17:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=o13gzE
 hjtVOELqeezEGE+a32RYRaIwtD/Ef6bPnFUNk=; b=F472sPSGvYtnVPYjNMKHhb
 AzXSpli8QaZtk8o+cGuqj+MQJd6M2Wtvu8YUJNnhbbCKVXS4cj3HLb7mnbIyRuqe
 Tp2ZccfKe9eGbigvgeY6GWWaeagTkrt4EJHRP8kRpgJlH4RfQot4keoPspvk+XDC
 uW0uznMmCT+wYMR4+jUVehEyRzgALPwbnjfmb/cpXgDX7aiB+4de5pMfv4WTfmTR
 mPECH/5Ve+zT4b107XV12/EOahXHHYUPMXKuPFC7e9Y4Qv5lT59HELaFeObxZQi+
 TR7o6h9cJu3MWcayg3jDb9b8O0+aCtJodnJXzTze2WmrZVnIsBBvvqVIc0+V87NA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grwawd8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Oct 2024 17:42:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49RGVbbT028327;
 Sun, 27 Oct 2024 17:42:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4xjucy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 27 Oct 2024 17:42:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49RHgjco18219564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Oct 2024 17:42:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2797258052;
 Sun, 27 Oct 2024 17:42:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9A7F58056;
 Sun, 27 Oct 2024 17:42:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 27 Oct 2024 17:42:44 +0000 (GMT)
Message-ID: <33618d67-861c-41aa-99d3-c610b59dc9e6@linux.ibm.com>
Date: Sun, 27 Oct 2024 13:42:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/qtest/tpm: add unit test to tis-spi
To: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 stefanb@linux.vnet.ibm.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com, clg@kaod.org
Cc: qemu-ppc@nongnu.org
References: <20241025201247.29574-1-dantan@linux.vnet.ibm.com>
 <20241025201247.29574-4-dantan@linux.vnet.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241025201247.29574-4-dantan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kgQr0_SBerOuC6LTvAeIFlcSW_a1F7xC
X-Proofpoint-ORIG-GUID: kgQr0_SBerOuC6LTvAeIFlcSW_a1F7xC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410270155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/25/24 4:12 PM, dan tan wrote:
> Add qtest cases to exercise main TPM locality functionality
> The TPM device emulation is provided by swtpm, which is TCG
> TPM 2.0, and TCG TPM TIS compliant. See
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> The SPI registers are specific to the PowerNV platform
> architecture
> 
> Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
> ---
;
> +
> +static inline void tpm_reg_writeb(const PnvChip *c,
> +                                  int locl,
> +                                  uint8_t reg,
> +                                  uint8_t val)
> +{
> +    uint32_t tpm_reg_locl = SPI_TPM_TIS_ADDR | (locl << TPM_TIS_LOCALITY_SHIFT);
> +
> +    spi_access_start(c, false, 1, TPM_WRITE_OP, tpm_reg_locl | reg);
> +    spi_write_reg(c, bswap64(val));

spi_write_reg(c, (uint64_t)val << 56);

A #define for the 56 would be good.


> +
> +static void spi_access_start(const PnvChip *chip,
> +                             bool n2,
> +                             uint8_t bytes,
> +                             uint8_t tpm_op,
> +                             uint32_t tpm_reg)
> +{
> +    uint64_t cfg_reg;
> +    uint64_t reg_op;
> +    uint64_t seq_op = SEQ_OP_REG_BASIC;
> +
> +    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
> +    if (cfg_reg != CFG_COUNT_COMPARE_1) {
> +        pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, CFG_COUNT_COMPARE_1);
> +    }
> +    /* bytes - sequencer operation register bits 24:31 */
> +    if (n2) {
> +        seq_op |= SPI_SHIFT_COUNTER_N2 | (bytes << 0x18);
> +    } else {
> +        seq_op |= SPI_SHIFT_COUNTER_N1 | (bytes << 0x18);
> +    }
> +    pnv_spi_tpm_write(chip, SPI_SEQ_OP_REG, seq_op);
> +    pnv_spi_tpm_write(chip, SPI_MM_REG, MM_REG_RDR_MATCH);
> +    pnv_spi_tpm_write(chip, SPI_CTR_CFG_REG, (uint64_t)0);
> +    reg_op = bswap64(tpm_op) | ((uint64_t)tpm_reg << 0x20);


Same #define to use here, maybe called SPI_XMIT_DATA_OP_SHIFT. And one 
for the 0x20, maybe called SPI_XMIT_DATA_ADDR_SHIFT. Any reference to a 
spec?

(uint64_t)tmp_op << SPI_XMIT_DATA_OP_SHIFT | (uint64_t)(tpm_reg & 
0xffffff) << SPI_XMIT_DATA_ADDR_SHIFT;


> +    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, reg_op);
> +}
> +

