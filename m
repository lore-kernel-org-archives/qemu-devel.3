Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF46DC25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 08:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8FYE-00075a-3A; Sat, 18 May 2024 04:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s8FY5-00073Y-PV
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s8FY3-00048G-EO
 for qemu-devel@nongnu.org; Sat, 18 May 2024 04:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716021369;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCtgce/WDwA6Sy51i+sjJJn85Uewfg3zHH6nUZ2bp5E=;
 b=KeF2nBwNbUf/OStdQUS/HWoyuS2pRFFcjEEPhx9XuxW70HQvHElZDZn7v3T5+gfe0xuJ8G
 +0qVM0Z38Gd9QMDZzYzulKDeMrcMllWZR8eCz7sm7fDETzu0hZKYhWVZcdqw3go0RYNz0n
 HLUnCC1jtPj/UOXaWLfxmOVcsRpaHHc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-V2RJ61fnMgmAM-aY8Oh8YA-1; Sat,
 18 May 2024 04:36:04 -0400
X-MC-Unique: V2RJ61fnMgmAM-aY8Oh8YA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768C029AA2C1;
 Sat, 18 May 2024 08:36:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FDE5200A0B4;
 Sat, 18 May 2024 08:36:03 +0000 (UTC)
Date: Sat, 18 May 2024 09:36:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 8/9] migration: Add support for fdset with multifd + file
Message-ID: <ZkhoYZtrPEtgs1C9@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-9-farosas@suse.de>
 <Zjs9nI_Wgi5UIJba@redhat.com> <ZjvDCA9QvTI-zFf9@x1n>
 <87cypwkpgm.fsf@suse.de> <ZjyD3RHdl-xybOWc@redhat.com>
 <87o794jbzc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o794jbzc.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
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

On Fri, May 17, 2024 at 07:43:35PM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> >
> > The only caller of monitor_fdset_dup_fd_add is qemu_open_internal
> > and that has a "Error **errp" parameter.  We should rewrite
> > monitor_fdset_dup_fd_add to also have an "Error **errp" at which
> > point we can actually report useful, actionable error messages
> > from it. Errnos be gone !
> 
> I can do that, but qemu_open_old() does not pass the error in. Please
> see if this works for you:
> 
> -->8--
> From 16e333cc5aeca1fab3f75f79048c0ab0d62d5b08 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Fri, 17 May 2024 19:30:39 -0300
> Subject: [PATCH] io: Stop using qemu_open_old in channel-file
> 
> We want to make use of the Error object to report fdset errors from
> qemu_open_internal() and passing the error pointer to qemu_open_old()
> would require changing all callers. Move the file channel to the new
> API instead.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  io/channel-file.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/io/channel-file.c b/io/channel-file.c
> index 6436cfb6ae..2ea8d08360 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -68,11 +68,13 @@ qio_channel_file_new_path(const char *path,
>  
>      ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
>  
> -    ioc->fd = qemu_open_old(path, flags, mode);
> +    if (flags & O_CREAT) {
> +        ioc->fd = qemu_create(path, flags & ~O_CREAT, mode, errp);
> +    } else {
> +        ioc->fd = qemu_open(path, flags, errp);
> +    }
>      if (ioc->fd < 0) {
>          object_unref(OBJECT(ioc));
> -        error_setg_errno(errp, errno,
> -                         "Unable to open %s", path);
>          return NULL;
>      }

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


