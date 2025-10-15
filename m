Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A0CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8vM0-00064B-Qp; Wed, 15 Oct 2025 02:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8vLv-00060L-Qk
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8vLm-0006Yj-MX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760511060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSfG0NqaRnNUVKtxyIGboE3igl5APS9ywaC73/1XTsc=;
 b=gNA+6AlmBcWzvBn/w/3l8AN44Kx9FcP9GxTcgK81ehy82dKWOYktQb7jYEqPJA0iGEPvsu
 RB9vqw/cruvRnR1CB4RzfBype17IDL7uHqozLC90dAb1E7zIH4AqEpCi9HM5ANpj421F9a
 Zj8gkS/bgVqYX1ZNiLY9zCK3opphjz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-MGlR7AekOWO33KNZn789Wg-1; Wed,
 15 Oct 2025 02:50:57 -0400
X-MC-Unique: MGlR7AekOWO33KNZn789Wg-1
X-Mimecast-MFC-AGG-ID: MGlR7AekOWO33KNZn789Wg_1760511056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51626195608E; Wed, 15 Oct 2025 06:50:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7138E30001A1; Wed, 15 Oct 2025 06:50:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C147A21E6A27; Wed, 15 Oct 2025 08:50:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 armbru@redhat.com,  yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
In-Reply-To: <20251014152644.954762-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Oct 2025 18:26:42 +0300")
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-6-vsementsov@yandex-team.ru>
Date: Wed, 15 Oct 2025 08:50:51 +0200
Message-ID: <87y0pcirp0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We'll need a possibility to postpone connect step to later point in
> time to implement backend-transfer migration feature for vhost-user-blk
> in further commits. Let's start with new char interface for backends.
>
> .init() takes QAPI parameters and should parse them, called early
>
> .connect() should actually establish a connection, and postponed to
> the point of attaching to frontend. Called at later point, either
> at time of attaching frontend, either from qemu_chr_wait_connected().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 429852f8d9..ebadaf3482 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -63,6 +63,7 @@ struct Chardev {
>      CharBackend *be;
>      char *label;
>      char *filename;
> +    bool connect_postponed;
>      int logfd;
>      int be_open;
>      /* used to coordinate the chardev-change special-case: */
> @@ -225,6 +226,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
>                                  bool permit_mux_mon);
>  int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_a=
ll);
>  #define qemu_chr_write_all(s, buf, len) qemu_chr_write(s, buf, len, true)
> +bool qemu_chr_connect(Chardev *chr, Error **errp);
>  int qemu_chr_wait_connected(Chardev *chr, Error **errp);
>=20=20
>  #define TYPE_CHARDEV "chardev"
> @@ -259,10 +261,28 @@ struct ChardevClass {
>      /* parse command line options and populate QAPI @backend */
>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
>=20=20
> -    /* called after construction, open/starts the backend */
> +    /*
> +     * Called after construction, create and open/starts the backend,

What to do mean by "create and open/starts"?

Maybe "create and start"?

> +     * mutual exclusive with .init. .connect must not be defined when

mutually

> +     * .open is defined.
> +     */

Suggest to use @name to refer to a member name.  We do that elsewhere,
and it's easier on the eyes than dots.

>      void (*open)(Chardev *chr, ChardevBackend *backend,
>                   bool *be_opened, Error **errp);
>=20=20
> +    /*
> +     * Called after construction, create the backend, mutual exclusive

mutually

> +     * with .open, and must be accompanied by .connect.

Is it okay to destroy after init() without connect()?

If yes, "must" is misleading.

> +     * Must set chr-filename.

What's chr-filename?

> +     */
> +    bool (*init)(Chardev *chr, ChardevBackend *backend,
> +                 Error **errp);
> +
> +    /*
> +     * Called after .init(), open/starts the backend, mutual exclusive

mutually

> +     * with .open. Must send CHR_EVENT_OPENED.

Must send CHR_EVENT_OPENED when it succeeds, I guess.

> +     */
> +    bool (*connect)(Chardev *chr, Error **errp);
> +
>      /* write buf to the backend */
>      int (*chr_write)(Chardev *s, const uint8_t *buf, int len);

So, a ChardevClass either provides methods init() and connect(), or
their fusion open().  Correct?

Perhaps documentation becomes simpler if you put init() and connect()
before open().  You could then say open() needs to do the work of both.


