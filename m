Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF321C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTST-0005br-DD; Tue, 17 Sep 2024 04:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sqTSQ-0005Yc-Ol
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sqTSN-00041u-Hx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726561266;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YyD1BUGx/dhdlYpgHApnQQ8vrqwB6HhtXtzsAonFFQc=;
 b=eTQCvjkQ1comsPJPe8ly5ywrhosfFoNgtjSDnaNIGOzrv329b8UzWSiON7H6019fkxBHml
 0rffZ9gu/FDzvVJCg8W7PCoe9OVGPJZfNckKGH6rrCNsGWhEd+qjFXX8TKrBc/OrIH2gb5
 KHZYKmYkwAR0Yro+3kSF/AJ8TL0H4jk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-396Aix36PoKZVF50x93trw-1; Tue,
 17 Sep 2024 04:21:02 -0400
X-MC-Unique: 396Aix36PoKZVF50x93trw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D4B7195608C; Tue, 17 Sep 2024 08:21:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6069030001A1; Tue, 17 Sep 2024 08:20:58 +0000 (UTC)
Date: Tue, 17 Sep 2024 09:20:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/unit: Really build pbkdf test on macOS
Message-ID: <Zuk7tnWvKyxhJzOT@redhat.com>
References: <20240917065736.27883-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917065736.27883-1-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 17, 2024 at 08:57:36AM +0200, Philippe Mathieu-Daudé wrote:
> Fix a typo to run the pbkdf crypto cipher tests on macOS.
> 
>  $ make check-unit
>    ...
>    87/102 qemu:unit / test-crypto-pbkdf      OK      2.35s   17 subtests passed
> 
> Fixes: ebe0302ac8 ("tests/unit: build pbkdf test on macOS")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/unit/test-crypto-pbkdf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
> index b477cf4e4b..12ee808fbc 100644
> --- a/tests/unit/test-crypto-pbkdf.c
> +++ b/tests/unit/test-crypto-pbkdf.c
> @@ -25,7 +25,7 @@
>  #include <sys/resource.h>
>  #endif
>  
> -#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWNI)
> +#if defined(_WIN32) || defined(RUSAGE_THREAD) || defined(CONFIG_DARWIN)

/face-palm

>  #include "crypto/pbkdf.h"
>  
>  typedef struct QCryptoPbkdfTestData QCryptoPbkdfTestData;

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


