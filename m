Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB37F43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgHB-0008Ds-9Q; Fri, 17 Apr 2026 06:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wDgH9-0008AV-3g
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wDgH6-0001jk-RD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776421091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz8pzmkAWRtvA0sk2nclTVOH5AaK4kArC8OzgvFo0do=;
 b=Di+bLhgcRp3Y/ZpeDlsZ2TEN8DBBuoiewdUC7O1Fl7op2myhAHFCIaMwTVi0BkA+tKMMrs
 6uDOVdYWa/p3Ek4pi6EzeSjZGahuo9uP6XTRMNBSo2lk9DJC8Md1nmbCjeR3M9yFHkSgOZ
 oIWV32kT4EpxS+VEUGWBy7OGbC4wUNw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-nbHprbRzP5uXGRoDzn1xUg-1; Fri, 17 Apr 2026 06:18:09 -0400
X-MC-Unique: nbHprbRzP5uXGRoDzn1xUg-1
X-Mimecast-MFC-AGG-ID: nbHprbRzP5uXGRoDzn1xUg_1776421089
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d4ac6ff9so4115325e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776421088; x=1777025888; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Oz8pzmkAWRtvA0sk2nclTVOH5AaK4kArC8OzgvFo0do=;
 b=Kf7SVTTQDX/FyMoAAlF8yrcqUi/iL1XGHKKtdG5qwaIlm/hj12vQGG8TFjIkptFMSm
 dcJCHuToWcx5qbvvY+zeChgr6EgYMscPRk7rE509pgNW0XmncnvGpdi7u5/1LD0B9p9l
 UzpSftvb7m2Wl/3hPucCNRvi2eT1ixUreuUrVoKitoi5vbRAbf/XTtLIearhbAXjCMHC
 sHE0Ns3A8Qccu2kWJLVkDvGzkAivzoe+MaKhFGBnJio1ITghOX2MZrZyo0EBnkpXLlqj
 abQGOT6rt1XGz4NQ9DKFwRLK1BIxMS5iaa0cZeTSvgciBcC4lTzJ955Og5TvnvCke6hQ
 2Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776421088; x=1777025888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oz8pzmkAWRtvA0sk2nclTVOH5AaK4kArC8OzgvFo0do=;
 b=UkbH8/sds18F9v/rsyer9dflChuyGZCs7nI6MLUi7RyASZVjtffKXP2mYhRAf9NxVa
 OrgR2aLoFvAAjQM3GS7f5Kjdj2GTJalpISV6Z+tRQGnFsyW/RjtJwFFns8GPQb+MR0LJ
 NLruEzjzzx0Xnddgh6VPIkzrm6HKB50F17g4CQVQTHG3a+syo46/5IfquZz8pM7DEA9k
 O9DGR1ohB1pXY+68v2sFSp4qykLOpA+erccNRAWvgnAoqlhSYspwlFZh/5fo9c6bI1SM
 RMRuL+NaVPlnIpIb/ZuXW68PAJeniiaADxpjNhn05LF8M8pPHwdmf8qJVp2CyhT/uC75
 kNwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y7FiSG+mLg1xcZel5ga854gxbpjBpLvxM3xjxKNXESMQyI/3Q39MG3WE+NixdhNnSriP00vGoIR2l@nongnu.org
X-Gm-Message-State: AOJu0Yyri8bshJEbwBqArRFWRbLZyYMbS9cANdA6vvS1+vhbbeoa9PM0
 c+YQP4fXA6x+ZFZsXa9hUTZzJ4fnAUcqZVVMseYnkaFjap2Kq6bCDkssxDcAqhsc3JCYOAeyjkP
 qsrOjJLEi9Vp6dwIKEcZPEsg6kdohnIpxf1lwitwHUrNi8Fyhpux3UWtF
X-Gm-Gg: AeBDietZDvjN5oJi6R7wJG7VNdgcF0ET0ufzVEciS2DFmxrbhyQZI747mLT2kxWr4G2
 Dsr6DDgs8lTH7yK7okjr7m/H0nkP7fKbN5X/lkLJEww954IBk0X7nV9bn++0cv5XjBGTUWt/xEL
 zPeGjBD9ieTffxyPnnEfUGFffv/XTnZwn5TZEF6oLDII7tQy5vPrGu5zXu3SOmCZNRSJkWaHb+S
 oaup78cRInLdlFWSRKhDSlW2jv40yupve6+u0VTrpFgoyYJnSP0yf/xVnK0RwX0/cfAGhDZCmMr
 XZYC/WYJVDd7bIc2rriSWxChGZjBHC8+XAvFyMXqXy8e42+dOXSm0RhxF2/VIZAI3qAtEIgHpVX
 A00EvTByHTqH5
X-Received: by 2002:a05:600c:4f0e:b0:488:945a:ed63 with SMTP id
 5b1f17b1804b1-488fb6e8491mr34383645e9.0.1776421088442; 
 Fri, 17 Apr 2026 03:18:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:488:945a:ed63 with SMTP id
 5b1f17b1804b1-488fb6e8491mr34383175e9.0.1776421087933; 
 Fri, 17 Apr 2026 03:18:07 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fe29bd0csm7368125e9.2.2026.04.17.03.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:18:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 12:18:04 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>, 
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>, 
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 06/14] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <aeH2m6r-m8uz2PcJ@fedora>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-7-peterx@redhat.com>
 <adfhtgEeWtsMxEmv@fedora> <aeEaXLXGokjjODKR@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeEaXLXGokjjODKR@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-04-16 13:20, Peter Xu wrote:
> On Thu, Apr 09, 2026 at 07:36:51PM +0200, Juraj Marcin wrote:
> > Hi Peter,
> > 
> > actually, I do have one question, see inline
> 
> [...]
> 
> > shouldn't also the condition that triggers postcopy migration be updated?
> > As total_bytes is calculated as sum of all three
> > (precopy_bytes + stopcopy_bytes + postcopy_bytes), this implies to me
> > that stopcopy_bytes is not subset of precopy_bytes and would also need
> > to be migrated during switchover before postcopy.
> 
> For now it shouldn't matter when VFIO never works with postcpoy yet, but
> it's a good point. We'd better make it right from the start.
> 
> When looking at this, I also found we may be reporting wrong things in the
> query results when pmem is available on postcopy bits, it's about when this
> hits:
> 
> static bool ram_has_postcopy(void *opaque)
> {
>     RAMBlock *rb;
>     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
>         if (ram_block_is_pmem(rb)) {
>             info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
>                          "is not supported now!", rb->idstr, rb->host);
>             return false;
>         }
>     }
> 
>     return migrate_postcopy_ram();
> }
> 
> So I think we should also report differently based on whether pmem is
> present in ramblocks.. IOW, I think the module should make sure its
> save_query_pending() to match its has_postcopy() when they're both present.
> Or, maybe we don't even need has_postcopy()..

Yeah, it looks like ram_state_pending() should use ram_has_postcopy()
instead of just migrate_postcopy_ram().

> 
> If it's a problem, it should be an old problem.  Let me address the
> comments so far on this patch, so a fixup planned to be squashed (I also
> added the trace parameter Avihai requested), feel free to comment before I
> repost, thanks.
> 
> From 594b85b66b2d1abd9a38fae4051e01ffc73aa8ff Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 16 Apr 2026 13:09:16 -0400
> Subject: [PATCH] fixup! migration: Introduce stopcopy_bytes in
>  save_query_pending()
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  | 13 +++++++++++--
>  migration/savevm.c     |  3 ++-
>  migration/trace-events |  2 +-
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c2aa145106..62299ff3c0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3276,6 +3276,16 @@ static void migration_iteration_go_next(MigPendingData *pending)
>      }
>  }
>  
> +static bool postcopy_should_start(MigrationState *s, MigPendingData *pending)
> +{
> +    /* If postcopy's switchver will violate user specified downtime, stop */
> +    if (pending->precopy_bytes + pending->stopcopy_bytes > s->threshold_size) {
> +        return false;
> +    }
> +
> +    return qatomic_read(&s->start_postcopy);
> +}
> +
>  /*
>   * Return true if continue to the next iteration directly, false
>   * otherwise.
> @@ -3323,8 +3333,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>          }
>  
>          /* Should we switch to postcopy now? */
> -        if (pending.precopy_bytes <= s->threshold_size &&
> -            can_switchover && qatomic_read(&s->start_postcopy)) {
> +        if (can_switchover && postcopy_should_start(s, &pending)) {
>              if (postcopy_start(s, &local_err)) {
>                  migrate_error_propagate(s, error_copy(local_err));
>                  error_report_err(local_err);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1d3fce45b9..7f38be0ee1 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1804,7 +1804,8 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>  
>      trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
>                                      pending->stopcopy_bytes,
> -                                    pending->postcopy_bytes);
> +                                    pending->postcopy_bytes,
> +                                    pending->total_bytes);
>  }
>  
>  void qemu_savevm_state_cleanup(MigrationState *s)
> diff --git a/migration/trace-events b/migration/trace-events
> index 2f86ad448e..d2134af862 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>  qemu_loadvm_state_post_main(int ret) "%d"
>  qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>  qemu_savevm_send_packaged(void) ""
> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
> +qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>  loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>  loadvm_state_setup(void) ""
>  loadvm_state_cleanup(void) ""
> -- 
> 2.53.0

The fixup looks good, thanks!

> 
> 
> -- 
> Peter Xu
> 


