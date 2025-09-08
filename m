Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52E5CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 09:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvXzt-0003om-9X; Mon, 08 Sep 2025 05:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvXzf-0003ks-EB
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 05:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvXzV-00024f-22
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 05:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757323001;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+l/3b3cbTq/oeCxu/K9h0ZJJXkFT9qYd86ttyzMDqo=;
 b=ZmGgMnbiVXAHP2p6J0NFusxMboEDDYKo9NzEqY3oHAvDn4kDoAq9i5wGnaUUr5pkRGVomJ
 MplY1OeNlm1QET8UdXXBH+ZXBGZKFsXTCYSqFcdSxSN+3SXNXAartQDopDv+hOcdH2Vmuo
 wybArlqhcNKDWe4/rcREmcCfSdhlc3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-KlNaboD8ONa27v_bXVJ00g-1; Mon,
 08 Sep 2025 05:16:39 -0400
X-MC-Unique: KlNaboD8ONa27v_bXVJ00g-1
X-Mimecast-MFC-AGG-ID: KlNaboD8ONa27v_bXVJ00g_1757322998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 755FF1800451; Mon,  8 Sep 2025 09:16:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 052961800451; Mon,  8 Sep 2025 09:16:35 +0000 (UTC)
Date: Mon, 8 Sep 2025 11:16:32 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org, 1844144@gmail.com
Subject: Re: [PATCH v2 5/5] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
Message-ID: <aL6e8PyjsfK0Wx70@redhat.com>
References: <20250904154640.52687-1-gustavo.romero@linaro.org>
 <20250904154640.52687-6-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904154640.52687-6-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 04, 2025 at 03:46:40PM +0000, Gustavo Romero wrote:
> This commit removes Avocado as a dependency for running the
> reverse_debugging test.
> 
> The main benefit, beyond eliminating an extra dependency, is that there
> is no longer any need to handle GDB packets manually. This removes the
> need for ad-hoc functions dealing with endianness and arch-specific
> register numbers, making the test easier to read. The timeout variable
> is also removed, since Meson now manages timeouts automatically.
> 
> The reverse_debugging test is now executed through a runner, because it
> requires GDB in addition to QMP. The runner is responsible for invoking
> GDB with the appropriate arguments and for passing the test script to
> GDB.
> 
> Since the test now runs inside GDB, its output, particularly from
> 'stepi' commands, which cannot be disabled, interleaves with the TAP
> output from unittest. To avoid this conflict, the test no longer uses
> Meson’s 'tap' protocol and instead relies on the simpler 'exitcode'
> protocol.
> 
> reverse_debugging is kept "skipped" for aarch64, ppc64, and x86_64, so
> won't run unless QEMU_TEST_FLAKY_TESTS=1 is set in the test environment,
> before running 'make check-functional' or 'meson test [...]'.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/functional/aarch64/meson.build          |   7 +-
>  .../functional/aarch64/test_reverse_debug.py  |  15 +-
>  tests/functional/ppc64/meson.build            |   7 +-
>  tests/functional/ppc64/test_reverse_debug.py  |  17 +-
>  tests/functional/reverse_debugging.py         | 175 +++++++++---------
>  tests/functional/x86_64/meson.build           |   7 +-
>  tests/functional/x86_64/test_reverse_debug.py |  21 +--
>  7 files changed, 131 insertions(+), 118 deletions(-)
> 
> diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
> index 04846c6eb1..4f3168dd55 100644
> --- a/tests/functional/aarch64/meson.build
> +++ b/tests/functional/aarch64/meson.build
> @@ -32,7 +32,6 @@ tests_aarch64_system_thorough = [
>    'raspi3',
>    'raspi4',
>    'replay',
> -  'reverse_debug',
>    'rme_virt',
>    'rme_sbsaref',
>    'sbsaref',
> @@ -46,3 +45,9 @@ tests_aarch64_system_thorough = [
>    'xen',
>    'xlnx_versal',
>  ]
> +
> +if is_variable('gdb_runner')
> +tests_aarch64_system_thorough_with_runner = [
> +    ['reverse_debug', gdb_runner, 'exitcode'],
> +]
> +endif

Why do you need to replace the of 'tap' with 'exitcode' for this script ?

I don't like the idea that a subset of our functional tests are not using
the TAP protocol.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


