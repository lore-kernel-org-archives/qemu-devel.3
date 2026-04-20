Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE11F5A8C7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 21:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEwRt-00087J-Ap; Mon, 20 Apr 2026 17:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEwRr-00086t-C0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEwRp-0003K5-Ed
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 17:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776721587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBUtvPYvZpVW+Ynfg4Mkrgi1sg4otCsYmknNnSJhk5k=;
 b=L8FdF2sslG2VopnqaHPlQ0VkCmJq8F3QbGUvZoQUgwbIEkcP0FJ7AjnK2fvJ5+iJt9v0HM
 DYm6IPb55D6miTBgj4aSjwXYTpH+u2kz3jGwlCRnuwDVyqHjgIYf+S1Q/3DSEqAAZsuH0A
 lz1TIt3UjJFzY05LFD8ymDheAGjmR8k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-2nngnCePOTC2mRtqTzwxXA-1; Mon, 20 Apr 2026 17:46:25 -0400
X-MC-Unique: 2nngnCePOTC2mRtqTzwxXA-1
X-Mimecast-MFC-AGG-ID: 2nngnCePOTC2mRtqTzwxXA_1776721585
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50e423a05c8so56932801cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776721585; x=1777326385; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GBUtvPYvZpVW+Ynfg4Mkrgi1sg4otCsYmknNnSJhk5k=;
 b=LaLS6wy4UNOb58SD2kkBi1ZJ+7CxRqP550oV5g1ZAcY3dfcP1W5cbiouftASq1L5rK
 KT4ZJxvSR54zbpnuwnzLs2okNkM+1+aigVrAZKvI/Cv1SGXBvimwbIc2FkT6TmYm3nHu
 jb8xYUY9x0U28CfgkHN/oS1BEtu2feF3UwK+L83ukQVne7NHDo1rDBIxQ47vzfBXjCqS
 yltfYp/pFQsTZL+JhPkHMrpTV6SkFBB+qU6jjFwz1eLlqe+G+3dF910tR7a2SvxxhHZq
 VKxvk/0/S3k8jb7FHjTy2FIeeSZifvcCLzj6JPVygO/uBJU7huFiG4M9yhREYD6p2259
 1sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776721585; x=1777326385;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GBUtvPYvZpVW+Ynfg4Mkrgi1sg4otCsYmknNnSJhk5k=;
 b=WqSxf73j+gviCLtEaYR92YUwbpFahHi52bBU7CY0WC/55UI5otVpoqFH4l1dB9MQWH
 F8GAFrrRoI4ODxsWJvqYvLpXj08AcSWLonZtsqI6zbykz9y8LPqFvHY9S8CV2wk8Z8Ru
 oYF9zOYAyKLKm2seyEIWHJAJon6TO9vlr6FyQUfMY6I84o12OHEdRqOdnLnTB5vO8Kae
 HZWl28jSFQqbFtxAzoyumb/p5NYxscvD4aSfqcadY39QPjTDYN1b4ZJnNpAW+QRwbelH
 Re5JXLOt1zfNi2e0aG5BAFX7ozwBh9jI8kQoKDdZKlfa3uXDxwM/qeOBf8B4otL4/n+f
 N7jw==
X-Gm-Message-State: AOJu0YwaJQRUg3GGoonSeE4rxnh3dE9ovH9I/VgvF5zFKjUs+SIAVJqR
 frvnI7EOnnZljRid4hsnsIyN632uu/sqlfjAab+FG1QIH9H9qDSO3UHN2nBmjbe4aAjfak1kY8V
 xtY0cSMYDbEPUF4AVR+ylsslzY11KDPHJfBOKG4NGePpha4708ZU68wMx
X-Gm-Gg: AeBDietgOMT/mXqhmIcAQiQED3kngUkfvw9Lun7PxF5GQ6a0mChkpKMKqwjTwp/Yy9h
 8bJ8XjoaExJ4fMjyTIkrY+gewuUhz4ciO23ATbpc6/9lMXJaZSN50TK188mrN5YAwKI2cwOmEWq
 211GvF4N7SxhuTUj1EhGJVRkHvwhXuNXUy451dPS5JsqdqLGocz/CeOEsaLpgmrFyrOvS9Yq2rE
 GUpIDL0FH6znDVRyi/kyiAP3yYaDq10nS6F2U7rqJ2Fndcl4Z94w7Wr83UfM9IRW6QDr0VYEGBB
 AlvhALvGhg1K4j56zaxM9YNl2WN/YsIWbix0vGrcAk0t5YuMM16AVoeXRtKmeSFu+TM4QcwAITd
 3dsEofDF/6GpdpoBg5gxG78l/uJ86wwAiELvzeTYzfIcDaZq5xnvZvqp9Yg==
X-Received: by 2002:a05:622a:8356:b0:509:2231:977a with SMTP id
 d75a77b69052e-50e3676f1fbmr139388581cf.30.1776721585232; 
 Mon, 20 Apr 2026 14:46:25 -0700 (PDT)
X-Received: by 2002:a05:622a:8356:b0:509:2231:977a with SMTP id
 d75a77b69052e-50e3676f1fbmr139388371cf.30.1776721584655; 
 Mon, 20 Apr 2026 14:46:24 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e392e351esm90131071cf.7.2026.04.20.14.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 14:46:24 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:46:23 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, steven.sistare@oracle.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: fix abort when re-migrating after cancel
 during SETUP
Message-ID: <aeaer6F0Q9XLt8Zt@x1.local>
References: <20260417184742.293061-1-marcandre.lureau@redhat.com>
 <aeaBKzauFijGRhWr@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeaBKzauFijGRhWr@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 20, 2026 at 03:40:27PM -0400, Peter Xu wrote:
> On Fri, Apr 17, 2026 at 10:47:42PM +0400, marcandre.lureau@redhat.com wrote:
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > 
> > When a migration is cancelled during the early SETUP phase (before
> > migration_connect_outgoing() has set s->to_dst_file), migration_cancel()
> > takes a fast path that transitions the state from CANCELLING to
> > Cancelled without calling migration_cleanup(). This leaves the migration
> > yank instance registered.
> > 
> > A subsequent qmp_migrate() call passes the migration_is_running() guard
> > (since CANCELLED is a terminal state) and then calls
> > yank_register_instance(MIGRATION_YANK_INSTANCE, &error_abort), which
> > finds the stale entry and aborts with "duplicate yank instance".
> > 
> >   #6  0x000056028b5e17fc in error_setg_internal
> >       (errp=errp@entry=0x56028cc8cb18 <error_abort>, src=src@entry=0x56028ba87fa5 "../util/yank.c", line=line@entry=87, func=func@entry=0x56028bb77140 <__func__.5> "yank_register_instance", fmt=fmt@entry=0x56028ba87f8d "duplicate yank instance") at ../util/error.c:100
> >   #7  0x000056028b601b2a in yank_register_instance (instance=instance@entry=0x7ffea0cf36b0, errp=0x56028cc8cb18 <error_abort>) at ../util/yank.c:87
> >   #8  0x000056028b25221e in migrate_prepare (s=0x5602b0a7db90, resume=<optimized out>, errp=0x7ffea0cf3718) at ../migration/migration.c:2001
> >   #9  qmp_migrate (uri=<optimized out>, has_channels=<optimized out>, channels=<optimized out>, has_resume=<optimized out>, resume=<optimized out>, errp=errp@entry=0x7ffea0cf3718) at ../migration/migration.c:2039
> >   #10 0x000056028b5891be in qmp_marshal_migrate (args=<optimized out>, ret=<optimized out>, errp=0x7f63392e0ee0) at qapi/qapi-commands-migration.c:459
> > 
> > Add missing yank_unregister_instance. Alternatively, it seems
> > migration_cleanup() should be safe in this context too.
> > 
> > Fixes: 624e6e654e11 ("migration: cpr-transfer mode")
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
> >  migration/migration.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 5c9aaa6e58f..bbdd91ee7ee 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1477,6 +1477,7 @@ void migration_cancel(void)
> >                            MIGRATION_STATUS_CANCELLED);
> >          cpr_state_close();
> >          cpr_transfer_source_destroy(s);
> > +        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> >      }
> >  }
> 
> Thanks for the report.
> 
> I had a feeling that this is not enough.. and I had a feeling that this
> special casing was something fast merged for cpr-transfer work to be able
> to cancel the HUP source when waiting, however did it wrong.  IOW, at least
> this chunk:
> 
>     if (setup && !s->to_dst_file) {
>         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                           MIGRATION_STATUS_CANCELLED);
>         cpr_state_close();
>         cpr_transfer_source_destroy(s);
>     }
> 
> Should only apply to cpr-transfer, not normal migrations..
> 
> E.g. consider one qmp_migrate() on top of tcp socket:
> 
> - qmp_migrate
>   - migration_connect_outgoing
>     - socket_connect_outgoing
>       - ... waiting for worker to invoke socket_outgoing_migration()
> - ... some time later
> - qmp_migrate_cancel
>   - above check hits, update CANCELLING->CANCELLED, unregister yank etc.
> - ... some time later
> - socket_outgoing_migration() invoked with an error
>   - migration_connect_error_propagate() should see CANCELLED state, which
>     is illegal.

So the 1st thing I did here is I tried to reproduce this issue with
firewall dropping packets over some port:

$ sudo iptables -A OUTPUT -p tcp --dport 44444 -j DROP

Then I can reproduce this by migrating to port 44444, and this patch does
fix it, but then I verified I can hit the above illegal CANCELLED state
error:

2026-04-20T21:30:21.669131Z migrate_set_state new state setup
2026-04-20T21:30:27.281824Z migrate_set_state new state cancelling
2026-04-20T21:30:27.281862Z migrate_set_state new state cancelled
...
2026-04-20T21:32:37.638382Z qemu-system-x86_64: migration_connect_error_propagate: Illegal migration status (cancelled) detected

After that if I retry with a correct connection migration will actually
succeed.  I believe it's because migration_connect_error_propagate() was
careful on skipping the extra migration_cleanup() when hitting something
weird:

        /*
         * This really shouldn't happen. Just be careful to not crash a VM
         * just for this.  Instead, dump something.
         */
        error_report("%s: Illegal migration status (%s) detected",
                     __func__, MigrationStatus_str(current));
        return;

I'll try out the other approach and share the patch if it will pass all
tests.

> 
> So IMHO for non-cpr cases we should always get ourselves covered with
> migration_connect_error_propagate(), except CPR where it may have the HUP
> source registered via migration_connect_error_propagate().
> 
> IIUC, maybe we could change this check to be an explicit one, checking
> whether cpr_transfer_add_hup_watch() has the source attached but not yet
> executed (if executed, migration_connect_outgoing_cb() will also properly
> invoke migration_connect_error_propagate()).
> 
> We could check against both "mode==CPR_TRANSFER && s->hup_source", but then
> we need early release of hup_resource too (currently it is deferred until
> migration_cleanup(), which is slightly hackish; after all the source
> returns always with G_SOURCE_REMOVE for migration_connect_outgoing_cb, so
> it was removed long time ago, rather than until the end of migration).
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


