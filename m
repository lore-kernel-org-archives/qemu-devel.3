Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAA3E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIww9-0002Bg-3N; Wed, 04 Dec 2024 16:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIww6-0002Au-E1
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIww5-0003I0-0i
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733347767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N5EmvGGMgs5YCosqqJ7vvi2UiO4RjXUflhp0CueYXj0=;
 b=TuYpMdwuzT9B/w3VrfPVjSzxvM4QXmPc1WvuZpg2cm+U1mCw4HAIPPI3pbmjrnUdpDmo+J
 7wCikdbjyhOOPi7GGkHw5wETVsEHvJaKwItpSupyb1wLUN2Vtibg1UImeMlGyxM9ZOLqPn
 1wJtpqFeWBspm3zIEKZvIziv6ktLFNo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-wCfyHYpxPZqPGV4mtTIbzg-1; Wed, 04 Dec 2024 16:29:22 -0500
X-MC-Unique: wCfyHYpxPZqPGV4mtTIbzg-1
X-Mimecast-MFC-AGG-ID: wCfyHYpxPZqPGV4mtTIbzg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-841aa90930cso15406639f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733347762; x=1733952562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5EmvGGMgs5YCosqqJ7vvi2UiO4RjXUflhp0CueYXj0=;
 b=Uv1AgRLyXW75L7m0cvUU3DBtG1oP3CnD3nHYtyCdP47ZpqXZOgVB9GdFnQmvbYKBdL
 FJAqwvVnZKNgKAId/4a8ko4u/16bcns6HAqkYz1Yzlhkqk4SpyKRpWZw7Ryh/HYytl+y
 ep8nrGXhHBjbpXiiJEwcHub4bYWrnz7Q3OwpWMy2Tz7uVXkbWnKoeJArKQxavAQNk1UJ
 pzzEezHWFdSmmu2AHW/NqAV9LgUrQPMAjT2nE+CDhyzxedGZQm2LUFCFvTKvXo97WC0K
 7QjboWnHyXVMqfToJjVAUD/8QXRJpoL84IkALD5h4xd2FyEaIUgtQA7uU+SnNx1b5hVJ
 cCwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF4wNdurPrZH4z/s82pJoX/dkcw6RpQGbC94Ig61SQWxK+B517GiYRV2LUi91nG49LF8n38y1C9OM3@nongnu.org
X-Gm-Message-State: AOJu0YyBcPoFVvCc0S/iiEADxLMRSwlBmamyw/Qx4H0PBQaUG9XYgIAI
 cgyLM5ZFayzWE90bfGS52BF+hGIh+G70B+z142vdFHvbJyWAZv/5RKfTIydS2ztDFPFZI5t3FIn
 uIwB+aLJTpKmQCBdWd/mNwEpJB486O+alVWhXu38EKN7Rp2rCwOeb
X-Gm-Gg: ASbGncs6H29zxQXtDxjIrgGpiSWFBh5wYL/whW7yrnrz8LQRl4hOBmIY2d+sV2QzEJp
 n96SHpf6EGt82aAk665ZjspQOPsXtECf/xwK3NOHLOvv+sY6nVbojjYMnuMeD3KleIjNqHCnOle
 xUIXfGv26m6dZE0fnPUzoznv4XDDuYoZPPw086epb4Ax4G2nankw2K9CcWc4++LO2Da8nFZAJXz
 RlTZ3mdD+OIbqcNXv9COVP1a4u1l/+sgGEcFyEs0C8FiMNEDOE0riI4AXXbDtQ0imzZrxPEa2Wq
 zvER7EwU6YE=
X-Received: by 2002:a05:6e02:1a85:b0:3a7:a738:d9c8 with SMTP id
 e9e14a558f8ab-3a7f9a295cemr113799825ab.2.1733347761923; 
 Wed, 04 Dec 2024 13:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKDJFf4rfa5gGOz3LrM78i58Ag8qxsLQeksDS7RMdUVut0aRv60YtRypE6oxYpiwFamsSHeQ==
X-Received: by 2002:a05:6e02:1a85:b0:3a7:a738:d9c8 with SMTP id
 e9e14a558f8ab-3a7f9a295cemr113799615ab.2.1733347761627; 
 Wed, 04 Dec 2024 13:29:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230e74a52sm3271877173.122.2024.12.04.13.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 13:29:21 -0800 (PST)
Date: Wed, 4 Dec 2024 16:29:18 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 05/24] migration: Add MIG_CMD_SWITCHOVER_START and its
 load handler
Message-ID: <Z1DJroYiKUwK-kMY@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <624309a8e37f7779336bd5c0573d24f155b2ed41.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sun, Nov 17, 2024 at 08:20:00PM +0100, Maciej S. Szmigiero wrote:
> diff --git a/migration/colo.c b/migration/colo.c
> index 9590f281d0f1..a75c2c41b464 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -452,6 +452,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>          bql_unlock();
>          goto out;
>      }
> +
> +    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
> +
>      /* Note: device state is saved into buffer */
>      ret = qemu_save_device_state(fb);

Looks all good, except I'm not sure whether we should touch colo.  IIUC it
should be safer to remove it.

-- 
Peter Xu


