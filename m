Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77340E67800
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 14:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Eyh-000693-Fq; Sat, 02 Nov 2024 10:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t7Eyd-00068R-E8; Sat, 02 Nov 2024 10:19:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t7EyZ-0002qm-NH; Sat, 02 Nov 2024 10:19:42 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2Dg5Qd013662;
 Sat, 2 Nov 2024 14:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vHCL0e
 i//NHPWo6/qyLseGoolwWwrNB76LdUxcqzLFU=; b=fI42ci7R15LbZKbA22xFjk
 lWipbWfIQ5XZx9Hs/B2mj3nZT51mNXfKru4LtVuvzg6YWuob2shgeZ+1gYamtA/7
 rNtj4z0/Eo/BbZ6COnqY3FgVSTbE/A/JnFdTco6x0gDB2VnIY2X9rHVG2MtREG6Z
 v1IT8Y7ttcEdJcijIJYoyEOk7YpxaKYvL+h9RoSinYD7X7uSdNxfZLD7/HzWMPRF
 58v7c5/N8Ldg5uCjb3TtR5NxvMyTE2/ElOxORJqDrg0Aafxpr40IhO4nD3D4dlul
 AemKEqNezSH6e/w5Wi4dtyWrHBZ2xfcDBQMRJnfB2Us3mJ5CSzntzzReTcnUdEWw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42nn5nr2a6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 Nov 2024 14:19:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A27Wmig008162;
 Sat, 2 Nov 2024 14:19:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nfqg8cx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 Nov 2024 14:19:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A2EJWrf4194924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 2 Nov 2024 14:19:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78D405805A;
 Sat,  2 Nov 2024 14:19:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9ADB58052;
 Sat,  2 Nov 2024 14:19:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  2 Nov 2024 14:19:31 +0000 (GMT)
Message-ID: <78c4eb21-855a-494d-bc83-049914bbacfb@linux.ibm.com>
Date: Sat, 2 Nov 2024 10:19:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] tpm/tpm_tis_spi: Support TPM for SPI (Serial
 Peripheral Interface)
To: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org
References: <20241101202727.9023-1-dantan@linux.vnet.ibm.com>
 <20241101202727.9023-2-dantan@linux.vnet.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241101202727.9023-2-dantan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PQYsolvrk8HJAmFdwDLkNSHUesHITJ3B
X-Proofpoint-ORIG-GUID: PQYsolvrk8HJAmFdwDLkNSHUesHITJ3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411020125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 11/1/24 4:27 PM, dan tan wrote:
> Implement support for TPM via SPI interface. The SPI bus master
> is provided by PowerNV SPI device which is an SSI peripheral.
> It can uses the tpm_emulator driver backend with the external
> swtpm.
> 
> Although the implementation is endian neutral, the SPI
> bus master provider, pnv_spi.c is only supported on the
> PowerNV platform, thus, is big endian specific.
> 

Did you try running this with Linux? Did the Linux TPM driver work?

> tpm/tpm_tis_spi: Support TPM for SPI (rev 4)

Remove this. It seems to be from your patch merge.

> 
> - moved variable tis_addr from TPMStateSPI struct to local
> - added the VM suspend/resume support:
>    - added vmstate_tpm_tis_spi declaration
>    - added tpm_tis_spi_pre_save() function
> - fixed trace formatting string

Move this below your Signed-off-by after the dashes '---'

> 
> Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>

---

v3:
  - moved variable tis_addr from TPMStateSPI struct to local
  - added the VM suspend/resume support:
     - added vmstate_tpm_tis_spi declaration
     - added tpm_tis_spi_pre_save() function
  - fixed trace formatting string

> ---
>   docs/specs/tpm.rst   |  15 ++
>   include/sysemu/tpm.h |   3 +
>   hw/tpm/tpm_tis_spi.c | 360 +++++++++++++++++++++++++++++++++++++++++++
>   hw/tpm/Kconfig       |   6 +
>   hw/tpm/meson.build   |   1 +
>   hw/tpm/trace-events  |   7 +
>   6 files changed, 392 insertions(+)
>   create mode 100644 hw/tpm/tpm_tis_spi.c
> 
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index 1ad36ad709..63c3a43c7d 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -24,6 +24,7 @@ QEMU files related to TPM TIS interface:
>    - ``hw/tpm/tpm_tis_isa.c``
>    - ``hw/tpm/tpm_tis_sysbus.c``
>    - ``hw/tpm/tpm_tis_i2c.c``
> + - ``hw/tpm/tpm_tis_spi.c``
>    - ``hw/tpm/tpm_tis.h``
>   
>   Both an ISA device and a sysbus device are available. The former is
> @@ -33,6 +34,9 @@ Arm virt machine.
>   An I2C device support is also provided which can be instantiated in the Arm
>   based emulation machines. This device only supports the TPM 2 protocol.
>   
> +A Serial Peripheral Interface (SPI) device support has been added to the
> +PowerNV emulation machines. This device only supports the TPM 2 protocol.
> +
>   CRB interface
>   -------------
>   
> @@ -371,6 +375,17 @@ attached to I2C bus, use the following command line:
>   
>     echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device
>   
> +In case a PowerNV machine is emulated and you want to use a TPM device
> +attached to SPI bus, use the following command line (SPI bus master is
> +provided by PowerNV SPI device):
> +
> +.. code-block:: console
> +
> +  qemu-system-ppc64 -m 2G -machine powernv10 -nographic \
> +    -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
> +    -tpmdev emulator,id=tpm0,chardev=chrtpm \
> +    -device tpm-tis-spi,tpmdev=tpm0,bus=pnv-spi-bus.4
> +


If you move this a bit further up to after the 'pSeries machine' then we 
have the ppc64 stuff in one place.

>   In case SeaBIOS is used as firmware, it should show the TPM menu item
>   after entering the menu with 'ESC'.
>   
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 1ee568b3b6..22b05110e2 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -49,6 +49,7 @@ struct TPMIfClass {
>   #define TYPE_TPM_CRB                "tpm-crb"
>   #define TYPE_TPM_SPAPR              "tpm-spapr"
>   #define TYPE_TPM_TIS_I2C            "tpm-tis-i2c"
> +#define TYPE_TPM_TIS_SPI            "tpm-tis-spi"
>   
>   #define TPM_IS_TIS_ISA(chr)                         \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
> @@ -60,6 +61,8 @@ struct TPMIfClass {
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
>   #define TPM_IS_TIS_I2C(chr)                      \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_I2C)
> +#define TPM_IS_TIS_SPI(chr)                      \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SPI)
>   
>   /* returns NULL unless there is exactly one TPM device */
>   static inline TPMIf *tpm_find(void)
> diff --git a/hw/tpm/tpm_tis_spi.c b/hw/tpm/tpm_tis_spi.c
> new file mode 100644
> index 0000000000..4aee1c6d6c
> --- /dev/null
> +++ b/hw/tpm/tpm_tis_spi.c
> @@ -0,0 +1,360 @@
> +/*
> + * QEMU PowerPC SPI TPM 2.0 model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define IBM_PONQ
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/sysbus.h"
> +#include "hw/acpi/tpm.h"
> +#include "tpm_prop.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "tpm_tis.h"
> +#include "hw/ssi/ssi.h"
> +#include "migration/vmstate.h"
> +
> +typedef struct TPMStateSPI {
> +    /*< private >*/
> +    SSIPeripheral parent_object;
> +
> +    uint8_t     byte_offset;     /* byte offset in transfer */
> +    uint8_t     wait_state_cnt;  /* wait state counter */
> +    uint8_t     xfer_size;       /* data size of transfer */
> +    uint32_t    reg_addr;        /* register address of transfer */
> +
> +    uint8_t     spi_state;       /* READ / WRITE / IDLE */
> +#define SPI_STATE_IDLE   0
> +#define SPI_STATE_WRITE  1
> +#define SPI_STATE_READ   2
> +
> +    bool        command;
> +
> +    /*< public >*/
> +    TPMState    tpm_state;       /* not a QOM object */
> +
> +} TPMStateSPI;
> +
> +#define CMD_BYTE_WRITE          (1 << 7)
> +#define CMD_BYTE_XFER_SZ_MASK   0x1f
> +#define TIS_SPI_HIGH_ADDR_BYTE  0xd4
> +
> +DECLARE_INSTANCE_CHECKER(TPMStateSPI, TPM_TIS_SPI, TYPE_TPM_TIS_SPI)
> +
> +static int tpm_tis_spi_pre_save(void *opaque)
> +{
> +    TPMStateSPI *spist = opaque;
> +
> +    return tpm_tis_pre_save(&spist->tpm_state);
> +}
> +
> +static const VMStateDescription vmstate_tpm_tis_spi = {
> +     .name = "tpm-tis-spi",
> +     .version_id = 0,
> +     .pre_save  = tpm_tis_spi_pre_save,
> +     .fields = (const VMStateField[]) {
> +         VMSTATE_BUFFER(tpm_state.buffer, TPMStateSPI),
> +         VMSTATE_UINT16(tpm_state.rw_offset, TPMStateSPI),
> +         VMSTATE_UINT8(tpm_state.active_locty, TPMStateSPI),
> +         VMSTATE_UINT8(tpm_state.aborting_locty, TPMStateSPI),
> +         VMSTATE_UINT8(tpm_state.next_locty, TPMStateSPI),
> +
> +         VMSTATE_STRUCT_ARRAY(tpm_state.loc, TPMStateSPI,
> +                              TPM_TIS_NUM_LOCALITIES, 0,
> +                              vmstate_locty, TPMLocality),
> +
> +         /* spi specifics */
> +         VMSTATE_UINT8(byte_offset, TPMStateSPI),
> +         VMSTATE_UINT8(wait_state_cnt, TPMStateSPI),
> +         VMSTATE_UINT8(xfer_size, TPMStateSPI),
> +         VMSTATE_UINT32(reg_addr, TPMStateSPI),
> +         VMSTATE_UINT8(spi_state, TPMStateSPI),
> +         VMSTATE_BOOL(command, TPMStateSPI),
> +
> +         VMSTATE_END_OF_LIST()
> +     }
> +};
> +
> +static inline void tpm_tis_spi_clear_data(TPMStateSPI *spist)
> +{
> +    spist->spi_state = SPI_STATE_IDLE;
> +    spist->byte_offset = 0;
> +    spist->wait_state_cnt = 0;
> +    spist->xfer_size = 0;
> +    spist->reg_addr = 0;
> +
> +    return;
> +}
> +
> +/* Callback from TPM to indicate that response is copied */
> +static void tpm_tis_spi_request_completed(TPMIf *ti, int ret)
> +{
> +    TPMStateSPI *spist = TPM_TIS_SPI(ti);
> +    TPMState *s = &spist->tpm_state;
> +
> +    /* Inform the common code. */
> +    tpm_tis_request_completed(s, ret);
> +}
> +
> +static enum TPMVersion tpm_tis_spi_get_tpm_version(TPMIf *ti)
> +{
> +    TPMStateSPI *spist = TPM_TIS_SPI(ti);
> +    TPMState *s = &spist->tpm_state;
> +
> +    return tpm_tis_get_tpm_version(s);
> +}
> +
> +/*
> + * TCG PC Client Platform TPM Profile Specification for TPM 2.0 ver 1.05 rev 14
> + *
> + * For system Software, the TPM has a 64-bit address of 0x0000_0000_FED4_xxxx.
> + * On SPI, the chipset passes the least significant 24 bits to the TPM.
> + * The upper bytes will be used by the chipset to select the TPM’s SPI CS#
> + * signal. Table 9 shows the locality based on the 16 least significant address
> + * bits and assume that either the LPC TPM sync or SPI TPM CS# is used.
> + *
> + */
> +static void tpm_tis_spi_write(TPMStateSPI *spist, uint32_t addr, uint8_t val)
> +{
> +    TPMState *tpm_st = &spist->tpm_state;
> +
> +    trace_tpm_tis_spi_write(addr, val);
> +    tpm_tis_write_data(tpm_st, addr, val, 1);
> +}
> +
> +static uint8_t tpm_tis_spi_read(TPMStateSPI *spist, uint32_t addr)
> +{
> +    TPMState *tpm_st = &spist->tpm_state;
> +    uint8_t data;
> +
> +    data = tpm_tis_read_data(tpm_st, addr, 1);
> +    trace_tpm_tis_spi_read(addr, data);
> +    return data;
> +}
> +
> +static Property tpm_tis_spi_properties[] = {
> +    DEFINE_PROP_TPMBE("tpmdev", TPMStateSPI, tpm_state.be_driver),
> +    DEFINE_PROP_UINT32("irq", TPMStateSPI, tpm_state.irq_num, 0),

Please remove this line.

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void tpm_tis_spi_reset(DeviceState *dev)
> +{
> +    TPMStateSPI *spist = TPM_TIS_SPI(dev);
> +    TPMState *s = &spist->tpm_state;
> +
> +    tpm_tis_spi_clear_data(spist);
> +    return tpm_tis_reset(s);
> +}
> +
> +static uint32_t tpm_transfer(SSIPeripheral *ss, uint32_t tx)
> +{
> +    TPMStateSPI *spist = TPM_TIS_SPI(ss);
> +    uint32_t rx = 0;
> +    uint8_t byte;       /* reversed byte value */
> +    uint8_t offset = 0; /* offset of byte in payload */
> +    uint8_t index;      /* index of data byte in transfer */
> +    uint32_t tis_addr;  /* tis address including locty */
> +
> +    /* new transfer or not */
> +    if (spist->command) {   /* new transfer start */
> +        if (spist->spi_state != SPI_STATE_IDLE) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "unexpected new transfer\n");
> +        }
> +        spist->byte_offset = 0;
> +        spist->wait_state_cnt = 0;
> +    }
> +    /*
> +     * Explanation of wait_state:
> +     * The original TPM model did not have wait state or "flow control" support
> +     * built in.  If you wanted to read a TPM register through SPI you sent
> +     * the first byte with the read/write bit and size, then three address bytes
> +     * and any additional bytes after that were don't care bytes for reads and
> +     * the model would begin returning byte data to the SPI reader from the
> +     * register address provided.  In the real world this would mean that a
> +     * TPM device had only the time between the 31st clock and the 32nd clock
> +     * to fetch the register data that it had to provide to SPI MISO starting
> +     * with the 32nd clock.
> +     *
> +     * In reality the TPM begins introducing a wait state at the 31st clock
> +     * by holding MISO low.  This is how it controls the "flow" of the
> +     * operation. Once the data the TPM needs to return is ready it will
> +     * select bit 31 + (8*N) to send back a 1 which indicates that it will
> +     * now start returning data on MISO.
> +     *
> +     * The same wait states are applied to writes.  In either the read or write
> +     * case the wait state occurs between the command+address (4 bytes) and the
> +     * data (1-n bytes) sections of the SPI frame.  The code below introduces
> +     * the support for a 32 bit wait state for P10.  All reads and writes
> +     * through the SPI interface MUST now be aware of the need to do flow
> +     * control in order to use the TPM via SPI.
> +     *
> +     * In conjunction with these changes there were changes made to the SPIM
> +     * engine that was introduced in P10 to support the 6x op code which is
> +     * used to receive wait state 0s on the MISO line until it sees the b'1'
> +     * come back before continuing to read real data from the SPI device(TPM).
> +     */
> +
> +    trace_tpm_tis_spi_transfer_data("Payload byte_offset", spist->byte_offset);
> +    /* process payload data */
> +    while (offset < 4) {
> +        spist->command = false;
> +        byte = (tx >> (24 - 8 * offset)) & 0xFF;
> +        trace_tpm_tis_spi_transfer_data("Extracted byte", byte);
> +        trace_tpm_tis_spi_transfer_data("Payload offset", offset);
> +        switch (spist->byte_offset) {
> +        case 0:    /* command byte */
> +            if ((byte & CMD_BYTE_WRITE) == 0) {  /* bit-7 */
> +                spist->spi_state = SPI_STATE_WRITE;
> +                trace_tpm_tis_spi_transfer_event("spi write");
> +            } else {
> +                spist->spi_state = SPI_STATE_READ;
> +                trace_tpm_tis_spi_transfer_event("spi read");
> +            }
> +            spist->xfer_size = (byte & CMD_BYTE_XFER_SZ_MASK) + 1;
> +            trace_tpm_tis_spi_transfer_data("xfer_size", spist->xfer_size);
> +            break;
> +        case 1:     /* 1st address byte */
> +            if (byte != TIS_SPI_HIGH_ADDR_BYTE) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "incorrect high address 0x%x\n",
> +                              byte);
> +            }
> +            spist->reg_addr = byte << 16;
> +            trace_tpm_tis_spi_transfer_data("first addr byte", byte);
> +            trace_tpm_tis_spi_transfer_addr("reg_addr", spist->reg_addr);
> +            break;
> +        case 2:     /* 2nd address byte */
> +            spist->reg_addr |= byte << 8;
> +            trace_tpm_tis_spi_transfer_data("second addr byte", byte);
> +            trace_tpm_tis_spi_transfer_addr("reg_addr", spist->reg_addr);
> +            break;
> +        case 3:     /* 3rd address byte */
> +            spist->reg_addr |= byte;
> +            trace_tpm_tis_spi_transfer_data("third addr byte", byte);
> +            trace_tpm_tis_spi_transfer_addr("reg_addr", spist->reg_addr);
> +            break;
> +        default:    /* data bytes */
> +            if (spist->wait_state_cnt < 4) {
> +                spist->wait_state_cnt++;
> +                if (spist->wait_state_cnt == 4) {
> +                    trace_tpm_tis_spi_transfer_data("wait complete, count",
> +                                                     spist->wait_state_cnt);
> +                    rx = rx | (0x01 << (24 - offset * 8));
> +                    return rx;
> +                } else {
> +                    trace_tpm_tis_spi_transfer_data("in wait state, count",
> +                                                     spist->wait_state_cnt);
> +                    rx = 0;
> +                }
> +            } else {
> +                index = spist->byte_offset - 4;
> +                trace_tpm_tis_spi_transfer_data("index", index);
> +                trace_tpm_tis_spi_transfer_data("data byte", byte);
> +                trace_tpm_tis_spi_transfer_addr("reg_addr", spist->reg_addr);
> +                if (index >= spist->xfer_size) {
> +                    /*
> +                     * SPI SSI framework limits both rx and tx
> +                     * to fixed 4-byte with each xfer
> +                     */
> +                    trace_tpm_tis_spi_transfer_event("index exceeds xfer_size");
> +                    return rx;
> +                }
> +                tis_addr = spist->reg_addr + (index % 4);
> +                if (spist->spi_state == SPI_STATE_WRITE) {
> +                    tpm_tis_spi_write(spist, tis_addr, byte);
> +                } else {
> +                    byte = tpm_tis_spi_read(spist, tis_addr);
> +                    rx = rx | (byte << (24 - offset * 8));
> +                    trace_tpm_tis_spi_transfer_data("byte added to response",
> +                                                     byte);
> +                    trace_tpm_tis_spi_transfer_data("offset", offset);
> +                }
> +            }
> +            break;
> +        }
> +        if ((spist->wait_state_cnt == 0) || (spist->wait_state_cnt == 4)) {
> +            offset++;
> +            spist->byte_offset++;
> +        } else {
> +            break;
> +        }
> +    }
> +    return rx;
> +}
> +
> +static int tpm_cs(SSIPeripheral *ss, bool select)
> +{
> +    TPMStateSPI *spist = TPM_TIS_SPI(ss);
> +
> +    if (select) {
> +        spist->command = false;
> +        spist->spi_state = SPI_STATE_IDLE;
> +    } else {
> +        spist->command = true;
> +    }
> +    return 0;
> +}
> +
> +static void tpm_realize(SSIPeripheral *dev, Error **errp)
> +{
> +    TPMStateSPI *spist = TPM_TIS_SPI(dev);
> +    TPMState *s = &spist->tpm_state;
> +
> +    if (!tpm_find()) {
> +        error_setg(errp, "at most one TPM device is permitted");
> +        return;
> +    }
> +
> +    s->be_driver = qemu_find_tpm_be("tpm0");
> +
> +    if (!s->be_driver) {
> +        error_setg(errp, "unable to find tpm backend device");
> +        return;
> +    }
> +}
> +
> +static void tpm_tis_spi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    TPMIfClass *tc = TPM_IF_CLASS(klass);
> +    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
> +
> +    k->transfer = tpm_transfer;
> +    k->realize = tpm_realize;
> +    k->set_cs = tpm_cs;
> +    k->cs_polarity = SSI_CS_LOW;
> +
> +    device_class_set_legacy_reset(dc, tpm_tis_spi_reset);
> +    device_class_set_props(dc, tpm_tis_spi_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +
> +    dc->desc = "SPI TPM";
> +    dc->vmsd = &vmstate_tpm_tis_spi;
> +
> +    tc->model = TPM_MODEL_TPM_TIS;
> +    tc->request_completed = tpm_tis_spi_request_completed;
> +    tc->get_version = tpm_tis_spi_get_tpm_version;
> +}
> +
> +static const TypeInfo tpm_tis_spi_info = {
> +    .name          = TYPE_TPM_TIS_SPI,
> +    .parent        = TYPE_SSI_PERIPHERAL,
> +    .instance_size = sizeof(TPMStateSPI),
> +    .class_init    = tpm_tis_spi_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_TPM_IF },
> +        { }
> +    }
> +};
> +
> +static void tpm_tis_spi_register_types(void)
> +{
> +    type_register_static(&tpm_tis_spi_info);
> +}
> +
> +type_init(tpm_tis_spi_register_types)
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index a46663288c..5951c225cc 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -5,6 +5,12 @@ config TPM_TIS_I2C
>       select I2C
>       select TPM_TIS
>   
> +config TPM_TIS_SPI
> +    bool
> +    depends on TPM
> +    select TPM_BACKEND
> +    select TPM_TIS
> +
>   config TPM_TIS_ISA
>       bool
>       depends on TPM && ISA_BUS
> diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
> index 6968e60b3f..e03cfb11b9 100644
> --- a/hw/tpm/meson.build
> +++ b/hw/tpm/meson.build
> @@ -2,6 +2,7 @@ system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
> +system_ss.add(when: 'CONFIG_TPM_TIS_SPI', if_true: files('tpm_tis_spi.c'))
>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index fa882dfefe..0324ceb6d0 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -42,3 +42,10 @@ tpm_tis_i2c_recv(uint8_t data) "TPM I2C read: 0x%X"
>   tpm_tis_i2c_send(uint8_t data) "TPM I2C write: 0x%X"
>   tpm_tis_i2c_event(const char *event) "TPM I2C event: %s"
>   tpm_tis_i2c_send_reg(const char *name, int reg) "TPM I2C write register: %s(0x%X)"
> +
> +# tpm_tis_spi.c
> +tpm_tis_spi_write(uint32_t addr, uint8_t val) "TPM SPI write - addr:0x%08X 0x%02x"
> +tpm_tis_spi_read(uint32_t addr, uint8_t val) "TPM SPI read - addr:0x%08X 0x%02x"
> +tpm_tis_spi_transfer_event(const char *event) "TPM SPI XFER event: %s"
> +tpm_tis_spi_transfer_data(const char *name, uint8_t val) "TPM SPI XFER: %s = 0x%02x"
> +tpm_tis_spi_transfer_addr(const char *name, uint32_t addr) "TPM SPI XFER: %s = 0x%08x"


The rest looks good to me.


