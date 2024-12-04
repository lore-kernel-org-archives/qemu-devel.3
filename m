Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8B1E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIx4j-0004bU-VD; Wed, 04 Dec 2024 16:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIx4i-0004ay-1p
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:38:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIx4g-0004NA-4N
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733348300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SgRCLonj8/L0Xj/8hDhH91NRJ2CHcWEULUQ4qFdbxBI=;
 b=QoZUZoo/er618mkXgL3yNMsi8ERhWBkFu6IaQE1nJYBP2o0C0ysR1Hl32cmE+3eyIbDxim
 /WY1B5Yv8ewF7KcEPUMmJBIPAi88rd9WvZJD+9jqqyxFrR+3X6G37vzX4Up1jRpX/Y1wkx
 k3gYNmPVdWBvMClmAnO4kKIPMNpfxNM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Owo3r6TtNXucXGI1DcSvVA-1; Wed, 04 Dec 2024 16:38:16 -0500
X-MC-Unique: Owo3r6TtNXucXGI1DcSvVA-1
X-Mimecast-MFC-AGG-ID: Owo3r6TtNXucXGI1DcSvVA
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-843e86e0b3fso29091439f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733348295; x=1733953095;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgRCLonj8/L0Xj/8hDhH91NRJ2CHcWEULUQ4qFdbxBI=;
 b=QtjjTN/zpsMhbPlyZF8/VNtzKz1rm9j9EtfH3bbUvTxpd8kZgOYlha004tdN3vlRx5
 iYZIpFQfK3tIQLjbj1VtRHFpeXL9bCc5q4Kh75A4B85nCf8h2eSJwKWAu+nt1eds9s0F
 011AuJArxfoC9HiYn/7o1zij/GQbBCNWV1O9oUyAVXlRJcF1VThCw7JOWTzq3OVZocEu
 v9vUHp5V8wJC4ztf/Zq76b21gETRVyb9x8C6ET/WlI/jxHBdosDh2I5ggRHG1PO6VFN5
 YcItnNy3r610OMDWrH9rQk1znktaFGD/2/4a+J3T0HFNXuALUdwBqjJ+Cvx5VTJvBJZ4
 eCiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSfpoku16XpfzaRAmmbecSpY3nJ2tK/slA/VE1RGsSSIOi/tBl3LCvLh/EZAgrxye/51efFUuBJg6M@nongnu.org
X-Gm-Message-State: AOJu0YxitQGs/SmkMLo7O2BcQaFKGtUg0SRt32inUDkdXhUg3VjV1M5U
 4qLjcCBySjRK+9O1wXZiAScC6uZT60QZV0riXgQkElWbTbkrO0jk/ns52fZYN9lMFTiEFIYtgGS
 ohHuWHEdvyUxnhy4BqRH4quluIhRrDvL9swM1fVNwsSmL4lGu1QF3
X-Gm-Gg: ASbGncuQTc1JGeBHBE1ukxke9i4/mzxS7TAhFxuwQoryuANokvgMQXKsFp6yVpOFloL
 HkvzoRFSiHfe5Q1obklVwXtgwxXvNpuORt2hM6YfTGPAqxkYGz+2An9wewsShQALH3Oqp+iO7o7
 itvTMABKYdHPbwiZbzR4MNgFfYth94J9KDm20XBGNrQdo++L/qCAbON5iRYQc1Eh3SmQYmikJ/a
 OLiOEMbiJMoX4bjLY/oq1yAhau2ziFH/8kGy8IBE5nfCCIdjGX1ofyq42PiRPU+a5EFE/rXRQIU
 2jUgdoXuVqI=
X-Received: by 2002:a05:6e02:18ca:b0:3a7:e800:7d37 with SMTP id
 e9e14a558f8ab-3a7f9a496a7mr91472615ab.10.1733348295355; 
 Wed, 04 Dec 2024 13:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB2tJ2otkygLMXeGe1RIXluUkmkCpZn8EKsBpX0mjQ2vHNdUhvVEX37NDrKjCm3ToHWWjQcQ==
X-Received: by 2002:a05:6e02:18ca:b0:3a7:e800:7d37 with SMTP id
 e9e14a558f8ab-3a7f9a496a7mr91472425ab.10.1733348295077; 
 Wed, 04 Dec 2024 13:38:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808d8ed40sm311935ab.16.2024.12.04.13.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 13:38:14 -0800 (PST)
Date: Wed, 4 Dec 2024 16:38:11 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 07/24] migration: Document the BQL behavior of load
 SaveVMHandlers
Message-ID: <Z1DLw2Tw9vZmH06K@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Sun, Nov 17, 2024 at 08:20:02PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Some of these SaveVMHandlers were missing the BQL behavior annotation,
> making people wonder what it exactly is.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/migration/register.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 39991f3cc5d0..761e4e4d8bcb 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -212,6 +212,8 @@ typedef struct SaveVMHandlers {
>      void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
>                                  uint64_t *can_postcopy);
>  
> +    /* This runs inside the BQL. */
> +
>      /**
>       * @load_state
>       *
> @@ -246,6 +248,8 @@ typedef struct SaveVMHandlers {
>      int (*load_state_buffer)(void *opaque, char *buf, size_t len,
>                               Error **errp);
>  
> +    /* The following handlers run inside the BQL. */
> +
>      /**
>       * @load_setup
>       *
> @@ -272,6 +276,9 @@ typedef struct SaveVMHandlers {
>       */
>      int (*load_cleanup)(void *opaque);
>  
> +
> +    /* This runs outside the BQL. */
> +
>      /**
>       * @resume_prepare
>       *
> @@ -284,6 +291,8 @@ typedef struct SaveVMHandlers {
>       */
>      int (*resume_prepare)(MigrationState *s, void *opaque);
>  
> +    /* The following handlers run inside the BQL. */
> +
>      /**
>       * @switchover_ack_needed
>       *
> 

Such change is not only error prone when adding new hooks, it's also hard
to review..

If we do care about that, I suggest we attach that info to every command.
For example, changing from:

    /**
     * @save_state
     * ...

To:

    /**
     * @save_state (invoked with BQL)
     * ...

Or somewhere in the doc lines of each hook.

-- 
Peter Xu


