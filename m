Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5251DE77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIweo-0005Lq-1R; Wed, 04 Dec 2024 16:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwej-0005LD-N8
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwei-0007gF-9G
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733346689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYJWkPROhQSc8nBcndaRxj61sV52bch/0bTJTEecKLc=;
 b=HVvJKw3tLbaMNJxxdqJqJngIxYPtqzms69xqTTbTXVd0c1iXngH9pjwZ6OvlxJDJ2Wp3mf
 iBnlpTokItPQs74jOXC6RA/MnCzMDh/hTa1fvoC2oLlUWeTEHSjKGd7VRmxhgtl8tAtWR9
 27SJoH5N1SImeSxlPPoc5LRlafwwRVQ=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Ja_QWZEzOlKqTCMGo4MMWA-1; Wed, 04 Dec 2024 16:11:28 -0500
X-MC-Unique: Ja_QWZEzOlKqTCMGo4MMWA-1
X-Mimecast-MFC-AGG-ID: Ja_QWZEzOlKqTCMGo4MMWA
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7e0d7b804so1684745ab.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:11:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733346688; x=1733951488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYJWkPROhQSc8nBcndaRxj61sV52bch/0bTJTEecKLc=;
 b=AFv1Z+zRheYatdVQdiTNitcJTPur5gMaIwu2QvQEpUBZIkPlieFbgG3kHkcyXkBXdO
 7jDJ+HPXX6iLALF52byEJp3K/DLVbqJ3Zml4fbq30CKqeySl/0Huv5O9WP1veK2DaJZO
 cS+9IKJ3uGv65RMUA53jSoDKo9rtrYxs8gWPE4BC8gsanwk/iFOYHepjxhP3qrYXqa5O
 scGIXVWFbWIydhZtw8z0fuD2y+aeuNqORxI2enO+CGX1/Q9DjvxqafL7o0JebNltZVxe
 bxtIVqlZpE2Xthxq+UELdj2YjQ0QwnCShDjreMs+sNErCFY/d/hhAsERym6PKBViU5Gl
 tApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZHGE1pQ+wJSdFsLunl1faUqHTC4bleADijbKS7RJ6hLoG1eykBmtaZyg/Lh2tgihA/jmwfrUGeI0t@nongnu.org
X-Gm-Message-State: AOJu0YxkrQEFGCNYo7gmsR+O3CmtPnPast2y36Hqot2YTQR38Oa+c1Th
 CvoWKFF1OtPtGt3vRObSv+tyu1C3nXy4b+JwMM8IfR3VJ0wWEMnDHohnQ7Rr3Tl181iOM/HdBiY
 +OvK6xhA2DDBWptYg6QK2HiQ/sq0mOEO0CmJp0gdvcX0Atw1yHd3f
X-Gm-Gg: ASbGncvVaBBq7+2mAQGOWevmJXlBGmIQzPiiPb6iZk2Gh3QjFc3f/B0qnB2+VIN4Lw8
 YRWurh4g9OTuv2h7p+M5Fta7OyERxiKVKR+eZKVOnddDxPa4TdvnJt83g//hVejOMQSqvUVKYm/
 D6zbkRNglcrSGcdePYeHQGhFP1P3BHcJIIcqMBqQmvCm5AiPwWVAVE9d1nPVpsLdi5r2DPZMOAz
 7MvR7gfy+Fb0N24QHnm2YCuKlip/ZfebX/EKleALzOBMi3aAab5vpafi5s9H0a3JopTRa/EY/+W
 l7mBKrJRo90=
X-Received: by 2002:a05:6e02:1448:b0:3a7:8720:9e9e with SMTP id
 e9e14a558f8ab-3a7f9a2fb33mr103969745ab.2.1733346688201; 
 Wed, 04 Dec 2024 13:11:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFqmQFj54LE1L10D+dyKRC2xtQk7wtg7gnop/kK3UmN+ctFzQdbWBlO7AXLTTURlDJjCb82A==
X-Received: by 2002:a05:6e02:1448:b0:3a7:8720:9e9e with SMTP id
 e9e14a558f8ab-3a7f9a2fb33mr103969165ab.2.1733346687480; 
 Wed, 04 Dec 2024 13:11:27 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a808db87fcsm184565ab.45.2024.12.04.13.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 13:11:26 -0800 (PST)
Date: Wed, 4 Dec 2024 16:11:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1DFfCngRr3e-9q2@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com> <Z1DAzzB1SfY_bL17@x1n>
 <87frn3i2mk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frn3i2mk.fsf@suse.de>
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

On Wed, Dec 04, 2024 at 06:01:39PM -0300, Fabiano Rosas wrote:
> > Considering it's confusing to mostly everyone, and tons of people asked me
> > about this.. maybe I should send a patch to remove yank from migration?
> 
> Take a look at my suggestion in the other thread, it might make yank
> make sense for migration after all. But I'm not against the removal,
> it's better than the current state IMO.

I missed that.  Copying that part over:

> I asked because for socket at least yank and cancel do the same:
> shutdown(). It might be more trouble than it's worth it, but I wonder if
> we could have everything that can be stuck implement a yank routine and
> just have cancel call those. So for instance, when this series does
> sem_post on a bunch of semaphores explicitly, the cancel command would
> instead call whatever yank routine was registered by the code that can
> wait on the semaphore. With this there should be no surprises of a
> cancel arriving at a weird moment, because we'd require "code that
> sleeps" to implement a yank.

If so, it means migration_cancel will still do the same as what yank would
do (but it could cover more now, like processing sleeping semaphores).

Actually, since it'll invoke a yank API it'll be the same from that regard.

However as long as there's still something extra migrate_cancel would do
after that yank API, then we should still suggest nobody using QMP "yank"
on migration instance..

Unless we want to precisely define migrate_cancel exactly the same as the
yank API would do.  But then it means the two APIs are identical, then we
should probably keep the one that people use the most, which is still, the
migrate_cancel API..

-- 
Peter Xu


