Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FF4C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1HL2-000828-Bk; Tue, 01 Sep 2026 01:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1HL0-00081g-LF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 01:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1HKx-0001Jp-Go
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 01:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788241629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YiuaRX3OqjNJfeLIMB5MIclgvIjzC07hw6KDqhH0KA=;
 b=gtIlUDoXgl1xzmN+VlLI9L2imgmwev4hUG3pjpohldOluaDHvS5GRYoHEJ08ARDbWFdrmn
 HABKKhVk2h3cVWHR0B7AnBhTW6f5xzZMenfg1Py3WHEVhBEnJoC3okVEb5ie/DmZ+CaTki
 I46ZTtAhqXAB7amkdxEXMbRJdLXZsfw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-8rb3LZUUNrKMWA_RNm4JCg-1; Tue,
 01 Sept 2026 01:47:06 -0400
X-MC-Unique: 8rb3LZUUNrKMWA_RNm4JCg-1
X-Mimecast-MFC-AGG-ID: 8rb3LZUUNrKMWA_RNm4JCg_1788241625
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2A381955F2D; Tue,  1 Sep 2026 05:47:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43E021800598; Tue,  1 Sep 2026 05:47:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5C7C21E6832; Tue, 01 Sep 2026 07:47:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
In-Reply-To: <20260831160038.221776-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Tue, 1 Sep 2026 00:00:27 +0800")
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
Date: Tue, 01 Sep 2026 07:47:01 +0200
Message-ID: <8733vtbk16.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Monitors that require an IOThread share the internal mon_iothread.
> Account for each monitor explicitly in IOThread holder tracking, using
> the monitor's canonical QOM path to distinguish holders.
>
> Acquire the shared monitor IOThread AioContext once, using the monitor
> QOM path as the holder, and reuse the stored context for later
> operations.
>
> Release the holder from the Monitor ObjectClass::unparent callback,
> while the canonical QOM path is still available. This covers every
> object_unparent() path and avoids duplicating the cleanup in
> monitor_cleanup() and monitor_qmp_prepare_delete().
>
> The internal mon_iothread remains hidden from query-iothreads, as before.
> Management applications therefore cannot use it to determine which
> monitors are using the IOThread. Nevertheless, track the monitor
> holders so that they follow the same explicit holder and
> IOThread reference lifecycle as other AioContext users.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

I have a question for our QOM experts (Paolo and Daniel).

This patch takes a reference in its UserCreatableClass method
complete(), and relinquishes it in its ObjectClass unparent() method.
Is that correct and clean?  Or should complete() pair with
prepare_delete()?

> ---
>  monitor/monitor-internal.h |  3 +++
>  monitor/monitor.c          | 33 ++++++++++++++++++++++++++++-----
>  monitor/qmp.c              |  5 +++--
>  3 files changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index e0a124a317..74ea15c85f 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -154,6 +154,9 @@ struct Monitor {
>      guint out_watch;
>      int mux_out;
>      int reset_seen;
> +
> +    /* iothread context */
> +    AioContext *ctx;
>  };
>  
>  struct MonitorHMPClass {
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 6af09f2f6e..9e3b639eff 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -81,6 +81,22 @@ int monitor_device_index;
>  OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
>                              { TYPE_USER_CREATABLE }, {});
>  
> +static void monitor_unparent(Object *obj)
> +{
> +    Monitor *mon = MONITOR(obj);
> +
> +    if (mon->ctx && monitor_requires_iothread(mon)) {
> +        g_autofree char *path = object_get_canonical_path(obj);
> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = path,
> +        };
> +
> +        iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
> +        mon->ctx = NULL;
> +    }
> +}
> +
>  static void monitor_finalize(Object *obj)
>  {
>      Monitor *mon = MONITOR(obj);
> @@ -116,6 +132,8 @@ static void monitor_class_init(ObjectClass *cls, const void *data)
>  {
>      UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
>  
> +    cls->unparent = monitor_unparent;
> +
>      object_class_property_add_str(cls, "chardev",
>                                    monitor_get_chardev_id,
>                                    monitor_set_chardev_id);
> @@ -575,7 +593,7 @@ void monitor_suspend(Monitor *mon)
>           * Kick I/O thread to make sure this takes effect.  It'll be
>           * evaluated again in prepare() of the watch object.
>           */
> -        aio_notify(iothread_get_aio_context(mon_iothread));
> +        aio_notify(mon->ctx);
>      }
>  
>      trace_monitor_suspend(mon, 1);
> @@ -715,7 +733,6 @@ char *monitor_compat_id(void)
>  static void monitor_complete(UserCreatable *uc, Error **errp)
>  {
>      Monitor *mon = MONITOR(uc);
> -    AioContext *ctx;
>  
>      if (mon->chardev_id) {
>          Chardev *chr = qemu_chr_find(mon->chardev_id);
> @@ -734,11 +751,17 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
>              mon_iothread = iothread_create("mon_iothread", &error_abort);
>          }
>  
> -        ctx = iothread_get_aio_context(mon_iothread);
> +        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = path,
> +        };
> +
> +        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
>      } else {
> -        ctx = qemu_get_aio_context();
> +        mon->ctx = qemu_get_aio_context();
>      }
> -    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
> +    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
>  }
>  
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index aec0315775..de56345456 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -734,7 +734,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
>           * thread.  Schedule a bottom half.
>           */
>          mon->setup_pending = true;
> -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +
> +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {
> @@ -789,7 +790,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
>  
>      /* Synchronize with in-flight iothread callbacks. */
>      if (monitor_requires_iothread(mon)) {
> -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> +        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
>                              monitor_qmp_iothread_quiesce, NULL);
>      }


