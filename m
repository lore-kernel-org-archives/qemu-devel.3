Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE0CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 09:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl39f-0006ou-Jd; Mon, 02 Sep 2024 05:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sl39d-0006o0-B2
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sl39b-000850-8K
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 05:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725268517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UGORFKBEhSmSi0Zwf86Tf0fkHZiFDdV+gHc+zOUAGYU=;
 b=fC+VbEhmzI7nvx9LqZDCnBddRWM3/g7s0mZ/0l/z2O+bTz7cUjTlOXpcoTv6QQ/PMgAIOE
 NSbnVhqXOGjPYddBuPLxKp0phyqTwd5ia5O4FXLNW1gEExoXvZtsn2L5tVvXqJa8sEchH4
 C8fB8znaSTvKfRlk938rReosZOJRw8k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-siDpQaW3M16LU2UHTX_Dxg-1; Mon,
 02 Sep 2024 05:15:13 -0400
X-MC-Unique: siDpQaW3M16LU2UHTX_Dxg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 728E11955D47
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2024 09:15:12 +0000 (UTC)
Received: from localhost (unknown [10.42.28.10])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A12421955BE3; Mon,  2 Sep 2024 09:15:11 +0000 (UTC)
Date: Mon, 2 Sep 2024 10:15:10 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/unit: remove block layer code from
 test-nested-aio-poll
Message-ID: <20240902091510.GB1450@redhat.com>
References: <20240902000343.54021-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902000343.54021-1-pbonzini@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 02, 2024 at 02:03:43AM +0200, Paolo Bonzini wrote:
> GCC is reporting a NULL pointer dereference when compiling aio_wait_kick()
> with LTO.
> 
> The issue is that test-nested-aio-poll.c does not call qemu_init_main_loop().
> It doesn't _need_ to because it never calls AIO_WAIT_WHILE(), but it seems
> that LTO does not do enough dead-code elimination to catch that.
> 
> Fortunately aio_wait_kick() is only used in few places, and only in block
> layer or system emulation code; and this test only needs the core event loop
> functionality.  It does not even need iothreads.   So remove everything that
> calls aio_wait_kick(), which is nice for coverage compared to adding the call
> to qemu_init_main_loop().
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2434
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/unit/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 490ab8182dc..6c377917636 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -115,7 +115,7 @@ if have_block
>    if host_os != 'windows'
>      tests += {
>        'test-image-locking': [testblock],
> -      'test-nested-aio-poll': [testblock],
> +      'test-nested-aio-poll': [],
>      }
>    endif
>    if config_host_data.get('CONFIG_REPLICATION')

I tested this patch & it fixes the build problem here, thanks!

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW


