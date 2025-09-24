Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A869CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ltz-0008CV-8O; Wed, 24 Sep 2025 05:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Ltj-0007xp-7b
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1Ltc-0005ea-QI
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706482;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAmc7ng1DshMG3byOC3I+oWPKZYVKD/Ui3WzD+LV9Sk=;
 b=eup8K2IsO09F5MW/7Ligxc8MpZ4WtugP2JsTzkvtqtrn/IU4hDveYYAlaIPPK+5RiRj9ab
 G1tOSrdC0WgUwdWkgu+0GShgdPcvf6ZWjpRxqUTY3m6HHI9wlajsa7AlaugQ6TPN9YALM/
 2kRf1DH6TA81zVPFevG2Xwvd5Izc2q0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-OYOoNe9pPcWkM_PtiZ9XWQ-1; Wed,
 24 Sep 2025 05:34:41 -0400
X-MC-Unique: OYOoNe9pPcWkM_PtiZ9XWQ-1
X-Mimecast-MFC-AGG-ID: OYOoNe9pPcWkM_PtiZ9XWQ_1758706480
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B6C619560B2; Wed, 24 Sep 2025 09:34:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.136])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 887361800451; Wed, 24 Sep 2025 09:34:36 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:34:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: alessandro.ratti@gmail.com, alex.bennee@linaro.org, armbru@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] virtio: improve virtqueue mapping error messages
Message-ID: <aNO7J7Y6wsk1-wyw@redhat.com>
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
 <20250924093138.559872-2-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924093138.559872-2-alessandro@0x65c.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 24, 2025 at 11:14:04AM +0200, Alessandro Ratti wrote:
> Improve error reporting when virtqueue ring mapping fails by including a
> device identifier in the error message.
> 
> Introduce a helper qdev_get_printable_name() in qdev-core, which returns
> either:
> 
>  - the device ID, if explicitly provided (e.g. -device ...,id=foo)
>  - the QOM path from qdev_get_dev_path(dev) otherwise
>  - "<unknown device>" as a fallback when no identifier is present
> 
> This makes it easier to identify which device triggered the error in
> multi-device setups or when debugging complex guest configurations.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  hw/core/qdev.c         | 29 +++++++++++++++++++++++++++++
>  hw/virtio/virtio.c     | 15 ++++++++++++---
>  include/hw/qdev-core.h |  1 +
>  3 files changed, 42 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


