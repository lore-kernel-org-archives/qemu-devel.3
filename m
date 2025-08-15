Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADE2CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 18:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umzaR-0000vY-9A; Fri, 15 Aug 2025 14:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzaK-0000sy-UL
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:55:29 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzaH-00063c-Rg
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:55:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D3D0B1F770;
 Fri, 15 Aug 2025 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755284123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlcfqXSz/EIUn910plzw5vhw95pwa/TT+zMKdh16ehc=;
 b=fl6UkdaAKnumH02/CK7AZGyd1kJP0SA1OZZ6VZ2BspGBJVlBhTW173dW2D2cWsl6t7SEbU
 pNXkCOSq8or5JpYwnyyllM1kk6e/ubXjv51UWN1PT70N6XNI9W7u7is6jigsjWJOaWYKCt
 px9v4nwDgNvsZOpYLAa9+AwHnLirIyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755284123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlcfqXSz/EIUn910plzw5vhw95pwa/TT+zMKdh16ehc=;
 b=J5MP1iWXROuLdGDJ5Hcy23JpP2V71WbW4eC5cEp8bbLDebUZKe3psTDk3LkRL+seNaLhkj
 X1OK5IdKZK8bydDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BsB0zwk7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HQGSJmzs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755284122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlcfqXSz/EIUn910plzw5vhw95pwa/TT+zMKdh16ehc=;
 b=BsB0zwk7RKFUZ5L+HkYl4iNdnKdefifEI2pDSD51V0tWKDwzgizqG+SlgF5yvfmV6YgNqH
 g3XHQA+C+Vz2uEdNv4Q/qjq2dBk1nK23AsGXzF+lKkwMbjcTf0KAXZ4+Pb/4awD4nFO5dL
 behCBTNTWkf556z9YcWPut4OZbVUVlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755284122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlcfqXSz/EIUn910plzw5vhw95pwa/TT+zMKdh16ehc=;
 b=HQGSJmzsM5X2Cbfd/s/itXmQIOQnOI7dmY7uLJk2hE1FD5lqE1cNHRqQNnGwa4ePDR8zM4
 5v9VGGoOe9lkyJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 121D11368C;
 Fri, 15 Aug 2025 18:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SiQmBJqCn2iuTAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 18:55:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck
 <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Steve
 Sistare <steven.sistare@oracle.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Arun Menon <armenon@redhat.com>
Subject: Re: [PATCH v11 07/27] migration: push Error **errp into
 qemu_loadvm_state()
In-Reply-To: <20250813-propagate_tpm_error-v11-7-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-7-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 15:55:19 -0300
Message-ID: <87a540za7c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D3D0B1F770
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[32]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Arun Menon <armenon@redhat.com> writes:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state() must report an error
> in errp, in case of failure.
>
> When postcopy live migration runs, the device states are loaded by
> both the qemu coroutine process_incoming_migration_co() and the
> postcopy_ram_listen_thread(). Therefore, it is important that the
> coroutine also reports the error in case of failure, with
> error_report_err(). Otherwise, the source qemu will not display
> any errors before going into the postcopy pause state.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/migration.c |  9 +++++----
>  migration/savevm.c    | 31 +++++++++++++++++++------------
>  migration/savevm.h    |  2 +-
>  3 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25dec01f206eacad2edd24d21f00e614c..c6768d88f45c870c7fad9b995=
7300766ff69effc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
>                        MIGRATION_STATUS_ACTIVE);
>=20=20
>      mis->loadvm_co =3D qemu_coroutine_self();
> -    ret =3D qemu_loadvm_state(mis->from_src_file);
> +    ret =3D qemu_loadvm_state(mis->from_src_file, &local_err);
>      mis->loadvm_co =3D NULL;
>=20=20
>      trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
>      }
>=20=20
>      if (ret < 0) {
> -        error_setg(&local_err, "load of migration failed: %s", strerror(=
-ret));
> +        error_prepend(&local_err, "load of migration failed: %s: ",
> +                      strerror(-ret));
>          goto fail;
>      }
>=20=20
> @@ -924,13 +925,13 @@ fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      migrate_set_error(s, local_err);
> -    error_free(local_err);
> +    error_report_err(local_err);
>=20=20
>      migration_incoming_state_destroy();
>=20=20
>      if (mis->exit_on_error) {
>          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -            error_report_err(s->error);
> +            error_free(s->error);
>              s->error =3D NULL;
>          }
>=20=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 4f8c40e284a1b199d12f3c7dd61212b3e0e057c9..05dc392bdf4e19f340bc72bf6=
6ba0543d56868a5 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3159,28 +3159,24 @@ out:
>      return ret;
>  }
>=20=20
> -int qemu_loadvm_state(QEMUFile *f)
> +int qemu_loadvm_state(QEMUFile *f, Error **errp)
>  {
>      MigrationState *s =3D migrate_get_current();
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> -    Error *local_err =3D NULL;
>      int ret;
>=20=20
> -    if (qemu_savevm_state_blocked(&local_err)) {
> -        error_report_err(local_err);
> +    if (qemu_savevm_state_blocked(errp)) {
>          return -EINVAL;
>      }
>=20=20
>      qemu_loadvm_thread_pool_create(mis);
>=20=20
> -    ret =3D qemu_loadvm_state_header(f, &local_err);
> +    ret =3D qemu_loadvm_state_header(f, errp);
>      if (ret) {
> -        error_report_err(local_err);
>          return ret;
>      }
>=20=20
> -    if (qemu_loadvm_state_setup(f, &local_err) !=3D 0) {
> -        error_report_err(local_err);
> +    if (qemu_loadvm_state_setup(f, errp) !=3D 0) {
>          return -EINVAL;
>      }
>=20=20
> @@ -3191,6 +3187,9 @@ int qemu_loadvm_state(QEMUFile *f)
>      cpu_synchronize_all_pre_loadvm();
>=20=20
>      ret =3D qemu_loadvm_state_main(f, mis);
> +    if (ret < 0) {
> +        error_setg(errp, "Load VM state failed: %d", ret);
> +    }
>      qemu_event_set(&mis->main_thread_load_event);
>=20=20
>      trace_qemu_loadvm_state_post_main(ret);
> @@ -3208,8 +3207,14 @@ int qemu_loadvm_state(QEMUFile *f)
>          if (migrate_has_error(migrate_get_current()) ||
>              !qemu_loadvm_thread_pool_wait(s, mis)) {
>              ret =3D -EINVAL;
> +            error_setg(errp,
> +                       "Error while loading VM state: "
> +                       "Migration stream has error");

The stream error is the one below. Just keep a generic message here
because we'll propagate the error from qemu_loadvm_state_main() later in
the series.

>          } else {
>              ret =3D qemu_file_get_error(f);
> +            if (ret < 0) {
> +                error_setg(errp, "Error while loading vmstate : %d", ret=
);

+ stream error:

> +            }
>          }
>      }
>      /*
> @@ -3474,6 +3479,7 @@ void qmp_xen_save_devices_state(const char *filenam=
e, bool has_live, bool live,
>=20=20
>  void qmp_xen_load_devices_state(const char *filename, Error **errp)
>  {
> +    ERRP_GUARD();
>      QEMUFile *f;
>      QIOChannelFile *ioc;
>      int ret;
> @@ -3495,10 +3501,10 @@ void qmp_xen_load_devices_state(const char *filen=
ame, Error **errp)
>      f =3D qemu_file_new_input(QIO_CHANNEL(ioc));
>      object_unref(OBJECT(ioc));
>=20=20
> -    ret =3D qemu_loadvm_state(f);
> +    ret =3D qemu_loadvm_state(f, errp);
>      qemu_fclose(f);
>      if (ret < 0) {
> -        error_setg(errp, "loading Xen device state failed");
> +        error_prepend(errp, "loading Xen device state failed: ");
>      }
>      migration_incoming_state_destroy();
>  }
> @@ -3506,6 +3512,7 @@ void qmp_xen_load_devices_state(const char *filenam=
e, Error **errp)
>  bool load_snapshot(const char *name, const char *vmstate,
>                     bool has_devices, strList *devices, Error **errp)
>  {
> +    ERRP_GUARD();
>      BlockDriverState *bs_vm_state;
>      QEMUSnapshotInfo sn;
>      QEMUFile *f;
> @@ -3569,13 +3576,13 @@ bool load_snapshot(const char *name, const char *=
vmstate,
>          ret =3D -EINVAL;
>          goto err_drain;
>      }
> -    ret =3D qemu_loadvm_state(f);
> +    ret =3D qemu_loadvm_state(f, errp);
>      migration_incoming_state_destroy();
>=20=20
>      bdrv_drain_all_end();
>=20=20
>      if (ret < 0) {
> -        error_setg(errp, "Error %d while loading VM state", ret);
> +        error_prepend(errp, "Error %d while loading VM state: ", ret);

This message will get redundant, leave it out.

>          return false;
>      }
>=20=20
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24=
a7baeae73d90955 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
>  void qemu_savevm_live_state(QEMUFile *f);
>  int qemu_save_device_state(QEMUFile *f);
>=20=20
> -int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);

