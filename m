Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2065DCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umvfr-00076v-BX; Fri, 15 Aug 2025 10:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umvfo-00075o-TE
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:44:52 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1umvfi-0003NR-EB
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:44:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5237218F1;
 Fri, 15 Aug 2025 14:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755269075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL96MnuKzwqs3AXNCH/fSKgogjHHAABXMZ78eG0R0G4=;
 b=pyAuhhZt9ai0hlxS9FdBdDmlvC6h810mvC/QRrS5QVemgNT0dQn3KBpqvaoOhuKP8B38Ua
 KlqcwXYj0wNAt/x5XiZPl/kcEetmqTM5pmPP0Q0RGs8Q5Iqt4jA9E8/8AF+yV17uwtSEUL
 RmOsUz0wQWpZsWk0o5qk4n7EaOvTx6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755269075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL96MnuKzwqs3AXNCH/fSKgogjHHAABXMZ78eG0R0G4=;
 b=EvKxa9/D8WGkl8OTiyWtSTrDqVtqnD+LGXkrZQ647aSnXbu8BUu+zowcUIgr/MipxrdAin
 dWSuqoWY3W9u7RBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KDtSwxab;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7SLbOEUu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755269073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL96MnuKzwqs3AXNCH/fSKgogjHHAABXMZ78eG0R0G4=;
 b=KDtSwxabrLvURlojp9Le5Rp9OVRl6aU/JFhsuh4MjQmtvwK8Wq4U+Sfz5YPXKfe8Rj1aX5
 bQ8sKvMEWEr1zJNSUsClZ7YuJbyESwfh8SezUfAROMFS9UC4Ue8TP+u6cAt7+/Zkn9opZQ
 mJtEu5NCKi9aUJmFyXuYrDU1y9grxg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755269073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL96MnuKzwqs3AXNCH/fSKgogjHHAABXMZ78eG0R0G4=;
 b=7SLbOEUuc0wWI5Tmzlz2akqM1lOSE2WfSydea+8G46i1ZlMr6CMPFcOQMun6G+FOizjdqE
 V6E7VoLJnytxI2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1681213876;
 Fri, 15 Aug 2025 14:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dLZvBdFHn2j4CwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 15 Aug 2025 14:44:33 +0000
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
Subject: Re: [PATCH v11 01/27] migration: push Error **errp into
 vmstate_subsection_load()
In-Reply-To: <20250813-propagate_tpm_error-v11-1-b470a374b42d@redhat.com>
References: <20250813-propagate_tpm_error-v11-0-b470a374b42d@redhat.com>
 <20250813-propagate_tpm_error-v11-1-b470a374b42d@redhat.com>
Date: Fri, 15 Aug 2025 11:44:30 -0300
Message-ID: <87qzxczltd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D5237218F1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[32];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linaro.org,rsg.ci.i.u-tokyo.ac.jp,collabora.com,gmail.com,linux.ibm.com,euphon.net,oracle.com,nongnu.org,xfusion.com,linux.vnet.ibm.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLzasi9boc9ahn35s1z6tc8qwy)];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
> It is ensured that vmstate_subsection_load() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/vmstate.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 5feaa3244d259874f03048326b2497e7db32e47c..6108c7fe283a5013ce42ea998=
7723c489aef26a2 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const V=
MStateDescription *vmsd,
>                                     void *opaque, JSONWriter *vmdesc,
>                                     Error **errp);
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription=
 *vmsd,
> -                                   void *opaque);
> +                                   void *opaque, Error **errp);
>=20=20
>  /* Whether this field should exist for either save or load the VM? */
>  static bool
> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDesc=
ription *vmsd,
>          field++;
>      }
>      assert(field->flags =3D=3D VMS_END);
> -    ret =3D vmstate_subsection_load(f, vmsd, opaque);
> +    ret =3D vmstate_subsection_load(f, vmsd, opaque, &error_fatal);
>      if (ret !=3D 0) {
>          qemu_file_set_error(f, ret);
>          return ret;

This is now unreachable, no?

> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * con=
st *sub,
>  }
>=20=20
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription=
 *vmsd,
> -                                   void *opaque)
> +                                   void *opaque, Error **errp)
>  {
>      trace_vmstate_subsection_load(vmsd->name);
>=20=20
> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const=
 VMStateDescription *vmsd,
>          sub_vmsd =3D vmstate_get_subsection(vmsd->subsections, idstr);
>          if (sub_vmsd =3D=3D NULL) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(looku=
p)");
> +            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
> +                       idstr, vmsd->name);
>              return -ENOENT;
>          }
>          qemu_file_skip(f, 1); /* subsection */
> @@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const=
 VMStateDescription *vmsd,
>          ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id);
>          if (ret) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child=
)");
> +            error_setg(errp,
> +                       "Loading VM subsection '%s' in '%s' failed: %d",
> +                       idstr, vmsd->name, ret);
>              return ret;
>          }
>      }

