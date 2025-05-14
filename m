Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4D7C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFC97-00010G-4z; Wed, 14 May 2025 09:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFC93-0000zK-Mb
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uFC91-000675-Iy
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747229250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viBZtYiRp1SLIBuVyV9+GTDTUajMsIt468HpiqEVSKk=;
 b=XCka8LkdQZ/BnAd9ewrSeLNlXaxkRxYo4KS1mb0cPgDtm0tSUOhL6FGGwf/YdJ4LCe5qaS
 7fDajlKekfw+JaAPb23T5CM/XbK0mGsTm+igb0JWYTi6sMGl/Au7LyiguVdsI0WGKk70hJ
 4PmxPP2R9jAgLDMRmemPwbvfYv3ZhiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-tDeuV4g8OoyvM4AuQeWM2Q-1; Wed, 14 May 2025 09:27:29 -0400
X-MC-Unique: tDeuV4g8OoyvM4AuQeWM2Q-1
X-Mimecast-MFC-AGG-ID: tDeuV4g8OoyvM4AuQeWM2Q_1747229248
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so33316635e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747229248; x=1747834048;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viBZtYiRp1SLIBuVyV9+GTDTUajMsIt468HpiqEVSKk=;
 b=QFsAMa9/7ERTpa9UBaO7MeOcmhpUuwx0iR+L3Wlru3wO8mYRcB7/Au33k5FEHRNZJi
 kFTQZroLiItWy2OWoETnyRBWyUxGUA4t1aZ2m+/my8qMhrmlw7e1FYxnuiLyiFhDq/4l
 R/WQFJhFAf+io3o3NltpuXsRFFKbJoh20VagmbX3yc0d9ZOWxvWi8QK8X0C/b1p+/8Ym
 zi+/7VMXKnB9cPn1oYMM2vK6KQNlHdZUdiZIABE64snf9tmAwjBIQ5hEny11pcqP4v/0
 s6ySNpAp5eUSFjQo4Wl8cKfFhfcP3I1GGFzWp0oACKMO2uVs6irPVPMm15frz4iHzOa7
 +iWA==
X-Gm-Message-State: AOJu0YyKZ3E9dB1OU+C7oN/MIeJJXmXMcyWLfxI0mZvCmhr/5TT/AK2a
 EOIODwWWA2X3MO4jxQPvyDwGcmw4HtbJFwllMZW5GaNz/4T1NQP3hakHeLdV0RhyLN3q+WXaF/X
 RoNhAYwvBVqaTy7YSpXDOnJIxcFGvqE7d3GYoSWKZcE+lEEZOBvsm
X-Gm-Gg: ASbGncsgcS9MSS05o/GlPBIZ/D5ae4xjPBkD0TwMrFj5r4duGP4sUGK0aXu+ZKCUEv1
 te8O7t3/VyO2jw9JWDfEnhrqJruG8eSNwFgmhxnDU615e3uUsaOBzr6ufk33av8qXaCam2cXLnQ
 TxqUYkcOfY3TSXdYouiFxBDTL+PqunT/tNGhuGjBxChhZiuUpo4gZ93wMMfav8XKp/7Q/tMu8VS
 zpHYyqdJctXxiyQyRmIHgtnxwRAhPr4UePsbWrfxJiRWixAOMZZdY6ThUxxRtz6u75I/o5cg7Kb
X-Received: by 2002:a05:6000:2283:b0:3a1:f67e:37bc with SMTP id
 ffacd0b85a97d-3a3493dddafmr3379362f8f.0.1747229248140; 
 Wed, 14 May 2025 06:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETPY9hikdj3Ef03W5sax7NDhJXIwS8L54sf+BwdfAX32bVGM9y3h9bX60Yd3g4S1tr/rlzBw==
X-Received: by 2002:a05:6000:2283:b0:3a1:f67e:37bc with SMTP id
 ffacd0b85a97d-3a3493dddafmr3379338f8f.0.1747229247795; 
 Wed, 14 May 2025 06:27:27 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58ebd43sm20363059f8f.37.2025.05.14.06.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 06:27:27 -0700 (PDT)
Date: Wed, 14 May 2025 15:27:25 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 1/3] migration: Allow caps to be set when preempt or
 multifd cap enabled
Message-ID: <t64bdqgaqvtz2urb62fpn76rfay4a26csvjys522jn7wndmkjy@6cwkomp6wiyn>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513220923.518025-2-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 2025-05-13 18:09, Peter Xu wrote:
> With commit 82137e6c8c ("migration: enforce multifd and postcopy preempt to
> be set before incoming"), and if postcopy preempt / multifd is enabled, one
> cannot setup any capability because these checks would always fail.
> 
> (qemu) migrate_set_capability xbzrle off
> Error: Postcopy preempt must be set before incoming starts
> 
> To fix it, check existing cap and only raise an error if the specific cap
> changed.
> 
> Fixes: 82137e6c8c ("migration: enforce multifd and postcopy preempt to be set before incoming")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/options.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


