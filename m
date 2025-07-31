Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBF6C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 15:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhV6G-0003Z1-3w; Thu, 31 Jul 2025 11:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhTrb-0008GT-Ch
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhTrX-0001tQ-HZ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 10:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753970544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=po9b8vNTUzHLz7mBMHe31P671vtvm7WBJZHO51l2nzM=;
 b=UPTrQBNDWc1XNVblqXIESaQALnfwERkMXIlKdsJMYEcvFYTJivu9LBrQEKoY/GMvHZVzBd
 X4l+QVqSVSe1qdWlqo+lfl9ewzKix1RVmmHAN2uLIoUJfG/vBNq2BQSgoqkaT03K+3Bhjk
 PAbQxQbdHm4DuKu60yQQ5/joXBP0qEk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-UAO3-SaFPeOrK10JNXbDvg-1; Thu, 31 Jul 2025 10:02:22 -0400
X-MC-Unique: UAO3-SaFPeOrK10JNXbDvg-1
X-Mimecast-MFC-AGG-ID: UAO3-SaFPeOrK10JNXbDvg_1753970542
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70748301f71so15573596d6.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 07:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753970541; x=1754575341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=po9b8vNTUzHLz7mBMHe31P671vtvm7WBJZHO51l2nzM=;
 b=mJR8VnM3yHzJIUDLMeBsPKmCmUiuyXBpOYriLQ/HABh6P3kbbApsGLfKTyUJ+ql5xI
 9fVDTPYYV85Pyh0b7LIGHh7Hu7r1ePzcDrqjemfhB5n/Owe8OnDUAZBjQEXWqfLVR/7U
 GzuWbA/xbIdSMk8WmrpqzWIj3N0dMTaQFNtJyygRXQE8QP8tVmY7CUrQ+gLI/TlK7FmU
 K1KY2X5ln0TEn6ZsSoBDwX5J1ffnJ8H/30CKvDpAhVu5OemqR4Szs+6W6bZGq3pQ3I9z
 to3g8gUaleiAnfQTuMqCX61in1UPWkFXkWhDWl5mSFCgHqriJFA0vFE4EmUUJJUiJuDL
 pQkw==
X-Gm-Message-State: AOJu0Yx4PbxuD8QtyXd0GTOciVT7qXjU4s+coJzTeWjIzk9GUgXh94+g
 gVgxOEEa0NhWBdcr6KxMBaoSVHFh1UnFVdOoVN4OGGTqJkbuSRB8bNFpAPdVECxEAQV4PfW6ohd
 +lbOP18DArMzfnUKCnkJePFtXFCl8qamluUSMZeQjlQJmDVH+qHn2aaWI
X-Gm-Gg: ASbGncva1HssJgF4o9IENgSf2m5zYDQ+a1a5MFY6iK/O1094Aqm8hsmAnNNG+30a2lE
 zwF8jgqZ3WIchkZ6oWAWpohSgNXM9yrjiWkPB15+rWCWESW3rEZAa7TfUTP8EIglbEhroYwN27y
 PeVggO1kudv6fitI9YmXjKgjTrHZnFEOjAZEE4RVxNdwr2v2De9/7QJqaNboT74TFqwD00v5IxK
 Qu/8Ud5mDY/Pv0nzfOOqWS1PzuhfbmzsMWirsB27c6GY9BSdBxmxa+jqWUOrN/iEr7P7yJTZBYs
 GkKLEwIZhQ7JLVsx56Z3O0IZDI2wfgOv
X-Received: by 2002:a05:6214:230d:b0:707:619c:8eb6 with SMTP id
 6a1803df08f44-70767009d2cmr97440776d6.20.1753970541327; 
 Thu, 31 Jul 2025 07:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgV1zwmMinzb3fe8CfzONixtDA1iU7iJzMQxbZv0XMazmiRZUm9BiG92pSoAzZn+FaLQPSQw==
X-Received: by 2002:a05:6214:230d:b0:707:619c:8eb6 with SMTP id
 6a1803df08f44-70767009d2cmr97440176d6.20.1753970540570; 
 Thu, 31 Jul 2025 07:02:20 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca2ee51sm7607436d6.28.2025.07.31.07.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 07:02:20 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:02:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 5/6] hpet: make main counter read lock-less
Message-ID: <aIt3Xo8dSKusoxA8@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-6-imammedo@redhat.com>
 <aIqZZ5bePh7Jmq3c@x1.local> <20250731103210.292dfecb@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731103210.292dfecb@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 31, 2025 at 10:32:10AM +0200, Igor Mammedov wrote:
> On Wed, 30 Jul 2025 18:15:03 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Jul 30, 2025 at 02:39:33PM +0200, Igor Mammedov wrote:
> > > Make access to main HPET counter lock-less when enable/disable
> > > state isn't changing (which is the most of the time).
> > > 
> > > A read will fallback to locked access if the state change happens
> > > in the middle of read or read happens in the middle of the state
> > > change.
> > > 
> > > This basically uses the same approach as cpu_get_clock(),
> > > modulo instead of busy wait it piggibacks to taking device lock
> > > to wait until HPET reaches consistent state.  
> > 
> > The open-coded seqlock will slightly add complexity of the hpet code.  Is
> > it required? IOW, is it common to have concurrent writters while reading?
> 
> Write path has to be lock protected for correctness sake even though
> concurrent writers are not likely.

Right.  Though we have seqlock_write_lock() for that, IIUC (even though
maybe in hpet's use case we don't need it..).

> 
> I've tried seqlock as well, the difference wrt seqlock is few LOC only
> it didn't make HPET code any simpler.

I tried to do this and it looks still worthwhile to do, but maybe I missed
something alone the lines. Please have a look if so.  That is still a lot
of LOC saved, meanwhile IMHO the important part is mem barriers are just
tricky to always hard-code in users, so I thought it would always be nice
to reuse the lock APIs whenever possible.

One example is, IIUC this current patch may have missed the mem barriers
when boosting state_version in hpet_ram_write().

> 
> > How bad it is to spin on read waiting for the writer to finish?
> that will waste CPU cycles, and on large NUMA system it will generate
> more cross node traffic. (i.e. it would scale badly, though TBH
> I don't have numbers. I think measuring it would be hard as it
> would drown in the noise.)
> 
> hence I've opted for a more effective option, to halt readers
> until update is done. (at the cost of latency spike when that
> unlikely event happens)

If it is extremely unlikely (IIUC, disabling HPET while someone is using /
reading the counter.. should never happen in normal production?), would
spinning read also be fine?  Maybe that's also why I can save more LOCs in
the diff below.

In the diff I also removed a "addr <= 0xff" check, that might belong to a
prior patch that I thought is not needed.

Thanks,

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index d822ca1cd0..09a84d19f3 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -39,6 +39,7 @@
 #include "system/address-spaces.h"
 #include "qom/object.h"
 #include "qemu/lockable.h"
+#include "qemu/seqlock.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -74,7 +75,7 @@ struct HPETState {
     MemoryRegion iomem;
     uint64_t hpet_offset;
     bool hpet_offset_saved;
-    unsigned state_version;
+    QemuSeqLock state_version;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
     uint8_t rtc_irq_level;
@@ -431,39 +432,17 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     trace_hpet_ram_read(addr);
     addr &= ~4;
 
-    if ((addr <= 0xff) && (addr == HPET_COUNTER)) {
+    if (addr == HPET_COUNTER) {
         unsigned version;
-        bool release_lock = false;
-redo:
-        version = qatomic_load_acquire(&s->state_version);
-        if (unlikely(version & 1)) {
-                /*
-                 * Updater is running, state can be inconsistent
-                 * wait till it's done before reading counter
-                 */
-                release_lock = true;
-                qemu_mutex_lock(&s->lock);
-        }
-
-        if (unlikely(!hpet_enabled(s))) {
-            cur_tick = s->hpet_counter;
-        } else {
-            cur_tick = hpet_get_ticks(s);
-        }
-
-        /*
-         * ensure counter math happens before we check version again
-         */
-        smp_rmb();
-        if (unlikely(version != qatomic_load_acquire(&s->state_version))) {
-            /*
-             * counter state has changed, re-read counter again
-             */
-            goto redo;
-        }
-        if (unlikely(release_lock)) {
-            qemu_mutex_unlock(&s->lock);
-        }
+        /* Write update is extremely rare, so spinning is fine */
+        do {
+            version = seqlock_read_begin(&s->state_version);
+            if (unlikely(!hpet_enabled(s))) {
+                cur_tick = s->hpet_counter;
+            } else {
+                cur_tick = hpet_get_ticks(s);
+            }
+        } while (seqlock_read_retry(&s->state_version, version));
         trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
         return cur_tick >> shift;
     }
@@ -528,11 +507,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             old_val = s->config;
             new_val = deposit64(old_val, shift, len, value);
             new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-            /*
-             * Odd versions mark the critical section, any readers will be
-             * forced into lock protected read if they come in the middle of it
-             */
-            qatomic_inc(&s->state_version);
+            seqlock_write_begin(&s->state_version);
             s->config = new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
@@ -551,12 +526,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                     hpet_del_timer(&s->timer[i]);
                 }
             }
-            /*
-             * even versions mark the end of critical section,
-             * any readers started before config change, but were still executed
-             * during the change, will be forced to re-read counter state
-             */
-            qatomic_inc(&s->state_version);
+            seqlock_write_end(&s->state_version);
 
             /* i8254 and RTC output pins are disabled
              * when HPET is in legacy mode */


-- 
Peter Xu


