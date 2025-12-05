Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7244D33980
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXRe-0001r2-Mr; Fri, 05 Dec 2025 10:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXRd-0001ps-4g
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vRXRa-0000RI-Eb
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jykQQItPP/FBDc87h2GLuimWSX2vQfDkT8zldL8Arjc=;
 b=YaEkLHMytNjcOvK4NSNAaGMRLwJBZhXPUuhUeTY+pVbZyJYbwbwC2vRy48oK597wUhX7ep
 mOBh18RVP5GPThKMJhI0nyuqU0nsaMRN37Qh3wz8K5t7piIfDzjqpG4t/uuYYPy291c3eu
 TFGKhc6UZC7ldWLKrRXmjv3mVznneP0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-7FcRP8JTN26ORdBwYyDnKQ-1; Fri, 05 Dec 2025 10:09:58 -0500
X-MC-Unique: 7FcRP8JTN26ORdBwYyDnKQ-1
X-Mimecast-MFC-AGG-ID: 7FcRP8JTN26ORdBwYyDnKQ_1764947398
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34188ba5990so5203873a91.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947398; x=1765552198; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jykQQItPP/FBDc87h2GLuimWSX2vQfDkT8zldL8Arjc=;
 b=V2riIIL3T81JftPQ2hVvakfUQ6T2HbYdI8Ueh1J7fnVvMlMqAm9OyZh9rsc+BV0/7j
 rPlXhTXa9NroFN9VBtJ6nQPQJlF1s+4xl2dSh7Bo36zyWQAnGIIdfn5+0qS+LG0MnCu5
 GUYhZRagabHJnw/POcMmZ3rSwAJ3vGqVsngqyhuqiW55MY+KhogbTNuYji2wWu6SNJck
 13a7TFq52IiODx+lvgKm3dF3y9b07IvSXAh06+LtARMK0eEGDVa25peQxbj2KCfHu0MO
 T+TkH5Fxshr7YwgaBeK7YXTed3an+rrNI/RUogk0Uh30+Cn01h0AxgqRoN+slYaHJtux
 c3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947398; x=1765552198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jykQQItPP/FBDc87h2GLuimWSX2vQfDkT8zldL8Arjc=;
 b=sghdl/Y30YK8Pk0SN3StmrDMic/nEhbvbeA8qXIsi6AgbD1BWuzcnbZ0P60JwE0AHo
 mFq54t9FwZ97qDytYz22A8YECQyEz84l0/WBnlBtxPGGXTlVo9SJzFlNXuRE5ge2Mtlk
 5xqxL3elGHEhSyuGTq2+VhW08p7BehF01wgZig5EFkDjqr5ShuFLCS6BszZPbgxG7jQR
 5KSql29lsrYH+HK/caL3/EVfnQTQ4EQmwWQ2nK5POsGqkZqhO/NR2KOuH0ULDqevmOrA
 f3i3HGq05SjnSi6+axi1NWs3zAxlusCh0HPxTASfxGMCfJUhL2BnRqlF4EsTDrD54O5c
 uySw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXriq0+jB4r/w6rqQ1jd+ALOwWJ+M12jh4qvbzWphP/4YFWZNRNBZIQzr+iHuXSm4Tav+/NMxk3Wgyh@nongnu.org
X-Gm-Message-State: AOJu0YwrES2oAVWz9yzh7z3a2HtTBcYquZiAxMNGR0loqPpDxtOII0nE
 A+oT9FPicaxM1oPnRzc0mSX1WtT8Z8j8MqTfcGrTM7lKTXE4WoOe8cT7Rtmqp5lGeh1aMgfhiek
 SQZtqKBG4OSzLEqe2HvUmc9WiLLYXh8Fzn7Wqjfr9+a++y5fxias/WKcinTzvzFLWgL3F+wehRl
 wLIQFZZRBPYCca+fS7Jy6zUoXZ3uyXt9o=
X-Gm-Gg: ASbGncucOETFrnLNNWLbBdkM7W10kJM5fMPdBCqu9vW8PPYYHrrUAzbAJb0lscPUtWC
 qlOVTVeCnKSTGVKfZcEsHbhI6FjJWgbLbw0axpdqdrxXzcJJE+aMo8W9bz6indrep4NEfGepEnT
 hMgHl8eRw+nEXgVXByEgli6Quln1HM3nPr6xLTPP83GjhpeEBSDaR6tW275LBbxjaJsVGmsysA8
 xwgjpbmgzaYOVzmNrrqP1zXOA==
X-Received: by 2002:a17:90b:1a92:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-34947b601c3mr7078633a91.4.1764947397595; 
 Fri, 05 Dec 2025 07:09:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw2Rde25r72TPKyKQK9Vu2ilUYJfuVn3+0zzPwmkET6IUbVYIhzAiQ0uqzg6e2E/oE675G2WPN44l/sc8TIsI=
X-Received: by 2002:a17:90b:1a92:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-34947b601c3mr7078606a91.4.1764947397034; Fri, 05 Dec 2025
 07:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20251204154235.149575-1-vsementsov@yandex-team.ru>
 <20251204154235.149575-2-vsementsov@yandex-team.ru>
In-Reply-To: <20251204154235.149575-2-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Dec 2025 19:09:44 +0400
X-Gm-Features: AWmQ_bkI8Y8LyX8GdOS4qc-fzkvtR9fPDWC8yhV3rTii_VEPDlPWigBZ5E2ZYOs
Message-ID: <CAMxuvaw7n7p5-0+k1hmhWX=09Q0wZk1J4=97hoWyF_RA6RLKMQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ui/spice: Require spice-server >= 0.15.0
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a5d621064535d667"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a5d621064535d667
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Dec 4, 2025 at 7:42=E2=80=AFPM Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> wrote:

> For major distributions we have now:
>
>     Debian 13: 0.15.2
>     Ubuntu 22.04: 0.15.0
>     RHEL-9/CentOS Stream 9: SPICE is removed
>     Fedora 42: 0.15.1
>     OpenSUSE Leap 15.4: 0.15.0
>
> Time to update the dependancy in QEMU and drop almost all
> SPICE_SERVER_VERSION checks.
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  chardev/spice.c         |  6 ------
>  hw/display/qxl.c        | 11 ++---------
>  include/ui/qemu-spice.h |  4 ----
>  meson.build             |  2 +-
>  ui/spice-display.c      |  8 ++------
>  5 files changed, 5 insertions(+), 26 deletions(-)
>
> diff --git a/chardev/spice.c b/chardev/spice.c
> index db53b49da2..39b79d60fb 100644
> --- a/chardev/spice.c
> +++ b/chardev/spice.c
> @@ -278,12 +278,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,
>      }
>
>      *be_opened =3D false;
> -#if SPICE_SERVER_VERSION < 0x000e02
> -    /* Spice < 0.14.2 doesn't explicitly open smartcard chardev */
> -    if (strcmp(type, "smartcard") =3D=3D 0) {
> -        *be_opened =3D true;
> -    }
> -#endif
>      chr_open(chr, type);
>  }
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 18f482ca7f..0fa8a3204d 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -261,11 +261,6 @@ static void
> qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
>                      QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,
>                      0));
>      } else {
> -#if SPICE_SERVER_VERSION < 0x000e02 /* release 0.14.2 */
> -        if (qxl->max_outputs) {
> -            spice_qxl_set_max_monitors(&qxl->ssd.qxl, qxl->max_outputs);
> -        }
> -#endif
>          qxl->guest_monitors_config =3D qxl->ram->monitors_config;
>          spice_qxl_monitors_config_async(&qxl->ssd.qxl,
>                  qxl->ram->monitors_config,
> @@ -2109,6 +2104,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl,
> Error **errp)
>      uint8_t* config =3D qxl->pci.config;
>      uint32_t pci_device_rev;
>      uint32_t io_size;
> +    Error *err =3D NULL;
> +    char device_address[256] =3D "";
>
>      qemu_spice_display_init_common(&qxl->ssd);
>      qxl->mode =3D QXL_MODE_UNDEFINED;
> @@ -2208,9 +2205,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl,
> Error **errp)
>          return;
>      }
>
> -#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
> -    Error *err =3D NULL;
> -    char device_address[256] =3D "";
>      if (qemu_console_fill_device_address(qxl->vga.con,
>                                           device_address,
> sizeof(device_address),
>                                           &err)) {
> @@ -2221,7 +2215,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl,
> Error **errp)
>      } else {
>          error_report_err(err);
>      }
> -#endif
>
>      qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
>
> diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
> index b7d493742c..8e5e6b2a74 100644
> --- a/include/ui/qemu-spice.h
> +++ b/include/ui/qemu-spice.h
> @@ -34,11 +34,7 @@ int qemu_spice_add_display_interface(QXLInstance
> *qxlin, QemuConsole *con);
>  int qemu_spice_migrate_info(const char *hostname, int port, int tls_port=
,
>                              const char *subject);
>
> -#if SPICE_SERVER_VERSION >=3D 0x000f00 /* release 0.15.0 */
>  #define SPICE_HAS_ATTACHED_WORKER 1
> -#else
> -#define SPICE_HAS_ATTACHED_WORKER 0
> -#endif
>
>  #else  /* CONFIG_SPICE */
>
> diff --git a/meson.build b/meson.build
> index d9293294d8..975e842f70 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1357,7 +1357,7 @@ if get_option('spice') \
>               .require(pixman.found(),
>                        error_message: 'cannot enable SPICE if pixman is
> not available') \
>               .allowed()
> -  spice =3D dependency('spice-server', version: '>=3D0.14.0',
> +  spice =3D dependency('spice-server', version: '>=3D0.15.0',
>                       required: get_option('spice'),
>                       method: 'pkg-config')
>  endif
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index db71e866f8..f2304bb0ce 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -689,13 +689,11 @@ static int
> interface_client_monitors_config(QXLInstance *sin,
>      if (mc->num_of_monitors > head) {
>          info.width  =3D mc->monitors[head].width;
>          info.height =3D mc->monitors[head].height;
> -#if SPICE_SERVER_VERSION >=3D 0x000e04 /* release 0.14.4 */
>          if (mc->flags & VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICAL_SIZE) {
>              VDAgentMonitorMM *mm =3D (void
> *)&mc->monitors[mc->num_of_monitors];
>              info.width_mm =3D mm[head].width;
>              info.height_mm =3D mm[head].height;
>          }
> -#endif
>      }
>
>      trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
> @@ -1393,6 +1391,8 @@ static const DisplayGLCtxOps gl_ctx_ops =3D {
>  static void qemu_spice_display_init_one(QemuConsole *con)
>  {
>      SimpleSpiceDisplay *ssd =3D g_new0(SimpleSpiceDisplay, 1);
> +    Error *err =3D NULL;
> +    char device_address[256] =3D "";
>
>      qemu_spice_display_init_common(ssd);
>
> @@ -1414,9 +1414,6 @@ static void qemu_spice_display_init_one(QemuConsole
> *con)
>      ssd->qxl.base.sif =3D &dpy_interface.base;
>      qemu_spice_add_display_interface(&ssd->qxl, con);
>
> -#if SPICE_SERVER_VERSION >=3D 0x000e02 /* release 0.14.2 */
> -    Error *err =3D NULL;
> -    char device_address[256] =3D "";
>      if (qemu_console_fill_device_address(con, device_address, 256, &err)=
)
> {
>          spice_qxl_set_device_info(&ssd->qxl,
>                                    device_address,
> @@ -1425,7 +1422,6 @@ static void qemu_spice_display_init_one(QemuConsole
> *con)
>      } else {
>          error_report_err(err);
>      }
> -#endif
>
>      qemu_spice_create_host_memslot(ssd);
>
> --
> 2.48.1
>
>

--000000000000a5d621064535d667
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4, 2025 at 7:42=
=E2=80=AFPM Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementsov@y=
andex-team.ru">vsementsov@yandex-team.ru</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">For major distributions we have now=
:<br>
<br>
=C2=A0 =C2=A0 Debian 13: 0.15.2<br>
=C2=A0 =C2=A0 Ubuntu 22.04: 0.15.0<br>
=C2=A0 =C2=A0 RHEL-9/CentOS Stream 9: SPICE is removed<br>
=C2=A0 =C2=A0 Fedora 42: 0.15.1<br>
=C2=A0 =C2=A0 OpenSUSE Leap 15.4: 0.15.0<br>
<br>
Time to update the dependancy in QEMU and drop almost all<br>
SPICE_SERVER_VERSION checks.<br>
<br>
Suggested-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau=
@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Signed-off-by: Vladimir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementso=
v@yandex-team.ru" target=3D"_blank">vsementsov@yandex-team.ru</a>&gt;<br></=
blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a h=
ref=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&=
gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
---<br>
=C2=A0chardev/spice.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ------<br>
=C2=A0hw/display/qxl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++---------<br>
=C2=A0include/ui/qemu-spice.h |=C2=A0 4 ----<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 =
+-<br>
=C2=A0ui/spice-display.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++------<br>
=C2=A05 files changed, 5 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/chardev/spice.c b/chardev/spice.c<br>
index db53b49da2..39b79d60fb 100644<br>
--- a/chardev/spice.c<br>
+++ b/chardev/spice.c<br>
@@ -278,12 +278,6 @@ static void qemu_chr_open_spice_vmc(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0*be_opened =3D false;<br>
-#if SPICE_SERVER_VERSION &lt; 0x000e02<br>
-=C2=A0 =C2=A0 /* Spice &lt; 0.14.2 doesn&#39;t explicitly open smartcard c=
hardev */<br>
-=C2=A0 =C2=A0 if (strcmp(type, &quot;smartcard&quot;) =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *be_opened =3D true;<br>
-=C2=A0 =C2=A0 }<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0chr_open(chr, type);<br>
=C2=A0}<br>
<br>
diff --git a/hw/display/qxl.c b/hw/display/qxl.c<br>
index 18f482ca7f..0fa8a3204d 100644<br>
--- a/hw/display/qxl.c<br>
+++ b/hw/display/qxl.c<br>
@@ -261,11 +261,6 @@ static void qxl_spice_monitors_config_async(PCIQXLDevi=
ce *qxl, int replay)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00));<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-#if SPICE_SERVER_VERSION &lt; 0x000e02 /* release 0.14.2 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qxl-&gt;max_outputs) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spice_qxl_set_max_monitors(&amp;=
qxl-&gt;ssd.qxl, qxl-&gt;max_outputs);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qxl-&gt;guest_monitors_config =3D qxl-&gt=
;ram-&gt;monitors_config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spice_qxl_monitors_config_async(&amp;qxl-=
&gt;ssd.qxl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qxl-&gt;ram-&=
gt;monitors_config,<br>
@@ -2109,6 +2104,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t* config =3D qxl-&gt;pci.config;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t pci_device_rev;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t io_size;<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 char device_address[256] =3D &quot;&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_display_init_common(&amp;qxl-&gt;ssd);<br>
=C2=A0 =C2=A0 =C2=A0qxl-&gt;mode =3D QXL_MODE_UNDEFINED;<br>
@@ -2208,9 +2205,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-#if SPICE_SERVER_VERSION &gt;=3D 0x000e02 /* release 0.14.2 */<br>
-=C2=A0 =C2=A0 Error *err =3D NULL;<br>
-=C2=A0 =C2=A0 char device_address[256] =3D &quot;&quot;;<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_console_fill_device_address(qxl-&gt;vga.con,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d=
evice_address, sizeof(device_address),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;err)) {<br>
@@ -2221,7 +2215,6 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report_err(err);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_add_vm_change_state_handler(qxl_vm_change_state_ha=
ndler, qxl);<br>
<br>
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h<br>
index b7d493742c..8e5e6b2a74 100644<br>
--- a/include/ui/qemu-spice.h<br>
+++ b/include/ui/qemu-spice.h<br>
@@ -34,11 +34,7 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin,=
 QemuConsole *con);<br>
=C2=A0int qemu_spice_migrate_info(const char *hostname, int port, int tls_p=
ort,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *subject);<br>
<br>
-#if SPICE_SERVER_VERSION &gt;=3D 0x000f00 /* release 0.15.0 */<br>
=C2=A0#define SPICE_HAS_ATTACHED_WORKER 1<br>
-#else<br>
-#define SPICE_HAS_ATTACHED_WORKER 0<br>
-#endif<br>
<br>
=C2=A0#else=C2=A0 /* CONFIG_SPICE */<br>
<br>
diff --git a/meson.build b/meson.build<br>
index d9293294d8..975e842f70 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1357,7 +1357,7 @@ if get_option(&#39;spice&#39;) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .require(pixman.found(),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0error_message: &#39;cannot enable SPICE if pixman is not availabl=
e&#39;) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .allowed()<br>
-=C2=A0 spice =3D dependency(&#39;spice-server&#39;, version: &#39;&gt;=3D0=
.14.0&#39;,<br>
+=C2=A0 spice =3D dependency(&#39;spice-server&#39;, version: &#39;&gt;=3D0=
.15.0&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 required: get_option(&#39;spice&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 method: &#39;pkg-config&#39;)<br>
=C2=A0endif<br>
diff --git a/ui/spice-display.c b/ui/spice-display.c<br>
index db71e866f8..f2304bb0ce 100644<br>
--- a/ui/spice-display.c<br>
+++ b/ui/spice-display.c<br>
@@ -689,13 +689,11 @@ static int interface_client_monitors_config(QXLInstan=
ce *sin,<br>
=C2=A0 =C2=A0 =C2=A0if (mc-&gt;num_of_monitors &gt; head) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info.width=C2=A0 =3D mc-&gt;monitors[head=
].width;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info.height =3D mc-&gt;monitors[head].hei=
ght;<br>
-#if SPICE_SERVER_VERSION &gt;=3D 0x000e04 /* release 0.14.4 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mc-&gt;flags &amp; VD_AGENT_CONFIG_MO=
NITORS_FLAG_PHYSICAL_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VDAgentMonitorMM *mm =3D (v=
oid *)&amp;mc-&gt;monitors[mc-&gt;num_of_monitors];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info.width_mm =3D mm[head].=
width;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info.height_mm =3D mm[head]=
.height;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qemu_spice_ui_info(ssd-&gt;<a href=3D"http://qxl.=
id" rel=3D"noreferrer" target=3D"_blank">qxl.id</a>, info.width, info.heigh=
t);<br>
@@ -1393,6 +1391,8 @@ static const DisplayGLCtxOps gl_ctx_ops =3D {<br>
=C2=A0static void qemu_spice_display_init_one(QemuConsole *con)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SimpleSpiceDisplay *ssd =3D g_new0(SimpleSpiceDisplay, =
1);<br>
+=C2=A0 =C2=A0 Error *err =3D NULL;<br>
+=C2=A0 =C2=A0 char device_address[256] =3D &quot;&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_display_init_common(ssd);<br>
<br>
@@ -1414,9 +1414,6 @@ static void qemu_spice_display_init_one(QemuConsole *=
con)<br>
=C2=A0 =C2=A0 =C2=A0ssd-&gt;qxl.base.sif =3D &amp;dpy_interface.base;<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_add_display_interface(&amp;ssd-&gt;qxl, con)=
;<br>
<br>
-#if SPICE_SERVER_VERSION &gt;=3D 0x000e02 /* release 0.14.2 */<br>
-=C2=A0 =C2=A0 Error *err =3D NULL;<br>
-=C2=A0 =C2=A0 char device_address[256] =3D &quot;&quot;;<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_console_fill_device_address(con, device_addres=
s, 256, &amp;err)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spice_qxl_set_device_info(&amp;ssd-&gt;qx=
l,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_address,<br>
@@ -1425,7 +1422,6 @@ static void qemu_spice_display_init_one(QemuConsole *=
con)<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report_err(err);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_spice_create_host_memslot(ssd);<br>
<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div></div>

--000000000000a5d621064535d667--


