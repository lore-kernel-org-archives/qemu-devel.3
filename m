Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C179CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGSL-00048z-Cu; Thu, 15 Oct 2026 04:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGSJ-00048X-UN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHGSD-0005IV-Fq
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792051484;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDUQP2M8JBDeFsWOhSpt5t1W8MShJh6KYkquaTQyQ0I=;
 b=P48baGakvtS11rotBuUm0eqZNND1RS3O/qDLcgXlsrMgMKFuddacHFHvpg4QGVFk78yrPt
 HZoICn/0HRvPs+rNa2IRz+EdZMofDa6UMJldmkcaJle8Fld5vk5vz5xgFnyzCkfTtPKD2C
 y7i7jXes3StD13S/PK0QBzslC1g8gGY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-VGj7oXhIMEmqzCgrJ-BinQ-1; Thu,
 15 Oct 2026 08:04:38 +0000
X-MC-Unique: VGj7oXhIMEmqzCgrJ-BinQ-1
X-Mimecast-MFC-AGG-ID: VGj7oXhIMEmqzCgrJ-BinQ_1792051477
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C72C1955F14; Thu, 15 Oct 2026 08:04:36 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187A2195608D; Thu, 15 Oct 2026 08:04:29 +0000 (UTC)
Date: Thu, 15 Oct 2026 09:04:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3] treewide: use qemu_dup() instead of dup()
Message-ID: <atCJCs4acmZoss2H@redhat.com>
References: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 15, 2026 at 03:34:43AM +0200, Filip Hejsek wrote:
> Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.
> 
> The only direct users of dup() are now guest syscalls in the user
> emulators and the implementation of qemu_dup() itself.
> 
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
> For each call I replaced, I checked how the resulting fd is used
> afterwards. In summary:
> 
> hw/virtio/virtio.c:
>     the fd is passed to memory_region_init_ram_from_fd, used for mmaping
> 
> io/channel-file.c:
>     the fd is passed to qio_channel_file_new_fd, used for reading/writing
> 
> migration/cpr-exec.c:
>     the cloexec flag is cleared
> 
> qemu-nbd.c:
>     the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO
> 
> system/vl.c:
>     no change in behavior, the code was already setting the cloexec flag
> 
> ui/dmabuf.c:
>     the function is called by qemu_spice_gl_update, which passes the fds
>     to SPICE server
> 
> tests/qtest/bios-tables-test.c:
>     temp dup of stdout, dup2'd back to STDOUT_FILENO
> 
> tests/unit/test-util-sockets.c:
>     one fd is dup'd again and returned from mock monitor_get_fd; another
>     is converted to string and given as address to socket_connect
> 
> tests/unit/test-vmstate.c:
>     passed to qio_channel_file_new_fd to create a channel
> 
> Changes in v3:
> - Also replace the use in migration/cpr-exec.c and the tests
> - Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com
> 
> Changes in v2:
> - Replace the use in qemu-nbd.c too
> - Changed commit message
> - Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
> ---
>  hw/virtio/virtio.c             | 2 +-
>  io/channel-file.c              | 2 +-
>  migration/cpr-exec.c           | 2 +-
>  qemu-nbd.c                     | 2 +-
>  system/vl.c                    | 9 +--------
>  tests/qtest/bios-tables-test.c | 2 +-
>  tests/unit/test-util-sockets.c | 6 +++---
>  tests/unit/test-vmstate.c      | 2 +-
>  ui/dmabuf.c                    | 2 +-
>  9 files changed, 11 insertions(+), 18 deletions(-)


> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index daa50916d2..2f38db30bb 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>      /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
> -    int mfd = dup(fioc->fd);
> +    int mfd = qemu_dup(fioc->fd);
>      char val[16];

This change needed to be:

   int mfd = qemu_dup(fioc->fd);
   qemu_clear_cloexec(fioc->fd);   


If that is added:

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


