Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95474E92733
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGMo-0001r7-Rm; Mon, 29 Dec 2025 11:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGMn-0001qv-GR
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:45:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGMl-0000t8-Ea
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767026706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bl7UafSFz8NAw+s63DbEEtHNSwrPFrQtS6OUwiDmhIQ=;
 b=VmGLEO+cJxkR6i+59HYDuRfGaLSejVkpKPy5ny+7VtKL1502aAEoxxhe0jEkbjkA+aObNt
 BQ/0ik7TDe2vw4ab71ZPuNB03aXeTsSGODYjuPSMMhoMHWo6SD5LzcmTZKHXawMJO8tIjL
 8G2Nm6uX8OokO5kI9HU9Zn/oSZDZoyM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-xOAy-ZX1NqGjA8L6TI7RVQ-1; Mon, 29 Dec 2025 11:45:04 -0500
X-MC-Unique: xOAy-ZX1NqGjA8L6TI7RVQ-1
X-Mimecast-MFC-AGG-ID: xOAy-ZX1NqGjA8L6TI7RVQ_1767026704
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4f1d2aa793fso251578511cf.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 08:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767026704; x=1767631504; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bl7UafSFz8NAw+s63DbEEtHNSwrPFrQtS6OUwiDmhIQ=;
 b=cLE5fePzl7qa9bLMRWddGXvyoKAmxI2QNdmg689ms6tv4yqimjeBD6xMq+slcoWqD8
 yzjBFTvFs0kZXIQDVrFHi6lYG7JJWHIx1SMVFCamezzrek3HjiEMtgZMoV+8z+03MYFk
 LP0gBHkjcxQblrs6w3ghRL66WTP262WbOIs0jmhk3Ah0Z8ZBeTXIB+c2RWUkgfBzKwOS
 ztsCCsfiNk3FItd9ne9W2vHsftnxtQRdzqCmVdlKdXndfkliDi+TIFnNyNGnx4/547eO
 uySV/rmr14njOw9uhl2VZrAzYjr8l1KjNfUIrysRVl5QU9T+xNxRVg8yi8Uup7YdlNwE
 c0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767026704; x=1767631504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bl7UafSFz8NAw+s63DbEEtHNSwrPFrQtS6OUwiDmhIQ=;
 b=mfiJ6eelSuqjlQ/d9mCsEscAENeLpwGjrs39MkzGW/0335vQp0Fq7IlPv85lHtcpCl
 wCcr55uPeVCnJzcbGtL4xdp1WKD11F61ujGbCFHmn3XXymHupxRv9OWTxwAg8KI8iGJD
 ssolmclv4RIhuwtbs+L66JrUK98b+zds8gsw8sbcI+qe/5Fh0K2Ntvl9U5lqyqOLFtSX
 ev85pwuOsbB06HTf1wjgPWQv/xe08nNJhk6G5OOnkbpqsHCkzsyH/oDYD85OoYsbF1Cx
 kKHPbzsEY8Mq21tCZuwPCiYGxuh2nD6nvhHn0VBE+Htq0dnoH5NFyl5vZO37NAUMf/gh
 oqTw==
X-Gm-Message-State: AOJu0YwzbPgfyJYrDEmQCuRV/MjaYlpqE6XlzXvWM9wkgI1QpWTFUdgj
 T7NEqYjzLWJsJqTj9/7orMMYsopKEF9UZKI7pWIz5thipX9bAlVPNP72mkPLYgfvUTuOhWkh+GT
 pMQbvmt55p3E9XCeppF2Q87ZqjztGuskcushp+eqygj0v4Ir2n4+lEUHQ
X-Gm-Gg: AY/fxX5+tr0YpXQe1FFrt/6rCvPehobyD4N7YNwwM9+RRfYtHzzhLewn5C/CshyOqvv
 407PWpHEYdUPwVkDmkzh9A9n9/ypJmIdX8ZVMMLJosxsTjyrAHWUriksi6LEzKXuLSTa1UK5aVI
 atF+B7R0e0+vPNWW0ydM3gkvoSRQBqU7RNayxavOmAqSoiSjGJZcV7xpKOxaDwqy6cN8tmG6Zo4
 Dj526gs8xTYvajH4vUAIIoP25L3QcCyUwMEXFZOIjLyuswlavsRHybxrCk4MWZUwWULW/7oLFek
 Zt0ASJrBX29llefFndl3l9dta2/sBtyvKkZypmF3gz2+L4sE8meHSMaDtagDPCzbh/7VD8yiSLT
 HxG0=
X-Received: by 2002:a05:622a:480a:b0:4f1:b6bc:5833 with SMTP id
 d75a77b69052e-4f4abd7d3ffmr463177621cf.54.1767026703892; 
 Mon, 29 Dec 2025 08:45:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJvgsuSsXrQDnTNFG0RiZ9IABB7D2ypdIjiSyvNYsS1z+Mf/k/Do8e3AfPi1ySpZCRM6sNEw==
X-Received: by 2002:a05:622a:480a:b0:4f1:b6bc:5833 with SMTP id
 d75a77b69052e-4f4abd7d3ffmr463177291cf.54.1767026703431; 
 Mon, 29 Dec 2025 08:45:03 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ad519939sm226260081cf.2.2025.12.29.08.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 08:45:03 -0800 (PST)
Date: Mon, 29 Dec 2025 11:45:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 09/25] migration: Move error reporting out of
 migration_cleanup
Message-ID: <aVKwDpo5wxCWcwud@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-10-farosas@suse.de>
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

On Fri, Dec 26, 2025 at 06:19:11PM -0300, Fabiano Rosas wrote:
> In the next patches migration_cleanup() will be used in qmp_migrate(),
> which currently does not show an error message. Move the error
> reporting out of migration_cleanup() to avoid duplicated messages.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

With one comment on top below:

> ---
>  migration/migration.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a56f8fb05e..83854d084a 100644
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
>      migration_call_notifiers(s, type, NULL);
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
> @@ -4026,18 +4027,12 @@ void migration_connect(MigrationState *s, Error *error_in)
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
> @@ -4118,6 +4113,9 @@ fail:
>      }
>      error_report_err(local_err);

[1]

>      migration_cleanup(s);
> +    if (s->error) {
> +        error_report_err(error_copy(s->error));
> +    }

This should keep no functional difference, which looks correct from that
regard.

Said that, I wonder if we can drop [1] above, because when reaching here
error_in must not be set, so I don't yet see how s->error can be different
from local_err.

>  }
>  
>  static void migration_class_init(ObjectClass *klass, const void *data)
> -- 
> 2.51.0
> 

-- 
Peter Xu


