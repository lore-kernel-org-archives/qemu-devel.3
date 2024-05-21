Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1E2C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 06:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9J9b-0000yH-QU; Tue, 21 May 2024 02:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s9J9Z-0000xQ-Ro; Tue, 21 May 2024 02:39:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s9J9X-0002tJ-LV; Tue, 21 May 2024 02:39:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44L6WNrk010116; Tue, 21 May 2024 06:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kC83FcZ88T+cg4Zd7GyzIAYjVd7wgSkf2Pm0ZVDuB6I=;
 b=E/bWfy5mOpawgGM7qbckKqvqYbV8w9FSH1/DMNUct31lQ7oecardfg8ceoHUeSH2y3Ua
 rurSvxOotn3PWPM361LzGYkWUSPoVc3bJJc681qEKSpDx53NZyQB8O6QYx5d/0Vm2p1T
 Zjgm10EN0WPUuPtNJnC/WVMpp17bOQfDJQA9uuNyyb9foy5c957R0tVmLCLTjwaL7AJX
 6V3xdN9LG8pbhkBiIs3Xh3ow22T6Pse0aGM3ErHcjVk1l+duugG3JNjmjnh6/feepd6M
 OkgN/pLwaRvg7Q79usx3zR6VEtjAmHWLevHPs7kKX28M9Nkk1DE8S2tjn0KbBJ3eAc82 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8pe5r0gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 06:39:06 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44L6d5OG019841;
 Tue, 21 May 2024 06:39:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8pe5r0gs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 06:39:05 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44L2qLVp023460; Tue, 21 May 2024 06:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77np46ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 06:39:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44L6d0JE41943308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 06:39:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E91C20063;
 Tue, 21 May 2024 06:39:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F36D720077;
 Tue, 21 May 2024 06:38:57 +0000 (GMT)
Received: from [9.113.183.100] (unknown [9.113.183.100])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 06:38:57 +0000 (GMT)
Message-ID: <21ea8598-ae20-45b5-85e7-f360d24199f5@linux.ibm.com>
Date: Tue, 21 May 2024 12:08:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] tests/qtest: Add pnv-spi-seeprom qtest
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-6-chalapathi.v@linux.ibm.com>
 <dfcf9e54-3fe5-4551-bfd3-814d9cd62724@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <dfcf9e54-3fe5-4551-bfd3-814d9cd62724@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cceaP4viLPrfKcc91RxE032UaLllTlaS
X-Proofpoint-GUID: HLqoPbmd6z6NzZJ97myaW202_GRgWTqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_04,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=748 adultscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210049
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 20-05-2024 11:43, Cédric Le Goater wrote:
> On 5/15/24 19:41, Chalapathi V wrote:
>> In this commit Write a qtest pnv-spi-seeprom-test to check the
>> SPI transactions between spi controller and seeprom device.
>>
>> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
>> ---
>>   tests/qtest/pnv-spi-seeprom-test.c | 129 +++++++++++++++++++++++++++++
>>   tests/qtest/meson.build            |   1 +
>>   2 files changed, 130 insertions(+)
>>   create mode 100644 tests/qtest/pnv-spi-seeprom-test.c
>>
>> diff --git a/tests/qtest/pnv-spi-seeprom-test.c 
>> b/tests/qtest/pnv-spi-seeprom-test.c
>> new file mode 100644
>> index 0000000000..bfa57f3234
>> --- /dev/null
>> +++ b/tests/qtest/pnv-spi-seeprom-test.c
>> @@ -0,0 +1,129 @@
>> +/*
>> + * QTest testcase for PowerNV 10 Seeprom Communications
>> + *
>> + * Copyright (c) 2024, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include <unistd.h>
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "qemu/bswap.h"
>> +#include "hw/ssi/pnv_spi_regs.h"
>> +
>> +#define P10_XSCOM_BASE          0x000603fc00000000ull
>> +#define SPIC2_XSCOM_BASE        0xc0040
>> +
>> +/* To transmit READ opcode and address */
>> +#define READ_OP_TDR_DATA        0x0300010000000000
>> +/*
>> + * N1 shift - tx 4 bytes (transmit opcode and address)
>> + * N2 shift - tx and rx 8 bytes.
>> + */
>> +#define READ_OP_COUNTER_CONFIG  0x2040000000002b00
>> +/* SEQ_OP_SELECT_RESPONDER - N1 Shift - N2 Shift * 5 - SEQ_OP_STOP */
>> +#define READ_OP_SEQUENCER       0x1130404040404010
>> +
>> +/* To transmit WREN(Set Write Enable Latch in status0 register) 
>> opcode */
>> +#define WRITE_OP_WREN           0x0600000000000000
>> +/* To transmit WRITE opcode, address and data */
>> +#define WRITE_OP_TDR_DATA       0x0300010012345678
>> +/* N1 shift - tx 8 bytes (transmit opcode, address and data) */
>> +#define WRITE_OP_COUNTER_CONFIG 0x4000000000002000
>> +/* SEQ_OP_SELECT_RESPONDER - N1 Shift - SEQ_OP_STOP */
>> +#define WRITE_OP_SEQUENCER      0x1130100000000000
>> +
>> +static uint64_t pnv_xscom_addr(uint32_t pcba)
>> +{
>> +    return P10_XSCOM_BASE | ((uint64_t) pcba << 3);
>> +}
>
>
> I would prefer if the test used the pnv_xscom_addr() definition from
> tests/qtest/pnv-xscom.h.
Sure. Will update. Thank You
>
>> +static uint64_t pnv_spi_seeprom_xscom_addr(uint32_t reg)
>> +{
>> +    return pnv_xscom_addr(SPIC2_XSCOM_BASE + reg);
>> +}
>> +
>> +static void pnv_spi_controller_xscom_write(QTestState *qts, uint32_t 
>> reg,
>> +                uint64_t val)
>> +{
>> +    qtest_writeq(qts, pnv_spi_seeprom_xscom_addr(reg), val);
>> +}
>> +
>> +static uint64_t pnv_spi_controller_xscom_read(QTestState *qts, 
>> uint32_t reg)
>> +{
>> +    return qtest_readq(qts, pnv_spi_seeprom_xscom_addr(reg));
>> +}
>> +
>> +static void spi_seeprom_transaction(QTestState *qts)
>> +{
>> +    /* SPI transactions to SEEPROM to read from SEEPROM image */
>> +    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
>> +                                    READ_OP_COUNTER_CONFIG);
>> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
>> +                                    READ_OP_SEQUENCER);
>> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 
>> READ_OP_TDR_DATA);
>> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 0);
>> +    /* Read 5*8 bytes from SEEPROM at 0x100 */
>> +    uint64_t rdr_val = pnv_spi_controller_xscom_read(qts, 
>> RECEIVE_DATA_REG);
>> +    printf("RDR READ = 0x%lx\n", rdr_val);
>> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
>> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
>> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
>> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
>> +    printf("RDR READ = 0x%lx\n", rdr_val);
>> +
>> +    /* SPI transactions to SEEPROM to write to SEEPROM image */
>> +    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
>> +                                    WRITE_OP_COUNTER_CONFIG);
>> +    /* Set Write Enable Latch bit of status0 register */
>> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
>> +                                    WRITE_OP_SEQUENCER);
>> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 
>> WRITE_OP_WREN);
>> +    /* write 8 bytes to SEEPROM at 0x100 */
>> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
>> +                                    WRITE_OP_SEQUENCER);
>> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 
>> WRITE_OP_TDR_DATA);
>> +}
>> +
>> +/* Find complete path of in_file in the current working directory */
>> +static void find_file(const char *in_file, char *in_path)
>> +{
>> +    g_autofree char *cwd = g_get_current_dir();
>> +    char *filepath = g_build_filename(cwd, in_file, NULL);
>> +    if (!access(filepath, F_OK)) {
>> +        strcpy(in_path, filepath);
>> +    } else {
>> +        strcpy(in_path, "");
>> +        printf("File %s not found within %s\n", in_file, cwd);
>> +    }
>> +}
>> +
>> +static void test_spi_seeprom(void)
>> +{
>> +    QTestState *qts = NULL;
>> +    char seepromfile[500];
>> +    find_file("sbe_measurement_seeprom.bin.ecc", seepromfile);
>
> hmm, could you generate the contents instead ?
>
>> +    if (strcmp(seepromfile, "")) {
>> +        printf("Starting QEMU with seeprom file.\n");
>> +        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
>> +                          "threads=1 -accel tcg,thread=single 
>> -nographic "
>> +                          "-blockdev node-name=pib_spic2,driver=file,"
>> +              "filename=sbe_measurement_seeprom.bin.ecc "
>> +              "-device 25csm04,bus=pnv-spi-bus.2,cs=0,"
>> +              "drive=pib_spic2");
>> +    } else {
>> +        printf("Starting QEMU without seeprom file.\n");
>> +        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
>> +                          "threads=1 -accel tcg,thread=single 
>> -nographic"
>> +              " -device 25csm04,bus=pnv-spi-bus.2,cs=0");
>> +    }
>> +    spi_seeprom_transaction(qts);
>> +    qtest_quit(qts);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("spi_seeprom", test_spi_seeprom);
>> +    return g_test_run();
>> +}
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 86293051dc..2fa98b2430 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -171,6 +171,7 @@ qtests_ppc64 = \
>>     qtests_ppc + \
>>     (config_all_devices.has_key('CONFIG_PSERIES') ? 
>> ['device-plug-test'] : []) +               \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-xscom-test'] : []) +                 \
>> +  (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-spi-seeprom-test'] : []) +           \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-host-i2c-test'] : []) +              \
>>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : 
>> []) +                      \
>>     (slirp.found() ? ['pxe-test'] : []) +              \
>

