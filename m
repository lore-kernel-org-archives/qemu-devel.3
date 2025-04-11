Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D41EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ef2-0003fS-KK; Fri, 11 Apr 2025 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Eex-0003a9-BJ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3Eev-0002Fd-C9
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744378983;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YY5PXsRQnhJ7B1iL8CIo54wGcbPHxm2sNzMZy+ip5Rk=;
 b=QRRF9n09CoDGSOOUwrMVePBHz2k3Dvu9mmBnKZja8JfhSyhUZms+Eb0bC9BGrI6bc4vEEB
 A3EXbS7culwp9uioOzUOeF9e79Gmw2WCwrRpsy/Xk6laHB1Bum6zR7GrbeKKLyyUCsTCp9
 2Ai4KC1JaqhlyIPesVHOfLJqzWHPx7M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-C9bko7iVOoCIpcNppKMu6g-1; Fri,
 11 Apr 2025 09:43:00 -0400
X-MC-Unique: C9bko7iVOoCIpcNppKMu6g-1
X-Mimecast-MFC-AGG-ID: C9bko7iVOoCIpcNppKMu6g_1744378979
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42A541809CA5; Fri, 11 Apr 2025 13:42:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFC651809B65; Fri, 11 Apr 2025 13:42:56 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:42:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 8/9] meson: Disallow 64-bit on 32-bit emulation
Message-ID: <Z_kcXeS8qSDa0I8_@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250208205725.568631-9-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Feb 08, 2025 at 12:57:23PM -0800, Richard Henderson wrote:
> For system mode, we can rarely support the amount of RAM that
> the guest requires. TCG emulation is restricted to round-robin
> mode, which solves many of the atomicity issues, but not those
> associated with virtio.  In any case, round-robin does nothing
> to help the speed of emulation.
> 
> For user mode, most emulation does not succeed at all.  Most
> of the time we cannot even load 64-bit non-PIE binaries due
> to lack of a 64-bit address space.  Threads are run in
> parallel, not round-robin, which means that atomicity
> is not handled.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  meson.build | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Shouldn't  this patch and the earlier ones in this series have
added something to removed-features.rst, as this is a significant
feature removal which is impacting downstream users, and distros
in particular.

> 
> diff --git a/meson.build b/meson.build
> index 85317cd63f..ec51827f40 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3185,6 +3185,9 @@ if host_os == 'windows'
>    endif
>  endif
>  
> +# Detect host pointer size for the target configuration loop.
> +host_long_bits = cc.sizeof('void *') * 8
> +
>  ########################
>  # Target configuration #
>  ########################
> @@ -3277,8 +3280,14 @@ foreach target : target_dirs
>      }
>    endif
>  
> +  config_target += keyval.load('configs/targets' / target + '.mak')
> +
>    target_kconfig = []
>    foreach sym: accelerators
> +    # Disallow 64-bit on 32-bit emulation and virtualization
> +    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
> +      continue
> +    endif
>      if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
>        config_target += { sym: 'y' }
>        config_all_accel += { sym: 'y' }
> @@ -3292,9 +3301,6 @@ foreach target : target_dirs
>      error('No accelerator available for target @0@'.format(target))
>    endif
>  
> -  config_target += keyval.load('configs/targets' / target + '.mak')
> -  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
> -
>    if 'TARGET_NEED_FDT' in config_target and not fdt.found()
>      if default_targets
>        warning('Disabling ' + target + ' due to missing libfdt')
> @@ -3307,6 +3313,7 @@ foreach target : target_dirs
>    actual_target_dirs += target
>  
>    # Add default keys
> +  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
>    if 'TARGET_BASE_ARCH' not in config_target
>      config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
>    endif
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


