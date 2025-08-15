Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4608CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un0DO-0000sD-R6; Fri, 15 Aug 2025 15:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un0DJ-0000qY-6y
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:35:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1un0DG-0005l9-06
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 15:35:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92AE51F770;
 Fri, 15 Aug 2025 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755286539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlAv3bDRsFL3ZkVTifourGvRe2V3h6w8s+32q250rIE=;
 b=J9KLz368HFS16hNQelTUNR9RV02WRxUdTW7iJ/EzMTlzPzn7fTMerxAKTqprnRbQqL2evt
 Y4z2AzeynfZzOQSE3uh98O2oL1jzvspYMejJcB6vn1WvgRwY+/fyMY4RRDduqexhHKABgj
 8K0LRtio+lcYnfwtCtsH83VJBRjsCWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755286539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlAv3bDRsFL3ZkVTifourGvRe2V3h6w8s+32q250rIE=;
 b=yTH6V4otJt3UKRFUF2ugkYVI3SUSrCoPzB309bgz+nge45Zx6CaxLZiurQTc+e8q0VB3cF
 Z+P1XaRZaixAT3Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J9KLz368;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yTH6V4ot
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755286539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlAv3bDRsFL3ZkVTifourGvRe2V3h6w8s+32q250rIE=;
 b=J9KLz368HFS16hNQelTUNR9RV02WRxUdTW7iJ/EzMTlzPzn7fTMerxAKTqprnRbQqL2evt
 Y4z2AzeynfZzOQSE3uh98O2oL1jzvspYMejJcB6vn1WvgRwY+/fyMY4RRDduqexhHKABgj
 8K0LRtio+lcYnfwtCtsH83VJBRjsCWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755286539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlAv3bDRsFL3ZkVTifourGvRe2V3h6w8s+32q250rIE=;
 b=yTH6V4otJt3UKRFUF2ugkYVI3SUSrCoPzB309bgz+nge45Zx6CaxLZiurQTc+e8q0VB3cF
 Z+P1XaRZaixAT3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C781F1368C;
 Fri, 15 Aug 2025 19:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GBlhMAqMn2glVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 19:35:38 +0000
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
Subject: Re: [PATCH v11 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
In-Reply-To: <20250813-propagate_tpm_error-v11-11-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-11-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 16:35:36 -0300
Message-ID: <87y0rkxtrr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 92AE51F770
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
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
> It is ensured that qemu_loadvm_section_part_end() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 77408347c1f1ca7eb3a04f8f130c20a5a81f6db2..ff2e4f75e070d0f452414f284=
35905928b1480a7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2806,21 +2806,20 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8=
_t type, Error **errp)
>  }
>=20=20
>  static int
> -qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> +qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
>  {
> +    ERRP_GUARD();
>      bool trace_downtime =3D (type =3D=3D QEMU_VM_SECTION_END);
>      int64_t start_ts, end_ts;
>      uint32_t section_id;
>      SaveStateEntry *se;
>      int ret;
> -    Error *local_err =3D NULL;
>=20=20
>      section_id =3D qemu_get_be32(f);
>=20=20
>      ret =3D qemu_file_get_error(f);
>      if (ret) {
> -        error_report("%s: Failed to read section ID: %d",
> -                     __func__, ret);
> +        error_setg(errp, "Failed to read section ID: %d", ret);
>          return ret;
>      }
>=20=20
> @@ -2831,7 +2830,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t t=
ype)
>          }
>      }
>      if (se =3D=3D NULL) {
> -        error_report("Unknown savevm section %d", section_id);
> +        error_setg(errp, "Unknown savevm section %d", section_id);

Drop "savevm" please.

>          return -EINVAL;
>      }
>=20=20
> @@ -2839,11 +2838,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t=
 type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>=20=20
> -    ret =3D vmstate_load(f, se, &local_err);
> +    ret =3D vmstate_load(f, se, errp);
>      if (ret < 0) {
> -        error_report("error while loading state section id %d(%s)",
> -                     section_id, se->idstr);
> -        warn_report_err(local_err);
> +        error_prepend(errp, "error while loading state section id %d(%s)=
: ",
> +                      section_id, se->idstr);
>          return ret;
>      }
>=20=20
> @@ -2854,6 +2852,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t t=
ype)
>      }
>=20=20
>      if (!check_section_footer(f, se)) {
> +        error_setg(errp, "Check section footer error, section_id: %d",

This became not very grammatical, maybe drop the "Check" word.

> +                   section_id);
>          return -EINVAL;
>      }
>=20=20
> @@ -3112,7 +3112,7 @@ retry:
>              break;
>          case QEMU_VM_SECTION_PART:
>          case QEMU_VM_SECTION_END:
> -            ret =3D qemu_loadvm_section_part_end(f, section_type);
> +            ret =3D qemu_loadvm_section_part_end(f, section_type, errp);
>              if (ret < 0) {
>                  goto out;
>              }
> @@ -3136,9 +3136,6 @@ retry:
>=20=20
>  out:
>      if (ret < 0) {
> -        if (*errp =3D=3D NULL) {
> -            error_setg(errp, "Loading VM state failed: %d", ret);
> -        }

Good. Could have been mentioned in that patch's commit message, or even
a /* temporary */ comment in the code.

>          qemu_file_set_error(f, ret);
>=20=20
>          /* Cancel bitmaps incoming regardless of recovery */

