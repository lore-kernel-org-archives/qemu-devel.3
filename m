Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A1DC36010
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txN6m-0008Tm-10; Wed, 26 Mar 2025 05:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txN6A-0008RI-JN
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txN67-0003Mn-8t
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742981451;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=r+mDRhxCXg/J+ccPFl7rg148xFIbllxWiEEQqChfTPQ=;
 b=WmjcE3KjZcF0XS3N5JL62iWBuzcGEEoHnkujNCJf1Qah2YNz0j/Ax69SfOoetC6f4crOpY
 y2AFYTvWlsgXXsTpU8L91oe1tsUGnjdVFpf1/dira6sYHW8A5n/VkRBijwlXUAhpHw9wNg
 T+V4VSOdMDMRPGC3nxZhuzhzKbQx0E4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-m8HXSSytM3Sy1HeM6GmQlA-1; Wed,
 26 Mar 2025 05:30:49 -0400
X-MC-Unique: m8HXSSytM3Sy1HeM6GmQlA-1
X-Mimecast-MFC-AGG-ID: m8HXSSytM3Sy1HeM6GmQlA_1742981448
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AA72180AF55; Wed, 26 Mar 2025 09:30:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.107])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3B0319541A5; Wed, 26 Mar 2025 09:30:46 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:30:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 03/15] tests/functional: Convert reverse_debugging tests
 to the functional framework
Message-ID: <Z-PJQwDMG3QYP563@redhat.com>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325200026.344006-4-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 25, 2025 at 09:00:11PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These tests are using the gdb-related library functions from the
> Avocado framework which we don't have in the functional framework
> yet. So for the time being, keep those imports and skip the test
> if the Avocado framework is not installed on the host.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |   2 +-
>  tests/functional/meson.build                  |   4 +
>  .../reverse_debugging.py                      | 114 +++---------------
>  .../functional/test_aarch64_reverse_debug.py  |  37 ++++++
>  tests/functional/test_ppc64_reverse_debug.py  |  41 +++++++
>  tests/functional/test_x86_64_reverse_debug.py |  36 ++++++
>  6 files changed, 138 insertions(+), 96 deletions(-)
>  rename tests/{avocado => functional}/reverse_debugging.py (66%)
>  create mode 100755 tests/functional/test_aarch64_reverse_debug.py
>  create mode 100755 tests/functional/test_ppc64_reverse_debug.py
>  create mode 100755 tests/functional/test_x86_64_reverse_debug.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f470a1c9b7..73ccf5e5176 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3670,7 +3670,7 @@ F: docs/system/replay.rst
>  F: stubs/replay.c
>  F: tests/avocado/replay_kernel.py
>  F: tests/avocado/replay_linux.py
> -F: tests/avocado/reverse_debugging.py
> +F: tests/functional/*reverse_debug*.py
>  F: tests/functional/*replay*.py
>  F: qapi/replay.json
>  

> diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
> new file mode 100755
> index 00000000000..82925bf5908
> --- /dev/null
> +++ b/tests/functional/test_aarch64_reverse_debug.py
> @@ -0,0 +1,37 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Reverse debugging test
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from qemu_test import Asset, skipIfMissingImports
> +from reverse_debugging import ReverseDebugging
> +
> +
> +@skipIfMissingImports('avocado')

Would it make sense to specialize this to 'avocado.utils' ?

> +class ReverseDebugging_AArch64(ReverseDebugging):
> +
> +    REG_PC = 32
> +
> +    KERNEL_ASSET = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
> +         'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
> +        '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
> +
> +    def test_aarch64_virt(self):
> +        self.set_machine('virt')
> +        self.cpu = 'cortex-a53'
> +        kernel_path = self.KERNEL_ASSET.fetch()
> +        self.reverse_debugging(args=('-kernel', kernel_path))
> +
> +
> +if __name__ == '__main__':
> +    ReverseDebugging.main()

> diff --git a/tests/functional/test_x86_64_reverse_debug.py b/tests/functional/test_x86_64_reverse_debug.py
> new file mode 100755
> index 00000000000..aba31f68748
> --- /dev/null
> +++ b/tests/functional/test_x86_64_reverse_debug.py
> @@ -0,0 +1,36 @@
> +#!/usr/bin/env python3
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Reverse debugging test
> +#
> +# Copyright (c) 2020 ISP RAS
> +#
> +# Author:
> +#  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from qemu_test import skipIfMissingImports, skipFlakyTest
> +from reverse_debugging import ReverseDebugging
> +
> +
> +@skipIfMissingImports('avocado')
> +class ReverseDebugging_X86_64(ReverseDebugging):
> +
> +    REG_PC = 0x10
> +    REG_CS = 0x12
> +    def get_pc(self, g):
> +        return self.get_reg_le(g, self.REG_PC) \
> +            + self.get_reg_le(g, self.REG_CS) * 0x10
> +
> +    @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/1992")

This bug refers to ppc64. Was this a copy and paste mistake, does
that bug need updating to also mention x86_64 ?

> +    def test_x86_64_pc(self):
> +        self.set_machine('pc')
> +        # start with BIOS only
> +        self.reverse_debugging()
> +
> +
> +if __name__ == '__main__':
> +    ReverseDebugging.main()
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


