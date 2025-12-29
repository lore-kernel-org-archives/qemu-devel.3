Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D3E92FE2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 22:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaLMu-0006g1-8g; Mon, 29 Dec 2025 17:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaLMq-0006fh-Jj
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaLMn-00019F-K7
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 17:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767045928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTyIja2FsXRC/Ha96gf+PdtNHPQlehUzLHkaYyOJv+c=;
 b=IhyE6Cpu8tThUQhIXSjCHtDlfuAaTgXwA/rDzdXBHbBgFiA+JSkT1FvYO4iPUcT0//BjJQ
 s5iLinFhn/CQsbqpHK8kB9aEG2IegfegYel5vqxjVrl+/c5RCQMzbRMKLJydSbGMC+HrJQ
 XsyIkh0D5if+cjxnXKQyfxcxytJx8lI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-fodDtkG5OM2_yE1p9SevQw-1; Mon, 29 Dec 2025 17:05:26 -0500
X-MC-Unique: fodDtkG5OM2_yE1p9SevQw-1
X-Mimecast-MFC-AGG-ID: fodDtkG5OM2_yE1p9SevQw_1767045925
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a3356a310so266392636d6.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 14:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767045925; x=1767650725; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTyIja2FsXRC/Ha96gf+PdtNHPQlehUzLHkaYyOJv+c=;
 b=k4b4h99HDkuhVm7RHxh1n/4zGHtLwgZtGSa3COj1z2a7O9G0StGXDvQDiZRr3Ts9nv
 V6NQKZ3YiIEeSXtMgbcRmiLysV1OUUg+c7zh3uRhD1UYmVQKe76sev2qfg9m/hWCwCDt
 t5+bd6g/nCmrwdPrClGxTKL6ea/ngypJVGbem9gI67rsq+RINEKx/zACRVPn7nWNpK6p
 /QM72x6balbcOIkKCFWVIMvy+G2Aiql+xRnW2koyNwBBl17QhtktZwXWl0qXeyztyLgM
 jOExPH2rsHG/zBsyPJUBCeH3xE5wVvDs2Qxtc/boH2dhEx1PfI9iA8NODGFpbTxOMEss
 XeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767045925; x=1767650725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTyIja2FsXRC/Ha96gf+PdtNHPQlehUzLHkaYyOJv+c=;
 b=qeyYHeC8LWEh8Gms2uXUe2QIZg+dl0Zr3Gd1SGRzoFoK/rnlEPmVH0bExv6R6VxkZo
 YgpSVm2MdfsuWvBOWFRzgNtQcrCDJkHqaEYV3xviJL9COsp6TKo+sj2l0xVsg9IrLPUj
 5AAityHTZ2S7etFN6MUYquLETiabAclvBJZ/SyYTGdrpATVMEFxDBVHGpIBBuQVEcnyr
 7OBL+a5nCgmQcA66RI+x3wnf3e3oE2XPsShDBRaiEhcsoX6ieiyfyl16BLDRbq+mTYi8
 VFTdwtmdwIehsKzqEnOcKfibg/boV6QwCuqILn71u/cSq/H7dC7/jNYZupp3ADei1jEx
 /Gng==
X-Gm-Message-State: AOJu0Yx3JCzubyYKnvVOlXgtIczUQLzm/8HTohezum0DqzcnkisivZ7l
 O6/KUY7g7Zd0zR1WoUuB859cmI9tb4oaW+nxGuAybSW7QXGxNus+onyAM1W/SvRs7VErUKpPtvG
 yyEH2DBwbgirqT7JQ8FCxu8lC2eo6FA1oDkn3mmldhONEluzhhbOzytYa
X-Gm-Gg: AY/fxX7VqSApA0731ayixFDWhv3XMqJaydTVSe7Kk+r369vxremGvSqiwdDFLXB9I36
 42BpltzklRwjqha7qy7YpuKsrzJhKahv0KoiTR29JQkwoPnEPwD2EpdLIOplY6n+MDPUZpcm+Si
 iRjoJLNEL3kOB0QwSMEKMIUe1wOVyGya2f9EdNfEZQ8IYrTwkt3HAPTSdjhxnOilV6bGCSDexCp
 yI7IUHJMsAYkcbBRLCKwemgq499rKo5cw0gxnI+Bcj95OvSaqtVuA3tqitZ6u/dKfVT0tbSJ63v
 amSsMyz4p1v4Y1QpYgh+WIv8SCfsT2LyIIkldSG3IA+ZDbpv+zV+OShrvZ2yPmDLoiZevGiLvhZ
 8vj0=
X-Received: by 2002:a0c:ea42:0:b0:880:3ce2:65ad with SMTP id
 6a1803df08f44-88d845357dbmr341769666d6.41.1767045925392; 
 Mon, 29 Dec 2025 14:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMV7msRm0pkuq10g55tlrIeyjzMyg4gYOaM4q04eEGS0GpT0cyWcPRmHMf2tKpHcnIPD69fg==
X-Received: by 2002:a0c:ea42:0:b0:880:3ce2:65ad with SMTP id
 6a1803df08f44-88d845357dbmr341769466d6.41.1767045924894; 
 Mon, 29 Dec 2025 14:05:24 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8901d0dcd77sm42232306d6.42.2025.12.29.14.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:05:24 -0800 (PST)
Date: Mon, 29 Dec 2025 17:05:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 22/25] migration/channel: Merge both sides of the
 connection initiation code
Message-ID: <aVL7I6tmd5wb22-n@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-23-farosas@suse.de>
 <aVLfYlEwDu3rL3wj@x1.local> <875x9p7zxv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875x9p7zxv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 29, 2025 at 06:14:52PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Dec 26, 2025 at 06:19:24PM -0300, Fabiano Rosas wrote:
> >> Now that everything is in channel.c, it's easier to browse this code
> >> if it's all in the same place. It's also easier to grasp what the
> >> connection flow is if both sides of the connection are close together.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/channel.c | 86 +++++++++++++++++++++++----------------------
> >>  migration/channel.h | 14 ++++++--
> >>  2 files changed, 56 insertions(+), 44 deletions(-)
> >> 
> >> diff --git a/migration/channel.c b/migration/channel.c
> >> index 042e01b224..ba9aa1c58b 100644
> >> --- a/migration/channel.c
> >> +++ b/migration/channel.c
> >> @@ -31,10 +31,11 @@
> >>  #include "trace.h"
> >>  #include "yank_functions.h"
> >>  
> >> -bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
> >> +bool migration_connect(MigrationAddress *addr, bool out, Error **errp)
> >>  {
> >>      g_autoptr(QIOChannel) ioc = NULL;
> >>      SocketAddress *saddr;
> >> +    ERRP_GUARD();
> >>  
> >>      switch (addr->transport) {
> >>      case MIGRATION_ADDRESS_TYPE_SOCKET:
> >> @@ -44,15 +45,24 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
> >>          case SOCKET_ADDRESS_TYPE_INET:
> >>          case SOCKET_ADDRESS_TYPE_UNIX:
> >>          case SOCKET_ADDRESS_TYPE_VSOCK:
> >> -            socket_connect_outgoing(saddr, errp);
> >> -            /*
> >> -             * async: after the socket is connected, calls
> >> -             * migration_channel_connect_outgoing() directly.
> >> -             */
> >> -            return true;
> >> +            if (out) {
> >
> > Personally I wouldn't suggest we merge the outgoing / incoming with
> > migration_connect() then split paths once more in this exact function.
> >
> > I got this conclusion when I started to count how many "if (out)" are
> > there..  When there're too much, it may imply we need to think more..
> >
> 
> Well, compared to before, there 50% less "if (addr->transport == ...)",
> this is top level programming! =D

Yep, though that'll be the only part got deduplicated.

Reading migration_connect() will definitely break my flow of thoughts when
hitting so many "if (out)", and I'll be a bit puzzled on how the code runs.

I'm not sure if I'm the only one, though.

If we really want, we can introduce a MigrationAddressOps, providing one
ops for each type of MigrationAddress, differently on both sides:

/* Return true if success; when false errp will be set */
bool (*MigrationAddressOp)(MigrationAddress *addr, QIOChannel **channel, Error **errp)

Then define:

MigrationAddressOps[MIGRATION_ADDRESS_TYPE__MAX] addr_ops_outgoing = { ... };
MigrationAddressOps[MIGRATION_ADDRESS_TYPE__MAX] addr_ops_incoming = { ... };

And use them..  but it may also be an overkill when we only have incoming /
outgoing anyway..  So IMHO the existing code (after you refactored many of
the rest!) looks still pretty decent to me.

> 
> This part of the series is highly subjective, if there's a patch you
> don't like it we can drop it, let's not dwell on it.. Just read my words
> below on the previous patch, which I think you may be mistaken about.

Thanks, yes I was indeed mistaken and overlooked something. :)

> 
> > This also answers part of my confusion when reading the previous patch - if
> > that was only paving way for this one, IMHO it may not be as worthwhile,
> > and I would tend to avoid both.
> >
> 
> Patch 21 is just a cleanup after patch 19 moves the call to
> migration_channel_connect_outgoing from being inside the transport
> routines to this top level here at migration_connect(), which moves the
> places where MigrationState is used as well. So it removes unused
> passing of MigrationState along with the SocketConnectionData.

Now after I read it again, I agree with those removal of *s where they're
not used, like for:

  fd_connect_outgoing()
  exec_connect_outgoing()
  file_connect_outgoing()

I think socket_connect_outgoing() should also be fine, but maybe better to
have a pre-requisite patch removing SocketConnectData?

For most of the rest, IMHO we don't get much benefit from removing *s from
the parameters, especially inside qmp_migrate()..

So IMHO you were right in the commit log there, that we should justify
every use of migrate_get_current() to deserve fetching from a global, and
we should avoid using it in new code whenever possible.  IMHO we should
stick with that.

Imagine the old days we debug when *s can become null, and the more we
reference the global, the harder we fight those things (taking one refcount
from the very top caller would work for all the sub-callers OTOH, when we
justify one place thread-safe and justify all the rest).  More referencing
globals normally will just make things harder for us.  This rule applies to
all the globals.. not only *s.

> 
> > Thoughts?
> >
> >> +                socket_connect_outgoing(saddr, errp);
> >> +                /*
> >> +                 * async: after the socket is connected, calls
> >> +                 * migration_channel_connect_outgoing() directly.
> >> +                 */
> >> +                return true;
> >> +            } else {
> >> +                socket_connect_incoming(saddr, errp);
> >> +            }
> >> +
> >>              break;
> >>          case SOCKET_ADDRESS_TYPE_FD:
> >> -            ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
> >> +            if (out) {
> >> +                ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
> >> +            } else {
> >> +                fd_connect_incoming(saddr->u.fd.str, errp);
> >> +            }
> >>              break;
> >>          default:
> >>              g_assert_not_reached();
> >> @@ -62,16 +72,28 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
> >>  
> >>  #ifdef CONFIG_RDMA
> >>      case MIGRATION_ADDRESS_TYPE_RDMA:
> >> -        ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
> >> +        if (out) {
> >> +            ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
> >> +        } else {
> >> +            rdma_connect_incoming(&addr->u.rdma, errp);
> >> +        }
> >>          break;
> >>  #endif
> >>  
> >>      case MIGRATION_ADDRESS_TYPE_EXEC:
> >> -        ioc = exec_connect_outgoing(addr->u.exec.args, errp);
> >> +        if (out) {
> >> +            ioc = exec_connect_outgoing(addr->u.exec.args, errp);
> >> +        } else {
> >> +            exec_connect_incoming(addr->u.exec.args, errp);
> >> +        }
> >>          break;
> >>  
> >>      case MIGRATION_ADDRESS_TYPE_FILE:
> >> -        ioc = file_connect_outgoing(&addr->u.file, errp);
> >> +        if (out) {
> >> +            ioc = file_connect_outgoing(&addr->u.file, errp);
> >> +        } else {
> >> +            file_connect_incoming(&addr->u.file, errp);
> >> +        }
> >>          break;
> >>  
> >>      default:
> >> @@ -79,42 +101,22 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
> >>          break;
> >>      }
> >>  
> >> -    if (!ioc) {
> >> -        return false;
> >> -    }
> >> -
> >> -    migration_channel_connect_outgoing(ioc);
> >> -    return true;
> >> -}
> >> -
> >> -void migration_connect_incoming(MigrationAddress *addr, Error **errp)
> >> -{
> >> -    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> >> -        SocketAddress *saddr = &addr->u.socket;
> >> -        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> >> -            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> >> -            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> >> -            socket_connect_incoming(saddr, errp);
> >> -        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> >> -            fd_connect_incoming(saddr->u.fd.str, errp);
> >> +    if (out) {
> >> +        if (!ioc) {
> >> +            return false;
> >>          }
> >> -#ifdef CONFIG_RDMA
> >> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> >> -        rdma_connect_incoming(&addr->u.rdma, errp);
> >> -#endif
> >> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> >> -        exec_connect_incoming(addr->u.exec.args, errp);
> >> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> >> -        file_connect_incoming(&addr->u.file, errp);
> >> -    } else {
> >> -        error_setg(errp, "unknown migration protocol");
> >> +
> >> +        migration_channel_connect_outgoing(ioc);
> >> +        return true;
> >>      }
> >>  
> >>      /*
> >> -     * async: the above routines all wait for the incoming connection
> >> -     * and call back to migration_channel_process_incoming() to start
> >> -     * the migration.
> >> +     * async: on the incoming side all of the transport routines above
> >> +     * wait for the incoming connection and call back to
> >> +     * migration_channel_process_incoming() to start the migration.
> >>       */
> >> +
> >> +    return !*errp;
> >>  }
> >>  
> >>  bool migration_has_main_and_multifd_channels(void)
> >> diff --git a/migration/channel.h b/migration/channel.h
> >> index 8cf16bfda9..86934fee38 100644
> >> --- a/migration/channel.h
> >> +++ b/migration/channel.h
> >> @@ -39,6 +39,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
> >>  bool migration_has_main_and_multifd_channels(void);
> >>  bool migration_has_all_channels(void);
> >>  
> >> -bool migration_connect_outgoing(MigrationAddress *addr, Error **errp);
> >> -void migration_connect_incoming(MigrationAddress *addr, Error **errp);
> >> +bool migration_connect(MigrationAddress *addr, bool out, Error **errp);
> >> +static inline bool migration_connect_outgoing(MigrationAddress *addr,
> >> +                                              Error **errp)
> >> +{
> >> +    return migration_connect(addr, true, errp);
> >> +}
> >> +
> >> +static inline bool migration_connect_incoming(MigrationAddress *addr,
> >> +                                              Error **errp)
> >> +{
> >> +    return migration_connect(addr, false, errp);
> >> +}
> >>  #endif
> >> -- 
> >> 2.51.0
> >> 
> 

-- 
Peter Xu


