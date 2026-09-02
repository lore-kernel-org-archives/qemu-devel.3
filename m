Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE33C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1pey-0005Tu-HY; Wed, 02 Sep 2026 14:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1pex-0005Tf-26
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 14:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1peu-0001NQ-UI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 14:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788373563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5rWPi3J14cYHgk+q/D7/UiT0eshzUTKpy1J1gKNWNQ=;
 b=LltsvgVxw+WnrYe+NuLJuElkMj16tq8AsjxEL1Vv519XnqQGLiFk8EPoW6Hwihaff/Y8An
 N7uJk7nj+EuYScPy8kBa+24S64JwY+V0yrMrHTvKsIcbF92G4eZAUNn+1AuDwPFTZE/3rh
 m2D2T/8uAcYrQlO6QrlmrgYCbciTdF8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-xob011pIPaK4ycBueS-SUw-1; Wed, 02 Sep 2026 14:26:01 -0400
X-MC-Unique: xob011pIPaK4ycBueS-SUw-1
X-Mimecast-MFC-AGG-ID: xob011pIPaK4ycBueS-SUw_1788373561
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-85da2b96c35so22937697b3.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 11:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788373561; cv=none;
 d=google.com; s=arc-20260327;
 b=MLEOyhPh3totDwRyeTZW1bhMdGYnIanI7ErOklNXlVSj6u7R5KA0DlYHByg+aTL2vX
 0Ht5AtGnaqW+xYcsZGbvxkBO5IGbqR2XTTW2mvdzYVfxe4orc5ty8jRWKxZctDxESlwg
 ZWayakZFc7j18U6g8ZJpKNFxGParO0JICf7ZfNfL9lr0003cVPmDmUb/zmDjWBZ34hid
 YwfLGLDplyrTr9MAKrLT5M7PsU42TQOtKoYL9OkEhyuiRTZhwUC7YyK1bqGjd3OEEN9/
 xcVdih1QJsZW2N+3PrCxp+vamz+B0ANcz9WMe1rvcs0M1/93fZyJrnPhV58V8EWIhfPW
 dveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P5rWPi3J14cYHgk+q/D7/UiT0eshzUTKpy1J1gKNWNQ=;
 fh=SGAZSBrIvq79PhSIBNc3jpCpe23oKcZEzRNGniScZbg=;
 b=jKcV4gGtVIlX91Y2r267oYmwNvCziHrj1iCGn7phbqCFZe+NDPYkyj/iGKdzm93+A3
 9ofmWFfzFKwDNCdghdPM2W/v4l912KSkCup3OOvTJg9Ahp3oZvLNWuNhoDENs05fQKbB
 v4C4ei77+kf0wka5UaAul60tIAbf1EqvJdbjNejC4V9+99v7TPZTzX3u8dEJ14G/MCsM
 TwoQNd48EY94sdD/Vo4QHR8mCYvtzD4wzxCeb+VIVkZ8gF7xMjxykl+oPTYDtczyKaVm
 uOkyLNeYZKybb2zH1/rWTw0TUdU4IxnDiV3nM7sEWRuNf6mJwxiZvnMINOwASF4EhPWu
 dfAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788373561; x=1788978361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P5rWPi3J14cYHgk+q/D7/UiT0eshzUTKpy1J1gKNWNQ=;
 b=do5+yTwS7PeUN05A7/sH/ahNcA7rFQA349a1LbkWnDbKmrkg2rOqcL/rNxGTsVoSkH
 QlIaGQQlOeodw0Ngm9NfT2JEfm24aPGWA7j4fzFQNVa2uC4MogvXEJYNrA/NQaPNyJ3K
 QeylSDJHqS5ccMU4qcjRM9VLaf7HxjLtMfkL78VgdkwPA/qTulBtxwKECKEaFajCGm+3
 Uv9IrTeDqEPMNOJVems3HIOt6oPBylwSq7OgBCrgNVlJvGK5qk6TtE50gmTP722OtMZI
 O3lb1S6Ag1xAWUKJKDQhrfC9cMZXFHVoE78ufsSHKwugXBxyg+3VEjLMmUerG8CIpw7K
 P5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788373561; x=1788978361;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P5rWPi3J14cYHgk+q/D7/UiT0eshzUTKpy1J1gKNWNQ=;
 b=QwxmFV40C/yhSd2KahPfpZp39QbbyM1iwP0+L1KEWnxuJApvs3YXwBAq1Th4GMEG0z
 nJZJWhDnD21TW22ssH0qw7/FKGlyNs9tcUgHZIHBBKmuIQIOTa/13UYLPuwwP9qieEot
 +ZgoblH3nBOv2Quf/a+bYTI+rJvt60eeAiyB/X30W6sAXcArj7jjf5FInoy5qkYoqAZD
 V8cOGB0Zxhq7kCvcICsPDV/94QQ2Tw1mVbX6ZHCctxnLxLEK1eExE+IosNpdw/z24GpJ
 nd9teHwQ+thrsKQn9ynG6qJwEy4wT9CIC54z+0l/zfRpBbD4nGXabdo7n2wS3AC30Be1
 5NBw==
X-Gm-Message-State: AFuF++lefVJxyrndNBj6C1jfItLWBeTKiZ8WxZ121Gt8yfqm0vREitL2
 uW8ZzM/wIPwl7PuX59JJ2o/mZPdDqsUYwNGU9k3IhiFJTU03lbdmUIKl3TsP6HFovZOeQUoD2me
 a53kIHaTyS1O0RjJ3lHsmhT6D5UqfzvI7AwGbiNADbwXsdmqsJaeoXgKEQ+AX6C2UKgI4JErBC/
 eXj2NRsJ1ZdUO3fdYX4XoO6c0EMbJZMBA=
X-Gm-Gg: AYBFou0cjz+LFY0bh9PynFRmM9oADopfT56NdDj7WtHT+I2XeiX3AAPmApVoJXImQgN
 ybXdDVpACUf38ETVHQk+am+gUtqwS7Nw+xdJrE0e3NxHX6c8WZHJ3Wqj/s03ugP+AoBPePyub7K
 RpBmEwX0xp2UORypgkkmWLDT0Ar4LPQwCQa2z5TZBfIyB1uHSkOz4MT5I9ya16TzPv9HpO5Y7fq
 csquyTErEWe3AIq
X-Received: by 2002:a05:690e:7a5:b0:668:9230:e269 with SMTP id
 956f58d0204a3-66f9be81bbfmr1786391d50.41.1788373561041; 
 Wed, 02 Sep 2026 11:26:01 -0700 (PDT)
X-Received: by 2002:a05:690e:7a5:b0:668:9230:e269 with SMTP id
 956f58d0204a3-66f9be81bbfmr1786378d50.41.1788373560471; Wed, 02 Sep 2026
 11:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
 <aphh-XHBjGicZDD7@redhat.com>
In-Reply-To: <aphh-XHBjGicZDD7@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 2 Sep 2026 14:25:48 -0400
X-Gm-Features: AcwNN1W9deS9rrDOGl3R7mBplqfNrANfkaeTBeQC00lrbHX-L2VptVuY9cniDVw
Message-ID: <CAFn=p-ZiUwRR9jibyCY4A28mnJLGFMDgB74DP+ub1149Y-Y4Aw@mail.gmail.com>
Subject: Re: Async machine appliance for testing (python)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 2, 2026 at 1:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Mon, Aug 31, 2026 at 04:51:36PM -0400, John Snow wrote:
> > WIth the upgrade to 3.12 imminent, now might be a good time for me to
> > revisit the work I started when I converted QMP from sync to an async
> > library. I have a draft of the library I wrote some time ago, but it's
> > probably in somewhat dodgy shape after a year or two of being ignored.
> >
> > Before I dig in, I wanted to ask if this would be a helpful project.
> > The main selling points would be:
> >
> > (1) Ability to split it out from the main QEMU tree, like QMP was, for
> > use in external testing
> > (2) Better stream management so console information is consumed and
> > logged reliably without deadlocks due to pipes hitting their buffer
> > limit
>
> I can't remember the specific details, but I do recall some
> scenarios where it would have been valuable to have the console
> output continuously streamed to the log file on disk, while
> at the same time retainining the ability to do expected
> output matching from the API.
>
> > (3) Removing multiprocess and multithread processing of console and
> > stdout/stderr logging from test suites in favor of using async
> > user-threads for (hopefully) simpler, more straightforward processing
> > and customization.
>
> Which tests were you refering to here ?  I didn't think we had
> python tests using multiprocess/multithread ?

We use it for console log draining ... see
python/qemu/machine/console_socket.py which is quite the hack.

>
> Tangentially related, in debugging failures of the functional
> test suite, and to a lesser extent I/O tests / qmp-shell, I've
> often found myself heavily confused by the asyncio call paths
> and control flow, making it really hard to debug.
>
> In particular I've never fully figured out how to get qmp-shell
> to have a clean exit path without stack traces being thrown.

Send me an example / a reproducer and I will make it pretty or die trying.

Most teardown errors fall into two camps:

(1) EOF was encountered, and it gets reported up the stack as an
"Error" even though it's quite an ordinary part of the connection
lifecycle. I did this mostly to force iotests to be noisy when QEMU
died unexpectedly towards the end of a test, which happened more often
than you'd like. Not every last possible pathway to have QEMU exit or
shut down is always handled, and so EOF pops up as an "error" when it
may not be.

(I tried to handle them all, but I think there may be infinite ways to
intentionally kill QEMU.)

(2) We are using the sync frontend and an API call to terminate the
machine and/or the QMP class wasn't issued, which means we miss out on
the opportunity to gracefully exit the async loop in the backend. I
make an effort to rectify this whenever possible, but sometimes it
just isn't possible. The avalanche of stack traces you receive in this
cases is not ideal, but I have made efforts to give human readable
summaries when they occur so that the cause and fix are obvious. I
wouldn't be fundamentally shocked if I missed a case where this can
happen.

I was focused on the async qmp shell utility for a time, but stalled
because I couldn't design an appropriate command format I wanted to
commit to. I have probably neglected to make the "old" qmp-shell as
nice as a result... might be time to revisit this to make sure we have
a utility that is using all of the nice new features of the async
library.

(For instance, I never routed through async events up to the "old"
qmp-shell, so you still have to press enter on a blank line to trick
the utility into polling for new events to show. Not ideal.)

One of my hopes is that an async machine class can work in conjunction
with an async qmp class to corral concurrent errors better and produce
less output yapping in general when errors occur. I should be able to
condense them and report them more succinctly as a result.

>
> I'm unclear if this is related to our having QEMUMachine class
> expose a sync API on top of an async QMP class (square peg in
> a round hole situation), or if this is just something inherent
> to Python asyncio APIs, or probably a bit of both ?

A bit of both, but there are some mitigations possible with 3.12 that
I want to address.

One of them is the addition of ExceptionGroup which allows handling of
multiple error pathways and handling/reporting those errors in a sane
way.

Another new thing I have wanted to add is Exception notes, which
allows nice, human-readable error messages attached to unhandled stack
traces that can help give non-jargony explanations for why something
has crashed. It won't stop the unruly stack trace, but it will at
least give a nice summary that end users can latch on to without
needing to go cross-eyed trying to understand the async trace.

I also believe there's a few workarounds and hacks that got baked in
during the early days that can be dropped now, and that should
hopefully help to simplify error pathways, too. They are admittedly
complex.

>
> If switching to a fully async API throughout the stack makes
> debugging simpler, I'd welcome it.

That's the hope. If I can't make that true, it won't be worth it, I agree.

>
> > (4) Ability to add listeners/event handlers to watch for specific
> > patterns and trigger asynchronously when they occur; i.e. ability to
> > handle and watch for specific patterns in an arbitrary order without
> > deadlocking your test
> > (5) Centralized timeout setting and handling.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


