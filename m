Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B5C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukN8J-00037x-DI; Fri, 08 Aug 2025 09:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ukN8H-00035E-Em
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:27:41 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ukN8F-00062f-AE
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:27:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CEA133E0F;
 Fri,  8 Aug 2025 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754659656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/Rc7pb0nED1cajEqoPbDSX6u6ouBN4o7M4iA1Hzeu0=;
 b=wPJkhSVpCQMQSSGqu0Auy891ZhWZzduJSUtVSTVi7zg1dFHcwx6uJayDtLdq42nPLGVtNs
 mFb6ULqSHyX77/7nKM9SGoy0UkjzZ0sTnj4Ulr0SFgx7in10JeBf0ZfDX9SCxzum1aSzHp
 2nmBpbe1DwMYmDid2FTPA84VjbDFdIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754659656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/Rc7pb0nED1cajEqoPbDSX6u6ouBN4o7M4iA1Hzeu0=;
 b=7NrW1DLZT0A+SfVV1Kess3GW905ticTDB//naswgS1E3MuUn2Y0O5nwrF5zwDWPh3mK1/S
 vR+wYUtyzClyw4Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wPJkhSVp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7NrW1DLZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754659656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/Rc7pb0nED1cajEqoPbDSX6u6ouBN4o7M4iA1Hzeu0=;
 b=wPJkhSVpCQMQSSGqu0Auy891ZhWZzduJSUtVSTVi7zg1dFHcwx6uJayDtLdq42nPLGVtNs
 mFb6ULqSHyX77/7nKM9SGoy0UkjzZ0sTnj4Ulr0SFgx7in10JeBf0ZfDX9SCxzum1aSzHp
 2nmBpbe1DwMYmDid2FTPA84VjbDFdIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754659656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/Rc7pb0nED1cajEqoPbDSX6u6ouBN4o7M4iA1Hzeu0=;
 b=7NrW1DLZT0A+SfVV1Kess3GW905ticTDB//naswgS1E3MuUn2Y0O5nwrF5zwDWPh3mK1/S
 vR+wYUtyzClyw4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCC811392A;
 Fri,  8 Aug 2025 13:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sx/oMUf7lWjtIgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Aug 2025 13:27:35 +0000
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
 <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>
Subject: Re: [PATCH v9 22/27] migration: Capture error in
 postcopy_ram_listen_thread()
In-Reply-To: <20250805-propagate_tpm_error-v9-22-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-22-123450810db7@redhat.com>
Date: Fri, 08 Aug 2025 10:27:33 -0300
Message-ID: <87wm7e0wqi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9CEA133E0F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[30];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
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
> postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
> to load the vm, and in case of a failure, it should set the error
> in the migration object.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c89fa59161fd1c4f20d0c3f8f14e86f014223dd6..4df50fb5c674e56c0173c357c=
1e23367373e2114 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      QEMUFile *f =3D mis->from_src_file;
>      int load_res;
>      MigrationState *migr =3D migrate_get_current();
> +    Error *local_err =3D NULL;
>=20=20
>      object_ref(OBJECT(migr));
>=20=20
> @@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaqu=
e)
>      qemu_file_set_blocking(f, true);
>=20=20
>      /* TODO: sanity check that only postcopiable data will be loaded her=
e */
> -    load_res =3D qemu_loadvm_state_main(f, mis, NULL);
> +    load_res =3D qemu_loadvm_state_main(f, mis, &local_err);
>=20=20
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2137,7 +2138,12 @@ static void *postcopy_ram_listen_thread(void *opaq=
ue)
>                           __func__, load_res);
>              load_res =3D 0; /* prevent further exit() */
>          } else {
> -            error_report("%s: loadvm failed: %d", __func__, load_res);
> +            if (local_err !=3D NULL) {

This should always be true. I presume the conditional goes away at the
end of the series. Could have been mentioned in the commit message.

> +                error_prepend(&local_err,
> +                              "loadvm failed during postcopy: %d: ", loa=
d_res);
> +                migrate_set_error(migr, local_err);
> +                error_report_err(local_err);
> +            }
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACT=
IVE,
>                                             MIGRATION_STATUS_FAILED);
>          }

