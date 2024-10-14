Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BBBCF259D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 02:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Awx-0003yK-B6; Sun, 13 Oct 2024 22:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1t0Awr-0003xM-1r; Sun, 13 Oct 2024 22:36:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.ibm.com>)
 id 1t0Awi-0000OQ-UX; Sun, 13 Oct 2024 22:36:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E0F6ml025903;
 Mon, 14 Oct 2024 02:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
 :from:to:cc:subject:in-reply-to:references:message-id
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 o/nroe0QEsTROXWdJpODO0RwUZWP5S9cSvOhD75SfM0=; b=LQTTobh5Hr8tLTO5
 BgoLrmKu64CEnXG5CI6Q6rhnVUhaSS5gz5XVVJdqgrsEX8IsXggMstnK6cd+9FZT
 dADEJI8CluUZXDrTZEmmSJlOQ4qyt2Fco8weGDJVY6KONObm6sIADyDj+qgDFRcA
 DiG8xHzVUcge0LhUTRRIsvNnronaW7G0IO7MX9LOfZDaevZ1ToNKQKYDJaUCYXyn
 HgNbi1i5zsulfjVHbjy5Su2mofKz9P6Abua0IIs262Rh1kbOl7zxb2phVwhgHUK4
 yxVZM3puDsLIBM2Pvqkixefi7Oli55ARFD5ya8OLrsPpTYwcFiElL8WS8ninrMKl
 9lsMrg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428px2gku6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 02:36:21 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49E2aCx1004217;
 Mon, 14 Oct 2024 02:36:20 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 428px2gku4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 02:36:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49E07dTJ005936;
 Mon, 14 Oct 2024 02:36:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650kxp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Oct 2024 02:36:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49E2aHRH23724658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2024 02:36:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B6FF5805A;
 Mon, 14 Oct 2024 02:36:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B58558054;
 Mon, 14 Oct 2024 02:36:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Oct 2024 02:36:16 +0000 (GMT)
Date: Sun, 13 Oct 2024 21:36:16 -0500
From: dan tan <dantan@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 thuth@redhat.com, lvivier@redhat.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
Subject: Re: [PATCH] ppc/pnv: Add support for TPM with SPI interface
In-Reply-To: <e85c17d6-296c-47b4-b2f3-63a674713dc4@linux.ibm.com>
References: <20240912160959.25885-1-dantan@linux.vnet.ibm.com>
 <e85c17d6-296c-47b4-b2f3-63a674713dc4@linux.ibm.com>
Message-ID: <3fbc6ddcb0b1c72930918095ce9f8df8@linux.ibm.com>
X-Sender: dantan@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uTmdFIqOpMYGsC1S4kzWmOVSQbxAMa4O
X-Proofpoint-ORIG-GUID: AZgtUS00W8FvZYI11LczeqYWbIMRuD4W
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410140016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=dantan@linux.ibm.com;
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

Hi Stefan,

Thank you for the review comments! Please see my response below.

thank you,
---
dan tan
power simulation
phone:+1.7373.099.138
email:dantan@linux.ibm.com


On 2024-09-12 13:02, Stefan Berger wrote:
> On 9/12/24 12:09 PM, dan tan wrote:
>> From: dan tan <dantan@linux.ibm.com>
>> 
>> SPI interface to TPM TIS implementation via swtpm
> 
> Apart from Cedric's comments:
> 
> Can you say a bit more about the specs you followed and details how
> many localities are supported etc. Is this device pnv-specific or can
> it be used on other platforms as well? If it can then the 'pnv'
> prefix/suffix should probably disappear from functions in the test
> code because we could probably start an aarch or x86_64 VM then and
> call them as well.
> 
> Also, an entry in docs/specs/tpm.rst would be great.
> 

This addition to the TPM device support is part of a bigger project
to support an IBM hypervisor stack. In this system, IBM uses Nuvoton
Technology's TPM. Per Nuvoton's documentation, the NPCT7/6/5/4xx devices
implement all TCG commands and functionality, as defined in the 
following
TCG specifications:
- [TPM2.0] Trusted Platform Module Library Specification, Family “2.0”, 
Level 00, Revision 01.59
- Trusted Platform Module Library Specification, Family "2.0", Level 00, 
Revision 01.38
- Trusted Platform Module Library Specification, Family “2.0”, Level 00, 
Revision 01.16
https://trustedcomputinggroup.org/resource/tpm-library-specification/

The hypervisor only uses locality 0, thus, is the implementation as well
as the qtest.

The interface via SSI SPI is only implemented on the PowerNV platform.

I will add a section in docs/specs/tpm.rst to describe this support

>> 
>> Signed-off-by: dan tan <dantan@linux.ibm.com>
>> ---
>>   include/sysemu/tpm.h               |   3 +
>>   hw/tpm/tpm_tis_spi.c               | 347 
>> +++++++++++++++++++++++++++++
>>   tests/qtest/pnv-tpm-tis-spi-test.c | 223 ++++++++++++++++++
>>   hw/ppc/Kconfig                     |   1 +
>>   hw/tpm/Kconfig                     |   6 +
>>   hw/tpm/meson.build                 |   1 +
>>   tests/qtest/meson.build            |   2 +
>>   7 files changed, 583 insertions(+)
>>   create mode 100644 hw/tpm/tpm_tis_spi.c
>>   create mode 100644 tests/qtest/pnv-tpm-tis-spi-test.c
>> 
>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>> index 1ee568b3b6..22b05110e2 100644
>> --- a/include/sysemu/tpm.h
>> +++ b/include/sysemu/tpm.h
>> @@ -49,6 +49,7 @@ struct TPMIfClass {
>>   #define TYPE_TPM_CRB                "tpm-crb"
>>   #define TYPE_TPM_SPAPR              "tpm-spapr"
>>   #define TYPE_TPM_TIS_I2C            "tpm-tis-i2c"
>> +#define TYPE_TPM_TIS_SPI            "tpm-tis-spi"
>>     #define TPM_IS_TIS_ISA(chr)                         \
>>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
>> @@ -60,6 +61,8 @@ struct TPMIfClass {
>>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
>>   #define TPM_IS_TIS_I2C(chr)                      \
>>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_I2C)
>> +#define TPM_IS_TIS_SPI(chr)                      \
>> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SPI)
>>     /* returns NULL unless there is exactly one TPM device */
>>   static inline TPMIf *tpm_find(void)
>> diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c
>> new file mode 100644
>> index 0000000000..6e7f42b2db
>> --- /dev/null
>> +++ b/hw/tpm/tpm_tis_spi.c
>> @@ -0,0 +1,347 @@
>> +/*
>> + * QEMU PowerPC SPI TPM 2.0 model
>> + *
>> + * Copyright (c) 2024, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/pci/pci_ids.h"
>> +#include "hw/acpi/tpm.h"
>> +#include "tpm_prop.h"
>> +#include "qemu/log.h"
>> +#include "tpm_tis.h"
>> +#include "hw/ssi/ssi.h"
>> +
>> +typedef struct TPMStateSPI {
>> +    /*< private >*/
>> +    SSIPeripheral parent_object;
>> +
>> +    uint8_t     offset;       /* offset into data[] */
>> +    uint8_t     spi_state;    /* READ / WRITE / IDLE */
>> +#define SPI_STATE_IDLE   0
>> +#define SPI_STATE_WRITE  1
>> +#define SPI_STATE_READ   2
>> +
>> +    bool        command;
>> +
>> +    uint8_t     loc_sel;      /* Current locality */
>> +    uint32_t    tis_addr;     /* tis address including locty */
>> +
>> +    /*< public >*/
>> +    TPMState    tpm_state; /* not a QOM object */
>> +
>> +} TPMStateSPI;
>> +
>> +typedef struct xfer_buffer xfer_buffer;
>> +
>> +#ifdef SPI_DEBUG_ENABLED
>> +#define SPI_DEBUG(x) (x)
>> +#else
>> +#define SPI_DEBUG(x)
>> +#endif
>> +
>> +DECLARE_INSTANCE_CHECKER(TPMStateSPI, TPM_TIS_SPI, TYPE_TPM_TIS_SPI)
>> +
>> +static inline void tpm_tis_spi_clear_data(TPMStateSPI *spist)
>> +{
>> +    spist->spi_state = 0;
>> +    spist->offset = 0;
>> +    spist->tis_addr = 0xffffffff;
>> +
>> +    return;
>> +}
>> +
>> +/* Callback from TPM to indicate that response is copied */
>> +static void tpm_tis_spi_request_completed(TPMIf *ti, int ret)
>> +{
>> +    TPMStateSPI *spist = TPM_TIS_SPI(ti);
>> +    TPMState *s = &spist->tpm_state;
>> +
>> +    /* Inform the common code. */
>> +    tpm_tis_request_completed(s, ret);
>> +}
>> +
>> +static enum TPMVersion tpm_tis_spi_get_tpm_version(TPMIf *ti)
>> +{
>> +    TPMStateSPI *spist = TPM_TIS_SPI(ti);
>> +    TPMState *s = &spist->tpm_state;
>> +
>> +    return tpm_tis_get_tpm_version(s);
>> +}
>> +
>> +/*
>> + * TCG PC Client Platform TPM Profile Specification for TPM 2.0 ver 
>> 1.05 rev 14
>> + *
>> + * For system Software, the TPM has a 64-bit address of 
>> 0x0000_0000_FED4_xxxx.
>> + * On SPI, the chipset passes the least significant 24 bits to the 
>> TPM.
>> + * The upper bytes will be used by the chipset to select the TPM’s 
>> SPI CS#
>> + * signal. Table 9 shows the locality based on the 16 least 
>> significant address
>> + * bits and assume that either the LPC TPM sync or SPI TPM CS# is 
>> used.
>> + *
>> + */
>> +static void tpm_tis_spi_write(TPMStateSPI *spist, uint32_t addr, 
>> uint8_t val)
>> +{
>> +    SPI_DEBUG(qemu_log("tpm_tis_spi_write addr:0x%8.8x, 
>> value:%2.2x\n",
>> +                       addr, val));
>> +    TPMState *tpm_st = &spist->tpm_state;
> 
> First variable declation then empty line and then the SPI_DEBUG.
> 

Not sure how this happened, good catch! I will correct it.

>> +    tpm_tis_write_data(tpm_st, addr, val, 1);
>> +}
>> +
>> +static uint8_t tpm_tis_spi_read(TPMStateSPI *spist, uint32_t addr)
>> +{
>> +    uint16_t offset = addr & 0xffc;
>> +    TPMState *tpm_st = &spist->tpm_state;
>> +    uint8_t data;
>> +    uint32_t did_vid;
>> +
>> +    SPI_DEBUG(qemu_log("tpm_tis_spi_read addr:0x%8.8x .... ", addr));
>> +    if (offset == TPM_TIS_REG_DID_VID) {
>> +        did_vid = (TPM_TIS_TPM_DID << 16) | TPM_TIS_TPM_VID;
>> +        data = (did_vid >> ((addr & 0x3) * 8)) & 0xff;
> 
> Why does this register need special handling? This function could just
> be a 'return tpm_tis_read_data(tpm_st, addr, 1);' at this point, no?
> 

Yes, you are right!
This is the code segment leftover from the hypervisor specific support.
Although it is an IBM Power platform, the TPM does have a different
vendor ID and device ID than IBM's. If we didn't intercept this request,
tpm_tis_read_data() would return IBM's vendor ID, and the validation in
the hypervisor would fail.

I will remove the _if_ block and verify the results.

>> +    } else {
>> +        data = tpm_tis_read_data(tpm_st, addr, 1);
>> +    }
>> +
>> +    return data;
>> +}
>> +
>> +static Property tpm_tis_spi_properties[] = {
>> +    DEFINE_PROP_TPMBE("tpmdev", TPMStateSPI, tpm_state.be_driver),
>> +    DEFINE_PROP_UINT32("irq", TPMStateSPI, tpm_state.irq_num, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void tpm_tis_spi_reset(DeviceState *dev)
>> +{
>> +    TPMStateSPI *spist = TPM_TIS_SPI(dev);
>> +    TPMState *s = &spist->tpm_state;
>> +
>> +    tpm_tis_spi_clear_data(spist);
>> +
>> +    spist->loc_sel = 0x00;
>> +
>> +    return tpm_tis_reset(s);
>> +}
>> +
>> +static uint32_t tpm_transfer(SSIPeripheral *ss, uint32_t tx)
>> +{
>> +    uint32_t rx = 0;
>> +    /* static variables are automatically initialized to zero */
>> +    static uint8_t byte_offset;       /* byte offset in transfer */
>> +    static uint8_t wait_state_count;  /* wait state counter */
>> +    static uint8_t xfer_size;         /* data size of transfer */
>> +    static uint32_t reg_addr;         /* register address of transfer 
>> */
> 
> Shouldn't these statics be part of the TPMStateSPI so that they can be
> saved if the VM was to suspend in the middle of a transfer. If this
> cannot happen because you will always get all bytes passed to this
> function then why are these static's?

You are absolutely right! I will move them to the TPMStateSPI struct.

>> +
>> +    TPMStateSPI *spist = TPM_TIS_SPI(ss);
>> +
>> +    uint8_t byte;       /* reversed byte value */
>> +    uint8_t offset = 0; /* offset of byte in payload */
>> +    uint8_t index;      /* index of data byte in transfer */
>> +
>> +    SPI_DEBUG(qemu_log("TPM SPI request from controller\n"));
>> +
>> +    /* new transfer or not */
>> +    if (spist->command) {   /* new transfer start */
>> +        if (spist->spi_state != SPI_STATE_IDLE) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "unexpected new 
>> transfer\n");
>> +        }
>> +        byte_offset = 0;
>> +        wait_state_count = 0;
>> +    }
>> +    /*
>> +     * Explanation of wait_state:
>> +     * The original TPM model did not have wait state or "flow 
>> control" support
>> +     * built in.  If you wanted to read a TPM register through SPI 
>> you sent
>> +     * the first byte with the read/write bit and size, then three 
>> address bytes
>> +     * and any additional bytes after that were don't care bytes for 
>> reads and
>> +     * the model would begin returning byte data to the SPI reader 
>> from the
>> +     * register address provided.  In the real world this would mean 
>> that a
>> +     * TPM device had only the time between the 31st clock and the 
>> 32nd clock
>> +     * to fetch the register data that it had to provide to SPI MISO 
>> starting
>> +     * with the 32nd clock.
>> +     *
>> +     * In reality the TPM begins introducing a wait state at the 31st 
>> clock
>> +     * by holding MISO low.  This is how it controls the "flow" of 
>> the
>> +     * operation. Once the data the TPM needs to return is ready it 
>> will
>> +     * select bit 31 + (8*N) to send back a 1 which indicates that it 
>> will
>> +     * now start returning data on MISO.
>> +     *
>> +     * The same wait states are applied to writes.  In either the 
>> read or write
>> +     * case the wait state occurs between the command+address (4 
>> bytes) and the
>> +     * data (1-n bytes) sections of the SPI frame.  The code below 
>> introduces
>> +     * the support for a 32 bit wait state for P10.  All reads and 
>> writes
>> +     * through the SPI interface MUST now be aware of the need to do 
>> flow
>> +     * control in order to use the TPM via SPI.
>> +     *
>> +     * In conjunction with these changes there were changes made to 
>> the SPIM
>> +     * engine that was introduced in P10 to support the 6x op code 
>> which is
>> +     * used to receive wait state 0s on the MISO line until it sees 
>> the b'1'
>> +     * come back before continuing to read real data from the SPI 
>> device(TPM).
>> +     */
>> +
>> +    SPI_DEBUG(qemu_log("Processing new payload current 
>> byte_offset=%d\n",
>> +                            byte_offset));
>> +    /* process payload data */
>> +    while (offset < 4) {
>> +        spist->command = false;
>> +        byte = (tx >> (24 - 8 * offset)) & 0xFF;
>> +        SPI_DEBUG(qemu_log("Extracted byte=0x%2.2x from payload 
>> offset=%d\n",
>> +                  byte, offset));
>> +        switch (byte_offset) {
>> +        case 0:    /* command byte */
>> +            if ((byte >> 7) == 0) {    /* bit-7 */
> 
> I think checking for bit 7 would be better like this:
> 
> #define CMD_BYTE_WRITE (1 << 7)
> if ((byte & CMD_BYTE_WRITE) == 0)

Yes, that does look more readable. I will make the change.

>> +                spist->spi_state = SPI_STATE_WRITE;
>> +                SPI_DEBUG(qemu_log("spi write\n"));
>> +            } else {
>> +                spist->spi_state = SPI_STATE_READ;
>> +                SPI_DEBUG(qemu_log("spi read\n"));
>> +            }
> 
> # define CMD_BYTE_XFER_SZ_MASK  0x1f
> xfter_size = (byte & CMD_BYTE_XFER_SZ_MASK)

ditto!

>> +            xfer_size = (byte & 0x1f) + 1;  /* bits 5:0 */
>> +            SPI_DEBUG(qemu_log("xfer_size=%d\n", xfer_size));
>> +            break;
>> +        case 1:     /* 1st address byte */
> 
> This is the from the TIS address 0fe >d4< 00 00.

Correct. I will add a comment

>> +            if (byte != 0xd4) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "incorrect high 
>> address 0x%x\n",
>> +                              byte);
>> +            }
>> +            reg_addr = byte << 16;
>> +            SPI_DEBUG(qemu_log("first addr byte=0x%x, reg_addr now 
>> 0x%8.8x\n",
>> +                      byte, reg_addr));
>> +            break;
>> +        case 2:     /* 2nd address byte */
>> +            reg_addr |= byte << 8;
>> +            SPI_DEBUG(qemu_log("second addr byte=0x%x, reg_addr now 
>> 0x%8.8x\n",
>> +                      byte, reg_addr));
>> +            break;
>> +        case 3:     /* 3rd address byte */
>> +            reg_addr |= byte;
>> +            SPI_DEBUG(qemu_log("third addr byte=0x%x, reg_addr now 
>> 0x%8.8x\n",
>> +                      byte, reg_addr));
>> +            break;
>> +        default:    /* data bytes */
>> +            if (wait_state_count < 4) {
>> +                wait_state_count++;
>> +                if (wait_state_count == 4) {
>> +                    SPI_DEBUG(qemu_log("wait complete, 
>> wait_state_count=0x%x\n",
>> +                              wait_state_count));
>> +                    rx = rx | (0x01 << (24 - offset * 8));
>> +                    return rx;
>> +                } else {
>> +                    SPI_DEBUG(qemu_log("in wait state, 
>> wait_state_count=0x%x\n",
>> +                              wait_state_count));
>> +                    rx = 0;
>> +                }
>> +            } else {
>> +                index = byte_offset - 4;
>> +                SPI_DEBUG(qemu_log("data byte=0x%x for index=%d, "
>> +                                    "reg_addr now 0x%8.8x\n",
>> +                                    byte, index, reg_addr));
>> +
>> +                if (index >= xfer_size) {
>> +                    /*
>> +                     * SPI SSI framework limits both rx and tx
>> +                     * to fixed 4-byte with each xfer
> 
> Per the setting of xfer_size above it can be up to 32 bytes?

This comment is made by the SPI SSI implementer. I believe this
is the SSI framework statement. The SPI max transfer size is much
smaller

>> +                     */
>> +                    SPI_DEBUG(qemu_log("data exceeds expected amount 
>> %u\n",
>> +                              xfer_size));
>> +                    return rx;
>> +                }
>> +                spist->tis_addr = reg_addr + (index % 4);
>> +                if (spist->spi_state == SPI_STATE_WRITE) {
>> +                    tpm_tis_spi_write(spist, spist->tis_addr, byte);
>> +                } else {
>> +                    byte = tpm_tis_spi_read(spist, spist->tis_addr);
>> +                    rx = rx | (byte << (24 - offset * 8));
>> +                    SPI_DEBUG(qemu_log("added byte=0x%2.2x to 
>> response payload"
>> +                             " at offset=%d\n", byte, offset));
>> +                }
>> +            }
>> +            break;
>> +        }
>> +        if ((wait_state_count == 0) || (wait_state_count == 4)) {
> 
> Is there not a more obvious relationship between having to increase
> offset and byte_offset other than making this depend on the
> wait_states? Like make it depend on the byte_offset.

A wait state in a Serial Peripheral Interface (SPI) occurs when the main
must wait before issuing clock cycles to allow for a required waiting 
period.
It does not have direct relationships with the byte_offset. With real 
hardware,
a good example would be that if an analog-to-digital conversion is 
required,
the main must wait for the conversion to complete before issuing clock 
cycles.

> /*
>  * advance offsets while handling command and address bytes and once
>  * 4 wait states have been reached.
>  */
> if (byte_offset <= 3 || wait_state_count == 4)
> 
>> +            offset++;
>> +            byte_offset++;
>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +    return rx;
>> +}
>> +
>> +static int tpm_cs(SSIPeripheral *ss, bool select)
>> +{
>> +    TPMStateSPI *spist = TPM_TIS_SPI(ss);
> 
> add empty line
> 

yes, sir.

>> +    if (select) {
>> +        spist->command = false;
>> +        spist->spi_state = SPI_STATE_IDLE;
>> +    } else {
>> +        spist->command = true;
>> +    }
>> +    return 0;
>> +}
>> +
>> +
> one too many empty lines
> 
>> +static void tpm_realize(SSIPeripheral *dev, Error **errp)
>> +{
>> +    TPMStateSPI *spist = TPM_TIS_SPI(dev);
>> +    TPMState *s = &spist->tpm_state;
>> +
>> +    spist->command = true;
>> +    spist->spi_state = SPI_STATE_IDLE;
>> +
>> +    if (!tpm_find()) {
>> +        error_setg(errp, "at most one TPM device is permitted");
>> +        return;
>> +    }
>> +
>> +    s->be_driver = qemu_find_tpm_be("tpm0");
>> +
>> +    if (!s->be_driver) {
>> +        error_setg(errp, "unable to find tpm backend device");
>> +        return;
>> +    }
>> +}
>> +
>> +static void tpm_tis_spi_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    TPMIfClass *tc = TPM_IF_CLASS(klass);
>> +    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
>> +
>> +    k->transfer = tpm_transfer;
>> +    k->realize = tpm_realize;
>> +    k->set_cs = tpm_cs;
>> +    k->cs_polarity = SSI_CS_LOW;
>> +
>> +    dc->reset = tpm_tis_spi_reset;
>> +    device_class_set_props(dc, tpm_tis_spi_properties);
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +
>> +    dc->desc = "PowerNV SPI TPM";
> 
> Is it really a PowerNV specific device?

At current time, it is, as it relies on PNV_SPI

>> +
>> +    tc->model = TPM_MODEL_TPM_TIS;
>> +    tc->request_completed = tpm_tis_spi_request_completed;
>> +    tc->get_version = tpm_tis_spi_get_tpm_version;
>> +}
>> +
>> +static const TypeInfo tpm_tis_spi_info = {
>> +    .name          = TYPE_TPM_TIS_SPI,
>> +    .parent        = TYPE_SSI_PERIPHERAL,
>> +    .instance_size = sizeof(TPMStateSPI),
>> +    .class_init    = tpm_tis_spi_class_init,
>> +    .interfaces    = (InterfaceInfo[]) {
>> +        { TYPE_TPM_IF },
>> +        { }
>> +    }
>> +};
>> +
>> +static void tpm_tis_spi_register_types(void)
>> +{
>> +    type_register_static(&tpm_tis_spi_info);
>> +}
>> +
>> +type_init(tpm_tis_spi_register_types)
>> diff --git a/tests/qtest/pnv-tpm-tis-spi-test.c 
>> b/tests/qtest/pnv-tpm-tis-spi-test.c
>> new file mode 100644
>> index 0000000000..395c944044
>> --- /dev/null
>> +++ b/tests/qtest/pnv-tpm-tis-spi-test.c
> 
> Call it tpm-tis-spi-pnv-test.c ? with functions in namespace
> tpm_tis_spi_pnv_...  If this device is not PNV specific you should
> probably drop pnv from the name.

It is PNV specific. It is only implemented and runs on PowerNV platform.
Given that, should I keep the pnv-tpm-tis-spi-test.c name, or change it
to tpm-tis-spi-pnv-test.c?

>> @@ -0,0 +1,223 @@
>> +/*
>> + * QTest testcase for PowerNV 10 TPM with SPI interface
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
>> +
>> +#define CFG_COUNT_COMPARE_1     0x0000000200000000
>> +#define MM_REG_RDR_MATCH        0x00000000ff01ff00
>> +#define SEQ_OP_REG_BASIC        0x1134416200100000
>> +
>> +#define TPM_REG_LOC_0  0xd40000
>> +
>> +static void pnv_spi_tpm_write(const PnvChip *chip,
>> +                              uint32_t reg,
>> +                              uint64_t val)
>> +{
>> +    uint32_t pcba = SPI_TPM_BASE + reg;
>> 
> add empty line
> +    qtest_writeq(global_qtest, pnv_xscom_addr(chip, pcba), val);
>> +}
>> +
>> +static uint64_t pnv_spi_tpm_read(const PnvChip *chip, uint32_t reg)
>> +{
>> +    uint32_t pcba = SPI_TPM_BASE + reg;
> add empty line

got it

>> +    return qtest_readq(global_qtest, pnv_xscom_addr(chip, pcba));
>> +}
>> +
>> +static void spi_access_start(const PnvChip *chip,
>> +                             bool n2,
>> +                             uint8_t bytes,
>> +                             uint8_t tpm_op,
>> +                             uint32_t tpm_reg)
>> +{
>> +    uint64_t cfg_reg;
>> +    uint64_t reg_op;
>> +    uint64_t seq_op = SEQ_OP_REG_BASIC;
>> +
>> +    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
>> +    if (cfg_reg != CFG_COUNT_COMPARE_1) {
>> +        pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, 
>> CFG_COUNT_COMPARE_1);
>> +    } > +    if (n2) {
> 
> What does 'n2' mean?

This is in regards to the two SPI shift registers n1 and n2. Some 
commands
only use one shift register, thus, n2 = False.


>> +        seq_op |= 0x40000000 | (bytes << 0x18);
> 
> Any comment about these hex values that you are shifting the 'bytes' 
> into?
> 

I will add a comment to explain.

>> +    } else {
>> +        seq_op |= 0x30000000 | (bytes << 0x18);
>> +    }
>> +    pnv_spi_tpm_write(chip, SPI_SEQ_OP_REG, seq_op);
>> +    pnv_spi_tpm_write(chip, SPI_MM_REG, MM_REG_RDR_MATCH);
>> +    pnv_spi_tpm_write(chip, SPI_CTR_CFG_REG, (uint64_t)0);
>> +    reg_op = bswap64(tpm_op) | ((uint64_t)tpm_reg << 0x20);
>> +    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, reg_op);
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
>> +    for (i = 0; i < 10; i++) {
>> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
>> +        if (GETFIELD(SPI_STS_TDR_FULL, spi_sts) == 1) {
>> +            sleep(0.5);
>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +    /* cannot write if SPI_STS_TDR_FULL bit is still set */
>> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_TDR_FULL, spi_sts));
>> +    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, val);
>> +
>> +    for (i = 0; i < 3; i++) {
>> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
>> +        if (GETFIELD(SPI_STS_SHIFTER_FSM, spi_sts) & FSM_DONE) {
>> +            break;
>> +        } else {
>> +            sleep(0.1);
>> +        }
>> +    }
>> +    /* it should be done given the amount of time */
>> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_SHIFTER_FSM, spi_sts) & 
>> FSM_DONE);
>> +    spi_op_complete(chip);
>> +}
>> +
>> +static uint64_t spi_read_reg(const PnvChip *chip)
>> +{
>> +    int i;
>> +    uint64_t spi_sts, val = 0;
>> +
>> +    for (i = 0; i < 10; i++) {
>> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
>> +        if (GETFIELD(SPI_STS_RDR_FULL, spi_sts) == 1) {
>> +            val = pnv_spi_tpm_read(chip, SPI_RCV_DATA_REG);
>> +            break;
>> +        }
>> +        sleep(0.5);
>> +    }
>> +    for (i = 0; i < 3; i++) {
>> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
>> +        if (GETFIELD(SPI_STS_RDR_FULL, spi_sts) == 1) {
>> +            sleep(0.1);
>> +        } else {
>> +            break;
>> +        }
>> +    }
>> +    /* SPI_STS_RDR_FULL bit should be reset after read */
>> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_RDR_FULL, spi_sts));
>> +    spi_op_complete(chip);
>> +    return val;
>> +}
>> +
>> +static void tpm_set_verify_loc0(const PnvChip *chip)
>> +{
>> +    uint8_t access;
>> +
>> +    g_test_message("TPM locality 0 test");
>> +    spi_access_start(chip, false, 1, 0, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_ACCESS);
>> +    spi_write_reg(chip, 0);
> 
> Looking at the other test cases for the I2C and 'regular' TIS it
> should be possible to abstract this here also to something like the
> following so that those test cases could be easily transferred here:
> 
> tpm_tis_spi_pnv_writeb(chip, TIS_REG(locty, TPM_TIS_REG_ACCESS), 0);

Good idea! I will implement this.

>> +    spi_access_start(chip, false, 1, 0, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_ACCESS);
>> +    spi_write_reg(chip, bswap64(TPM_TIS_ACCESS_REQUEST_USE));
> 
> tpm_tis_spi_pnv_writeb(chip, TIS_REG(locty, TPM_TIS_REG_ACCESS),
> TPM_TIS_ACCESS_REQUEST_USE);

ditto!

>> +
>> +    spi_access_start(chip, true, 1, 0x80, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_ACCESS);
>> +    access = (uint8_t)spi_read_reg(chip);
> 
> 
> access = tpm_tis_spi_pnv_readb(chip, TIS_REG(locty, 
> TPM_TIS_REG_ACCESS));
> 

will do.

> 
> 
>> +    g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
>> +                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
>> +                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
>> +    g_test_message("ACCESS REG = 0x%x checked", access);
>> +}
>> +
>> +static void test_spi_tpm(const void *data)
>> +{
>> +    const PnvChip *chip = data;
>> +    uint32_t tpm_sts;
>> +
>> +    /* vendor ID and device ID ... check against the known value*/
>> +    spi_access_start(chip, true, 4, 0x83, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_DID_VID);
>> +    g_test_message("DID_VID = 0x%lx", spi_read_reg(chip));
> 
> I2C has this assert here:
>         didvid = tpm_tis_i2c_readl(locty, TPM_I2C_REG_DID_VID);
>         g_assert_cmpint(didvid, ==, (1 << 16) | PCI_VENDOR_ID_IBM);
> 
> ->
> 	didvid = tpm_tis_spi_pnv_readl(chip, TIS_REG(locty, 
> TPM_TIS_REG_DID_VID))

OK, I can implement this as well

>> +
>> +    /* set locality 0 */
>> +    tpm_set_verify_loc0(chip);
> 
> ->
> 	tpm_tis_spi_pnv_writeb(chip, TIS_REG(0, TPM_TIS_REG_ACCESS),
> TPM_TIS_ACCESS_REQUEST_USE);
> 
> I would try to recycle as much of the normal and/or I2C test case
> here. They all should be easy to transfer.

OK, I will look into them.

>> +
>> +    g_test_message("TPM status register tests");
>> +    /* test tpm status register */
>> +    spi_access_start(chip, true, 4, 0x80, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_STS);
>> +    tpm_sts = (uint32_t)spi_read_reg(chip);
>> +    g_assert_cmpuint(0, ==, tpm_sts);
>> +    /* tpm cmd_ready is a read/write bit */
>> +    /* set the cmd_ready bit */
>> +    spi_access_start(chip, false, 1, 0, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_STS);
>> +    spi_write_reg(chip, bswap64(TPM_TIS_STS_COMMAND_READY));
>> +    /* check the cmd_ready bit */
>> +    spi_access_start(chip, true, 1, 0x80, TPM_REG_LOC_0 | 
>> TPM_TIS_REG_STS);
>> +    tpm_sts = (uint8_t)spi_read_reg(chip);
>> +    g_assert_cmpuint(TPM_TIS_STS_COMMAND_READY, ==,
>> +                    (TPM_TIS_STS_COMMAND_READY | tpm_sts));
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int ret;
>> +    char *tname;
>> +    char args[512];
>> +    GThread *thread;
>> +    TPMTestState test;
>> +    g_autofree char *tmp_path = 
>> g_dir_make_tmp("qemu-tpm-tis-spi-test.XXXXXX",
>> +                                                NULL);
>> +
>> +    module_call_init(MODULE_INIT_QOM);
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    test.addr = g_new0(SocketAddress, 1);
>> +    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
>> +    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", 
>> NULL);
>> +    g_mutex_init(&test.data_mutex);
>> +    g_cond_init(&test.data_cond);
>> +    test.data_cond_signal = false;
>> +    test.tpm_version = TPM_VERSION_2_0;
>> +
>> +    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
>> +    tpm_emu_test_wait_cond(&test);
>> +
>> +    tname = g_strdup_printf("pnv-xscom/spi-tpm-tis/%s",
>> +                             pnv_chips[3].cpu_model);
>> +
>> +    sprintf(args, "-m 2G -machine powernv10 -smp 2,cores=2,"
>> +                      "threads=1 -accel tcg,thread=single -nographic 
>> "
>> +                      "-chardev socket,id=chrtpm,path=%s "
>> +                      "-tpmdev emulator,id=tpm0,chardev=chrtpm "
>> +                      "-device 
>> tpm-tis-spi,tpmdev=tpm0,bus=pnv-spi-bus.4",
>> +                      test.addr->u.q_unix.path);
> 
> all other test cases use :
> 
> args = g_strdup_printf(..)
> ...
> g_free(args);
> 

I remember there was a reason for me to separate the g_strdup_printf() 
return string
used for the qtest_start() call. It has something to do with the test 
log output. I
will test per your suggestion and see the problem I had encountered 
before.

>> +    qtest_start(args);
>> +    qtest_add_data_func(tname, &pnv_chips[3], test_spi_tpm);
>> +    ret = g_test_run();
>> +
>> +    qtest_end();
>> +    g_thread_join(thread);
>> +    g_unlink(test.addr->u.q_unix.path);
>> +    qapi_free_SocketAddress(test.addr);
>> +    g_rmdir(tmp_path);
>> +    g_free(tname);
>> +    return ret;
>> +}
>> +
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index 5addad1124..91232b33a9 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -39,6 +39,7 @@ config POWERNV
>>       select PCI_POWERNV
>>       select PCA9552
>>       select PCA9554
>> +    select TPM_TIS_SPI
>>       select SERIAL_ISA
>>       select SSI
>>       select SSI_M25P80
>> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
>> index a46663288c..5951c225cc 100644
>> --- a/hw/tpm/Kconfig
>> +++ b/hw/tpm/Kconfig
>> @@ -5,6 +5,12 @@ config TPM_TIS_I2C
>>       select I2C
>>       select TPM_TIS
>>   +config TPM_TIS_SPI
>> +    bool
>> +    depends on TPM
>> +    select TPM_BACKEND
>> +    select TPM_TIS
>> +
>>   config TPM_TIS_ISA
>>       bool
>>       depends on TPM && ISA_BUS
>> diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
>> index 6968e60b3f..e03cfb11b9 100644
>> --- a/hw/tpm/meson.build
>> +++ b/hw/tpm/meson.build
>> @@ -2,6 +2,7 @@ system_ss.add(when: 'CONFIG_TPM_TIS', if_true: 
>> files('tpm_tis_common.c'))
>>   system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: 
>> files('tpm_tis_isa.c'))
>>   system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: 
>> files('tpm_tis_sysbus.c'))
>>   system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: 
>> files('tpm_tis_i2c.c'))
>> +system_ss.add(when: 'CONFIG_TPM_TIS_SPI', if_true: 
>> files('tpm_tis_spi.c'))
>>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
>>   system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
>>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 2f0d3ef080..8f0e9eb070 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -172,6 +172,7 @@ qtests_ppc64 = \
>>     (config_all_devices.has_key('CONFIG_PSERIES') ? 
>> ['device-plug-test'] : []) +               \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] 
>> : []) +                 \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-spi-seeprom-test'] : []) +           \
>> +  (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-tpm-tis-spi-test'] : []) +           \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-host-i2c-test'] : []) +              \
>>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : 
>> []) +                      \
>>     (slirp.found() ? ['pxe-test'] : []) +              \
>> @@ -343,6 +344,7 @@ qtests = {
>>     'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
>>     'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>>     'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>> +  'pnv-tpm-tis-spi-test': [io, tpmemu_files],
>>     'virtio-net-failover': files('migration-helpers.c'),
>>     'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
>>     'netdev-socket': files('netdev-socket.c', 
>> '../unit/socket-helpers.c'),

