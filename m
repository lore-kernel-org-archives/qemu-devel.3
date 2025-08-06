Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB44C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 09:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujatk-0000ZI-LI; Wed, 06 Aug 2025 05:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujatW-0000Sv-Ng
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujatS-0007nf-0z
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 05:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754474228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwbVfgaLvnTNbCIb1YKvkI/Xqxftrcyjv41jlngmJJg=;
 b=d+F7Z/23/tVQtLaN1KAg+AT7WW3jsWFpr+jE0LMU8ybmeAyTtkUjL8ElGOt9MNWDtVTbU6
 B8FDhwpsCPabkcrU5TRNrY13mCAljMH3fsMzXKOZa5cWflKQ3vio3Q/1MYYLUlueu7Ip4J
 qctK2hlIGRKeZ0SJ3Y5jtqgJbPsWSbE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-Ct6tsZjqOOGBB757M_uUBA-1; Wed, 06 Aug 2025 05:57:07 -0400
X-MC-Unique: Ct6tsZjqOOGBB757M_uUBA-1
X-Mimecast-MFC-AGG-ID: Ct6tsZjqOOGBB757M_uUBA_1754474226
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-31f3b65ce07so10598033a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 02:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754474226; x=1755079026;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VwbVfgaLvnTNbCIb1YKvkI/Xqxftrcyjv41jlngmJJg=;
 b=CAZEeqvIsnlhbqYRsPC4gzjpXFVT7COZfJU0DIoysSDOmrZuSrWBxla3SWoaCP3Gw+
 54OtKAxy2EZELufa97QF4mRHd6zdyICrfsh5bQnk5Uy8HAa2HNsJmh8gl/TXMDFYPDxl
 Y9NoGgppvS40BoJwYaZexW7g7C3qva+GHC1AtF/LFggGmj3EB4PwMbCuYMeAEIgAiOa1
 yq2TIT0gWuonyw4iSGCbFwxvTii2za0Pj0NQJkFrKiAruJSUZSk9dsv0AQH9cpuH8VwU
 ol1LAh0nOVwYTj4wiy/Hz8CZ3Xqn8hn8V3nrdUWZqNgvqJZUQGhX28rgYC+uEtHLeAKh
 VsIw==
X-Gm-Message-State: AOJu0YxMC+8sYUm6j9JiG+BGyEclYgJ8+sZI4czBU88nuTfyaZKhyAad
 Miqn9G7PyULud67t72JSyNmKou2Ezjr7KKPmnP0Zl5jyKCOvk2DMQIrlUSKuYgmPVxWDDTrcFzo
 0fBC77GVxt7ZNE4f1f3jI8vs5rbjr9EyuzfKxCa1nAVuqLlz7AsZht0Jh
X-Gm-Gg: ASbGncv4jqx9Gl9mIFJztmefgRF3zVjPJheE1ktF6eTxjGyCGaYpYecwgWjkjw2w+9n
 3D0QVUpm0HXa7xGfFAVkJf1kz+2lehUE51PspIErhmFxmZjqjKM3nvSP1pU/IXJUvoLYEvg5r2I
 Bl463k4YIjIFdgmnLIvDBdARVoMF8FMkCa+FoxjJodLw2ez8oploHuRCbltlR4bSxLL1kGwUZYM
 FH/TCz4REIy6sbXNpVBX5TdKPLt6/CCy3r9pG0zL4bKmhs0d3RXQLN54Bvvwh1BnICu/xyzb47j
 Xy4AwAw5CLkEVi7BnPq5UJJDXYEnXtQFpRon4+amXK9fB/trUeiI9Q==
X-Received: by 2002:a17:903:2447:b0:234:d292:be95 with SMTP id
 d9443c01a7336-2429f53c1b6mr37269065ad.42.1754474226057; 
 Wed, 06 Aug 2025 02:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjlQQwt7xQd9dt/JPIcGCC8ynfr1ytnB2wR+lgqAG5PqMfIFlhjurQtwaeuXD3hZEKqCrpbQ==
X-Received: by 2002:a17:903:2447:b0:234:d292:be95 with SMTP id
 d9443c01a7336-2429f53c1b6mr37268765ad.42.1754474225596; 
 Wed, 06 Aug 2025 02:57:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6bcfsm155833195ad.5.2025.08.06.02.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:57:05 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:26:53 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 20/27] migration: push Error **errp into
 loadvm_process_enable_colo()
Message-ID: <aJMm5Qfdegtu9VNN@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-20-123450810db7@redhat.com>
 <CAMxuvazyJ89i=Yw1j49hSCmBvnuqeB+dMG3ms0=NjzhaB9Uw-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazyJ89i=Yw1j49hSCmBvnuqeB+dMG3ms0=NjzhaB9Uw-A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Marc-André,
Thanks for the review and the Reviewed-by tag.

On Wed, Aug 06, 2025 at 12:07:25PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 5, 2025 at 10:31 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that loadvm_process_enable_colo() must report an error
> > in errp, in case of failure.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> >
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 
> > ---
> >  include/migration/colo.h |  2 +-
> >  migration/migration.c    | 12 ++++++------
> >  migration/ram.c          |  8 ++++----
> >  migration/ram.h          |  2 +-
> >  migration/savevm.c       | 26 ++++++++++++++------------
> >  5 files changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/migration/colo.h b/include/migration/colo.h
> > index
> > 43222ef5ae6adc3f7d8aa6a48bef79af33d09208..d4fe422e4d335d3bef4f860f56400fcd73287a0e
> > 100644
> > --- a/include/migration/colo.h
> > +++ b/include/migration/colo.h
> > @@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
> >  bool migration_in_colo_state(void);
> >
> >  /* loadvm */
> > -int migration_incoming_enable_colo(void);
> > +int migration_incoming_enable_colo(Error **errp);
> >  void migration_incoming_disable_colo(void);
> >  bool migration_incoming_colo_enabled(void);
> >  bool migration_incoming_in_colo_state(void);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index
> > 6962dc7d7f3e0121d28994c98f12f9f2258343d7..4a76d7ed730589bae87115368b0bf4819f8b161e
> > 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -623,22 +623,22 @@ void migration_incoming_disable_colo(void)
> >      migration_colo_enabled = false;
> >  }
> >
> > -int migration_incoming_enable_colo(void)
> > +int migration_incoming_enable_colo(Error **errp)
> >  {
> >  #ifndef CONFIG_REPLICATION
> > -    error_report("ENABLE_COLO command come in migration stream, but the "
> > -                 "replication module is not built in");
> > +    error_setg(errp, "ENABLE_COLO command come in migration stream, but
> > the "
> > +               "replication module is not built in");
> >      return -ENOTSUP;
> >  #endif
> >
> >      if (!migrate_colo()) {
> > -        error_report("ENABLE_COLO command come in migration stream, but
> > x-colo "
> > -                     "capability is not set");
> > +        error_setg(errp, "ENABLE_COLO command come in migration stream"
> > +                   ", but x-colo capability is not set");
> >          return -EINVAL;
> >      }
> >
> >      if (ram_block_discard_disable(true)) {
> > -        error_report("COLO: cannot disable RAM discard");
> > +        error_setg(errp, "COLO: cannot disable RAM discard");
> >          return -EBUSY;
> >      }
> >      migration_colo_enabled = true;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index
> > 6a0dcc04f436524a37672c41c38f201f06773374..995431c9e320f443c385c29d664d62e18c1afd90
> > 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -3576,7 +3576,7 @@ static void colo_init_ram_state(void)
> >   * memory of the secondary VM, it is need to hold the global lock
> >   * to call this helper.
> >   */
> > -int colo_init_ram_cache(void)
> > +int colo_init_ram_cache(Error **errp)
> >  {
> >      RAMBlock *block;
> >
> > @@ -3585,9 +3585,9 @@ int colo_init_ram_cache(void)
> >              block->colo_cache = qemu_anon_ram_alloc(block->used_length,
> >                                                      NULL, false, false);
> >              if (!block->colo_cache) {
> > -                error_report("%s: Can't alloc memory for COLO cache of
> > block %s,"
> > -                             "size 0x" RAM_ADDR_FMT, __func__,
> > block->idstr,
> > -                             block->used_length);
> > +                error_setg(errp, "Can't alloc memory for COLO cache of "
> > +                           "block %s, size 0x" RAM_ADDR_FMT,
> > +                           block->idstr, block->used_length);
> >                  RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> >                      if (block->colo_cache) {
> >                          qemu_anon_ram_free(block->colo_cache,
> > block->used_length);
> > diff --git a/migration/ram.h b/migration/ram.h
> > index
> > 275709a99187f9429ccb4111e05281ec268ba0db..24cd0bf585762cfa1e86834dc03c6baeea2f0627
> > 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -109,7 +109,7 @@ void ramblock_set_file_bmap_atomic(RAMBlock *block,
> > ram_addr_t offset,
> >                                     bool set);
> >
> >  /* ram cache */
> > -int colo_init_ram_cache(void);
> > +int colo_init_ram_cache(Error **errp);
> >  void colo_flush_ram_cache(void);
> >  void colo_release_ram_cache(void);
> >  void colo_incoming_start_dirty_log(void);
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index
> > 938adb20270adbf9546b0884d0877c25c3f0f816..a6b71a958aeda31e89043f8103bfe2fc89542fb5
> > 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2519,15 +2519,21 @@ static int
> > loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
> >      return 0;
> >  }
> >
> > -static int loadvm_process_enable_colo(MigrationIncomingState *mis)
> > +static int loadvm_process_enable_colo(MigrationIncomingState *mis,
> > +                                      Error **errp)
> >  {
> > -    int ret = migration_incoming_enable_colo();
> > +    ERRP_GUARD();
> > +    int ret;
> >
> > -    if (!ret) {
> > -        ret = colo_init_ram_cache();
> > -        if (ret) {
> > -            migration_incoming_disable_colo();
> > -        }
> > +    ret = migration_incoming_enable_colo(errp);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    ret = colo_init_ram_cache(errp);
> > +    if (ret) {
> >
> 
> Note: here you keep the "ret" error condition !=0, ok.
> 
> colo_init_ram_cache(), returns -errno on error. Although errno should
> remain unchanged on success (during qemu_anon_ram_free etc), I think it
> would be safer to convert the function to follow the recommended
> bool-valued function for true on success / false on failure instead.

There has been some discussion on this here:
https://lore.kernel.org/all/aH5AtUcjI3HYXdBe@redhat.com/
It has been advised not to use bool return.

> 
> 
> > +        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
> > +        migration_incoming_disable_colo();
> >
>      }
> >      return ret;
> >  }
> > @@ -2646,11 +2652,7 @@ static int loadvm_process_command(QEMUFile *f,
> > Error **errp)
> >          return loadvm_handle_recv_bitmap(mis, len, errp);
> >
> >      case MIG_CMD_ENABLE_COLO:
> > -        ret = loadvm_process_enable_colo(mis);
> > -        if (ret < 0) {
> > -            error_setg(errp, "Failed to load device state command: %d",
> > ret);
> > -        }
> > -        return ret;
> > +        return loadvm_process_enable_colo(mis, errp);
> >
> >      case MIG_CMD_SWITCHOVER_START:
> >          ret = loadvm_postcopy_handle_switchover_start();
> >
> > --
> > 2.50.1
> >
> >
Regards,
Arun


