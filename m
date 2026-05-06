Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA82CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 05:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKVC4-0007JE-Cu; Wed, 06 May 2026 01:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKVC2-0007If-Hi
 for qemu-devel@nongnu.org; Wed, 06 May 2026 01:53:10 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKVC0-0002Bc-L0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 01:53:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a8fba3f769so24886845ad.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778046786; x=1778651586; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f7sE3FRimHIINXSd8puM1AIRt8EfPIvqaDSSEESZbVU=;
 b=lGUD8oEqMt/LSnSacIF+asPop9IJ7vjxh8lXOB45smFfJO6x7DiOWQomJZkJdllphU
 uIN3oSTa2Eq6DzTp9h7fotn2Jh4YEWd7/fWK9syA2PvjunDxWFlW5LKseq/YqOQO+P0J
 A4oCdPok3+QfT3zodaCKODONp+Ml8imlAH4fmkOFfK9gEJ8FD7eG4ih3YaQGhLKBqw0n
 tzTzIZp/FwmorqmoMmcVMPo/gCN38AUcVBkik/7MvuQwr0+sflcmz2zTVKQTU5cXoWxb
 Mfw+t0YYVw9lW0wINxiCeUZzfeU8szreMEaAYoo/UQtd/nKosx6NjoEINGowwF88o15p
 es8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778046786; x=1778651586;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f7sE3FRimHIINXSd8puM1AIRt8EfPIvqaDSSEESZbVU=;
 b=Xw/Xbm1dlMrUEu4x3SyPIEh/EJxOnciW7vpMI6y71b1l9OisFWdO949721lkXgyhWN
 Qop2hoe6V8dj9/f7oDhjjLstq/TAPrtcvRKyxQ8sYTWnlI04U2oAXQr+lfjobl/9vffi
 2KiMGT3fHgFD8VIDYfBGuJI1KQJPrSnyF+r5BfdDcp6onEKRExch0Xasa22b6kV1s1PB
 377o2JrbfRZS6oaTR4O9VrBaVZ1/eD7Xac1q52f8pahHdkmSdgf/LgErAHSCWdm7zd8B
 InHSy0P8LbVY3ycSPPbwRjmACQDj/yxySfIxfe+7/IPUJH66OTrbdtw70Pi/rLP163WO
 shpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n/hov0DoDC6KM5FRwbmSOPpQYeW3LYEwkqubwVZ4cHmcAv9G4Yrb2dcXVpP27cfd+XNGR9eQ3LFQX@nongnu.org
X-Gm-Message-State: AOJu0YxL+yChDvhSWLwhRE4BaQNY/o2BOe5qKVCP3We4QAMizcu00+q/
 0/b92G24QYInYM48MvMNdzt0LPar5THsx0FOwgq9uswLeDJd+6dAeAU6
X-Gm-Gg: AeBDietKTLeZMmgwyYrWpEGdx2GdKdYHctzBxVDPlkrvZ+fqVyZV9RbEtVjF3dBE9GP
 8h+9tgjpihxZDZNAt6BeHv9JUIvVJ2xjCkKNpEOFJ7U0RLDapIdKdW6RnVpWN6awaw7XdU1dOz/
 ADtLzuBGXccdjisRVA0Z86xojp3JYozz0Xqp0IfeaDraamO9mxIV7gY0jwpBgwvGTuYVs7o9B76
 5X+ylGnBxB+TJ9QDpw+4eQUTW3FdzdjmCoT/anwnxitvNDp8RAaqXGySjfD6ddrbOF8Ag7vsM0V
 z8HGQXxPn3+ZaS5nDG+GItqjOXtn/foKB4zsp3dvZa8e5qk8X65alWmxzLs+jhBgHF6/oZKlcyE
 buBS4Im61Io7UU5Ddr4j6S0pftImIhDefw5VBgHcBmIxpezuwdUNhKBmhtJg1frcTG1d9rbxjGC
 mHWg9ame8lGNwxYkxA5/bYyu73qd5TRMDwPlPldWc+GSPMD9GhBbLKbsdMfCTseZTb/rDpQhLvg
 FXdQ7eK
X-Received: by 2002:a17:903:2c6:b0:2ba:6ffe:30ad with SMTP id
 d9443c01a7336-2ba794b7134mr19251325ad.20.1778046786231; 
 Tue, 05 May 2026 22:53:06 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7bf2cd25sm12174325ad.22.2026.05.05.22.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 22:53:05 -0700 (PDT)
Date: Wed, 6 May 2026 15:53:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Message-ID: <afrVHbIeet5tqCA-@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
 <972d8ddd-8ef9-4cd3-a7e5-90f00ec625ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <972d8ddd-8ef9-4cd3-a7e5-90f00ec625ad@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 05, 2026 at 09:57:20AM +0200, Philippe Mathieu-Daudé wrote:
> On 25/4/26 15:17, Joel Stanley wrote:
> > From: Chris Rauer <crauer@google.com>
> > 
> > In the past this model has been submitted for use with the arm virt
> > machine, however in this case it will be used by the upcoming
> > Tenstorrent Atlantis RISC-V machine.
> > 
> > This is a re-submission of the model with Chris' permission, with a
> > light touch of updates to make it build with qemu master.
> > 
> > Reviewed-by: Hao Wu <wuhaotsh@google.com>
> > Signed-off-by: Chris Rauer <crauer@google.com>
> > Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
> > [jms: rebase and minor build fixes for class_init and reset callback]
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v4: Remove unused random header
> > v2: Add trace event for read and write, document Alano and myself as
> > reviewers.
> > ---
> >   MAINTAINERS                     |   8 +
> >   include/hw/i2c/designware_i2c.h | 101 ++++
> >   hw/i2c/designware_i2c.c         | 817 ++++++++++++++++++++++++++++++++
> >   hw/i2c/Kconfig                  |   4 +
> >   hw/i2c/meson.build              |   1 +
> >   hw/i2c/trace-events             |   4 +
> >   6 files changed, 935 insertions(+)
> >   create mode 100644 include/hw/i2c/designware_i2c.h
> >   create mode 100644 hw/i2c/designware_i2c.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aa4267b15806..e1942a86eba5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2716,6 +2716,14 @@ S: Orphan
> >   F: hw/gpio/pcf8574.c
> >   F: include/gpio/pcf8574.h
> > +DesignWare I2C
> > +M: Chris Rauer <crauer@google.com>
> 
> This was 4 years ago. Is Chris still up to this?

Joel is away for a few weeks, but AFAIK he did ping Chris and got
ack to upstream his patch.

> > +    case DW_IC_SAR:
> > +        qemu_log_mask(LOG_UNIMP, "%s: unsupported write - ic_sar\n",
> > +                      DEVICE(s)->canonical_path);
> > +        s->ic_sar = value & DW_IC_SAR_MASK;
> 
> Unsupported but updated...

Yeah, not sure what the best course of action is, maybe device driver
was working better if the value got saved?

> > +    s->ic_comp_param_1 = DW_IC_COMP_PARAM_1_INIT_VAL;
> > +    s->ic_comp_version = DW_IC_COMP_VERSION_INIT_VAL;
> > +    s->ic_comp_type = DW_IC_COMP_TYPE_INIT_VAL;
> 
> Preferably initialize the IC_COMP registers once in the
> designware_i2c_realize() handler.

This I didn't change yet because I started register API converstion and
that all changes.

> > +static void designware_i2c_smbus_init(Object *obj)
> > +{
> > +    DesignWareI2CState *s = DESIGNWARE_I2C(obj);
> > +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> > +
> > +    sysbus_init_irq(sbd, &s->irq);
> > +
> > +    memory_region_init_io(&s->iomem, obj, &designware_i2c_ops, s,
> > +                          "regs", 4 * KiB);
> 
> I note the current registers only describe a 1KiB region.

256 bytes even. It might have 4K alignment in data sheet.

> > +}
> Since I couldn't look at the datasheet values, for overall modelling:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

I have an incremental patch here that incorporates review comments and
also a couple of possible issues I found - RX underflow bit was never
being set AFAIKS it should be set here, and one of the INTR bit clear
registers was not recalculating irqs.

I will fold this in before next repost if there are no objections.

Thanks,
Nick

---
diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
index 7d8b1c1353..1e5505f571 100644
--- a/hw/i2c/designware_i2c.c
+++ b/hw/i2c/designware_i2c.c
@@ -217,7 +217,7 @@ static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
                       "%s: Attempted to read from RX fifo when not in receive "
                       "state.\n", DEVICE(s)->canonical_path);
         if (s->status != DW_I2C_STATUS_IDLE) {
-            s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
+            s->ic_raw_intr_stat |= DW_IC_INTR_RX_UNDER;
             dw_i2c_update_irq(s);
         }
         return 0;
@@ -228,7 +228,7 @@ static uint32_t dw_i2c_read_ic_data_cmd(DesignWareI2CState *s)
     if (s->ic_rxflr > 0) {
         s->ic_rxflr--;
     } else {
-        s->ic_raw_intr_stat &= ~DW_IC_INTR_RX_UNDER;
+        s->ic_raw_intr_stat |= DW_IC_INTR_RX_UNDER;
         dw_i2c_update_irq(s);
         return 0;
     }
@@ -395,6 +395,7 @@ static uint64_t dw_i2c_read(void *opaque, hwaddr offset, unsigned size)
         break;
     case DW_IC_CLR_RESTART_DET:
         s->ic_raw_intr_stat &= ~(DW_IC_INTR_RESTART_DET);
+        dw_i2c_update_irq(s);
         break;
     case DW_IC_COMP_PARAM_1:
         value = s->ic_comp_param_1;
@@ -698,6 +699,10 @@ static const MemoryRegionOps designware_i2c_ops = {
     .read = dw_i2c_read,
     .write = dw_i2c_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -748,7 +753,7 @@ static const VMStateDescription vmstate_designware_i2c = {
     .name = TYPE_DESIGNWARE_I2C,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ic_con, DesignWareI2CState),
         VMSTATE_UINT32(ic_tar, DesignWareI2CState),
         VMSTATE_UINT32(ic_sar, DesignWareI2CState),
@@ -803,6 +808,8 @@ static void designware_i2c_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_designware_i2c;
     rc->phases.enter = designware_i2c_enter_reset;
     rc->phases.hold = designware_i2c_hold_reset;
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo designware_i2c_types[] = {
diff --git a/include/hw/i2c/designware_i2c.h b/include/hw/i2c/designware_i2c.h
index 0d8f904f51..71d74c9141 100644
--- a/include/hw/i2c/designware_i2c.h
+++ b/include/hw/i2c/designware_i2c.h
@@ -57,7 +57,7 @@ typedef enum DesignWareI2CStatus {
  * @status: The current status of the SMBus.
  */
 typedef struct DesignWareI2CState {
-    SysBusDevice parent;
+    SysBusDevice parent_obj;
 
     MemoryRegion iomem;
 

