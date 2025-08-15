Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C4FCA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un0SX-0000Mo-B8; Fri, 15 Aug 2025 15:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un0SH-0000J4-Bi
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:51:14 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un0SE-0002ip-8t
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:51:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B7F41F449;
 Fri, 15 Aug 2025 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755287468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJheFueUkzld+ozX78+FoRfTmhO2DKzoLNMb1r699Jc=;
 b=k9iRWS8v7R9UkDhbjsklR5MGBZY4MMOY4oC4Hz0yY/Ae1rt7TN33C4BCj6YC6GPx0U2m5P
 LFf6xCbjN3e+CBMx5Cw4t6MqHRzs9XNKgk8T2yl/hzdTIrM3Zt5l3NmEJt973zd7L8LKtG
 ouA4o+vNRRNxVWQtkxuIhKDaPmZmqNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755287468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJheFueUkzld+ozX78+FoRfTmhO2DKzoLNMb1r699Jc=;
 b=mOSSBISlbwzHcXRgYRGzkfthUEyFTQFMy2ryJi/kLx5/TWwWsx+xJeetA4vcMHKSJ/m+zT
 VvSMUOmYNGflUTAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k9iRWS8v;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mOSSBISl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755287468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJheFueUkzld+ozX78+FoRfTmhO2DKzoLNMb1r699Jc=;
 b=k9iRWS8v7R9UkDhbjsklR5MGBZY4MMOY4oC4Hz0yY/Ae1rt7TN33C4BCj6YC6GPx0U2m5P
 LFf6xCbjN3e+CBMx5Cw4t6MqHRzs9XNKgk8T2yl/hzdTIrM3Zt5l3NmEJt973zd7L8LKtG
 ouA4o+vNRRNxVWQtkxuIhKDaPmZmqNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755287468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJheFueUkzld+ozX78+FoRfTmhO2DKzoLNMb1r699Jc=;
 b=mOSSBISlbwzHcXRgYRGzkfthUEyFTQFMy2ryJi/kLx5/TWwWsx+xJeetA4vcMHKSJ/m+zT
 VvSMUOmYNGflUTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CCA813876;
 Fri, 15 Aug 2025 19:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 155oEquPn2jJWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 19:51:07 +0000
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
Subject: Re: [PATCH v11 19/27] migration: push Error **errp into
 loadvm_handle_recv_bitmap()
In-Reply-To: <20250813-propagate_tpm_error-v11-19-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-19-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 16:51:04 -0300
Message-ID: <87h5y8xt1z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[33];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1B7F41F449
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
> It is ensured that loadvm_handle_recv_bitmap() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9098c4bd3394d7b9ed77e20afbb26fd9c9be6550..a7aede1b3df9164e322e68f38=
89df7c4166876f5 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2480,32 +2480,35 @@ static int loadvm_handle_cmd_packaged(MigrationIn=
comingState *mis, Error **errp)
>   * len (1 byte) + ramblock_name (<255 bytes)
>   */
>  static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
> -                                     uint16_t len)
> +                                     uint16_t len, Error **errp)
>  {
>      QEMUFile *file =3D mis->from_src_file;
>      RAMBlock *rb;
>      char block_name[256];
>      size_t cnt;
> +    int ret;
>=20=20
>      cnt =3D qemu_get_counted_string(file, block_name);
>      if (!cnt) {
> -        error_report("%s: failed to read block name", __func__);
> +        error_setg(errp, "failed to read block name: %s", block_name);

Could we not print the buffer that's just failed to be written? As a
matter of principle =3D)

>          return -EINVAL;
>      }
>=20=20
>      /* Validate before using the data */
> -    if (qemu_file_get_error(file)) {
> -        return qemu_file_get_error(file);
> +    ret =3D qemu_file_get_error(file);
> +    if (ret < 0) {
> +        error_setg(errp, "migration stream has error: %d", ret);

I've been suggesting "stream error:", probably best to keep it uniform.

> +        return ret;
>      }
>=20=20
>      if (len !=3D cnt + 1) {
> -        error_report("%s: invalid payload length (%d)", __func__, len);
> +        error_setg(errp, "invalid payload length (%d)", len);
>          return -EINVAL;
>      }
>=20=20
>      rb =3D qemu_ram_block_by_name(block_name);
>      if (!rb) {
> -        error_report("%s: block '%s' not found", __func__, block_name);
> +        error_setg(errp, "block '%s' not found", block_name);
>          return -EINVAL;
>      }
>=20=20
> @@ -2642,11 +2645,7 @@ static int loadvm_process_command(QEMUFile *f, Err=
or **errp)
>          return 0;
>=20=20
>      case MIG_CMD_RECV_BITMAP:
> -        ret =3D loadvm_handle_recv_bitmap(mis, len);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to load device state command: %d", =
ret);
> -        }
> -        return ret;
> +        return loadvm_handle_recv_bitmap(mis, len, errp);
>=20=20
>      case MIG_CMD_ENABLE_COLO:
>          ret =3D loadvm_process_enable_colo(mis);

