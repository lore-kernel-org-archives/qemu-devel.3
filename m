Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED6AF54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w536v-0000iD-BR; Tue, 24 Mar 2026 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w536d-0000gl-Lq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w536b-0001Jq-KR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774363900;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FXaaWhNp5dFN/8+KwIgs6Fd8Vh6PjU/mTwOWvd6TtBE=;
 b=NPmdOFhZyKGU26UeU9tbFFheS/1WVi0eLEcfFO6abevXKQjXl/jPavMsLz/dMsOHXTuZuq
 0tKs6qFqj5EEQF5GENMP19keSlISiri84UqOTLZZhgPvXKzTNo+wC+H/PQX/DXrbMTMeiu
 fxZsr3vRxVS2o2swLLOu03Mcz2Mjdwg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-ICuAiS6wM-adm0oSKVdR7w-1; Tue,
 24 Mar 2026 10:51:38 -0400
X-MC-Unique: ICuAiS6wM-adm0oSKVdR7w-1
X-Mimecast-MFC-AGG-ID: ICuAiS6wM-adm0oSKVdR7w_1774363898
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D877419560A2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 14:51:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A6BC19560B1; Tue, 24 Mar 2026 14:51:35 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:51:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 46/60] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
Message-ID: <acKk9CIbQMXGWbeu@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-46-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-qemu-vnc-v1-46-48eb1dcf7b76@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 17, 2026 at 12:51:00PM +0400, Marc-André Lureau wrote:
> Combine the two-step vnc_display_init()/vnc_display_open() sequence
> into a single vnc_display_new() function that returns VncDisplay*.
> This simplifies the API by making vnc_display_open() an
> internal detail and will allow further code simplification.
> 
> vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
> Add vnc_display_free() for consistency, and it will be later used.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/console.h |  2 --
>  ui/vnc.h             |  3 ++
>  ui/vnc.c             | 79 ++++++++++++++++++++++------------------------------
>  3 files changed, 37 insertions(+), 47 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 152333d60fc..737ceba3890 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -448,8 +448,6 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
>  void qemu_display_help(void);
>  
>  /* vnc.c */
> -void vnc_display_init(const char *id, Error **errp);
> -void vnc_display_open(const char *id, Error **errp);
>  void vnc_display_add_client(const char *id, int csock, bool skipauth);
>  int vnc_display_password(const char *id, const char *password, Error **errp);
>  int vnc_display_pw_expire(const char *id, time_t expires);
> diff --git a/ui/vnc.h b/ui/vnc.h
> index c5d678ac31e..6afe0f16d12 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -548,6 +548,9 @@ enum VncFeatures {
>  #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
>  #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
>  
> +VncDisplay *vnc_display_new(const char *id, Error **errp);
> +void vnc_display_free(VncDisplay *vd);

This re-inforces my comment from the previous patch, wrt stopping
the VNC worker thread. If we're exposing this as a "public" API,
then IMHO, we need to  keep around all the code for stopping the
worker thread, revert 09526058d0a501106dcac842a455e187f1413d98
and actually call vnc_stop_worker_thread in the right place(s).

> +
>  /*****************************************************************************
>   *
>   * Internal APIs
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 115ff8a988e..03b99c9e590 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3421,14 +3421,14 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
>      update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
>  }
>  
> -static void vnc_display_free(VncDisplay *vd);
> +static bool vnc_display_open(VncDisplay *vd, Error **errp);
>  
> -void vnc_display_init(const char *id, Error **errp)
> +VncDisplay *vnc_display_new(const char *id, Error **errp)
>  {
>      VncDisplay *vd;
>  
>      if (vnc_display_find(id) != NULL) {
> -        return;
> +        return NULL;
>      }
>      vd = g_malloc0(sizeof(*vd));
>  
> @@ -3449,7 +3449,7 @@ void vnc_display_init(const char *id, Error **errp)
>  
>      if (!vd->kbd_layout) {
>          vnc_display_free(vd);
> -        return;
> +        return NULL;
>      }
>  
>      vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> @@ -3462,7 +3462,13 @@ void vnc_display_init(const char *id, Error **errp)
>      vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
>          &vmstate_change_handler, vd);
>  
> +    if (!vnc_display_open(vd, errp)) {
> +        vnc_display_free(vd);
> +        return NULL;
> +    }
> +
>      QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> +    return vd;
>  }
>  
>  static void vnc_display_close(VncDisplay *vd)
> @@ -3507,7 +3513,7 @@ static void vnc_display_close(VncDisplay *vd)
>  #endif
>  }
>  
> -static void vnc_display_free(VncDisplay *vd)
> +void vnc_display_free(VncDisplay *vd)
>  {
>      if (!vd) {
>          return;
> @@ -3525,7 +3531,6 @@ static void vnc_display_free(VncDisplay *vd)
>      g_free(vd);
>  }
>  
> -
>  int vnc_display_password(const char *id, const char *password, Error **errp)
>  {
>      VncDisplay *vd = vnc_display_find(id);
> @@ -4068,10 +4073,9 @@ bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp)
>      return true;
>  }
>  
> -void vnc_display_open(const char *id, Error **errp)
> +static bool vnc_display_open(VncDisplay *vd, Error **errp)
>  {
> -    VncDisplay *vd = vnc_display_find(id);
> -    QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
> +    QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, vd->id);
>      g_autoptr(SocketAddressList) saddr_list = NULL;
>      g_autoptr(SocketAddressList) wsaddr_list = NULL;
>      const char *share, *device_id;
> @@ -4090,26 +4094,23 @@ void vnc_display_open(const char *id, Error **errp)
>      assert(vd);
>      assert(opts);
>  
> -    vnc_display_close(vd);
> -
>      reverse = qemu_opt_get_bool(opts, "reverse", false);
>      if (vnc_display_get_addresses(opts, reverse, &saddr_list, &wsaddr_list,
>                                    errp) < 0) {
> -        goto fail;
> +        return false;
>      }
>  
> -
>      passwordSecret = qemu_opt_get(opts, "password-secret");
>      if (passwordSecret) {
>          if (qemu_opt_get(opts, "password")) {
>              error_setg(errp,
>                         "'password' flag is redundant with 'password-secret'");
> -            goto fail;
> +            return false;
>          }
>          vd->password = qcrypto_secret_lookup_as_utf8(passwordSecret,
>                                                       errp);
>          if (!vd->password) {
> -            goto fail;
> +            return false;
>          }
>          password = true;
>      } else {
> @@ -4120,7 +4121,7 @@ void vnc_display_open(const char *id, Error **errp)
>                  QCRYPTO_CIPHER_ALGO_DES, QCRYPTO_CIPHER_MODE_ECB)) {
>              error_setg(errp,
>                         "Cipher backend does not support DES algorithm");
> -            goto fail;
> +            return false;
>          }
>      }
>  
> @@ -4130,7 +4131,7 @@ void vnc_display_open(const char *id, Error **errp)
>  #ifndef CONFIG_VNC_SASL
>      if (sasl) {
>          error_setg(errp, "VNC SASL auth requires cyrus-sasl support");
> -        goto fail;
> +        return false;
>      }
>  #endif /* CONFIG_VNC_SASL */
>      credid = qemu_opt_get(opts, "tls-creds");
> @@ -4141,7 +4142,7 @@ void vnc_display_open(const char *id, Error **errp)
>          if (!creds) {
>              error_setg(errp, "No TLS credentials with id '%s'",
>                         credid);
> -            goto fail;
> +            return false;
>          }
>          vd->tlscreds = (QCryptoTLSCreds *)
>              object_dynamic_cast(creds,
> @@ -4149,26 +4150,26 @@ void vnc_display_open(const char *id, Error **errp)
>          if (!vd->tlscreds) {
>              error_setg(errp, "Object with id '%s' is not TLS credentials",
>                         credid);
> -            goto fail;
> +            return false;
>          }
>          object_ref(OBJECT(vd->tlscreds));
>  
>          if (!qcrypto_tls_creds_check_endpoint(vd->tlscreds,
>                                                QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
>                                                errp)) {
> -            goto fail;
> +            return false;
>          }
>      }
>      tlsauthz = qemu_opt_get(opts, "tls-authz");
>      if (tlsauthz && !vd->tlscreds) {
>          error_setg(errp, "'tls-authz' provided but TLS is not enabled");
> -        goto fail;
> +        return false;
>      }
>  
>      saslauthz = qemu_opt_get(opts, "sasl-authz");
>      if (saslauthz && !sasl) {
>          error_setg(errp, "'sasl-authz' provided but SASL auth is not enabled");
> -        goto fail;
> +        return false;
>      }
>  
>      share = qemu_opt_get(opts, "share");
> @@ -4181,7 +4182,7 @@ void vnc_display_open(const char *id, Error **errp)
>              vd->share_policy = VNC_SHARE_POLICY_FORCE_SHARED;
>          } else {
>              error_setg(errp, "unknown vnc share= option");
> -            goto fail;
> +            return false;
>          }
>      } else {
>          vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> @@ -4215,20 +4216,20 @@ void vnc_display_open(const char *id, Error **errp)
>      if (vnc_display_setup_auth(&vd->auth, &vd->subauth,
>                                 vd->tlscreds, password,
>                                 sasl, false, errp) < 0) {
> -        goto fail;
> +        return false;
>      }
>      trace_vnc_auth_init(vd, 0, vd->auth, vd->subauth);
>  
>      if (vnc_display_setup_auth(&vd->ws_auth, &vd->ws_subauth,
>                                 vd->tlscreds, password,
>                                 sasl, true, errp) < 0) {
> -        goto fail;
> +        return false;
>      }
>      trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
>  
>  #ifdef CONFIG_VNC_SASL
>      if (sasl && !vnc_sasl_server_init(errp)) {
> -        goto fail;
> +        return false;
>      }
>  #endif
>      vd->lock_key_sync = lock_key_sync;
> @@ -4241,7 +4242,7 @@ void vnc_display_open(const char *id, Error **errp)
>      if (audiodev) {
>          vd->audio_be = audio_be_by_name(audiodev, errp);
>          if (!vd->audio_be) {
> -            goto fail;
> +            return false;
>          }
>      } else {
>          vd->audio_be = audio_get_default_audio_be(NULL);
> @@ -4255,7 +4256,7 @@ void vnc_display_open(const char *id, Error **errp)
>          con = qemu_console_lookup_by_device_name(device_id, head, &err);
>          if (err) {
>              error_propagate(errp, err);
> -            goto fail;
> +            return false;
>          }
>      } else {
>          con = qemu_console_lookup_default();
> @@ -4271,16 +4272,16 @@ void vnc_display_open(const char *id, Error **errp)
>      qkbd_state_set_delay(vd->kbd, key_delay_ms);
>  
>      if (saddr_list == NULL) {
> -        return;
> +        return true;
>      }
>  
>      if (reverse) {
>          if (vnc_display_connect(vd, saddr_list, wsaddr_list, errp) < 0) {
> -            goto fail;
> +            return false;
>          }
>      } else {
>          if (vnc_display_listen(vd, saddr_list, wsaddr_list, errp) < 0) {
> -            goto fail;
> +            return false;
>          }
>      }
>  
> @@ -4288,11 +4289,7 @@ void vnc_display_open(const char *id, Error **errp)
>          vnc_display_print_local_addr(vd);
>      }
>  
> -    /* Success */
> -    return;
> -
> -fail:
> -    vnc_display_close(vd);
> +    return true;
>  }

I think it would be helpful for clarity if we changed vnc_display_init
and vnc_display_open to have a 'bool' return value in an earlier patch,
then let this patch just focus on the merge without the large
refactoring of return vaules.


>  
>  void vnc_display_add_client(const char *id, int csock, bool skipauth)
> @@ -4348,15 +4345,7 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>          id = vnc_auto_assign_id(opts);
>      }
>  
> -    vnc_display_init(id, errp);
> -    if (*errp) {
> -        return -1;
> -    }
> -    vnc_display_open(id, errp);
> -    if (*errp) {
> -        return -1;
> -    }
> -    return 0;
> +    return vnc_display_new(id, errp) != NULL ? 0 : -1;
>  }
>  
>  static void vnc_register_config(void)
> 
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


