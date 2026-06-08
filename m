Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E810CCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWVT-0008N3-M9; Mon, 08 Jun 2026 05:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWWVS-0008Mu-BS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWWVQ-0007Rr-J2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780911771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5WryYrGID0MpqyXMg1qDn+eXTbw24V9txPewyBAtps=;
 b=KygFJwKOrtW5MLAA5sNk7rCNdWMu1851ngPAaFbaM6/N53KVRa+gema1fBhc3wxpECfEtC
 NJhviPwBk1vYQdI3/bv4gJyY+DFGcgD5rYGnY2okjKLGNmF4UvMfrH0t135mr/WxzQD+Dk
 awAuSVz+cNzeEtQkQHo5oWVEKgrVXL4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-zsDQ2y9qMoO_5fG7kau8ag-1; Mon,
 08 Jun 2026 05:42:41 -0400
X-MC-Unique: zsDQ2y9qMoO_5fG7kau8ag-1
X-Mimecast-MFC-AGG-ID: zsDQ2y9qMoO_5fG7kau8ag_1780911760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 525B41955F29; Mon,  8 Jun 2026 09:42:40 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B58103008B34; Mon,  8 Jun 2026 09:42:35 +0000 (UTC)
Date: Mon, 8 Jun 2026 10:42:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v2 13/33] ui/spice: add cleanup on shutdown
Message-ID: <aiaOh9w3KPkB1urR@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-13-9ea6355ea08f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608-b4-ui-v2-13-9ea6355ea08f@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jun 08, 2026 at 11:16:31AM +0400, Marc-André Lureau wrote:
> SPICE resources were never freed on shutdown. Add per-subsystem
> cleanup (display, input, core) and call it from qemu_cleanup().
> 
> Move spice-module.c into libui so the qemu_spice ops table links
> with the rest of the UI code. Add an LSan suppression for a known
> spice-server leak.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/qemu-spice-module.h |  1 +
>  include/ui/qemu-spice.h        |  2 ++
>  system/runstate.c              |  4 ++++
>  ui/spice-core.c                | 25 ++++++++++++++++++--
>  ui/spice-display.c             | 52 ++++++++++++++++++++++++++++++++++++++++++
>  ui/spice-input.c               | 52 ++++++++++++++++++++++++++++--------------
>  ui/spice-module.c              |  5 ++++
>  scripts/lsan_suppressions.txt  |  5 ++++
>  ui/meson.build                 |  4 ++--
>  9 files changed, 129 insertions(+), 21 deletions(-)




> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index e3716127203..75c7df7bb5e 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -34,6 +34,8 @@ bool spice_opengl;
>  bool spice_remote_client;
>  int spice_max_refresh_rate;
>  
> +static GPtrArray *spice_displays;
> +
>  int qemu_spice_rect_is_empty(const QXLRect* r)
>  {
>      return r->top == r->bottom || r->left == r->right;
> @@ -1421,6 +1423,54 @@ static void qemu_spice_display_init_one(QemuConsole *con)
>          qemu_console_set_display_gl_ctx(con, &ssd->dgc);
>      }
>      qemu_console_register_listener(con, &ssd->dcl, ops);
> +    g_ptr_array_add(spice_displays, ssd);
> +}
> +
> +void qemu_spice_display_cleanup(void)

Nitpicking, I would suggest separating it so that we have

  qemu_spice_displays_cleanup(void)

and

  qemu_spice_display_cleanup(SimpleSpiceDisplay *ssd)

> +{
> +    if (!spice_displays) {
> +        return;
> +    }
> +
> +    for (guint i = 0; i < spice_displays->len; i++) {
> +        SimpleSpiceDisplay *ssd = g_ptr_array_index(spice_displays, i);
> +        SimpleSpiceUpdate *update;
> +
> +        qemu_console_unregister_listener(&ssd->dcl);
> +#ifdef HAVE_SPICE_GL
> +        if (spice_opengl) {
> +            qemu_console_set_display_gl_ctx(ssd->dcl.con, NULL);
> +        }
> +#endif
> +
> +        if (ssd->ds) {
> +            qemu_spice_destroy_host_primary(ssd);
> +        }
> +        qemu_spice_del_memslot(ssd, MEMSLOT_GROUP_HOST, 0);
> +        spice_server_remove_interface(&ssd->qxl.base);
> +
> +        while ((update = QTAILQ_FIRST(&ssd->updates)) != NULL) {
> +            QTAILQ_REMOVE(&ssd->updates, update, next);
> +            qemu_spice_destroy_update(ssd, update);
> +        }
> +        g_clear_pointer(&ssd->ptr_define, g_free);
> +        g_clear_pointer(&ssd->ptr_move, g_free);
> +        g_clear_pointer(&ssd->cursor, cursor_unref);
> +        g_clear_pointer(&ssd->surface, pixman_image_unref);
> +        g_clear_pointer(&ssd->mirror, pixman_image_unref);
> +        g_clear_pointer(&ssd->buf, g_free);
> +#ifdef HAVE_SPICE_GL
> +        g_clear_pointer(&ssd->gl_unblock_bh, qemu_bh_delete);
> +        g_clear_pointer(&ssd->gl_unblock_timer, timer_free);
> +        g_clear_pointer(&ssd->gls, qemu_gl_fini_shader);
> +        egl_fb_destroy(&ssd->guest_fb);
> +        egl_fb_destroy(&ssd->blit_fb);
> +        egl_fb_destroy(&ssd->cursor_fb);
> +#endif
> +        qemu_mutex_destroy(&ssd->lock);
> +        g_free(ssd);
> +    }
> +    g_clear_pointer(&spice_displays, g_ptr_array_unref);
>  }

None the less

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


