Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE1C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgUa-0005yP-TK; Tue, 14 Jul 2026 13:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjgUY-0005xy-UD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjgUV-00031J-HX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784048417;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6ZMmlZvPwhoyRKz+TUHe6xD3Aa5e65XIYN7AXEmxuk=;
 b=bn2ktuDnWd6t9e38KdFFrNTAZf+xSAqigif9OD0fr+0+rwYg2sCw2OdY31wAoPonLxS5On
 x7Ta0sBjlNDRh25esZfpmdiQkpHUhARb/hR7or/PO9SuTOgXuiIknKmurzBR6bUYWburJO
 7PXG5TjJomrZEa7rpAW+b6K9qnBPJf4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-n4gEYWWGOk6JrVPfCRfWig-1; Tue,
 14 Jul 2026 13:00:14 -0400
X-MC-Unique: n4gEYWWGOk6JrVPfCRfWig-1
X-Mimecast-MFC-AGG-ID: n4gEYWWGOk6JrVPfCRfWig_1784048413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7132F180044D; Tue, 14 Jul 2026 17:00:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A407930002DA; Tue, 14 Jul 2026 17:00:10 +0000 (UTC)
Date: Tue, 14 Jul 2026 18:00:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3] qga: implement 'guest-get-fsinfo' for FreeBSD
Message-ID: <alZrF6CkX1YRK2D0@redhat.com>
References: <20260714165759.7521-1-bogorodskiy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714165759.7521-1-bogorodskiy@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 06:57:59PM +0200, Roman Bogorodskiy wrote:
> Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> To implement it, reuse build_fs_mount_list() which is already
> implemented for FreeBSD. Extend the FsMount type to include
> a string "fromname" attribute to store the disk the FS is mounted from.
> 
> Disk mapping info is not covered by this implementation.
> 
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
> Changes since v1:
> 
>  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
> 
> Changes since v2:
> 
>  - Drop the unused 'errp' argument to build_guest_fsinfo() and
>    clean up the related code.
>  - Fix leaking string through g_strdup() for a g_path_get_basename()
>    allocated string.
> 
>  qga/commands-bsd.c    | 53 ++++++++++++++++++++++++++++++++++++++++++-
>  qga/commands-common.h |  1 +
>  qga/commands-posix.c  |  3 +++
>  qga/qapi-schema.json  | 12 +++++-----
>  4 files changed, 62 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


