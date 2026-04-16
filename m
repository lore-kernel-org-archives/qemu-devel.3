Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56B9F8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIwa-0007ZG-8n; Thu, 16 Apr 2026 05:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIwY-0007Yp-IA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:23:26 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIwU-0001UL-Ut
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:23:26 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79a74765703so67428807b3.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776331402; cv=none;
 d=google.com; s=arc-20240605;
 b=TuA8iwWtNzleUIRKVqeKxJf2LczzNfx/TBgJyluHxngHeUNSVjd4lIEd3Hao0yNYO6
 t3FzxMTML38HofcxccIoudW3TIBesqfT3bIzl1k4ZMkBKhDOK81M5Wqx5cVsm0DsmA2G
 8lDIB8cMvjONGHIbVd3AC3pCZgaxFlUeMK7OaVund2YA6oxtnF6iYOTsiVpoLIlcREaO
 cKgS5/uQjvqxUklLmWj3sYt3Z4D7JApJAAiT9DDSsFQyTzhNd53RGKqAnM0CFCXRalxF
 mRVIB/5gyU9nswQp83dB7bp5asZ6jiFOsYE6cCJWZzgCKZw/IILLnNLyuh85LxWHxHAU
 Zklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u2Qzt78b4+S6CwHhERqqOrM0tHgGbJSVjiBA2yKVNa8=;
 fh=dTRcQ5M/KzudIbA+Yj3+r3aPPzjKbHiVzFuLZQMNqgo=;
 b=CgQNWc8cP+Tijt7iuIzyAFGnAlmEOx0hVVk0v3kYgPaLntkzoVvtnkbvxUxCunNk5X
 +E973BWalx6p841F9+NlshRkD71mIEuyrBB+04urxQbLiwQlBCJSuXo5YkA7IlIiTm5B
 kpBf1dnt9VZE/BKD172WbXJlntvz6b90tVtKtoaWe+F/KjbCUuNHZkKX0WBjJOR9q5mR
 aKkpbK/jFv6JUUPNfrgolMgzELkCxmjeCnNKQ8LX1UoCLsav/YT3nEzbT7PSAkNiQeP9
 94dJKnJp+mZSmGCym1T7sNZPVk1+3/+xKTv7Z5NwsMXbe9lqQR5llRcOTMEOlIQF4R2p
 Mkww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331402; x=1776936202; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u2Qzt78b4+S6CwHhERqqOrM0tHgGbJSVjiBA2yKVNa8=;
 b=buZtWpB2r78kyo1TKRKBKBPDmPKuPTnxSsfHYOrg9WNpxamvfyOYYPSA2yh9x4YsiE
 MVsKQzuOMdk1fNu6TQcZ9S/TT9CoO99DIwm+h6qbDRb/qBonAnlS1WCF95719eIzqzvO
 aoO8mGnTtPzh0oIiV4VP9eI8Td+w98CSkznFd7LKq1IsWyQCZ7KY1CSsMMNUklSepPqN
 lg0OBXMKjmw6Q9wdzaQSv1JOE/QHZmWQYNSJbN6QOT7z/Rof5hAcyvTC+EA12Loejc+L
 0jBy+d45R+H3KSydt1moxMcvkirB1ylSXklswcWho8eCIDsSphOhjMFy7uFStByv+MAQ
 5zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331402; x=1776936202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2Qzt78b4+S6CwHhERqqOrM0tHgGbJSVjiBA2yKVNa8=;
 b=Ra02SKcH8nqMHXd54r5P0g0EbFPIAdRKrPmvphM85i8lWKNnOvy0vtx+Y5up5AqQja
 8UbSV7dBAIe2KTa2zWu+ygP2xp139PlFSr8S2lGabHb8jpPIHzq1fGDtZF+ri229Q3vc
 vL34QM3E4k/hJQqw4RL0YJuRKq8DT6I9PZgvvpVpOhpc2DPxwZ7oNYLQcJanRnJqsIl5
 6INfXLt6B5XB0Ps+hQERtteGCn5AOqe2aArL/h2GlSU8I5/N3w4CHKSoqZ9UqBxniQZn
 zIsg1P/z6SkRJJZhxzBCQ4J4vJKytH8E/kpXf+n4D3JOo9H6loTjkrJ4ozwJhmd1H8xk
 mVFA==
X-Gm-Message-State: AOJu0Yx03Q3iWszEgPJ5GKDUZU2P/+jU+NPYOYxoL0IS6zeQvB8meRIG
 3bfHQmWTxIlveh/Tb9XTQ8Y0ceT0FnSeBN6YqQRKbiteWapq4Pgvd00LgGyngw5oLNt0cODwoeX
 zEus5vcPIas6PpLOF3D95Eej4p9tbQH69LZwZ4mRDVQ==
X-Gm-Gg: AeBDieux+5loyAgaPSNEnYYpCS7h4pSRyYukV7h0Is9B4czKMSYnxZuTEfeZeXgD+f0
 Vay4Q1FIfzFOTnoYBzi0nYrlZQ6jeg9a/wKG6Ku3e2EYr30Bil2R9z1B6rKI383ZhB0kNvBuK/v
 CBHVzO2OYN/oI/sBkOpNA1yiqJ6zjZGgGpwhw92gaQ9GvNXp3CmHwxvqw+lUm4vlwNH+FL5TXZD
 vjeS57UEnP9jw76BhIZWo9kyTGVY2ambzLhdTisjgAkeKr9ux0zcE5TfYggvXt+3hN1XPh4PZ0P
 88k4TkdEXa2HzEXesTUXZ9DzqSz7gIRm+GPuCs3+jmxau8PFloX42vh9aVxsdtxd4Rtv4AZAxLx
 Oog==
X-Received: by 2002:a05:690e:42c2:b0:64e:d622:9d1a with SMTP id
 956f58d0204a3-65198a2e33fmr18044526d50.4.1776331401658; Thu, 16 Apr 2026
 02:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260414223718.23965-1-farosas@suse.de> <87zf34xp7k.fsf@suse.de>
In-Reply-To: <87zf34xp7k.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2026 10:23:10 +0100
X-Gm-Features: AQROBzDNLZLmcIeeS8C7BLmcZLINvyA17PRaGK5pgZ5rLnrIetwHoM0jRUe5pOs
Message-ID: <CAFEAcA8dwXxFodsg6gk473aEWBXynFAwaohrMqY3ca5c4FxzMw@mail.gmail.com>
Subject: Re: [PATCH v1] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_test_apply
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 15 Apr 2026 at 15:39, Fabiano Rosas <farosas@suse.de> wrote:
>
> Fabiano Rosas <farosas@suse.de> writes:
>
> > Use QAPI_CLONE_MEMBERS instead of making an assignment. The QAPI
> > method makes the handling of the TLS strings more intuitive because it
> > clones them as well.
> >
> > This also fixes a segfault when a NULL TLS option is accessed as part
> > of a validation check for another option (e.g. in the zero-copy +
> > multifd compression case). Details follow:
> >
> > Currently, after copying s->parameters to the temporary
> > MigrationParameters object before migrate_params_check(), the
> > references in temporary object to the TLS options are dropped, either
> > because:
> >
> > a) the user set a new option, in which case that's fine as
> >    s->parameters still holds the reference to the old memory or,
> >
> > b) the user did not set a new option, in which case keeping the
> >    references in the temporary object would later cause them to be
> >    freed along with it, leading to double-free when s->parameters is
> >    also freed later on.
> >
> > In this second case, it was overlooked that the TLS options can be
> > accessed already during migrate_params_check() as part of validation
> > of another option. Those pointers should not have been cleared.
> >
> > Using QAPI_CLONE_MEMBERS fixes the issue because the temporary object
> > is not stealing a reference from s->parameters anymore.
> >
> > Fixes: aed97f0563 ("migration: Normalize tls arguments")
> > Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Link: https://lore.kernel.org/r/a65a1049-9f19-460a-8e27-a62bb30d2727@maciej.szmigiero.name
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> > NOTE#1: For the release we could have a simpler fix just checking for
> > NULL, but that would allow two unsupported configurations to be
> > accepted: zero-copy with either multifd compression or TLS.
> >
>
> Peter Xu just pointed out on IRC that it's actually only the zero-copy +
> TLS configuration that will be allowed with the simpler fix. I think
> it's best we go that route instead and hold this patch until after the
> release.

rc4 has already been tagged and I really don't want to put anything
more into 11.0 unless it is a super high priority release-blocker
kind of a bug. The fact that this is a fix for a commit that's
been in git for pretty much the whole of the 11.0 cycle without anybody
noticing earlier suggests it probably isn't that important ?

If we want to put it in then the commit message needs to clearly
state the severity (e.g. "everybody trying to use migration
hits a segfault") that makes it release-critical.

Otherwise we should put this into 11.1 and with the usual cc:stable
so it is backported to the 11.0 stable series.

thanks
-- PMM

