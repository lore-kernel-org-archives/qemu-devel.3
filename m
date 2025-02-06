Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14616C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9og-0000dj-Bk; Thu, 06 Feb 2025 16:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tg9od-0000dJ-Nf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tg9oc-0003jT-Bj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738878820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IlgzKcttoQ9X1JAT0VsIPyP5fedcMG0eRUVyYwc6NHQ=;
 b=d2GjynUWCav/gxoWncaqjVInAjveV12u0Kq6gfQWPA5SpsFpx6w1QMffHpmzwAtLGWgqlR
 jcGjt1ioealrWo3nqO8cslwowjprDb3kmJEFEZQmiBxB9S+7XWXiNkDrlpTN3kw9T/12ja
 3evqPZwllo3IgQPdwWbizJ6UgdvelU4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-ujZ8WIOiMFmoNf_GaZqB-g-1; Thu, 06 Feb 2025 16:53:39 -0500
X-MC-Unique: ujZ8WIOiMFmoNf_GaZqB-g-1
X-Mimecast-MFC-AGG-ID: ujZ8WIOiMFmoNf_GaZqB-g
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46fa764f79cso26221081cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 13:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738878819; x=1739483619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlgzKcttoQ9X1JAT0VsIPyP5fedcMG0eRUVyYwc6NHQ=;
 b=Z4nfeUC3WaS6PRWSK6Vp5wYrFCelqcNkitlbdDUawtsIIf34PRAUbRUBN68Ssn24nD
 5w17m6qVOzwydwPrm9lAWj6uSi9jC4NvNGPvXfV/HrmZhVpg19nnPHO9KpvuQV5xYQWg
 gQ3yEDiWYrqncP/Wm1qIXtmWMC4zn/W/78F72Pwh78nUCF5a1Xn2nvHfN9T9bcQnrhIO
 t9WQhgPOABDHKNmsrbRr+6Yk74J9btjz+bWw9uQASyIjtfJFunx3ipt6ZxAhNpwaUyCW
 arbxgcW2Wz07VOSBy0cegGT+Zb+uTTa21CGBU4ZnByt2rYp1uEOOe86pF+v7HnzXF58d
 VezA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3ibse0HJUHRQn95L5xO7XXt5lhUR2dIYTWmlNnf5hTWzvCy8ZVrli5FFZThB8Zx+i0xr4ar2mdFAA@nongnu.org
X-Gm-Message-State: AOJu0YxFV+D9qsql9bDKoxSI78RdnpWBGw5gH/fhs6gMrU2OopTjtslU
 9jHXl/ntHh6C06NuDFGhyYnhhZmxn90GcwiSO7USkx/LpYmldu2ucwouH9sno/0W9aEVMSfOa1C
 4Rzu35/tQ25+7EBNkbPolc1k/hxcygR80fCZx5IcrUZIcXHZ7Qsh4
X-Gm-Gg: ASbGncuKcFpu+uu/kYuE60RZtg/OCT3TSbRugWzFY8I+a6IU0t2L8dE44z+coKQjC2h
 UjTEfou8JcxnQeNKKSrrzcoyA/gpq2z8Kb5/sE6bAkPiO/OV4TOAbDcC/GGrYhcYQi3ZaJ9oTa+
 i1Yn7eeLkrB4CzHki/MTW7+yB058aZof7NRNfakXr8jm1rYbQJIbijj9PLK9ZoBNRntmcRChSq6
 6P75S2CUFn1REpxQB50oi+23MhSvYcWlImv2xPdDs8YSbpPV8qovnB7swm3DLTKycdGYQu23rGi
 dMZYh+LnbGf1TLJLgS/dnLrqwv8JYunkHHtVOumjNIcKe4CG
X-Received: by 2002:a05:622a:258f:b0:467:83f1:71d2 with SMTP id
 d75a77b69052e-47167b02618mr13963571cf.45.1738878818916; 
 Thu, 06 Feb 2025 13:53:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN35ipjbyDf2UzNAgFoTnybC/+AyXxsdKMNE4oL69Ppxb/WCUNuj+bBjqgDlZf6LIe8KWssQ==
X-Received: by 2002:a05:622a:258f:b0:467:83f1:71d2 with SMTP id
 d75a77b69052e-47167b02618mr13963441cf.45.1738878818681; 
 Thu, 06 Feb 2025 13:53:38 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47149276049sm9549951cf.5.2025.02.06.13.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 13:53:38 -0800 (PST)
Date: Thu, 6 Feb 2025 16:53:36 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/33] io: tls: Allow terminating the TLS session
 gracefully with EOF
Message-ID: <Z6UvYEeewuvZQmMl@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <fdd9a0a6053ac6aed32e08cc284991a3630bbfec.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6IvAXXfIgDRYV5o@redhat.com>
 <493dd3bc-8a3d-4b3c-8eea-08e674c38f40@maciej.szmigiero.name>
 <Z6I86e-hzJAlxk0r@redhat.com>
 <150a9741-daab-4724-add0-f35257e862f9@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150a9741-daab-4724-add0-f35257e862f9@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Feb 04, 2025 at 07:25:12PM +0100, Maciej S. Szmigiero wrote:
> That's for the multifd channel recv thread main loop only, if @Peter
> wants to patch also the mid-stream page receive methods and the main
> migration channel receive then qio_channel_read(), qio_channel_read_all(),
> qio_channel_readv_all() and qio_channel_readv_full_all() would need
> such treatment too.

No matter which way we go with the multifd part - I'm ok we ignore the main
channel completely if it's not prone to any pre-mature terminations anyway.

Thanks,

-- 
Peter Xu


