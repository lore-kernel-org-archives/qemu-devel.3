Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B7C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJCO-0007DL-0e; Thu, 20 Jun 2024 10:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKJCM-0007Ap-HL
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKJCK-00039S-KS
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718895333;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7n/C2Txau1OeRHNhOCjnWhoNXaaGHnW/ji4nym/0FPw=;
 b=Cmu/irOTEE1gwAog9G/X/zU1m5SiThc0k5rhsFld+7j8IcUShlKQQaY2L9ymy2dClOiF8Q
 y11vORHroPztqePejpgYQfi78mkVl9wfa+iamKgrYH4IoRJMSFIeFrQQ13Mg7f/tZCM2Eh
 o4FzDVoY2VA6p4IRKA3NuQz2N3JZ8a4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-B24IXHhvNxOKxhxoCTsmhQ-1; Thu,
 20 Jun 2024 10:55:31 -0400
X-MC-Unique: B24IXHhvNxOKxhxoCTsmhQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0729C19560BC; Thu, 20 Jun 2024 14:55:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E815300022B; Thu, 20 Jun 2024 14:55:24 +0000 (UTC)
Date: Thu, 20 Jun 2024 15:55:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, amonakov@ispras.ru
Subject: Re: [PATCH 4/6] meson: allow configuring the x86-64 baseline
Message-ID: <ZnRC2cVcDSlKs72d@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620130254.415699-5-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jun 20, 2024 at 03:02:52PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                   | 41 ++++++++++++++++++++++++++++-------
>  meson_options.txt             |  3 +++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 97e00d6f59b..6e694ecd9fe 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -336,15 +336,40 @@ if host_arch == 'i386' and not cc.links('''
>    qemu_common_flags = ['-march=i486'] + qemu_common_flags
>  endif
>  
> -# Assume x86-64-v2 (minus CMPXCHG16B for 32-bit code)
> -if host_arch == 'i386'
> -  qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
> -endif
> +# Pick x86-64 baseline version
>  if host_arch in ['i386', 'x86_64']
> -  qemu_common_flags = ['-mpopcnt', '-msse4.2'] + qemu_common_flags
> -endif
> -if host_arch == 'x86_64'
> -  qemu_common_flags = ['-mcx16'] + qemu_common_flags
> +  if get_option('x86_version') == '0' and host_arch == 'x86_64'
> +    error('x86_64-v1 required for x86-64 hosts')
> +  endif
> +
> +  # add flags for individual instruction set extensions
> +  if get_option('x86_version') >= '1'
> +    if host_arch == 'i386'
> +      qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
> +    else
> +      # present on basically all processors but technically not part of
> +      # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
> +      qemu_common_flags = ['-mcx16'] + qemu_common_flags
> +    endif
> +  endif
> +  if get_option('x86_version') >= '2'
> +    qemu_common_flags = ['-mpopcnt'] + qemu_common_flags
> +    qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
> +  endif
> +  if get_option('x86_version') >= '3'
> +    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
> +  endif
> +
> +  # add required vector instruction set (each level implies those below)
> +  if get_option('x86_version') == '1'
> +    qemu_common_flags = ['-msse2'] + qemu_common_flags
> +  elif get_option('x86_version') == '2'
> +    qemu_common_flags = ['-msse4.2'] + qemu_common_flags
> +  elif get_option('x86_version') == '3'
> +    qemu_common_flags = ['-mavx2'] + qemu_common_flags
> +  elif get_option('x86_version') == '4'
> +    qemu_common_flags = ['-mavx512f', '-mavx512bw', '-mavx512cd', '-mavx512dq', '-mavx512vl'] + qemu_common_flags
> +  endif
>  endif


Any particular reason you chose to list various instructions individually
rather than just ask GCC for the full ABI ? I'd think all of the above
condences down to just

  # add flags for individual instruction set extensions
  if get_option('x86_version') >= '1'
    if host_arch == 'i386'
      qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
    else
      # present on basically all processors but technically not part of
      # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
      qemu_common_flags = ['-mcx16'] + qemu_common_flags
    endif
  endif
  if get_option('x86_version') >= '2'
    qemu_common_flags = ['-march=x86-64-v' + get_option('x86_version'), '-mneeded'] + qemu_common_flags
  endif


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


