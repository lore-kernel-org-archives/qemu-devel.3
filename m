Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B5DC71151
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 05:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjXtD-0000Uw-ER; Thu, 29 Aug 2024 01:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sjXtB-0000U8-T4
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 01:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sjXt9-0006HJ-Sl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 01:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724910005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=egbMFc3XGtWxfPSy30sQ2UCmCGy+Sptw3QR5D0ZjpDs=;
 b=CFxHO1Am0QmXvvB8IqdC8x8aDwA1QAeEWnQ/B0NyJUZGjWi7w7BpoolKJn9RcM5yMHqaQT
 y0voP1dFOHrq+A7kO2rrRSZSDgrgeCwQlZvkVzvTHcSTffr+gzGqJl0tUUwG+LA2saUzsZ
 XG5rTl/cLWwT4HLbD4q9qW8zmVsqjGY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Zyh_pIv-PAKjL2byZk2nsw-1; Thu, 29 Aug 2024 01:40:03 -0400
X-MC-Unique: Zyh_pIv-PAKjL2byZk2nsw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42bb5950d1aso2987345e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 22:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724910002; x=1725514802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=egbMFc3XGtWxfPSy30sQ2UCmCGy+Sptw3QR5D0ZjpDs=;
 b=u1IM00ZpjyXyy5ots6TDyYpCn2JRZuORA80eysKXezBDZhpQnQa8RecpE5UrKsZ59t
 BhTrS3QMCbKCne5h7sJ1Ll5y+0NDt6REoUL156SIgjQa/hfMv5otewrN2aQ6LLElQ47g
 wOavRIuOghpW0QcicpglETCv6BhOm3ejxeqrTB5uS9iQJbBeiy0+wGHE4b3KcNJx4xLq
 P3rqTRrAL2bT6EVW/oDQ/UDQnpRi/Aa/ABEScCcDype44FYfWCvBhjXSm+K/OdUs9PyY
 L99XN16IsySHd61L445h+0FtTWwG8txw5Dez4prE0fMmcW1aP9L0IQcoDKhKYFIeK4pC
 5q6A==
X-Gm-Message-State: AOJu0YyyBy98TW3i8FvkyhaZOhKhM/C7t8yLnx1yfHmIBG8y3PYPs7K8
 3vPlCGkl0j5QkO8t+AbtRL1OlO4Pezt06ulZqwrUuBqhvTuRhOWaoWAvx3j6usEKU5VHxX++ro2
 jy64E75jaxZc0rSBChW18kKj7IwMtW/Eddjs8DqcDahhwjYb65wiuXs5h0BtDfFRzrZwdkZNnp0
 wdU/t5DxhHf4AvMREq4n2yvVOWo9E=
X-Received: by 2002:a05:600c:1d9d:b0:429:d43e:dbc3 with SMTP id
 5b1f17b1804b1-42bb020b7efmr16591325e9.34.1724910002281; 
 Wed, 28 Aug 2024 22:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlat3RbD8smJi4abv8XIBG6rDGkS/xvM2Etlzuw36D9KDtKjQFALY+2Ab7JIkQAPHAT3glWvJzJBG4rdMq6hg=
X-Received: by 2002:a05:600c:1d9d:b0:429:d43e:dbc3 with SMTP id
 5b1f17b1804b1-42bb020b7efmr16591125e9.34.1724910001809; Wed, 28 Aug 2024
 22:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240828100914.105728-1-ppandit@redhat.com>
 <20240828100914.105728-3-ppandit@redhat.com>
 <20240828071343-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240828071343-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 29 Aug 2024 11:09:44 +0530
Message-ID: <CAE8KmOyyUBSebh62_zdMyXWEZK+uUyx28Pe-aU-0E9d-upOWTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost-user: add a request-reply lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com, 
 mcoqueli@redhat.com, peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 28 Aug 2024 at 16:45, Michael S. Tsirkin <mst@redhat.com> wrote:
> >  - Place QEMU_LOCK_GUARD near the vhost_user_write() calls, holding
> >    the lock for longer fails some tests during rpmbuild(8).
>
> what do you mean fails rpmbuild? that qemu with this patch can not be compiled?

* In V1 of this patch, QEMU_LOCK_GUARD was placed near beginning of
the function. But that caused some unit tests to fail reporting
TIMEOUT errors. In this V2, QEMU_LOCK_GUARD is placed near
vhost_user_write() calls, to reduce the time that lock is held.

* Both (V1 & V2) compile well, but fail at '%check' stage while
running unit tests (on some machines), ie. rpm package is not built.
rpmbuild(8) on F40 machine failed, but koji scratch build with the
same SRPM worked fine. Those scratch builds are shared above. RHEL-9
SRPM built well on RHEL-9 host, but failed to build on F40 machine
reporting failure at '%check' stage of rpmbuild(8).

Thank you.
---
  - Prasad


