Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF1DD2124C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 08:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1M7Y-0007gf-D7; Thu, 17 Oct 2024 04:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1M7W-0007gG-7p
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1M7U-0000i0-Lh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 04:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729154670;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/22rKZZSTb7ZDnh1sARGvgQPTpvPfyxJ70xl01LBoKg=;
 b=Njcd/TS4E2fMEWzrYbCLLf6HwpN26GiMnUjMyK2QnY6vXgZ+8zcGf7PPJDZcO0Esj+Uruk
 h4rDyBaHKVnef8IiyP0buYeKu0l08SuUPQSNOGJg/QBQMxggHLfUh9Eeb6f1uPRmPVD/3g
 9LMnfIraeDd3rkQOeYXXqO8oAJpNrLE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-FcCUpfHuPnu7RBF8-r_yiA-1; Thu,
 17 Oct 2024 04:44:29 -0400
X-MC-Unique: FcCUpfHuPnu7RBF8-r_yiA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22AC31955DD2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 08:44:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2934519560AD; Thu, 17 Oct 2024 08:44:25 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:44:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, dbassey@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-user: fix shared object return values
Message-ID: <ZxDOZjIixsfvGuQT@redhat.com>
References: <20241016090606.2358056-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016090606.2358056-1-aesteve@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Oct 16, 2024 at 11:06:06AM +0200, Albert Esteve wrote:
> VHOST_USER_BACKEND_SHARED_OBJECT_ADD and
> VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE state
> in the spec that they return 0 for successful
> operations, non-zero otherwise. However,
> implementation relies on the return types
> of the virtio-dmabuf library, with opposite
> semantics (true if everything is correct,
> false otherwise). Therefore, current implementaion
> violates the specification.
> 
> Revert the logic so that the implementation
> of the vhost-user handling methods matches
> the specification.
> 
> Fixes: 043e127a126bb3ceb5fc753deee27d261fd0c5ce
> Fixes: 160947666276c5b7f6bca4d746bcac2966635d79
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..90917352a4 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1607,7 +1607,7 @@ vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
>      QemuUUID uuid;
>  
>      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> -    return virtio_add_vhost_device(&uuid, dev);
> +    return !virtio_add_vhost_device(&uuid, dev);
>  }

This virtio_add_vhost_device() method returns a bool, but this
vhost_user_backend_handle_shared_object_add() method returns
an int, but fills that int with an inverted bool value. The
caller then assigns the return value to an int, but then
interprets the int as a bool, and assigns that bool result
to an u64.

This call chain is madness :-(

Change vhost_user_backend_handle_shared_object_add to return
a bool to reduce the madness IMHO.

>  
>  static int
> @@ -1623,16 +1623,16 @@ vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
>          struct vhost_dev *owner = virtio_lookup_vhost_device(&uuid);
>          if (dev != owner) {
>              /* Not allowed to remove non-owned entries */
> -            return 0;
> +            return -EPERM;
>          }
>          break;
>      }
>      default:
>          /* Not allowed to remove non-owned entries */
> -        return 0;
> +        return -EPERM;
>      }
>  
> -    return virtio_remove_resource(&uuid);
> +    return !virtio_remove_resource(&uuid);
>  }

These return values are inconsistent.

In some places you're returning a negative errno, but in this
last place you're returning true or false, by calling
virtio_remove_resource which is a 'bool' method & inverting it.

On top of this inconsistency, it has all the same madness mentioneed
above.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


