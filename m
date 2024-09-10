Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C105FEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1ck-0001Pk-SD; Tue, 10 Sep 2024 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so1cj-0001LG-Ll
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1so1ci-0007Rh-7r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725977619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pt8bqbCwh9kKYJgKv8v45h+FfOHOODyraeYE53gO4t8=;
 b=C8RkVkMxriIDu8p/ytCdYwiVqGPO3sNhhcrPXqKrdyyE3yeApjkpdomw+OUIOQ1e6F0GYC
 8KrDGreEQq3M48GW4eXJQtKKZeQP2g9zMndq5Z1759Bk2KTjq6JUm0X3FSw9May9SxX09a
 1WTDYvZydvBRQErR9kJMCdeF+Y9rD68=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-nFNc7slGPT6tWngJN91sMw-1; Tue, 10 Sep 2024 10:13:38 -0400
X-MC-Unique: nFNc7slGPT6tWngJN91sMw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d0b29198so932410285a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977617; x=1726582417;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pt8bqbCwh9kKYJgKv8v45h+FfOHOODyraeYE53gO4t8=;
 b=dvjsysEp8Jo+4duN2Ub6XiBQ2CxyOjiuyI5h1V4s5tWa4zYfjSJDBIydi1oHrK406u
 gmeRN5SeFsGUWv1xYkrrh34My+udL0vOy15oDI2ObJ4pRYcYoJ+42J9fBGdjKflKQizW
 I8dX/irrTIU/aAtqTncpCoDcpmr3KckA9TuBI1jIGPwAcPZNhRHgeNPL1GZJJ0fRVDOA
 uqwQImexyO80PUCOB/3AG0pOwnm4rGGBo4U3IUK6h8qkEXr5GBWnOH7x3utekl89F51D
 tpYNND3/I1OhYibDqkauii7h+yPJCTBRSpediXCGOv/7Hn8InxMGA4CEPKYFzEejE5xr
 zAyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7g66UdzNyQwiqOAj8WJ0oRdkNsCNls9yZ/9zCPgUaMyVtokonXs4hyxGrTMHXjVFuLhHpB9iGF0Lk@nongnu.org
X-Gm-Message-State: AOJu0Yyz/5gGuOGXKHcrTi1cvtutr6VL5U0APDzgRE/6DhhysXDGg9Uy
 1ZPEnzCauAb1TIbJubGOwe/Dkgee4mQq4hWF0aky+YCE8/tOikJDYHBZ/SnY9VYnd2C+xIl2dfM
 bj9r5Z6/uuYWMFVdyQ6/idT4CbXhFcSxzKv3f2yS8S2Ctgx57CMwB
X-Received: by 2002:a05:620a:1aaa:b0:7a9:b959:7748 with SMTP id
 af79cd13be357-7a9b9597b82mr845879185a.54.1725977617464; 
 Tue, 10 Sep 2024 07:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhSVP9t81NbW6YYaG37bhZ2IXKUZT8vAHjjP+CYh63dyqFQDXdVkBwG2S6txIdWxw+RSPk3Q==
X-Received: by 2002:a05:620a:1aaa:b0:7a9:b959:7748 with SMTP id
 af79cd13be357-7a9b9597b82mr845873685a.54.1725977616938; 
 Tue, 10 Sep 2024 07:13:36 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a7a042b1sm309507285a.84.2024.09.10.07.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:13:36 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:13:34 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/17] migration/multifd: Convert
 multifd_send()::next_channel to atomic
Message-ID: <ZuBUDmJAErKggXYE@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <76dc3ad69fa457fd1e358ad3de874474f9f64716.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76dc3ad69fa457fd1e358ad3de874474f9f64716.1724701542.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 27, 2024 at 07:54:29PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is necessary for multifd_send() to be able to be called
> from multiple threads.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Would it be much simpler to just use a mutex for enqueue?

Something like:

===8<===
diff --git a/migration/multifd.c b/migration/multifd.c
index 9b200f4ad9..979c9748b5 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -69,6 +69,8 @@ struct {
     QemuSemaphore channels_created;
     /* send channels ready */
     QemuSemaphore channels_ready;
+    /* Mutex to serialize multifd enqueues */
+    QemuMutex multifd_send_mutex;
     /*
      * Have we already run terminate threads.  There is a race when it
      * happens that we got one error while we are exiting.
@@ -305,6 +307,8 @@ bool multifd_send(MultiFDSendData **send_data)
     MultiFDSendParams *p = NULL; /* make happy gcc */
     MultiFDSendData *tmp;
 
+    QEMU_LOCK_GUARD(&multifd_send_mutex);
+
     if (multifd_send_should_exit()) {
         return false;
     }
@@ -824,6 +828,7 @@ bool multifd_send_setup(void)
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
     qemu_sem_init(&multifd_send_state->channels_created, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
+    qemu_mutex_init(&multifd_send_state->multifd_send_mutex);
     qatomic_set(&multifd_send_state->exiting, 0);
     multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
===8<===

Then all the details doesn't need change (meanwhile the perf should be
similar)?

-- 
Peter Xu


