Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED112E9273F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFWc-0001gP-Ti; Mon, 29 Dec 2025 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFWa-0001fR-Gz
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFWY-0008ST-71
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767023468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r5GB/jPnI0makKKh4NsjhAB7cxSNMwihLyQggccSU74=;
 b=an037FNk0QyS8uYNseaYlpJLDEfC2qEkoi41dG5uwf6RDb+UXFavmgnkgWqIeNcXK5g3DE
 dCnb7GP2rQ1HMw/lEUuPRe6tIP8dXw1U3jTdFtoOheR+s6qtJsExHFyKMHJl2ysbqmBLob
 YDedXR+eZcpn5dsBp+JeMs+syrq/AsU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-mCyUoGxCPWuUOYjUUllrEA-1; Mon, 29 Dec 2025 10:51:06 -0500
X-MC-Unique: mCyUoGxCPWuUOYjUUllrEA-1
X-Mimecast-MFC-AGG-ID: mCyUoGxCPWuUOYjUUllrEA_1767023465
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88a43d4cd2bso115610486d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 07:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767023465; x=1767628265; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r5GB/jPnI0makKKh4NsjhAB7cxSNMwihLyQggccSU74=;
 b=QvUfYwbxD3Sp7tm+zHU+fRtj7HycduXMyQNU5VSv6XpKfpH28B8bgQ6ZbThZp3AACX
 j8uUDU87rzauY7l5sGLFLDhfyoARZUsVtP42NY4r9BUi8b4VFa9w8V8WaXuY2hndwo1R
 +2nmgC1Afx4zdOyISNmC7bJE7CbrNd74cZoQF1R1gHWp6jdkTnPhotYxWesGA5B7muEM
 ByAOYbaw1F5yDIaKbt0+/C8m5fYiOMeH4KYuApzDSh2BCOpJSHCgpD7eGmPVqifPWaXI
 rp7RpqUtDih0H0ctBG6KvzMJOhzy+9RJI40oDsXYc62B1Bf3+U/p4U2KlRuvI3rT2UaO
 qK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767023465; x=1767628265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5GB/jPnI0makKKh4NsjhAB7cxSNMwihLyQggccSU74=;
 b=qobDjtS5bzAn7smQEBZgr+vNoeLJTwb1TfSvCpslapawya4b0XmgCFBBTWO5lOvWZ8
 Fgq7AkvafsrR+85l5ah2TLdj9zvjwsfgov8ETstXBA7488S+gqsiUgtGirMi5GM644o9
 pr0ZdCJa8wke+8lDlbATFDGib8VmAizlfEHF/aetMVwjbgqfuxB8BkGD2FJLF0wI0Q4L
 ZKHmgqr42XgB0g9P8RPHVqeFcRGHC3sxmszVIkXDRddjB0bQjpNk6pgCnD2ueyvsvWYx
 IP9n2823jeXaaQFSQs3SYSLGcl+0qPqybqnu+3tFs37de9bFZXRcsbArLh6BUnPdwq1N
 hjEQ==
X-Gm-Message-State: AOJu0YwCs7r0vgKp3D6yfp7DX8THnMqAZLxpVpvg0umwWb3djG7iWAJN
 yxjMTR8TWse2f1EyRHalDGRinryhO8RFX6RyIPdrkA+pfZThJ9N74q+v9Gw2IGCgdacS4r966Ns
 MqA9LXvf2uo5rThDd7yvPrB03MVHuxaGsRM6heVCtn/K5P2KGmDEIcv6G
X-Gm-Gg: AY/fxX4lGYoxwJOLxtIQ8WTYmJUSRfE57FF4U4/wQZSU0LteWevxhgG7qx2+GM9YlQh
 z2Z5w0pkw8NYPXNuJ226HxU34Ftx/jXmh7+sBHJ/r001UO/TpFuxNpkT6mIASFdO8hI1lMq5W6R
 sQAzgsN3Xuyj2soqiGqA632e7KK5Xi3PjV+VwQcAX7sCoiJ23aRoV5JCPCQsH2CO6P6JcL3KBLJ
 8+DiKYQ4rwjXGUGWdB9DT7wXowDbYR5LjQFVJl03MIY3EBSH8IzEqLpbIZVuXhHmEb/kJ7WLTZD
 xyzpYwxAn3gB0yrL1j4RawQjuJB3QHBSFYFMh/DZFcaWl1+j1FHbg7fxU3m65EH3/C3A5I1cSUM
 p+TI=
X-Received: by 2002:ad4:5d64:0:b0:88a:2d3d:7c30 with SMTP id
 6a1803df08f44-88d83f573ecmr448259896d6.55.1767023465330; 
 Mon, 29 Dec 2025 07:51:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjat2F31F6zyk/9akSEMxfRbcbwlzM315gEG/2pdygHd5ANFTQv6d8Kb5ul9poQQCJisQdmA==
X-Received: by 2002:ad4:5d64:0:b0:88a:2d3d:7c30 with SMTP id
 6a1803df08f44-88d83f573ecmr448259466d6.55.1767023464786; 
 Mon, 29 Dec 2025 07:51:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997addd5sm235401026d6.33.2025.12.29.07.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 07:51:04 -0800 (PST)
Date: Mon, 29 Dec 2025 10:51:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 04/25] migration: Move multifd_recv_setup call
Message-ID: <aVKjZyDWVH5ouvdV@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-5-farosas@suse.de>
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

On Fri, Dec 26, 2025 at 06:19:06PM -0300, Fabiano Rosas wrote:
> The multifd_recv_setup() call is currently in a place where it will be
> called for every channel that appears. That doesn't make much
> sense.
> 
> It seems it was moved when the channel discovery mechanism was added
> back at commit 6720c2b327 (migration: check magic value for deciding
> the mapping of channels, 2022-12-20). The original place was
> migration_incoming_setup() which would run for just the main channel,
> but it was discovered that the main channel might arrive after a
> multifd channel.
> 
> Move the call back to a place where it will be called only once.
> 
> With respect to cleanup, this new location at
> qemu_start_incoming_migration() has the same issue as the previous
> callsite at migration_ioc_process_incoming(): no cleanup ever happens.
> 
> The error message goes from being emitted via error_report_err(), to
> being returned to the qmp_migrate_incoming() incoming command, which
> is arguably better, since this is setup code.

This is not the only and real reason that you moved it, right?

Neither should it be the reason that you want it to be called only exactly
once; after all the function will be no-op in the 2nd+ calls.

I'll keep reading.. I'm guessing I'll find it later, but IMHO it'll always
be good to mention the real motivation in the commit log.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 71efe945f6..974313944c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -786,6 +786,10 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>          return;
>      }
>  
> +    if (multifd_recv_setup(errp) != 0) {
> +        return;
> +    }
> +
>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>          SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> @@ -1065,10 +1069,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>          channel = CH_POSTCOPY;
>      }
>  
> -    if (multifd_recv_setup(errp) != 0) {
> -        return;
> -    }
> -
>      if (channel == CH_MAIN) {
>          f = qemu_file_new_input(ioc);
>          migration_incoming_setup(f);
> -- 
> 2.51.0
> 

-- 
Peter Xu


