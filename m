Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596D1FDEE21
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwhr-00082n-CO; Thu, 23 Apr 2026 12:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwhl-0007vL-FF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFwhi-00042R-UF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776960901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G/zdI4D3oeWdzkUOgpQ1c66Tem8f73p1nJxiUY8Oep4=;
 b=ELhpdvcbcEOpN0pfYbHBDwHSHQTtCZmXcjnQfGebAJmOGDZWhTRKFpNVVOFvNwVPQ4cJMC
 O6fn2B5DNhW4oiMC5eyuLnsD6ZIyh/OeyQfmL6QI7oWy84D9sdOrlaM6e9l2jeQBoOo/8a
 47AKM4rim1tom8g9bH+0pKPJo8qDTUU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-79IyyKDcNRGWekVMN9N12w-1; Thu, 23 Apr 2026 12:14:58 -0400
X-MC-Unique: 79IyyKDcNRGWekVMN9N12w-1
X-Mimecast-MFC-AGG-ID: 79IyyKDcNRGWekVMN9N12w_1776960898
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eabf08affaso1319278485a.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776960898; x=1777565698; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G/zdI4D3oeWdzkUOgpQ1c66Tem8f73p1nJxiUY8Oep4=;
 b=avCK2joaloG2qUn6D4Yfu9B3kd5UX9hBY9PmKFH0pHUKFOsBCWqA4XCiaQlrJF3PJ5
 OE3YQ3+VaOhJ4R4BC4Dpb3BkaLK3zFszzp72QfrFklxOQLZNtRDgCdV952ieilpWILgc
 Kztm7Rqih3aDtGKcKasosHSvsKs3NokzLoPl2zW1GsmQDnu7X+Y1n1a8BLPRw9MwGDpm
 Kv3b6k+ih0wUjLKVziusdmHj/TCriJ5bYpLHl9qgsRJLtWriI084F/dVkGNc0+O6n/f+
 8qYXrlzoViOPtxrUCXXqUg9U9LbFM/SBreUEL8SmGk+2PXRIcyK/dgCGmTv81YujltWl
 SswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960898; x=1777565698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/zdI4D3oeWdzkUOgpQ1c66Tem8f73p1nJxiUY8Oep4=;
 b=OvWFIzEUH8Iv+ZPp83vepwgdnsDXX80AgcAf9MsNsMdLw44iZlm7rtVMkqCT0z7mrt
 rr9tzlM60H5cyd3MDW+MyhAp5VMs+D1r1g3ay4uag8kJLmapy4bgyXLdGaxCjNXmSaCj
 uQRjCKsXAmuiFYSHxr6MpNwa+GjCWBaDJP6U9bskc7RO0YWErEKkq9gMb4d1IG5Oj6a4
 MVUMuYt+3vFUOQ8RbsJSkJay6M1XI6gdemQ6M3PqXpFsT1KRTQoWc71zeMK7xswS/Mgh
 FNKorSNWP/xytJoBQ1baPDETuVoRdbZ7KDZOcfxLyI1aAItpCV3Qw/L2yEVrbW8jl4kX
 Yk+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/w0b+YLGxwNPuQ39bhVgLDkRc2TjApwP7h7iF+WLQGH/iFi8M9GyMvXHyz2k42dVSPrr0K2YtzOCIQ@nongnu.org
X-Gm-Message-State: AOJu0YxeTf0xIE3vVGMUQ6J0czAksECzGpykHHP7XmplqcjBUWJ1tQWz
 CGmFhOtVfwBD3AgFikNodG2nJ5FL5Db5mAlNUkm9gktaQh0j5H5CYg4SO3i+xdv4Ymdg3/SnEYw
 o5n/Hrd6N9ugXufmXePxaW6x07TBTfkK1zVLN521BEPH3djr0KCIPgGVR
X-Gm-Gg: AeBDiesfsOtYQofUU8o4iT77ztGQbVUkZJB+BFPjtysoreqFNu1O5cfRuuOnTJR5Utd
 VpumxiEAccBAWX+syb7zn4QSe+wDxzlShTqLol09wjb3u4vgi84f4U+eQWlWPh+DIQ4Dg9jAbvV
 NsqCLN96jRMHHtOlG9aoJ5Y3xlUvTAojT1C7r+gZK1/Cs5ip+ZRLYqCw9KWXxqrfWIwMXc1SZEd
 d0eTtusg2f38Ez7fZWBo61vubvkyUeBx+19zjeuZnx3Xqw1PA/r9rMgrslb6t2mMemwtXu0Do2h
 GU+QmC1wu9ZCzdl3KmNiWTM8P7GU9Tdyh0RCEhcY4bV+y+Gpgguiu7e5o/QWqLryLNjUUujDPCK
 yqC7viWAaYdLIia6hAp60LThNUEdLJk6WoTCZh24IkwtdeHyPMxewg5nKUg==
X-Received: by 2002:a05:620a:1a2a:b0:8ed:bafb:26b0 with SMTP id
 af79cd13be357-8edbafb2cbamr2151653185a.37.1776960898140; 
 Thu, 23 Apr 2026 09:14:58 -0700 (PDT)
X-Received: by 2002:a05:620a:1a2a:b0:8ed:bafb:26b0 with SMTP id
 af79cd13be357-8edbafb2cbamr2151645785a.37.1776960897517; 
 Thu, 23 Apr 2026 09:14:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d98c15a9sm1871369085a.43.2026.04.23.09.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 09:14:56 -0700 (PDT)
Date: Thu, 23 Apr 2026 12:14:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
Message-ID: <aepFf11lBgdXK6CB@x1.local>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com> <87o6jaeig8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6jaeig8.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 22, 2026 at 07:30:47PM -0300, Fabiano Rosas wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > From: Trieu Huynh <vikingtc4@gmail.com>
> >
> > When a multifd migration is cancelled and the user changes
> > multifd-channels via QMP before cleanup completes, the shutdown and
> > termination loops re-read migrate_multifd_channels() which now returns
> > the new value.
> 
> Right, so this is because migrate-set-parameters is allowed to set
> so-called (by me) runtime options, such as downtime-limit, which means

I like this new name, if we ever need a name for such..

> we cannot block it while migration_is_running() = true as we do for
> migrate-set-capabilities. The "right" fix here is something I discussed
> with Peter a while back, which is to write a whitelist of commands that
> we're certain have no negative effect during migration runtime (or are
> simply required as part of normal functioning) and block everything else
> behind a migration_is_running() check.
> 
> Still, I think we can consider this patch in isolation for now... Let me
> continue looking.
> 
> > This causes the loops to iterate over, for instance
> > fewer channels than were created, leaving yank functions of the
> > abandoned channels still registered when yank_unregister_instance()
> > is called, triggering an abort:
> >   qemu-system-x86_64: ../util/yank.c:107: yank_unregister_instance:
> >   Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
> >   Aborted (core dumped)
> 
> Ah yes, the assert machine doing it's job as usual.
> 
> >
> > Fix by storing the channel count at setup time and using that frozen
> > value in all subsequent loops. The live parameter
> > migrate_multifd_channels() is now only read once during setup, ensuring
> > teardown always operates on the exact set of channels that were created.
> >
> 
> Take a look at multifd_send(), there's some shenanigans there as well
> regarding changing the number of channels on the fly. Could we drop that
> logic with this patch?

I don't know anything allows dynamic number of channels.  If it's about:

    /*
     * next_channel can remain from a previous migration that was
     * using more channels, so ensure it doesn't overflow if the
     * limit is lower now.
     */

It's about another migration after a failed/cancelled migration only, where
next_channel is currently a static variable.

> 
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >  migration/multifd.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> Hmm, I see 20 instances of migrate_multifd_channels() being used in
> multifd.c. It seems you missed some.
> 
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 035cb70f7b..69c8f6747b 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -75,6 +75,8 @@ struct {
> >      int exiting;
> >      /* multifd ops */
> >      const MultiFDMethods *ops;
> > +    /* number of channels created (fixed at setup) */
> > +    int channel_num;
> 
> Reads like "channel number" to me. As in "the number of the
> channel". I'd use n_channels, num_channels or channels_num.
> 
> Naming aside... we'll then have three variables representing number of
> multifd channels:
> 
> s->parameters.multifd_channels
> multifd_send_state->channel_num
> multifd_recv_state->channel_num
> 
> (or just 2 and inconsistent representation between send/recv, which is
> worse IMO)
> 
> Let's go back to the core issue I described at the start, could we
> instead check at migrate_params_test_apply() whether migration is
> running and return an error when trying to change multifd channels?
> 
> There might be issues with current_migration going away while QMP is
> still dispatching, but I'm not sure it will be productive if we start to
> solve locally the troubles caused by each parameter when changed at
> migration runtime.

Agreed, I think we should fix it with the whitelist idea.

If you haven't started looking at this (??), I wonder if Trieu would like
to look at it as a replacement of this patch.

-- 
Peter Xu


