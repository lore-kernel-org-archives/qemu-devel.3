Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C548F5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEudo-000597-5x; Mon, 20 Apr 2026 15:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wEudm-00058T-2i
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:50:42 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wEudk-0007Ch-0i
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:50:41 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so4351915eec.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776714637; cv=none;
 d=google.com; s=arc-20240605;
 b=Mez2SazArTjKJ3QQ7qIPsHWum5P/0vSqtvaeAP5UE1VuKOG7qwyZLFFyNv4FwXTAtM
 +C3/6x03Zr/6TRmbRNy6RHJucYQ1/wXKoBODrQaE0N1gru7bCsehbX4koT3ZDu37xoBh
 L9u1LWkbHkEKETXjhLhkh2ROPLxbwVyk0D8utQMLPa2OKtuBxIHzPm8q6Pj3EUDYX1/s
 YAptiaD+CQMxY8K2/0p48FnASNXfMkfo1bLCrt6+7DvUs0OcuYZVJ+7CFrUuJzSctPOr
 BG0CFRuRBTTMz918QkcVWetKD+VhwJ69+zEuFf5yFdRlZ8gjNymJ815eaem09+os+WU8
 Klgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kU+3bier+XxAIEfgQXzu6BYyfFhLqhrehILZE05xFw0=;
 fh=yHtdBvj3A+6LB7O7PY25VbVbN9BGzHkl0W0yQXMvNjM=;
 b=CqpMXtSj+Sn+D2aD1TdnJ4X6reRh3beeJLVf0WPFJ7wnjPqL4+KGDaO49TgCdG/DtO
 dXTqja008tRYZ2n0gcL4PqkElA3pkk5W0Bd6Bt6/YwhKhWcvX2qmIxeAGpH8RnMOGnlM
 ZhCQWgN+IdCMO6tQqcC/dL799zA3zUnU0brFC2DczTrf3Xmm9wlS8zSGn9EQ4Nv4hej5
 ZczQ2xbjHPHuy1yRUaNaf69UvlDty7GFxhwOpazd8nDztWLm3PUarxe8cTS2k02Y8wsl
 tLlwJEaJhfprpAV4+3HEhS6zp29eav4gs3Z2w9fRcSVumiDQxqXLX6JXpTKciRaDIuEe
 UsRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776714637; x=1777319437; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kU+3bier+XxAIEfgQXzu6BYyfFhLqhrehILZE05xFw0=;
 b=Y8LVrkRehnO/EL0B0oHzmBtfyTaTQ13naqNLmXWzAQ38IkAoOQgYJBjgGqEsnxlX+T
 iQmqMZjhWTwYUUyRX6WqiwayH/IuAyGWLkYRbYv9jP71goS+DmZY0MD5EgY4tOftHtpG
 zTyeOeMrKuZRjk6OFbqN/t/h+JzzTg0SVOESzxgnNtovrKbyZTxb05KcPlxr0fi3QJ1Z
 fuyDO80Xvx+P+mc4rkmlcOKGRR6kAsc33bf21SpNbqppGd92SDVgyVlxGDIhurQs91/7
 VADAG5l/lfbEiPRo2TilVHD+omxUdsUOdU2REM+SLMEKzjoBYclucAS4cCnaUYPDyJ/e
 sjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714637; x=1777319437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kU+3bier+XxAIEfgQXzu6BYyfFhLqhrehILZE05xFw0=;
 b=nor8mwn3MErjePD6uAQK4UyIw72jzLRpgCvv2YlJvMVMUQwvDFxqWWU7emmmZTtIOp
 PJ6lbr4TSiYxL6VCPT48NZ+E55WeswfSZM2rTGehs0nbODDuxRE1T7ahm+4DVVekE/9z
 GCPHYIgAXwr6UVjsAdvagibw/G62iCrG6Z1o+gOg62prx1tHjEmWiYyFI7A3ww2OXfA4
 rBrFkjGKmrPIE0L5RJI1U+0f3Oe1j8RHMvBJkSe5Sfc5KTohjAUPC3rhHob3BrmC8qB6
 f1TPHeaN0QdBG7qv7AcpGOOmQ4Q3iKDRZazFKskS3jRlLJNOPcqX85s5ncmpnhcbJ0b1
 u9EQ==
X-Gm-Message-State: AOJu0YxwHxUxaRYtFX3EQqOAAW/Y73UkiWWBsm6LfkVfjF+IHNFVNz8r
 XQIReDyRY5+xHVH6iM7CnQwSuigg12V6VhgfRzn+sadJGI2oxFvGcIe+PszJQ/mZWjk5oUMqCoH
 hkZsOKGm6EVP/fJbrojdQwcgI8f7VWOs=
X-Gm-Gg: AeBDiesscO0dK8+RaHEbKzY+Rng4rpaY8nF/olKyI43ThZn0veH4LsuuIJAm5JWx/ZJ
 prBpT6irNCioW5QM5A2BuAEya3tB6coijVhoKGARQQdOSJeSYKY7nH0ZFegX9QwtOQK6ZdycPvW
 eh2zpZSa7Ry9bRqRFUyr0JKM8rpCo4DcrYmxG2wwtsluafbgnzeKWHyVzcgDcdLTx8ym8CR02hH
 XPVPUcvnZAd9wlqWUh2W2tpfJCRS9+BIzkxpz2AKsXyhOYBIaXEKWuGbaZhD5VDwxiteWb5SMll
 LphHKDBn0bNsRH6zoXEIwkeNsCyIzR/JOB+ZnFQcu1X9cTJI5fg6cYpjPSx+ew==
X-Received: by 2002:a05:7300:6d23:b0:2de:aafb:fef3 with SMTP id
 5a478bee46e88-2e464eaa418mr8514291eec.1.1776714637096; Mon, 20 Apr 2026
 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260417184742.293061-1-marcandre.lureau@redhat.com>
 <aeaBKzauFijGRhWr@x1.local>
In-Reply-To: <aeaBKzauFijGRhWr@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Apr 2026 23:50:24 +0400
X-Gm-Features: AQROBzBclPENOFrYgUqaDth6m-749jx-rJFAkf4wW5UHhbn03Ncw_TbmYL5Eb_E
Message-ID: <CAJ+F1CKboKMKA0MbGhURhCSW5HkOM0+jQ4Sj4nWEXbLafpS1fQ@mail.gmail.com>
Subject: Re: [PATCH] migration: fix abort when re-migrating after cancel
 during SETUP
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, steven.sistare@oracle.com, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Mon, Apr 20, 2026 at 11:40=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Fri, Apr 17, 2026 at 10:47:42PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > When a migration is cancelled during the early SETUP phase (before
> > migration_connect_outgoing() has set s->to_dst_file), migration_cancel(=
)
> > takes a fast path that transitions the state from CANCELLING to
> > Cancelled without calling migration_cleanup(). This leaves the migratio=
n
> > yank instance registered.
> >
> > A subsequent qmp_migrate() call passes the migration_is_running() guard
> > (since CANCELLED is a terminal state) and then calls
> > yank_register_instance(MIGRATION_YANK_INSTANCE, &error_abort), which
> > finds the stale entry and aborts with "duplicate yank instance".
> >
> >   #6  0x000056028b5e17fc in error_setg_internal
> >       (errp=3Derrp@entry=3D0x56028cc8cb18 <error_abort>, src=3Dsrc@entr=
y=3D0x56028ba87fa5 "../util/yank.c", line=3Dline@entry=3D87, func=3Dfunc@en=
try=3D0x56028bb77140 <__func__.5> "yank_register_instance", fmt=3Dfmt@entry=
=3D0x56028ba87f8d "duplicate yank instance") at ../util/error.c:100
> >   #7  0x000056028b601b2a in yank_register_instance (instance=3Dinstance=
@entry=3D0x7ffea0cf36b0, errp=3D0x56028cc8cb18 <error_abort>) at ../util/ya=
nk.c:87
> >   #8  0x000056028b25221e in migrate_prepare (s=3D0x5602b0a7db90, resume=
=3D<optimized out>, errp=3D0x7ffea0cf3718) at ../migration/migration.c:2001
> >   #9  qmp_migrate (uri=3D<optimized out>, has_channels=3D<optimized out=
>, channels=3D<optimized out>, has_resume=3D<optimized out>, resume=3D<opti=
mized out>, errp=3Derrp@entry=3D0x7ffea0cf3718) at ../migration/migration.c=
:2039
> >   #10 0x000056028b5891be in qmp_marshal_migrate (args=3D<optimized out>=
, ret=3D<optimized out>, errp=3D0x7f63392e0ee0) at qapi/qapi-commands-migra=
tion.c:459
> >
> > Add missing yank_unregister_instance. Alternatively, it seems
> > migration_cleanup() should be safe in this context too.
> >
> > Fixes: 624e6e654e11 ("migration: cpr-transfer mode")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
> to cancel the HUP source when waiting, however did it wrong.  IOW, at lea=
st
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
> We could check against both "mode=3D=3DCPR_TRANSFER && s->hup_source", bu=
t then
> we need early release of hup_resource too (currently it is deferred until
> migration_cleanup(), which is slightly hackish; after all the source
> returns always with G_SOURCE_REMOVE for migration_connect_outgoing_cb, so
> it was removed long time ago, rather than until the end of migration).

This is a bit over my head, I am not familiar with CPR. If you can
take it from there, I am fine. I just wanted to fix the crash :)

