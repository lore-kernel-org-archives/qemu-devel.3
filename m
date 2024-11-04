Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F644D132A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tEJ-00075m-H8; Mon, 04 Nov 2024 04:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7tEF-00075Y-DM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t7tEC-00049E-9n
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730711907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1O+OXJetMWn0bcbc+n0FEBPKISrMwcoRIjxicJeL9mk=;
 b=UQUih1O0zneFXe8Oirnu+UxTxr+CF3NDwyKXLPZ16Lhg+iN90my3S5KXXhD/TnbJvZj6OF
 HnHRSPxetkKaLTirQuJKY20WfH779Kdj40H9hSjrI+uTi9QfnVRQ7pcx5qm4+xbEuKK/e8
 81UwRrlYaHngMRwjCY46Ra87DJ6qJKU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-7xuBHeK0NmKvAMRB6aWuug-1; Mon,
 04 Nov 2024 04:18:25 -0500
X-MC-Unique: 7xuBHeK0NmKvAMRB6aWuug-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE1811955D53; Mon,  4 Nov 2024 09:18:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.152])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EF93300019D; Mon,  4 Nov 2024 09:18:19 +0000 (UTC)
Date: Mon, 4 Nov 2024 09:18:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: jansene@google.com, sw@weilnetz.de, peterx@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] sysemu/os-win32.h: Windows clang-cl compiler fixes
Message-ID: <ZyiRWPssVKTpJBql@redhat.com>
References: <20241101214101.3376595-1-roqueh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101214101.3376595-1-roqueh@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Nov 01, 2024 at 09:41:01PM +0000, Roque Arcudia Hernandez wrote:
> This contains a series of small compiler fixes to enable the compilation
> of qemu using clang-cl.
> 
> It mainly involves adding some missing header files and updating #ifdefs
> to handle clang-cl specific things.
> 
> Signed-off-by: Erwin Jansen <jansene@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  include/qemu/compiler.h   | 3 ++-
>  include/sysemu/dma.h      | 2 ++
>  include/sysemu/os-win32.h | 2 +-
>  migration/savevm.c        | 2 ++
>  tests/qtest/libqtest.c    | 2 +-
>  5 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index c06954ccb4..7f532fe660 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -22,7 +22,8 @@
>  #define QEMU_EXTERN_C extern
>  #endif
>  
> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)) && \
> +    !defined(__clang__)
>  # define QEMU_PACKED __attribute__((gcc_struct, packed))
>  #else
>  # define QEMU_PACKED __attribute__((packed))

We must use the 'gcc_struct' format for packing on Windows
to preserve the correct ABI.

clang doesn't support this yet, which is why we don't permit
use of clang on Windows platforms at this time.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


