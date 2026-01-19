Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19374CCF2F6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 12:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhoRS-00005O-AR; Mon, 19 Jan 2026 07:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoRO-0008US-GY
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vhoRM-0005cJ-C2
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 07:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768825982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xJcJoWkTm/EoDkuXRCYc60sYCRJjN3BIAUVVT99dVJ4=;
 b=ZYzzhgzw7Rfj/U1J7+LRkEDNmrUfNcZKfIDti+qIwhIARKDq85F7SMmb4TVR1tqFlkXe5T
 9QXN23nmYpPaTboPc/MDjNBT2ESb+KIVFG+76lYtqJx4kxZMf/3Em5I5pZ/V2SCwTlNnvj
 +9jPAEUwLqr0l8AjqNCbLxKAzRLXhx8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-IHW3oKXsOR25TH_v5o70hQ-1; Mon, 19 Jan 2026 07:33:01 -0500
X-MC-Unique: IHW3oKXsOR25TH_v5o70hQ-1
X-Mimecast-MFC-AGG-ID: IHW3oKXsOR25TH_v5o70hQ_1768825980
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso21027645e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 04:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768825980; x=1769430780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xJcJoWkTm/EoDkuXRCYc60sYCRJjN3BIAUVVT99dVJ4=;
 b=VfhjCLwotH7G/0GihA8+9ealRehnKmW688woNmrm0Pw92ZSaqv1X6Lx7bm/c5IhPwv
 /OXqjaJ2fGOJnl8brxM5o/tLLlL7JZ7UVihMpTKkRyqd0sRqsqp1tPJDeZwQbUnxCTY7
 rsXOZqAhl3l+Kye/1L9zO/hSZI29KUu3rdCV3UjBLAzBcL0tZiAZAsLdPEt/dFjNK2JQ
 MO3EwM7OS1XoCU7CVkjtG3DrqBRCLNY1FljbhPmU8fjmalOJHG41zXilXeq5lCUYpiGy
 JKNqpdP2WDxkmqVrdOrPP7Sa/JIItrMHMGOPEUKzsMduZdjv7MR9c50fBHLV1jU7/6KN
 HNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768825980; x=1769430780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJcJoWkTm/EoDkuXRCYc60sYCRJjN3BIAUVVT99dVJ4=;
 b=JmwhsvlFsvOudcIMq5M2tvrYhr8Q8mZYn93ohz+/7nXYO+RVqL3h82mliJMnoQekUG
 +EcdHW88kDQlWA7ziTlvy1ZCwYB1+oncpNeqKI03mtcVODgCLBzH9t0C0t66wiesIymC
 aMlXzU6EJgSv4rzviJlH69a7wU6QLAhn8yj9wLpo4mAdCnLLzvvOim+ZIBhzlHG9QImA
 HT3P1Wdrdoo+Hr/zxhcSfEeDBYkdhQH0JteIN3rVgAmBe0oC3x3EUZ2IVAingYn2t+7k
 SgwmSf0OWLDqTT83EQ0TncgrwfKoELP/chF70ym1lyFyeo7L3g+/9641Zgocw84bQfX/
 akVw==
X-Gm-Message-State: AOJu0YykyOUDHdRW068iy9KvfGhl4tb90MBe+fW+wthra5n8chMNX0VC
 gAhhIemYElv3aTrvRv2svl0i2Tbt8qbi31WHVezRj87k/7Q7vkCVVTmxGzmvwMxLCnqbeNwH8/+
 jK756vj9u3BtN2m0rDsxoDqp9NKy5gC4wVeVIPEECK2vLqRXcCIitaFhK+R4rtm7lxhPZ7m91bL
 vsNjrtWtr0tDsFQXP5/PAg4XnOwZwJ5Z4=
X-Gm-Gg: AY/fxX7f9i/lyBre9E98BsfbzXW7430n+C1L1MHPL6xM0TRS+0+WGF4l9yfwhAU0jUc
 mqwzXzRkLDIKoSU9oXo9WJ7ynBjiwJ4nfDNRtThzbhhHxRWGyNRX1QdRyb3yFt0GZVxZPFFqnPz
 L3kOU/5Il4BR6haCMWxoqnE2DFJjicn/WuHBIiYDWV/2J99huHEKpvU2u7XpJsdQAMHMrkz4GEE
 3gAG5+JpU8v8I+Q2HrZgKJJ068KOizQrPBbrl/YDZgcHIYcfIpblwxS
X-Received: by 2002:a05:600c:524f:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-4801e685697mr117360945e9.16.1768825980108; 
 Mon, 19 Jan 2026 04:33:00 -0800 (PST)
X-Received: by 2002:a05:600c:524f:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-4801e685697mr117360635e9.16.1768825979692; Mon, 19 Jan 2026
 04:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-9-farosas@suse.de>
In-Reply-To: <20260109124043.25019-9-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 19 Jan 2026 18:02:43 +0530
X-Gm-Features: AZwV_QhJLJ0q9NbXg8_fLFYIYSoibm5A4e4VuRRfx5uzo96RTFPfLJDk2Bm8U0g
Message-ID: <CAE8KmOzQ_iW-TWVq1YypA8xE8uJBh9q7JZUvsmSQ2CMd3Y1__w@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] migration: Move error reporting out of
 migration_cleanup
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Fri, 9 Jan 2026 at 18:13, Fabiano Rosas <farosas@suse.de> wrote:
> In the next patches migration_cleanup() will be used in qmp_migrate(),
> which currently does not show an error message. Move the error
> reporting out of migration_cleanup() to avoid duplicated messages.

* duplicated -> duplicate OR double

> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 9204029c88..7bef787f00 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1528,10 +1528,6 @@ static void migration_cleanup(MigrationState *s)
>                            MIGRATION_STATUS_CANCELLED);
>      }
>
> -    if (s->error) {
> -        /* It is used on info migrate.  We can't free it */
> -        error_report_err(error_copy(s->error));
> -    }
>      type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
>                                       MIG_EVENT_PRECOPY_DONE;
>      migration_call_notifiers(type, NULL);
> @@ -1540,7 +1536,12 @@ static void migration_cleanup(MigrationState *s)
>
>  static void migration_cleanup_bh(void *opaque)
>  {
> -    migration_cleanup(opaque);
> +    MigrationState *s = opaque;
> +
> +    migration_cleanup(s);
> +    if (s->error) {
> +        error_report_err(error_copy(s->error));
> +    }
>  }
>
>  /*
> @@ -4025,18 +4026,12 @@ void migration_connect(MigrationState *s, Error *error_in)
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
>          migration_connect_error_propagate(s, error_in);
> -        if (resume) {
> -            /*
> -             * Don't do cleanup for resume if channel is invalid, but only dump
> -             * the error.  We wait for another channel connect from the user.
> -             * The error_report still gives HMP user a hint on what failed.
> -             * It's normally done in migration_cleanup(), but call it here
> -             * explicitly.
> -             */
> -            error_report_err(error_copy(s->error));
> -        } else {
> +        if (!resume) {
>              migration_cleanup(s);
>          }
> +        if (s->error) {
> +            error_report_err(error_copy(s->error));
> +        }
>          return;
>      }
>
> @@ -4115,8 +4110,10 @@ fail:
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>      }
> -    error_report_err(local_err);
>      migration_cleanup(s);
> +    if (s->error) {
> +        error_report_err(error_copy(s->error));
> +    }
>  }
>
>  static void migration_class_init(ObjectClass *klass, const void *data)
> --

* Change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


