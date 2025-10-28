Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7535CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlUF-0005SR-7n; Tue, 28 Oct 2025 11:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDlU8-0005RL-ER
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDlU1-0000nE-5B
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761664772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQducGBU0eL0OYAMIb4Ca1kjVhRX6dZz2fI7B/2KgUI=;
 b=YTf96YN2XIuxHHGycbsgqcCRlY9rcYF6+GawL0DzCLQNq/bzYeJrrBHVrmvpbxLRmz0Qga
 WZD7r7OaRXjWxH84T4ii5uXfKN3nABVOZMERLZ81sfJpgqDQPwo0cc6d0AZLCapZBpNJuH
 38LBKaTDQkqYiOp0lud8oFgvkbseiYg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-ExXlV7ejN0a3ew38wzD6Tg-1; Tue, 28 Oct 2025 11:19:28 -0400
X-MC-Unique: ExXlV7ejN0a3ew38wzD6Tg-1
X-Mimecast-MFC-AGG-ID: ExXlV7ejN0a3ew38wzD6Tg_1761664768
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e892f776d0so278129451cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761664768; x=1762269568;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQducGBU0eL0OYAMIb4Ca1kjVhRX6dZz2fI7B/2KgUI=;
 b=AQbE2yHVEyWwqaeVcwYcExicCWyKreyDXpf+WE6bkC40fSNSm5J5cccN497pjsm9oW
 LUBzfjzveEaAHIXc8wAmpj7bKowPd3I2Zg9GbBB3ic2Lk+T5W+aK2Yr3IvKpyYLtauXh
 e7jaSu/c+J5ZU5WIEcfF6/2zdlDN2qYLe9FFofQHXyc9LGz+H/SBytoDdCI6e9rMN2rT
 0UZvWf43KTIuFtWTQue34/CNkWqbJSxM0c3qDDvyWVT4TLy9Y+VgTiA8kr7rHp1BL4wZ
 MB0yFVGSeOaQPDpXkI1ufVIv1+3ECJoZxwTg9ulx2CJyxDqkS8NU7KNbSzs9pfJBXfZt
 jAlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBJJn6JskD8Mp2XZBLSNUzJDylTXfMO1OGo9Cm16x6Xe1TQ3dOmya9mUzsrRxEdWOfM50/ZHD2NAJL@nongnu.org
X-Gm-Message-State: AOJu0YzVOFXKg5sDHx3asG3aXsX+dhaYVzGECY2VW9ejXEQNN7nbnBST
 fFiSSn9GaxaoAAyS+45ecvb0jFiITGOniu0U7W3XN+FGtwHgIdWPS/q65FTYZiJ9MNd+JGYPWFA
 Pw5vb/5eeaiZOIZlxzDFcK+LeDxnZfEZmzUZZ2Y/4CSNUUHgrE1Hu8Mh2
X-Gm-Gg: ASbGncvHrYrLyI0JVoCOzIPqb44Qvy59DI95iMgSqakIpZA2vL0hujSN9tQQ/4vLyRU
 yxasu1TG/AukEeY6IS5IOaAw3fmps6ZapmhefwW7yxe0FfJ6ybuGOiZabobkRLhi+aFgk3ObNa4
 oF20Pgy6obmqUOyzwlBh052dSymB69RIL72pqEEhsPP9ELFo2qiU0Bu1gDojpw5lj5l9NbCVRp3
 CGgNYquVAJ6oWgAnmhHKfD35Y8InEGRPm1YnDSXR6NBxxu/lIXXn8NBpIfJ3TBtjNQosDihTOdo
 t2IAnAwATlESGBTCZyMCbandb7UUg/luwTBk+e3+FuxtGUGRQ/CWN5aw86LkIob6m5M=
X-Received: by 2002:a05:622a:4896:b0:4ec:f5a1:a2c4 with SMTP id
 d75a77b69052e-4ed0749a32emr55181671cf.9.1761664768259; 
 Tue, 28 Oct 2025 08:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL225WHvl2ZFdzf/re5AHJkSS1N+wUTki2D79YxqHjHX1PByZBu7OyjME6kRWdaKAnqtfYXQ==
X-Received: by 2002:a05:622a:4896:b0:4ec:f5a1:a2c4 with SMTP id
 d75a77b69052e-4ed0749a32emr55181081cf.9.1761664767709; 
 Tue, 28 Oct 2025 08:19:27 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4eba387fdb2sm72226281cf.37.2025.10.28.08.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:19:27 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:19:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, guobin@linux.alibaba.com
Subject: Re: [PATCH 0/3] migration: Cleanup around MigMode sets
Message-ID: <aQDe_UZF-fwsqkuL@x1.local>
References: <20251027064503.1074255-1-armbru@redhat.com>
 <877bwgeau8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bwgeau8.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 27, 2025 at 10:24:47AM -0300, Fabiano Rosas wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Markus Armbruster (3):
> >   migration: Use unsigned instead of int for bit set of MigMode
> >   migration: Use bitset of MigMode instead of variable arguments
> >   migration: Put Error **errp parameter last
> >
> >  include/migration/blocker.h |  9 ++----
> >  include/migration/misc.h    | 10 +++----
> >  hw/vfio/container-legacy.c  |  6 ++--
> >  hw/vfio/cpr-iommufd.c       |  6 ++--
> >  hw/vfio/cpr-legacy.c        |  8 +++---
> >  hw/vfio/cpr.c               |  5 ++--
> >  hw/vfio/device.c            |  4 +--
> >  migration/migration.c       | 57 +++++++++----------------------------
> >  stubs/migr-blocker.c        |  2 +-
> >  system/physmem.c            |  8 +++---
> >  10 files changed, 40 insertions(+), 75 deletions(-)
> 
> Series:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

I recall I tried to convince Steve to use a bitmask like what patch2 does
but failed.. I didn't push that too hard, though.

Queued, thanks both!

-- 
Peter Xu


