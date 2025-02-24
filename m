Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E747AC021B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 09:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmVCO-0002w3-DN; Mon, 24 Feb 2025 04:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmVCK-0002rq-AW
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmVCG-0002rw-UH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 04:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740390978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmByXzVLyP4IVzZbueHy8sE7+bNhpyKrtGajqaGB6/c=;
 b=ZiLNRk6eb+JtQrhlwlEkZsFaDrNeMryYsU1WUoL5quVaYbGcTEMTvq9pHzxUrWDaeDXoka
 1Nr2TxwE3ON2BxYgLoCUW/BW9a/DE1kqtUIFEXTdtYLEM966KV93jfsmeb3/P5YzKc2Woo
 2CAw/36MULm7EUwZJIl+abrwJnHxExE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-Ip8oV_aPP8Kl0pQU-vB37w-1; Mon,
 24 Feb 2025 04:56:13 -0500
X-MC-Unique: Ip8oV_aPP8Kl0pQU-vB37w-1
X-Mimecast-MFC-AGG-ID: Ip8oV_aPP8Kl0pQU-vB37w_1740390971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 207141800879; Mon, 24 Feb 2025 09:56:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC10D19560A3; Mon, 24 Feb 2025 09:56:06 +0000 (UTC)
Date: Mon, 24 Feb 2025 09:56:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 2/2] tests/functional: Allow running TCG plugins tests on
 non-Linux/BSD hosts
Message-ID: <Z7xCM50MLESBdLs5@redhat.com>
References: <20250219192340.92240-1-philmd@linaro.org>
 <20250219192340.92240-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219192340.92240-3-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 19, 2025 at 08:23:40PM +0100, Philippe Mathieu-Daudé wrote:
> Not all platforms use the '.so' suffix for shared libraries,
> which is how plugins are built. Use the recently introduced
> dso_suffix() helper to get the proper host suffix.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/functional/test_aarch64_tcg_plugins.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
> index 7e8beacc833..306e46c7972 100755
> --- a/tests/functional/test_aarch64_tcg_plugins.py
> +++ b/tests/functional/test_aarch64_tcg_plugins.py
> @@ -16,7 +16,7 @@
>  import re
>  
>  from qemu.machine.machine import VMLaunchFailure
> -from qemu_test import LinuxKernelTest, Asset
> +from qemu_test import LinuxKernelTest, Asset, dso_suffix
>  
>  
>  class PluginKernelBase(LinuxKernelTest):
> @@ -62,6 +62,10 @@ class PluginKernelNormal(PluginKernelBase):
>          ('https://storage.tuxboot.com/20230331/arm64/Image'),
>          'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
>  
> +    def plugin_file(self, plugin_name):
> +        suffix = dso_suffix()
> +        return f'tests/tcg/plugins/{plugin_name}.{suffix}'
> +

IMHO this should be on the QemuBaseTest class with all the other similar
path file helpers, since in the long run plugins are liable to be used
for more than just this one test program.

>      def test_aarch64_virt_insn(self):
>          self.set_machine('virt')
>          self.cpu='cortex-a53'
> @@ -74,7 +78,7 @@ def test_aarch64_virt_insn(self):
>                                                   suffix=".log")
>  
>          self.run_vm(kernel_path, kernel_command_line,
> -                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
> +                    self.plugin_file('libinsn'), plugin_log.name,
>                      console_pattern)
>  
>          with plugin_log as lf, \
> @@ -100,7 +104,7 @@ def test_aarch64_virt_insn_icount(self):
>                                                   suffix=".log")
>  
>          self.run_vm(kernel_path, kernel_command_line,
> -                    "tests/tcg/plugins/libinsn.so", plugin_log.name,
> +                    self.plugin_file('libinsn'), plugin_log.name,
>                      console_pattern,
>                      args=('-icount', 'shift=1'))
>  
> -- 
> 2.47.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


