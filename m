Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA53C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdPg-0000ca-F1; Tue, 19 Mar 2024 13:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmdPe-0000cA-4o
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmdPc-0002rn-Aw
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710869886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=K7o2MaO98RAsRhnkjTikqityBGgP2UNvSJGEvX8bnTw=;
 b=G3nlMuMt6D1uFSjir27hw8PcYyYXyvH7Ggm3C8GTFuBGwI6V4p25VHERG9OdYh9a9XHl0Q
 tkd/EX13yR7vrFatjJqWbsU2VMMZZFQFYMznM/i58MstyvUBzDcEjSM2tEcfU/zMZ1kkU4
 CMNcLyh51xpUaQ5DmJUbXl27b5O0fPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-6IZDkwDlOCyd06e-rsCcqA-1; Tue, 19 Mar 2024 13:37:58 -0400
X-MC-Unique: 6IZDkwDlOCyd06e-rsCcqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E51DE80026D;
 Tue, 19 Mar 2024 17:37:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4EA410F53;
 Tue, 19 Mar 2024 17:37:56 +0000 (UTC)
Date: Tue, 19 Mar 2024 17:37:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Subject: Re: [PATCH v3 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-root' field
Message-ID: <ZfnNbpubB0HpFDnj@redhat.com>
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
 <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Fri, Mar 15, 2024 at 02:29:40PM +0200, Andrey Drobyshev wrote:
> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
> returned by statvfs(3).  While on Windows guests that's all we can get
> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
> total file system size, as it's visible for root user.  Let's add an
> optional field 'total-bytes-root' to GuestFilesystemInfo struct, which'd
> only be reported on POSIX and represent f_blocks value as returned by
> statvfs(3).
> 
> While here, let's document better where those values come from in both
> POSIX and Windows.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c |  2 ++
>  qga/commands-win32.c |  1 +
>  qga/qapi-schema.json | 12 +++++++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 26008db497..8207c4c47e 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>          nonroot_total = used + buf.f_bavail;
>          fs->used_bytes = used * fr_size;
>          fs->total_bytes = nonroot_total * fr_size;
> +        fs->total_bytes_root = buf.f_blocks * fr_size;
>  
>          fs->has_total_bytes = true;
> +        fs->has_total_bytes_root = true;
>          fs->has_used_bytes = true;
>      }
>  
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index a1015757d8..9e820aad8d 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
>      fs = g_malloc(sizeof(*fs));
>      fs->name = g_strdup(guid);
>      fs->has_total_bytes = false;
> +    fs->has_total_bytes_root = false;

Can we use GetDiskSpaceInformationA to return this information
on Windows ? In contrast to GetDiskFreeSpaceExA(), the
DISK_SPACE_INFORMATION struct details both the real sizes
and the current user available sizes.

>      fs->has_used_bytes = false;
>      if (len == 0) {
>          fs->mountpoint = g_strdup("System Reserved");
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b8efe31897..093a5ab602 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1031,8 +1031,18 @@
>  # @type: file system type string
>  #
>  # @used-bytes: file system used bytes (since 3.0)
> +#     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by statvfs(3)
> +#     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as returned
> +#       by GetDiskFreeSpaceEx()
>  #
>  # @total-bytes: non-root file system total bytes (since 3.0)
> +#     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
> +#       statvfs(3)
> +#     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
> +#
> +# @total-bytes-root: total file system size in bytes (as visible for a
> +#     priviledged user) (since 8.3)
> +#     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)

I tend to wonder whether it is really a good idea to document
our specific implementation details in the public API

I might suggest

  @total-bytes: filesystem capacity in bytes for unprivileged users
  @total-bytes-root: filesystem capacity in bytes for privileged users

also should we call it 'total-bytes-privilegd', to avoid UNIX specific
terminology.

>  #
>  # @disk: an array of disk hardware information that the volume lies
>  #     on, which may be empty if the disk type is not supported
> @@ -1042,7 +1052,7 @@
>  { 'struct': 'GuestFilesystemInfo',
>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
> -           'disk': ['GuestDiskAddress']} }
> +           '*total-bytes-root': 'uint64', 'disk': ['GuestDiskAddress']} }
>  
>  ##
>  # @guest-get-fsinfo:
> -- 
> 2.39.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


