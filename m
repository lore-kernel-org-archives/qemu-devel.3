Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9EFC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncJB-0003Th-DI; Fri, 22 Mar 2024 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rncJA-0003TP-0d
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rncJ8-0002it-7n
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711103969;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IeI2zG0UgvTEQRsPuKc8KH8h60Dxviv3x/YY/wARwd4=;
 b=b/KmRgxEMZkyXAllVjV5TrioXWaxbxi3Cb23PD3QHd5YsL6u0LcgIAQsSO3p6hcou/S5tb
 S7W+o6sgbThSkTSiTBWmeYonaxNKuL1ckKP24EOmJBE7GfwVckq9lLW2jZz9KLmgzL8SIV
 hQchKat8K5FImeVgpYu1xWQBwsFwBYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-NxoCXq89Mj6owySmTvP_LA-1; Fri, 22 Mar 2024 06:39:26 -0400
X-MC-Unique: NxoCXq89Mj6owySmTvP_LA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF1B8A5E2A;
 Fri, 22 Mar 2024 10:39:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1689492BC6;
 Fri, 22 Mar 2024 10:39:24 +0000 (UTC)
Date: Fri, 22 Mar 2024 10:39:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org, den@virtuozzo.com
Subject: Re: [PATCH v4 1/7] qga: guest-get-fsinfo: add optional
 'total-bytes-privileged' field
Message-ID: <Zf1f1yajMqqF6G6t@redhat.com>
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
 <20240320161648.158226-2-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320161648.158226-2-andrey.drobyshev@virtuozzo.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

On Wed, Mar 20, 2024 at 06:16:42PM +0200, Andrey Drobyshev wrote:
> Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
> GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
> used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
> returned by statvfs(3).  While on Windows guests that's all we can get
> with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
> total file system size, as it's visible for root user.  Let's add an
> optional field 'total-bytes-privileged' to GuestFilesystemInfo struct,
> which'd only be reported on POSIX and represent f_blocks value as returned
> by statvfs(3).
> 
> While here, also tweak the docs to reflect better where those values
> come from.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qga/commands-posix.c | 2 ++
>  qga/commands-win32.c | 1 +
>  qga/qapi-schema.json | 7 +++++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 26008db497..7df2d72e9f 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
>          nonroot_total = used + buf.f_bavail;
>          fs->used_bytes = used * fr_size;
>          fs->total_bytes = nonroot_total * fr_size;
> +        fs->total_bytes_privileged = buf.f_blocks * fr_size;
>  
>          fs->has_total_bytes = true;
> +        fs->has_total_bytes_privileged = true;
>          fs->has_used_bytes = true;
>      }
>  
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 6242737b00..6fee0e1e6f 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
>      fs = g_malloc(sizeof(*fs));
>      fs->name = g_strdup(guid);
>      fs->has_total_bytes = false;
> +    fs->has_total_bytes_privileged = false;
>      fs->has_used_bytes = false;
>      if (len == 0) {
>          fs->mountpoint = g_strdup("System Reserved");
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 9554b566a7..dcc469b268 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1026,7 +1026,10 @@
>  #
>  # @used-bytes: file system used bytes (since 3.0)
>  #
> -# @total-bytes: non-root file system total bytes (since 3.0)
> +# @total-bytes: filesystem capacity in bytes for unprivileged users (since 3.0)
> +#
> +# @total-bytes-privileged: filesystem capacity in bytes for privileged users
> +#     (since 9.0)

Will need to be '9.1', not '9.0', since we don't accept new features
during freeze periods.

>  #
>  # @disk: an array of disk hardware information that the volume lies
>  #     on, which may be empty if the disk type is not supported
> @@ -1036,7 +1039,7 @@
>  { 'struct': 'GuestFilesystemInfo',
>    'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
>             '*used-bytes': 'uint64', '*total-bytes': 'uint64',
> -           'disk': ['GuestDiskAddress']} }
> +           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']} }
>  
>  ##
>  # @guest-get-fsinfo:

Assuming the version is changed:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


