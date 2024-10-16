Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A25D2A52F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16n8-0002wD-0G; Wed, 16 Oct 2024 12:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t16n5-0002w4-GD
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t16n3-0006nr-Id
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729095743;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C4c6wFUNKFXHZ/lZkM6nyU2aNSdwdjLUUzxBGMQQt8=;
 b=GxfEtfTwMrApSGBV6Y9ZWLQZjKu70Nz92rWp+8lqK+TqC8N34Z8OeToc4qC3L5tJYdR4qn
 hPN08llMRp0blcFyBnqPuTRDcjByR6c1bSOb0vHfLc+T3EWWzK60k0oaj1nW/1fmkJe5AQ
 nMuj+WnmxM8U3GqwIZeG+sb4s/dQqIQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-vEl73JoWOyu6CeSjMz7-3Q-1; Wed,
 16 Oct 2024 12:22:19 -0400
X-MC-Unique: vEl73JoWOyu6CeSjMz7-3Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A5F41977024; Wed, 16 Oct 2024 16:22:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AE8E19560A2; Wed, 16 Oct 2024 16:22:15 +0000 (UTC)
Date: Wed, 16 Oct 2024 17:22:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration/dirtyrate: Silence warning about strcpy() on
 OpenBSD
Message-ID: <Zw_oM-RStF4QhWik@redhat.com>
References: <20241016160712.962407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016160712.962407-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 16, 2024 at 06:07:12PM +0200, Thomas Huth wrote:
> The linker on OpenBSD complains:
> 
>  ld: warning: dirtyrate.c:447 (../src/migration/dirtyrate.c:447)(...):
>  warning: strcpy() is almost always misused, please use strlcpy()

Is that the only place it complains ?  We use 'strcpy' in almost
100 places across the codebase....

> It's currently not a real problem in this case since both arrays
> have the same size (256 bytes). But just in case somebody changes
> the size of the source array in the future, let's better play safe
> and use g_strlcpy() here instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  migration/dirtyrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 233acb0855..090c76e934 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -444,7 +444,7 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      info->ramblock_pages = qemu_ram_get_used_length(block) >>
>                             qemu_target_page_bits();
>      info->ramblock_addr = qemu_ram_get_host_addr(block);
> -    strcpy(info->idstr, qemu_ram_get_idstr(block));
> +    g_strlcpy(info->idstr, qemu_ram_get_idstr(block), sizeof(info->idstr));
>  }

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Is it worth also adding

  G_STATIC_ASSERT(sizeof((struct RamblockDirtyInfo){}.idstr) ==
                  sizeof((struct RAMBlock){}.idstr));

at the top of this file, since both of these fields are expected to
be the same size by this code, to avoid truncation.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


