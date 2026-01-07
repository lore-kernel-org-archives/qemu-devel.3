Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE76ECD583B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 10:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdR6q-00067j-3J; Wed, 07 Jan 2026 05:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdR6o-00062u-3v
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 05:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdR6m-0001KC-6q
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 05:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767782981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MufZbfFhp1cHM4WRTfq7y1J61SrlyJrkWojaN4dJaP4=;
 b=D++f/fONlGYn8OKDAVOZYMGOs6R49uJxsQwVvjq87lj89gooEMiqeRu2bn4uLaQcT7AlWM
 OGd6MU6FY5oopycss4mh5Mnyexv4uSUU3/y9vCe4oDiPVKZw2zPa5qzFbiWxfgKI89LhCF
 euxtgvUxO/SXGxPXCTKT8LiJy23HTnI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-fi8-_UQMPuOpEsEalKJFJQ-1; Wed, 07 Jan 2026 05:49:40 -0500
X-MC-Unique: fi8-_UQMPuOpEsEalKJFJQ-1
X-Mimecast-MFC-AGG-ID: fi8-_UQMPuOpEsEalKJFJQ_1767782979
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47777158a85so24310305e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767782979; x=1768387779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MufZbfFhp1cHM4WRTfq7y1J61SrlyJrkWojaN4dJaP4=;
 b=Ky2VDeUcy6B9k9CPLFYzfWyoGIgdiNy0WE5KKfrviDr9NRlbZfar5myUr353DzA9Yj
 f+AkC+FxnI+x0j2JnDfjX9+2sdwo6cPy3TKRxQ2VpQVO8tmz6WhY4tdrxKq5NwLTrSSr
 CmX8cc/BHoW13ddx5cUTLMv2CrCBug8uDepipjV6zoIa11WXzGbLlHholRNojJGgGRVv
 EDJR6iUEnvuwWBSmyh+omr76vmbzpnrkNYGrHi/xqTEDpzvd4ORSzn2j21Q3mRsqAU/t
 EEH09uZI3ZTiknnLezlndl6elNEnbLYCy5J339iNQ5woASa/i8riQPIdmDkhCz0uaW0D
 LHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767782979; x=1768387779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MufZbfFhp1cHM4WRTfq7y1J61SrlyJrkWojaN4dJaP4=;
 b=aHshi2iQCGhXOuDUgxAKJFP7ckUpy0+ErOtNs15PvCOWGTlR2TloCMLbmV0LRf4XP/
 oubjP4vrLekPEYeMdr5kWLB6uGpFTuVdHy8hOxe6/mv8UQQfsJPkCh7BzCDpH0klyWF9
 k9BcxhoHjh1HBmX3tWyXoLRvYtFrIyGzrMZt/8K/Amd8TWbYIZX+isQpCFrlHkvLJfPI
 9av9p4IOhV/AsUVLeePe36flu2wKtv62uMywyNE56b1xd7DlO8W0gJpI6VJXexbYkHc0
 bPj4yKL08WMM+cudLT006JS7IPyjkogCpIEvwxPxpZCR5Hg9fwpKp6+U9e1lfOwlxdo5
 K//g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSK9aVWGEq28qM1xs9T+ucC/0b9cRG4Db6euueif99/jZPe5IM9HpM2s7Xwu6tRrOJNUqd/XxVABun@nongnu.org
X-Gm-Message-State: AOJu0YxLiaxpZpb+OKSFvtFtGjnhabLPBRxZNDfmvwhzwHMXjFQnECfw
 RGPcnivbKp3T6BVszGWG6EughKOGLU+nwFJk8iNUW/9rlb8WPIX0h3Y5EINLvb0ZVvJSjPW+yGX
 0lvA4IlkahYuSeC6OsCZzgJSCd1T45R1zXWcP1xaQBUz9GJVXfOxeU7E8OyrXReE02iHmgy229C
 00hl/FTQVdcsaduSu/xCinaPLD2S34T3oOmdMm7N4sPA==
X-Gm-Gg: AY/fxX5s2EPh17HOPa2mFxkyHztlvsJ9y/0mmT3GnOjvYAzCrabekxenCoEOqpYWWrl
 GAiY3LqINMi5eoF+pKj4JrA8hHFVXjLCwG57VKKt0GMOE4EhWa1ml7Qpm+FfMVSDatfWRYDzNno
 AP2+AbFSTWC8rpxNyRJ52TW2l0klMWzJsmE1BYBs2JBn2JnIvBC+dq2JFYlnH+wM55cgI=
X-Received: by 2002:a05:600c:3b15:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-47d84b3472amr19902465e9.22.1767782978972; 
 Wed, 07 Jan 2026 02:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfj5GZhIz71VuqkEG5+RHfSdtr7z7bAGT/FLl8ixHjAkCEwgg9TSwQHZajfpVtSc5W1w2XLpsiUaQDU12Ljvo=
X-Received: by 2002:a05:600c:3b15:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-47d84b3472amr19902285e9.22.1767782978562; Wed, 07 Jan 2026
 02:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
 <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
 <87zf6q26q5.fsf@suse.de>
In-Reply-To: <87zf6q26q5.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 7 Jan 2026 16:19:21 +0530
X-Gm-Features: AQt7F2ofIZRu7Of4iS7jEyWmY904lm-vpIQLs5wv-r7dw-RaPuj0ArpQp5MvRjw
Message-ID: <CAE8KmOzxDn7X7rohJGT5AeW3+5oJFgueVtaQCpUc2bmBvrgRXg@mail.gmail.com>
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

Hi,

On Tue, 6 Jan 2026 at 19:17, Fabiano Rosas <farosas@suse.de> wrote:
> If we had a linear state transition table, i.e. a DFA without any
> branching, that would be ideal. But since we have states that can reach
> (and be reached from) multiple other states, then we'll always need some
> input to migration_change_state(). Here you're making it the
> s->trigger. Where will that come from?

* The trigger or reason can come from the place where we call
migration_change_state(), there we'll know whether migration has
paused OR completed OR failed OR cancelled.

* Even with branches, the process is still linear as it goes from
start to finish. Just that we can reach the end state via different
paths.
  ===
    $ grep -ri 'shutting' /var/log/libvirt/qemu/   | cut -d' ' -f 3- |
sort | uniq
     shutting down, reason=crashed
     shutting down, reason=destroyed
     shutting down, reason=failed
     shutting down, reason=migrated
     shutting down, reason=shutdown
===
As we see, guest VM can stop/shutdown due to various reasons.

* Between [migration-start] and [migration-end], we can define
events/triggers that will lead to the next state. Ex

      - START -> t:connection-established -> ACTIVE

We can reach the ACTIVE state only after connections are established,
not without that. If connection establishment fails, we reach the END.

     - START  -> t:connection-established -> ACTIVE ->  running   -> END

ACTIVE ->  t:error     ->  END

ACTIVE ->  t:cancel  ->  END

ACTIVE ->  t:pause   ->  PAUSED  -> t:resume -> ACTIVE

> Looking at runstate.c and job.c, it seems we could at least define a
> state transition table and do away with the second parameter to
> migrate_set_state(s, old, new).
>
> As we've been discussing, the current state-change mechanism has the
> dual purpose of emitting the state change event and also serving as
> internal tracking of the migration state. It's not clear to me whether
> you're covering both in this proposal or just one of them.

* We are not doing away with migration states, just reducing or
rationalising them to make it easier. Emitting state change to
libvirtd(8) and internal tracking should still serve the same. Just
that in migration_is_running() etc. functions we'll check only if the
state is ACTIVE, instead of 10 other states which also indicate that
the migration is running.

> I don't think we've established actually what are the goals of having
> any state changes. Do we even need state changes for internal tracking?
> We could use your s->trigger as an enum and just check it wherever
> necessary. And keep the MIGRATION_STATUS exclusive for the external API,
> in which case, it's probably better to just set it unconditionally (in
> many places migrate_set_state already takes the current state as
> argument, i.e. it doesn't care about the current state).

* Well as I see it, different states help us to
      1 - know where the process is at a given time. In case of
errors/failures or other events to know what actions to take.
      2 - what actions/triggers/events are possible.

ex. If an error/cancel occurs before ACTIVE state, during connection
establishment, it may not have to go through migration_cleanup(),
probably there's nothing to cleanup. Vs if an error/cancel occurs
after ACTIVE  or in PAUSED state, we know migration_cleanup() is
needed.  Similarly if we receive t:resume command when in ACTIVE
state, OR receive t:pause command in PAUSED state,  we know there's
nothing to do and ignore it.

Thank you.
---
  - Prasad


