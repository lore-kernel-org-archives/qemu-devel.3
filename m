Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527C9C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgRT-00083S-Gw; Thu, 29 May 2025 12:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgRC-00080f-4A
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgRA-0007P3-F8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748537339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXxOUbDvoOps0OVa9sDqkeu/6zFOhv8DA5lhrLbf0g4=;
 b=BEBwyUkV/3Yzym8kv+wz/716ljnE7XVD5ti5Lvz7TMaISYb6YH4oj3GjEWhknB6WlBchtO
 0vhKDEDSYtOhvvGcJbAgGYsltJCHbtgCFyKXWUZtJLZC+ydRg9hn3/LXFaErPYirtIPw1z
 M8iv9Egxu8+7dt8qVrdhcJNXtyQ/Rd0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-g1ODFCaGM5CeRyDCG6Sw_w-1; Thu, 29 May 2025 12:48:58 -0400
X-MC-Unique: g1ODFCaGM5CeRyDCG6Sw_w-1
X-Mimecast-MFC-AGG-ID: g1ODFCaGM5CeRyDCG6Sw_w_1748537337
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6cc5332so211535f8f.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748537337; x=1749142137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXxOUbDvoOps0OVa9sDqkeu/6zFOhv8DA5lhrLbf0g4=;
 b=Re+1eZ2YnqxMIKKQmKVTfNq3EokfMGHjfBVOdxzff5TiQJeZg0VsAJZopDCihy9oa7
 mzPPvZsHwqUPw3xgEhSyAXFuLDdGt1H5UD6DqrluInFucLoZ/FWKJCDmy/4Ay7KkoEvd
 ZqrHaEIpFspSVbnzohSEiVXrDx2TsfA6H4Ui9GmYNXS/d2lhf5OJ4EIh+7ZI95y3HgRN
 FZu+1DMryRSWsM3xNYWKadbBi4X/SgW2BkxEWrccJXfl4XeVQRmzfHm6Bln3Zxm7EDOk
 l/tHhTpKjtKtuZNAINfvsMeO5gaRUgBZYGRXqa3Dp0N8jBb9+TvJXHUjoHzXXGB1dbzJ
 3k8Q==
X-Gm-Message-State: AOJu0YyvnebXoBUr3nr486qWtRT6k/aZ2tFQs/185AeXq5C36cS4tcqD
 3eTVIL/00UtYQWsnrUyYfmy8aEqmqa8UYqjzDIn7QFXmlNWZ9mIe4dUMMoUWMourAT1U1LKod8Q
 DU2eG/kbJvZ8++sxWYhxqjRxPAsUpsZHqwRG1Zzl2grShBbPHZYGFbGFC
X-Gm-Gg: ASbGncvD34xFf0p3UQcv++DAO3GL0gTMGm5Qygs94ut1009qsTcyDSVfUPg/VRTbM1g
 1qpNrcYCkkzYBeYt1QH3NhAsE0FQhwdRZ+qPUEQHetHfbbQqb/mtXxL8XbMsxdddLBKTQJirBfZ
 m5y2Qdsut9IB/tzoKenihn0xKmC4/0pd44Xt9HPVqCHQH5FCJ0y7cf5yG+CIKK+LwOAMBlfJ5sk
 o/AOa80NaNwb5h9nsx/OQnt9doHRV+g9fCbkd2t+Yph3APqvn8IaOGLuSu6XQxOA2lvBxPNuBEQ
X-Received: by 2002:a05:6000:188c:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a4f7a23d97mr1816f8f.7.1748537336921; 
 Thu, 29 May 2025 09:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHatOyXqY9KJG9JnSruTp79/hBXsvSz/ybFW9+yfjzt/4QzqfAcj32XM6YpKsHzgqUgptlT+Q==
X-Received: by 2002:a05:6000:188c:b0:3a0:a0d1:1131 with SMTP id
 ffacd0b85a97d-3a4f7a23d97mr1798f8f.7.1748537336444; 
 Thu, 29 May 2025 09:48:56 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b7f8sm2455006f8f.3.2025.05.29.09.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:48:56 -0700 (PDT)
Date: Thu, 29 May 2025 18:48:54 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 10/11] migration: Rewrite the migration complete detect
 logic
Message-ID: <jqyhfpkut5fbi5b7crmhvl63wakdm4wb5jz7xt5aztpyj3bigq@zvygzh6nxxxc>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-11-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2025-05-27 17:58, Peter Xu wrote:
> There're a few things off here in that logic, rewrite it.  When at it, add
> rich comment to explain each of the decisions.
> 
> Since this is very sensitive path for migration, below are the list of
> things changed with their reasonings.
> 
>   (1) Exact pending size is only needed for precopy not postcopy
> 
>       Fundamentally it's because "exact" version only does one more deep
>       sync to fetch the pending results, while in postcopy's case it's
>       never going to sync anything more than estimate as the VM on source
>       is stopped.
> 
>   (2) Do _not_ rely on threshold_size anymore to decide whether postcopy
>       should complete
> 
>       threshold_size was calculated from the expected downtime and
>       bandwidth only during precopy as an efficient way to decide when to
>       switchover.  It's not sensible to rely on threshold_size in postcopy.
> 
>       For precopy, if switchover is decided, the migration will complete
>       soon.  It's not true for postcopy.  Logically speaking, postcopy
>       should only complete the migration if all pending data is flushed.
> 
>       Here it used to work because save_complete() used to implicitly
>       contain save_live_iterate() when there's pending size.
> 
>       Even if that looks benign, having RAMs to be migrated in postcopy's
>       save_complete() has other bad side effects:
> 
>       (a) Since save_complete() needs to be run once at a time, it means
>       when moving RAM there's no way moving other things (rather than
>       round-robin iterating the vmstate handlers like what we do with
>       ITERABLE phase).  Not an immediate concern, but it may stop working
>       in the future when there're more than one iterables (e.g. vfio
>       postcopy).
> 
>       (b) postcopy recovery, unfortunately, only works during ITERABLE
>       phase. IOW, if src QEMU moves RAM during postcopy's save_complete()
>       and network failed, then it'll crash both QEMUs... OTOH if it failed
>       during iteration it'll still be recoverable.  IOW, this change should
>       further reduce the window QEMU split brain and crash in extreme cases.
> 
>       If we enable the ram_save_complete() tracepoints, we'll see this
>       before this patch:
> 
>       1267959@1748381938.294066:ram_save_complete dirty=9627, done=0
>       1267959@1748381938.308884:ram_save_complete dirty=0, done=1
> 
>       It means in this migration there're 9627 pages migrated at complete()
>       of postcopy phase.
> 
>       After this change, all the postcopy RAM should be migrated in iterable
>       phase, rather than save_complete():
> 
>       1267959@1748381938.294066:ram_save_complete dirty=0, done=0
>       1267959@1748381938.308884:ram_save_complete dirty=0, done=1
> 
>   (3) Adjust when to decide to switch to postcopy
> 
>       This shouldn't be super important, the movement makes sure there's
>       only one in_postcopy check, then we are clear on what we do with the
>       two completely differnt use cases (precopy v.s. postcopy).
> 
>   (4) Trivial touch up on threshold_size comparision
> 
>   Which changes:
> 
>   "(!pending_size || pending_size < s->threshold_size)"
> 
>   into:
> 
>   "(pending_size <= s->threshold_size)"
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 56 +++++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 15 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


