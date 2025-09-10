Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEDDCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 12:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJaF-0002Ad-5X; Wed, 10 Sep 2025 08:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uwJaB-00029T-4V
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uwJa3-0003DA-TS
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757505938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5iBlAFS5YklOvAJ4LCjyXiNbFDVL1X6TEGaaSO7LsQ=;
 b=PKGLIykPNXtSFmRdruAta+5OqNW3uU9YtrTcNulTGL5r+GhmJ+KAfEl3S/I/OtdCOaUz0F
 3y5yojM34aXWCe/w5KFo8rojZJqiPnQi1r7HW8cj4+oxQJNE/XJkkekFVtSZMK1+TfuOK1
 pAG0fXFJ/NjFXPfkNrFO3blibY3LmhM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-0euN7RsdPpKTxEhHGrnZxQ-1; Wed, 10 Sep 2025 08:05:36 -0400
X-MC-Unique: 0euN7RsdPpKTxEhHGrnZxQ-1
X-Mimecast-MFC-AGG-ID: 0euN7RsdPpKTxEhHGrnZxQ_1757505935
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3df2f4aedd1so4821003f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 05:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757505935; x=1758110735;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R5iBlAFS5YklOvAJ4LCjyXiNbFDVL1X6TEGaaSO7LsQ=;
 b=mci0PkCU1mIY0Ezwn/LL+9vQBW4kActZV/ndYmnikL/3OHgCcvedSNf/2kiO6b/l6F
 Ru+57oJyvNA/CAeJQdDJadFQ/vAgr84uAPD4mZz/w90YhPlya4mcMb4EQbQE2Qx/heGF
 TtS/1KbkZclPiW8DF+T1riV4kRNL0BMRvFWaY53kY1Bryd6NKa1IYjnOCurvWfkcKtkV
 rmCDkSK87jpZ6mgXKYpjP5ed8pXQdkKSavwrPVqPkT1xnw5QoI7aBFIvO8kkHBasiqUl
 /85XG/NIjb8B5ir2g/CSE1NWeTJZfGGQQq1ci5wlm1inOAPnKxhXmsWDFXjkJOuNx0Dv
 huVA==
X-Gm-Message-State: AOJu0YzkWjYa+pBjXjdL7iHixio/YFnEMlagfq2SIcpVDQC69kYIkTbH
 u7oeCU+AopzdB3lGIELT1Bo3nlHz6irDYQWpCKWzeaDC6YmQ3Qfl0Bk/yp3/dFthtejUBfkogSs
 dnJYpVyxiE8hvDbOfLzq9hPDmAO2fopL0GQ8QFEstK0PBsI1jAxg8IczB
X-Gm-Gg: ASbGncs9WpFNO1VqszS8WbfUTZd7y8wUJzQtfY8i6tl+TmLA22m9QAbT3v17SpT0bjx
 tEGHIJfOj+O48kkBJ0ufdORS1utx6vW09lB9xhk65xNu2NFNFqt9gpiYJxc5GBb5V0vg9fzpsxq
 DZPkXAdJABopIzommQbPKD1EH/1b1AcIU+Ss+8EPKVZPsKZT9Oajtm1rp0AjxaZm7E9c8450wkl
 lUNzdcaqV2zGpk5QaaeABfuxP3F6k4bUOvUzvfac6jg8T+Qg0+agX5bxdWsFHbQayaMK/7d7Qtv
 SekbFiWgbaK9CQfKPSg7MvoCFwdgdA==
X-Received: by 2002:a05:6000:420f:b0:3e5:5261:9fad with SMTP id
 ffacd0b85a97d-3e641e3ab9amr17552828f8f.13.1757505934912; 
 Wed, 10 Sep 2025 05:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGIncUjpEWwqk6V4ExSxPl1BsrGRpp/96F5VJR6NYiwIlf/QeMFuwX7SkMjPXvbNA/y4+6Og==
X-Received: by 2002:a05:6000:420f:b0:3e5:5261:9fad with SMTP id
 ffacd0b85a97d-3e641e3ab9amr17552786f8f.13.1757505934347; 
 Wed, 10 Sep 2025 05:05:34 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7521ca0e9sm7087803f8f.25.2025.09.10.05.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 05:05:33 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:05:32 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] migration: Apply migration specific keep-alive defaults
 to inet socket
Message-ID: <zzpyzcx7xlsxahxcnbxhvknhwbxw6pucjnk27rnfmxf5wp3z5q@7yglatzuhbuy>
References: <20250909150127.1494626-1-jmarcin@redhat.com>
 <aMBDIwKDxTVrBJBQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMBDIwKDxTVrBJBQ@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Daniel,

thank you for the feedback.

On 2025-09-09 16:09, Daniel P. Berrangé wrote:
> On Tue, Sep 09, 2025 at 05:01:24PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Usual system defaults for TCP keep-alive options are too long for
> > migration workload. On Linux, a TCP connection waits idle for 2 hours
> > before it starts checking if the connection is not broken.
> > 
> > Now when InetSocketAddress supports keep-alive options [1], this patch
> > applies migration specific defaults if they are not supplied by the user
> > or the management software. With these defaults, a migration TCP stream
> > waits idle for 1 minute and then sends 5 TCP keep-alive packets in 30
> > second interval before considering the connection as broken.
> > 
> > System defaults can be still used by explicitly setting these parameters
> > to 0.
> 
> IMHO this is not a good idea. This is a very short default, which
> may be fine for the scenario where your network conn is permanently
> dead, but it is going to cause undesirable failures when the network
> conn is only temporarily dead.
> 
> Optimizing defaults for temporary outages is much more preferrable
> as that maximises reliability of migration. In the case of permanent
> outages, it is already possible to tear down the connection without
> waiting for a keep-alive timeout, and liveliness checks can also be
> perform by the mgmt app at a higher level too. The TCP keepalives
> are just an eventual failsafe, and having those work on a long
> timeframe is OK.

So, would extending the keep-alive parameter to, for example 30 minutes
be an acceptable solution? Or the system default is preferred and the
patch should just enable keep-alive without setting other parameters?

Thank you!

Best regards,

Juraj Marcin

> 
> > 
> > [1]: 1bd4237cb1 "util/qemu-sockets: Introduce inet socket options
> >      controlling TCP keep-alive"
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  migration/migration.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  qapi/migration.json   |  6 ++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25d..a1f1223946 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -74,6 +74,11 @@
> >  
> >  #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
> >  
> > +#define INET_SOCKET_DEFAULT_KEEP_ALIVE true
> > +#define INET_SOCKET_DEFAULT_KEEP_ALIVE_COUNT 5
> > +#define INET_SOCKET_DEFAULT_KEEP_ALIVE_IDLE 60
> > +#define INET_SOCKET_DEFAULT_KEEP_ALIVE_INTERVAL 30
> > +
> >  static NotifierWithReturnList migration_state_notifiers[] = {
> >      NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
> >      NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
> > @@ -718,6 +723,36 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> >      return true;
> >  }
> >  
> > +static void migration_address_apply_defaults(MigrationAddress *addr)
> > +{
> > +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> > +        addr->u.socket.type == SOCKET_ADDRESS_TYPE_INET) {
> > +        InetSocketAddress *inet = &addr->u.socket.u.inet;
> > +        if (!inet->has_keep_alive) {
> > +            inet->has_keep_alive = true;
> > +            inet->keep_alive = INET_SOCKET_DEFAULT_KEEP_ALIVE;
> > +        }
> > +#ifdef HAVE_TCP_KEEPCNT
> > +        if (!inet->has_keep_alive_count) {
> > +            inet->has_keep_alive_count = true;
> > +            inet->keep_alive_count = INET_SOCKET_DEFAULT_KEEP_ALIVE_COUNT;
> > +        }
> > +#endif
> > +#ifdef HAVE_TCP_KEEPIDLE
> > +        if (!inet->has_keep_alive_idle) {
> > +            inet->has_keep_alive_idle = true;
> > +            inet->keep_alive_idle = INET_SOCKET_DEFAULT_KEEP_ALIVE_IDLE;
> > +        }
> > +#endif
> > +#ifdef HAVE_TCP_KEEPINTVL
> > +        if (!inet->has_keep_alive_interval) {
> > +            inet->has_keep_alive_interval = true;
> > +            inet->keep_alive_interval = INET_SOCKET_DEFAULT_KEEP_ALIVE_INTERVAL;
> > +        }
> > +#endif
> > +    }
> > +}
> > +
> >  static bool
> >  migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
> >  {
> > @@ -775,6 +810,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
> >          addr = channel->addr;
> >      }
> >  
> > +    migration_address_apply_defaults(addr);
> > +
> >      /* transport mechanism not suitable for migration? */
> >      if (!migration_transport_compatible(addr, errp)) {
> >          return;
> > @@ -2232,6 +2269,8 @@ void qmp_migrate(const char *uri, bool has_channels,
> >          addr = channel->addr;
> >      }
> >  
> > +    migration_address_apply_defaults(addr);
> > +
> >      /* transport mechanism not suitable for migration? */
> >      if (!migration_transport_compatible(addr, errp)) {
> >          return;
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 2387c21e9c..68d4acb5db 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1639,6 +1639,12 @@
> >  #
> >  # Migration endpoint configuration.
> >  #
> > +# If transport is socket of type inet, it has the following defaults:
> > +# keep-alive: true, keep-alive-count: 5, keep-alive-idle: 60 seconds,
> > +# keep-alive-interval: 30 seconds.  System defaults can be used by
> > +# explicitly setting these parameters to 0.  See `InetSocketAddress` for
> > +# more details.
> > +#
> >  # @transport: The migration stream transport mechanism
> >  #
> >  # Since: 8.2
> > -- 
> > 2.51.0
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 


