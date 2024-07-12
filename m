Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E39C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGhD-0004N0-90; Fri, 12 Jul 2024 09:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGh7-0003v5-GS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGh4-0004CX-0L
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720792332;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Aj8rcGmCCkMfT2iOyC4KpyDjrWxGDtqBmgZyVXrvKo=;
 b=OU6vIZbtaRF4HC4L0uXHQO6x6sjVUr1uk6iMCDb7/vb2yFn972y5pkwtZnQoOYltZfiAhE
 SA4jvfoDuaRJTRibl+5Me+WWsecoK4Alm/LIsVhyrd9AZX4RCD8RbUnJhT67LBWQP3v1tl
 UYuzg3b2B3LMqgGkj/3WBNok2W3JZzA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-pUZuJTsNOIOw2k2OcbMMtg-1; Fri,
 12 Jul 2024 09:52:10 -0400
X-MC-Unique: pUZuJTsNOIOw2k2OcbMMtg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5726E1955F3B; Fri, 12 Jul 2024 13:52:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 722F11955F40; Fri, 12 Jul 2024 13:52:05 +0000 (UTC)
Date: Fri, 12 Jul 2024 14:52:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yao Zi <ziyao@disroot.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] meson.build: fix libgcrypt detection on system without
 libgcrypt-config
Message-ID: <ZpE1ApH6sWuRdf-L@redhat.com>
References: <20240706201226.46089-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240706201226.46089-1-ziyao@disroot.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 06, 2024 at 08:12:26PM +0000, Yao Zi wrote:
> libgcrypt starts providing correct pkg-config configuration and dropping
> libgcrypt-config since 1.11.0. So use auto method for detection of
> libgcrypt, in which meson will try both pkg-config and libgcrypt-config.

The pkg-config file seems to be provided since 1.9 in fact.

Where do you see that ligcrypt-config is dropped ?  It still
exists in the gcrypt  git repo and in Fedora 1.11.0 packages.

> 
> This fixes build failure when libgcrypt is enabled on a system without
> ligcrypt-config. Auto method for libgcrypt is supported by meson since
> 0.49.0, which is higher than the version qemu requires.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  meson.build | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 6a93da48e1..1b71824548 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1695,7 +1695,6 @@ endif
>  if not gnutls_crypto.found()
>    if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
>      gcrypt = dependency('libgcrypt', version: '>=1.8',
> -                        method: 'config-tool',
>                          required: get_option('gcrypt'))
>      # Debian has removed -lgpg-error from libgcrypt-config
>      # as it "spreads unnecessary dependencies" which in

Despite the misleading commit message the change is good and I'll
queue it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


