Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A5AC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 14:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7vO-0003M9-Qx; Tue, 26 Mar 2024 10:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rp7vK-0003Kr-Uk
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rp7vJ-0002Tm-ET
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 10:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711463828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrBHHcYUkYfh/fLWeLShn5rV4uvOLA0snSQJbShNg64=;
 b=YEBjHEytkNrGcSD8H9o28toDLbEABjLGfB5cpw7+NNGQqIJJi2iND5VDffpI0iGg9yFdkj
 H22dMZZCSyLHC3Nydp941abYoMlVCk5/3F1vLOEsGTdED1MMTOvPXemwIL2CJkJMc+vIke
 3yTdekYiH2pMKVJTrOZH0UTLCmT7hWM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-rCXz-_CWP5eO-zf5S-yLdw-1; Tue, 26 Mar 2024 10:37:05 -0400
X-MC-Unique: rCXz-_CWP5eO-zf5S-yLdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA23E8007AB;
 Tue, 26 Mar 2024 14:37:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74380C01600;
 Tue, 26 Mar 2024 14:37:00 +0000 (UTC)
Date: Tue, 26 Mar 2024 09:36:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 03/11] libvhost-user: mask F_INFLIGHT_SHMFD if
 memfd is not supported
Message-ID: <ixiutci362bjtfb7n7l7knacx22fy2v4jqcpyc475cnmsyymwf@6yyguuh5j2oz>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-4-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326133936.125332-4-sgarzare@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 26, 2024 at 02:39:28PM +0100, Stefano Garzarella wrote:
> libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
> message if MFD_ALLOW_SEALING is not defined, since it's not able
> to create a memfd.
> 
> VHOST_USER_GET_INFLIGHT_FD is used only if
> VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
> that feature if the backend is not able to properly handle these
> messages.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
> index a11afd1960..1c361ffd51 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -1674,6 +1674,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>          features |= dev->iface->get_protocol_features(dev);
>      }
>  
> +    /*
> +     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
> +     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
> +     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
> +     * is negotiated. A device implementation can enable it, so let's mask
> +     * it to avoid a runtime panic.
> +     */
> +#ifndef MFD_ALLOW_SEALING
> +    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
> +#endif

Masking the feature out of advertisement is obviously correct. But
should we also fix the code for handling
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD to return an error to any client
that requests it in error when the feature was not advertised, instead
of panicking?

>      vmsg_set_reply_u64(vmsg, features);
>      return true;
>  }
> -- 
> 2.44.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


