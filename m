Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3644AC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZo0-0001IS-CR; Thu, 27 Feb 2025 04:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnZnp-0001HZ-IL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnZnn-000327-K2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740647011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZszhIPsciDW52yUIkHX/wCn0QHT7xVae/t/UlYN2pg=;
 b=LyiZFbpxjhQM0dZeLQiOrex9gJqDsRXP2i+Zg1/wdT/nqQ8A3CPay0cxNO2GUjEmkM4sAV
 s5bsXLm3t6Qs4Et1OHt+0PC8yu3NChXDWPUtUuARQnxP7ycsQ24iH0D3EtXCXskaWqRJFh
 Wtfjx2UuIAuF18UdaZIi9GYW+CBt1ZE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-JI9U2pwlMhes5cuyONRRZA-1; Thu,
 27 Feb 2025 04:03:28 -0500
X-MC-Unique: JI9U2pwlMhes5cuyONRRZA-1
X-Mimecast-MFC-AGG-ID: JI9U2pwlMhes5cuyONRRZA_1740647006
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F513190ECE1; Thu, 27 Feb 2025 09:03:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BBE01800352; Thu, 27 Feb 2025 09:03:18 +0000 (UTC)
Date: Thu, 27 Feb 2025 09:03:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 07/25] tests/functional: Allow running TCG plugins tests
 on non-Linux/BSD hosts
Message-ID: <Z8AqU7HaD9kraz_c@redhat.com>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226140343.3907080-8-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 26, 2025 at 02:03:25PM +0000, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Not all platforms use the '.so' suffix for shared libraries,
> which is how plugins are built. Use the recently introduced
> dso_suffix() helper to get the proper host suffix.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20250220080215.49165-4-philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/functional/test_aarch64_tcg_plugins.py | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
> index 7e8beacc83..5736b60545 100755
> --- a/tests/functional/test_aarch64_tcg_plugins.py
> +++ b/tests/functional/test_aarch64_tcg_plugins.py
> @@ -13,10 +13,11 @@
>  
>  import tempfile
>  import mmap
> +import os
>  import re
>  
>  from qemu.machine.machine import VMLaunchFailure
> -from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import LinuxKernelTest, Asset, dso_suffix
>  
>  
>  class PluginKernelBase(LinuxKernelTest):
> @@ -62,6 +63,10 @@ class PluginKernelNormal(PluginKernelBase):
>          ('https://storage.tuxboot.com/20230331/arm64/Image'),
>          'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
>  
> +    def plugin_file(self, plugin_name):
> +        sfx = dso_suffix()
> +        return os.path.join('tests', 'tcg', 'plugins', f'{plugin_name}.{sfx}')

General purpose helper functions shouldn't go in the test cases files.
This it better placed in tests/functional/qemu_test/testcase.py, alongside
all the other path construction helper functions.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


