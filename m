Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EABC9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHcl-0006mk-Ag; Mon, 12 Jan 2026 08:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfHcJ-0006fp-Vs
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfHcG-00011S-IW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8nC6CiuWwYKC8k7JE7UgDsOARoH5gdYNE869kJ8hOE=;
 b=TNzHt8GfRpphZqtv67uWKvMyjevxEcyZ9ZtL2hA37kWN6gbcTTjhomAb3/woQ8Jbss3BJy
 W7QLPkSk4ZFOdK0fEkPpMYqDsr2bx1hnkPxmD+yFT/Sz+VTLZ1WbK+XLiNAbM6KdMAz5cW
 hxwkQjsqyX4XoC7u/Fj1oUZsA4pMqxg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-jMcWYtCsOMua8yHOSs9qZg-1; Mon, 12 Jan 2026 08:05:49 -0500
X-MC-Unique: jMcWYtCsOMua8yHOSs9qZg-1
X-Mimecast-MFC-AGG-ID: jMcWYtCsOMua8yHOSs9qZg_1768223148
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso27354745e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768223148; x=1768827948; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O8nC6CiuWwYKC8k7JE7UgDsOARoH5gdYNE869kJ8hOE=;
 b=Vyf2ZhbRO3G0yIJDIjmTaqT1wB7zowh3C3wGdt+H5or1Pr8sF8WwND+eXja1IqOCYJ
 eZGcq5cbsVcXFwK5sDYAJyh41WaXPTNEqnSPqIc0uCC+6HQfFynP693N3kqU/7Uig5lU
 cC673LLk/nXNc5f+DcHUP2/F7cGT2NnP7TLugfzhtJp+qUEHM0Tw4/WMLIKWhxJykgUr
 rkGfFgUySydqtB19dkxFuk77mCXXvF7NEjXfdIZ1nU8fX9wB84CkOlj7eGZ8pzFA7yNp
 gl5AlL/TcYp6x7dhKJGeXamjlbem1r4cxuUA8uDpdHy+K5A++cMlc33VTphdoHB90lEh
 CtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768223148; x=1768827948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8nC6CiuWwYKC8k7JE7UgDsOARoH5gdYNE869kJ8hOE=;
 b=nL2iJEiaIo/rR8VINftSmDvJoNoEij4kGg+n/QBKS6K9vvDm4H8GUYrg9y2KFMkVUf
 6VnqVG64TYWZwsxt1sri19QpzpG9FHRWasj0KyVAGd/MYmf89mQBowAa470ZeYVhDTo/
 d7zfZnKtIWwfFz/ImCnJwBbhY+JDpDBAqS7vPAT/N1zoxMGV5B85bMo2uQcnvi7hORmk
 DjHhPhd9w9+QEDgGv847Mx50I3XHx0qNnorWdiydxYJqUofJxO75eucqmxSx7Nsgdiob
 7k9JBwQuUe3FJAj3yZfkcvLpcBryoJyYg7ZqytXYOxk0jNm3qFvokt5LfHCiLCuFjnz+
 dXYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2/+C/xVb1RAwSDYx6Ylr0Bk6HJm2pNU3sN5nD8CCS0p+ijpRSj24iarr10fQHgAXtf2QWCJsWXISt@nongnu.org
X-Gm-Message-State: AOJu0YxF/qkwiHqkSPgPTcRQ2KOqieX7IUI2GUUr1gdiYy3mZv2tSIZD
 UleU8F3BOu//g+2YEaDNSdLPJE20mnJVWnm+4d7LWIWglRMRlwFLIC28IgyJgkyvUrjMVrZLq5V
 onvgplkw6IJh3a9HYylNJPgtGQoKn9g95lsiS1JF8aiGR6QOo/pUOucLWTpJoKJQHbgmlpmGpRI
 4yeH/0jjMlC6Uolv0GEiS0tXLalGe6wTc=
X-Gm-Gg: AY/fxX4a/90734UQ4+0+wtAOrd8Lab0e6vlZfxVVCTdBZlpOlsQtZkzws6Jmu1CECRw
 us36Es/xHnh1X0+fAqkcP8hhUeiDZ6fC+m/QAiqrgcq31ztqIRqYNp1Jljcv2FFTWAcI5DEbHGm
 8WPKDPWuyqPXntGIy/kSh3jPHAJdwSGrBjoZXftQiSr/ObBbRk5aqNSXEexcglOdKafOA=
X-Received: by 2002:a05:600c:5646:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-47d7f398fffmr175439865e9.0.1768223147855; 
 Mon, 12 Jan 2026 05:05:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEehYMrTwj5be9g51ldl+btJ/yyZfIy8upnwgw1ZcHmF+2Ap2SvJ5UKarhivqkOCul6r3LyJg1Ai4YQoR7PQs=
X-Received: by 2002:a05:600c:5646:b0:471:793:e795 with SMTP id
 5b1f17b1804b1-47d7f398fffmr175439575e9.0.1768223147382; Mon, 12 Jan 2026
 05:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <87zf6q26q5.fsf@suse.de>
 <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
 <874ioxzhcm.fsf@suse.de>
In-Reply-To: <874ioxzhcm.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 12 Jan 2026 18:35:30 +0530
X-Gm-Features: AZwV_QhqPYxmFINkzxyP7VdhvPYm55z3wVfnplQbeBSqNpLOSyOi1pDiu1zYH50
Message-ID: <CAE8KmOx0ikDueu-znY14RCmp6weX_G+CJMUrQOmOuv-OPwPR+Q@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Fabiano,

On Wed, 7 Jan 2026 at 18:54, Fabiano Rosas <farosas@suse.de> wrote:
> I like this because it forces us to determine more clearly what is the
> necessary condition for a state change. This could eventually allow the
> abstraction of the qapi_event_send_migration() to a higher
> layer. Something like:
>
> void qmp_migrate() {
>     t:migrate=true
>
>     migration_setup() :: do setup, mig_setup_done=true
>     migration_advance_state() :: checks the triggers, changes state and
>                                  sends the event
>
>     migration_start() :: migrate, mig_done=true
>                          failure, mig_failed=true
>                          etc
>     migration_advance_state()
>
>     migrate_vmstate() :: device state migration, mig_device_done=true
>     migration_advance_state()
>
>  etc..
> }
>
> IOW, we could do a better job of separating what is work, what is
> migration control flow, what is error handling, etc.

* Yes, indeed. Above skeleton code conveys the plausible
segregation/stages well.

> What I'm trying to convey is that we have:
>
> 1) events API that needs to be kept stable, this list of states that
>    libvirt sees and at what moments we emit them.
===
  qemuProcessHandleMigrationStatus & qemuMigrationUpdateJobType
    -> https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_process.c#L1766
    -> https://gitlab.com/libvirt/libvirt/-/blob/master/src/qemu/qemu_migration.c?ref_type=heads#L1931
===
* I was trying to see how libvirtd(8) handles QEMU migration states.
Looking at the above functions there, it seems they don't do much with
it. Only MIGRATION_STATUS_POSTCOPY_* has some handling, while other
states are not handled for anything. Interestingly, there's no _FAILED
state in there, maybe they call it _ERROR.

* While I get the importance of not breaking APIs, still, simplifying
migration states on the QEMU side should help them too.

> 2) MigrationStatus being used as an internal record of the current
>    (loosely defined) migration phase. This is "arbitrary", hence we're
>    discussing adding a new MigrationStatus "just" to make sure we don't
>    start a new migration at the wrong moment.
>
> I'm trying to understand if you want to cover 1, 2 or both.
>
> I would suggest we first take all of the internal tracking, i.e. #2, the
> "if (state==MIGRATION_STATUS)" code and convert them to use some other
> state tracking, either the triggers as you suggest, or random booleans
> sprinkled all over, it's not immediately important.
>
> Once that is done, then we could freeze the #1, MigrationStatus. It
> would only change whenever we wanted to change the API and that should
> be a well documented change.

* Yes, sounds good. We could start with the QEMU internal state/phase
tracking and then go to #1 above once we see how it all works in
practice.

> Ok, maybe I'm splittling hairs here, I was trying to understand whether
> all of these "if (s->state ...)" have the same semantics.
>
> a) For cases such as CANCELLING: that could be a simple
>    s->trigger[MIGRATE_CANCEL]=1.
>
>   (we're not removing the CANCELLING state due to the API stability, but
>   still)
>
> b) For error conditions: s->event[FAILED]=1, then (possibly at a later
>    point in migration_change_state):
>
>    if (s->event[FAILED] && !s->trigger[MIGRATE_CANCEL]) {
>       migrate_set_state(s->state, MIGRATION_STATUS_FAILED);
>    }

* Do we have to check !MIGRATE_CANCEL like this? It's not clean.
Ideally if an error/failure event occurs before the user cancels, then
cancel can be ignored, no? Because migration is anyway going to stop
or end. OTOH, if we cancel while processing an error/failure, end user
may not see that error because we report - migration was cancelled.

> b) For postcopy resume/pause, etc, maybe an actual state machine that can
>    only be in one state would be helpful.
>
> c) For "we reached this point, so set this state", most of those could
>    just be an invocation to migration_change_state() and, as you
>    suggest, that would look for the evidence elsewhere to know what
>    state to set:
>
>    if (s->trigger[MIGRATE] && s->event[COMPLETED]) {
>       migrate_set_state(s->state, MIGRATION_STATUS_COMPLETED);
>    }

* Yes, right. We need to define/differentiate between _what_ is the
state and _why_ is that state.

* How do we go from here? Next step?

Thank you.
---
  - Prasad


