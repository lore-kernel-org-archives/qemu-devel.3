Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F31CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYB8-0001XU-Np; Fri, 19 Sep 2025 06:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzYB6-0001Vm-H7
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzYB2-0000ta-9n
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758277033;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=riVFNTyrntU0Pdv7PASyh+zm6orsNhMb2Idj0Y25f4Y=;
 b=PUZf9J4jGzVP2Kcu9xY1TrEvY54CZfkSSfszRO0EkIftbT+9IyHLp4HEGpiua+imjnJb1s
 f8YM46bADamwf8B1RHuRwqOeLAp3/vaBlz8xj7R1BLfzFBwj78lF/JObakM6O5qk9JAnmi
 3TY+0KbTToUDGLViWHsUhgrrcu/GrRI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-UMou-etWP7Op5nJpL95eJA-1; Fri,
 19 Sep 2025 06:17:09 -0400
X-MC-Unique: UMou-etWP7Op5nJpL95eJA-1
X-Mimecast-MFC-AGG-ID: UMou-etWP7Op5nJpL95eJA_1758277028
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD1A180057D; Fri, 19 Sep 2025 10:17:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36639180035E; Fri, 19 Sep 2025 10:17:07 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:17:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mads@ynddal.dk, stefanha@redhat.com
Subject: Re: [PATCH] tracing: deprecate "ust" tracing backend
Message-ID: <aM0tn93uWCKsZRfE@redhat.com>
References: <20250919101021.119590-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919101021.119590-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Sep 19, 2025 at 12:10:21PM +0200, Paolo Bonzini wrote:
> The "ust" backend is complex (tracetool contains two output formats just
> for that backend).  It is not clear if if it has any users, and LTTng
> anyway can use the uprobe tracepoints provided by the "dtrace" backend,
> therefore deprecate "ust".
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/deprecated.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index aa300bbd507..57250f9d47f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -533,3 +533,12 @@ command documentation for details on the ``fdset`` usage.
>  
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +Host features
> +-------------
> +
> +``ust`` tracing backend
> +-----------------------
> +
> +LTTng can use uprobe tracepoints, therefore it is recommended to use
> +the ``dtrace`` backend instead.

meson.build should call

   warning('ust trace backend is deprecated, use dtrace backend for uprobe support')


if the user requests ust at build time.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


