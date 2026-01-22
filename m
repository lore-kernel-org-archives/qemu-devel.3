Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46563C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqPM-000333-6j; Thu, 22 Jan 2026 03:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viqPJ-0002zN-0y
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viqPH-0005aq-6w
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769071869;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=E8Jc1QOWL6iUotbwLC20csta9iLeBwR6U68lhti3PzM=;
 b=e7Uzu+cgCKgZY4IfL48+BOO7g+ZvN8Dnw7IAp2VepJtBOEWzI+aSL62TlGR9504dCB9XYh
 P2RsCeeNt0R+czwvBCkIeXnXinIoun+OaLzEYuFJ3rsAysO8XjY1eth8FSNpRRbtGT+pRZ
 dGaICzzNc3vaKzKJ/OF69KRLv54CAls=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-d1fSDcL-PqS0MrkssqDsVQ-1; Thu,
 22 Jan 2026 03:51:05 -0500
X-MC-Unique: d1fSDcL-PqS0MrkssqDsVQ-1
X-Mimecast-MFC-AGG-ID: d1fSDcL-PqS0MrkssqDsVQ_1769071865
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95CFC18005AF; Thu, 22 Jan 2026 08:51:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF68218004D8; Thu, 22 Jan 2026 08:51:02 +0000 (UTC)
Date: Thu, 22 Jan 2026 08:50:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wei Wang <wei.wang@smartx.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com
Subject: Re: [PATCH] qga: Fix crash due to redundant error setting in
 qmp_guest_file_open()
Message-ID: <aXHk8wPrQe6VLW-C@redhat.com>
References: <20260122040430.51001-1-wei.wang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122040430.51001-1-wei.wang@smartx.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Jan 22, 2026 at 12:04:30PM +0800, Wei Wang wrote:
> Avoid setting GError multiple times in qmp_guest_file_open() by checking
> if errp is already set.
> This prevents crash caused by repeated error handling calls.
> 
> Signed-off-by: Wei Wang <wei.wang@smartx.com>
> ---
>  qga/commands-win32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 0fd0c966e4..8c45ca5004 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -263,7 +263,9 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
>      fd = guest_file_handle_add(fh, errp);
>      if (fd < 0) {
>          CloseHandle(fh);
> -        error_setg(errp, "failed to add handle to qmp handle table");
> +        if (!*errp) {
> +            error_setg(errp, "failed to add handle to qmp handle table");
> +        }

guest_file_handle_add() only returns -1 when qga_get_fd_handle
returns -1, and qga_get_fd_handle always sets errp.

Therefore, your new conditional call to error_setg will never be
executed; remove it entirely.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


