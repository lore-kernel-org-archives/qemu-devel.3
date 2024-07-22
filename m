Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BBFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVuaF-0001Rr-FS; Mon, 22 Jul 2024 11:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVuaD-0001Pl-9h
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:04:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVuaA-0003nU-Rq
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721660648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UFY8yZk4hgIF56JndefDXElSpK4Zo1d0RyY6AelT83k=;
 b=G9Ig/2w7OU4BxPGFmlkyc2fcMWoEmAXL8gegII69QStwtDSxW25on+Im4yG3WAfS5kXs9I
 SsMB7aY+k7svjIlTNqyrCmo+KJW3NZ1TLwkYgzQuBRYXY+QhqbNrB7PfEtI7epvTYe8WrK
 Q2TMSfbVcVlnjR7ijL4wRhgJMX285BI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-1gF386OCNmK87E9u9yAEzA-1; Mon,
 22 Jul 2024 11:04:03 -0400
X-MC-Unique: 1gF386OCNmK87E9u9yAEzA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D943F1955BD0; Mon, 22 Jul 2024 15:04:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 396E51955D47; Mon, 22 Jul 2024 15:03:57 +0000 (UTC)
Date: Mon, 22 Jul 2024 16:03:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/5] crypto: drop gnutls debug logging support
Message-ID: <Zp502k1hrDNV3B1T@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-4-berrange@redhat.com>
 <466f4899-0a07-4599-8b0d-07c4a8c759da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <466f4899-0a07-4599-8b0d-07c4a8c759da@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 04:32:23PM +0200, Philippe Mathieu-Daudé wrote:
> On 22/7/24 15:16, Daniel P. Berrangé wrote:
> > GNUTLS already supports dynamically enabling its logging at runtime by
> > setting the env var 'GNUTLS_DEBUG_LEVEL=10', so there is no need to
> > re-invent this logic in QEMU in a way that requires a re-compile.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   crypto/init.c | 11 -----------
> >   1 file changed, 11 deletions(-)
> > 
> > diff --git a/crypto/init.c b/crypto/init.c
> > index fb7f1bff10..2d6dfa3091 100644
> > --- a/crypto/init.c
> > +++ b/crypto/init.c
> > @@ -34,13 +34,6 @@
> >   #include "crypto/random.h"
> > -/* #define DEBUG_GNUTLS */
> 
> Maybe mention GNUTLS_DEBUG_LEVEL=10 here or in header? Otherwise

I'm adding

/*
 * To debug GNUTLS see env vars listed in
 * https://gnutls.org/manual/html_node/Debugging-and-auditing.html
 */



> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


