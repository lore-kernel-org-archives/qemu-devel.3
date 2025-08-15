Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D9CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umxV1-0003TB-0N; Fri, 15 Aug 2025 12:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umxUy-0003ST-Dp
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:41:48 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umxUw-0004P9-5z
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:41:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0208B21896;
 Fri, 15 Aug 2025 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755276104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6wDelU08xVrBuLNt69UlLow3uk8FnPmEm4Q3NQEL8I=;
 b=QmE/kU2VNl5jaMBJ9BPdTW0WGqU6SMsfGGK2qbyNaR61a/KSLW7lCSI3kTfBj0C7KCLagK
 7Vm7E93Vz6ptLypQ/dn/oignb0L16v22u7G7O2SL1bkrBa47ctskb8Zb+awqCpGWRSyuC/
 A2a3E28XtY/TkAUOH81ozorQ35basGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755276104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6wDelU08xVrBuLNt69UlLow3uk8FnPmEm4Q3NQEL8I=;
 b=bLXI7QaQFxW3bD9S6eOExo6lylSiZuHnPh2lg4CE7sxC8iO1yGzSTlmyPR9oCEDo2jqmss
 t9VX+R9aIOqsKtAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QmE/kU2V";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bLXI7QaQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755276104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6wDelU08xVrBuLNt69UlLow3uk8FnPmEm4Q3NQEL8I=;
 b=QmE/kU2VNl5jaMBJ9BPdTW0WGqU6SMsfGGK2qbyNaR61a/KSLW7lCSI3kTfBj0C7KCLagK
 7Vm7E93Vz6ptLypQ/dn/oignb0L16v22u7G7O2SL1bkrBa47ctskb8Zb+awqCpGWRSyuC/
 A2a3E28XtY/TkAUOH81ozorQ35basGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755276104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6wDelU08xVrBuLNt69UlLow3uk8FnPmEm4Q3NQEL8I=;
 b=bLXI7QaQFxW3bD9S6eOExo6lylSiZuHnPh2lg4CE7sxC8iO1yGzSTlmyPR9oCEDo2jqmss
 t9VX+R9aIOqsKtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 388DA13876;
 Fri, 15 Aug 2025 16:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YbS2DUdjn2g2LAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 16:41:43 +0000
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
Subject: Re: [PATCH v11 04/27] migration: push Error **errp into vmstate_load()
In-Reply-To: <20250813-propagate_tpm_error-v11-4-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-4-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 13:41:40 -0300
Message-ID: <87ikiozge3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0208B21896
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[32];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> It is ensured that vmstate_load() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0c445a957fc99f826e6753ed3795bcdd51f1e3f5..7f79461844105bf672314c332=
5caee9cdb654c27 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMSta=
teDescription *vmsd,
>      }
>  }
>=20=20
> -static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
> +static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
>  {
> +    int ret;
>      trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
>      if (!se->vmsd) {         /* Old style */
> -        return se->ops->load_state(f, se->opaque, se->load_version_id);
> +        ret =3D se->ops->load_state(f, se->opaque, se->load_version_id);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load VM version_id: %d, ret: %d",

"VM" is ambiguous. I'd use "vmstate".

> +                       se->load_version_id, ret);
> +        }
> +        return ret;
>      }
>      return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_=
id,
> -                              &error_fatal);
> +                              errp);
>  }
>=20=20
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -2692,6 +2698,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t=
 type)
>      SaveStateEntry *se;
>      char idstr[256];
>      int ret;
> +    Error *local_err =3D NULL;
>=20=20
>      /* Read section start */
>      section_id =3D qemu_get_be32(f);
> @@ -2741,10 +2748,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8=
_t type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>=20=20
> -    ret =3D vmstate_load(f, se);
> +    ret =3D vmstate_load(f, se, &local_err);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%"PRIx32"=
 of"
>                       " device '%s'", instance_id, idstr);
> +        warn_report_err(local_err);

I was about to ask why you're using a warning here, but I see you remove
it futher in the series. That's fine, but this kind of thing should be
mentioned in the commit message, otherwise it gets confusing to review.

>          return ret;
>      }
>=20=20
> @@ -2769,6 +2777,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t t=
ype)
>      uint32_t section_id;
>      SaveStateEntry *se;
>      int ret;
> +    Error *local_err =3D NULL;
>=20=20
>      section_id =3D qemu_get_be32(f);
>=20=20
> @@ -2794,10 +2803,11 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t=
 type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>=20=20
> -    ret =3D vmstate_load(f, se);
> +    ret =3D vmstate_load(f, se, &local_err);
>      if (ret < 0) {
>          error_report("error while loading state section id %d(%s)",
>                       section_id, se->idstr);
> +        warn_report_err(local_err);
>          return ret;
>      }

