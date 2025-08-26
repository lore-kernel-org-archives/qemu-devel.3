Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF4BCA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 15:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqvVZ-0000nL-2U; Tue, 26 Aug 2025 11:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqvVR-0000fC-O3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqvVH-00066P-08
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 11:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756221742;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=30bGLInMTeEMwx+OWsyGrNU+XiA1+5q7zylwgLkObYQ=;
 b=H3I5mfahu+pqhtH9xahLBwzOl8moNNaUM6Lx6BJElCRRj3ssxxxEEItwGfKf9Ty4qV6QAa
 01l4LltKSA13m2A8w4jElum3EOPFdIs0ekWsjkS4fioOZUWGm3PFaz3GBy2Euj4fhuywMj
 EGHaeu1553JYXGUXWCzjmSrzOJZYlmo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-_KbIDtc8ObG-8PkzAku6wg-1; Tue,
 26 Aug 2025 11:22:20 -0400
X-MC-Unique: _KbIDtc8ObG-8PkzAku6wg-1
X-Mimecast-MFC-AGG-ID: _KbIDtc8ObG-8PkzAku6wg_1756221739
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 981021956089; Tue, 26 Aug 2025 15:22:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 777F530001A5; Tue, 26 Aug 2025 15:22:17 +0000 (UTC)
Date: Tue, 26 Aug 2025 16:22:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org, 1844144@gmail.com,
 Jan Richter <jarichte@redhat.com>
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
Message-ID: <aK3RJnTA1m-kEr4c@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
 <8326014d-114e-47df-89fc-632eb5683632@redhat.com>
 <aK3AYjQmb3bNEdrh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK3AYjQmb3bNEdrh@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 26, 2025 at 03:10:42PM +0100, Daniel P. Berrangé wrote:
> On Tue, Aug 26, 2025 at 09:51:27AM +0200, Thomas Huth wrote:
> > On 25/08/2025 16.04, Gustavo Romero wrote:
> > > Hello, Thomas!
> > > 
> > > On 8/25/25 07:29, Thomas Huth wrote:
> > > > On 19/08/2025 16.39, Gustavo Romero wrote:
> > > > > The goal of this series is to remove Avocado as a dependency for running
> > > > > the reverse_debugging functional test.
> > > > > 
> > > > > This test, the last one I’m aware of that relies on Avocado, requires it
> > > > > because of the need for GDB to test reverse stepping and continue.
> > ...
> > > > I gave it a try, but this did not work for me, the test was not run
> > > > at all anymore. Are there any patches needed on top?
> > > 
> > > hmm that's odd. I'm able to run it with 'make check-functional' and with
> > > 'meson test'...
> > > 
> > > This is how I'm running it (let me know if I'm missing something):
> > ...
> > > gromero@gromero0:/mnt/git/qemu_$
> > > gromero@gromero0:/mnt/git/qemu_/build$ ../configure
> > > --target-list=aarch64- softmmu --disable-docs
> > > gromero@gromero0:/mnt/git/qemu_/build$ make -j 32
> > > gromero@gromero0:/mnt/git/qemu_/build$ time make -j 15  check-functional
> > > [1/2] Generating tests/functional/func-precache-aarch64-
> > > aarch64_reverse_debug with a custom command (wrapped by meson to set
> > > env)
> > > 2025-08-25 12:50:04,215 - qemu-test - INFO - Attempting to cache '/home/
> > > gromero/.cache/qemu/
> > > download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7'
> > > 2025-08-25 12:50:04,225 - qemu-test - DEBUG - Using cached asset /home/
> > > gromero/.cache/qemu/
> > > download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7
> > > for
> > > https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/29/
> > > Everything/aarch64/os/images/pxeboot/vmlinuz
> > > GDB CMD: /usr/bin/gdb-multiarch -q -n -batch -ex 'set pagination off'
> > > -ex 'set confirm off' -ex "py
> > > sys.argv=['/mnt/git/qemu_/tests/functional/
> > > test_aarch64_reverse_debug.py']" -x /mnt/git/qemu_/tests/functional/
> > > test_aarch64_reverse_debug.py
> > > [0/1] Running external command precache-functional (wrapped by meson to
> > > set env)
> > > make[1]: Entering directory '/mnt/git/qemu_/build'
> > > [1/6] Generating qemu-version.h with a custom command (wrapped by meson
> > > to capture output)
> > > /mnt/git/qemu_/build/pyvenv/bin/meson test  --no-rebuild -t 1 --setup
> > > thorough  --num-processes 10 --print-errorlogs  --suite func  --suite
> > > func- quick  --suite func-thorough
> > >   1/27 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-
> > > aarch64_virt_gpu                   SKIP              1.95s   0 subtests
> > > passed
> > 
> > I tried a couple of times now, and finally realized that it's the
> > "gdb-multiarch" binary that is missing on Fedora. And as far as I can see,
> > there is also no package that provides this on Fedora? So if we go ahead
> > with your patches, this test will only run on certain distros that provide
> > this binary.
> 
> 'gdb-multiarch' is a command name invented by Debian.
> 
> On Fedora, the regular 'gdb' binary is built with support for
> multiple architectures for the purpose of remote debugging.

The set of archs supported by GDB in Fedora is

  s390-linux-gnu
  powerpc-linux-gnu
  arm-linux-gnu
  aarch64-linux-gnu
  riscv64-linux-gnu
  x86_64-redhat-linux-gnu

you can query this with 'gdb --configuration' and parsing the
'--enable-targets' args  - I've not found a better way :-( 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


