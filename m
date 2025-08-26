Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7357CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqsBI-0006dg-4l; Tue, 26 Aug 2025 07:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqsBE-0006d1-Od
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uqsBB-0003DD-Mw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756208971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=j1BaSl6tTmjw1ukR7K6MZ+uMIeEFIkUDKa9Re6GNAu8=;
 b=VodDOPEzG8I9CKh+8X7lBOzs8Jw8CYYXZQRmmEZ+WPE1VDgUVFToIFEJFq6QbVhGJVzFzr
 SFpCwiFT+8nTx6aTnzHYOqo4VMTxvzgYG13c9fSHi45EWXE7dNmvLWvLXFw/0UjeMVyVFr
 c/xprnyp77Ds5anAReTuUrF1/vIAqGo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-rrlNK4FUP5W6XvNU8dOIig-1; Tue,
 26 Aug 2025 07:49:29 -0400
X-MC-Unique: rrlNK4FUP5W6XvNU8dOIig-1
X-Mimecast-MFC-AGG-ID: rrlNK4FUP5W6XvNU8dOIig_1756208968
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2037E195609F; Tue, 26 Aug 2025 11:49:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.174])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0FEF1977687; Tue, 26 Aug 2025 11:49:25 +0000 (UTC)
Date: Tue, 26 Aug 2025 12:49:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH 06/14] tracetool: Add Rust format support
Message-ID: <aK2fQquP2Uj_C7tP@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-7-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 22, 2025 at 02:26:47PM +0200, Paolo Bonzini wrote:
> From: Tanish Desai <tanishdesai37@gmail.com>
> 
> Generating .rs files makes it possible to support tracing in rust.
> This support comprises a new format, and common code that converts
> the C expressions in trace-events to Rust.  In particular, types
> need to be converted, and PRI macros expanded.  Fortunately, all
> common platforms have a known mapping of 8/16/32/64-bit integers
> to char/short/int/"long long": even if int64_t is equal to long,
> it is fine to change the format string from PRIx64's expansion
> "%lx" to "%llx".  This makes it possible to have a static mapping
> from PRI macros to their expansion.
> 
> As of this commit no backend generates Rust code, but it is already
> possible to use tracetool to generate Rust sources; they are not
> functional but they compile and contain tracepoint functions.
> 
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> [Move Rust argument conversion from Event to Arguments; string
>  support. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/tracetool/__init__.py  | 156 +++++++++++++++++++++++++++++++++
>  scripts/tracetool/format/rs.py |  76 ++++++++++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 scripts/tracetool/format/rs.py


> diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
> new file mode 100644
> index 00000000000..bc8b2be5971
> --- /dev/null
> +++ b/scripts/tracetool/format/rs.py
> @@ -0,0 +1,76 @@
> +# -*- coding: utf-8 -*-
> +
> +"""
> +trace-DIR.rs
> +"""
> +
> +__author__     = "Tanish Desai <tanishdesai37@gmail.com>"
> +__copyright__  = "Copyright 2025, Tanish Desai <tanishdesai37@gmail.com>"
> +__license__    = "GPL version 2 or (at your option) any later version"
> +
> +__maintainer__ = "Stefan Hajnoczi"
> +__email__      = "stefanha@redhat.com"
> +
> +
> +from tracetool import out
> +
> +
> +def generate(events, backend, group):
> +    out('// This file is autogenerated by tracetool, do not edit.',

Should add

        '/* SPDX-License-Identifier: GPL-2.0-or-later */',

and update the reference output in the later patch.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


