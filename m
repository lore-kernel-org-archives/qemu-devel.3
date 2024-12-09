Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DB1E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 23:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnFe-000649-2Y; Mon, 09 Dec 2024 18:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnFb-00063x-DK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:33:15 -0500
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1tKnFZ-0006rP-61
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 18:33:15 -0500
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id ECE8940B44;
 Tue, 10 Dec 2024 00:33:09 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id pngUSLDKAAJg; Tue, 10 Dec 2024 00:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1733787187;
 bh=EzbKY9nIqZ8012Obi/YAYVMAjws5F2vHZfFm0qP7i90=;
 h=From:To:Cc:Subject:Date:From;
 b=Vy5qHy/kjOzHz5rzwHZdWQPzisjNQNt1GF6gsT/WAW1Z5NnqVxFTKM1ujVaVKSw9A
 hkKFxITIXyV8RHvbrClXKApO9w6krm51cVnoyOgzxl+VUyyVY7vtCY0zWJZySxj/LB
 qOHI+tqq12CNNoR8wK76oD3J50o9I2e0BszNt0lmzBjl5BTYYaffSogYpU6A5GpPde
 +nyB/x0mPDRuleYduhxnUrXNY3i3AGJ1/Ps5qxXLNqWsAmeONftmG3FgxLBOmi0P/d
 Z3/QQ2xODmapMey4f4uvFm+ROOAwmTjaF0tQwtr6cSZaWbbUQ/v4TVFDBzB7iowYNx
 jkNmZKGh9OCzw==
Received: from fel.cvut.cz (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5164340D1D;
 Tue, 10 Dec 2024 00:33:07 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [RFC/WIP 0/3] WIP CTU CAN FD IP core mapping to the platform bus
Date: Tue, 10 Dec 2024 00:32:50 +0100
Message-Id: <cover.1733783500.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Hello Peter, Gustavo and others,

our CTU CAN FD IP core is used on many FPGA platforms
and has been even tapeout on some other university
and even prototypes of the massive production chips
(support for that organized by our former student
in his company).

But actual QEMU emulation targets only PCI/PCIe mapping in

  hw/net/can/ctucan_pci.c

of the core in

  hw/net/can/ctucan_core.c

I would like to add support to map the core at fixed position for
SoCs and command line controlled location for FPGA targets.

I have working proof of concept on the branch net-can-ctucanfd-platform/

  https://github.com/ppisa/qemu/commits/net-can-ctucanfd-platform/

But I am sure that IRQ delivery should be cleaned and even for PCI/PCIe
the logical OR function should be added into delivery of interrupts
from individual cores to the IRQ on platform or PCI/PCIe level

The code at this moment:

hw/net/can/ctucan_core.h

typedef struct CtuCanCoreState {
...
    qemu_irq        irq;
    CanBusClientState bus_client;
} CtuCanCoreState;


hw/net/can/ctucan_core.c:
int ctucan_init(CtuCanCoreState *s, qemu_irq irq)
{
    s->irq = irq;

    qemu_irq_lower(s->irq);

    ctucan_hardware_reset(s);

    return 0;
}

static void ctucan_update_irq(CtuCanCoreState *s)
{
...
    if (s->int_stat.u32 & s->int_ena.u32) {
        qemu_irq_raise(s->irq);
    } else {
        qemu_irq_lower(s->irq);
    }
}

Memory mapping of the core
hw/net/can/ctucan_mm.c:

struct CtuCanMmState {
    /*< private >*/
    SysBusDevice    parent_obj;
    /*< public >*/

    struct {
        uint64_t    iobase;
        uint32_t    irqnum;
        char        *irqctrl;
    } cfg;

    MemoryRegion    ctucan_io_region;

    CtuCanCoreState ctucan_state[CTUCAN_MM_CORE_COUNT];
    qemu_irq        irq;

    char            *model;
    CanBusState     *canbus[CTUCAN_MM_CORE_COUNT];
};

and qemu_irq value is propagated into CTU CAN FD cores
in

hw/net/can/ctucan_mm.c:
static void ctucan_mm_realize(DeviceState *dev, Error **errp)
{
    CtuCanMmState *d = CTUCAN_MM_DEV(dev);
    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
    int i;
...
    /* memory_region_add_subregion(get_system_memory(), 0x43c30000, &d->ctucan_io_region); */
    if (d->cfg.iobase != 0) {
        sysbus_mmio_map(sbd, 0, d->cfg.iobase);
    }
    if (d->cfg.irqnum != 0) {
        //const char *id = "/machine/unattached/device[3]/gic";
        //const char *id = "/machine/unattached/device[3]";
        char *id = d->cfg.irqctrl;

        if (!id) {
            error_setg(errp, "irqctrl object path is mandatory when irqnum is specified");
            return;
        }

        Object *obj = object_resolve_path_at(container_get(qdev_get_machine(), "/peripheral"), id);
        DeviceState *gicdev;
        if (!obj) {
            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Device '%s' not found", id);
            return;
        }
        gicdev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
        if (!gicdev) {
            error_setg(errp, "%s is not a hotpluggable device", id);
            return;
        }
        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(gicdev, d->cfg.irqnum));
    }
    for (i = 0 ; i < CTUCAN_MM_CORE_COUNT; i++) {
        ctucan_init(&d->ctucan_state[i], d->irq);
    }
}

There is magic how to obtain interrupt controller object
of the SoC. I have found that next parameters are working
for Xilinx Zynq platform

qemu-system-arm -m 1G -M xilinx-zynq-a9 \
      -kernel kernel-zynq \
      -dtb zynq-microzed-uart1-2x-xcan-4x-ctu-axi.dtb \
      -initrd ramdisk.cpio \
      -serial null -serial mon:stdio \
      -nographic \
      -object can-bus,id=canbus0-bus \
      -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
      -device ctucan_mm,iobase=0x43c30000,irqnum=29,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \
      -device ctucan_mm,iobase=0x43c70000,irqnum=30,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \
      -device ctucan_mm,iobase=0x43bf0000,irqnum=31,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \
      -device ctucan_mm,iobase=0x43bb0000,irqnum=32,irqctrl=/machine/unattached/device[3],canbus=canbus0-bus \

But in general, I am not sure if copying of qemu_irq object
(s->irq = irq;) is correct according to the conventions and
I would like more some solution which allows to process/combine
multiple requests in some callback on the level of PCI/PCIe
or platform level integration object before passing to the
parent bus/interrupt controller level. 

Pavel Pisa (3):
  hw/net/can: WIP CTU CAN FD IP core mapping to the platform bus
  hw/net/can: WIP CTU CAN FD mapping of IRQ for platform device solved.
  hw/net/can: WIP CTU CAN FD add parameter to specify IRQ controller on
    command line

 hw/arm/xilinx_zynq.c   |   1 +
 hw/net/can/ctucan_mm.c | 291 +++++++++++++++++++++++++++++++++++++++++
 hw/net/can/meson.build |   1 +
 3 files changed, 293 insertions(+)
 create mode 100644 hw/net/can/ctucan_mm.c

-- 
2.39.5


