Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4A1CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 21:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uydJq-00070T-OB; Tue, 16 Sep 2025 17:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uydJo-0006vO-7S
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 17:34:32 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uydJm-0003tW-JA
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 17:34:31 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4E3E21B0F;
 Tue, 16 Sep 2025 21:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758058469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOUv4+E6b40H4Sc+AWBh8+q3R5YyfMPkJ8TgRPyUA8g=;
 b=IWUimZ1FIhgXT9hcjO6dz6L79KEbNxP5QcMMvdUabvx8QE/bshif7/OLSxuU7hDH0hmncd
 ybgz2oHbm+uOcTIaZbKBIhHANEP7l7HvIHPUXB8WoXMfRb4oFrf/djRZcAlmSzOTiZO9Ah
 bTg6W1KPYpnJbohPdlD1c8N6ZLbigBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758058469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOUv4+E6b40H4Sc+AWBh8+q3R5YyfMPkJ8TgRPyUA8g=;
 b=muYc4RzN+CI8Q3N6Mpj+AORkEY9D8a8gDd0iLwVUIFGi6NJmyrFqqep/ifXeRhkJVHiJ77
 v+VfDNRzMWk9EjDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WEMvPHnI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LxYb0ATj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758058467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOUv4+E6b40H4Sc+AWBh8+q3R5YyfMPkJ8TgRPyUA8g=;
 b=WEMvPHnIZzmcPMyM1P3FGpYqNExSyANgO/unFMJv13EDFihawyfc6PH77VPhospSvSp5MX
 nNoBg11iLakTsgjV/tYltsIwKzggs389mQ+7Y9vgKmQmWUmsh+w/J+Fra70NpZXlCm7QKI
 A1m93tUpOMUEwLbcPODSjT+0WZnh6ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758058467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOUv4+E6b40H4Sc+AWBh8+q3R5YyfMPkJ8TgRPyUA8g=;
 b=LxYb0ATj6QolxKoGCkEWnyKpgk6k+T4L2ySEC4D5GP3wMYlllDdF13AOJ6TLJPobuYn35/
 tfjc2qnxTnPLqMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A851139CB;
 Tue, 16 Sep 2025 21:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uajDOeLXyWhkTwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Sep 2025 21:34:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater <clg@redhat.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
Subject: Re: [PATCH RFC 1/9] migration/vfio: Remove BQL implication in
 vfio_multifd_switchover_start()
In-Reply-To: <20250827205949.364606-2-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-2-peterx@redhat.com>
Date: Tue, 16 Sep 2025 18:34:24 -0300
Message-ID: <87wm5yw07z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[16]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com,maciej.szmigiero.name];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Queue-Id: C4E3E21B0F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> We may switch to a BQL-free loadvm model.  Be prepared with it.
>
> Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/vfio/migration-multifd.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index e4785031a7..8dc8444f0d 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -763,16 +763,21 @@ int vfio_multifd_switchover_start(VFIODevice *vbase=
dev)
>  {
>      VFIOMigration *migration =3D vbasedev->migration;
>      VFIOMultifd *multifd =3D migration->multifd;
> +    bool bql_is_locked =3D bql_locked();
>=20=20
>      assert(multifd);
>=20=20
>      /* The lock order is load_bufs_mutex -> BQL so unlock BQL here first=
 */
> -    bql_unlock();
> +    if (bql_is_locked) {
> +        bql_unlock();
> +    }
>      WITH_QEMU_LOCK_GUARD(&multifd->load_bufs_mutex) {
>          assert(!multifd->load_bufs_thread_running);
>          multifd->load_bufs_thread_running =3D true;
>      }
> -    bql_lock();
> +    if (bql_is_locked) {
> +        bql_lock();
> +    }
>=20=20
>      qemu_loadvm_start_load_thread(vfio_load_bufs_thread, vbasedev);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

