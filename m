Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26094D0E6C7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrBM-0002x1-Ka; Tue, 25 Nov 2025 06:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vNrB7-0002ry-7C
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vNrB3-00061R-33
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764069942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaJ1fjXvEaOH2Zur89dMYlyW9B7jikufbkMJcB7OxTQ=;
 b=Hfr2j0LWRkTZrzPuPYQA5z8y9xkhbBipzVs0YCaqwAqjh448uYVYoSKda2ynTx62EeZ4TT
 vl9rUyaS7vgUr9ZTy7o+EKwr/LUQeVXEN4k0jpzrI30gRW0jaAlrvUPxgckByRbbu2bFtn
 U6TVM172EtW7niagLQ6Rtg/VbIEUlkE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-3V0nEY_vN4iYEjlXgScoIg-1; Tue,
 25 Nov 2025 06:25:38 -0500
X-MC-Unique: 3V0nEY_vN4iYEjlXgScoIg-1
X-Mimecast-MFC-AGG-ID: 3V0nEY_vN4iYEjlXgScoIg_1764069937
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56B4D195606D; Tue, 25 Nov 2025 11:25:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77133180049F; Tue, 25 Nov 2025 11:25:35 +0000 (UTC)
Date: Tue, 25 Nov 2025 11:25:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 peter.maydell@linaro.org
Subject: Re: g_autoptr(Error) (was: [PATCH] migration: Fix double-free on
 error path)
Message-ID: <aSWSLMi6ZhTCS_p2@redhat.com>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871plmk1bc.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 25, 2025 at 08:40:07AM +0100, Markus Armbruster wrote:
> g_autoptr(T) is quite useful when the object's extent matches the
> function's.
> 
> This isn't the case for an Error object the function propagates to its
> caller.  It is the case for an Error object the function reports or
> handles itself.  However, the functions to report Error also free it.
> 
> Thus, g_autoptr(Error) is rarely applicable.  We have just three
> instances out of >1100 local Error variables, all in migration code.
> 
> Two want to move the error to the MigrationState for later handling /
> reporting.  Since migrate_set_error() doesn't move, but stores a copy,
> the original needs to be freed, and g_autoptr() is correct there.  We
> have 17 more that instead manually free with error_free() or
> error_report_err() right after migrate_set_error().
> 
> We recently discussed storing a copy vs. move the original:
> 
>     From: Peter Xu <peterx@redhat.com>
>     Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
>     Date: Mon, 17 Nov 2025 11:03:37 -0500
>     Message-ID: <aRtHWbWcTh3OF2wY@x1.local>
> 
> The two g_autoptr() gave me pause when I investigated this topic, simply
> because they deviate from the common pattern migrate_set_error(s, err)
> followed by error_free() or error_report_err().
> 
> The third one became wrong when I cleaned up the reporting (missed in
> the cleanup patch, fixed in the patch I'm replying to).  I suspect my
> mistake escaped review for the same reason I made it: g_autoptr(Error)
> is unusual and not visible in the patch hunk.
> 
> Would you like me to replace the two correct uses of g_autoptr(Error) by
> more common usage?

I had previously proposed g_autoptr(Error) a year or two back and you
rejected it then, so I'm surprised to see that it got into the code,
because it requires explicit opt-in via a G_DEFINE_AUTOPTR_CLEANUP_FUNC.

Unfortunately it appears exactly that was added earlier this year in

  commit 18eb55546a54e443d94a4c49286348176ad4b00a
  Author: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
  Date:   Tue Mar 4 23:03:35 2025 +0100

    error: define g_autoptr() cleanup function for the Error type
    
    Automatic memory management helps avoid memory safety issues.
    
    Reviewed-by: Peter Xu <peterx@redhat.com>
    Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
    Link: https://lore.kernel.org/qemu-devel/a5843c5fa64d7e5239a4316092ec0ef0d10c2320.1741124640.git.maciej.szmigiero@oracle.com
    Signed-off-by: Cédric Le Goater <clg@redhat.com>


When removing this usage, ensure that commit is reverted too, which
will prevent anyone unwittingly re-introducing g_autoptr(Error)
usage

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


