Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C777CCEE347
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 20:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sydQ8-0006dh-3Q; Wed, 09 Oct 2024 16:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sydQ6-0006dQ-FA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sydQ4-0000sA-AN
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728506185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ospLgNjwACuqXrsI/839ZOwJd1rRTIulSiTFLxur5IU=;
 b=IR94IWTHvJZBXNJYtJO9wuKOgYI+pWWZeKOL1HEyuRwNVNxcbUX7ta80A4PrxOpV1XUXL9
 UPc4MiyXVxLV/Ln1cUaojvv8LPQaq8XD+IhA0+TOTRfqbhkn6qgv2mP4qnEGwVOXC5RIVr
 8G/PrGV+O4mBbLk33OZjKEuBvv7RCtE=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-CUweqOBIMQmTXK_5qJ62FA-1; Wed, 09 Oct 2024 16:36:23 -0400
X-MC-Unique: CUweqOBIMQmTXK_5qJ62FA-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4a3a36ad78aso66510137.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 13:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728506183; x=1729110983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ospLgNjwACuqXrsI/839ZOwJd1rRTIulSiTFLxur5IU=;
 b=LwBNLj72Cp7vgoClVsh+kNw5g8EOoFCWWjUSlJue2sJwZ0KxNOG+Z+thycYE4HAHpX
 HFIptOHjtatTxEvbdPdfAFG6SUVY0WzzDywYPnYopwogaIELIDuFU4BpA5yXIJlME+fg
 zD3iEizodCdHGglTTkTIx9Wxad9mu6f8al1aFku3EDlYN/tC8yCT9qWClch7UqGeWiwA
 bluDqf3qmuAnP9ex3YeiD0n5tyXqyuBoMIhzDsTuEL6TlCMu2adTWT4gg06Y2UJRoLLo
 3HrmPu4d5G1GRJLltpNptu3QZynSesBDogVeFlZc4EUInHco57ezj1P+162tL453c7Vn
 e8vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyH0vpLqxn9/pHkA5XcEfYVRrhK4YTOyurN6ZWFr+oi7w6SsRoJ1/nAgNkFQczsvEfw0jEuMcRP4Al@nongnu.org
X-Gm-Message-State: AOJu0YzxvuFbEZJk7eabR3YrQvUJepZ5cdK/KtA7E1td0DtjvDDI3K6z
 xcnq7l/ObIacL8is++l/QnTmkDETX6hHxQSMZVxSUhVeBnNlOjOZL2NAjBH/2j7mRjYvss0Ofb8
 mCUtWi5PEnWKSRmGkT8c17VlLs4ArLDzyQguaCAeG5udcZw+xJF+9
X-Received: by 2002:a05:6102:34d9:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-4a448d15cbcmr2845844137.6.1728506183188; 
 Wed, 09 Oct 2024 13:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA3kxLVJ/QkWN49TPOxz1YdmtpCAXDLwSzopO0COhokkLm4LW+EtqMl+JB+yrs0XTy4Cmwhg==
X-Received: by 2002:a05:6102:34d9:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-4a448d15cbcmr2845830137.6.1728506182808; 
 Wed, 09 Oct 2024 13:36:22 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46dfbe4sm49018196d6.47.2024.10.09.13.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 13:36:22 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:36:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwbpQiK7YWKpqHTk@x1n>
References: <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
 <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n>
 <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 09, 2024 at 04:09:45PM -0400, Steven Sistare wrote:
> On 10/9/2024 3:06 PM, Peter Xu wrote:
> > On Wed, Oct 09, 2024 at 02:43:44PM -0400, Steven Sistare wrote:
> > > On 10/8/2024 3:48 PM, Peter Xu wrote:
> > > > On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
> > > > > As of half an hour ago =) We could put a feature branch up and work
> > > > > together, if you have more concrete thoughts on how this would look like
> > > > > let me know.
> > > > 
> > > > [I'll hijack this thread with one more email, as this is not cpr-relevant]
> > > > 
> > > > I think I listed all the things I can think of in the wiki, so please go
> > > > ahead.
> > > > 
> > > > One trivial suggestion is we can start from the very simple, which is the
> > > > handshake itself, with a self-bootstrap protocol, probably feature-bit
> > > > based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
> > > > how to handshake".
> > > > 
> > > > Comparing to the rest requirement, IMHO we can make the channel
> > > > establishment the 1st feature, then it's already good for merging, having
> > > > feature bit 1 saying "this qemu understands named channel establishment".
> > > > 
> > > > Then we add new feature bits on top of the handshake feature, by adding
> > > > more feature bits.  Both QEMUs should first handshake on the feature bits
> > > > they support and enable only the subset that all support.
> > > > 
> > > > Or instead of bit, feature strings, etc. would all work which you
> > > > prefer. Just to say we don't need to impl all the ideas there, as some of
> > > > them might take more time (e.g. device tree check), and that list is
> > > > probably not complete anyway.
> > > 
> > > While writing a qtest for cpr-transfer, I discovered a problem that could be
> > > solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.
> > > 
> > > There is currently no way to set migration caps on dest qemu before starting
> > > cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
> > > devices or monitors. It is unblocked after the user sends the migrate command
> > > to source qemu, but then the migration starts and it is too late to set migration
> > > capabilities or parameters on the dest.
> > > 
> > > Are you OK with that restriction (for now, until a handshake is implemented)?
> > > If not, I have a problem.
> > > 
> > > I can hack the qtest to make it work with the restriction.
> > 
> > Hmm, the test case is one thing, but if it's a problem, then.. how in real
> > life one could set migration capabilities on dest qemu for cpr-transfer?
> 
> You will allow it via the migration handshake!
> But right now, one can enable capabilities by adding -global migration.xxx=yyy
> on the target command line.

Those are for debugging only, so we shouldn't suggest them to be used in
production.. at least not the plan.

Yeah, handshake would make it work.  But it's not yet there.. :(

> 
> > Now a similar question, and also what I overlooked previously, is how
> > cpr-transfer should support "-incoming defer".  We need that because that's
> > what Libvirt uses.. with an upcoming migrate_incoming QMP command.
> 
> Defer works.  Start dest qemu, issue the migrate command to source qemu.
> Dest qemu finishes cpr_load_state and enters the main loop, listening for
> montitor commands.

Ahh yes, the HUP works with this case too, that's OK.

What's your thoughts in the other email I wrote?  That'll make QMP
available in general on dest, if I read it right.  But yeah I think this
issue is not a blocker now at least, so I'm just curious whether that's
still useful.

We may still want to understand one question I raised elsewhere on whether
cpr state save/load must be done during vm stopped.  If so, then it means
Libvirt will only go with "defer", and QMP set-capabilities might be
accounted as downtime there which can be unfortunate.. Basically, it means
if we can still drop patch 4 completely (while the vhost notifiers can
exist in the future, but hopefully not dependent on patch 4).

-- 
Peter Xu


