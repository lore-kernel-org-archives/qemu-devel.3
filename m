Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69BEE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZW1-0001xn-Cx; Fri, 06 Dec 2024 09:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJZVz-0001xW-RT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJZVv-0005hz-Lr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733496062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlXUFZf53M46oTe6eWhmeU3xp5WvTMHxPU5SgkfQY4U=;
 b=QU2j74ZpN1PtzLn7ladO2HGT3f86dYibMlSUJ8KxG0BKLBhyR9Esdy5dlt/tGDzTokjqW+
 ttDMPEldF1nekw0mF3EqNHtegfZK6GLssil9lhKLwjOQY1LLDkJ0BhVOOG92C11cEG+5rB
 AVO83oxp1YEShI0EpB+x2/q+oAi3Rzw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-iZ0XEbebMzScAvSZ1Evg2g-1; Fri, 06 Dec 2024 09:41:00 -0500
X-MC-Unique: iZ0XEbebMzScAvSZ1Evg2g-1
X-Mimecast-MFC-AGG-ID: iZ0XEbebMzScAvSZ1Evg2g
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-466afab5886so47352491cf.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496060; x=1734100860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlXUFZf53M46oTe6eWhmeU3xp5WvTMHxPU5SgkfQY4U=;
 b=Ts5XhFbkGXGXIvLd94FvlqNGuMDCyqJTIMYAzmzyBT+aTEwlOxGjGuSoFOSiXu6hZR
 XrxvYkt5dPqj7RhcseBEjJ+rDBTFVaB4ev1ezu9BqWGsybGvGpww7FNr2s+jgviKoEqp
 AqJrCkt/PbV6LHxleHMYDstd/L9nzO2pltwJnieWZgqCR8eI/wpuhRUtLAckH286m+wE
 gT4RlVjYYDaB+qRbjPCcD92g/OsvYgaGx909atu2BiPmDppWyAPBBcqH99eKbAmNMo6v
 2kEwbgiWQ8FJ1s5IOJqKddpAalCDco8luXP2LsYlFOWEfu8x9VzsK8S0GySafl/lKgK9
 +46Q==
X-Gm-Message-State: AOJu0YyoKH7U6e1BveZunHZZZGiqPKsDdJzJ0PDSdEz+rMI7SUGJ/Bpr
 0R8gWEN3sSDqxwtCcvZvOcYgotENFktlL/73AxBtAxZj2PnxHZYA0ZoDSDbGoBG6Yka8/idUyCn
 1PD6DGTSUTna1M8nfM8iEuix0liYz0c75C2Aji0+GRPR5kdeeV84/
X-Gm-Gg: ASbGnctoP/bKsYa8NuMCaTTF1w20nYt5KNwzMVV8a0hyEV50e4asD5nycW6ammhMXD/
 F5R7Jw7IddD19TbIbEighUDFHiKQ2Tgi2iX1dozR4H/5mE7sFDEABp3Ir0X2Q+TJX50zmgwhe5b
 XWcH3avX82m8xj8gOjAe87A48O94II12mXQrLigADbXh7ZT6kp8y2shc2YX3+chIJ9syyMiMG44
 yHhA4Thj6lqImIvINBEMENIH6oKWReP+6TiQxRWuvCONMxK5E6+5iZxxtJsil2mBiuAZ2JVb1mJ
 rXCqzOmHlqA=
X-Received: by 2002:a05:622a:610e:b0:466:8cc1:6221 with SMTP id
 d75a77b69052e-46734fa992bmr69099561cf.50.1733496060222; 
 Fri, 06 Dec 2024 06:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdMpKccL+XMujrCPgZHGV/8SqAeJ3EXrHJcR2zWnF17hms4am6AglPzFnte2h0z5mpFoTaUA==
X-Received: by 2002:a05:622a:610e:b0:466:8cc1:6221 with SMTP id
 d75a77b69052e-46734fa992bmr69098951cf.50.1733496059770; 
 Fri, 06 Dec 2024 06:40:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46729793741sm21420811cf.61.2024.12.06.06.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 06:40:58 -0800 (PST)
Date: Fri, 6 Dec 2024 09:40:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/7] migration/multifd: Further remove the SYNC on
 complete
Message-ID: <Z1MM-LqLTYWv7ztO@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-2-peterx@redhat.com>
 <87a5d9c5nh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5d9c5nh.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Dec 06, 2024 at 10:17:22AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
> > complete()") removed the FLUSH operation on complete() which should avoid
> > one global sync on destination side, because it's not needed.
> >
> > However that commit overlooked multifd_ram_flush_and_sync() part of things,
> > as that's always used together with the FLUSH message on the main channel.
> >
> > For very old binaries (multifd_flush_after_each_section==true), that's
> > still needed because each EOS received on destination will enforce
> > all-channel sync once.
> >
> > For new binaries (multifd_flush_after_each_section==false), the flush and
> > sync shouldn't be needed just like the FLUSH, with the same reasoning.
> >
> > Currently, on new binaries we'll still send SYNC messages on multifd
> > channels, even if FLUSH is omitted at the end.  It'll make all recv threads
> > hang at SYNC message.
> >
> > Multifd is still all working fine because luckily recv side cleanup
> > code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
> > recv threads are stuck at SYNC it'll get kicked out.  And since this is the
> > completion phase of migration, nothing else will be sent after the SYNCs.
> >
> > This may be needed for VFIO in the future because VFIO can have data to
> > push after ram_save_complete(), hence we don't want the recv thread to be
> > stuck in SYNC message. Remove this limitation will make src even slightly
> > faster too to avoid some more code.
> >
> > Stable branches do not need this patch, as no real bug I can think of that
> > will go wrong there.. so not attaching Fixes to be clear on the backport
> > not needed.
> 
> You forgot my comments on the commit message, so here's a brand-new one

Yes I did.. :(

> with some things spelt out more explicitly:
> 
> --
> Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
> complete()") stopped sending the RAM_SAVE_FLAG_MULTIFD_FLUSH flag at
> ram_save_complete(), because the sync on the destination side is not
> needed due to the last iteration of find_dirty_block() having already
> done it.
> 
> However, that commit overlooked that multifd_ram_flush_and_sync() on the
> source side is also not needed at ram_save_complete(), for the same
> reason.
> 
> Moreover, removing the RAM_SAVE_FLAG_MULTIFD_FLUSH but keeping the
> multifd_ram_flush_and_sync() means that currently the recv threads will
> hang when receiving the MULTIFD_FLAG_SYNC message, waiting for the
> destination sync which only happens when RAM_SAVE_FLAG_MULTIFD_FLUSH is
> received.
> 
> Luckily, multifd is still all working fine because recv side cleanup
> code (mostly multifd_recv_sync_main()) is smart enough to make sure even
> if recv threads are stuck at SYNC it'll get kicked out. And since this
> is the completion phase of migration, nothing else will be sent after
> the SYNCs.
> 
> This needs to be fixed because in the future VFIO will have data to push
> after ram_save_complete() and we don't want the recv thread to be stuck
> in the MULTIFD_FLAG_SYNC message.
> 
> Remove the unnecessary (and buggy) invocation of
> multifd_ram_flush_and_sync().
> 
> For very old binaries (multifd_flush_after_each_section==true), the
> flush_and_sync is still needed because each EOS received on destination
> will enforce all-channel sync once.
> 
> Stable branches do not need this patch, as no real bug I can think of
> that will go wrong there.. so not attaching Fixes to be clear on the
> backport not needed.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Sure, I used it, thanks.

> 
> > ---
> >  migration/ram.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 05ff9eb328..7284c34bd8 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >          }
> >      }
> >  
> > -    ret = multifd_ram_flush_and_sync();
> > -    if (ret < 0) {
> > -        return ret;
> > +    if (migrate_multifd() &&
> > +        migrate_multifd_flush_after_each_section()) {
> > +        /*
> > +         * Only the old dest QEMU will need this sync, because each EOS
> > +         * will require one SYNC message on each channel.
> > +         */
> > +        ret = multifd_ram_flush_and_sync();
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> >      }
> >  
> >      if (migrate_mapped_ram()) {
> 

-- 
Peter Xu


