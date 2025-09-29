Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCE8CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Hiz-0004gt-Ma; Mon, 29 Sep 2025 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Hiw-0004gY-F2
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 13:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Hit-0005ht-3A
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 13:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759167096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRYMoKYkAirYdKjNwSaF7I6B44lsMndq2R5CjfmGwEQ=;
 b=Oe76xJLaAL3LraIgDC+NsAwhszKqFn4h1aoHheI1wb1QRoVgSvqNN3/eHxgt15XNmcbWBB
 JnkAyn1iAtcL0rAtGhvSRGQOONXOOAsS/UD92krdf3NJ16qw6nDbeiktk1MboFAY2vcbWj
 bKFwz21FUVUuEbY+dph9sTl0ERljoIw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-C39BxqLZPiazXy8-mYWXQQ-1; Mon, 29 Sep 2025 13:31:34 -0400
X-MC-Unique: C39BxqLZPiazXy8-mYWXQQ-1
X-Mimecast-MFC-AGG-ID: C39BxqLZPiazXy8-mYWXQQ_1759167094
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7c547f51b36so97078256d6.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 10:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759167094; x=1759771894;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRYMoKYkAirYdKjNwSaF7I6B44lsMndq2R5CjfmGwEQ=;
 b=aJ4Op/rg2cHSQEEo+1tzaWCbapyUE/RkuHPW9hxh/pzUHMTWSqIC4m8hYxBet+Fgny
 cibIH4QUTRQTkXDqckVttl8yooPxYadjoEYwpzq+Q6mW89zMnCT3hulbqUNi/k08fQIS
 hKa7SEXelXC7k/ITGyFeNoRuPTUHhf1GYJAANyj6LQUstKlbogSQyPST47sOA9eWQlVR
 W7Mvf6scjM9QvzxY5fc1HGIwuh/0WmzFHn6JbNCQ5yNflSYBTLVIHTpAdZ8dah6Q/4Kg
 npCop0mBL379GLwdeZUCU9gnvynxowZek6Z5tXD67d0Xzb9KZKl4Ylbv6pluU8fa6oet
 3bNw==
X-Gm-Message-State: AOJu0YzhSUIjIVEuDsYgollhogLjzLsaZ5u0Moy6OmL4UGa3KoXI+dAi
 iwzs9tSlcboxr/jCcoxTo/KobQaGBqXBBqJmNE0HZRGzURI6OGH7fxyjgzuvyfHLb5B0np8nvIc
 kS21fTWG7tuQ1IWHqFu+zGkHswUfMKDPvV0JXXr0HJnfF3/mCnLh7mLd+
X-Gm-Gg: ASbGncvWrVe1gDnzobUUvyVXrZyQu+gFfJFG/pF5JcmYo4SRYVhcrga+Bjf+BZAO0Zl
 kOHZuQLA76A8PPVCvDx/hOK0l3y+yDNhWuMS/0jpR96pDZGa0GrZU44uOUN5Aet+QepPchedABH
 fN9hMe0dUYTczs2jIMw9v4HMKDt9drC6cTm/Pl+NFyTMCh0X+KjtrStzXpTN9gQmZwQz+pr/M5Y
 oE5B7aOXgcDJy07g4NpD6FHV4Vzd8feGT1tuLIaTvTrvG57xwvr6DwxET+WdJKwRgQnc19fG+Dm
 a8DGJ+BU6H6dLtYm/gTAw0i/1Sct4Y3h
X-Received: by 2002:a05:6214:21a3:b0:7e7:a043:59d1 with SMTP id
 6a1803df08f44-7fc3ca0be6amr249092096d6.44.1759167094001; 
 Mon, 29 Sep 2025 10:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhvz64acFqw7xSBOoLLZNNYZ/8aXjoMtlM7YUE7lHcrPgrTLClmQLUPcdoP0Wg23eNMtPIeA==
X-Received: by 2002:a05:6214:21a3:b0:7e7:a043:59d1 with SMTP id
 6a1803df08f44-7fc3ca0be6amr249091616d6.44.1759167093490; 
 Mon, 29 Sep 2025 10:31:33 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80173f45ee9sm78594966d6.64.2025.09.29.10.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 10:31:33 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:31:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <aNrCdIIL8ErDcjEi@x1.local>
References: <20250801170212.54409-1-berrange@redhat.com>
 <aNqsnaBkQe8i_MLK@x1.local> <aNq6Fu0-nb1XMRxk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNq6Fu0-nb1XMRxk@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 29, 2025 at 05:55:50PM +0100, Daniel P. Berrangé wrote:
> On Mon, Sep 29, 2025 at 11:58:21AM -0400, Peter Xu wrote:
> > On Fri, Aug 01, 2025 at 06:02:10PM +0100, Daniel P. Berrangé wrote:
> > > This is a followup to previously merged patches that claimed to
> > > workaround the gnutls bug impacting migration, but in fact were
> > > essentially non-functional. Juraj Marcin pointed this out, and
> > > this new patch tweaks the workaround to make it actually do
> > > something useful.
> > > 
> > > Daniel P. Berrangé (2):
> > >   migration: simplify error reporting after channel read
> > >   migration: fix workaround for gnutls thread safety
> > > 
> > >  crypto/tlssession.c   | 16 ----------------
> > >  migration/qemu-file.c | 22 +++++++++++++++++-----
> > >  2 files changed, 17 insertions(+), 21 deletions(-)
> > 
> > Dan, is there a planned repost on this one?
> 
> It is on my todo list, but I don't have a firm ETA yet.

Sure.  I assume in production people should really be relying on the gnutls
upgrade.

I queued patch 1 then for now, thanks.

-- 
Peter Xu


