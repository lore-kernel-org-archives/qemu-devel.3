Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35220CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wqn-0002sG-Fr; Wed, 08 Oct 2025 12:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6WqR-0002km-U2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6WqJ-0005Ax-TZ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759940196;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0CvxHy96HLNAXOe4GJyLHMqVOMpF0iix3m7vM3BSmis=;
 b=LA/cxDFH9vmgKXSQS509V5CHF8MShNdrrOQZ0Wqx7wJmm6a0Pt1/qZWET651odU+XpJuv3
 Fs0T7JrBSJ0CTcmHSvQoYkZ8jLepss/TKTJCvSgiCBJaGjPKaAFOXW1h7ukNyryArlwQCa
 C9tHFch5JLpvh7hGKNx5LZ1XwU8RMpU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-hjFtaM1JNOqGYtzPwZjOOg-1; Wed,
 08 Oct 2025 12:16:32 -0400
X-MC-Unique: hjFtaM1JNOqGYtzPwZjOOg-1
X-Mimecast-MFC-AGG-ID: hjFtaM1JNOqGYtzPwZjOOg_1759940191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27CDD180034D
 for <qemu-devel@nongnu.org>; Wed,  8 Oct 2025 16:16:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.74])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50116180057B; Wed,  8 Oct 2025 16:16:28 +0000 (UTC)
Date: Wed, 8 Oct 2025 17:16:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH] qobject: make refcount atomic
Message-ID: <aOaOWbrE443LpqPX@redhat.com>
References: <20251008152701.411964-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008152701.411964-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 08, 2025 at 05:27:01PM +0200, Paolo Bonzini wrote:
> The Rust bindings for QObject will only operate on complete objects,
> treating them as immutable as long as the Rust QObject is live.
> 
> With that constraint, it is trivial for Rust code to treat QObjects as
> thread-safe; all that's needed is to make reference count operations
> atomic.  Do the same when the C code adds or removes references, since
> we don't really know what the Rust code is up to; of course C code will
> have to agree with not making changes to the QObjects after they've
> been passed to Rust code.

I wonder whether that latter constraint on the C code will hold
true in practice ? Particularly thinking about scenarios where
we add/remove link properties to QObject's, potentially at any
time during life of QEMU via QMP/HMP commands ?

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/qobject.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qobject/qobject.h b/include/qobject/qobject.h
> index a6244d0ce00..02f4c6a6eb2 100644
> --- a/include/qobject/qobject.h
> +++ b/include/qobject/qobject.h
> @@ -32,6 +32,7 @@
>  #ifndef QOBJECT_H
>  #define QOBJECT_H
>  
> +#include "qemu/atomic.h"
>  #include "qapi/qapi-builtin-types.h"
>  
>  /* Not for use outside include/qobject/ */
> @@ -73,7 +74,7 @@ QEMU_BUILD_BUG_MSG(QTYPE__MAX != 7,
>  static inline void qobject_ref_impl(QObject *obj)
>  {
>      if (obj) {
> -        obj->base.refcnt++;
> +        qatomic_inc(&obj->base.refcnt);
>      }
>  }
>  
> @@ -95,7 +96,7 @@ void qobject_destroy(QObject *obj);
>  static inline void qobject_unref_impl(QObject *obj)
>  {
>      assert(!obj || obj->base.refcnt);
> -    if (obj && --obj->base.refcnt == 0) {
> +    if (obj && qatomic_fetch_dec(&obj->base.refcnt) == 1) {
>          qobject_destroy(obj);
>      }
>  }

With this unref method being void, how does the Rust code
know when a QObject is no longer alive after it has called
unref ? Does it need to know this to provide any safety
guarantees ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


