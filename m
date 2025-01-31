Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B2C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 13:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrIT-0006LF-4s; Fri, 31 Jan 2025 08:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tdrIK-0006GP-DQ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:42:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1tdrIH-0003HO-Sd
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 08:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738330968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rxxu/HKSzvabWAfj+7HzGtVkdfdSe232n/q0EHOblQo=;
 b=Rz4jC/ShwkaPGzS9r78XTV2rq+4NOdB+rWc4tQKaOGU6HvEz+8OiB7JkzReboa/9/0rqOI
 ImhvHYgkegOyS/18e52CfWJuDAzqvrHG98MvYTaQG4rCv+RjK0RVVYSZ+bXi/RO2PVYjxC
 RRXNvJO0XEWPdnYoc8E2P1rX9/cXVU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-dr6xkeT-Pbe-xwnK7rm86w-1; Fri, 31 Jan 2025 08:42:46 -0500
X-MC-Unique: dr6xkeT-Pbe-xwnK7rm86w-1
X-Mimecast-MFC-AGG-ID: dr6xkeT-Pbe-xwnK7rm86w
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43621907030so17512835e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 05:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738330965; x=1738935765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxxu/HKSzvabWAfj+7HzGtVkdfdSe232n/q0EHOblQo=;
 b=JdAZk2R/xFH7jrHSBW8E8cvf7x90vZ6GAR1CZZCUV38VUQKa4nnyXXmpv2ZxktIgsV
 +dJV5MIgpe3u2XAuCIpGAFY2q/OQYbsnEWat+MqaIR9w83VNJsyYDOOo75qKNbbueNPm
 r2nyN+1jA1Wg6GH+d68da05ItzRNbMUwc4hJEhW6zSFrt4nr+m//tvw5lR0Kw9cbrAEL
 Wu/hJIR7odri0Bxg2IA5ChawEAWVFSJ21VVFsDA+Bw02F5tAWQ3THHjU3K85SqJ5cWIu
 Q6cMFnYIZpbx7y0par/Dc1F74YdXqh9iwXayHFMOR8zMTFVAoN8Vf/SaFMduBurcaBx2
 ETRQ==
X-Gm-Message-State: AOJu0YzakNCvbRTrjdvjohGnL8JbmHmV1Nvq+iff4NjR/gj8d3RZ+1sT
 d/TEFdGJ/aLA3WWnIWkDYT+/z4Y9VVpzQmyRR4biWWhk8B3ferpx73gBggdDHUxPsYdI1uV15gW
 8bRWrrmjeNsD9M0IRJcLUI9QMbk/lNQH13+NffpFuf2BhcON3lJG/
X-Gm-Gg: ASbGncvo3w7vdwElWapBIDpOaKmpC5UeliNzAcixFyQTQKOCBxQUPK3htO0utRgaGiA
 6n6BMD7PvKE8Y400CqVM7+dMZZpwk24F2nqrQYOijiCjI69LJ7J3D7XT5VEiMg8ImqDuiBRvyp8
 yqlCYJh/BZkfDBbs6f4OboD8jE9Q0yPo4pX122Nb/OYQoTPvUGxzUV4xtMoJMPtAjMODHPmMMQ7
 ILFBcUH95Wa252rEwAsVzqhNKHwSQVlTsw2adoK3lsUs5n6C6RJiEqvcf41KBcm+bPSlDSg/SXW
 wgZa+GSk55tqSXa0r4wDyFpzhQ==
X-Received: by 2002:a05:600c:5027:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-438dc40d36emr108799475e9.24.1738330964749; 
 Fri, 31 Jan 2025 05:42:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhJlmiT8x0W/aIxZzCuFycpG45Dx4olDqbPwe/MAEZNJHBhgvAG/KvRfznIeQtJdCJCAgnFg==
X-Received: by 2002:a05:600c:5027:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-438dc40d36emr108799165e9.24.1738330964309; 
 Fri, 31 Jan 2025 05:42:44 -0800 (PST)
Received: from rh-jmarcin (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23deddcsm55383755e9.14.2025.01.31.05.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 05:42:43 -0800 (PST)
Date: Fri, 31 Jan 2025 14:42:41 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Add keepalive messages from dst to src during
 postcopy
Message-ID: <5epliohdmjfh4gctt55qqm4we6abn4sfuc47ixvuoau2ztdwhx@uqvlx4m4mqlm>
References: <20250130161139.548078-1-jmarcin@redhat.com>
 <Z5vpTx3d3MYQL2pi@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5vpTx3d3MYQL2pi@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2025-01-30 16:04, Peter Xu wrote:
> On Thu, Jan 30, 2025 at 05:11:36PM +0100, Juraj Marcin wrote:
> > When there are no page requests from the destination side and the
> > connection breaks, the destination might not be aware of it. This is
> > the case for example with a TCP connection, which by default remains
> > open unless it is explicitly closed or the TCP stack fails to
> > successfully send a packet.
> > 
> > Such situation without any traffic from the destination to the source
> > side can happen for multiple reasons. For example, if all pages accessed
> > at idle are already migrated, but there are still non-migrated pages
> > that are accessed very infrequently, or if the destination QEMU is
> > started with '-S' option and the management application does not run
> > the 'cont' QMP command right away.
> > 
> > Due to this, the destination side might not know about the network
> > failure and stays in the postcopy-active state instead of switching
> > to the postcopy-paused state, informing the destination management
> > application about the issue.
> > 
> > This patch resolves this by sending a keepalive message on the return
> > path to the source if there is no page fault (thus page request message)
> > in a certain amount of time. This wait time can be configured with new
> > 'postcopy-rp-keepalive-period' migration parameter, by default it is
> > 60000 ms. By setting this parameter to 0, sending keepalive messages
> > can be disabled completely.
> 
> Hmm, I see.. Does it mean it would also work if we leverage tcp keepalive
> events?  I just checked on my system, indeed it can at least be too large a
> default value:
> 
> $ sysctl net.ipv4.tcp_keepalive_time
> net.ipv4.tcp_keepalive_time = 7200
> 
> I wonder if it makes more sense to set it to a smaller value.  What you
> proposed here (60s) as default sounds more reasonable indeed at least to
> me.
> 
> Is that a concern (e.g. tcp keepalive not enabled, or timeout too large) so
> that maybe it's better we have our own way to timeout the session?  If so,
> maybe worthwhile to add some comment on that.

Accepting or relaying TCP keepalive packets is not required by the RFC
and is not enabled on sockets used (at least on the destination side,
which I cheked). Therefore, I opted to implement it at higher layer,
migration protocol itself. I can mention it the commit message.

However, even with 60s keepalive period, the time it takes for the TCP
stack to give up trying to send a packet can be around 15-20 minutes.
This could be possibly configured at socket level with
'TCP_USER_TIMEOUT' socket option.

> 
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  migration/migration.c    | 12 ++++++++++++
> >  migration/migration.h    |  1 +
> >  migration/options.c      | 35 +++++++++++++++++++++++++++++++++++
> >  migration/options.h      |  1 +
> >  migration/postcopy-ram.c | 15 ++++++++++++++-
> >  migration/trace-events   |  2 ++
> >  qapi/migration.json      | 35 ++++++++++++++++++++++++++++++++---
> >  7 files changed, 97 insertions(+), 4 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 2d1da917c7..ef049efd0a 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -89,6 +89,8 @@ enum mig_rp_message_type {
> >      MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
> >      MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
> >  
> > +    MIG_RP_MSG_KEEPALIVE, /* Keepalive message from destination to source */
> > +
> >      MIG_RP_MSG_MAX
> >  };
> >  
> > @@ -471,6 +473,12 @@ static int migrate_send_rp_message(MigrationIncomingState *mis,
> >      return qemu_fflush(mis->to_src_file);
> >  }
> >  
> > +void migrate_send_rp_keepalive(MigrationIncomingState *mis)
> > +{
> > +    trace_migrate_send_rp_keepalive();
> > +    migrate_send_rp_message(mis, MIG_RP_MSG_KEEPALIVE, 0, NULL);
> > +}
> > +
> >  /* Request one page from the source VM at the given start address.
> >   *   rb: the RAMBlock to request the page in
> >   *   Start: Address offset within the RB
> > @@ -2399,6 +2407,10 @@ static void *source_return_path_thread(void *opaque)
> >              trace_source_return_path_thread_switchover_acked();
> >              break;
> >  
> > +        case MIG_RP_MSG_KEEPALIVE:
> > +            trace_source_return_path_thread_received_keepalive();
> > +            break;
> > +
> >          default:
> >              break;
> 
> So we ignore unknown messages on return path.  I didn't expect it, but
> looks like it means we can enable this without worrying about compatibility
> with older QEMU binaries, am I right?

I also thought this and it seemed to be working when I tested it, but
actually it isn't the case. Due to 'header_type >= MIG_RP_MSG_MAX'
condition after reading the header type, the return path on the source
side fails. So we need to change the default to 0, so it is disabled by
default.

> 
> If so, worth add a sentence in the commit message for it too.
> 

But I will mention in the commit message and documentation that this is
not compatible with older source side QEMU binaries.

> >          }
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 0df2a187af..4ec7c63fc4 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -503,6 +503,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
> >                            uint32_t value);
> >  void migrate_send_rp_pong(MigrationIncomingState *mis,
> >                            uint32_t value);
> > +void migrate_send_rp_keepalive(MigrationIncomingState *mis);
> >  int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
> >                                ram_addr_t start, uint64_t haddr);
> >  int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> > diff --git a/migration/options.c b/migration/options.c
> > index b8d5300326..4df973467f 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -85,6 +85,12 @@
> >  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
> >  #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
> >  
> > +/*
> > + * Time in milliseconds for periodic keepalive message from destination to
> > + * source during postcopy if there is no other traffic, 0: no keepalive messages
> > + */
> > +#define DEFAULT_MIGRATE_POSTCOPY_RP_KEEPALIVE_PERIOD 60000
> > +
> >  const Property migration_properties[] = {
> >      DEFINE_PROP_BOOL("store-global-state", MigrationState,
> >                       store_global_state, true),
> > @@ -172,6 +178,9 @@ const Property migration_properties[] = {
> >      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
> >                         parameters.zero_page_detection,
> >                         ZERO_PAGE_DETECTION_MULTIFD),
> > +    DEFINE_PROP_UINT32("postcopy-rp-keepalive-period", MigrationState,
> > +                       parameters.postcopy_rp_keepalive_period,
> > +                       DEFAULT_MIGRATE_POSTCOPY_RP_KEEPALIVE_PERIOD),
> >  
> >      /* Migration capabilities */
> >      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> > @@ -837,6 +846,13 @@ ZeroPageDetection migrate_zero_page_detection(void)
> >      return s->parameters.zero_page_detection;
> >  }
> >  
> > +uint32_t migrate_postcopy_rp_keepalive_period(void)
> > +{
> > +    MigrationState *s = migrate_get_current();
> > +
> > +    return s->parameters.postcopy_rp_keepalive_period;
> > +}
> > +
> >  /* parameters helpers */
> >  
> >  AnnounceParameters *migrate_announce_params(void)
> > @@ -922,6 +938,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
> >      params->zero_page_detection = s->parameters.zero_page_detection;
> >      params->has_direct_io = true;
> >      params->direct_io = s->parameters.direct_io;
> > +    params->has_postcopy_rp_keepalive_period = true;
> > +    params->postcopy_rp_keepalive_period = s->parameters.postcopy_rp_keepalive_period;
> >  
> >      return params;
> >  }
> > @@ -956,6 +974,7 @@ void migrate_params_init(MigrationParameters *params)
> >      params->has_mode = true;
> >      params->has_zero_page_detection = true;
> >      params->has_direct_io = true;
> > +    params->has_postcopy_rp_keepalive_period = true;
> >  }
> >  
> >  /*
> > @@ -1142,6 +1161,14 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
> >          return false;
> >      }
> >  
> > +    if (params->has_postcopy_rp_keepalive_period &&
> > +        params->postcopy_rp_keepalive_period > INT_MAX) {
> > +        error_setg(errp,
> > +                   "Parameter 'postcopy-rp-keepalive-period' must be less than %d",
> > +                   INT_MAX);
> > +        return false;
> > +    }
> > +
> >      return true;
> >  }
> >  
> > @@ -1255,6 +1282,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
> >      if (params->has_direct_io) {
> >          dest->direct_io = params->direct_io;
> >      }
> > +
> > +    if (params->has_postcopy_rp_keepalive_period) {
> > +        dest->postcopy_rp_keepalive_period = params->postcopy_rp_keepalive_period;
> > +    }
> >  }
> >  
> >  static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> > @@ -1387,6 +1418,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
> >      if (params->has_direct_io) {
> >          s->parameters.direct_io = params->direct_io;
> >      }
> > +
> > +    if (params->has_postcopy_rp_keepalive_period) {
> > +        s->parameters.postcopy_rp_keepalive_period = params->postcopy_rp_keepalive_period;
> > +    }
> >  }
> >  
> >  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> > diff --git a/migration/options.h b/migration/options.h
> > index 762be4e641..c941806413 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -85,6 +85,7 @@ const char *migrate_tls_creds(void);
> >  const char *migrate_tls_hostname(void);
> >  uint64_t migrate_xbzrle_cache_size(void);
> >  ZeroPageDetection migrate_zero_page_detection(void);
> > +uint32_t migrate_postcopy_rp_keepalive_period(void);
> >  
> >  /* parameters helpers */
> >  
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 6a6da6ba7f..26db4e2d22 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -960,6 +960,10 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >      int ret;
> >      size_t index;
> >      RAMBlock *rb = NULL;
> > +    int poll_timeout = migrate_postcopy_rp_keepalive_period();
> > +    if (poll_timeout == 0) {
> > +        poll_timeout = -1; /* wait forever with no keepalive messages */
> > +    }
> >  
> >      trace_postcopy_ram_fault_thread_entry();
> >      rcu_register_thread();
> > @@ -995,7 +999,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >           * an eventfd
> >           */
> >  
> > -        poll_result = poll(pfd, pfd_len, -1 /* Wait forever */);
> > +        poll_result = poll(pfd, pfd_len, poll_timeout);
> >          if (poll_result == -1) {
> >              error_report("%s: userfault poll: %s", __func__, strerror(errno));
> >              break;
> > @@ -1010,6 +1014,15 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >              postcopy_pause_fault_thread(mis);
> >          }
> >  
> > +        if (poll_result == 0) {
> > +            /*
> > +             * No page to request, send at least a keepalive message to check
> > +             * that the connection is not broken.
> > +             */
> > +            migrate_send_rp_keepalive(mis);
> > +            continue;
> > +        }
> > +
> >          if (pfd[1].revents) {
> >              uint64_t tmp64 = 0;
> >  
> > diff --git a/migration/trace-events b/migration/trace-events
> > index b82a1c5e40..64ffbc271f 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -161,6 +161,7 @@ migrate_pending_exact(uint64_t size, uint64_t pre, uint64_t post) "exact pending
> >  migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate pending size %" PRIu64 " (pre = %" PRIu64 " post=%" PRIu64 ")"
> >  migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
> >  migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
> > +migrate_send_rp_keepalive(void) ""
> >  migration_completion_file_err(void) ""
> >  migration_completion_vm_stop(int ret) "ret %d"
> >  migration_completion_postcopy_end(void) ""
> > @@ -188,6 +189,7 @@ source_return_path_thread_pong(uint32_t val) "0x%x"
> >  source_return_path_thread_shut(uint32_t val) "0x%x"
> >  source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> >  source_return_path_thread_switchover_acked(void) ""
> > +source_return_path_thread_received_keepalive(void) ""
> >  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> >  migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
> >  process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index a605dc26db..b4553aedfc 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -844,6 +844,15 @@
> >  #     only has effect if the @mapped-ram capability is enabled.
> >  #     (Since 9.1)
> >  #
> > +# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
> > +#     request message is sent from the destination side to the source side, a
> > +#     keepalive message is sent instead.  Allows the destination to detect
> > +#     network failure that would not be detected otherwise in case there is no
> > +#     other communication to the source side (no page requests).  Should be less
> > +#     than platform INT_MAX, 0 means no keepalive will be sent.
> > +#     Default is 60000 ms.
> > +#     (Since 9.3)
> > +#
> >  # Features:
> >  #
> >  # @unstable: Members @x-checkpoint-delay and
> > @@ -870,7 +879,7 @@
> >             'vcpu-dirty-limit',
> >             'mode',
> >             'zero-page-detection',
> > -           'direct-io'] }
> > +           'direct-io', 'postcopy-rp-keepalive-period'] }
> >  
> >  ##
> >  # @MigrateSetParameters:
> > @@ -1025,6 +1034,15 @@
> >  #     only has effect if the @mapped-ram capability is enabled.
> >  #     (Since 9.1)
> >  #
> > +# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
> > +#     request message is sent from the destination side to the source side, a
> > +#     keepalive message is sent instead.  Allows the destination to detect
> > +#     network failure that would not be detected otherwise in case there is no
> > +#     other communication to the source side (no page requests).  Should be less
> > +#     than platform INT_MAX, 0 means no keepalive will be sent.
> > +#     Default is 60000 ms.
> > +#     (Since 9.3)
> > +#
> >  # Features:
> >  #
> >  # @unstable: Members @x-checkpoint-delay and
> > @@ -1066,7 +1084,8 @@
> >              '*vcpu-dirty-limit': 'uint64',
> >              '*mode': 'MigMode',
> >              '*zero-page-detection': 'ZeroPageDetection',
> > -            '*direct-io': 'bool' } }
> > +            '*direct-io': 'bool',
> > +            '*postcopy-rp-keepalive-period': 'uint32' } }
> >  
> >  ##
> >  # @migrate-set-parameters:
> > @@ -1235,6 +1254,15 @@
> >  #     only has effect if the @mapped-ram capability is enabled.
> >  #     (Since 9.1)
> >  #
> > +# @postcopy-rp-keepalive-period: Time (in milliseconds) in which if no page
> > +#     request message is sent from the destination side to the source side, a
> > +#     keepalive message is sent instead.  Allows the destination to detect
> > +#     network failure that would not be detected otherwise in case there is no
> > +#     other communication to the source side (no page requests).  Should be less
> > +#     than platform INT_MAX, 0 means no keepalive will be sent.
> > +#     Default is 60000 ms.
> > +#     (Since 9.3)
> 
> s/9.3/10.0/
> 
> We don't have 9.3. :)

Right, will fix. Thank you!

> 
> Thanks for looking into this!
> 
> > +#
> >  # Features:
> >  #
> >  # @unstable: Members @x-checkpoint-delay and
> > @@ -1273,7 +1301,8 @@
> >              '*vcpu-dirty-limit': 'uint64',
> >              '*mode': 'MigMode',
> >              '*zero-page-detection': 'ZeroPageDetection',
> > -            '*direct-io': 'bool' } }
> > +            '*direct-io': 'bool',
> > +            '*postcopy-rp-keepalive-period': 'uint32' } }
> >  
> >  ##
> >  # @query-migrate-parameters:
> > -- 
> > 2.48.1
> > 
> 
> -- 
> Peter Xu
> 

-- 
Juraj Marcin


