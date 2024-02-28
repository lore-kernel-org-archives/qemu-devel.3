Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B3DC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIkY-0003Kc-UF; Wed, 28 Feb 2024 07:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfIk6-00039F-0D
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfIjy-0004rC-8n
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709122128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CrLHz7Mdxdz0Y8CUgYDc4Z7fJj/1afhw+Y5Zqw5kDoU=;
 b=btUV7LeJMJ3PGQTl5s6vpgX37XYRfS1vGXjk8ILTlWXmXWe02e5tfB/LJpz5/mlI8/2bUm
 G6iwuvD40VVZs/4jlOEQDSoiqHQc+UPVwiM65AO3cRyNFLNX8yH119XXEAH9aOVOVt1JoF
 wRNsevz0bTBCEmBwWDq1tRrv0hg3DlM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-smFtZx2SN2m8aA8Jcl0I7A-1; Wed, 28 Feb 2024 07:08:46 -0500
X-MC-Unique: smFtZx2SN2m8aA8Jcl0I7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8610385A58C;
 Wed, 28 Feb 2024 12:08:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2510F8173;
 Wed, 28 Feb 2024 12:08:39 +0000 (UTC)
Date: Wed, 28 Feb 2024 12:08:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 stefanha@redhat.com, gmaglione@redhat.com
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
Message-ID: <Zd8iRWHaFqDxSJp2@redhat.com>
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228114759.44758-10-sgarzare@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:47:59PM +0100, Stefano Garzarella wrote:
> Add a new `shm` bool option for `-object memory-backend-file`.
> 
> When this option is set to true, the POSIX shm_open(3) is used instead
> of open(2).
> 
> So a file will not be created in the filesystem, but a "POSIX shared
> memory object" will be instantiated. In Linux this turns into a file
> in /dev/shm, but in other OSes this may not happen (for example in
> macOS or FreeBSD nothing is shown in any filesystem).
> 
> This new feature is useful when we need to share guest memory with
> another process (e.g. vhost-user backend), but we don't have
> memfd_create() or any special filesystems (e.g. /dev/shm) available
> as in macOS.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> I am not sure this is the best way to support shm_open() in QEMU.
> 
> Other solutions I had in mind were:
> 
> - create a new memory-backend-shm
> 
> - extend memory-backend-memfd to use shm_open() on systems where memfd is
> not available (problem: shm_open wants a name to assign to the object, but
> we can do a workaround by using a random name and do the unlink right away)

IMHO, create a new memory-backend-shm, don't overload memory-backend-memfd,
as this lets users choose between shm & memfd, even on Linux.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


