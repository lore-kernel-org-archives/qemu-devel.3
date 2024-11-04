Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0314D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wU8-00012E-T6; Mon, 04 Nov 2024 07:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7wTs-000119-3C
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:46:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7wTp-000311-88
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730724407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKnFc9ldkPn3bGuSHXRkDz5dyGxZEwSgWMUnUlT83mw=;
 b=dbwbg/03134Pjer5by2lnAilGO8e257DHJY0CHptME5xmQkZo0mZwU69Lp1i1+/2GvykCq
 6EvkLDgHEI1NEqSlr8S57xo6piT3WRDoH2AdJe8FHGY5Uw9eug4V3XjYqF7t02QBVFNKqP
 WELc9jqfK5nPXH2FDZbw3/r51pZ27Xc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-xnnZpsWzPO-nNTPNvpXsig-1; Mon,
 04 Nov 2024 07:46:43 -0500
X-MC-Unique: xnnZpsWzPO-nNTPNvpXsig-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73D9B19032BB; Mon,  4 Nov 2024 12:46:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.152])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CEAC1955E94; Mon,  4 Nov 2024 12:46:23 +0000 (UTC)
Date: Mon, 4 Nov 2024 12:46:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: check-function failing on func-arm-arm_aspeed
Message-ID: <ZyjCGzS63fiBbT5B@redhat.com>
References: <CAFEAcA_Z+o3HYfjapAeADAmjJqTYvswAfAbtj8i=3rSBDLwsyA@mail.gmail.com>
 <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28eba1fd-f5d8-4755-b8bb-074d3c087a75@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 01:12:16PM +0100, Thomas Huth wrote:
> On 28/10/2024 18.14, Peter Maydell wrote:
> > Trying a "make check-functional" I find that the func-arm-arm_aspeed
> > test seems to hit a timeout:
> > 
> > 18/18 qemu:func-thorough+func-arm-thorough+thorough /
> > func-arm-arm_aspeed              TIMEOUT        600.08s   killed by
> > signal 15 SIGTERM
> > 
> > This is with commit cea8ac78545a.
> 
> Cédric, is it working reliable for you?
> 
> > Does anybody else see this, or is it some oddity happening only
> > on my local dev machine?
> > 
> > The "full log" in testlog-thorough.txt doesn't seem to be
> > very full. All it has for this test is:
> > 
> > =================================== 18/18 ====================================
> > test:         qemu:func-thorough+func-arm-thorough+thorough /
> > func-arm-arm_aspeed
> > start time:   16:54:50
> > duration:     600.08s
> > result:       killed by signal 15 SIGTERM
> > command:      G_TEST_SLOW=1
> > PYTHONPATH=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python:/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional
> > UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> > MALLOC_PERTURB_=238
> > ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
> > MESON_TEST_ITERATION=1
> > QEMU_TEST_QEMU_IMG=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-img
> > MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> > QEMU_TEST_QEMU_BINARY=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/qemu-system-arm
> > QEMU_BUILD_ROOT=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/pyvenv/bin/python3
> > /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_arm_aspeed.py
> > ----------------------------------- stdout -----------------------------------
> > TAP version 13
> > ok 1 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_04
> > ok 2 test_arm_aspeed.AST1030Machine.test_ast1030_zephyros_1_07
> > ok 3 test_arm_aspeed.AST2x00Machine.test_arm_ast2400_palmetto_openbmc_v2_9_0
> > ==============================================================================
> > 
> > Is it possible to get the log to include a pointer to the
> > actual log for the test (including the guest console output)?
> > It's hard to debug tests if they don't report what they're doing.
> 
> I tried to add something to the log iff the test case failed (e.g. by
> checking defaultTestResult().wasSuccessful() or something similar in the
> tearDown() function of the test), but that does not seem to work ...
> so all I can suggest right now is to print out the path to the test log
> unconditionally, something like:
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index aa0146265a..7436f37bc5 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -47,13 +47,14 @@ def setUp(self, bin_prefix):
>          self.logdir = self.workdir
>          self.log = logging.getLogger('qemu-test')
>          self.log.setLevel(logging.DEBUG)
> -        self._log_fh = logging.FileHandler(os.path.join(self.logdir,
> -                                                        'base.log'), mode='w')
> +        log_file_name = os.path.join(self.logdir, 'base.log')
> +        self._log_fh = logging.FileHandler(log_file_name, mode='w')
>          self._log_fh.setLevel(logging.DEBUG)
>          fileFormatter = logging.Formatter(
>              '%(asctime)s - %(levelname)s: %(message)s')
>          self._log_fh.setFormatter(fileFormatter)
>          self.log.addHandler(self._log_fh)
> +        print(self.id() + ' log file: ' + log_file_name)

Surely this is going to break TAP format parsing of test output, as
diagnostics need to be prefixed with a '# '. I'm fairly sure it was
meson that complained about such stuff in the past when I converted
the acpibits test to the functional test

>      def tearDown(self):
>          self.log.removeHandler(self._log_fh)
> 
> Downside is that the message is also always printed if you e.g. run
> "make check-functional V=1" ... does that still sound ok to you?



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


