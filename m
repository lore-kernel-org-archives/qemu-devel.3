Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F2C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 22:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6e8Y-0005Db-Ml; Mon, 13 May 2024 18:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6e8X-0005DM-85
 for qemu-devel@nongnu.org; Mon, 13 May 2024 18:27:13 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s6e8V-0002p7-Ik
 for qemu-devel@nongnu.org; Mon, 13 May 2024 18:27:12 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2FDF5D671;
 Mon, 13 May 2024 22:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715639229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WEmrC+NUuZeqCd5Rd/mRk4Gc0bFiVaaqTNlqv1d7wY=;
 b=EwzwyH05r8rnddGrED1drL2F4mXbbhidL74jZJwYqq3BHj4TXOJ+upTUAzR6SADsRQZoTZ
 3IkzPrvd73xAmnwuBitVPAgse3SyDea7CcIL79PgSObfEHLH8CZzSLlpARcY1r3ML3kaG9
 w+/WiHOpUvjEIIqwpt2CoYU1xmSPANI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715639229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WEmrC+NUuZeqCd5Rd/mRk4Gc0bFiVaaqTNlqv1d7wY=;
 b=f6OfuAZoaZi4tjCUVHszcKnSMEE0KhBNl5Ac1JwNJEwKpA/+7kieIQCCA1X6tDGrMUQkQc
 fhGk1hkLIgMUZxDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EwzwyH05;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=f6OfuAZo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715639229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WEmrC+NUuZeqCd5Rd/mRk4Gc0bFiVaaqTNlqv1d7wY=;
 b=EwzwyH05r8rnddGrED1drL2F4mXbbhidL74jZJwYqq3BHj4TXOJ+upTUAzR6SADsRQZoTZ
 3IkzPrvd73xAmnwuBitVPAgse3SyDea7CcIL79PgSObfEHLH8CZzSLlpARcY1r3ML3kaG9
 w+/WiHOpUvjEIIqwpt2CoYU1xmSPANI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715639229;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WEmrC+NUuZeqCd5Rd/mRk4Gc0bFiVaaqTNlqv1d7wY=;
 b=f6OfuAZoaZi4tjCUVHszcKnSMEE0KhBNl5Ac1JwNJEwKpA/+7kieIQCCA1X6tDGrMUQkQc
 fhGk1hkLIgMUZxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3277E1372E;
 Mon, 13 May 2024 22:27:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NKpjOryTQmZYQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 May 2024 22:27:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/4] migration: fix a typo
In-Reply-To: <20240513071905.499143-3-marcandre.lureau@redhat.com>
References: <20240513071905.499143-1-marcandre.lureau@redhat.com>
 <20240513071905.499143-3-marcandre.lureau@redhat.com>
Date: Mon, 13 May 2024 19:27:06 -0300
Message-ID: <87wmnxe4at.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B2FDF5D671
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,huawei.com,linaro.org,habkost.net];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/vmstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index b51212a75b..ff5d589a6d 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -479,7 +479,7 @@ static int vmstate_subsection_load(QEMUFile *f, const=
 VMStateDescription *vmsd,
>=20=20
>          len =3D qemu_peek_byte(f, 1);
>          if (len < strlen(vmsd->name) + 1) {
> -            /* subsection name has be be "section_name/a" */
> +            /* subsection name has to be "section_name/a" */
>              trace_vmstate_subsection_load_bad(vmsd->name, "(short)", "");
>              return 0;
>          }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

