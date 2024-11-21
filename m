Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD50D6E2CA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 10:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE4Ln-0006Dh-AJ; Thu, 21 Nov 2024 05:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4Ld-0006BS-Tv
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE4LR-0002YS-Jn
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 05:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732184606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PZKsWgosnOTgGkEfng6XkceWz3U4whhl0ZVd9xhBEXo=;
 b=Mbp2gWGjKI7w0d9LprJCZyXdE/2TpoCEMP96YNLwPHoHr61WxtD/ZK5ogn9xL2zEUFK4bo
 cl+VzmwtWYgAmvPhjqspivRvlMNBr3wnsVOG/EltMn9d8e+k2Cq0KTmrn9uEA7ENVdO1Xt
 Fa967LGfpzssHpyzaEyJAqH7JzxESm0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-qzu1sfZdMh-20VaODhw1jw-1; Thu,
 21 Nov 2024 05:23:23 -0500
X-MC-Unique: qzu1sfZdMh-20VaODhw1jw-1
X-Mimecast-MFC-AGG-ID: qzu1sfZdMh-20VaODhw1jw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E851955F77; Thu, 21 Nov 2024 10:23:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 265031955E99; Thu, 21 Nov 2024 10:23:17 +0000 (UTC)
Date: Thu, 21 Nov 2024 10:23:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 09/12] qdev: Add machine_get_container()
Message-ID: <Zz8KEg3f5u5Z_1bw@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120215703.3918445-10-peterx@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 20, 2024 at 04:57:00PM -0500, Peter Xu wrote:
> Add a helper to fetch machine containers.  Add some sanity check around.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/hw/qdev-core.h | 10 ++++++++++
>  hw/core/qdev.c         | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 5be9844412..38edfb1b54 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -996,6 +996,16 @@ const char *qdev_fw_name(DeviceState *dev);
>  void qdev_assert_realized_properly(void);
>  Object *qdev_get_machine(void);
>  
> +/**
> + * machine_get_container:
> + * @name: The name of container to lookup
> + *
> + * Get a container of the machine (QOM path "/machine/XXX").
> + *
> + * Returns: the machine container object.
> + */
> +Object *machine_get_container(const char *name);
> +
>  /**
>   * qdev_get_human_name() - Return a human-readable name for a device
>   * @dev: The device. Must be a valid and non-NULL pointer.
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c869c47a27..6cb4fe4691 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -829,6 +829,23 @@ Object *qdev_get_machine(void)
>      return dev;
>  }
>  
> +Object *machine_get_container(const char *name)
> +{
> +    Object *container, *machine;
> +
> +    /*
> +     * NOTE: nobody should call this _before_ machine is created.  If it
> +     * happens, it's a programming error.
> +     */
> +    machine = qdev_get_machine();
> +    assert(machine);

IMHO this assert should be in  qdev_get_machine() itself any
premature call of it is a programming error.

> +
> +    container = object_resolve_path_component(machine, name);
> +    assert(object_dynamic_cast(container, TYPE_CONTAINER));
> +
> +    return container;
> +}
> +
>  char *qdev_get_human_name(DeviceState *dev)
>  {
>      g_assert(dev != NULL);
> -- 
> 2.45.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


