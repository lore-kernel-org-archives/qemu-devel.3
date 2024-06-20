Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD30EC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJIY-0003oh-Ry; Thu, 20 Jun 2024 11:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKJIX-0003lX-CI
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKJIV-0004W7-Ff
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718895717;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=S3nUSdNgimp19rDMuG+e/h4GnggJ9L4PEu5vn2wdzgI=;
 b=FpmDvTYo/FXNCkeJii8Af83hm63NPsXyAUNEkFMleGK8SFnZ4scqj8Q1jhpsUeZn5/Ijyp
 8a6YG3cuDNQN9OMDOveUbJlSF7qk48L71EtEbK9DL1BFJaf8QqtlKFXeAKNwMhoafghls+
 oL6tMpkoqjT/A3fpdeCG4CH4xeDV54I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-CkInKGo0NaGCv5maV24Wew-1; Thu,
 20 Jun 2024 11:01:54 -0400
X-MC-Unique: CkInKGo0NaGCv5maV24Wew-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 915F71955BDD; Thu, 20 Jun 2024 15:01:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B571F1955D81; Thu, 20 Jun 2024 15:01:36 +0000 (UTC)
Date: Thu, 20 Jun 2024 16:01:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, amonakov@ispras.ru
Subject: Re: [PATCH 6/6] meson: require compiler support for chosen x86-64
 instructions
Message-ID: <ZnRETaWTb57K0VO3@redhat.com>
References: <20240620130254.415699-1-pbonzini@redhat.com>
 <20240620130254.415699-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620130254.415699-7-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Thu, Jun 20, 2024 at 03:02:54PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 54e6b09f4fb..c5360fbd299 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2863,6 +2863,7 @@ have_cpuid_h = cc.links('''
>  config_host_data.set('CONFIG_CPUID_H', have_cpuid_h)
>  
>  config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
> +  .enable_auto_if(get_option('x86_version') >= '3') \
>    .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
>    .require(cc.links('''
>      #include <cpuid.h>
> @@ -2875,6 +2876,7 @@ config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
>    '''), error_message: 'AVX2 not available').allowed())
>  
>  config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
> +  .enable_auto_if(get_option('x86_version') >= '4') \
>    .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
>    .require(cc.links('''
>      #include <cpuid.h>

I'm not sure this makes sense. The CONFIG_AVX* options are used only
to validate whether the toolchain has support for this. The QEMU
code then has a runtime, so it automagically uses AVX2/AVX512
if-and-only-if running on a suitably new CPU.  IOW, we want this
enabled always when the toolchain supports it, regardless of what
x86_version is set.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


