Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1BFCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKUB-0006qC-MT; Tue, 19 Aug 2025 07:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKU8-0006fn-OK
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoKU4-0007XQ-ST
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602791;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uHY8mNYdKDbxOW+I7HiKNONtB9F8GWoyDihgaxYOkfs=;
 b=CTBCQ67YpSWHo8uIqZNbKDQW+mN1PQglgJa9b12E85+buidilrujXuSKUIBQWnVc8Ngvf6
 rgv43i2dLXCCGOL1gWKDqWenVoTy7Dnn1nT/DMmfWQs5wlk1Wedwd9M5UeeQJrdzCA8XZy
 ZWN9E2u/KbIn5FvmRSxZokBT1byW0SQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-ufo8siYtNziqKMl_7b_gbQ-1; Tue,
 19 Aug 2025 07:26:27 -0400
X-MC-Unique: ufo8siYtNziqKMl_7b_gbQ-1
X-Mimecast-MFC-AGG-ID: ufo8siYtNziqKMl_7b_gbQ_1755602787
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3E84180036E; Tue, 19 Aug 2025 11:26:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B93019560B2; Tue, 19 Aug 2025 11:26:25 +0000 (UTC)
Date: Tue, 19 Aug 2025 12:26:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 12/12] error: Kill @error_warn
Message-ID: <aKRfXdh-bclOVVyb@redhat.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808080823.2638861-13-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 08, 2025 at 10:08:23AM +0200, Markus Armbruster wrote:
> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
> add global &error_warn destination).  It has multiple issues:
> 
> * error.h's big comment was not updated for it.
> 
> * Function contracts were not updated for it.
> 
> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>   error_prepend() and such.  These crash on @error_warn, as pointed
>   out by Akihiko Odaki.
> 
> All fixable.  However, after more than two years, we had just of 15
> uses, of which the last few patches removed eight as unclean or
> otherwise undesirable.  I didn't look closely enough at the remaining
> seven to decide whether they are desirable or not.
> 
> I don't think this feature earns its keep.  Drop it.
> 
> Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/error.h           |  6 ------
>  hw/display/virtio-gpu.c        |  8 ++++++--
>  hw/net/virtio-net.c            |  8 +++++++-
>  tests/unit/test-error-report.c | 17 -----------------
>  ui/gtk.c                       |  6 +++++-
>  util/error.c                   |  5 +----
>  6 files changed, 19 insertions(+), 31 deletions(-)

> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6b5b5dace3..7848e26278 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1289,6 +1289,8 @@ exit:
>  
>  static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
>  {
> +    Error *err = NULL;
> +
>      if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
>          return true;
>      }
> @@ -1306,7 +1308,11 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
>          return virtio_net_load_ebpf_fds(n, errp);
>      }
>  
> -    ebpf_rss_load(&n->ebpf_rss, &error_warn);
> +    ebpf_rss_load(&n->ebpf_rss, &err);
> +    /* Beware, ebpf_rss_load() can return false with @err unset */

Per our other mail, this is a bug we should fix

> +    if (err) {
> +        warn_report_err(err);
> +    }
>      return true;
>  }
>  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


