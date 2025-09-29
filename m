Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6958FCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G6S-0005cI-OY; Mon, 29 Sep 2025 11:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3G6H-0005Nw-Fj
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3G6A-0008WH-Cb
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IRUhMF5HqID8l0+G3qcm1wjjA4WCx7k6E6lHoZUnZtU=;
 b=AwgyV5hbx48i6tCN6T3vScKvCO7DAcIHJ0ddGIWRp/W2MLZb6aduDxoj5Zdhv7xiSnJfvi
 3ziX2OYImdPwoaIMM2tq7GLECiFdDOzdk0SUwy+0GIGCi4Z7nPNtXGxIYWPSbKVSIlvmK0
 vvBoUnIl20gp9x/QdYUcYbr/DXFZji8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-9Dp_bsuaM0-TTIOQ1_Re0w-1; Mon, 29 Sep 2025 11:47:29 -0400
X-MC-Unique: 9Dp_bsuaM0-TTIOQ1_Re0w-1
X-Mimecast-MFC-AGG-ID: 9Dp_bsuaM0-TTIOQ1_Re0w_1759160849
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4db75c7fa8dso113779781cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160848; x=1759765648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRUhMF5HqID8l0+G3qcm1wjjA4WCx7k6E6lHoZUnZtU=;
 b=HmRwLBTpY63jm3eJ/2g7BIGS2wXA/6JGcO6Piat/2S+k56P+ThTwPbEhmGAjmrcD6l
 jXiVd0kxcIRggKqYThcVJ8nmaIIulqLDQLgEzuO9jV1U0nBGT0IKN3qOmnFZsRpxiztz
 sW9h5nni4VsH0Dck6yil11Tpi5Wbqb3QuA1GUscwQZD3qvn10aqeFHAoXY4q36PItmaV
 RD0sV00n3qyxjsTEkrMznjtCNgimISiOs28b4OX0r7RhtwuOBeICpzUwTUp4ZmNEqKlV
 h7fDaEacrSuQpVXnNJh6nJvDEyrUx1AppmUCsYZOhnBefWdFGoP1LKmBUrtrnWJOnFwc
 /60A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhJ+DCeopFjGoJlB4jrJrzhCgOf3QKk1zFk6flCS1D03pHwOTGe3WS6BK7bJTTXAHy33+Dn/zQrO07@nongnu.org
X-Gm-Message-State: AOJu0YwNNgqvCbu1bJr+8H2QDbMDX+eYUY5KEdXLniG75FnzommBXfCw
 AA+v07T+roJryoEbQJvznXP93wh3WHWnpkhZ0kNxKvUnTvT7C6HPiZBxl8ccdDTcYE0l1Kvzl9o
 vaF+g5Wps69aEKWhuyjhguX2kgb6DbJYnArjuP+d5CVa5+k3Dmb/TtLyJ2BLH/m8d
X-Gm-Gg: ASbGnctrsUaH+iCey9lg4hFG6myxDM0Ed/YwxBf5QxUeUWdedKREZtELF/8NaHoqxNI
 tpvjJrnD5TCOMVwUEjbdlzBMGareKHWyeL1i/esIAV10QVWxDq5lVQMce+X/jzCj0z1h0hdlQfT
 Izg9T4o+hGQ01HU+8yYTUXdxo4ijY5Je8ilH0KgHdZ9lGXH6VCOtd3Wp71K+b0kdfzQh/TRdjGL
 17XQg67jsget25bDmZMO82uc1LsvPsDzncJjxCsbt6S85oqpyRpu5AxRW7Y6Z7oD/gZsryBvSeR
 aAMDM3QU0yVlHsP1IbZdnftI639397Sl
X-Received: by 2002:a05:6214:d83:b0:805:b4cb:c97f with SMTP id
 6a1803df08f44-805b4cbc9b7mr196824066d6.27.1759160848350; 
 Mon, 29 Sep 2025 08:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYvIVueaE2aYIo1FOrGdFkk6ciet31Ri/SDX6YryLkRamIMuLyVZvik/J5qZzl2DL6OdK8oQ==
X-Received: by 2002:a05:6214:d83:b0:805:b4cb:c97f with SMTP id
 6a1803df08f44-805b4cbc9b7mr196823726d6.27.1759160847823; 
 Mon, 29 Sep 2025 08:47:27 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8016ce9a3c0sm76075626d6.53.2025.09.29.08.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:47:27 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:47:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org
Subject: Re: [PATCH] migration: Fix state transition in postcopy_start()
 error handling
Message-ID: <aNqqDlMKhT1j8i2-@x1.local>
References: <20250826115145.871272-1-jmarcin@redhat.com>
 <f030f57c-fc09-476d-a767-75857f7d864f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f030f57c-fc09-476d-a767-75857f7d864f@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, Sep 27, 2025 at 05:01:11PM +0300, Michael Tokarev wrote:
> On 26.08.2025 14:51, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Commit 48814111366b ("migration: Always set DEVICE state") introduced
> > DEVICE state to postcopy, which moved the actual state transition that
> > leads to POSTCOPY_ACTIVE.
> > 
> > However, the error handling part of the postcopy_start() function still
> > expects the state POSTCOPY_ACTIVE, but depending on where an error
> > happens, now the state can be either ACTIVE, DEVICE or CANCELLING, but
> > never POSTCOPY_ACTIVE, as this transition now happens just before a
> > successful return from the function.
> > 
> > Instead, accept any state except CANCELLING when transitioning to FAILED
> > state.
> > 
> > Cc: qemu-stable@nongnu.org
> > Fixes: 48814111366b ("migration: Always set DEVICE state")
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > 
> > ---
> > In the RFC[1] where this patch was discussed, there was also a
> > suggestion for a helper function migrate_set_failure() that would check
> > if the state is not CANCELLING and then set migration error and FAILED
> > state. I discussed the implementation with Peter, and we came to a
> > conclusion that instead of patching such clean-up on top of the current
> > error handling code, it might be more useful to do a larger refactor and
> > clean-up of all error handling in the migration code.
> > 
> > Such clean-up should reduce the number of places where we need to
> > explicitly transition to a FAILED state (ideally to one, or only a
> > couple of places), and instead only set an appropriate migration error
> > using migrate_set_error(). Additionally, it would also refactor
> > inappropriate uses of QEMUFile errors where the error is not really an
> > error of the underlying channel and migrate_set_error() should be used
> > instead.
> > 
> > [1]: https://lore.kernel.org/all/20250807114922.1013286-3-jmarcin@redhat.com/
> 
> Ping?  Can we apply this to the master branch, so I can pick it up for
> the stable series?

Apologies for the delay, queued.  Will send the PR this week.

-- 
Peter Xu


