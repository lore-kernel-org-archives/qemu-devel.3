Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hQhTG6ph
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhdI-0007Mn-7F; Tue, 10 Nov 2026 03:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQhdG-0007MK-DD
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xQhdD-00066p-Fb
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794300906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0A0R8gj+Nqp+KuhKnI2jNhF/RY7hxOpLEIH3UqMGZ1E=;
 b=hQhTG6ph8jKSt3ROB8lckpNAqHm7gU0Lj/7MSUI+6rcFQAYtXAXnaTWzz2QNjA5xF5ID35
 bAoZqvdpzevz6iE5vvb5AhtkyH5f/qNpSiwva/JcyYx+P7nfZxo994/u2EcZoQ3sddIz35
 JFcIE+EfvL/qJ4LY8/gtcpfBT6Hksj8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-1ZZpwCmdMyqB3_KsNKwilQ-1; Tue,
 10 Nov 2026 03:55:02 -0500
X-MC-Unique: 1ZZpwCmdMyqB3_KsNKwilQ-1
X-Mimecast-MFC-AGG-ID: 1ZZpwCmdMyqB3_KsNKwilQ_1794300901
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FDFE1956060; Tue, 10 Nov 2026 08:55:01 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81D0C3003740; Tue, 10 Nov 2026 08:54:59 +0000 (UTC)
Date: Tue, 10 Nov 2026 08:54:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>
Subject: Re: [PATCH 3/4] virtio-gpu/rutabaga: reject non-32bpp cursor resources
Message-ID: <avLb4ORkQ1Ai_aK2@redhat.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
 <20261110-master-v1-3-7a0505d6c259@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110-master-v1-3-7a0505d6c259@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:31:13PM +0400, Marc-André Lureau wrote:
> The cursor buffer is always 64x64x4, but rutabaga does not check the
> resource format before the transfer read. Gfxstream copies only as many
> bytes as the resource format needs, so an R8_UNORM cursor updates the
> first 4096 bytes of the 16384 byte buffer and leaves the rest untouched,
> while formats with a larger pixel size do not fit the request and fail.
> 
> Refuse cursor resources that are not 32bpp, reusing
> virtio_gpu_get_pixman_format() as the allowlist so the 32bpp formats the
> other backends accept keep working. res->format is the value passed to
> rutabaga_resource_create_3d(), so it matches what gfxstream stores. Blob
> resources carry no format; they were already rejected by the dimension
> check and stay rejected. Log the dimension mismatch and the transfer
> failure as well.
> 
> Fixes: CVE-2026-122027
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
> Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/virtio-gpu-rutabaga.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


