Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A2ECAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux56W-0006uN-Vp; Fri, 12 Sep 2025 10:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux56N-0006WX-6h
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux56E-0007hi-LS
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757688602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7SS32GOmeVlDCi9lftr8b/i0oix8Re2uCyAHjkf+htg=;
 b=W7tovtT/LF3Y5AgBd2umJmMaw1dVoNuy79CVoY2wmeIUdwBKJeGTOQA8XT0zav/1suMsGG
 1qjsMIhIPGlizE/GqfbYtfCZ0rCMeanH75r1gonqX+GdBFM3pANASeBGneEa6fc5wWLiLO
 991AVc0U1zBfuzULYBSNbanduA4m0OI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-fQr5U3_GOOiUzaXHAJ_iCA-1; Fri,
 12 Sep 2025 10:49:58 -0400
X-MC-Unique: fQr5U3_GOOiUzaXHAJ_iCA-1
X-Mimecast-MFC-AGG-ID: fQr5U3_GOOiUzaXHAJ_iCA_1757688597
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FDA2180048E; Fri, 12 Sep 2025 14:49:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB021800447; Fri, 12 Sep 2025 14:49:55 +0000 (UTC)
Date: Fri, 12 Sep 2025 15:49:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 0/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Message-ID: <aMQzD0m3QluWzlmh@redhat.com>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <aL7CsSppNc-WZFY-@redhat.com>
 <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6320118-84f0-4088-82de-7192be6093cd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Thu, Sep 11, 2025 at 08:51:08PM -0300, Gustavo Romero wrote:
> Hi Daniel,
> 
> Thanks a lot for review and the suggestions.
> 
> On 9/8/25 08:49, Daniel P. Berrangé wrote:
> > On Thu, Sep 04, 2025 at 03:46:35PM +0000, Gustavo Romero wrote:
> > > In this series, we leveraged the run-test.py script used in the
> > > check-tcg tests, making it a GDB runner capable of calling a test script
> > > without spawning any VMs. In this configuration, the test scripts can
> > > manage the VM and also import gdb, making the GDB Python API inside the
> > > functional test scripts.
> > > 
> > > A --quiet option has been added to run-test.py so it doesn't print the
> > > command line used to execute GDB to the stdout. This ensures that users
> > > don't get confused about how to re-run the tests. One can re-run the
> > > test simply by copying and pasting the command line shown by Meson when
> > > V=1 is passed:
> > > 
> > > $ make -j check-functional V=1
> > > 
> > > or, alternatively, once the test run completes, the exact command found
> > > in the 'command:' field of the build/meson-logs/testlog-thorough.txt
> > > file generated by Meson. Both methods provide the correct environment
> > > variables required to run the test, such as the proper $PYTHONPATH.
> > 
> > While I like the conceptual idea of just sending human GDB commands,
> > instead of working with GDB protocol packets, I really dislike the
> > effect this has on the execution / startup of the functional tests
> > via use of the custom runner for a number of reasons
> > 
> >   * The command line for launching the test outside of meson is very
> >     complicated, so not memorable
> 
> Why very complicated? It calls a simple runner instead of calling the
> test script directly, but it doesn't change the way to re-run a single
> test. One just have to pass V=1 to see make's command line  and copy
> and paste the full command line to re-run the test. I mentioned
> inspecting 'testlog-thorough.txt' just for completeness.

Today we can run the individual tests directly 

 # ./tests/functional/x86_64/test_reverse_debug.py
 TAP version 13
 ok 1 test_reverse_debug.ReverseDebugging_X86_64.test_x86_64_pc
 1..1


(assuming you have PYTHONPATH and QEMU_TEST_QEMU_BINARY env set)

This gives you a very easy way to interact with the test, see
its progress, understand what failed, and debug it with strace,
etc.

This change looses all that. It appears I can run it with

  # ./tests/guest-debug/run-test.py --quiet --gdb gdb --test \
       ./tests/functional/x86_64/test_reverse_debug.py

but the output is unintelligible

  TAP version 13
  0x000000000000fff0 in ?? ()
  0x000000000000e05b in ?? ()
  0x000000000000e062 in ?? ()
  0x000000000000e066 in ?? ()
  0x000000000000e068 in ?? ()
  0x000000000000e06a in ?? ()
  0x000000000000e070 in ?? ()
  0x000000000000e076 in ?? ()
  0x000000000000cf30 in ?? ()
  0x000000000000cf31 in ?? ()
  0x000000000000cf32 in ?? ()
  0x000000000000cf31 in ?? ()
  0x000000000000cf30 in ?? ()
  0x000000000000e076 in ?? ()
  0x000000000000e070 in ?? ()
  0x000000000000e06a in ?? ()
  0x000000000000e068 in ?? ()
  0x000000000000e066 in ?? ()
  0x000000000000e062 in ?? ()
  0x000000000000e05b in ?? ()
  0x000000000000fff0 in ?? ()
  0x000000000000e05b in ?? ()
  0x000000000000e062 in ?? ()
  0x000000000000e066 in ?? ()
  0x000000000000e068 in ?? ()
  0x000000000000e06a in ?? ()
  0x000000000000e070 in ?? ()
  0x000000000000e076 in ?? ()
  0x000000000000cf30 in ?? ()
  0x000000000000cf31 in ?? ()
  0x000000000000cf32 in ?? ()
  Breakpoint 1 at 0xfff0
  Breakpoint 2 at 0xe05b
  Breakpoint 3 at 0xe062
  Breakpoint 4 at 0xe066
  Breakpoint 5 at 0xe068
  Breakpoint 6 at 0xe06a
  Breakpoint 7 at 0xe070
  Breakpoint 8 at 0xe076
  Breakpoint 9 at 0xcf30
  Breakpoint 10 at 0xcf31
  
  Program received signal SIGINT, Interrupt.
  0x00000000000d80dc in ?? ()
  
  Breakpoint 1, 0x000000000000fff0 in ?? ()
  [Inferior 1 (process 1) detached]


This undermines the core goals of what we aimed to achieve with
the new functional test harness.

> 
> >   * It makes the meson.build rules much more complicated
> 
> Do we want to never augment functional tests' meson.build? Nothing
> complicated is being added. Basically, just a new variable suffixed with
> '_with_runner' which holds a tuple (test, runner) that tell the test
> to be executed, following the same logic we already have for all the other
> variables that specify the tests per arch/mode/speed.
> 
> Another option would be to select a runner based on a suffix in the test
> name, for instance, 'reverse_debug_with_runner.py'.

IMHO the overall concept of using the run-test.py runner for launching
the tests is flawed and not viable. It adds too much complexity to the
use of the tests, and harms the output.

> >   * Running standalone there is no TAP output available making the
> >     test hard to debug on failure or timeout
> 
> This is because of an unfortunate GDB Python API issue, please see my
> reply in your comment on patch 5/5. This can be solved but needs more
> investigation on GDB side.
> 
> 
> > I understand the need to spawn the test via gdb, in order to be able
> > to import the 'gdb' python module. Looking at what reverse_debugging.py
> > does, however, makes me question whether we actually need to directly
> > use the 'gdb' python module.
> > 
> > The only APIs we use are 'gdb.execute' and 'gdb.parse_and_eval'.
> > 
> > The latter is only used once as
> > 
> >    gdb.parse_and_eval("$pc")
> > 
> > and I believe that can be changed to
> > 
> >    gdb.execute("printf \"0x%x\", $pc", to_string=True)
> > 
> > IOW, all we need is 'gdb.execute("....", to_string=True)'
> 
> Yes, I do want to directly use the 'gdb' python module directly in the
> tests. We shouldn't look at a solution only for reverse_debug.py but also
> think of any future tests that will require the GDB Python API, so I don't
> want to specialize here and reduce the API to a single method.

If any other tests needing GDB arrive int he future we can consider
them at that time.

I like the idea of the test being able to execute human gdb commands,
but I don't think the GDB provided 'gdb' module is viable to use
directly. We need to retain control over how we launch our tests
without intermediate runners present.

> > With a little extra helper proxy script, we can achieve this without
> > changing the way scripts are launched.
> > 
> > The script needs to listen on a UNIX socket path. When a client
> > connects, it should read lines of data from the client and pass
> > them to 'gdb.execute(..., to_string=True)' and whatever data
> > gdb returns should be written back to the client.
> > 
> > A very very crude example with no error handling would be:
> > 
> >    #!/usr/bin/python3
> > 
> >    import gdb
> >    import os
> >    import socket
> > 
> >    sock = os.environ.get("QEMU_PROXY", "/tmp/qemu.gdb.proxy")
> > 
> >    try:
> >      os.unlink(sock)
> >    except:
> >      pass
> > 
> >    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
> >      s.bind(sock)
> >      s.listen()
> >      conn, addr = s.accept()
> >      fh = conn.makefile('rw')
> >      with conn:
> >          while True:
> >              line = fh.readline()
> >              if not line:
> >                  break
> >              data = gdb.execute(line, to_string=True)
> >              fh.write(data)
> >              fh.flush()
> > 
> > 
> > In the functional test suite, we should have a helper file
> > tests/functional/qemu_test/gdb.py that provides an API for
> > launching GDB to execute this proxy script, and an API to
> > execute commands by talking over this UNIX socket path.
> > 
> > With this, we will need no changes in the way we execute the
> > reverse debugging script from a test runner POV, thus avoiding
> > all the downsides of use of the run-test.py script. IOW, the
> > first 4 patches in this series go away completely. Instead we
> > need a patch to create the proxy script and a patch to create
> > the helper APIs in tests/functional/qemu_test/gdb.py, whereupon
> > the last patch can replace
> > 
> > try:
> >      import gdb
> > except ModuleNotFoundError:
> >      from sys import exit
> >      exit("This script must be launched via tests/guest-debug/run-test.py!")
> > 
> > with
> > 
> >    from qemu_test import gdb
> > 
> > and the earlier mentioned replacement of parse_and_eval()
> 
> For the sake of not adding a few lines into meson.build, we are going
> to design a new ad-hoc API for the functional tests on top of the GDB
> Python API, which will communicate with the test script via a socket
> and will _still require a runner anyway_ (just now hidden under a
> module/API)? This is far more complicated than having a simple runner
> to call GDB and pass the test script.

This is not exclusively about the meson.build changes. It is about the
overall execution environment of the tests being *simple* and easy to
understand. That is the overrriding goal of how we approached design
of the new functional test harness that made it valuable to spend the
time to replace avocado. The GDB runner usage undermines the benefits
we have achieved.

> In fact, I think that if the test script had any clue in its name,
> like the "_with_runner" suffix I mentioned above, maybe Meson's could
> take care of calling GDB itself without calling any runner. Would that
> address your first comment in the bullets (and maybe the second one too,
> but not sure without trying it) and get this series accepted by you,
> since the third one, about the exitcode, is related to GDB's odd behavior?

The tests need to be runnable directly as standalone python programs,
with well formed TAP output.

Given the limitations of GDB, if we want to use its python module, then
the proxy idea I describe above is the only way forward I see.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


