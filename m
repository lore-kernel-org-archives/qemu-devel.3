Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212F3C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8Gz-0003xe-5N; Wed, 12 Aug 2026 08:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wu8Gu-0003xG-MC
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wu8Gr-0006lz-Jz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786538482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Svx2JN4cshSWBDvCveU0FUJ1nwoe+VU75kCTnrvx7c=;
 b=MHrkMVEw3/r0PD4+SfiouNlpvPGRauaJmAdTwBG1+lPIfs3lqlkErfiQn9TVikXRDrBU9o
 CORO9shAX5bhGma0+sXEf8aKWbxHC0cUjb93tfQ5b4omKxJsTEHURGdu1BVboBus+KH4ha
 7P4gzHTG1NXCWLr6SBbXqYkkCKNXoeQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-CoND65ZoPBGlXBoGBavs1A-1; Wed, 12 Aug 2026 08:41:21 -0400
X-MC-Unique: CoND65ZoPBGlXBoGBavs1A-1
X-Mimecast-MFC-AGG-ID: CoND65ZoPBGlXBoGBavs1A_1786538480
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93494cce712so77001585a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786538480; x=1787143280; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2Svx2JN4cshSWBDvCveU0FUJ1nwoe+VU75kCTnrvx7c=;
 b=IHmaOGjfrC2QHqQY8jIJhnHhXrkOAjY0s1zsAtwwIWIC20XZtPvQge51XWcsa6F/aO
 IfW8LV6YmbgYKrJiDugtt4EMGM50Tbp8h20ZJ33RYt45Xf2c3kcZNtVoKnR/SEHWjW1i
 ZisFZm0iH3mjbhQh5exR29iWQ8A8ejmbU96uNdgTFv5h+p796pz500XEpGroMHvM5FeK
 DzrRaA05vZhyuxBZoy7zALPot01zWVEwLA3/Lcoc9FTGC3sI4OnDuFceePVN1S0kPT8I
 UPCj7ycBVeWpED/Rx9plUVuwj91Zu9O9vg490KKmR1BIFwol1Jb3jVEHQxy+7kQ4ppUy
 pMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786538480; x=1787143280;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2Svx2JN4cshSWBDvCveU0FUJ1nwoe+VU75kCTnrvx7c=;
 b=V0KPB5X6Xw7j2DwaaUcSusJjdV3c7UdwTq6gLxLL5lWFSrSHgbBEv8AFgJWe2AhQ4R
 oMKz5tIV/wyOl/Q47WckqsqsHwZzQhfG+W+/sNUE5m4G25NSzEUF3WSe0kxX+IO8ARoF
 V4qK1qCgi5YKbRjgvNqiHhbrD6XOp6FOJlwZr3gne/fXzusrIn1j3bN6TactENXGzTf3
 496p9tIXbNLEIi0mGwWSsUNG5yALo1pVv3njVHCc/wtgV2aHLqnn87BXzln+P/yB2yVZ
 ILprHK7Mb4BE3SZCwkzgWpMvo/yaaNpVziClzXQZdws3y1Wzb4/OYIbiuv6hJ4LUhlqP
 X/bg==
X-Gm-Message-State: AOJu0YzVV7JrvUY2iR2246EjntYE2P6D8qugXAYGSVN626CZE3cuXRFf
 oAvWOJ5hbT6mR0p39N+n9RaneM/04JEAcMnVrflABgZg82OBCRcmtTLNKFQSEvZEtzqYf6590dp
 dsma/TGMTWep0ECvT2onplA+Z73Fg9hMAC5ZZ17CmVJK8/Vda1EVP6SMOomlPa4B0FrRqUjXeiC
 P5aARN0xff5dchjl3oaY739i8wXMuYVYwxINp8NA==
X-Gm-Gg: AR+sD100FkrFpWGcZGn/O0D9RtKqcez1c2u7lRbPHCtrz0OZDPSOuTYQsq5FB8gABTG
 yBSGHXJd3PUIRzYB9wh7IMToYpw3tRQ7RF/1gKmE58RE/1i+sHaJiWgn9RQ8kCcxUcgTBNearm2
 iTuwITxBPtQ4fwR8QWMz1n6h7cpMx8ked0FKYEwt57CrKKLFArzbi1rvAg3ppqGM1C42PAqEPUP
 8OU+eCFBXkf8wfHPAJASGpZMc/LDs1SzXBMD8YbI6u5FUk1f222UZIaL6fzHR7T9yioYGy+FWtM
 zlQ0dUQF8AhLGmko/HKaEkrm3Nrdp9+ni+PwhnTdGBqUy0Jw0ZI6lrm++nvedPYYxgO6PkZ6asj
 88HyJyNYuZYyH0VlKRMOPIZ0ZGgKtvY5eFeQvcLhhIUMM9JL+sChM2dDALyg=
X-Received: by 2002:a05:620a:d95:b0:934:aa56:45df with SMTP id
 af79cd13be357-936b3a6417bmr421790185a.11.1786538480416; 
 Wed, 12 Aug 2026 05:41:20 -0700 (PDT)
X-Received: by 2002:a05:620a:d95:b0:934:aa56:45df with SMTP id
 af79cd13be357-936b3a6417bmr421785185a.11.1786538479851; 
 Wed, 12 Aug 2026 05:41:19 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936b5f3b3afsm118301085a.35.2026.08.12.05.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:41:19 -0700 (PDT)
Date: Wed, 12 Aug 2026 08:41:18 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 0/5] migration: Hardening fixes for 11.2
Message-ID: <anxp7qsWJOlqNPVm@x1.local>
References: <20260728210417.1925078-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728210417.1925078-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 28, 2026 at 05:04:12PM -0400, Peter Xu wrote:
> v2:
> - Added R-bs
> - Patch 2/3, update commit message on wrong use of term "release buillds"
> - Patch 4, fix bug Dan pointed out, use assert() for !coroutine, update
>   commit log
> 
> This is a small batch of fixes from recent reports on migration, the plan
> is this is only for 11.2; we don't need to rush on any of them.
> 
> RDMA migration has its own small batch.. It'll take slightly longer so I'll
> send them separately.
> 
> Reviews welcomed.
> 
> Peter Xu (5):
>   migration: Fix possible overflow in vmstate_handle_alloc()
>   migration/multifd: Validate next_packet_size in zlib/zstd recv
>   migration/multifd: Replace assert() with error_setg() in recv paths
>   migration: Fix rare hang of migration_channel_read_peek()
>   migration/ram: Check for RAMBlock size mismatch when parsing

I queued patch 2,3,5.

I'll drop 1, Fabiano, please pick up relevant tags when you repost with
your other series to refactor num/size offsettings.

I'll repost patch 4 separately.

-- 
Peter Xu


