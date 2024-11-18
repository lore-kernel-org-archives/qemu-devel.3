Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E1CD49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1JC-00064z-Bt; Mon, 18 Nov 2024 07:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tD1JA-00064q-IF
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:56:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tD1J8-0006Rf-QJ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731934605;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VgkenlmULVdGdrT4VQihxvXhbzkXBBhT7y2mGskpSN4=;
 b=cv8zrhctb3VkMSTvJdmZyqS23Lypgu8lWLWpM+swWhl4ZaBIfulzSneq4+MT2uuWe9W1GI
 8nY/WRHrfRzF+1UNdDeB5G2urDC8BIz5njzoqABVm+iGJRjx8xPsH9uQQGwvcl2O8CSSSq
 Gvbmic8hEzugDZM9dGrBHsxZIh/Zhko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-v5PbqxljNVqmuemY581dvA-1; Mon,
 18 Nov 2024 07:56:43 -0500
X-MC-Unique: v5PbqxljNVqmuemY581dvA-1
X-Mimecast-MFC-AGG-ID: v5PbqxljNVqmuemY581dvA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17FDE1955D4D; Mon, 18 Nov 2024 12:56:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C34A19560A3; Mon, 18 Nov 2024 12:56:40 +0000 (UTC)
Date: Mon, 18 Nov 2024 12:56:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: tests/functional is eating disk space
Message-ID: <Zzs5hKLic2XU4FBc@redhat.com>
References: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
 <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Mon, Nov 18, 2024 at 01:10:14PM +0100, Thomas Huth wrote:
> On 18/11/2024 11.57, Peter Maydell wrote:
> > I just ran out of disk space on my dev machine, because:
> > 
> > $ du -h build/clang/tests/functional/
> > [...]
> > 11G     build/clang/tests/functional/
> 
> That's indeed a lot. I only got 6.9G in my build tree for all targets ... I
> guess there are some stale files lying around, so as a temporary mitigation,
> just try to delete that folder (it should get recreated the next time you
> run the tests).
> 
> > The new functional tests seem to be eating disk space.
> > 
> > Even the build tree I have that's just arm targets is 7.1GB.
> > 
> > Could you have a look at what's happening here?
> 
> I am aware of the problem and got it on my TODO list already... I think we
> best should set the "workdir" to a temporary folder that we can remove once
> the test has finished, that will automatically delete all binary assets that
> the test created during its runtime.

workdir also stores the logs currently, which we want to preserve, but we
can just move assets to a sub-tree instead. Something approx like this:

@@ -40,11 +42,11 @@ def setUp(self, bin_prefix):
         self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
         self.arch = self.qemu_bin.split('-')[-1]
 
-        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
-                                    self.id())
-        os.makedirs(self.workdir, exist_ok=True)
+        self.outputdir = Path(BUILD_DIR, 'tests', 'functional', self.arch, self.id())
+        self.workdir = Path(self.outputdir, 'scratch')
+        self.workdir.mkdir(parents=True, exist_ok=True)
 
-        self.logdir = self.workdir
+        self.logdir = self.outputdir
         self.log_filename = os.path.join(self.logdir, 'base.log')
         self.log = logging.getLogger('qemu-test')
         self.log.setLevel(logging.DEBUG)
@@ -56,6 +58,8 @@ def setUp(self, bin_prefix):
         self.log.addHandler(self._log_fh)
 
     def tearDown(self):
+        if not "QEMU_TEST_SKIP_RMTREE" in os.environ:
+            shutil.rmtree(self.workdir)
         self.log.removeHandler(self._log_fh)
 
     def main():


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


