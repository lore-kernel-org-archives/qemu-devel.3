Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E198CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 18:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umzHO-0004b4-Lk; Fri, 15 Aug 2025 14:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzHM-0004Yh-5Q
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:35:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzHI-0001vg-G3
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:35:51 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B80A211B0;
 Fri, 15 Aug 2025 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755282943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnU//gsmJV6nYhqrYYl/MMhX9oE5wwD59sKBz7ms9og=;
 b=AXvygzX+YjfHZZg6ZkJ5ORJMhYuukUVf0E8ho+M3V+01/LNRO9xsJtWJ+wxDd45gmTAj/9
 VldMA0YT8Om4dCGLJNmyj1h8am5OsmNk9QQ58H1kZAy596tusLgPHAZVAT+f5fl9Xpuogt
 5Y1fzNYwzQ7prKOF+CIR+6d54aHaVko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755282943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnU//gsmJV6nYhqrYYl/MMhX9oE5wwD59sKBz7ms9og=;
 b=fuW9h3/Hj/yEHkrXPvcDNyaVYp4UJkhJM9sCsoQXR6kplc8h2IAvSoZ33+SBlYsKpvKfJb
 rQ9Gt9sy84zyDbAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AXvygzX+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="fuW9h3/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755282943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnU//gsmJV6nYhqrYYl/MMhX9oE5wwD59sKBz7ms9og=;
 b=AXvygzX+YjfHZZg6ZkJ5ORJMhYuukUVf0E8ho+M3V+01/LNRO9xsJtWJ+wxDd45gmTAj/9
 VldMA0YT8Om4dCGLJNmyj1h8am5OsmNk9QQ58H1kZAy596tusLgPHAZVAT+f5fl9Xpuogt
 5Y1fzNYwzQ7prKOF+CIR+6d54aHaVko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755282943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnU//gsmJV6nYhqrYYl/MMhX9oE5wwD59sKBz7ms9og=;
 b=fuW9h3/Hj/yEHkrXPvcDNyaVYp4UJkhJM9sCsoQXR6kplc8h2IAvSoZ33+SBlYsKpvKfJb
 rQ9Gt9sy84zyDbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E5F713876;
 Fri, 15 Aug 2025 18:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DKGTHv59n2h8RwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 18:35:42 +0000
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
Subject: Re: [PATCH v11 05/27] migration: push Error **errp into
 loadvm_process_command()
In-Reply-To: <20250813-propagate_tpm_error-v11-5-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-5-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 15:35:40 -0300
Message-ID: <87frdszb43.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4B80A211B0
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
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> It is ensured that loadvm_process_command() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 82 +++++++++++++++++++++++++++++++++++++++---------=
------
>  1 file changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7f79461844105bf672314c3325caee9cdb654c27..715cc35394cac5fe225ef88cf=
448714a02321bd7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2546,32 +2546,35 @@ static int loadvm_postcopy_handle_switchover_star=
t(void)
>   * LOADVM_QUIT All good, but exit the loop
>   * <0          Error
>   */
> -static int loadvm_process_command(QEMUFile *f)
> +static int loadvm_process_command(QEMUFile *f, Error **errp)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      uint16_t cmd;
>      uint16_t len;
>      uint32_t tmp32;
> +    int ret;
>=20=20
>      cmd =3D qemu_get_be16(f);
>      len =3D qemu_get_be16(f);
>=20=20
>      /* Check validity before continue processing of cmds */
> -    if (qemu_file_get_error(f)) {
> -        return qemu_file_get_error(f);
> +    ret =3D qemu_file_get_error(f);
> +    if (ret) {
> +        error_setg(errp, "Failed to load VM process command: %d", ret);

"Failed to process command: stream error: %d"

> +        return ret;
>      }
>=20=20
>      if (cmd >=3D MIG_CMD_MAX || cmd =3D=3D MIG_CMD_INVALID) {
> -        error_report("MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
> +        error_setg(errp, "MIG_CMD 0x%x unknown (len 0x%x)", cmd, len);
>          return -EINVAL;
>      }
>=20=20
>      trace_loadvm_process_command(mig_cmd_args[cmd].name, len);
>=20=20
>      if (mig_cmd_args[cmd].len !=3D -1 && mig_cmd_args[cmd].len !=3D len)=
 {
> -        error_report("%s received with bad length - expecting %zu, got %=
d",
> -                     mig_cmd_args[cmd].name,
> -                     (size_t)mig_cmd_args[cmd].len, len);
> +        error_setg(errp, "%s received with bad length - expecting %zu, g=
ot %d",
> +                   mig_cmd_args[cmd].name,
> +                   (size_t)mig_cmd_args[cmd].len, len);
>          return -ERANGE;
>      }
>=20=20

Where's MIG_CMD_OPEN_RETURN_PATH?

> @@ -2594,11 +2597,10 @@ static int loadvm_process_command(QEMUFile *f)
>           * been created.
>           */
>          if (migrate_switchover_ack() && !mis->switchover_ack_pending_num=
) {
> -            int ret =3D migrate_send_rp_switchover_ack(mis);
> +            ret =3D migrate_send_rp_switchover_ack(mis);
>              if (ret) {
> -                error_report(
> -                    "Could not send switchover ack RP MSG, err %d (%s)",=
 ret,
> -                    strerror(-ret));
> +                error_setg_errno(errp, -ret,
> +                                 "Could not send switchover ack RP MSG");
>                  return ret;
>              }
>          }
> @@ -2608,39 +2610,71 @@ static int loadvm_process_command(QEMUFile *f)
>          tmp32 =3D qemu_get_be32(f);
>          trace_loadvm_process_command_ping(tmp32);
>          if (!mis->to_src_file) {
> -            error_report("CMD_PING (0x%x) received with no return path",
> -                         tmp32);
> +            error_setg(errp, "CMD_PING (0x%x) received with no return pa=
th",
> +                       tmp32);
>              return -1;
>          }
>          migrate_send_rp_pong(mis, tmp32);
>          break;
>=20=20
>      case MIG_CMD_PACKAGED:
> -        return loadvm_handle_cmd_packaged(mis);
> +        ret =3D loadvm_handle_cmd_packaged(mis);

I missed a lot of the discussion in this series, but I assume there's a
good reason to not put the conversion of each command first in the
series, so there's no need for temporary code in this patch.

> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_POSTCOPY_ADVISE:
> -        return loadvm_postcopy_handle_advise(mis, len);
> +        ret =3D loadvm_postcopy_handle_advise(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_POSTCOPY_LISTEN:
> -        return loadvm_postcopy_handle_listen(mis);
> +        ret =3D loadvm_postcopy_handle_listen(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_POSTCOPY_RUN:
> -        return loadvm_postcopy_handle_run(mis);
> +        ret =3D loadvm_postcopy_handle_run(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_POSTCOPY_RAM_DISCARD:
> -        return loadvm_postcopy_ram_handle_discard(mis, len);
> +        ret =3D loadvm_postcopy_ram_handle_discard(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_POSTCOPY_RESUME:
>          return loadvm_postcopy_handle_resume(mis);
>=20=20
>      case MIG_CMD_RECV_BITMAP:
> -        return loadvm_handle_recv_bitmap(mis, len);
> +        ret =3D loadvm_handle_recv_bitmap(mis, len);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_ENABLE_COLO:
> -        return loadvm_process_enable_colo(mis);
> +        ret =3D loadvm_process_enable_colo(mis);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>=20=20
>      case MIG_CMD_SWITCHOVER_START:
> -        return loadvm_postcopy_handle_switchover_start();
> +        ret =3D loadvm_postcopy_handle_switchover_start();
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load device state command: %d", =
ret);
> +        }
> +        return ret;
>      }
>=20=20
>      return 0;
> @@ -3051,6 +3085,7 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIn=
comingState *mis)
>  {
>      uint8_t section_type;
>      int ret =3D 0;
> +    Error *local_err =3D NULL;
>=20=20
>  retry:
>      while (true) {
> @@ -3078,7 +3113,10 @@ retry:
>              }
>              break;
>          case QEMU_VM_COMMAND:
> -            ret =3D loadvm_process_command(f);
> +            ret =3D loadvm_process_command(f, &local_err);
> +            if (ret < 0) {
> +                warn_report_err(local_err);

Again, some throwaway code here. Commit message could have made this
clear: "For now, report the error with warn_report until all callers
have been converted to pass errp".

> +            }
>              trace_qemu_loadvm_state_section_command(ret);
>              if ((ret < 0) || (ret =3D=3D LOADVM_QUIT)) {
>                  goto out;

