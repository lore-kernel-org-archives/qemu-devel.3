Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD2AE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZTY-0001Mm-Vw; Tue, 17 Dec 2024 10:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNZTX-0001FZ-DM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:27:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNZTS-0005BF-Iw
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:27:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A50F21153;
 Tue, 17 Dec 2024 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734449221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+5J6yZPjVYpQtjLESjqLkV5VUHmeUmTowMeXp+QIQ4=;
 b=jaxoeYhfZjJQBL6UGxMDY3VnxuXteqxMzC5xzieTzW/I4no4KGcGZRhrM0Z/6r60okd28l
 1E3JSjJfXBCMHCCvIewGPkenbBF0wsOva3CLQYQ0Czcm/2RCn+YJRo1xp+QumQRZBjZWt/
 GTHM5jKE2z1xXSm5tOZTx6rbCBiuNTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734449221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+5J6yZPjVYpQtjLESjqLkV5VUHmeUmTowMeXp+QIQ4=;
 b=dUgc94RIytmgBxLm9jbmVCfMjsVucumDjwU3IiKjWYw3bgdEI3kSwUolhKMOVuxDaxwPKk
 u2az/zx2rxVh6WDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jaxoeYhf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dUgc94RI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734449221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+5J6yZPjVYpQtjLESjqLkV5VUHmeUmTowMeXp+QIQ4=;
 b=jaxoeYhfZjJQBL6UGxMDY3VnxuXteqxMzC5xzieTzW/I4no4KGcGZRhrM0Z/6r60okd28l
 1E3JSjJfXBCMHCCvIewGPkenbBF0wsOva3CLQYQ0Czcm/2RCn+YJRo1xp+QumQRZBjZWt/
 GTHM5jKE2z1xXSm5tOZTx6rbCBiuNTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734449221;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+5J6yZPjVYpQtjLESjqLkV5VUHmeUmTowMeXp+QIQ4=;
 b=dUgc94RIytmgBxLm9jbmVCfMjsVucumDjwU3IiKjWYw3bgdEI3kSwUolhKMOVuxDaxwPKk
 u2az/zx2rxVh6WDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A666E132EA;
 Tue, 17 Dec 2024 15:27:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 26jJGkSYYWcXJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 15:27:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, peterx@redhat.com
Cc: linuxarm@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH] tests/qtest/migration: Fix compile errors when
 CONFIG_UADK is set
In-Reply-To: <20241217131046.83844-1-shameerali.kolothum.thodi@huawei.com>
References: <20241217131046.83844-1-shameerali.kolothum.thodi@huawei.com>
Date: Tue, 17 Dec 2024 12:26:58 -0300
Message-ID: <87ed26wcsd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2A50F21153
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Shameer Kolothum via <qemu-devel@nongnu.org> writes:

> Removes accidental inclusion of unrelated functions within CONFIG_UADK
> as this causes compile errors like:
>
> error: redefinition of =E2=80=98migrate_hook_start_xbzrle=E2=80=99
>
> Fixes: 932f74f3fe6e ("tests/qtest/migration: Split compression tests from=
 migration-test.c")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  tests/qtest/migration/compression-tests.c | 54 -----------------------
>  1 file changed, 54 deletions(-)
>
> diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migr=
ation/compression-tests.c
> index 6de87bc47d..d78f1f11f1 100644
> --- a/tests/qtest/migration/compression-tests.c
> +++ b/tests/qtest/migration/compression-tests.c
> @@ -88,59 +88,6 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState=
 *from,
>      return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk=
");
>  }
>=20=20
> -static void *
> -migrate_hook_start_xbzrle(QTestState *from,
> -                          QTestState *to)
> -{
> -    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
> -
> -    migrate_set_capability(from, "xbzrle", true);
> -    migrate_set_capability(to, "xbzrle", true);
> -
> -    return NULL;
> -}
> -
> -static void test_precopy_unix_xbzrle(void)
> -{
> -    g_autofree char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
> -    MigrateCommon args =3D {
> -        .connect_uri =3D uri,
> -        .listen_uri =3D uri,
> -        .start_hook =3D migrate_hook_start_xbzrle,
> -        .iterations =3D 2,
> -        /*
> -         * XBZRLE needs pages to be modified when doing the 2nd+ round
> -         * iteration to have real data pushed to the stream.
> -         */
> -        .live =3D true,
> -    };
> -
> -    test_precopy_common(&args);
> -}
> -
> -static void *
> -migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
> -                                            QTestState *to)
> -{
> -    /*
> -     * Overloading this test to also check that set_parameter does not e=
rror.
> -     * This is also done in the tests for the other compression methods.
> -     */
> -    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
> -    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
> -
> -    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib=
");
> -}
> -
> -static void test_multifd_tcp_zlib(void)
> -{
> -    MigrateCommon args =3D {
> -        .listen_uri =3D "defer",
> -        .start_hook =3D migrate_hook_start_precopy_tcp_multifd_zlib,
> -    };
> -    test_precopy_common(&args);
> -}
> -
>  static void test_multifd_tcp_uadk(void)
>  {
>      MigrateCommon args =3D {
> @@ -151,7 +98,6 @@ static void test_multifd_tcp_uadk(void)
>  }
>  #endif /* CONFIG_UADK */
>=20=20
> -
>  static void *
>  migrate_hook_start_xbzrle(QTestState *from,
>                            QTestState *to)

Queued, thanks!

