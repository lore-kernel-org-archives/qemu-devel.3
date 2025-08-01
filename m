Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B0CC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 08:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhkn7-00037y-7y; Fri, 01 Aug 2025 04:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhkn5-00036V-8t
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhkn2-0003JO-Tq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754035613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxgN6hgKO9B4HinZwY03ozVRE0pdEXV96cVLmapR90k=;
 b=c77NeotZf7yK9lauaPAE7aqXBUznlTftPo+3yK3enGVLH/UvAcXgOQ5vTpCWlTk6hcbR+K
 lAIJayY4WwLIWjtlCaLwEvKpXBSNTGQ1Mg08Kkl9rZE7KPm7r9zsCWk0Hr/fFzzI6c/ZNO
 qsyfvFDEsxdiujuLdJTIFPQA2SlcNhs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-ZsXU0NHCPWKC-a_p6EuvSw-1; Fri, 01 Aug 2025 04:06:51 -0400
X-MC-Unique: ZsXU0NHCPWKC-a_p6EuvSw-1
X-Mimecast-MFC-AGG-ID: ZsXU0NHCPWKC-a_p6EuvSw_1754035609
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b78329f180so1226724f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 01:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754035609; x=1754640409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxgN6hgKO9B4HinZwY03ozVRE0pdEXV96cVLmapR90k=;
 b=dTckk2v/tYgtv+DR8EnMx0Qymt0WrW59Ci/F7nOHFD/ytppf7F8lzLznhjfHKGt50x
 whbs4aClMVsOjjy/B1PnSalLuWzZGytb4vHAiMlIF8kysU2yIDwa8dUU9slXRWs8hVup
 5Vajjp/qPm19Nsi7Q4uVT25qLFDTeV+7K6Ia6PCS2IhVQb3a06qMAUWARGuBNCnVEqVh
 og4Wis1hfvrJh9c87HLdfrHkVACXFF7/PiB2EhYx5fgttuYIdOnaYVRKDRR4NhR7UOHm
 yjMSp7wsbOYMqntH190gTwoWUf/qUNFvmKKiBeJMwLmHvoyPC75N1bDoZbSh1o+A+18z
 CYyQ==
X-Gm-Message-State: AOJu0Yz66cTZRB3q7e72mE+5UkPZjnjvrYAE1h3Swewo1QyhugalIPm2
 kalZfLI70Uu1gZSGkVn2qtBtE+AmUtc6p5nWty1RJqY0SHWPM0VPXxZ3BxzOjRPl3Fo6ZiyrXS+
 MtdwicPKpq+mrei/o1V3jTZCKhpRhHSHu+/uNWGnx78qqGBJ8AJioREwouRfR9WXv
X-Gm-Gg: ASbGncvz4l4le0MmF3e3tn3NXryAD8ch7wVWESy1Ndasx9L2MOmjmPQp0T+rPWWhVOf
 z9Y89SfgiE97w+aMoXtpDhx0K44pHd8TD0A/4KSBVEjhRMNkwHm4Vz4kvA36+NYkLWXbgHVRSeJ
 rcXGweyHPTEtLJJHpZVdLbeU0fdS9a8NOpVOtQj0t2lTS04cZHxaIXNhusfPU92ROiCdEIvus39
 G0K2LzNoTujb09aZnBFmP/Hzm88ActG5Y26k02L+GZ98tTnMbzgfcb/wnX5IMMvp5sS4vlA7ETE
 nJAm+MSnPXpisFOIlE/KPiYAf5eeWw==
X-Received: by 2002:a5d:64e5:0:b0:3b7:761a:95d9 with SMTP id
 ffacd0b85a97d-3b795009640mr8355908f8f.59.1754035609069; 
 Fri, 01 Aug 2025 01:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9d6h4c0/5/Eh0vSZDoeMGmRjHKaHe7zSZ2g8wHpPuVrSQr2hIbZTtaZ+FlM9gswGNrD4Qcg==
X-Received: by 2002:a5d:64e5:0:b0:3b7:761a:95d9 with SMTP id
 ffacd0b85a97d-3b795009640mr8355886f8f.59.1754035608603; 
 Fri, 01 Aug 2025 01:06:48 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c467994sm4970029f8f.50.2025.08.01.01.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 01:06:48 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:06:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 5/6] hpet: make main counter read lock-less
Message-ID: <20250801100645.133727f0@fedora>
In-Reply-To: <aIt3Xo8dSKusoxA8@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-6-imammedo@redhat.com>
 <aIqZZ5bePh7Jmq3c@x1.local> <20250731103210.292dfecb@fedora>
 <aIt3Xo8dSKusoxA8@x1.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Thu, 31 Jul 2025 10:02:06 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Thu, Jul 31, 2025 at 10:32:10AM +0200, Igor Mammedov wrote:
> > On Wed, 30 Jul 2025 18:15:03 -0400
> > Peter Xu <peterx@redhat.com> wrote:
> >   
> > > On Wed, Jul 30, 2025 at 02:39:33PM +0200, Igor Mammedov wrote:  
> > > > Make access to main HPET counter lock-less when enable/disable
> > > > state isn't changing (which is the most of the time).
> > > > 
> > > > A read will fallback to locked access if the state change happens
> > > > in the middle of read or read happens in the middle of the state
> > > > change.
> > > > 
> > > > This basically uses the same approach as cpu_get_clock(),
> > > > modulo instead of busy wait it piggibacks to taking device lock
> > > > to wait until HPET reaches consistent state.    
> > > 
> > > The open-coded seqlock will slightly add complexity of the hpet code.  Is
> > > it required? IOW, is it common to have concurrent writters while reading?  
> > 
> > Write path has to be lock protected for correctness sake even though
> > concurrent writers are not likely.  
> 
> Right.  Though we have seqlock_write_lock() for that, IIUC (even though
> maybe in hpet's use case we don't need it..).
> 
> > 
> > I've tried seqlock as well, the difference wrt seqlock is few LOC only
> > it didn't make HPET code any simpler.  
> 
> I tried to do this and it looks still worthwhile to do, but maybe I missed
> something alone the lines. Please have a look if so.  That is still a lot
> of LOC saved, meanwhile IMHO the important part is mem barriers are just
> tricky to always hard-code in users, so I thought it would always be nice
> to reuse the lock APIs whenever possible.

I'll try it for the next respin

> One example is, IIUC this current patch may have missed the mem barriers
> when boosting state_version in hpet_ram_write().

docs put qatomic_inc() in 'Sequentially consistent' category,
hence no manual barrier.
before that I've used weak qatomic_store_release(), but
qatomic_inc() should do increment and store that in one go.

> > > How bad it is to spin on read waiting for the writer to finish?  
> > that will waste CPU cycles, and on large NUMA system it will generate
> > more cross node traffic. (i.e. it would scale badly, though TBH
> > I don't have numbers. I think measuring it would be hard as it
> > would drown in the noise.)
> > 
> > hence I've opted for a more effective option, to halt readers
> > until update is done. (at the cost of latency spike when that
> > unlikely event happens)  
> 
> If it is extremely unlikely (IIUC, disabling HPET while someone is using /
> reading the counter.. should never happen in normal production?), would
> spinning read also be fine?  Maybe that's also why I can save more LOCs in
> the diff below.

it's mostly need for comments that goes away.
but you are right,
it's very not likely to happen. so busywait vs lock probably won't matter. 

> 
> In the diff I also removed a "addr <= 0xff" check, that might belong to a
> prior patch that I thought is not needed.

indeed check is not really needed.

> 
> Thanks,
> 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index d822ca1cd0..09a84d19f3 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -39,6 +39,7 @@
>  #include "system/address-spaces.h"
>  #include "qom/object.h"
>  #include "qemu/lockable.h"
> +#include "qemu/seqlock.h"
>  #include "trace.h"
>  
>  struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
> @@ -74,7 +75,7 @@ struct HPETState {
>      MemoryRegion iomem;
>      uint64_t hpet_offset;
>      bool hpet_offset_saved;
> -    unsigned state_version;
> +    QemuSeqLock state_version;
>      qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
>      uint32_t flags;
>      uint8_t rtc_irq_level;
> @@ -431,39 +432,17 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>      trace_hpet_ram_read(addr);
>      addr &= ~4;
>  
> -    if ((addr <= 0xff) && (addr == HPET_COUNTER)) {
> +    if (addr == HPET_COUNTER) {
>          unsigned version;
> -        bool release_lock = false;
> -redo:
> -        version = qatomic_load_acquire(&s->state_version);
> -        if (unlikely(version & 1)) {
> -                /*
> -                 * Updater is running, state can be inconsistent
> -                 * wait till it's done before reading counter
> -                 */
> -                release_lock = true;
> -                qemu_mutex_lock(&s->lock);
> -        }
> -
> -        if (unlikely(!hpet_enabled(s))) {
> -            cur_tick = s->hpet_counter;
> -        } else {
> -            cur_tick = hpet_get_ticks(s);
> -        }
> -
> -        /*
> -         * ensure counter math happens before we check version again
> -         */
> -        smp_rmb();
> -        if (unlikely(version != qatomic_load_acquire(&s->state_version))) {
> -            /*
> -             * counter state has changed, re-read counter again
> -             */
> -            goto redo;
> -        }
> -        if (unlikely(release_lock)) {
> -            qemu_mutex_unlock(&s->lock);
> -        }
> +        /* Write update is extremely rare, so spinning is fine */
> +        do {
> +            version = seqlock_read_begin(&s->state_version);
> +            if (unlikely(!hpet_enabled(s))) {
> +                cur_tick = s->hpet_counter;
> +            } else {
> +                cur_tick = hpet_get_ticks(s);
> +            }
> +        } while (seqlock_read_retry(&s->state_version, version));
>          trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
>          return cur_tick >> shift;
>      }
> @@ -528,11 +507,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              old_val = s->config;
>              new_val = deposit64(old_val, shift, len, value);
>              new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
> -            /*
> -             * Odd versions mark the critical section, any readers will be
> -             * forced into lock protected read if they come in the middle of it
> -             */
> -            qatomic_inc(&s->state_version);
> +            seqlock_write_begin(&s->state_version);
>              s->config = new_val;
>              if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
>                  /* Enable main counter and interrupt generation. */
> @@ -551,12 +526,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>                      hpet_del_timer(&s->timer[i]);
>                  }
>              }
> -            /*
> -             * even versions mark the end of critical section,
> -             * any readers started before config change, but were still executed
> -             * during the change, will be forced to re-read counter state
> -             */
> -            qatomic_inc(&s->state_version);
> +            seqlock_write_end(&s->state_version);
>  
>              /* i8254 and RTC output pins are disabled
>               * when HPET is in legacy mode */
> 
> 


