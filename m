Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AC7CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 18:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umzdk-0001qG-Db; Fri, 15 Aug 2025 14:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzdi-0001pZ-Nw
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:58:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umzdh-0006Ls-2l
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 14:58:58 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD741F770;
 Fri, 15 Aug 2025 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755284335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz2IivKvbgJ/qldyzxuejnkKq6v3ytC8+TWh+3z3jFo=;
 b=cTNrwV4vWCnA3deMuylHGMC8xNcyJUhJ/NjGDMSAnvON6hW6hzqXQpoB/SPUd3M1B1XHYW
 R2/r5tSdEy4DisKk5O3jK0nuV1kkKC8pH56yfMPxGDBxNREYWnumy4qCuVwIZuJQ9uyYSL
 Biywr8idzQcUleooYxjI0EVJYB9mQYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755284335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz2IivKvbgJ/qldyzxuejnkKq6v3ytC8+TWh+3z3jFo=;
 b=TQNa7EIRvY6on969ESCObt/11O6puSZ2R7Iv6uuKdysvuu4JSzsTrXGC1MMIv4f3jWlWOQ
 jzfWzCS69ADamHAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q2Tp38ff;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0JfjUtLv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755284334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz2IivKvbgJ/qldyzxuejnkKq6v3ytC8+TWh+3z3jFo=;
 b=q2Tp38ff7qz9eLGgs7PwjDYmHOEQou8MFesZLpZn8iSfnyI0tpHpQVmZdJf6A/eBiJuAff
 +7DOjA4NYaDQLk6aPMsebq59wTJuHMpsXlvltE42ET9vQjc9sldnS/za+eOQeE7aEK31AZ
 o+QT5DINynGPC+JAQWr4Ucvt11BLH2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755284334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wz2IivKvbgJ/qldyzxuejnkKq6v3ytC8+TWh+3z3jFo=;
 b=0JfjUtLvpG06N7vD4apitQnVWyodb5iQn0vy6lOLJu8WvQoxkAloWO7fMTKGCmUqoBFcWw
 wwFWNcSQjZl5/UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 529C51368C;
 Fri, 15 Aug 2025 18:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GS7WE22Dn2iTTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 18:58:53 +0000
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
Subject: Re: [PATCH v11 08/27] migration: push Error **errp into
 qemu_load_device_state()
In-Reply-To: <20250813-propagate_tpm_error-v11-8-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-8-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 15:58:50 -0300
Message-ID: <877bz4za1h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim]
X-Rspamd-Queue-Id: 1FD741F770
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
> It is ensured that qemu_load_device_state() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/colo.c   | 4 ++--
>  migration/savevm.c | 5 +++--
>  migration/savevm.h | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index e0f713c837f5da25d67afbd02ceb6c54024ca3af..0ba22ee76a13e313793f653f4=
3a728e3c433bbc1 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -729,9 +729,9 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
>      bql_lock();
>      vmstate_loading =3D true;
>      colo_flush_ram_cache();
> -    ret =3D qemu_load_device_state(fb);
> +    ret =3D qemu_load_device_state(fb, errp);
>      if (ret < 0) {
> -        error_setg(errp, "COLO: load device state failed");
> +        error_prepend(errp, "COLO: load device state failed: ");

This will say: "COLO: load device state failed: Failed to load device
state: %d"

Just remove it.

>          vmstate_loading =3D false;
>          bql_unlock();
>          return;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 05dc392bdf4e19f340bc72bf66ba0543d56868a5..70e021597d884030c4a0dc2a7=
bc27d42a7371797 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3263,15 +3263,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>      return ret;
>  }
>=20=20
> -int qemu_load_device_state(QEMUFile *f)
> +int qemu_load_device_state(QEMUFile *f, Error **errp)
>  {
> +    ERRP_GUARD();

Is this needed here?

>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      int ret;
>=20=20
>      /* Load QEMU_VM_SECTION_FULL section */
>      ret =3D qemu_loadvm_state_main(f, mis);
>      if (ret < 0) {
> -        error_report("Failed to load device state: %d", ret);
> +        error_setg(errp, "Failed to load device state: %d", ret);
>          return ret;
>      }
>=20=20
> diff --git a/migration/savevm.h b/migration/savevm.h
> index b80770b7461a60e2ad6ba5e24a7baeae73d90955..b12681839f0b1afa3255e4521=
5d99c13a224b19f 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> -int qemu_load_device_state(QEMUFile *f);
> +int qemu_load_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy);

