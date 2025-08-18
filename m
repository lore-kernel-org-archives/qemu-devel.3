Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A7FCA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 16:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo32w-0007gH-79; Mon, 18 Aug 2025 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uo32u-0007fs-QM
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 12:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uo32s-00054m-K4
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 12:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755535756;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=reFJFbmQBNshnSLNZlqPgkNTFPd0zlQyHsDqa+KSBH0=;
 b=IHkUxsgQ+vaWkEq+ChWrlLx10ELhGDDkOGmKCHTxLSeaW74vRbp4PADusD/KZDBVjF25t/
 jqnPQzZffWGDNBsL/qi1jZpR769uQTT7No9KwAeST57XnEYL6qotWcZwWM7c2VGB6Fln5U
 uGGM0uw6qbOgbkJeGmVwX5qu0fxcLvM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-xzUgtz_eP66-ASZEY1hmkA-1; Mon,
 18 Aug 2025 12:49:13 -0400
X-MC-Unique: xzUgtz_eP66-ASZEY1hmkA-1
X-Mimecast-MFC-AGG-ID: xzUgtz_eP66-ASZEY1hmkA_1755535752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E92A919775AC; Mon, 18 Aug 2025 16:49:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5335330001A5; Mon, 18 Aug 2025 16:49:08 +0000 (UTC)
Date: Mon, 18 Aug 2025 17:49:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
Message-ID: <aKNZgAw5a4f7Mtkx@redhat.com>
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 <aJI18an38eBkVL-Q@redhat.com>
 <CAAjaMXZhFM7keE1abmhQqehsZn7LaJXwYvUAuOvd-MdNTYtw1Q@mail.gmail.com>
 <aJJGvL8feHr7Wme7@redhat.com> <87h5ykzout.fsf@draig.linaro.org>
 <aJM9v0ASQOPWzcQ9@redhat.com>
 <62284106-30c9-4e30-8b97-ef38f920d237@linaro.org>
 <87bjorr8mz.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjorr8mz.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 07, 2025 at 07:41:24AM +0200, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
> > On 8/6/25 4:34 AM, Daniel P. Berrangé wrote:
> >> On Wed, Aug 06, 2025 at 12:11:38PM +0100, Alex Bennée wrote:
> >>> Daniel P. Berrangé <berrange@redhat.com> writes:
> >>>
> >>>> On Tue, Aug 05, 2025 at 07:57:38PM +0300, Manos Pitsidianakis wrote:
> >>>>> On Tue, Aug 5, 2025 at 7:49 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>> Was there a specific place where you found things hard to debug
> >>>>>> from the error message alone ?  I'm sure we have plenty of examples
> >>>>>> of errors that can be improved, but wondering if there are some
> >>>>>> general patterns we're doing badly that would be a good win
> >>>>>> to improve ?
> >>>>>
> >>>>> Some months ago I was debugging a MemoryRegion use-after-free and used
> >>>>> this code to figure out that the free was called from RCU context
> >>>>> instead of the main thread.
> >>>>
> >
> > I ran into something similar recently [1], and it was a pain to reproduce it. Luckily, I caught it using rr and could debug it, but it would have been much easier to just get a backtrace of the crash.
> >
> > In this case, it was a segmentation fault, which is not covered by current patch. Which brings me the thought I share at the end of this email.
> >
> > [1] https://lore.kernel.org/qemu-devel/173c1c78-1432-48a4-8251-65c65568c112@linaro.org/T/#
> >
> >>>> We give useful names to many (but not neccessarily all) threads that we
> >>>> spawn. Perhaps we should call pthread_getname_np() to fetch the current
> >>>> thread name, and used that as a prefix on the error message we print
> >>>> out, as a bit of extra context ?
> >>>
> >>> Do we always have sensible names for threads or only if we enable the
> >>> option?
> >>
> >> I was surprised to discover we don't name threads by default, only if we
> >> add '-name debug-threads=yes'.  I'm struggling to understand why we would
> >> ever want thread naming disabled, if an OS supports it ?
> >> I'm inclined to deprecate 'debug-threads' and always set the names when
> >> available.
> 
> On POSIX, thread naming uses pthread_setname_np(), which is a GNU
> extension.  Can't see drawbacks; just use it when available.
> 
> On Windows, thread naming appears to use a dynamically loaded
> SetThreadDescription().  Any drawbacks?  I'm a Windows ignoramus...
> 
> >>>> Obviously not as much info as a full stack trace, but that is something
> >>>> we could likely enable unconditionally without any overheads to worry
> >>>> about, so a likely incremental wni.
> >>>
> >>> The place where it comes in useful is when we get bug reports from users
> >>> who have crashed QEMU in a embedded docker container and can't give us a
> >>> reasonable reproducer. If we can encourage such users to enable this
> >>> option (or maybe make it part of --enable-debug-info) then we could get
> >>> a slightly more useful backtrace for those bugs.
> >> The challenge is whether this build option would be enabled widely
> >> enough to make a significant difference ?
> >>
> >
> > For developers working on crashes/bug fix, it's definitely a good addition (could come with --enable-debug for sure). It's something we could enable in CI by default too. Usually, with sanitizers, the reported stacktrace is enough to get a rough idea of what the problem is, without having to use any debugger.
> >
> >> I don't think we could really enable this in any distro builds, as
> >> this is way too noisy to have turned on unconditionally at build
> >> time for all users. Most containers are going to be consuming
> >> distro builds, with relatively few building custom QEMU themselves
> >> IME.  We might have better luck if this was a runtime option to
> >> the -msg arg.
> >>
> >
> > Regarding the outside world and users, I share Daniel's opinion that it would be too verbose if a backtrace is emitted with every fatal error message.
> 
> Yes, that's out of the question.  We can debate backtrace on internal
> errors, such as hitting &error_abort, or more generally abort().  Need
> to demonstrate it adds value to simply dumping core, which we get for
> free.
> 
> > However, I think it could have *incredible* value if we reported this backtrace when QEMU segfaults, which is always something exceptional.
> 
> This would be a best effort.  The program is already out of order, and
> printing may or may not work.  Avoiding printf() and memory allocation
> would improve the odds.

The risk of doing this on segvs in particular is that the act of
generating the stack trace corrupts further state, which then
makes debugging the original problem harder. 

> > In this case, we could always enable this.
> > It's not covered by the current patch, maybe it could be a great addition?
> >
> > Regarding binary size increase due to -rdynamic, I already know some people won't like it, so I'm not sure how we can ensure to have useful symbols in distributed binaries, which is a harder debate than enabling backtraces on segfaults or not.
> 
> 1. Core dumps may take disk space!  Let's disable them.
> 
> 2. My programs crash!  I need to know why.
> 
> 3. I know!  Let's make all the program bigger!
> 
> SCNR ;)

FWIW, in systemd enabled distros, core dump stack traces can be captured
for everything without needing to store the full dumps. It will capture
this even from stuff running inside containers. Fedora at least has this
enabled out of the box, not sure about defaults of other systemd based
distros.

Also if you are capturing full core dumps, QEMU can (and generally should)
be told to tell the kernel to omit guest RAM from dumps with

 -machine dump-guest-core=off

which maps to madvise(MADV_DONTDUMP).

So disk space concerns shouldn't be a reason for loosing important
debugging information from QEMU crashes in many cases

eg this example 

$ qemu-system-x86_64 &
$ killall -SEGV qemu-system-x86_64
$ coredumpctl  | tail -1
Mon 2025-08-18 17:35:45 BST  174809 1000 1000 SIGSEGV present  /usr/bin/qemu-system-x86_64 4.1M
$ coredumpctl info 174809
           PID: 174809 (qemu-system-x86)
           UID: 1000 (berrange)
           GID: 1000 (berrange)
        Signal: 11 (SEGV)
     Timestamp: Mon 2025-08-18 17:35:44 BST (2min 5s ago)
  Command Line: qemu-system-x86_64
    Executable: /usr/bin/qemu-system-x86_64
 Control Group: /user.slice/user-1000.slice/user@1000.service/user.slice/libpod-f697dc69d8bf78044d0a3964d6e9b7cc4644a66f07045796bfe5320780ffb0f0.scope/co>
          Unit: user@1000.service
     User Unit: libpod-f697dc69d8bf78044d0a3964d6e9b7cc4644a66f07045796bfe5320780ffb0f0.scope
         Slice: user-1000.slice
     Owner UID: 1000 (berrange)
       Boot ID: dab4d69ed89d444ba265e1b3a2ba3ccd
    Machine ID: 6fd7abbbb7b447e3968dd84ca07ab101
      Hostname: toolbx
       Storage: /var/lib/systemd/coredump/core.qemu-system-x86.1000.dab4d69ed89d444ba265e1b3a2ba3ccd.174809.1755534944000000.zst (present)
  Size on Disk: 4.1M
       Message: Process 174809 (qemu-system-x86) of user 1000 dumped core.
                
                Module /usr/lib64/libfdt.so.1.7.2 without build-id.
                Module /usr/lib64/libfdt.so.1.7.2
                Module /usr/lib64/libcapstone.so.5 without build-id.
                Module /usr/lib64/libcapstone.so.5
                Module libltdl.so.7 from rpm libtool-2.5.4-4.fc42.x86_64
		....snip...
                Module libpixman-1.so.0 from rpm pixman-0.46.2-1.fc42.x86_64
                Module libgnutls.so.30 from rpm gnutls-3.8.10-1.fc42.x86_64
                Stack trace of thread 174809:
                #0  0x00007f6900045642 n/a (/usr/lib64/libc.so.6 + 0x79642)
                #1  0x00007f69000399a4 n/a (/usr/lib64/libc.so.6 + 0x6d9a4)
                #2  0x00007f69000b3136 n/a (/usr/lib64/libc.so.6 + 0xe7136)
                #3  0x000055f0d2b85e15 n/a (/usr/bin/qemu-system-x86_64 + 0x5eee15)
                #4  0x000055f0d2b836e5 n/a (/usr/bin/qemu-system-x86_64 + 0x5ec6e5)
                #5  0x000055f0d27d156e n/a (/usr/bin/qemu-system-x86_64 + 0x23a56e)
                #6  0x000055f0d2ae6301 n/a (/usr/bin/qemu-system-x86_64 + 0x54f301)
                #7  0x00007f68fffcf575 n/a (/usr/lib64/libc.so.6 + 0x3575)
                #8  0x00007f68fffcf628 n/a (/usr/lib64/libc.so.6 + 0x3628)
                #9  0x000055f0d25d4395 n/a (/usr/bin/qemu-system-x86_64 + 0x3d395)
                ELF object binary architecture: AMD x86-64


NB, it can't resolve symbols in this example, as my dev env is inside
a toolbox container. If running outside a container, the stack trace
would have shown all symbols too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


