Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjcRI-0008PM-CM; Mon, 11 Mar 2024 05:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.sharikhin@yadro.com>)
 id 1rjcQx-0008HI-0t
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:59:08 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d.sharikhin@yadro.com>)
 id 1rjcQX-0002fr-SM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 05:59:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 2F293C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1710151112; bh=48r+OmcVNv61eDUBdgnRCAe1Mk4A0ie2SyiJZO/jMsI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=tTF8uNOshqre/A7xdae08a494JIGSlfy5NghSB/vDtis9KcuHjl/83MCM05fT7Y7k
 LZN0/z+8s8n0LNN43JAd0/zvCz+QryOiEMDRUQpJl4S2OpGmcgffxyrwaCmMX22H8Y
 Psr3ptavfLl7l+PLhFWtVXSLaMvkDEaF1wBFrYm/3BwYCkIQ+IMxh/k+zA7s3/r78d
 3Ps32JJC5Y5ok8c90iDH8J4giuhdJIQfp7vSipMubnBDK3N0WoD8cRBOeYVrTc+X39
 U8bCLQtelARRNx8LlFxOm7ogwm6glf43cdsv16zZq5CHSoMMC1PpxMFuq5OA2HMx4R
 h66Z7F7eynEqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1710151112; bh=48r+OmcVNv61eDUBdgnRCAe1Mk4A0ie2SyiJZO/jMsI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=fgrXB2pkdC/+sSY/FRbTq3edxAHZBkugyQk9pv8VuLD13n8QJ/NCvWAeOTlcsFaNv
 2Xmf+OSs+LL5KmHsGdpCNbAkuzfyiD6laa50XhXwmqW89iCsxqSFAeY3euXror1D3c
 vXsLkG1J/tSKk2ydSbtiOH8rVbTAvD0H5QbspEo/3aR/R/1NZR8Yu//G2mR1T1GiVy
 ixjoMO0eUqF1hmTh6RJ+wbhlDLNdZw7A+8qRh0K5vVqPB27jSfCU39booCh6EiuhmB
 rNQqMR6ktKw3LtzzSL7wZ0KN3CYWd4pErp8iYFFSEzDk7Z9CLeWoyP5EBRcTUms0yP
 tuxn25rmXslvA==
From: Dmitriy Sharikhin <d.sharikhin@yadro.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Igor Kononenko <i.kononenko@yadro.com>, "Alexander A. Filippov"
 <a.filippov@yadro.com>, Alexander Amelkin <a.amelkin@yadro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Subject: [PATCH v3] hw: gpio: introduce pcf8574 driver
Thread-Topic: [PATCH v3] hw: gpio: introduce pcf8574 driver
Thread-Index: AQHac5qsW7YpATGLKkSWCq/H0/dwHg==
Date: Mon, 11 Mar 2024 09:58:31 +0000
Message-ID: <f1552d822276e878d84c01eba2cf2c7c9ebdde00.camel@yadro.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-7"
Content-ID: <F0EAB8CA4D9AC54DB7A9DFF01687A28E@yadro.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=89.207.88.248; envelope-from=d.sharikhin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

NXP PCF8574 and compatible ICs are simple I2C GPIO expanders.
PCF8574 incorporates quasi-bidirectional IO, and simple
communication protocol, when IO read is I2C byte read, and
IO write is I2C byte write. User can think of it as
open-drain port, when line high state is input and line low
state is output.

Signed-off-by: Dmitrii Sharikhin +ADw-d.sharikhin+AEA-yadro.com+AD4-
---
 MAINTAINERS               +AHw-   6 +-+-
 hw/gpio/Kconfig           +AHw-   4 +-
 hw/gpio/meson.build       +AHw-   1 +-
 hw/gpio/pcf8574.c         +AHw- 162 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 include/hw/gpio/pcf8574.h +AHw-  15 +-+-+-+-
 5 files changed, 188 insertions(+-)
 create mode 100644 hw/gpio/pcf8574.c
 create mode 100644 include/hw/gpio/pcf8574.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d96f855de..72c23e3682 100644
--- a/MAINTAINERS
+-+-+- b/MAINTAINERS
+AEAAQA- -2503,6 +-2503,12 +AEAAQA- S: Maintained
 F: hw/i2c/i2c+AF8-mux+AF8-pca954x.c
 F: include/hw/i2c/i2c+AF8-mux+AF8-pca954x.h
=20
+-pcf8574
+-M: Dmitrii Sharikhin +ADw-d.sharikhin+AEA-yadro.com+AD4-
+-S: Maintained
+-F: hw/gpio/pcf8574.c
+-F: include/gpio/pcf8574.h
+-
 Generic Loader
 M: Alistair Francis +ADw-alistair+AEA-alistair23.me+AD4-
 S: Maintained
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 712940b8e0..19c97cc823 100644
--- a/hw/gpio/Kconfig
+-+-+- b/hw/gpio/Kconfig
+AEAAQA- -19,3 +-19,7 +AEAAQA- config SIFIVE+AF8-GPIO
=20
 config STM32L4X5+AF8-GPIO
     bool
+-
+-config PCF8574
+-    bool
+-    depends on I2C
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 3454b503ae..791e93a97b 100644
--- a/hw/gpio/meson.build
+-+-+- b/hw/gpio/meson.build
+AEAAQA- -16,3 +-16,4 +AEAAQA- system+AF8-ss.add(when: 'CONFIG+AF8-RASPI', =
if+AF8-true: files(
 system+AF8-ss.add(when: 'CONFIG+AF8-STM32L4X5+AF8-SOC', if+AF8-true: files=
('stm32l4x5+AF8-gpio.c'))
 system+AF8-ss.add(when: 'CONFIG+AF8-ASPEED+AF8-SOC', if+AF8-true: files('a=
speed+AF8-gpio.c'))
 system+AF8-ss.add(when: 'CONFIG+AF8-SIFIVE+AF8-GPIO', if+AF8-true: files('=
sifive+AF8-gpio.c'))
+-system+AF8-ss.add(when: 'CONFIG+AF8-PCF8574', if+AF8-true: files('pcf8574=
.c'))
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
new file mode 100644
index 0000000000..d37909e2ad
--- /dev/null
+-+-+- b/hw/gpio/pcf8574.c
+AEAAQA- -0,0 +-1,162 +AEAAQA-
+-/+ACo- SPDX-License-Identifier: GPL-2.0-only +ACo-/
+-
+-/+ACo-
+- +ACo- NXP PCF8574 8-port I2C GPIO expansion chip.
+- +ACo- Copyright (c) 2024 KNS Group (YADRO).
+- +ACo- Written by Dmitrii Sharikhin +ADw-d.sharikhin+AEA-yadro.com+AD4-
+- +ACo-/
+-
+-+ACM-include +ACI-qemu/osdep.h+ACI-
+-+ACM-include +ACI-hw/i2c/i2c.h+ACI-
+-+ACM-include +ACI-hw/gpio/pcf8574.h+ACI-
+-+ACM-include +ACI-hw/irq.h+ACI-
+-+ACM-include +ACI-migration/vmstate.h+ACI-
+-+ACM-include +ACI-qemu/log.h+ACI-
+-+ACM-include +ACI-qemu/module.h+ACI-
+-+ACM-include +ACI-qom/object.h+ACI-
+-
+-/+ACo-
+- +ACo- PCF8574 and compatible chips incorporate quasi-bidirectional
+- +ACo- IO. Electrically it means that device sustain pull-up to line
+- +ACo- unless IO port is configured as output +AF8-and+AF8- driven low.
+- +ACo-
+- +ACo- IO access is implemented as simple I2C single-byte read
+- +ACo- or write operation. So, to configure line to input user write 1
+- +ACo- to corresponding bit. To configure line to output and drive it low
+- +ACo- user write 0 to corresponding bit.
+- +ACo-
+- +ACo- In essence, user can think of quasi-bidirectional IO as
+- +ACo- open-drain line, except presence of builtin rising edge accelerati=
on
+- +ACo- embedded in PCF8574 IC
+- +ACo-
+- +ACo- PCF8574 has interrupt request line, which is being pulled down whe=
n
+- +ACo- port line state differs from last read. Port read operation clears
+- +ACo- state and INT line returns to high state via pullup.
+- +ACo-/
+-
+-OBJECT+AF8-DECLARE+AF8-SIMPLE+AF8-TYPE(PCF8574State, PCF8574)
+-
+-+ACM-define PORTS+AF8-COUNT (8)
+-
+-struct PCF8574State +AHs-
+-    I2CSlave parent+AF8-obj+ADs-
+-    uint8+AF8-t  lastrq+ADs-     /+ACo- Last requested state. If changed =
- assert irq +ACo-/
+-    uint8+AF8-t  input+ADs-      /+ACo- external electrical line state +A=
Co-/
+-    uint8+AF8-t  output+ADs-     /+ACo- Pull-up (1) or drive low (0) on b=
it +ACo-/
+-    qemu+AF8-irq handler+AFs-PORTS+AF8-COUNT+AF0AOw-
+-    qemu+AF8-irq intrq+ADs-      /+ACo- External irq request +ACo-/
+-+AH0AOw-
+-
+-static void pcf8574+AF8-reset(DeviceState +ACo-dev)
+-+AHs-
+-    PCF8574State +ACo-s +AD0- PCF8574(dev)+ADs-
+-    s-+AD4-lastrq +AD0- MAKE+AF8-64BIT+AF8-MASK(0, PORTS+AF8-COUNT)+ADs-
+-    s-+AD4-input  +AD0- MAKE+AF8-64BIT+AF8-MASK(0, PORTS+AF8-COUNT)+ADs-
+-    s-+AD4-output +AD0- MAKE+AF8-64BIT+AF8-MASK(0, PORTS+AF8-COUNT)+ADs-
+-+AH0-
+-
+-static inline uint8+AF8-t pcf8574+AF8-line+AF8-state(PCF8574State +ACo-s)
+-+AHs-
+-    /+ACo- we driving line low or external circuit does that +ACo-/
+-    return s-+AD4-input +ACY- s-+AD4-output+ADs-
+-+AH0-
+-
+-static uint8+AF8-t pcf8574+AF8-rx(I2CSlave +ACo-i2c)
+-+AHs-
+-    PCF8574State +ACo-s +AD0- PCF8574(i2c)+ADs-
+-    uint8+AF8-t linestate +AD0- pcf8574+AF8-line+AF8-state(s)+ADs-
+-    if (s-+AD4-lastrq +ACEAPQ- linestate) +AHs-
+-        s-+AD4-lastrq +AD0- linestate+ADs-
+-        if (s-+AD4-intrq) +AHs-
+-            qemu+AF8-set+AF8-irq(s-+AD4-intrq, 1)+ADs-
+-        +AH0-
+-    +AH0-
+-    return linestate+ADs-
+-+AH0-
+-
+-static int pcf8574+AF8-tx(I2CSlave +ACo-i2c, uint8+AF8-t data)
+-+AHs-
+-    PCF8574State +ACo-s +AD0- PCF8574(i2c)+ADs-
+-    uint8+AF8-t prev+ADs-
+-    uint8+AF8-t diff+ADs-
+-    uint8+AF8-t actual+ADs-
+-    int line +AD0- 0+ADs-
+-
+-    prev +AD0- pcf8574+AF8-line+AF8-state(s)+ADs-
+-    s-+AD4-output +AD0- data+ADs-
+-    actual +AD0- pcf8574+AF8-line+AF8-state(s)+ADs-
+-
+-    for (diff +AD0- (actual +AF4- prev)+ADs- diff+ADs- diff +ACYAPQ- +AH4=
-(1 +ADwAPA- line)) +AHs-
+-        line +AD0- ctz32(diff)+ADs-
+-        if (s-+AD4-handler+AFs-line+AF0-) +AHs-
+-            qemu+AF8-set+AF8-irq(s-+AD4-handler+AFs-line+AF0-, (actual +A=
D4APg- line) +ACY- 1)+ADs-
+-        +AH0-
+-    +AH0-
+-
+-    if (s-+AD4-intrq) +AHs-
+-        qemu+AF8-set+AF8-irq(s-+AD4-intrq, actual +AD0APQ- s-+AD4-lastrq)=
+ADs-
+-    +AH0-
+-
+-    return 0+ADs-
+-+AH0-
+-
+-static const VMStateDescription vmstate+AF8-pcf8574 +AD0- +AHs-
+-    .name               +AD0- +ACI-pcf8574+ACI-,
+-    .version+AF8-id         +AD0- 0,
+-    .minimum+AF8-version+AF8-id +AD0- 0,
+-    .fields +AD0- (VMStateField+AFsAXQ-) +AHs-
+-        VMSTATE+AF8-I2C+AF8-SLAVE(parent+AF8-obj, PCF8574State),
+-        VMSTATE+AF8-UINT8(lastrq, PCF8574State),
+-        VMSTATE+AF8-UINT8(input,  PCF8574State),
+-        VMSTATE+AF8-UINT8(output, PCF8574State),
+-        VMSTATE+AF8-END+AF8-OF+AF8-LIST()
+-    +AH0-
+-+AH0AOw-
+-
+-static void pcf8574+AF8-gpio+AF8-set(void +ACo-opaque, int line, int leve=
l)
+-+AHs-
+-    PCF8574State +ACo-s +AD0- (PCF8574State +ACo-) opaque+ADs-
+-    assert(line +AD4APQ- 0 +ACYAJg- line +ADw- ARRAY+AF8-SIZE(s-+AD4-hand=
ler))+ADs-
+-
+-    if (level) +AHs-
+-        s-+AD4-input +AHwAPQ-  (1 +ADwAPA- line)+ADs-
+-    +AH0- else +AHs-
+-        s-+AD4-input +ACYAPQ- +AH4-(1 +ADwAPA- line)+ADs-
+-    +AH0-
+-
+-    if (pcf8574+AF8-line+AF8-state(s) +ACEAPQ- s-+AD4-lastrq +ACYAJg- s-+=
AD4-intrq) +AHs-
+-        qemu+AF8-set+AF8-irq(s-+AD4-intrq, 0)+ADs-
+-    +AH0-
+-+AH0-
+-
+-static void pcf8574+AF8-realize(DeviceState +ACo-dev, Error +ACoAKg-errp)
+-+AHs-
+-    PCF8574State +ACo-s +AD0- PCF8574(dev)+ADs-
+-
+-    qdev+AF8-init+AF8-gpio+AF8-in(dev, pcf8574+AF8-gpio+AF8-set, ARRAY+AF=
8-SIZE(s-+AD4-handler))+ADs-
+-    qdev+AF8-init+AF8-gpio+AF8-out(dev, s-+AD4-handler, ARRAY+AF8-SIZE(s-=
+AD4-handler))+ADs-
+-    qdev+AF8-init+AF8-gpio+AF8-out+AF8-named(dev, +ACY-s-+AD4-intrq, +ACI=
-nINT+ACI-, 1)+ADs-
+-+AH0-
+-
+-static void pcf8574+AF8-class+AF8-init(ObjectClass +ACo-klass, void +ACo-=
data)
+-+AHs-
+-    DeviceClass   +ACo-dc +AD0- DEVICE+AF8-CLASS(klass)+ADs-
+-    I2CSlaveClass +ACo-k  +AD0- I2C+AF8-SLAVE+AF8-CLASS(klass)+ADs-
+-
+-    k-+AD4-recv     +AD0- pcf8574+AF8-rx+ADs-
+-    k-+AD4-send     +AD0- pcf8574+AF8-tx+ADs-
+-    dc-+AD4-realize +AD0- pcf8574+AF8-realize+ADs-
+-    dc-+AD4-reset   +AD0- pcf8574+AF8-reset+ADs-
+-    dc-+AD4-vmsd    +AD0- +ACY-vmstate+AF8-pcf8574+ADs-
+-+AH0-
+-
+-static const TypeInfo pcf8574+AF8-infos+AFsAXQ- +AD0- +AHs-
+-    +AHs-
+-        .name          +AD0- TYPE+AF8-PCF8574,
+-        .parent        +AD0- TYPE+AF8-I2C+AF8-SLAVE,
+-        .instance+AF8-size +AD0- sizeof(PCF8574State),
+-        .class+AF8-init    +AD0- pcf8574+AF8-class+AF8-init,
+-    +AH0-
+-+AH0AOw-
+-
+-DEFINE+AF8-TYPES(pcf8574+AF8-infos)+ADs-
diff --git a/include/hw/gpio/pcf8574.h b/include/hw/gpio/pcf8574.h
new file mode 100644
index 0000000000..3291d7dbbc
--- /dev/null
+-+-+- b/include/hw/gpio/pcf8574.h
+AEAAQA- -0,0 +-1,15 +AEAAQA-
+-/+ACo- SPDX-License-Identifier: GPL-2.0-only +ACo-/
+-
+-/+ACo-
+- +ACo- NXP PCF8574 8-port I2C GPIO expansion chip.
+- +ACo-
+- +ACo- Copyright (c) 2024 KNS Group (YADRO).
+- +ACo- Written by Dmitrii Sharikhin +ADw-d.sharikhin+AEA-yadro.com+AD4-
+- +ACo-/
+-
+-+ACM-ifndef +AF8-HW+AF8-GPIO+AF8-PCF8574
+-+ACM-define +AF8-HW+AF8-GPIO+AF8-PCF8574
+-
+-+ACM-define TYPE+AF8-PCF8574 +ACI-pcf8574+ACI-
+-
+-+ACM-endif /+ACo- +AF8-HW+AF8-GPIO+AF8-PCF8574 +ACo-/

