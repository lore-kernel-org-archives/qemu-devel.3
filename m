Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90447CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un07i-0007jy-NG; Fri, 15 Aug 2025 15:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un07g-0007i1-Il
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:29:56 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un07e-0004wj-M6
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:29:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEE3B2122E;
 Fri, 15 Aug 2025 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755286192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb9Wd6qlSB+Gdx1zO3a/cL+Cn5lQLUZAiUtWsNZsyWY=;
 b=bON75hUC3JyQavle75WRKCWgDK9O1E/6U8ZLd1bSo/SR0GBHB7oBVPnzONS/TT35GMhgiA
 Xi1LbIuNzSAfd/MfC8uN3Jy9UIW7ujPOmmCaRBjK1SnFJ2GtJeZdhhPDOH2jx9wyjvfRBi
 4ERakX5rP6wfwk24ZvOT51nec6Ed4zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755286192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb9Wd6qlSB+Gdx1zO3a/cL+Cn5lQLUZAiUtWsNZsyWY=;
 b=yB3xHZuiWPYFcDRl4mn7hMLvx8nGEiMtBgcSrivKjl8K5XK3dc8MqDYYILFJotCYXF/umr
 0k5IVol22/hqrOBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755286192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb9Wd6qlSB+Gdx1zO3a/cL+Cn5lQLUZAiUtWsNZsyWY=;
 b=bON75hUC3JyQavle75WRKCWgDK9O1E/6U8ZLd1bSo/SR0GBHB7oBVPnzONS/TT35GMhgiA
 Xi1LbIuNzSAfd/MfC8uN3Jy9UIW7ujPOmmCaRBjK1SnFJ2GtJeZdhhPDOH2jx9wyjvfRBi
 4ERakX5rP6wfwk24ZvOT51nec6Ed4zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755286192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb9Wd6qlSB+Gdx1zO3a/cL+Cn5lQLUZAiUtWsNZsyWY=;
 b=yB3xHZuiWPYFcDRl4mn7hMLvx8nGEiMtBgcSrivKjl8K5XK3dc8MqDYYILFJotCYXF/umr
 0k5IVol22/hqrOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BA331368C;
 Fri, 15 Aug 2025 19:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r1x/ArCKn2inVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 19:29:52 +0000
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
Subject: Re: [PATCH v11 10/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
In-Reply-To: <20250813-propagate_tpm_error-v11-10-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-10-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 16:29:49 -0300
Message-ID: <871ppcz8lu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[32];
 TAGGED_RCPT(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL96jwb13nk98k7j3ws9zhxhn8)];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
> It is ensured that qemu_loadvm_section_start_full() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9ec07892cd6ea666431410657c840b6325377d97..77408347c1f1ca7eb3a04f8f1=
30c20a5a81f6db2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2724,21 +2724,21 @@ static bool check_section_footer(QEMUFile *f, Sav=
eStateEntry *se)
>  }
>=20=20
>  static int
> -qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
> +qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
>  {
> +    ERRP_GUARD();
>      bool trace_downtime =3D (type =3D=3D QEMU_VM_SECTION_FULL);
>      uint32_t instance_id, version_id, section_id;
>      int64_t start_ts, end_ts;
>      SaveStateEntry *se;
>      char idstr[256];
>      int ret;
> -    Error *local_err =3D NULL;
>=20=20
>      /* Read section start */
>      section_id =3D qemu_get_be32(f);
>      if (!qemu_get_counted_string(f, idstr)) {
> -        error_report("Unable to read ID string for section %u",
> -                     section_id);
> +        error_setg(errp, "Unable to read ID string for section %u",
> +                   section_id);
>          return -EINVAL;
>      }
>      instance_id =3D qemu_get_be32(f);
> @@ -2746,8 +2746,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>=20=20
>      ret =3D qemu_file_get_error(f);
>      if (ret) {
> -        error_report("%s: Failed to read instance/version ID: %d",
> -                     __func__, ret);
> +        error_setg(errp, "Failed to read instance/version ID: %d", ret);
>          return ret;
>      }
>=20=20
> @@ -2756,17 +2755,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8=
_t type)
>      /* Find savevm section */
>      se =3D find_se(idstr, instance_id);
>      if (se =3D=3D NULL) {
> -        error_report("Unknown savevm section or instance '%s' %"PRIu32".=
 "
> -                     "Make sure that your current VM setup matches your "
> -                     "saved VM setup, including any hotplugged devices",
> -                     idstr, instance_id);
> +        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu=
32". "

Drop the "savevm" please.

> +                   "Make sure that your current VM setup matches your "
> +                   "saved VM setup, including any hotplugged devices",
> +                   idstr, instance_id);
>          return -EINVAL;
>      }
>=20=20
>      /* Validate version */
>      if (version_id > se->version_id) {
> -        error_report("savevm: unsupported version %d for '%s' v%d",
> -                     version_id, idstr, se->version_id);
> +        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",

Same.

> +                   version_id, idstr, se->version_id);
>          return -EINVAL;
>      }
>      se->load_version_id =3D version_id;
> @@ -2774,7 +2773,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>=20=20
>      /* Validate if it is a device's state */
>      if (xen_enabled() && se->is_ram) {
> -        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
> +        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", id=
str);
>          return -EINVAL;
>      }
>=20=20
> @@ -2782,11 +2781,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8=
_t type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>=20=20
> -    ret =3D vmstate_load(f, se, &local_err);
> +    ret =3D vmstate_load(f, se, errp);
>      if (ret < 0) {
> -        error_report("error while loading state for instance 0x%"PRIx32"=
 of"
> -                     " device '%s'", instance_id, idstr);
> -        warn_report_err(local_err);
> +        error_prepend(errp,
> +                      "error while loading state for instance 0x%"PRIx32=
" of"
> +                      " device '%s': ", instance_id, idstr);
>          return ret;
>      }
>=20=20
> @@ -2797,6 +2796,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>      }
>=20=20
>      if (!check_section_footer(f, se)) {
> +        error_setg(errp, "Reading footer section of instance "
> +                   "0x%"PRIx32" of device '%s' for version_id: %d failed=
",
> +                   instance_id, idstr, version_id);

check_section_footer() already has messages saying something went wrong
with the footer. Make sure you're not duplicating information. If
necessary, trim it either here or there.

>          return -EINVAL;
>      }
>=20=20
> @@ -3103,7 +3105,7 @@ retry:
>          switch (section_type) {
>          case QEMU_VM_SECTION_START:
>          case QEMU_VM_SECTION_FULL:
> -            ret =3D qemu_loadvm_section_start_full(f, section_type);
> +            ret =3D qemu_loadvm_section_start_full(f, section_type, errp=
);
>              if (ret < 0) {
>                  goto out;
>              }

