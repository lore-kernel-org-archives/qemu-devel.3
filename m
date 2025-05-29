Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8063EC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 14:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKeYz-0006Bs-6V; Thu, 29 May 2025 10:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKeYu-0006BI-V5
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKeYq-0007Oq-VN
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748530127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sBsmbjEytXI5lPlclWLDjvJS/VjTPMVJlUM1wxzTmJ0=;
 b=SbqbRhJGPiwxaRQfMs6tWSzHUaCmWVz3Q+cZbB5Shd2UXlU340syicbdnYP0kyZ2t2pjAi
 4Gn4uRLHB9FF3xPMBoAf6yt5W07olLwUkbVKAjrYHGncfLi8ZBQ/T4l78BLQEjbzhaWsgV
 0m3a0YcX1jeqfiSyhtr8081Xeo3sy1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-pd8kphQ2OSq2z41H6mh0xA-1; Thu, 29 May 2025 10:48:46 -0400
X-MC-Unique: pd8kphQ2OSq2z41H6mh0xA-1
X-Mimecast-MFC-AGG-ID: pd8kphQ2OSq2z41H6mh0xA_1748530125
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45048826b64so7317795e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 07:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748530124; x=1749134924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBsmbjEytXI5lPlclWLDjvJS/VjTPMVJlUM1wxzTmJ0=;
 b=RutV8nyMLk6rn8sEnCCxJG/SjZ3ps5R0g2fZAvleMMHCesIy/LvCuLFY4qxK6CATy6
 I1G5b2DC+zBXhd9rdjOD+wNsZq/LASbd0SeeXBxtgy1V5pfj38ISbYDV6sXDfDCSGqyw
 GDPl2kYBINvP2tzUaNmSyjvvCKkhr/5v/IJq+LlRndo2yXW8tAAzfElnv4tPjR/fcHo2
 +7QVxvzwpuQWVpl9jp2kRT5jV55cEWrivs0WM9oj53V3EwOg5a4u/iflH12cnm3GGUyC
 819IPRjwbZH/sOQukabH4fgjaN8XLd8JO2Rc46zmX8P3eXKS8hruWYmYLRwnsWaLfYa3
 Boew==
X-Gm-Message-State: AOJu0YyGyo5By47z1wTZmUtw5Me/IjSo0xlaKRZvU9jD5YMZrasANl2J
 etGOQfEYZnNsPrlIjb0zIgdm5buDrr+tTHgq0XhACm29j1tin97Ecd2i+MlFLhpK1ltHHO0BeVs
 3z/p5SvZ8eXfeU10LKqrKBZfYbPAztcQREG6Qp14BOdgOy92S+3b5v/mcEW4Jh4ceGIx2FQ==
X-Gm-Gg: ASbGncszr4h5D14WRufHzB61ZSXKgffu9fO/7u+OlMh6Fth2M+b5r/vuKxlW2ipsVIQ
 hZ774qKayJOQeoNborW1vv38AyDvn1ygrwB64VYRKGjjsro6VgWn5q5dKC1s4wZir5/qLXULcC6
 b/CtWOCH5Ojp+nY1kEJLsseGgSctkZwpTrrsme92CISGI6R4H+8lirtVjnxSZf1dfwKt86ir7oX
 MKLYssozgQH6RmJ8RUSOmzdZn1kbfeX/FQycAOo+9GXaJSQAAqSMlwW1ZRp/jraD/TxFT8qzezs
X-Received: by 2002:a05:600c:1988:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-450d654b6c4mr35745e9.19.1748530124391; 
 Thu, 29 May 2025 07:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQkgO83Zr2zizgu3Not4NSDAS9Twb9UMHsVW2a0QYRKU50xYB/IHY6ej5OAGM60kArWAT1pg==
X-Received: by 2002:a05:600c:1988:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-450d654b6c4mr35645e9.19.1748530123979; 
 Thu, 29 May 2025 07:48:43 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d637788asm979745e9.8.2025.05.29.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 07:48:43 -0700 (PDT)
Date: Thu, 29 May 2025 16:48:41 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 05/11] migration: Drop save_live_complete_postcopy hook
Message-ID: <hvfstra4oagwc5m6vojy5lpe5ro3qhjp7mr7sbawjwds7dxuyc@w656gwmgvs4i>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-6-peterx@redhat.com>
 <tew2ucyvg2z37rn6fvzwg6kj44crycegpc5jt4kd7unnyy3oqw@qaqb6towtfev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tew2ucyvg2z37rn6fvzwg6kj44crycegpc5jt4kd7unnyy3oqw@qaqb6towtfev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-05-29 16:42, Juraj Marcin wrote:
> Hi Peter
> 
> On 2025-05-27 17:58, Peter Xu wrote:
> > The hook is only defined in two vmstate users ("ram" and "block dirty
> > bitmap"), meanwhile both of them define the hook exactly the same as the
> > precopy version.  Hence, this postcopy version isn't needed.
> > 
> > No functional change intended.
> 
> Could be some future users, that would benefit from separate hooks for
> precopy and postcopy?
> 
> In case we are going to drop it, I think the '_precopy' suffix could be
> dropped too, as the handler would be used for postcopy too.

Never mind, just noticed it's in the next patch...

> 
> Best regards
> 
> Juraj Marcin
> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/migration/register.h   | 24 ++++++++----------------
> >  migration/block-dirty-bitmap.c |  1 -
> >  migration/ram.c                |  1 -
> >  migration/savevm.c             |  9 ++++-----
> >  4 files changed, 12 insertions(+), 23 deletions(-)
> > 
> > diff --git a/include/migration/register.h b/include/migration/register.h
> > index b79dc81b8d..e022195785 100644
> > --- a/include/migration/register.h
> > +++ b/include/migration/register.h
> > @@ -77,26 +77,18 @@ typedef struct SaveVMHandlers {
> >       */
> >      void (*save_cleanup)(void *opaque);
> >  
> > -    /**
> > -     * @save_live_complete_postcopy
> > -     *
> > -     * Called at the end of postcopy for all postcopyable devices.
> > -     *
> > -     * @f: QEMUFile where to send the data
> > -     * @opaque: data pointer passed to register_savevm_live()
> > -     *
> > -     * Returns zero to indicate success and negative for error
> > -     */
> > -    int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
> > -
> >      /**
> >       * @save_live_complete_precopy
> >       *
> >       * Transmits the last section for the device containing any
> > -     * remaining data at the end of a precopy phase. When postcopy is
> > -     * enabled, devices that support postcopy will skip this step,
> > -     * where the final data will be flushed at the end of postcopy via
> > -     * @save_live_complete_postcopy instead.
> > +     * remaining data at the end phase of migration.
> > +     *
> > +     * For precopy, this will be invoked _during_ the switchover phase
> > +     * after source VM is stopped.
> > +     *
> > +     * For postcopy, this will be invoked _after_ the switchover phase
> > +     * (except some very unusual cases, like PMEM ramblocks), while
> > +     * destination VM can be running.
> >       *
> >       * @f: QEMUFile where to send the data
> >       * @opaque: data pointer passed to register_savevm_live()
> > diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> > index f2c352d4a7..6ee3c32a76 100644
> > --- a/migration/block-dirty-bitmap.c
> > +++ b/migration/block-dirty-bitmap.c
> > @@ -1248,7 +1248,6 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
> >  
> >  static SaveVMHandlers savevm_dirty_bitmap_handlers = {
> >      .save_setup = dirty_bitmap_save_setup,
> > -    .save_live_complete_postcopy = dirty_bitmap_save_complete,
> >      .save_live_complete_precopy = dirty_bitmap_save_complete,
> >      .has_postcopy = dirty_bitmap_has_postcopy,
> >      .state_pending_exact = dirty_bitmap_state_pending,
> > diff --git a/migration/ram.c b/migration/ram.c
> > index fd8d83b63c..8b43b9e1e8 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -4545,7 +4545,6 @@ void postcopy_preempt_shutdown_file(MigrationState *s)
> >  static SaveVMHandlers savevm_ram_handlers = {
> >      .save_setup = ram_save_setup,
> >      .save_live_iterate = ram_save_iterate,
> > -    .save_live_complete_postcopy = ram_save_complete,
> >      .save_live_complete_precopy = ram_save_complete,
> >      .has_postcopy = ram_has_postcopy,
> >      .state_pending_exact = ram_state_pending_exact,
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 006514c3e3..26d32eb5a7 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1485,9 +1485,8 @@ bool should_send_vmdesc(void)
> >  }
> >  
> >  /*
> > - * Calls the save_live_complete_postcopy methods
> > - * causing the last few pages to be sent immediately and doing any associated
> > - * cleanup.
> > + * Complete saving any postcopy-able devices.
> > + *
> >   * Note postcopy also calls qemu_savevm_state_complete_precopy to complete
> >   * all the other devices, but that happens at the point we switch to postcopy.
> >   */
> > @@ -1497,7 +1496,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
> >      int ret;
> >  
> >      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> > -        if (!se->ops || !se->ops->save_live_complete_postcopy) {
> > +        if (!se->ops || !se->ops->save_live_complete_precopy) {
> >              continue;
> >          }
> >          if (se->ops->is_active) {
> > @@ -1510,7 +1509,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
> >          qemu_put_byte(f, QEMU_VM_SECTION_END);
> >          qemu_put_be32(f, se->section_id);
> >  
> > -        ret = se->ops->save_live_complete_postcopy(f, se->opaque);
> > +        ret = se->ops->save_live_complete_precopy(f, se->opaque);
> >          trace_savevm_section_end(se->idstr, se->section_id, ret);
> >          save_section_footer(f, se);
> >          if (ret < 0) {
> > -- 
> > 2.49.0
> > 


