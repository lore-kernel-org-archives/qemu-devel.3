Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9517C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 11:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDM3m-0003jX-BC; Fri, 09 May 2025 07:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDM3i-0003dW-9y
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDM3e-0004Zn-7E
 for qemu-devel@nongnu.org; Fri, 09 May 2025 07:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746790701;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtMeqUsFa2tN6I7M5z4Vk+JxQJ5sgjmGCcCNUBh3Www=;
 b=LiGBrfzjG2mxsXZw05HkpY4r6/+nHLBE4Zq/ieJw2Am07hk1gO5NA74dp/Wjx6FX2hW8Hs
 ts+P5/cvN8127aBBgCiG6r1lTNrq/GfceY+hqJGbKsIKpyTPcNl6nqV5C8zjQqbFvQvGW3
 B/gQj3P0oynm4DErRRx/ndKQ0ZBiR6I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ig8wMUdsNoOIG2Fl3I3ryA-1; Fri,
 09 May 2025 07:38:20 -0400
X-MC-Unique: ig8wMUdsNoOIG2Fl3I3ryA-1
X-Mimecast-MFC-AGG-ID: ig8wMUdsNoOIG2Fl3I3ryA_1746790699
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A46CD1955DE8
 for <qemu-devel@nongnu.org>; Fri,  9 May 2025 11:38:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2BF31956058; Fri,  9 May 2025 11:38:17 +0000 (UTC)
Date: Fri, 9 May 2025 12:38:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Subject: Re: [PATCH for-10.1 09/10] ui/vdagent: add migration support
Message-ID: <aB3pJXHoHsJz2p5Y@redhat.com>
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
 <20250311155932.1472092-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311155932.1472092-10-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 11, 2025 at 07:59:31PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vdagent.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
> 
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 125c659af7..cc5738a6ea 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -10,6 +10,7 @@
>  #include "ui/clipboard.h"
>  #include "ui/console.h"
>  #include "ui/input.h"
> +#include "migration/vmstate.h"
>  #include "trace.h"


> +static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
> +                      const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
> +    struct CBInfoArray cbinfo = { 0, };

Just ' = {}' should be sufficient to initialize all fields.

> +    int i;
> +
> +    if (!have_clipboard(vd)) {
> +        return 0;
> +    }
> +
> +    for (i = 0; i < QEMU_CLIPBOARD_SELECTION__COUNT; i++) {
> +        if (qemu_clipboard_peer_owns(&vd->cbpeer, i)) {
> +             cbinfo.cbinfo[cbinfo.n++] = *qemu_clipboard_info(i);
> +        }
> +    }
> +
> +    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc);
> +}
> +
> +static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
> +                      const VMStateField *field)
> +{
> +    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
> +    struct CBInfoArray cbinfo = { 0, };

Likewise.

> +    int i, ret;
> +
> +    if (!have_clipboard(vd)) {
> +        return 0;
> +    }
> +
> +    vdagent_clipboard_peer_register(vd);
> +
> +    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    for (i = 0; i < cbinfo.n; i++) {
> +        g_autoptr(QemuClipboardInfo) info = qemu_clipboard_info_new(&vd->cbpeer, cbinfo.cbinfo[i].selection);
> +        /* this will steal clipboard data pointer from cbinfo.types */
> +        memcpy(info->types, cbinfo.cbinfo[i].types, sizeof(cbinfo.cbinfo[i].types));
> +        qemu_clipboard_update(info);
> +    }
> +
> +    return 0;
> +}


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


