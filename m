Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F6BD116E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 16:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP1nv-0002z7-Hh; Fri, 28 Nov 2025 11:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vP1np-0002yS-OD
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vP1nm-0007MZ-Tu
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 11:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764349111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qNVIJbqu0qTQkxE+Q2EIrVGucjPFiFkfWgESzyvITeE=;
 b=SgqE0pjwm8OOfwGEg7JeM1wVHsvxzLnP3PBpCSVpBWOUyXqJyhXX2BZYjJeUfHAO6o/yZ3
 wwIuq4/Z6RMa3ydJ2z5DHSRyM5UgU2zH8za5tcRup3fa6SbVawXOGw+mq7Lf8BAENrRGuF
 9nbjQDTWIgu0OoebIHj7gcMmqM4WDkE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-orbfmjN4OESvM2WBmXZmUA-1; Fri, 28 Nov 2025 11:58:29 -0500
X-MC-Unique: orbfmjN4OESvM2WBmXZmUA-1
X-Mimecast-MFC-AGG-ID: orbfmjN4OESvM2WBmXZmUA_1764349109
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88050708ac2so44638496d6.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764349109; x=1764953909; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qNVIJbqu0qTQkxE+Q2EIrVGucjPFiFkfWgESzyvITeE=;
 b=qlZgBcYb8sciTD9boP2zUZA1bs6Gv7XH+e1+wlFAMWgqu184URX/XglDfXZsP41dUo
 6Cc7PJRIKK6o4G69F+0dZDbGg1xaWDlHELVAb4nTAhPwnivegy4mxlG0q0jEciQHGjNp
 5Hs5Bk15kJj38ynJGqcK20f+c88LR8mqR9W3+xRsPpOS9NaQbzSFRTUcJpDqKUkVK7t+
 EArbXPcnl1HUpjtb96nR2Df4AgR1r3hEynp5T0hhMq54vspSkVgkbEgXWuSlR9SbToeV
 srozeV3nENZiP1hPydClD5Eb0eHTlCWgmYitQAAK1vjb48nsjs653PIb8h9Wx73UrhFx
 W7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764349109; x=1764953909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNVIJbqu0qTQkxE+Q2EIrVGucjPFiFkfWgESzyvITeE=;
 b=oYo3/sEu+kmZJ3fTpwPCV0h9qqWQ3mPn9lSi8bF/4xLnVYQHtcjxfybbkV80LrDEOq
 QeyArHiVi+l5CTrGGftsCx6LmXW1xUA0eJj/evQQqn2p7YlCe5BW3QzwHJtyLmXdXZQ6
 umj5uf6cZsbdi1D2XEPB6a6d8iMtEVAPppDBgoVky+qoFanyEyXCvzHdTebF54DHGG0M
 qnV5A+pRjqjFfryyhbKykr1lXIMFGrI9ag0s3H0FH1Dcfc5ItgRmJML74HuSsEnPbeiT
 pgBXTem/d8V4ND+NE2d3i8epmeUHOXP69OBljuZEhr7fTL/5gy6ktsvapzqBMDSQmyYN
 iMgQ==
X-Gm-Message-State: AOJu0Yw2wRi6avYJEb3pcBnXsVEAPEX6cNggsQ68//jQI3dcYVnsvxR+
 Gmli05DiElwj9YOEo3S3XO5Pn7K8exMRzJ+/89pGa7uyczj96M0xFyg6aduY7dR2SUIsurRifHP
 exkwIBlcZhgQ+jt95gomA/K509SwX3IunFSadui+2Lv37V1guhoURBJtn
X-Gm-Gg: ASbGncutgNiLQVK/2z4mRHcuvs6AFM3NrnvIw3JOQuSrxgSqRc0IeOINnmrDL2Ckrd1
 Fl+aZFNiKH/IzQGHeVkIJ8LpqcuXVQ5eYs8YhsRR/UqZNzpTQY6m2WaiHeqVgUgNPmcrW9QdWUT
 0mj54KMSmqEIWcGrVYmeb4ePkrKNHsBRAqfnu1lFkzpOLSu+JrYe6E6bykC5H585pBvfq8l2ni6
 e6qsBDJg6yzUWyK0z7swdqLsW9iEMrbirUvQz1Eatxkgc+KspZYQENvcAVqE1wRAAvmKhfoIXtx
 33KPq3WJBge+HCk9XHc655sD9voVeoMMOD6RTyGxE4A6D/N3UlXT2xpKjOOdDWseE5C3wU9OlKW
 x2z4=
X-Received: by 2002:ad4:5f0b:0:b0:87c:2c76:62a2 with SMTP id
 6a1803df08f44-8847c57dc9amr419379156d6.64.1764349109222; 
 Fri, 28 Nov 2025 08:58:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkkeW0qZlUX3XXPtE5X1ye9Mgyu8PsrfwDfJzs74uarwG6/ZJg4lPuPT+/vz4i/66U1k1oAg==
X-Received: by 2002:ad4:5f0b:0:b0:87c:2c76:62a2 with SMTP id
 6a1803df08f44-8847c57dc9amr419378716d6.64.1764349108771; 
 Fri, 28 Nov 2025 08:58:28 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm32346746d6.16.2025.11.28.08.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:58:28 -0800 (PST)
Date: Fri, 28 Nov 2025 11:58:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH for-11.0 3/6] migration: Make
 migration_connect_set_error() own the error
Message-ID: <aSnUsxSCkkVJbcMt@x1.local>
References: <20251125204648.857018-1-peterx@redhat.com>
 <20251125204648.857018-4-peterx@redhat.com>
 <87jyzdfe2z.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jyzdfe2z.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Nov 26, 2025 at 08:27:48AM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Make migration_connect_set_error() take ownership of the error always.
> > Paving way for making migrate_set_error() to take ownership.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/channel.c   | 1 -
> >  migration/migration.c | 7 ++++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/channel.c b/migration/channel.c
> > index 462cc183e1..92435fa7f7 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -95,7 +95,6 @@ void migration_channel_connect(MigrationState *s,
> >          }
> >      }
> >      migration_connect(s, error);
> > -    error_free(error);
> >  }
> >  
> >  
> > diff --git a/migration/migration.c b/migration/migration.c
> > index b316ee01ab..4fe69cc2ef 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1575,7 +1575,7 @@ static void migrate_error_free(MigrationState *s)
> >      }
> >  }
> >  
> > -static void migration_connect_set_error(MigrationState *s, const Error *error)
> > +static void migration_connect_set_error(MigrationState *s, Error *error)
> 
> Recommend to rename for the same reason you rename migrate_set_error()
> in the last patch.
> 
> Bonus: all calls become visible in the patch, easing review.

Makes sense, will do.

> 
> >  {
> >      MigrationStatus current = s->state;
> >      MigrationStatus next;
> > @@ -1602,6 +1602,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
> >  
> >      migrate_set_state(&s->state, current, next);
> >      migrate_set_error(s, error);
> > +    error_free(error);
> >  }
> >  
> >  void migration_cancel(void)
> > @@ -2292,7 +2293,7 @@ void qmp_migrate(const char *uri, bool has_channels,
> >  
> >  out:
> >      if (local_err) {
> > -        migration_connect_set_error(s, local_err);
> > +        migration_connect_set_error(s, error_copy(local_err));
> >          error_propagate(errp, local_err);
> >      }
> >  }
> > @@ -2337,7 +2338,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
> >          if (!resume_requested) {
> >              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> >          }
> > -        migration_connect_set_error(s, local_err);
> > +        migration_connect_set_error(s, error_copy(local_err));
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> 
> There's one more call in migration_connect().  Doesn't it need an
> error_copy() now?  Oh, I see: it doesn't, because its only caller
> migration_channel_connect() loses its error_free() in the first hunk.
> 
> So, migration_connect() *also* takes ownership now.  The commit message
> should cover this.

Will add a note.

> 
> Aside: I'd be tempted to lift the if (error_in) code from
> migration_connect() to migration_channel_connect() and drop the
> @error_in parameter.

It was deliberately introduced in:

commit 688a3dcba980bf01344a1ae2bc37fea44c6014ac
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Fri Dec 15 17:16:55 2017 +0000

    migration: Route errors down through migration_channel_connect

That change will need some justification and care taken on its own when
changing back to before.  I plan to stick with the current goal of this
series so far (which is to remove autoptr for Error and also make the main
migration error API to follow Error's) to land this first.

Thanks!

-- 
Peter Xu


