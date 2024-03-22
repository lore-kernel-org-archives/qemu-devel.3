Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A9EC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbw6-0002O4-OZ; Fri, 22 Mar 2024 06:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rnbw4-0002Ne-9v
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rnbvx-0006UW-3V
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711102530;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pKjoGa7MNjQAIjUIOzId8mG/lCU8qzeXVEZOpXC+UKo=;
 b=Y+0S55EIUqlkPgye/GBbP041AkM3tnMFNfZFCtvuzCE1oaFYzrfNxIQ6lzBgostxZeeHNI
 5lNWgJkw9DmvMrnJaek+jNiAIK2xshn28olkJvS8OD16fYe8o3CNEBekIim6SMTE26b9id
 qLt//gaTGvqX2yJrtZ/16Gp5f1bZ+3U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-S4U15F7vPJKXuw1BnIqNSw-1; Fri,
 22 Mar 2024 06:15:26 -0400
X-MC-Unique: S4U15F7vPJKXuw1BnIqNSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 372DC1C0170D;
 Fri, 22 Mar 2024 10:15:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7EFE492BC9;
 Fri, 22 Mar 2024 10:15:25 +0000 (UTC)
Date: Fri, 22 Mar 2024 10:15:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: aidan_leuck@selinc.com
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com
Subject: Re: [PATCH v2 2/2] Refactor common functions between POSIX and
 Windows implementation
Message-ID: <Zf1aN16SJbFqzMJb@redhat.com>
References: <20240321160725.340341-1-aidan_leuck@selinc.com>
 <20240321160725.340341-3-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240321160725.340341-3-aidan_leuck@selinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 21, 2024 at 04:07:25PM +0000, aidan_leuck@selinc.com wrote:
> From: aidaleuc <aidan_leuck@selinc.com>
> 
> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
> ---
>  qga/commands-posix-ssh.c   | 47 +--------------------------
>  qga/commands-ssh-core.c    | 57 ++++++++++++++++++++++++++++++++
>  qga/commands-ssh-core.h    |  8 +++++
>  qga/commands-windows-ssh.c | 66 +-------------------------------------
>  qga/meson.build            |  3 +-
>  5 files changed, 69 insertions(+), 112 deletions(-)
>  create mode 100644 qga/commands-ssh-core.c
>  create mode 100644 qga/commands-ssh-core.h

Moving of existing functions into a common file should
be the *first* patch in the series, rather than copying
functions into the windows impl only to immediately
remove them again.

> diff --git a/qga/commands-ssh-core.c b/qga/commands-ssh-core.c
> new file mode 100644
> index 0000000000..51353b396d
> --- /dev/null
> +++ b/qga/commands-ssh-core.c

> \ No newline at end of file

Again, please ensure all files retain a final newline in the file.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


