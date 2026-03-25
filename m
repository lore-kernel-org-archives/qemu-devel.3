Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2874A109C047
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RiX-0000yl-Vx; Wed, 25 Mar 2026 13:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1w5RiT-0000yD-C2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fweimer@redhat.com>)
 id 1w5RiR-0007V2-Mu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774458502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gg5wkM7KBZG9B/V9InVG3XFk0+9R8fhuSJTWLRJZ9vI=;
 b=h5EIHvD4eFtFwjy0ShG8pqasE3nk1Z2JnMwRrFv9CslahJUJqLwXejIYZo9gwn2tSrmePo
 6E++gp8xtyBgckpHhFhT1UZWDlmGF9wzU6jCAvJigA9o7i43GV3x+Nm24tX4HM9PfQUDQp
 yq6sSzld8uR8zXwAfyPpbkvvxC4sNww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-omEX6e87OHqz7RspumjjrQ-1; Wed,
 25 Mar 2026 13:08:18 -0400
X-MC-Unique: omEX6e87OHqz7RspumjjrQ-1
X-Mimecast-MFC-AGG-ID: omEX6e87OHqz7RspumjjrQ_1774458497
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAD041944EB8; Wed, 25 Mar 2026 17:08:16 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35EC21800351; Wed, 25 Mar 2026 17:08:14 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Andreas Schwab
 <schwab@suse.de>,  Helge Deller <deller@gmx.de>,  qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
In-Reply-To: <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 18 Mar 2025 15:04:51 +0000")
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com>
 <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
Date: Wed, 25 Mar 2026 18:08:12 +0100
Message-ID: <lhumrzvn8g3.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=fweimer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

* Peter Maydell:

> On Tue, 18 Mar 2025 at 13:55, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>>
>> On Tue, Mar 18, 2025 at 01:06:17PM +0000, Peter Maydell wrote:
>> > The difficulty with vfork() (and, more generally, with various of
>> > the clone() syscall flag combinations) is that because we use the
>> > host libc we are restricted to the thread/process creation options
>> > that that libc permits: which is only fork() and pthread_create().
>> > vfork() wants "create a new process like fork with its own file
>> > descriptors, signal handlers, etc, but share all the memory space with
>> > the parent", and the host libc just doesn't provide us with the tools
>> > to do that. (We can't call the host vfork() because we wouldn't be
>> > abiding by the rules it imposes, like "don't return from the function
>> > that called vfork".)
>> >
>> > If we were implemented as a usermode emulator that sat on the raw
>> > kernel syscalls, we could directly call the clone syscall and
>> > use that to provide at least a wider range of the possible clone
>> > flag options; but our dependency on libc means we have to avoid
>> > doing things that would confuse it.
>>
>> I guess I'm not seeing how libc is blocking us in this respect ?
>> The clone() syscall wrapper is exposed by glibc at least, and it
>> is possible to call it, albeit with some caveats that we might
>> miss any logic glibc has around its fork() wrapper. The spec
>> requires that any child must immediately call execve after vfrok
>> so I'm wondering just what risk of confusion we would have in
>> practice ?
>
> I think my notes about clone are a red herring for vfork
> specifically. For vfork in the child, the vfork spec requires
> a very minimal amount of stuff to happen in the child, but QEMU's
> own TCG data structures and calls and processes mean that we
> will be doing a lot more than the guest does. For instance,
> we need to return from the function that called vfork, so we
> can continue to execute the guest code. And the guest code will
> likely call into the translator to generate more code, which will
> (a) mess up the TCG data structures for the parent and (b)
> probably result in our calling into libc functions that aren't
> OK to call.

Yes, the problem with vfork is the own state data structures for
qemu-user.  It may be okay to do this if the process is single-threaded,
but it won't really work if it is multi-threaded.

I think you would need to use userfaultfd to mimic vfork behavior for
emulated code only, and that seems to be quite a big project.

Maybe it would work to create the new PID off a new thread (created with
pthread_create) via vfork, and proxy emulated system calls through that
process, while still running the emulator in the original process.  The
trampoline could be a simple syscall function wrapper that communicates
through shared memory and a process-shared condition variable or
barrier.  Shouldn't this give the right semantics?  The emulated code
would see the new process identity because system calls like getpid are
executed remotely in that process.  It might be easier to implement than
userfaultfd support.

Thanks,
Florian


