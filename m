Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3490C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVo6-0007ow-Hi; Fri, 08 Mar 2024 03:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riVo4-0007oJ-Kn
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riVo1-0004yQ-4o
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709887336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mHoCI7HR7epTmwUO5oBzQnEGpfByQ4DgEOE1WWZH3Jg=;
 b=M6utAfauic+kZ9GUEbEg+YZmWj5Ap33XE4cOdo9dQ8noTey+mSz0fOEtQGXH8cWIWS5PM9
 Jinfrkq3TRiN0YjaEX8dcdcsjkzREHXycbAUPKfZqUKclEkgh3BxIPl9bUE5lshoJE5wp4
 yHPJXe+FROOv5asEXe93vKhetTPunXA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-MFm7Znc3MSaJe9R1Mq3lqA-1; Fri, 08 Mar 2024 03:42:12 -0500
X-MC-Unique: MFm7Znc3MSaJe9R1Mq3lqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 284C88F1F17;
 Fri,  8 Mar 2024 08:42:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8034B10E4F;
 Fri,  8 Mar 2024 08:42:10 +0000 (UTC)
Date: Fri, 8 Mar 2024 08:42:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 kraxel@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
Message-ID: <ZerPYH7KkLpmgTEV@redhat.com>
References: <ZemO6VnxhuRI-7c5@redhat.com>
 <20240308033827.2835989-1-justinien.bouron@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240308033827.2835989-1-justinien.bouron@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 07, 2024 at 07:38:27PM -0800, Justinien Bouron wrote:
> > This last two lines doesn't make sense to me. Isn't the grab
> > toggling entirely in control of the QEMU process, regardless
> > of what state the guest is at ?
> 
> Actually, you're right, they do not make sense. This issue of having the guest
> taking a while to start and the toggle keys not working, only seem to appear
> when running the VM under libvirt. I was not able to reproduce this issue when
> running qemu directly from the command line. So either this is a libvirt issue
> or something related to my setup (VFIO with GPU passthrough, so a lot can go
> wrong).
> 
> Should I send a new version of the patch with an updated commit message that
> does not mention this issue?

If that probem does not exist, what is the compelling reason to
add this patch ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


