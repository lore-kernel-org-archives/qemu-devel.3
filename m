Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A91D1CDAB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 07:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t396f-00054e-I4; Tue, 22 Oct 2024 03:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t396Y-00053e-MH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t396S-0000ZD-Ky
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 03:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729581283;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=W2RWqqONcivgYNG1NYuZFtmaZn8l9umPzJq3mUKXYAU=;
 b=Dt8zqQnP3WK+hHJPwzszpGoUHKwOdHE42JtiHYM5xJ63hJAzJmLcO7gyrM3n0VE5dMWXzB
 9LptdMsAPyQL+I5ndZTOkbQXPZowBi13oI8kq6lzIq0r+9WYSUCuOwCCRMyBecPd8Sv4dq
 FqYTiWuOiSZRxppTHKIu/w5pAFfrx2E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-W8yfBLeZOE6dwILDQ-4K3w-1; Tue,
 22 Oct 2024 03:14:37 -0400
X-MC-Unique: W8yfBLeZOE6dwILDQ-4K3w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE06219560B0; Tue, 22 Oct 2024 07:14:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A3221955F43; Tue, 22 Oct 2024 07:14:33 +0000 (UTC)
Date: Tue, 22 Oct 2024 08:14:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: ankeesler@google.com, mst@redhat.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, venture@google.com
Subject: Re: [PATCH 1/2] ui: Allow injection of vnc display name
Message-ID: <ZxdQ1XPZSC6U7fHU@redhat.com>
References: <20241017215304.3916866-1-roqueh@google.com>
 <20241017215304.3916866-2-roqueh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017215304.3916866-2-roqueh@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 17, 2024 at 09:53:03PM +0000, Roque Arcudia Hernandez wrote:
> From: Andrew Keesler <ankeesler@google.com>
> 
> Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display Identification
> Data) is propagated by QEMU such that a virtual display presents legitimate
> metadata (e.g., name, serial number, preferred resolutions, etc.) to its
> connected guest.
> 
> This change propagates an optional user-provided display name to
> QemuConsole. Future changes will update downstream devices to leverage this
> display name for various uses, the primary one being providing a custom EDID
> name to guests. Future changes will also update other displays (e.g., spice)
> with a similar option to propagate a display name to downstream devices.
> 
> Currently, every virtio-gpu virtual display has the same name: "QEMU
> Monitor". We hope to be able to inject the EDID name of virtual displays in
> order to test guest behavior that is specific to display names. We provide the
> ability to inject the display name from the display configuration as that most
> closely resembles how real displays work (hardware displays contain static EDID
> information that is provided to every connected host).
> 
> It should also be noted that EDID names longer than 12 bytes will be truncated
> per spec (I think?).
> 
> Signed-off-by: Andrew Keesler <ankeesler@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  include/ui/console.h | 1 +
>  ui/console-priv.h    | 1 +
>  ui/console.c         | 8 ++++++++
>  ui/vnc.c             | 8 +++++++-
>  4 files changed, 17 insertions(+), 1 deletion(-)
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 93a8dbd253..7d6acc5c2e 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3595,6 +3595,9 @@ static QemuOptsList qemu_vnc_opts = {
>          },{
>              .name = "power-control",
>              .type = QEMU_OPT_BOOL,
> +        },{
> +            .name = "name",
> +            .type = QEMU_OPT_STRING,
>          },
>          { /* end of list */ }
>      },
> @@ -4016,7 +4019,7 @@ void vnc_display_open(const char *id, Error **errp)
>      QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
>      g_autoptr(SocketAddressList) saddr_list = NULL;
>      g_autoptr(SocketAddressList) wsaddr_list = NULL;
> -    const char *share, *device_id;
> +    const char *share, *device_id, *name;
>      QemuConsole *con;
>      bool password = false;
>      bool reverse = false;
> @@ -4217,6 +4220,9 @@ void vnc_display_open(const char *id, Error **errp)
>      }
>      qkbd_state_set_delay(vd->kbd, key_delay_ms);
>  
> +    name = qemu_opt_get(opts, "name");
> +    qemu_console_set_name(vd->dcl.con, name);
> +
>      if (saddr_list == NULL) {
>          return;
>      }

The VNC protocol has a display name field that is sent to the client,
and which they would typically display in the Window titlebar. As a
user, I would expect this 'name' setting to be controlling that. It
is currently set in the 'protocol_client_init' method.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


