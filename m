Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A23CC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 17:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhYD6-0006xg-VA; Tue, 05 Mar 2024 12:04:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rhYD4-0006wr-JB; Tue, 05 Mar 2024 12:04:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rhYD1-0004kI-MD; Tue, 05 Mar 2024 12:04:10 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 425H02Gh011397; Tue, 5 Mar 2024 17:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=m4BPA8u7bSKE1YtrL4shg+LNYFkn3OanIG7XKMeI+aE=;
 b=LgN9QK1vdnOcRo0Y/L+P/jnigaIE/GTxZwDJnLMmYnD2EpNVu0Sa9q1ctD7c9eWkEpnQ
 RAO9PKxT1r0J/rRs45rB+7ERGUVj3AU0ZY/ytKqliDunArFR4PbSaQ+FmRRl2zFxBklg
 5yVb4dLPk9xnKeF2zBNuUwzML5Hy1Zpdgv3jiivbJ33E3CPw0AZl7SFq0u9PBnq6C/d0
 BG74RQ2uHMdCgLn4u2e7UN7VrTIFuKwkNYm+9uSvGJASUcrY+DndjTOCZnykCtT/0OFI
 CUVSumNCo4f7Jn8TENV5nrTKOYMgdFQIISzWLR2lodI6lZjliE5lY5v7Smhiq0nkI/78 /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp7ddr4y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 17:04:00 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 425H01th011051;
 Tue, 5 Mar 2024 17:04:00 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wp7ddr4xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 17:04:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 425F10x8010877; Tue, 5 Mar 2024 17:03:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh528gsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Mar 2024 17:03:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 425H3uCJ30933460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Mar 2024 17:03:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A73785805A;
 Tue,  5 Mar 2024 17:03:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B7B45803F;
 Tue,  5 Mar 2024 17:03:56 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Mar 2024 17:03:56 +0000 (GMT)
Message-ID: <a2f0fd7189f1afb8a5edec3032b642fa58ccc501.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 7/9] misc: Add a pca9554 GPIO device model
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, =?ISO-8859-1?Q?Fr=E9d=E9ric?=
 Barrat <fbarrat@linux.ibm.com>, Reza Arbab <arbab@linux.ibm.com>
Date: Tue, 05 Mar 2024 11:03:56 -0600
In-Reply-To: <1a40d19d-993f-4820-b839-95b17c31a703@kaod.org>
References: <20240125224818.146499-1-milesg@linux.vnet.ibm.com>
 <20240125224818.146499-8-milesg@linux.vnet.ibm.com>
 <e818c2ac-149f-4767-bb5a-53501729762d@redhat.com>
 <1a40d19d-993f-4820-b839-95b17c31a703@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JqNTH0Nbe5bvLz-iEDfDWQ2P9xef85i3
X-Proofpoint-GUID: Sd2Zb9cJQ9exUkVT2JT-ilYIKzjKrgL_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050137
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Tue, 2024-03-05 at 07:20 +0100, Cédric Le Goater wrote:
> On 3/4/24 23:32, Paolo Bonzini wrote:
> > On 1/25/24 23:48, Glenn Miles wrote:
> > > Specs are available here:
> > > 
> > >      https://www.nxp.com/docs/en/data-sheet/PCA9554_9554A.pdf
> > > 
> > > This is a simple model supporting the basic registers for GPIO
> > > mode.  The device also supports an interrupt output line but the
> > > model does not yet support this.
> > > 
> > > Reviewed-by: Cédric Le Goater <clg@kaod.org>
> > > Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > ---
> > > 
> > > No changes from previous version
> > > 
> > >   MAINTAINERS                    |  10 +-
> > >   hw/misc/pca9554.c              | 328
> > > +++++++++++++++++++++++++++++++++
> > 
> > Not a huge deal, but this should have been in hw/gpio.
> 
> I started by putting the pca9552 model under misc :/
> 
> Glenn,
> 
> FYI, there are 2 issues reported by Coverity. See below. May be we
> could
> move both files under gpio while at it ?
> 
> Thanks,
> 
> C.
> 
> 

Sure, I'll get to that as soon as I can.

Glenn

> 
> ** CID 1534919:  Error handling issues  (CHECKED_RETURN)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 171 in pca9554_get_pin()
> 
> 
> _____________________________________________________________________
> ___________________________________
> *** CID 1534919:  Error handling issues  (CHECKED_RETURN)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 171 in pca9554_get_pin()
> 165             return;
> 166         }
> 167
> 168         state = pca9554_read(s, PCA9554_CONFIG);
> 169         state |= pca9554_read(s, PCA9554_OUTPUT);
> 170         state = (state >> pin) & 0x1;
> > > >     CID 1534919:  Error handling issues  (CHECKED_RETURN)
> > > >     Calling "visit_type_str" without checking return value (as
> > > > is done elsewhere 689 out of 740 times).
> 171         visit_type_str(v, name, (char **)&pin_state[state],
> errp);
> 172     }
> 173
> 174     static void pca9554_set_pin(Object *obj, Visitor *v, const
> char *name,
> 175                                 void *opaque, Error **errp)
> 176     {
> 
> 
> 
> 
> ** CID 1534917:  Integer handling issues  (BAD_SHIFT)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 170 in pca9554_get_pin()
> 
> 
> _____________________________________________________________________
> ___________________________________
> *** CID 1534917:  Integer handling issues  (BAD_SHIFT)
> /builds/bonzini/qemu/hw/misc/pca9554.c: 170 in pca9554_get_pin()
> 164             error_setg(errp, "%s invalid pin %s", __func__,
> name);
> 165             return;
> 166         }
> 167
> 168         state = pca9554_read(s, PCA9554_CONFIG);
> 169         state |= pca9554_read(s, PCA9554_OUTPUT);
> > > >     CID 1534917:  Integer handling issues  (BAD_SHIFT)
> > > >     In expression "state >> pin", right shifting "state" by
> > > > more than 7 bits always yields zero.  The shift amount, "pin",
> > > > is as much as 8.
> 170         state = (state >> pin) & 0x1;
> 171         visit_type_str(v, name, (char **)&pin_state[state],
> errp);
> 172     }
> 173
> 174     static void pca9554_set_pin(Object *obj, Visitor *v, const
> char *name,
> 175                                 void *opaque, Error **errp)
> 
> 
> 
> > Paolo
> > 
> > >   include/hw/misc/pca9554.h      |  36 ++++
> > >   include/hw/misc/pca9554_regs.h |  19 ++
> > >   4 files changed, 391 insertions(+), 2 deletions(-)
> > >   create mode 100644 hw/misc/pca9554.c
> > >   create mode 100644 include/hw/misc/pca9554.h
> > >   create mode 100644 include/hw/misc/pca9554_regs.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index dfaca8323e..51861e3c7d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1169,9 +1169,7 @@ R: Joel Stanley <joel@jms.id.au>
> > >   L: qemu-arm@nongnu.org
> > >   S: Maintained
> > >   F: hw/*/*aspeed*
> > > -F: hw/misc/pca9552.c
> > >   F: include/hw/*/*aspeed*
> > > -F: include/hw/misc/pca9552*.h
> > >   F: hw/net/ftgmac100.c
> > >   F: include/hw/net/ftgmac100.h
> > >   F: docs/system/arm/aspeed.rst
> > > @@ -1540,6 +1538,14 @@ F: include/hw/pci-host/pnv*
> > >   F: pc-bios/skiboot.lid
> > >   F: tests/qtest/pnv*
> > > +pca955x
> > > +M: Glenn Miles <milesg@linux.vnet.ibm.com>
> > > +L: qemu-ppc@nongnu.org
> > > +L: qemu-arm@nongnu.org
> > > +S: Odd Fixes
> > > +F: hw/misc/pca955*.c
> > > +F: include/hw/misc/pca955*.h
> > > +
> > >   virtex_ml507
> > >   M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> > >   L: qemu-ppc@nongnu.org
> > > diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
> > > new file mode 100644
> > > index 0000000000..778b32e443
> > > --- /dev/null
> > > +++ b/hw/misc/pca9554.c
> > > @@ -0,0 +1,328 @@
> > > +/*
> > > + * PCA9554 I/O port
> > > + *
> > > + * Copyright (c) 2023, IBM Corporation.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/log.h"
> > > +#include "qemu/module.h"
> > > +#include "qemu/bitops.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "hw/misc/pca9554.h"
> > > +#include "hw/misc/pca9554_regs.h"
> > > +#include "hw/irq.h"
> > > +#include "migration/vmstate.h"
> > > +#include "qapi/error.h"
> > > +#include "qapi/visitor.h"
> > > +#include "trace.h"
> > > +#include "qom/object.h"
> > > +
> > > +struct PCA9554Class {
> > > +    /*< private >*/
> > > +    I2CSlaveClass parent_class;
> > > +    /*< public >*/
> > > +};
> > > +typedef struct PCA9554Class PCA9554Class;
> > > +
> > > +DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
> > > +                       TYPE_PCA9554)
> > > +
> > > +#define PCA9554_PIN_LOW  0x0
> > > +#define PCA9554_PIN_HIZ  0x1
> > > +
> > > +static const char *pin_state[] = {"low", "high"};
> > > +
> > > +static void pca9554_update_pin_input(PCA9554State *s)
> > > +{
> > > +    int i;
> > > +    uint8_t config = s->regs[PCA9554_CONFIG];
> > > +    uint8_t output = s->regs[PCA9554_OUTPUT];
> > > +    uint8_t internal_state = config | output;
> > > +
> > > +    for (i = 0; i < PCA9554_PIN_COUNT; i++) {
> > > +        uint8_t bit_mask = 1 << i;
> > > +        uint8_t internal_pin_state = (internal_state >> i) &
> > > 0x1;
> > > +        uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
> > > +        uint8_t new_value;
> > > +
> > > +        switch (internal_pin_state) {
> > > +        case PCA9554_PIN_LOW:
> > > +            s->regs[PCA9554_INPUT] &= ~bit_mask;
> > > +            break;
> > > +        case PCA9554_PIN_HIZ:
> > > +            /*
> > > +             * pullup sets it to a logical 1 unless
> > > +             * external device drives it low.
> > > +             */
> > > +            if (s->ext_state[i] == PCA9554_PIN_LOW) {
> > > +                s->regs[PCA9554_INPUT] &= ~bit_mask;
> > > +            } else {
> > > +                s->regs[PCA9554_INPUT] |=  bit_mask;
> > > +            }
> > > +            break;
> > > +        default:
> > > +            break;
> > > +        }
> > > +
> > > +        /* update irq state only if pin state changed */
> > > +        new_value = s->regs[PCA9554_INPUT] & bit_mask;
> > > +        if (new_value != old_value) {
> > > +            if (new_value) {
> > > +                /* changed from 0 to 1 */
> > > +                qemu_set_irq(s->gpio_out[i], 1);
> > > +            } else {
> > > +                /* changed from 1 to 0 */
> > > +                qemu_set_irq(s->gpio_out[i], 0);
> > > +            }
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
> > > +{
> > > +    switch (reg) {
> > > +    case PCA9554_INPUT:
> > > +        return s->regs[PCA9554_INPUT] ^ s-
> > > >regs[PCA9554_POLARITY];
> > > +    case PCA9554_OUTPUT:
> > > +    case PCA9554_POLARITY:
> > > +    case PCA9554_CONFIG:
> > > +        return s->regs[reg];
> > > +    default:
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to
> > > register %d\n",
> > > +                      __func__, reg);
> > > +        return 0xFF;
> > > +    }
> > > +}
> > > +
> > > +static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t
> > > data)
> > > +{
> > > +    switch (reg) {
> > > +    case PCA9554_OUTPUT:
> > > +    case PCA9554_CONFIG:
> > > +        s->regs[reg] = data;
> > > +        pca9554_update_pin_input(s);
> > > +        break;
> > > +    case PCA9554_POLARITY:
> > > +        s->regs[reg] = data;
> > > +        break;
> > > +    case PCA9554_INPUT:
> > > +    default:
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to
> > > register %d\n",
> > > +                      __func__, reg);
> > > +    }
> > > +}
> > > +
> > > +static uint8_t pca9554_recv(I2CSlave *i2c)
> > > +{
> > > +    PCA9554State *s = PCA9554(i2c);
> > > +    uint8_t ret;
> > > +
> > > +    ret = pca9554_read(s, s->pointer & 0x3);
> > > +
> > > +    return ret;
> > > +}
> > > +
> > > +static int pca9554_send(I2CSlave *i2c, uint8_t data)
> > > +{
> > > +    PCA9554State *s = PCA9554(i2c);
> > > +
> > > +    /* First byte sent by is the register address */
> > > +    if (s->len == 0) {
> > > +        s->pointer = data;
> > > +        s->len++;
> > > +    } else {
> > > +        pca9554_write(s, s->pointer & 0x3, data);
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
> > > +{
> > > +    PCA9554State *s = PCA9554(i2c);
> > > +
> > > +    s->len = 0;
> > > +    return 0;
> > > +}
> > > +
> > > +static void pca9554_get_pin(Object *obj, Visitor *v, const char
> > > *name,
> > > +                            void *opaque, Error **errp)
> > > +{
> > > +    PCA9554State *s = PCA9554(obj);
> > > +    int pin, rc;
> > > +    uint8_t state;
> > > +
> > > +    rc = sscanf(name, "pin%2d", &pin);
> > > +    if (rc != 1) {
> > > +        error_setg(errp, "%s: error reading %s", __func__,
> > > name);
> > > +        return;
> > > +    }
> > > +    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> > > +        error_setg(errp, "%s invalid pin %s", __func__, name);
> > > +        return;
> > > +    }
> > > +
> > > +    state = pca9554_read(s, PCA9554_CONFIG);
> > > +    state |= pca9554_read(s, PCA9554_OUTPUT);
> > > +    state = (state >> pin) & 0x1;
> > > +    visit_type_str(v, name, (char **)&pin_state[state], errp);
> > > +}
> > > +
> > > +static void pca9554_set_pin(Object *obj, Visitor *v, const char
> > > *name,
> > > +                            void *opaque, Error **errp)
> > > +{
> > > +    PCA9554State *s = PCA9554(obj);
> > > +    int pin, rc, val;
> > > +    uint8_t state, mask;
> > > +    char *state_str;
> > > +
> > > +    if (!visit_type_str(v, name, &state_str, errp)) {
> > > +        return;
> > > +    }
> > > +    rc = sscanf(name, "pin%2d", &pin);
> > > +    if (rc != 1) {
> > > +        error_setg(errp, "%s: error reading %s", __func__,
> > > name);
> > > +        return;
> > > +    }
> > > +    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> > > +        error_setg(errp, "%s invalid pin %s", __func__, name);
> > > +        return;
> > > +    }
> > > +
> > > +    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> > > +        if (!strcmp(state_str, pin_state[state])) {
> > > +            break;
> > > +        }
> > > +    }
> > > +    if (state >= ARRAY_SIZE(pin_state)) {
> > > +        error_setg(errp, "%s invalid pin state %s", __func__,
> > > state_str);
> > > +        return;
> > > +    }
> > > +
> > > +    /* First, modify the output register bit */
> > > +    val = pca9554_read(s, PCA9554_OUTPUT);
> > > +    mask = 0x1 << pin;
> > > +    if (state == PCA9554_PIN_LOW) {
> > > +        val &= ~(mask);
> > > +    } else {
> > > +        val |= mask;
> > > +    }
> > > +    pca9554_write(s, PCA9554_OUTPUT, val);
> > > +
> > > +    /* Then, clear the config register bit for output mode */
> > > +    val = pca9554_read(s, PCA9554_CONFIG);
> > > +    val &= ~mask;
> > > +    pca9554_write(s, PCA9554_CONFIG, val);
> > > +}
> > > +
> > > +static const VMStateDescription pca9554_vmstate = {
> > > +    .name = "PCA9554",
> > > +    .version_id = 0,
> > > +    .minimum_version_id = 0,
> > > +    .fields = (VMStateField[]) {
> > > +        VMSTATE_UINT8(len, PCA9554State),
> > > +        VMSTATE_UINT8(pointer, PCA9554State),
> > > +        VMSTATE_UINT8_ARRAY(regs, PCA9554State,
> > > PCA9554_NR_REGS),
> > > +        VMSTATE_UINT8_ARRAY(ext_state, PCA9554State,
> > > PCA9554_PIN_COUNT),
> > > +        VMSTATE_I2C_SLAVE(i2c, PCA9554State),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static void pca9554_reset(DeviceState *dev)
> > > +{
> > > +    PCA9554State *s = PCA9554(dev);
> > > +
> > > +    s->regs[PCA9554_INPUT] = 0xFF;
> > > +    s->regs[PCA9554_OUTPUT] = 0xFF;
> > > +    s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
> > > +    s->regs[PCA9554_CONFIG] = 0xFF; /* All pins are inputs */
> > > +
> > > +    memset(s->ext_state, PCA9554_PIN_HIZ, PCA9554_PIN_COUNT);
> > > +    pca9554_update_pin_input(s);
> > > +
> > > +    s->pointer = 0x0;
> > > +    s->len = 0;
> > > +}
> > > +
> > > +static void pca9554_initfn(Object *obj)
> > > +{
> > > +    int pin;
> > > +
> > > +    for (pin = 0; pin < PCA9554_PIN_COUNT; pin++) {
> > > +        char *name;
> > > +
> > > +        name = g_strdup_printf("pin%d", pin);
> > > +        object_property_add(obj, name, "bool", pca9554_get_pin,
> > > pca9554_set_pin,
> > > +                            NULL, NULL);
> > > +        g_free(name);
> > > +    }
> > > +}
> > > +
> > > +static void pca9554_set_ext_state(PCA9554State *s, int pin, int
> > > level)
> > > +{
> > > +    if (s->ext_state[pin] != level) {
> > > +        s->ext_state[pin] = level;
> > > +        pca9554_update_pin_input(s);
> > > +    }
> > > +}
> > > +
> > > +static void pca9554_gpio_in_handler(void *opaque, int pin, int
> > > level)
> > > +{
> > > +
> > > +    PCA9554State *s = PCA9554(opaque);
> > > +
> > > +    assert((pin >= 0) && (pin < PCA9554_PIN_COUNT));
> > > +    pca9554_set_ext_state(s, pin, level);
> > > +}
> > > +
> > > +static void pca9554_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    PCA9554State *s = PCA9554(dev);
> > > +
> > > +    if (!s->description) {
> > > +        s->description = g_strdup("pca9554");
> > > +    }
> > > +
> > > +    qdev_init_gpio_out(dev, s->gpio_out, PCA9554_PIN_COUNT);
> > > +    qdev_init_gpio_in(dev, pca9554_gpio_in_handler,
> > > PCA9554_PIN_COUNT);
> > > +}
> > > +
> > > +static Property pca9554_properties[] = {
> > > +    DEFINE_PROP_STRING("description", PCA9554State,
> > > description),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void pca9554_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > > +    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
> > > +
> > > +    k->event = pca9554_event;
> > > +    k->recv = pca9554_recv;
> > > +    k->send = pca9554_send;
> > > +    dc->realize = pca9554_realize;
> > > +    dc->reset = pca9554_reset;
> > > +    dc->vmsd = &pca9554_vmstate;
> > > +    device_class_set_props(dc, pca9554_properties);
> > > +}
> > > +
> > > +static const TypeInfo pca9554_info = {
> > > +    .name          = TYPE_PCA9554,
> > > +    .parent        = TYPE_I2C_SLAVE,
> > > +    .instance_init = pca9554_initfn,
> > > +    .instance_size = sizeof(PCA9554State),
> > > +    .class_init    = pca9554_class_init,
> > > +    .class_size    = sizeof(PCA9554Class),
> > > +    .abstract      = false,
> > > +};
> > > +
> > > +static void pca9554_register_types(void)
> > > +{
> > > +    type_register_static(&pca9554_info);
> > > +}
> > > +
> > > +type_init(pca9554_register_types)
> > > diff --git a/include/hw/misc/pca9554.h
> > > b/include/hw/misc/pca9554.h
> > > new file mode 100644
> > > index 0000000000..54bfc4c4c7
> > > --- /dev/null
> > > +++ b/include/hw/misc/pca9554.h
> > > @@ -0,0 +1,36 @@
> > > +/*
> > > + * PCA9554 I/O port
> > > + *
> > > + * Copyright (c) 2023, IBM Corporation.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +#ifndef PCA9554_H
> > > +#define PCA9554_H
> > > +
> > > +#include "hw/i2c/i2c.h"
> > > +#include "qom/object.h"
> > > +
> > > +#define TYPE_PCA9554 "pca9554"
> > > +typedef struct PCA9554State PCA9554State;
> > > +DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
> > > +                         TYPE_PCA9554)
> > > +
> > > +#define PCA9554_NR_REGS 4
> > > +#define PCA9554_PIN_COUNT 8
> > > +
> > > +struct PCA9554State {
> > > +    /*< private >*/
> > > +    I2CSlave i2c;
> > > +    /*< public >*/
> > > +
> > > +    uint8_t len;
> > > +    uint8_t pointer;
> > > +
> > > +    uint8_t regs[PCA9554_NR_REGS];
> > > +    qemu_irq gpio_out[PCA9554_PIN_COUNT];
> > > +    uint8_t ext_state[PCA9554_PIN_COUNT];
> > > +    char *description; /* For debugging purpose only */
> > > +};
> > > +
> > > +#endif
> > > diff --git a/include/hw/misc/pca9554_regs.h
> > > b/include/hw/misc/pca9554_regs.h
> > > new file mode 100644
> > > index 0000000000..602c4a90e0
> > > --- /dev/null
> > > +++ b/include/hw/misc/pca9554_regs.h
> > > @@ -0,0 +1,19 @@
> > > +/*
> > > + * PCA9554 I/O port registers
> > > + *
> > > + * Copyright (c) 2023, IBM Corporation.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + */
> > > +#ifndef PCA9554_REGS_H
> > > +#define PCA9554_REGS_H
> > > +
> > > +/*
> > > + * Bits [0:1] are used to address a specific register.
> > > + */
> > > +#define PCA9554_INPUT       0 /* read only input register */
> > > +#define PCA9554_OUTPUT      1 /* read/write pin output state */
> > > +#define PCA9554_POLARITY    2 /* Set polarity of input register
> > > */
> > > +#define PCA9554_CONFIG      3 /* Set pins as inputs our ouputs
> > > */
> > > +
> > > +#endif


