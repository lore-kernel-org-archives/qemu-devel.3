Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E607C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFtd-0004o6-Nq; Mon, 04 Mar 2024 16:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhFtW-0004nm-26
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:30:47 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhFtP-0001xO-I5
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:30:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 218743477E;
 Mon,  4 Mar 2024 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709587836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2fY/bSrPZDVjSoJP8+5L+v5+BL8AGgCD2PY7BIsyyE=;
 b=s3cpsUXYisJ2F9wf2GHYO2vcQpT4cMRGTknZISutx4GaKtO6aOCArtcdF+YIBOs6j6mnZz
 r7CNanAifGb17xBC7tEJAt+vb3s3662wfGWYejrVwWHer457Dtp9wMSAQTs66MbAXFBasr
 Wnv6t8UOKudsaW/aLXIotShlbObzubo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709587836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2fY/bSrPZDVjSoJP8+5L+v5+BL8AGgCD2PY7BIsyyE=;
 b=M9RqY7XpE/vjg6rau4sOPLKJ0m2rwvRIhDOIwPw4+zXm8KoE565nididRSvjLa9N6k/xY6
 9kIoBkLWRjg29DBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709587836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2fY/bSrPZDVjSoJP8+5L+v5+BL8AGgCD2PY7BIsyyE=;
 b=s3cpsUXYisJ2F9wf2GHYO2vcQpT4cMRGTknZISutx4GaKtO6aOCArtcdF+YIBOs6j6mnZz
 r7CNanAifGb17xBC7tEJAt+vb3s3662wfGWYejrVwWHer457Dtp9wMSAQTs66MbAXFBasr
 Wnv6t8UOKudsaW/aLXIotShlbObzubo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709587836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2fY/bSrPZDVjSoJP8+5L+v5+BL8AGgCD2PY7BIsyyE=;
 b=M9RqY7XpE/vjg6rau4sOPLKJ0m2rwvRIhDOIwPw4+zXm8KoE565nididRSvjLa9N6k/xY6
 9kIoBkLWRjg29DBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04D113A5B;
 Mon,  4 Mar 2024 21:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2NG2GXs95mXrTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 21:30:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 04/26] migration: Always report an error in
 ram_save_setup()
In-Reply-To: <20240304122844.1888308-5-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-5-clg@redhat.com>
Date: Mon, 04 Mar 2024 18:30:33 -0300
Message-ID: <87msrdheh2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.99 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.69)[83.18%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> This will prepare ground for futur changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> ram_save_setup() sets a new error.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  migration/ram.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 45a00b45edd429ef0568adce09b7459883e00167..dbd04d8ee2167881007c836a6=
bbc79c1aced72d0 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2937,12 +2937,14 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
>      int ret;
>=20=20
>      if (compress_threads_save_setup()) {
> +        error_report("%s: failed to start compress threads", __func__);
>          return -1;
>      }
>=20=20
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
>          if (ram_init_all(rsp) !=3D 0) {
> +            error_report("%s: failed to setup RAM for migration", __func=
__);
>              compress_threads_save_cleanup();
>              return -1;
>          }
> @@ -2969,12 +2971,14 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
>=20=20
>      ret =3D rdma_registration_start(f, RAM_CONTROL_SETUP);
>      if (ret < 0) {
> +        error_report("%s: failed to start RDMA registration", __func__);
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
>=20=20
>      ret =3D rdma_registration_stop(f, RAM_CONTROL_SETUP);
>      if (ret < 0) {
> +        error_report("%s: failed to stop RDMA registration", __func__);
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
> @@ -2986,6 +2990,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      ret =3D multifd_send_sync_main();
>      bql_lock();
>      if (ret < 0) {
> +        error_report("%s: multifd synchronization failed", __func__);
>          return ret;
>      }
>=20=20
> @@ -2994,7 +2999,11 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
>      }
>=20=20
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> -    return qemu_fflush(f);
> +    ret =3D qemu_fflush(f);
> +    if (ret) {
> +        error_report("%s failed : %s", __func__, strerror(ret));

Here it should be -ret

The qemu_fflush function returns the QEMUFile error (f->last_error) and
that is expected to be a -errno value.

I started making sure all callers of qemu_file_set_error() use a
negative value, but got lost in the vmstate code and never finished:

https://lore.kernel.org/r/20230706195201.18595-1-farosas@suse.de


