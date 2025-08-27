Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDEBCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 09:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urCo4-0005oG-Tf; Wed, 27 Aug 2025 05:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urCo2-0005mt-DG
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urCny-0003te-Aw
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756288254;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8+vvGgr/TMr049iVOrePFOf3V0szyzDgDwFlc8ybA4Q=;
 b=b8/jlgwzAynfFtR084aRp7kzR0gXV2g0E7BdqHyxDmq+Fqq2IU6hIaIbm4nq2KtTgkvBD5
 RyvgSrGaFKbzLAzE5LRwW5SewwVkIKX/0cjojQmMG9irengNbLhGJuN3tb9sP2PRZ33P1o
 lM1u9VAAs3QOMmnUfTEH1DVXdTBeSOc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-sxTj_5aJNVCflGn6xe9SjQ-1; Wed,
 27 Aug 2025 05:50:50 -0400
X-MC-Unique: sxTj_5aJNVCflGn6xe9SjQ-1
X-Mimecast-MFC-AGG-ID: sxTj_5aJNVCflGn6xe9SjQ_1756288249
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE09B19560B1; Wed, 27 Aug 2025 09:50:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD55130001A6; Wed, 27 Aug 2025 09:50:40 +0000 (UTC)
Date: Wed, 27 Aug 2025 10:50:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 qemu-arm@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] tests/functional: Fix reverse_debugging asset precaching
Message-ID: <aK7U6AWCMMHMZtZ3@redhat.com>
References: <20250827001008.22112-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827001008.22112-1-gustavo.romero@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

CC stable

On Wed, Aug 27, 2025 at 12:10:08AM +0000, Gustavo Romero wrote:
> This commit fixes the asset precaching in the reverse_debugging test on
> aarch64.
> 
> QemuBaseTest.main() precaches assets (kernel, rootfs, DT blobs, etc.)
> that are defined in variables with the ASSET_ prefix. This works because
> it ultimately calls Asset.precache_test(), which relies on introspection
> to locate these variables.
> 
> If an asset variable is not named with the ASSET_ prefix, precache_test
> cannot find the asset and precaching silently fails. Hence, fix the
> asset precaching by fixing the asset variable name.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/functional/test_aarch64_reverse_debug.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/test_aarch64_reverse_debug.py
> index 58d4532835..8bc91ccfde 100755
> --- a/tests/functional/test_aarch64_reverse_debug.py
> +++ b/tests/functional/test_aarch64_reverse_debug.py
> @@ -21,7 +21,7 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>  
>      REG_PC = 32
>  
> -    KERNEL_ASSET = Asset(
> +    ASSET_KERNEL = Asset(
>          ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
>           'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
>          '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
> @@ -30,7 +30,7 @@ class ReverseDebugging_AArch64(ReverseDebugging):
>      def test_aarch64_virt(self):
>          self.set_machine('virt')
>          self.cpu = 'cortex-a53'
> -        kernel_path = self.KERNEL_ASSET.fetch()
> +        kernel_path = self.ASSET_KERNEL.fetch()
>          self.reverse_debugging(args=('-kernel', kernel_path))
>  
>  
> -- 
> 2.34.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


