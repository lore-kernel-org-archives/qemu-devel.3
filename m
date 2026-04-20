Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B51F5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEuU3-0003KA-O7; Mon, 20 Apr 2026 15:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEuTz-0003JC-JD
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEuTx-00050m-U1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776714032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0nInPWWkYC5jnsWmSMyjbxo7XAmhxf0llMm4THi7iY=;
 b=cU5RG/LiN1fZCIa3QuiDWDczb81tj9xAwGFHrmM3jBP8NR6GieHN5vx8OUQKuL5QO3rK1O
 rAoINGY9vMJr3IUopmSx9Ffgv7bYYTWYdbM9t3wSSOIu1rHcwVe7grl2CB68JtXgUDQkz+
 VzLqjfmnc1z4D20tdPfHdyzmZERgTP0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-zWJFuOlSM66lIdOQiHGmOg-1; Mon, 20 Apr 2026 15:40:30 -0400
X-MC-Unique: zWJFuOlSM66lIdOQiHGmOg-1
X-Mimecast-MFC-AGG-ID: zWJFuOlSM66lIdOQiHGmOg_1776714030
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a275472d89so53090036d6.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776714030; x=1777318830; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d0nInPWWkYC5jnsWmSMyjbxo7XAmhxf0llMm4THi7iY=;
 b=TsU+UtOVK5RZd9dIBT+YFqAVYMzNGl1UMVkpvow1/o9v3zMBkt7xbYj8P6/VUWNqsY
 7aZVyh42rhdNlsUj93CfrIIY4hno8EH1QkM5liqjG7EpwsRhfX2/qEgTI4vDf6+wYPGJ
 dcsHO3WDts8vrQs3NtFhAdYEyPpdIop/Y6Guo5FSJlUwsvG+dJIAA1wRegJnWjN2eDfV
 0c0sBt5tkmWolt/SfYcCIpnhPL7il2VDM00nRrbJyPeomwGbTO3mF1I9A2smfmb9hnCh
 TuSWr+5RTeXz8ojVtAEUMVwKnpXruy+jZ+y2rUF3OmUBPkCXwHAa4vkmebofApZkMCsF
 sw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714030; x=1777318830;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d0nInPWWkYC5jnsWmSMyjbxo7XAmhxf0llMm4THi7iY=;
 b=AS2XcX45rCRRbeWlV8bun8ROtGbdNibRcemubNGVHLpN1nRHAUGtN9uaRMh8CdXizZ
 9otq5ss5RM4pDIMkrIimLqy6aO2JFGJ9BoH2RSAO48Aj6k0RVDMLUUZAemdwEGgYPOcE
 jO1Rbc/kOogXBpduAJu4DSd6GKcNDmMxyJNhlf07r0Z4RgLoxPkPyUIqYxtaFZ/0L1SG
 qyHPYIkAYE98H5iB1VT0AjLkJuPa1MEuNPdx5WH5W1eStFkQM66wL7bdvXpcaono+10K
 6M9pfZBkLX3SHfrtbKfUq4CcinAzcnslZqdl8dtx3/0VEZc5gu2SbIyI/RPxbVsb267S
 Zpgw==
X-Gm-Message-State: AOJu0YyAfILbN5JXoDIdclF1zfVVLY1wfXa663Y+lrjxJ8Y+Bps2rCrq
 vdSYRs+mnzDKk0y/j+4fFVZyZd6wmN8H7Xbklt3HgtxcVv7bv1HyMqef/6ccg1FSxh3IlFSUmVm
 lpIXmVqfDkZx0iDYnzdxh9+1h5L0nsUh3F4f1upYqaqORBId+HmHFUUgf
X-Gm-Gg: AeBDievtYZWpvmojdNqMKDQf8Jnm1TUU4nB2jL09bpkOCk4JbCgrale110cRPEI3AN+
 Jl2s3jpVaYnQFnSqH7cCFbZiMcG/v7Hcvx1bwpht+zODLzsBY3ajJQQ6uw8Xlq1EsVsbgrCYzKF
 S+qHLFtpBYKAQe9Zg1teqFmMI5qGRX9XdousoxHV100ldQHdfqbE1eBJjTJHvlBd2YoF/RliUqK
 LO/8Q4xYWVL1Ns1X1GQ5ykx+zLWJY8NBo9U1/sJOC1IpJgvljarrcat99PCdk97zFqTfoDbM70u
 xCHltXvUfl49tEsjgNV7Pk5O19gxRwDFmxuUe8XlnEChOIEc90q40LtD9hadTVBG8Q5j0uORTIq
 N0jT2jTvMvEJzqJ9Mt4I9Cxg4GeP9AiIS1ImEo4dtr1Ri3Nl0IS76teJXrQ==
X-Received: by 2002:a05:6214:4a84:b0:8ac:b3ba:eb0f with SMTP id
 6a1803df08f44-8b028081addmr233170886d6.21.1776714029902; 
 Mon, 20 Apr 2026 12:40:29 -0700 (PDT)
X-Received: by 2002:a05:6214:4a84:b0:8ac:b3ba:eb0f with SMTP id
 6a1803df08f44-8b028081addmr233170096d6.21.1776714029232; 
 Mon, 20 Apr 2026 12:40:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aea639fsm80079536d6.45.2026.04.20.12.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 12:40:28 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:40:27 -0400
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, steven.sistare@oracle.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: fix abort when re-migrating after cancel
 during SETUP
Message-ID: <aeaBKzauFijGRhWr@x1.local>
References: <20260417184742.293061-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417184742.293061-1-marcandre.lureau@redhat.com>
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

On Fri, Apr 17, 2026 at 10:47:42PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When a migration is cancelled during the early SETUP phase (before
> migration_connect_outgoing() has set s->to_dst_file), migration_cancel()
> takes a fast path that transitions the state from CANCELLING to
> Cancelled without calling migration_cleanup(). This leaves the migration
> yank instance registered.
> 
> A subsequent qmp_migrate() call passes the migration_is_running() guard
> (since CANCELLED is a terminal state) and then calls
> yank_register_instance(MIGRATION_YANK_INSTANCE, &error_abort), which
> finds the stale entry and aborts with "duplicate yank instance".
> 
>   #6  0x000056028b5e17fc in error_setg_internal
>       (errp=errp@entry=0x56028cc8cb18 <error_abort>, src=src@entry=0x56028ba87fa5 "../util/yank.c", line=line@entry=87, func=func@entry=0x56028bb77140 <__func__.5> "yank_register_instance", fmt=fmt@entry=0x56028ba87f8d "duplicate yank instance") at ../util/error.c:100
>   #7  0x000056028b601b2a in yank_register_instance (instance=instance@entry=0x7ffea0cf36b0, errp=0x56028cc8cb18 <error_abort>) at ../util/yank.c:87
>   #8  0x000056028b25221e in migrate_prepare (s=0x5602b0a7db90, resume=<optimized out>, errp=0x7ffea0cf3718) at ../migration/migration.c:2001
>   #9  qmp_migrate (uri=<optimized out>, has_channels=<optimized out>, channels=<optimized out>, has_resume=<optimized out>, resume=<optimized out>, errp=errp@entry=0x7ffea0cf3718) at ../migration/migration.c:2039
>   #10 0x000056028b5891be in qmp_marshal_migrate (args=<optimized out>, ret=<optimized out>, errp=0x7f63392e0ee0) at qapi/qapi-commands-migration.c:459
> 
> Add missing yank_unregister_instance. Alternatively, it seems
> migration_cleanup() should be safe in this context too.
> 
> Fixes: 624e6e654e11 ("migration: cpr-transfer mode")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5c9aaa6e58f..bbdd91ee7ee 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1477,6 +1477,7 @@ void migration_cancel(void)
>                            MIGRATION_STATUS_CANCELLED);
>          cpr_state_close();
>          cpr_transfer_source_destroy(s);
> +        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>      }
>  }

Thanks for the report.

I had a feeling that this is not enough.. and I had a feeling that this
special casing was something fast merged for cpr-transfer work to be able
to cancel the HUP source when waiting, however did it wrong.  IOW, at least
this chunk:

    if (setup && !s->to_dst_file) {
        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
                          MIGRATION_STATUS_CANCELLED);
        cpr_state_close();
        cpr_transfer_source_destroy(s);
    }

Should only apply to cpr-transfer, not normal migrations..

E.g. consider one qmp_migrate() on top of tcp socket:

- qmp_migrate
  - migration_connect_outgoing
    - socket_connect_outgoing
      - ... waiting for worker to invoke socket_outgoing_migration()
- ... some time later
- qmp_migrate_cancel
  - above check hits, update CANCELLING->CANCELLED, unregister yank etc.
- ... some time later
- socket_outgoing_migration() invoked with an error
  - migration_connect_error_propagate() should see CANCELLED state, which
    is illegal.

So IMHO for non-cpr cases we should always get ourselves covered with
migration_connect_error_propagate(), except CPR where it may have the HUP
source registered via migration_connect_error_propagate().

IIUC, maybe we could change this check to be an explicit one, checking
whether cpr_transfer_add_hup_watch() has the source attached but not yet
executed (if executed, migration_connect_outgoing_cb() will also properly
invoke migration_connect_error_propagate()).

We could check against both "mode==CPR_TRANSFER && s->hup_source", but then
we need early release of hup_resource too (currently it is deferred until
migration_cleanup(), which is slightly hackish; after all the source
returns always with G_SOURCE_REMOVE for migration_connect_outgoing_cb, so
it was removed long time ago, rather than until the end of migration).

Thanks,

-- 
Peter Xu


