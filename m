Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE2DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 17:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thuLm-0005ae-7j; Tue, 11 Feb 2025 12:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thuLF-0005T6-5y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thuL8-0003Gd-HS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 12:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739295983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NqCMGXt4hu0GttXxhi02XbGcThSTPTfW7XVUujKjrJE=;
 b=S2fX3A8vq9IA44KhFKCZ5QCdrYMvgauCKqlszXeXvwO7UfF+jbhP106SqYQGl+2tCMyOIK
 3he1IFWJMe4t0HlTwPiUhMs9oguqBcApR1fZG9760UHkCBbWiGHy2Cvzj8g/zexo/E1TRI
 CHfIzkMeHWcC92TVcvgg4UIewZkb1sM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-v3mpcYNqNZik-SIgyn1BXg-1; Tue, 11 Feb 2025 12:46:17 -0500
X-MC-Unique: v3mpcYNqNZik-SIgyn1BXg-1
X-Mimecast-MFC-AGG-ID: v3mpcYNqNZik-SIgyn1BXg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e4529f9682so67634816d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 09:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295977; x=1739900777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqCMGXt4hu0GttXxhi02XbGcThSTPTfW7XVUujKjrJE=;
 b=HgfW6ibLiOB89zt+MZpVJ0irQy7uf0qeanaoVOuNEEnvNm43cRooB/EKL4AIGEmWkD
 5qPlas3j0MeVD7TtUunMMTXYranZH/PNk5gnesdx7XTHRm59IxL8sIDAugepNoASqC9p
 pDwH4bl0EF6VQf48TAnvP4XHP1ykeQ/7kZo6RPgQTnNNiUhlKA6r3l3BIfpWpKrOp9r2
 /0xiPxJgVWOhlRzkdbmTsy+uc3kSCARvU5qwd6U/AM1S9IZOBldFuPL/qLDsUWv8IqTC
 WRst026rBhMoNImK8VaediCwPxpP9nMrDTRggFfmTYd7mPPGCIxjJHjsfQ0dCdCPzZ/1
 o0Fg==
X-Gm-Message-State: AOJu0Yw9vPvaKJ9jT7KBPZZg3e5uCjFC7rng/bZYforY5fXshKiL1MtS
 Z+1mWJOxaWKh6AVfSF75rQCBrM4gEj5XIde1ZzDk3EOKMkMY0Y5fa3w1/XsgcCAFeXs6doCN04G
 FUHbVukjwsXEY0xAqVnBgjp8nYe7xBeLdyIOJn34nEpx6scyxuCOj
X-Gm-Gg: ASbGncug+zha48LJrP6vwuiWKJPK3tQDZ56hN/eqlCJt3E7vPqzHkz+mJq5RjGBhrth
 JG7LtL8tD4K0lKSsUm3OS8w5PYFyi3I69vHoLUb0+k9r1JkpAzh/HmI2UE+pBhL/BI+F90i8l+a
 +rGzahh3CSk+UA7h8nDETlXrSNIKgAXHvjB7/E2HTjo1XLFhwymCIq2Rf24xAHbp8V5ivBi2d9o
 6zqzrP2aDQyhZeiop/YwuDHFUmd1LIU02EXZdrnEiJIJ5FpAxstJ61inCA=
X-Received: by 2002:ad4:5d6b:0:b0:6d8:92c9:12a0 with SMTP id
 6a1803df08f44-6e46edb5c83mr3216126d6.44.1739295976996; 
 Tue, 11 Feb 2025 09:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsjG7IB2cCU3w+HNnuJNrXTt24lOrcMU4BfSvWj+CLJkt9d26b5MQZi4WIf42xrfDHZxxJaQ==
X-Received: by 2002:ad4:5d6b:0:b0:6d8:92c9:12a0 with SMTP id
 6a1803df08f44-6e46edb5c83mr3215736d6.44.1739295976557; 
 Tue, 11 Feb 2025 09:46:16 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e456893843sm38656236d6.59.2025.02.11.09.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:46:16 -0800 (PST)
Date: Tue, 11 Feb 2025 12:46:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 6/9] migration: Don't set FAILED state when cancelling
Message-ID: <Z6uM5TDDGb5FkVqf@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 11, 2025 at 12:01:33PM -0300, Fabiano Rosas wrote:
> It's possible that the migration is cancelled during
> migration_switchover_start(). In that case, don't set the migration
> state FAILED in migration_completion().
> 
> Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I remember I paid some attention on this one when working on the commit,
where it has:

static bool migration_switchover_prepare(MigrationState *s)
{
    /* Concurrent cancellation?  Quit */
    if (s->state == MIGRATION_STATUS_CANCELLING) {   <================= [1]
        return false;
    }
    ...
    bql_unlock();

    qemu_sem_wait(&s->pause_sem);

    bql_lock();
    /*
     * After BQL released and retaken, the state can be CANCELLING if it
     * happend during sem_wait().. Only change the state if it's still
     * pre-switchover.
     */
    migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER, <====== [2]
                      MIGRATION_STATUS_DEVICE);

    return s->state == MIGRATION_STATUS_DEVICE;
}

So when holding BQL logically it can't change to CANCELLING, it'll check
first [1] making sure no prior CANCELLING.  Then after release and retake
BQL it'll check again [2] (see the comment above [2], it's done by passing
in explicit old_state to not change it if it's CANCELLING).

Any hint on how this could be triggered?

OTOH, when looking at this.. I seem to have found a bug indeed (which could
be another?), where I may have forgot to touch up the old_state in
migrate_set_state() after switching to always use DEVICE..

diff --git a/migration/migration.c b/migration/migration.c
index 74c50cc72c..513e5955cc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2793,8 +2793,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 fail_closefb:
     qemu_fclose(fb);
 fail:
-    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+    if (ms->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+    }
     migration_block_activate(NULL);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();

I'm not sure whether it's relevant to what you hit, though.. since you're
looking at this, I'd rely on you help figuring it out before I do.. :)

> ---
>  migration/migration.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 375de6d460..5dc43bcdc0 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2986,7 +2986,9 @@ fail:
>          error_free(local_err);
>      }
>  
> -    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +    if (s->state != MIGRATION_STATUS_CANCELLING) {
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +    }
>  }
>  
>  /**
> -- 
> 2.35.3
> 

-- 
Peter Xu


