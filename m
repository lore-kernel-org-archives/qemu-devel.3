Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DCDC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riceK-0000Xv-LR; Fri, 08 Mar 2024 11:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1riceJ-0000Xi-NE; Fri, 08 Mar 2024 11:00:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1riceG-0005wW-Dt; Fri, 08 Mar 2024 11:00:43 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428FWWpP025533; Fri, 8 Mar 2024 16:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=We/Qzl9uxtUwIKI0EH/TeMAUlGhDa3PAYbpRUFNepTI=;
 b=BWz2N5iHk+gjJVVcRhkJtUiMEruoLnAynRa+fMkmZocTanfUtqH4qf/gwXxi4NHzZlUU
 6hJ5VQC6HPBo/r10sWCRauyeRnUmeyddNnfWBCXjnTFxbvgQps9sNlx8yUT3vuepbGQ/
 oBslAGPPn93+PB3VHYvI+UZzRm6wcrGHpddjwfssxjriIukQk6CncNEj3DzgkakYfhiu
 GYFYpr8mHlLQB9ndh/gGubLWRIISao8sd1WyP/YlNqDWeyT3R3wkSRJkt1rAsoMY2hLU
 PsMaQ04jxoaDgYlpJH7HbXn7WefVCMdvX/SwE6wgYa9WptaNwl3LdJ1lU5wRvh8qMLDf Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr5dcgg77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 16:00:30 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428Fxo3n003656;
 Fri, 8 Mar 2024 16:00:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr5dcgg6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 16:00:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428DGOpA025376; Fri, 8 Mar 2024 16:00:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmeu05ge5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 16:00:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428G0Niu33751510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 16:00:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E015658056;
 Fri,  8 Mar 2024 16:00:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E15758070;
 Fri,  8 Mar 2024 16:00:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 16:00:21 +0000 (GMT)
Message-ID: <350fbdff-1fd6-43c2-a0e6-c20b2dc2e650@linux.ibm.com>
Date: Fri, 8 Mar 2024 11:00:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] hw/ppc: SPI responder model
Content-Language: en-US
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
 <20240207160833.3437779-2-chalapathi.v@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240207160833.3437779-2-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8Ieyp_2ceMGf1vOBGiZg__tFUvJTMFSa
X-Proofpoint-GUID: ISdFtABRE12SC3cLOCTVIIhAfMFl45Eb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/7/24 11:08, Chalapathi V wrote:
> Serial pheripheral interface provides full-duplex synchronous serial
> communication between single controller and multiple responder devices.
> One SPI Controller is implemented and supported on a SPI Bus, there is
> no support for multiple controllers on the SPI bus.
> 
> The current implemetation assumes that single responder is connected to
> bus, hence chip_select is not modelled.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/ppc/pnv_spi_responder.h | 109 +++++++++++++++++++
>   hw/ppc/pnv_spi_responder.c         | 166 +++++++++++++++++++++++++++++
>   hw/ppc/meson.build                 |   1 +
>   3 files changed, 276 insertions(+)
>   create mode 100644 include/hw/ppc/pnv_spi_responder.h
>   create mode 100644 hw/ppc/pnv_spi_responder.c
> 
> diff --git a/include/hw/ppc/pnv_spi_responder.h b/include/hw/ppc/pnv_spi_responder.h
> new file mode 100644
> index 0000000000..1cf7279aad
> --- /dev/null
> +++ b/include/hw/ppc/pnv_spi_responder.h
> @@ -0,0 +1,109 @@
> +/*
> + * QEMU SPI Responder.
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * SPI provides full-duplex synchronous serial communication between single
> + * controller and multiple responder devices. One SPI Controller is
> + * implemented and supported on a SPI Bus, there is no support for multiple

an SPI Bus

> + * controllers on the SPI bus.
> + *
> + * The current implementation assumes that single responder is connected to > + * bus, hence chip_select is not modelled.

to the bus, hence chip_select is not modeled.

> + */
> +
> +#ifndef PPC_PNV_SPI_RESPONDER_H
> +#define PPC_PNV_SPI_RESPONDER_H
> +
> +#include "hw/qdev-core.h"
> +#include "qom/object.h"
> +#include "qemu/log.h"
> +
> +#define TYPE_PNV_SPI_RESPONDER "spi-responder"
> +OBJECT_DECLARE_TYPE(PnvSpiResponder, PnvSpiResponderClass,
> +                    PNV_SPI_RESPONDER)
> +
> +typedef struct xfer_buffer xfer_buffer;
> +
> +struct PnvSpiResponderClass {
> +    DeviceClass parent_class;
> +
> +    /*
> +     * These methods are from controller to responder and implemented
> +     * by all responders.
> +     * Connect_controller/disconnect_controller methods are called by
> +     * controller to initiate/stop the SPI transfer.
> +     */
> +    void (*connect_controller)(PnvSpiResponder *responder, const char *port);
> +    void (*disconnect_controller)(PnvSpiResponder *responder);
> +    /*
> +     * SPI transfer consists of a number of consecutive calls to the request
> +     * method.
> +     * The parameter first is true on first call of the transfer and last is on
> +     * the final call of the transfer. Parameter bits and payload defines the
> +     * number of bits and data payload sent by controller.
> +     * Responder returns the response payload.
> +     */
> +    xfer_buffer *(*request)(PnvSpiResponder *responder, int first, int last,
> +                    int bits, xfer_buffer *payload);
> +};
> +
> +struct PnvSpiResponder {
> +    DeviceState parent_obj;
> +};
> +
> +#define TYPE_SPI_BUS "spi-bus"
> +OBJECT_DECLARE_SIMPLE_TYPE(SpiBus, SPI_BUS)
> +
> +struct SpiBus {
> +    BusState parent_obj;
> +};
> +
> +/*
> + * spi_realize_and_unref: realize and unref an SPI responder
> + * @dev: SPI responder to realize
> + * @bus: SPI bus to put it on
> + * @errp: error pointer
> + */
> +bool spi_realize_and_unref(DeviceState *dev, SpiBus *bus, Error **errp);
> +
> +/*
> + * spi_create_responder: create a SPI responder.

a -> an

> + * @bus: SPI bus to put it on
> + * @name: name of the responder object.
> + * call spi_realize_and_unref() after creating the responder.
> + */
> +
> +PnvSpiResponder *spi_create_responder(SpiBus *bus, const char *name);
> +
> +/* xfer_buffer */
> +typedef struct xfer_buffer {
> +
> +    uint32_t    len;
> +    uint8_t    *data;
> +
> +} xfer_buffer;
> +
> +/*
> + * xfer_buffer_read_ptr: Increment the payload length and return the pointer
> + * to the data at offset
> + */
> +uint8_t *xfer_buffer_write_ptr(xfer_buffer *payload, uint32_t offset,
> +                uint32_t length);
> +/* xfer_buffer_read_ptr: Return the pointer to the data at offset */
> +void xfer_buffer_read_ptr(xfer_buffer *payload, uint8_t **read_buf,
> +                uint32_t offset, uint32_t length);
> +/* xfer_buffer_new: Allocate memory and return the pointer */
> +xfer_buffer *xfer_buffer_new(void);
> +/* xfer_buffer_free: free the payload */
> +void xfer_buffer_free(xfer_buffer *payload);
> +
> +/* Controller interface */
> +SpiBus *spi_create_bus(DeviceState *parent, const char *name);
> +xfer_buffer *spi_request(SpiBus *bus, int first, int last, int bits,
> +                xfer_buffer *payload);
> +bool spi_connect_controller(SpiBus *bus, const char *port);
> +bool spi_disconnect_controller(SpiBus *bus);
> +#endif /* PPC_PNV_SPI_SEEPROM_H */
> diff --git a/hw/ppc/pnv_spi_responder.c b/hw/ppc/pnv_spi_responder.c
> new file mode 100644
> index 0000000000..c3bc659b1b
> --- /dev/null
> +++ b/hw/ppc/pnv_spi_responder.c
> @@ -0,0 +1,166 @@
> +/*
> + * QEMU PowerPC SPI Responder
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ppc/pnv_spi_responder.h"
> +#include "qapi/error.h"
> +
> +static const TypeInfo spi_bus_info = {
> +    .name = TYPE_SPI_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = sizeof(SpiBus),
> +};
> +
> +SpiBus *spi_create_bus(DeviceState *parent, const char *name)
> +{
> +    BusState *bus;

empty line after var decl

> +    bus = qbus_new(TYPE_SPI_BUS, parent, name);
> +    return SPI_BUS(bus);
> +}
> +
> +/* xfer_buffer_methods */
> +xfer_buffer *xfer_buffer_new(void)
> +{
> +    xfer_buffer *payload = g_malloc0(sizeof(*payload));

empty line after var decl

> +    payload->data = g_malloc0(payload->len * sizeof(uint8_t));

sizeof(uint8_t) doesn't seem necessary


> +    return payload;
> +}
> +
> +void xfer_buffer_free(xfer_buffer *payload)
> +{
> +    free(payload->data);
> +    payload->data = NULL;

not necessary to do this

> +    free(payload);
> +}
> +
> +uint8_t *xfer_buffer_write_ptr(xfer_buffer *payload, uint32_t offset,
> +                            uint32_t length)
> +{
> +    if (payload->len < (offset + length)) {
> +        payload->len = offset + length;
> +        payload->data = g_realloc(payload->data,
> +                        payload->len * sizeof(uint8_t));

sizeof(uint8_t)  does not seem necessary

> +    }
> +    return &payload->data[offset];
> +}
> +
> +void xfer_buffer_read_ptr(xfer_buffer *payload, uint8_t **read_buf,
> +                uint32_t offset, uint32_t length)
> +{
> +    static uint32_t prev_len;

Why do you keep prev_len around?

> +    uint32_t offset_org = offset;

empty line after var decl

> +    if (offset > payload->len) {
if (offset + length > payload->len) ?

> +        if (length < payload->len) {
> +            offset = payload->len - length;
> +        } else {
> +            offset = 0;
> +            length = payload->len;
> +        }

If the user passes in length (1000) and now you artificially lower it 
(10) he may assume he got 1000 bytes to read and end up reading over the 
end of the buffer in the end becasue there are only 10 bytes. I don't 
think you should neither adjust offset nor length but realloc (if at all 
necessary to do this here) to accomodate these values.

> +        qemu_log_mask(LOG_GUEST_ERROR, "Read offset(%d) exceeds buffer "
> +                        "length(%d), altered offset to %d and length to %d to "
> +                        "read within buffer\n", offset_org, payload->len,
> +                        offset, length);
> +    } else if ((offset + length) > payload->len) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Read length(%d) bytes from offset (%d)"
> +                        ", exceeds buffer length(%d)\n", length, offset,
> +                        payload->len);
> +        length = payload->len - offset;
> +    }
> +
> +    if ((prev_len != length) || (*read_buf == NULL)) {
> +        *read_buf = g_realloc(*read_buf, length * sizeof(uint8_t));
> +        prev_len = length;
> +    }
> +    *read_buf = &payload->data[offset];
> +}
> +
> +/* Controller interface methods */
> +bool spi_connect_controller(SpiBus *bus, const char *port)
> +{
> +    BusState *b = BUS(bus);
> +    BusChild *kid;

empty line

> +    QTAILQ_FOREACH(kid, &b->children, sibling) {
> +        PnvSpiResponder *r = PNV_SPI_RESPONDER(kid->child);
> +        PnvSpiResponderClass *rc = PNV_SPI_RESPONDER_GET_CLASS(r);

empty line

> +        rc->connect_controller(r, port);
> +        return true;

you didn't process the whole list but returned on the first element?

> +    }
> +    return false;
> +}
> +bool spi_disconnect_controller(SpiBus *bus)
> +{
> +    BusState *b = BUS(bus);
> +    BusChild *kid;

empty line

> +    QTAILQ_FOREACH(kid, &b->children, sibling) {
> +        PnvSpiResponder *r = PNV_SPI_RESPONDER(kid->child);
> +        PnvSpiResponderClass *rc = PNV_SPI_RESPONDER_GET_CLASS(r);
> +        rc->disconnect_controller(r);
> +        return true;

same comments here

> +    }
> +    return false;
> +}
> +
> +xfer_buffer *spi_request(SpiBus *bus,
> +                int first, int last, int bits, xfer_buffer *payload)
> +{
> +    BusState *b = BUS(bus);
> +    BusChild *kid;
> +    xfer_buffer *rsp_payload = NULL;
> +    uint8_t *buf = NULL;
> +
> +    QTAILQ_FOREACH(kid, &b->children, sibling) {
> +        PnvSpiResponder *r = PNV_SPI_RESPONDER(kid->child);
> +        PnvSpiResponderClass *rc = PNV_SPI_RESPONDER_GET_CLASS(r);
> +        rsp_payload = rc->request(r, first, last, bits, payload);
> +        return rsp_payload;

Also here you seem to stop processing in the first element.

> +    }
> +    if (rsp_payload == NULL) {
> +        rsp_payload = xfer_buffer_new();
> +    }
> +    buf = xfer_buffer_write_ptr(rsp_payload, 0, payload->len);
> +    memset(buf, 0, payload->len);
> +    return rsp_payload;
> +}
> +
> +/* create and realise spi responder device */
> +bool spi_realize_and_unref(DeviceState *dev, SpiBus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(dev, &bus->parent_obj, errp);
> +}
> +
> +PnvSpiResponder *spi_create_responder(SpiBus *bus, const char *name)
> +{
> +    DeviceState *dev = qdev_new(name);
> +
> +    spi_realize_and_unref(dev, bus, &error_fatal);
> +    return PNV_SPI_RESPONDER(dev);
> +}
> +
> +static void pnv_spi_responder_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "PowerNV SPI RESPONDER";
> +}
> +
> +static const TypeInfo pnv_spi_responder_info = {
> +    .name          = TYPE_PNV_SPI_RESPONDER,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(PnvSpiResponder),
> +    .class_init    = pnv_spi_responder_class_init,
> +    .abstract      = true,
> +    .class_size    = sizeof(PnvSpiResponderClass),
> +};
> +
> +static void pnv_spi_responder_register_types(void)
> +{
> +    type_register_static(&pnv_spi_responder_info);
> +    type_register_static(&spi_bus_info);
> +}
> +
> +type_init(pnv_spi_responder_register_types);
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index eba3406e7f..9bfd5a5613 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -53,6 +53,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
>     'pnv_bmc.c',
>     'pnv_homer.c',
>     'pnv_pnor.c',
> +  'pnv_spi_responder.c',
>   ))
>   # PowerPC 4xx boards
>   ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(

