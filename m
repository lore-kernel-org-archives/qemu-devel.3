Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8177C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 11:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuVbD-0006kA-Ba; Tue, 18 Mar 2025 07:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuVb0-0006il-3C
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuVaq-0005Y2-7C
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742299126;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Mb06MqwiDaG2EYc7S88XOuUSHiflR8g96OSgdvw5puI=;
 b=BwKyRFiBaA9EwLV1gOYb2PMzqWX83qfYj708pbGvZKu2emyxV2aD67jjYtjKoWfsIGdoQX
 l1uZ6+9KbAqLFdglJ11RvdrWjB9rs+gzogQVaHTccon7CVMhNVlucKqLMHmg6fcKXKqisA
 U1UnGlycMlFSHab0op2g/223QmWzLGI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-RH4BuGjhPfSrRlbVbGiyyg-1; Tue,
 18 Mar 2025 07:58:45 -0400
X-MC-Unique: RH4BuGjhPfSrRlbVbGiyyg-1
X-Mimecast-MFC-AGG-ID: RH4BuGjhPfSrRlbVbGiyyg_1742299124
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 046601955DC5; Tue, 18 Mar 2025 11:58:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 540901828A87; Tue, 18 Mar 2025 11:58:42 +0000 (UTC)
Date: Tue, 18 Mar 2025 11:58:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Andreas Schwab <schwab@suse.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
Message-ID: <Z9lf7lniMWzoy6uS@redhat.com>
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 18, 2025 at 10:53:27AM +0000, Peter Maydell wrote:
> On Tue, 18 Mar 2025 at 10:36, Helge Deller <deller@gmx.de> wrote:
> >
> > On 3/18/25 11:18, Andreas Schwab wrote:
> > > Is there a generic way for a program to detect that is it being run
> > > inside the linux-user emulation?
> >
> > Yes, having a reliable way to detect it would be good.
> >
> > My current (unreliable) way to detect it is using uname.
> 
> Yes, I don't believe there's currently an "intended"
> mechanism for detecting QEMU, only ways of noticing
> long-standing deviations from how the real kernel behaves.
> 
> > > The purpose for that would be to work around limitations of the
> > > emulation, like CLONE_VFORK being unsupported.
> >
> > yes, and robust futexes aren't supported either.
> 
> You don't need to detect QEMU for that one, though -- you can
> just try the get_robust_list syscall and if it fails ENOSYS
> then fall back to a codepath that doesn't use them (same as
> you would on an ancient kernel that didn't implement the
> syscall). Robust futexes are in the "technically extremely
> hard to impossible to support" bucket, per the comment in
> syscall.c.
> 
> > In qemu-user emulation we could change the return values of
> > "uname --processor" and/or "uname --hardware-platform".
> > Currently both always return "unknown", but in qemu we could
> > return the arch of the host.
> 
> As a mechanism that feels a bit risky to me -- at some
> point somebody may come along and say "my guest program
> requires that these return the expected values for
> the target CPU", and then you have a conflict between
> whether you want them to behave correctly for the
> target or to give you the "tell me it's QEMU" behaviour...

It also isn't future proof. People will change their program behaviour
based on the limitations of the particular QEMU version they tested
against. QEMU later changes/fixes its impl, and apps are not eithuer
applying a redundant workaround, or worse, applying a workaround that
is now actively harmful.

Whereever practical, it is preferrable to check a discrete feature
or behaviour in a functional way, rather than matching on "is it QEMU"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


