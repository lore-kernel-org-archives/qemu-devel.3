Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0534CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 06:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9HMP-00050w-BX; Thu, 16 Oct 2025 02:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v9HMO-00050F-HF
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v9HMJ-0002bl-ID
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760595664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSQT9bVBPLd3pEaMVh+yLzvVImWKdAW71zwP45dvnXg=;
 b=ZvTxVmGi0ONJQTTx04c0k4D2OSKgI+PrldrEUC/r7NanXLC5b9tJsHCuDM4MKkUQUhmcG0
 fcE00YHYxusZ5/t468t22Rny9bp0C7lqkxUIDz7pseShfQ4y+oayu1Wd3dYwnihcN0KGCV
 jKwuJ4mT+5MN+JyUo8+d2Ub9TPKBhdA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-BLKQV7bAM16LV8XUNb6Dhw-1; Thu,
 16 Oct 2025 02:21:00 -0400
X-MC-Unique: BLKQV7bAM16LV8XUNb6Dhw-1
X-Mimecast-MFC-AGG-ID: BLKQV7bAM16LV8XUNb6Dhw_1760595659
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC7671800345; Thu, 16 Oct 2025 06:20:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24F5D180057A; Thu, 16 Oct 2025 06:20:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64D7F21E6A27; Thu, 16 Oct 2025 08:20:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v4 5/7] chardev/char: introduce .init() + .connect()
 initialization interface
In-Reply-To: <20251015212051.1156334-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 16 Oct 2025 00:20:49 +0300")
References: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
 <20251015212051.1156334-6-vsementsov@yandex-team.ru>
Date: Thu, 16 Oct 2025 08:20:55 +0200
Message-ID: <87qzv3v03c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

s/either/or/

>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

[...]

> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 429852f8d9..d2e01f0f9c 100644
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
> @@ -259,7 +261,31 @@ struct ChardevClass {
>      /* parse command line options and populate QAPI @backend */
>      void (*parse)(QemuOpts *opts, ChardevBackend *backend, Error **errp);
>=20=20
> -    /* called after construction, open/starts the backend */
> +    /*
> +     * Called after construction, create the backend, mutually exclusive
> +     * with @open, and should be followed by @connect().
> +     * Must set the Chardev's chr->filename on success.
> +     */
> +    bool (*init)(Chardev *chr, ChardevBackend *backend,
> +                 Error **errp);
> +
> +    /*
> +     * Called after @init(), starts the backend, mutually exclusive
> +     * with @open. Should care to send CHR_EVENT_OPENED when connected.

Would "Must send CHR_EVENT_OPENED on success" be clearer?

> +     */
> +    bool (*connect)(Chardev *chr, Error **errp);
> +
> +    /*
> +     * Called after construction, an alternative to @init + @connect
> +     * and should do the work for both: create and start the backend.
> +     * Mutual exclusive with @init and @connect.

Mutually

> +     *
> +     * May not set the Chardev's chr->filename (generic code will care),
> +     * and may not send CHR_EVENT_OPENED when connected (@be_opened
> +     * should not be touched in this case, to signal the generic code
> +     * to care about CHR_EVENT_OPENED). If backend care about

If the backend cares

> +     * CHR_EVENT_OPENED, it should set @be_opened to false.
> +     */
>      void (*open)(Chardev *chr, ChardevBackend *backend,
>                   bool *be_opened, Error **errp);


