Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80492D132DE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7z2n-00021B-F7; Mon, 04 Nov 2024 10:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1t7z2m-00020z-GP; Mon, 04 Nov 2024 10:31:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1t7z2k-00039T-Je; Mon, 04 Nov 2024 10:31:04 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4F9oSm006274;
 Mon, 4 Nov 2024 15:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2Qg/wc
 I9bWHL4w6MePdgVA+zjSoWxXyF7uBUkH69k0I=; b=kithfqB5t055b8IsNzBRSr
 91umtudRGxL7wU7jL9ZqWs1o5jJFxu01Px1VRD4JTwtxPNoukMovPSGS8cw7LETd
 rU2YGYAIZ2Nf307dFK5cL6nk/1Eoob6CaKK5IpekhXcU3g76sUjqwD+yt1LYZJ4I
 xBHJ+14Q+88EEEe4QMKKtNeLeqePswjXoz7JgW3cEPmZKwP9Nvy1D1cU3mB5DdUQ
 qQ9dGm7svDb5rZBKXYjz4axqcgaP47+yGoCDbFVkygYCnKbtbeBE7GJPlzBKKKG3
 Q7QGdAnoyDCRX24bmLA6zcKii2X1AYMFZgpmnYE3QdIf8QQGMXUAQyQxNr4KOwsQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42q0nvg3h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 15:30:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A498xL7032050;
 Mon, 4 Nov 2024 15:30:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmjb3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Nov 2024 15:30:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A4FUpFl22151886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Nov 2024 15:30:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4D6858053;
 Mon,  4 Nov 2024 15:30:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30E4158043;
 Mon,  4 Nov 2024 15:30:51 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Nov 2024 15:30:51 +0000 (GMT)
Date: Mon, 04 Nov 2024 09:30:50 -0600
From: dan tan <dantan@linux.ibm.com>
To: undisclosed-recipients:;
Subject: Re: [PATCH v5 3/3] tests/qtest/tpm: add unit test to tis-spi
In-Reply-To: <1eed1859-4639-4b24-ba6a-347a3b3534fc@linux.ibm.com>
References: <20241104064334.21468-1-dantan@linux.vnet.ibm.com>
 <20241104064334.21468-4-dantan@linux.vnet.ibm.com>
 <1eed1859-4639-4b24-ba6a-347a3b3534fc@linux.ibm.com>
Message-ID: <370ea461b2081b5f636dc59d82c5326a@linux.ibm.com>
X-Sender: dantan@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lPpAdBKdw0ncLP-Eg9hea0iC74E8hX0G
X-Proofpoint-GUID: lPpAdBKdw0ncLP-Eg9hea0iC74E8hX0G
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411040130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=dantan@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Stefan,

What's the best way to catch these in my own local testing without 
submitting it to Travis CI?

thank you,
---
dan tan
power simulation
phone:+1.7373.099.138
email:dantan@linux.ibm.com


On 2024-11-04 09:20, Stefan Berger wrote:
> On 11/4/24 1:43 AM, dan tan wrote:
>> Add qtest cases to exercise main TPM functionality
>> The TPM device emulation is provided by swtpm, which is TCG
>> TPM 2.0, and TCG TPM TIS compliant. See
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
>> The SPI registers are specific to the PowerNV platform
>> architecture
>> 
>> Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
>> ---
>> 
>> v3:
>> - removed the function prototypes declaration
>> - fixed code format to comply with convention
>> - changed function names and variable names to be the same
>>    as the tpm-tis-i2c test.
>> - change hard coded numbers to #define's with meaningful
>>    names that are identifiable with spec documentation
>> 
>> v4:
>> - git commit amend only
>> 
>> v5:
>> - modified tpm_reg_readl() by
>>    - removing the special case for TPM_TIS_REG_DID_VID.
>>      - however, I did not use the more efficient 32bit access due
>>        to the SPI bus master implementation. The 16bit register
>>        still require special treatment with the SPI RWX bits.
>>    - correcting tpm_reg_readb() with uint16_t reg
>> - tpm_set_verify_loc() added checking for 
>> TPM_TIS_CAPABILITIES_SUPPORTED2_0
>> - test_spi_tpm_transmit_test() added
>>    - TPM_TIS_STS_TPM_FAMILY2_0 check in status register
>>    - TPM responses verification
>> - fixed the PowerNV stdout msg from running 
>> qtest-ppc64/tpm-tis-spi-pnv-test
>> ---
>>   tests/qtest/tpm-tis-spi-pnv-test.c | 713 
>> +++++++++++++++++++++++++++++
>>   tests/qtest/meson.build            |   2 +
>>   2 files changed, 715 insertions(+)
>>   create mode 100644 tests/qtest/tpm-tis-spi-pnv-test.c
>> 
>> diff --git a/tests/qtest/tpm-tis-spi-pnv-test.c 
>> b/tests/qtest/tpm-tis-spi-pnv-test.c
>> new file mode 100644
>> index 0000000000..9eeeea41f7
>> --- /dev/null
>> +++ b/tests/qtest/tpm-tis-spi-pnv-test.c
>> @@ -0,0 +1,713 @@
>> +/*
>> + * QTest testcase for a Nuvoton NPCT75x TPM SPI device
>> + *                      running on the PowerNV machine.
>> + *
>> + * Copyright (c) 2024, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include <glib/gstdio.h>
>> +#include "libqtest-single.h"
>> +#include "hw/acpi/tpm.h"
>> +#include "hw/pci/pci_ids.h"
>> +#include "qtest_aspeed.h"
>> +#include "tpm-emu.h"
>> +#include "hw/ssi/pnv_spi_regs.h"
>> +#include "pnv-xscom.h"
>> +
>> +#define SPI_TPM_BASE            0xc0080
>> +#define SPI_SHIFT_COUNTER_N1    0x30000000
>> +#define SPI_SHIFT_COUNTER_N2    0x40000000
>> +#define SPI_RWX_OPCODE_SHIFT    56
>> +#define SPI_RWX_ADDR_SHIFT      32
>> +#define SPI_CMD_DATA_SHIFT      56
>> +
>> +#define CFG_COUNT_COMPARE_1     0x0000000200000000
>> +#define MM_REG_RDR_MATCH        0x00000000ff01ff00
>> +#define SEQ_OP_REG_BASIC        0x1134416200100000
>> +
>> +#define TPM_TIS_8BITS_MASK      0xff
>> +#define SPI_TPM_TIS_ADDR        0xd40000
>> +#define SPI_EXTEND              0x03
>> +#define TPM_WRITE_OP            0x0
>> +#define TPM_READ_OP             0x80
>> +
>> +#define SHORT_MAX_RETRIES       5
>> +#define LONG_MAX_RETRIES        10
>> +
>> +static const uint8_t TPM_CMD[12] =
>> +                     
>> "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
>> +
>> +#define DPRINTF(fmt, ...) do { \
>> +    if (DEBUG_TIS_TEST) { \
>> +        printf(fmt, ## __VA_ARGS__); \
>> +    } \
>> +} while (0)
>> +
>> +#define DEBUG_TIS_TEST 0
>> +
>> +#define DPRINTF_ACCESS \
>> +    DPRINTF("%s: %d: locty=%d l=%d access=0x%02x 
>> pending_request_flag=0x%x\n", \
>> +            __func__, __LINE__, locty, l, access, 
>> pending_request_flag)
>> +
>> +#define DPRINTF_STS \
>> +    DPRINTF("%s: %d: sts = 0x%08x\n", __func__, __LINE__, sts)
>> +
>> +static uint64_t pnv_spi_tpm_read(const PnvChip *chip, uint32_t reg)
>> +{
>> +    uint32_t pcba = SPI_TPM_BASE + reg;
>> +
>> +    return qtest_readq(global_qtest, pnv_xscom_addr(chip, pcba));
>> +}
>> +
>> +static void pnv_spi_tpm_write(const PnvChip *chip,
>> +                              uint32_t reg,
>> +                              uint64_t val)
>> +{
>> +    uint32_t pcba = SPI_TPM_BASE + reg;
>> +
>> +    qtest_writeq(global_qtest, pnv_xscom_addr(chip, pcba), val);
>> +}
>> +
>> +static void spi_op_complete(const PnvChip *chip)
>> +{
>> +    uint64_t cfg_reg;
>> +
>> +    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
>> +    g_assert_cmpuint(CFG_COUNT_COMPARE_1, ==, cfg_reg);
>> +    pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, 0);
>> +}
>> +
>> +static void spi_write_reg(const PnvChip *chip, uint64_t val)
>> +{
>> +    int i;
>> +    uint64_t spi_sts;
>> +
>> +    for (i = 0; i < LONG_MAX_RETRIES; i++) {
>> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
>> +        if (GETFIELD(SPI_STS_TDR_FULL, spi_sts) == 1) {
>> +            sleep(0.5);
> 
> 
> One of the Travis builds complains about this:
> 
> ../tests/qtest/tpm-tis-spi-pnv-test.c:90:19: error: implicit
> conversion from 'double' to 'unsigned int' changes value from 0.5 to 0
> [-Werror,-Wliteral-conversion]
> 
>             sleep(0.5);
> 
>             ~~~~~ ^~~
> 
> ../tests/qtest/tpm-tis-spi-pnv-test.c:104:19: error: implicit
> conversion from 'double' to 'unsigned int' changes value from 0.1 to 0
> [-Werror,-Wliteral-conversion]
> 
>             sleep(0.1);
> 
>             ~~~~~ ^~~
> 
> ../tests/qtest/tpm-tis-spi-pnv-test.c:123:15: error: implicit
> conversion from 'double' to 'unsigned int' changes value from 0.5 to 0
> [-Werror,-Wliteral-conversion]
> 
>         sleep(0.5);
> 
>         ~~~~~ ^~~
> 
> ../tests/qtest/tpm-tis-spi-pnv-test.c:128:19: error: implicit
> conversion from 'double' to 'unsigned int' changes value from 0.1 to 0
> [-Werror,-Wliteral-conversion]
> 
>             sleep(0.1);
> 
>             ~~~~~ ^~~
> 
> You need to use g_usleep() here.
> 
> 
> 
>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +    /* cannot write if SPI_STS_TDR_FULL bit is still set */
>> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_TDR_FULL, spi_sts));
>> +    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, val);
>> +
>> +    for (i = 0; i < SHORT_MAX_RETRIES; i++) {
>> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
>> +        if (GETFIELD(SPI_STS_SHIFTER_FSM, spi_sts) & FSM_DONE) {
>> +            break;
>> +        } else {
>> +            sleep(0.1);
> 
> Also here.

