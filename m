Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2642CDC165
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd5VY-0008AL-R7; Tue, 06 Jan 2026 06:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vd5VU-00089w-CZ
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vd5VR-0007sU-Qe
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 06:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767699944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7N0pyUmtWjmgemLlxor9tGW++L0MtBDus8QuDhKmwY=;
 b=Adl5MaTlR8PWOkoc8fOwfPBywHwLLtThvOGCClK6+FQYd+Y8QzE/6tAxxpOLqSNl4XBqbJ
 KU9ocGiwv4Ynr6aFrjBqacZ51VhCtTO85uX/ZXw55r1KGNsoQ3sT73keJ2BgiCVzciaCeu
 3lLzEsdqP9A29fh5CK51i9h/ICFNgcQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-mo8XsiOnO0OxPe75nhrpOQ-1; Tue, 06 Jan 2026 06:45:43 -0500
X-MC-Unique: mo8XsiOnO0OxPe75nhrpOQ-1
X-Mimecast-MFC-AGG-ID: mo8XsiOnO0OxPe75nhrpOQ_1767699942
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so7124985e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 03:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767699942; x=1768304742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s7N0pyUmtWjmgemLlxor9tGW++L0MtBDus8QuDhKmwY=;
 b=heE1TClqRmg9N7XdiGXwBvAcelKW/NgpTNNVr2kzaBdKDmK63wmH50vQB809CIK/G6
 MfZMXZDZbc5vOhFqyyyq80w53M93yTSk3Qq++W8EN2ZmfDFNvYkpRCCBO3MpDNH920xP
 1zh9pk2FuDgxbOWHlYZ3ZxAnxfzCB1Q5km/ckI7MN+J8jPhOyUL03kv7XFQhRyZxA5aX
 70wjFQ0NwbdQlfuai0HzBFXCCc9PogG22TRm3eK7UqNncAd4oCnQjvycTBLkPbG6PpYX
 KakMJREolORXdLyKJe7UkWxNpJrofSh6j3muNYvwjBHfDA3rJrP8JGMNs9WzdK4fxZ9E
 Q0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767699942; x=1768304742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7N0pyUmtWjmgemLlxor9tGW++L0MtBDus8QuDhKmwY=;
 b=sTDIfa1fHlgqMGaefzhPkFq+z3D8lqJ2Api7drn//4Mr9BvRRYjX6rYmTwPELuebOw
 1jbb7TvFKHqKudTTKXMii8AIADXfA2IR3ecVBnDOr+y/enbFomJ3SnMWgT4ScAp27WYS
 8XP+tderjEcvIETrNnMqBpzBZormN6ke+4PzM3PTJ8Mt8e3z2Xp6Cp1Gmyl3Io2YcgWs
 JO/UOV9MuASS30eAkTVFrbS5Hlrf3brc7GA2Qpdjxrjhd28yGZDlftonGEu6NFvFsTAS
 WDx5mmeoTgPFHuIqYiC/AndIIlBn+2Iylyx2lMt5vyzPvN5QpCacYDipKZR7vGgjgmgR
 x45w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3rhuI6/LT0ZilKS9RAeZ6SxbGn8mAnUi2uwNbfRUmJ1wP225Ma1nO1l2ixbHBuBxUthDIM1RVoUw/@nongnu.org
X-Gm-Message-State: AOJu0YzYkdYT38icV07GtE+vbuZr15/A/xlxEJd2/feGsO/0g+EBSlQ1
 5QpKhpT8n66ZB+ufNfY/d2/V8RqXCT1Li2ru5+JaiaQ2BrM3TeYAFrpSLTxJA3PN3dQDx1UgkPA
 DIGfQe0iEVs2Zm/WUjLvf71iMLDkxtN3VvgJbX4qACi7KkC/yIDW4iteTo/fszyVvvOLGldiJNZ
 iUrRK6rdwiZgk7zxWXTVXRtuA9NJXsje8=
X-Gm-Gg: AY/fxX7yvciQP/OtAfWGE6ESobG+XbIfw+njMQUg4B6Tv3wTCSwTWFqURlyhB8NFrct
 itvoDtEfdOvVh6orLM+dLGsAGFhIVnU6OlUjQsKbnTqCROvaKk60jncPjUkU19BPKTMgsdFFrX5
 y6pu1GtrEtiL0qVL5aBrFUQbQFklWNkk6pT5XXahkTX05vOs0Yx3VM0CoWof2TEB+4xRY=
X-Received: by 2002:a05:600c:a10f:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-47d7f0a94f6mr24720655e9.35.1767699941657; 
 Tue, 06 Jan 2026 03:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwra8D3jp5dfSHNaPKQjDIizcQ8ZNQZ25RtXHjX3wjDMsmTatEj0enYa1jKOEJH9ITL7jVC9zKRrNeBDihDzs=
X-Received: by 2002:a05:600c:a10f:b0:477:55c9:c3ea with SMTP id
 5b1f17b1804b1-47d7f0a94f6mr24720295e9.35.1767699940466; Tue, 06 Jan 2026
 03:45:40 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de> <aUq1oA73W9rAdCgG@x1.local>
In-Reply-To: <aUq1oA73W9rAdCgG@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 6 Jan 2026 17:15:23 +0530
X-Gm-Features: AQt7F2pKJurpkIDO5gl1eOk5npl7vkcSXvrqt8q8XRP5GUNFo5sGKFpppNkEujM
Message-ID: <CAE8KmOzcOdYhnxpDr8BMV8zjixpEh9r+COe=xyLfXCVWKD0CRw@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 23 Dec 2025 at 21:00, Peter Xu <peterx@redhat.com> wrote:
> One thing good about exposing such status via QAPI is, it can help us
> diagnose issues by seeing CANCELLING / FAILING even looking at
> query-migrate results (as normally when bug happens we can't see the
> internal status..), so that we know either it's explicitly cancelled, or
> something went wrong.
>
> If it's a completely hidden / internal status, we may see ACTIVE even if
> something wrong happened..

* Both process state and reason(s) for the state change needs to be
visible to the user. But states like cancelling/failing are redundant,
users would derive the same conclusion from CANCELLED and CANCELLING
OR FAILED AND FAILING. Besides, migration_cleanup() does exactly the
same steps irrespective of whether migration is failing or cancelling
or failed or cancelled.

> My current hope is any mgmt should normally by default ignore new migration
> states..  If that's always achieved, it looks to me adding FAILING directly
> into migration status would still have some benefits on debugging.

* libvirtd(8) complains about unknown states multiple times:
      libvirtd[2194267]: unknown status 'failing' in migration event
      libvirtd[2194267]: unknown status 'failing' in migration event
      libvirtd[2194267]: unknown status 'failing' in migration event


> > > @@ -2907,7 +2914,7 @@ fail_closefb:
> > >      qemu_fclose(fb);
> > >  fail:
> > >      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> > > -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> > > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
> > >      }
> >
> > This is a good example where having MigrationStatus makes the code more
> > complicated. This could be exiting=true, running=false, etc. It
> > shouldn't matter why this routine failed. If we reach
> > migration_cleanup() and, at the very end, state is CANCELLING, then we
> > know the cancel command has caused this and set the state to
> > CANCELLED. If the state was something else, then it's unintended and we
> > set FAILED.
>
> If it'll be an internal status, we'll still need to identify if someone
> already have cancelled it, right?
>
> Assuming we introduce stop_reason flag, making it:
>
> enum {
>     MIG_STOP_REASON_CANCEL,
>     MIG_STOP_REASON_FAIL,
> } MigrationStopReason;
>
> Then we can switch to CANCELLED / FAILED when cleanup from those reasons.
>
> Then here, logically we also need logic like:
>
>     if (stop_reason != MIG_STOP_REASON_CANCEL) {
>         stop_reason = MIG_STOP_REASON_FAIL;
>     }
>
> Because we want to make sure when the user already triggered cancel, it
> won't show FAILED but only show CANCELLED at last?

* I think the way we are setting/changing these states in as many
locations is only adding to the complications. Do we have to
explicitly set these states like this? What if migration_cleanup()
always sets the state to 'STOP'. Similarly other places set the state
to a predefined state. OR
===
    struct {
        current_state;
        old_state;
        event/trigger;
        reason[];
    } MigrationState s;

    migration_change_state(s) {
          s->old_state = s->current_state;
          if (s->current_state == START && s->trigger ==
'connections-established') {
              s->current_state = ACTIVE;
              s->reason = "connections-established, migration starting"
          } else if (s->current_state == ACTIVE && s->trigger == 'completed') {
              s->current_state = STOP
              s->reason = "migration completed"
          } else if (s->current_state == ACTIVE  && s->trigger == 'pause') {
              s->current_state = PAUSE
              s->reason = "pause, migration paused"
          } else if (s->current_state == ACTIVE && s->trigger ==
'error-occurred') {
              s->current_state = STOP
              s->reason = "Error occurred, migration failed"
          } else if (s->current_state == ACTIVE && s->trigger ==
'user-cancel') {
              s->current_state = STOP
              s->reason = "user-cancel, migration cancelled"
         } else {
              s->current_state = s->current_state;
              warn_msg("unknown combination, maybe define a new rule?");
         }
    }
===
* We define explicit rules for the state change and accordingly we
only call migration_change_state() at any point and it'll change to an
appropriate next state, recording the due reason for the change.

Wdyt...?

Thank you.
---
  - Prasad


