Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F14CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pf0-0006Dv-UX; Wed, 24 Sep 2025 09:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Pey-0006Bk-4I
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:35:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Pes-0004jL-LR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758720941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bag7Ptn4J5Y/1DWF7VKOZgfEh15GMqlPJfGBL0E4bLw=;
 b=E0quDb9+ayB/aIiXAlNK+b3upOBenI5Teiw9ICCT7hSqLziKRPOrap26eu2C53KEuNMhO3
 rzz9204aZvtQCOPgfbkma4bcCuD1gNDqlNYXxOFwR//K4A9XzbN+IHcmQSqoxluJGQz6Eu
 mou9iIqDiG6Nv9lcfJVe6EL/vdvZPYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-8LYYRJ2xObq8va08EsbTiA-1; Wed,
 24 Sep 2025 09:35:36 -0400
X-MC-Unique: 8LYYRJ2xObq8va08EsbTiA-1
X-Mimecast-MFC-AGG-ID: 8LYYRJ2xObq8va08EsbTiA_1758720934
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B844718002C0; Wed, 24 Sep 2025 13:35:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7153000198; Wed, 24 Sep 2025 13:35:27 +0000 (UTC)
Date: Wed, 24 Sep 2025 14:35:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, devel@lists.libvirt.org,
 qemu-rust@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 11/27] build-sys: cfi_debug and safe_stack are not
 compatible
Message-ID: <aNPznNG2e5x94Xts@redhat.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924120426.2158655-12-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Sep 24, 2025 at 04:04:08PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It fails to link on fedora >= 41:
> /usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memcpy':
> (.text.__sanitizer_internal_memcpy+0x0): multiple definition of `__sanitizer_internal_memcpy'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memcpy+0x0): first defined here
> /usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memmove':
> (.text.__sanitizer_internal_memmove+0x0): multiple definition of `__sanitizer_internal_memmove'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memmove+0x0): first defined here
> /usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memset':
> (.text.__sanitizer_internal_memset+0x0): multiple definition of `__sanitizer_internal_memset'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memset+0x0): first defined here
> 
> cfi_debug seems to pull ubsan which has conflicting symbols with safe_stack.
> 
> See also: https://bugzilla.redhat.com/show_bug.cgi?id=2397265
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  meson.build                | 3 +++
>  .gitlab-ci.d/buildtest.yml | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


