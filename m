Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A7FC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp25b-000240-4v; Wed, 29 Jul 2026 07:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wp25Z-00022Y-AC
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wp25V-00050F-Ta
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 07:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785323075;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykzGrjtu5AkxQaV3uOZ77Btc5ov5tA7Vln/z0RQQ2Lk=;
 b=JDv7qewNCuEcc5HGv7V8n4xiHz4wpjoP7bnwn9vTIToLSP0SOHEpz8FgqTxoAnfMruk5Ui
 +1zsgsv8jOmNFc4dPttIB/kTIYNoSPpCF0MzpZTSiSJ16WFht8miIVisqOKSNT8oATso7Y
 fE/I4hpPwPvH/LWlMKTpDvKiY2yMjO8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-KybeJKHkPcWulNb6jScqaA-1; Wed,
 29 Jul 2026 07:04:32 -0400
X-MC-Unique: KybeJKHkPcWulNb6jScqaA-1
X-Mimecast-MFC-AGG-ID: KybeJKHkPcWulNb6jScqaA_1785323071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC02419560A6; Wed, 29 Jul 2026 11:04:30 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.113])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5326F300019F; Wed, 29 Jul 2026 11:04:29 +0000 (UTC)
Date: Wed, 29 Jul 2026 12:04:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH for-11.1?] qemu-iotest 161: fix race
Message-ID: <amneOTq8dVIw-YIZ@redhat.com>
References: <20260728163919.369020-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728163919.369020-1-mjt@tls.msk.ru>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 28, 2026 at 07:39:16PM +0300, Michael Tokarev wrote:
> qemu-iotest 161 fails intermittedly due to a race condition:
> 
> qemu:block / io-qcow2-161             ERROR            2.08s   exit status 1
> ――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> --- tests/qemu-iotests/161.out
> +++ scratch/qcow2-file-161/161.out.bad
> @@ -34,6 +34,8 @@
>  *** Commit and then change an option on the backing file
> 
>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
> +qemu-img: TEST_DIR/t.IMGFMT.base: Failed to get "write" lock
> +Is another process using the image [TEST_DIR/t.IMGFMT.base]?
>  Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
>  { 'execute': 'qmp_capabilities' }
> 
> This test is run right after a previous test, where we've
> killed qemu process which holds the test image open.

When you say "previous test" can you clarify the scenario you're
hitting. The tests run with TEST_DIR set to a name that is unique
to the test name + format. eg

   qemu.git/build/scratch/raw-file-101

so...

> It looks like when the next test is started (with creating
> the image files), old qemu is still running, so we're racing
> with that qemu, and qemu-img is unable to lock the image file
> properly.

...iiuc this can only happen if the exact same test + format is
re-run ?

Is that what you're doing ?

If so, rather than deleting the image we should do two
things

 * Make sure tests clean up after themselves if we find one that
   is buggy and leaves stuff running
 
 * Make TEST_DIR more unique by adding the current test hardness
   PID to is, so re-runs can never clash

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index dbe2dddc32..9c7f9d733e 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -259,7 +259,7 @@ def do_run_test(self, test: str) -> TestResult:
         for d in ['TEST_DIR', 'SOCK_DIR']:
             env[d] = os.path.join(
                 env[d],
-                f"{self.env.imgfmt}-{self.env.imgproto}-{f_test.name}")
+                f"{self.env.imgfmt}-{self.env.imgproto}-{f_test.name}-{os.getpid()}")
             Path(env[d]).mkdir(parents=True, exist_ok=True)
 
         test_dir = env['TEST_DIR']



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


