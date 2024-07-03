Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxmz-0003H9-30; Wed, 03 Jul 2024 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOxmo-0003Ff-LP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOxmm-0005tW-Hv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720004666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1N1fE7vZbDbXz8dg3BiSv/FQC0BrWP+p889kkH3aPaw=;
 b=PvulyiMYa8EXfwtgNFVvP4oJwPAhscb6UYJm9Ff8sLOGjfBymWrFW6bGVM5dUr2UZrKue5
 q+GaN5jlEzKlPwTZED7cJ1il3dEqYYl9TE23eMoEIrCwkrOG/FL6cYhoQY/kV++mdjZE+d
 D2REJRUpUENZzlLSClxpXGxMwfxQLSc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-clnleiOFMZ-MDChKyUF1Cg-1; Wed,
 03 Jul 2024 07:04:25 -0400
X-MC-Unique: clnleiOFMZ-MDChKyUF1Cg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 047491955BC0; Wed,  3 Jul 2024 11:04:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C65E195607C; Wed,  3 Jul 2024 11:04:21 +0000 (UTC)
Date: Wed, 3 Jul 2024 12:04:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH 1/2] qdev: change qdev_prop_set_globals() to use Object*
Message-ID: <ZoUwMr1X170aQNDS@redhat.com>
References: <20240703094626.1704990-1-dbarboza@ventanamicro.com>
 <20240703094626.1704990-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703094626.1704990-2-dbarboza@ventanamicro.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 03, 2024 at 06:46:25AM -0300, Daniel Henrique Barboza wrote:
> Next patch will add Accel globals support and will use
> qdev_prop_set_globals().
> 
> At this moment this function is hardwired to be used with DeviceState.
> dev->hotplugged is checked to determine if object_apply_global_props()
> will receive a NULL or an &error_fatal errp.
> 
> Change qdev_prop_set_globals() to receive an Object and an errp. The
> logic using dev->hotplugged is moved to the caller, device_post_init().
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/core/qdev-properties.c    | 5 ++---
>  hw/core/qdev.c               | 2 +-
>  include/hw/qdev-properties.h | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 86a583574d..4867d7dd9e 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -920,10 +920,9 @@ int qdev_prop_check_globals(void)
>      return ret;
>  }
>  
> -void qdev_prop_set_globals(DeviceState *dev)
> +void qdev_prop_set_globals(Object *obj, Error **errp)
>  {
> -    object_apply_global_props(OBJECT(dev), global_props(),
> -                              dev->hotplugged ? NULL : &error_fatal);
> +    object_apply_global_props(obj, global_props(), errp);
>  }

If you're going to make this work on Object, instead fo merely
DeviceState, then all this globals functionality should be
moved into qom/object.c, and the methods renamed, as it is no
longer qdev logic.

>  
>  /* --- 64bit unsigned int 'size' type --- */
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index f3a996f57d..923f9ca74c 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -673,7 +673,7 @@ static void device_post_init(Object *obj)
>       * precedence.
>       */
>      object_apply_compat_props(obj);
> -    qdev_prop_set_globals(DEVICE(obj));
> +    qdev_prop_set_globals(obj, DEVICE(obj)->hotplugged ? NULL : &error_fatal);
>  }
>  
>  /* Unlink device from bus and free the structure.  */
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 09aa04ca1e..a1737bf4d8 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -210,7 +210,7 @@ void qdev_prop_register_global(GlobalProperty *prop);
>  const GlobalProperty *qdev_find_global_prop(Object *obj,
>                                              const char *name);
>  int qdev_prop_check_globals(void);
> -void qdev_prop_set_globals(DeviceState *dev);
> +void qdev_prop_set_globals(Object *obj, Error **errp);
>  void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
>                                      const char *name, const char *value);
>  
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


