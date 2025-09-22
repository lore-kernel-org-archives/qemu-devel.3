Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C089CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cwi-0007TK-9j; Mon, 22 Sep 2025 05:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cwg-0007O7-6e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0cwV-0008Sm-MU
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758533679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uRLxGlxDlDSeMzcitLammO8xKvDXJ8vNPFvwt/Lh1+8=;
 b=Z3oCY3UQartK2QFIo9pYv3asjrKm2JhMQa2nRuGwFWnYc6d2jHK4qEdaxEl3nmdOzWugql
 MdMeZ6WgnxPPdK5iTfpqGHum9EMyWEXWJLvMjkTY6v0sc38isk3Nlql33JIfZ9fGhf7Gau
 +PcgVnih9J8ZTniJHk4sm+7Ocrimqqs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-9qRwSZV1O_GCkxakduxNbg-1; Mon,
 22 Sep 2025 05:34:35 -0400
X-MC-Unique: 9qRwSZV1O_GCkxakduxNbg-1
X-Mimecast-MFC-AGG-ID: 9qRwSZV1O_GCkxakduxNbg_1758533673
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3073180034F; Mon, 22 Sep 2025 09:34:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5421800577; Mon, 22 Sep 2025 09:34:29 +0000 (UTC)
Date: Mon, 22 Sep 2025 10:34:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH v3 4/4] tests/functional: Adapt arches to
 reverse_debugging w/o Avocado
Message-ID: <aNEYIeDsszbgfCQB@redhat.com>
References: <20250922054351.14289-1-gustavo.romero@linaro.org>
 <20250922054351.14289-5-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922054351.14289-5-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 22, 2025 at 05:43:51AM +0000, Gustavo Romero wrote:
> reverse_debugging no longer depends on Avocado, so remove the import
> checks for Avocado, the per-arch endianness tweaks, and the per-arch
> register settings. All of these are now handled in the ReverseDebugging
> class.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  .../functional/aarch64/test_reverse_debug.py  | 13 +++++--------
>  tests/functional/ppc64/test_reverse_debug.py  | 15 +++++----------
>  tests/functional/x86_64/test_reverse_debug.py | 19 ++++++-------------
>  3 files changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/tests/functional/aarch64/test_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
> index 8bc91ccfde..7f816025a9 100755
> --- a/tests/functional/aarch64/test_reverse_debug.py
> +++ b/tests/functional/aarch64/test_reverse_debug.py
> @@ -1,26 +1,23 @@
> -#!/usr/bin/env python3
> -#
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -# Reverse debugging test
> +# Reverse debugging test for aarch64
>  #
>  # Copyright (c) 2020 ISP RAS
> +# Copyright (c) 2025 Linaro Limited
>  #
>  # Author:
>  #  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> +#  Gustavo Romero <gustavo.romero@linaro.org> (Run without Avocado)
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
>  
> -from qemu_test import Asset, skipIfMissingImports, skipFlakyTest
> +from qemu_test import Asset, skipFlakyTest
>  from reverse_debugging import ReverseDebugging
>  
>  
> -@skipIfMissingImports('avocado.utils')
>  class ReverseDebugging_AArch64(ReverseDebugging):
>  
> -    REG_PC = 32
> -
>      ASSET_KERNEL = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
> @@ -35,4 +32,4 @@ def test_aarch64_virt(self):
>  
>  
>  if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_AArch64.main()

This shouldn't be needed AFAICT ?  (Same for other files)



>      @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/2922")
>      def test_x86_64_pc(self):
>          self.set_machine('pc')
> -        # start with BIOS only
> +        # Start with BIOS only

Spurious comment change

>          self.reverse_debugging()
>  
>  
>  if __name__ == '__main__':
> -    ReverseDebugging.main()
> +    ReverseDebugging_X86_64.main()
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


