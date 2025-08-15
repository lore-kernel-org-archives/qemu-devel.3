Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EBDCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un01q-00068B-JT; Fri, 15 Aug 2025 15:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un01o-00066r-0H
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:23:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un01j-0004CJ-OF
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:23:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91B061F79D;
 Fri, 15 Aug 2025 19:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755285825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i5eB0t1UUmgipjbg0Zajt5C5tIgqsOaUwLsDDYhnb4=;
 b=aiFTtZTRGQDAQCSOV6W4/o8aTcQ206SoezpysVyCyabP3hLd6qgtKjpjQnbpoTDv4e6eOF
 ltU5guN4cayH4Rkl07wKRBo2Fnz3G6et+A+fdqNTzXrgwxrNkiZshOWG4cGJwOL96xnGbX
 cr99q1y0d47TarObv5KK3hgiM9JPVA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755285825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i5eB0t1UUmgipjbg0Zajt5C5tIgqsOaUwLsDDYhnb4=;
 b=3hYNhF0WF1rHkuhFXYpgCZOeWCgckkixEpjClsEbNUkBuOpRMQ38wXKpOifE8OaclQuRCw
 jJh9gtiwZoqYKCCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755285825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i5eB0t1UUmgipjbg0Zajt5C5tIgqsOaUwLsDDYhnb4=;
 b=aiFTtZTRGQDAQCSOV6W4/o8aTcQ206SoezpysVyCyabP3hLd6qgtKjpjQnbpoTDv4e6eOF
 ltU5guN4cayH4Rkl07wKRBo2Fnz3G6et+A+fdqNTzXrgwxrNkiZshOWG4cGJwOL96xnGbX
 cr99q1y0d47TarObv5KK3hgiM9JPVA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755285825;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1i5eB0t1UUmgipjbg0Zajt5C5tIgqsOaUwLsDDYhnb4=;
 b=3hYNhF0WF1rHkuhFXYpgCZOeWCgckkixEpjClsEbNUkBuOpRMQ38wXKpOifE8OaclQuRCw
 jJh9gtiwZoqYKCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C02401368C;
 Fri, 15 Aug 2025 19:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8Ax2LkCJn2gsVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 19:23:44 +0000
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
 qemu-arm@nongnu.org, Arun Menon <armenon@redhat.com>, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v11 09/27] migration: push Error **errp into
 qemu_loadvm_state_main()
In-Reply-To: <20250813-propagate_tpm_error-v11-9-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-9-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 16:23:42 -0300
Message-ID: <874iu8z8w1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[33];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL96jwb13nk98k7j3ws9zhxhn8)];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> It is ensured that qemu_loadvm_state_main() must report an error
> in errp, in case of failure.
> loadvm_process_command also sets the errp object explicitly.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/colo.c   |  5 +++--
>  migration/savevm.c | 36 +++++++++++++++++++-----------------
>  migration/savevm.h |  3 ++-
>  3 files changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 0ba22ee76a13e313793f653f43a728e3c433bbc1..a96e4dba15516b71d1b315c73=
6c3b4879ff04e58 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
>  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
>  {
> +    ERRP_GUARD();

With my suggestion below, this goes away.

>      uint64_t total_size;
>      uint64_t value;
>      Error *local_err =3D NULL;
> @@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(Migrat=
ionIncomingState *mis,
>=20=20
>      bql_lock();
>      cpu_synchronize_all_states();
> -    ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
> +    ret =3D qemu_loadvm_state_main(mis->from_src_file, mis, errp);
>      bql_unlock();
>=20=20
>      if (ret < 0) {
> -        error_setg(errp, "Load VM's live state (ram) error");
> +        error_prepend(errp, "Load VM's live state (ram) error: ");

Another one to leave out. There's enough information downstream
already. Also, this "(ram)" doesn't look right.

>          return;
>      }
>=20=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 70e021597d884030c4a0dc2a7bc27d42a7371797..9ec07892cd6ea666431410657=
c840b6325377d97 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2105,7 +2105,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      qemu_file_set_blocking(f, true);
>=20=20
>      /* TODO: sanity check that only postcopiable data will be loaded her=
e */
> -    load_res =3D qemu_loadvm_state_main(f, mis);
> +    load_res =3D qemu_loadvm_state_main(f, mis, &error_fatal);
>=20=20
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2407,6 +2407,7 @@ static int loadvm_postcopy_handle_resume(MigrationI=
ncomingState *mis)
>   */
>  static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error=
 **errp)
>  {
> +    ERRP_GUARD();
>      int ret;
>      size_t length;
>      QIOChannelBuffer *bioc;
> @@ -2456,9 +2457,9 @@ static int loadvm_handle_cmd_packaged(MigrationInco=
mingState *mis, Error **errp)
>          qemu_coroutine_yield();
>      } while (1);
>=20=20
> -    ret =3D qemu_loadvm_state_main(packf, mis);
> +    ret =3D qemu_loadvm_state_main(packf, mis, errp);
>      if (ret < 0) {
> -        error_setg(errp, "VM state load failed: %d", ret);
> +        error_prepend(errp, "Loading VM state failed: %d: ", ret);

This is getting out of hand for code review, may I suggest you
artificially trigger these errors, look at the resulting message and
remove all the unnecessary wrapping? Each error_prepend is a candidate
for removal if it will just state "load failed".

Using error_prepend partly defeats the purpose of propagating errp. We
should only use it when there's valuable information to be provided.

>      }
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);
> @@ -3080,18 +3081,21 @@ static bool postcopy_pause_incoming(MigrationInco=
mingState *mis)
>      return true;
>  }
>=20=20
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp)
>  {
> +    ERRP_GUARD();
>      uint8_t section_type;
>      int ret =3D 0;
> -    Error *local_err =3D NULL;
>=20=20
>  retry:
>      while (true) {
>          section_type =3D qemu_get_byte(f);
>=20=20
> -        ret =3D qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_ds=
t, NULL);
> +        ret =3D qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_ds=
t, errp);
>          if (ret) {
> +            error_prepend(errp, "Failed to load device state section ID:=
 %d: ",
> +                          ret);

We could drop some extra words here, the term 'section' is already quite
representative.

"Failed to load section ID: stream error: %d: "


>              break;
>          }
>=20=20
> @@ -3112,10 +3116,7 @@ retry:
>              }
>              break;
>          case QEMU_VM_COMMAND:
> -            ret =3D loadvm_process_command(f, &local_err);
> -            if (ret < 0) {
> -                warn_report_err(local_err);
> -            }
> +            ret =3D loadvm_process_command(f, errp);

Good.

>              trace_qemu_loadvm_state_section_command(ret);
>              if ((ret < 0) || (ret =3D=3D LOADVM_QUIT)) {
>                  goto out;
> @@ -3125,7 +3126,7 @@ retry:
>              /* This is the end of migration */
>              goto out;
>          default:
> -            error_report("Unknown savevm section type %d", section_type);
> +            error_setg(errp, "Unknown savevm section type %d", section_t=
ype);

Not sure if they're referring to "savevm" here as a generic term for
vmstate/migration or if it was intended to say: "savevm wrote a section
type that this loadvm instance doesn't understand".

Since you're here, could you fix this? Migration errors from source and
destination are often interleaved in logs, we don't want to see the
"savevm" word in a destination-side error message. Just put a small note
in the commit message, no need for another patch.

>              ret =3D -EINVAL;
>              goto out;
>          }
> @@ -3133,6 +3134,9 @@ retry:
>=20=20
>  out:
>      if (ret < 0) {
> +        if (*errp =3D=3D NULL) {
> +            error_setg(errp, "Loading VM state failed: %d", ret);
> +        }

Another candidate for removal, then we avoid having to dereference errp.

>          qemu_file_set_error(f, ret);
>=20=20
>          /* Cancel bitmaps incoming regardless of recovery */
> @@ -3153,6 +3157,7 @@ out:
>              migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
>              /* Reset f to point to the newly created channel */
>              f =3D mis->from_src_file;
> +            error_free_or_abort(errp);

What's this about?

>              goto retry;
>          }
>      }
> @@ -3186,10 +3191,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>=20=20
>      cpu_synchronize_all_pre_loadvm();
>=20=20
> -    ret =3D qemu_loadvm_state_main(f, mis);
> -    if (ret < 0) {
> -        error_setg(errp, "Load VM state failed: %d", ret);
> -    }
> +    ret =3D qemu_loadvm_state_main(f, mis, errp);
>      qemu_event_set(&mis->main_thread_load_event);
>=20=20
>      trace_qemu_loadvm_state_post_main(ret);
> @@ -3270,9 +3272,9 @@ int qemu_load_device_state(QEMUFile *f, Error **err=
p)
>      int ret;
>=20=20
>      /* Load QEMU_VM_SECTION_FULL section */
> -    ret =3D qemu_loadvm_state_main(f, mis);
> +    ret =3D qemu_loadvm_state_main(f, mis, errp);
>      if (ret < 0) {
> -        error_setg(errp, "Failed to load device state: %d", ret);
> +        error_prepend(errp, "Failed to load device state: %d: ", ret);
>          return ret;
>      }
>=20=20
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b12681839f0b1afa3255e45215d99c13a224b19f..c337e3e3d111a7f28a57b90f6=
1e8f70b71803d4e 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
>=20=20
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,

