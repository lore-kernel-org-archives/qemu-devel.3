Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4DBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjadg-0003SU-1J; Tue, 14 Jul 2026 06:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjadc-0003RV-5C
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjadZ-0002l0-9j
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784025915;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AFe7hA/WBYZiHIqyws4irmWoehXOPCA1w38n98SUMJ0=;
 b=DGFouVuqUr1F5pNtKjDXVC8VbI9Az8PYbrTiWF+0dLCLf7cEs5AIoJ4YBVlEnrBJXbzugl
 6aHw+8gX7oszEwtF6rGkNj7ELBd4+1zJxK/XR8lQoea4QnXnjFWzFDTJaRcNuuRhyoTqOe
 mwo3rAuWzwvjmawhuz97siruwSEbq9k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-iMawf5pDPQ2OndDa9bsfKw-1; Tue,
 14 Jul 2026 06:45:12 -0400
X-MC-Unique: iMawf5pDPQ2OndDa9bsfKw-1
X-Mimecast-MFC-AGG-ID: iMawf5pDPQ2OndDa9bsfKw_1784025911
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FBFA195604D; Tue, 14 Jul 2026 10:45:11 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D170A765; Tue, 14 Jul 2026 10:45:08 +0000 (UTC)
Date: Tue, 14 Jul 2026 11:45:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] qga: implement 'guest-get-fsinfo' for FreeBSD
Message-ID: <alYTMRfaGKKri3Lr@redhat.com>
References: <20260703163107.46469-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703163107.46469-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 03, 2026 at 06:31:07PM +0200, Roman Bogorodskiy wrote:
> Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> To implement it, reuse build_fs_mount_list() which is already
> implemented for FreeBSD. Extend the FsMount type to include
> a string "fromname" attribute to store the disk the FS is mounted from.
> 
> Disk mapping info is not covered by this implementation.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> Changes since v1:
> 
>  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
> 
> 
>  qga/commands-bsd.c    | 62 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-common.h |  1 +
>  qga/commands-posix.c  |  3 +++
>  qga/qapi-schema.json  | 12 ++++-----
>  4 files changed, 71 insertions(+), 7 deletions(-)
> 

> +#if defined(__FreeBSD__)
> +static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
> +                                               Error **errp)

Nothing ever sets 'errp' so this method cannot fail. Drop this
parameter.

> +{
> +    GuestFilesystemInfo *fs = g_new0(GuestFilesystemInfo, 1);
> +    struct statvfs buf;
> +    unsigned long used, nonroot_total, fr_size;
> +
> +    fs->mountpoint = g_strdup(mount->dirname);
> +    fs->type = g_strdup(mount->devtype);
> +    fs->name = g_strdup(g_path_get_basename(mount->fromname));

Memoory leak - g_path_get_basename already returns a new heap
allocated string, so drop the g_strdup:

  https://docs.gtk.org/glib/func.path_get_basename.html

> +
> +    if (statvfs(fs->mountpoint, &buf) == 0) {
> +        fr_size = buf.f_frsize;
> +        used = buf.f_blocks - buf.f_bfree;
> +        nonroot_total = used + buf.f_bavail;
> +        fs->used_bytes = used * fr_size;
> +        fs->total_bytes = nonroot_total * fr_size;
> +        fs->total_bytes_privileged = buf.f_blocks * fr_size;
> +
> +        fs->has_total_bytes = true;
> +        fs->has_total_bytes_privileged = true;
> +        fs->has_used_bytes = true;
> +    }
> +
> +    return fs;
> +}
> +
> +GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
> +{
> +    FsMountList mounts;
> +    struct FsMount *mount;
> +    GuestFilesystemInfoList *ret = NULL;
> +    Error *local_err = NULL;
> +
> +    QTAILQ_INIT(&mounts);
> +    if (!build_fs_mount_list(&mounts, &local_err)) {
> +        error_propagate(errp, local_err);

Pointless use of local_err - pass errp and drop error_propagate

> +        return NULL;
> +    }
> +
> +    QTAILQ_FOREACH(mount, &mounts, next) {
> +        g_debug("Building guest fsinfo for '%s'", mount->dirname);
> +
> +        QAPI_LIST_PREPEND(ret, build_guest_fsinfo(mount, &local_err));
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            qapi_free_GuestFilesystemInfoList(ret);
> +            ret = NULL;
> +            break;
> +        }

build_guest_fsinfo cannot fail so this branch is dead code, which
means local_err can be entirely dropped.

> +    }
> +
> +    free_fs_mount_list(&mounts);
> +    return ret;
> +}
> +#endif /* __FreeBSD__ */

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


