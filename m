Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D3D6EC0B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1c3-0003yp-Tu; Fri, 29 Nov 2024 09:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH1c1-0003y0-L7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:04:49 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH1bz-0000Oj-RL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:04:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 231C81F441;
 Fri, 29 Nov 2024 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732889086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQWJImWkh/RoIpXA/w8xn0Qq1iNFMwSbfYl21NPzrZY=;
 b=HjjkG+ugacuJO0H6g2Nup59dVKULj34qMmS7nOZN/2TO5XInMunJMtX4TkQE2W5iENjx21
 oJ7ZJ4f5g8lEtdVSu1koh3zfpMu3WevpzGU1RX8Br689itrfXjmAuVHTzs8t/kdBBmLrY8
 zAbVg+9fmD9t27RNNVsYGLvLKMCkMRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732889086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQWJImWkh/RoIpXA/w8xn0Qq1iNFMwSbfYl21NPzrZY=;
 b=EJ1Pt6eXalWFaoCToh+eX7nUupg/vBJmHjrNrDYz4b/qYS9FE6egUb9JMHX4eEcUcqbg/0
 bESsk726OZLr3uDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HjjkG+ug;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EJ1Pt6eX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732889086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQWJImWkh/RoIpXA/w8xn0Qq1iNFMwSbfYl21NPzrZY=;
 b=HjjkG+ugacuJO0H6g2Nup59dVKULj34qMmS7nOZN/2TO5XInMunJMtX4TkQE2W5iENjx21
 oJ7ZJ4f5g8lEtdVSu1koh3zfpMu3WevpzGU1RX8Br689itrfXjmAuVHTzs8t/kdBBmLrY8
 zAbVg+9fmD9t27RNNVsYGLvLKMCkMRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732889086;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQWJImWkh/RoIpXA/w8xn0Qq1iNFMwSbfYl21NPzrZY=;
 b=EJ1Pt6eXalWFaoCToh+eX7nUupg/vBJmHjrNrDYz4b/qYS9FE6egUb9JMHX4eEcUcqbg/0
 bESsk726OZLr3uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FB6B133F3;
 Fri, 29 Nov 2024 14:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o4dPGf3JSWfzKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 Nov 2024 14:04:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Martin Pitt
 <mpitt@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3 for 9.2] tests/qtest: add test for querying
 balloon guest stats
In-Reply-To: <20241129135507.699030-4-berrange@redhat.com>
References: <20241129135507.699030-1-berrange@redhat.com>
 <20241129135507.699030-4-berrange@redhat.com>
Date: Fri, 29 Nov 2024 11:04:43 -0300
Message-ID: <87jzcmjfus.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 231C81F441
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This test would have identified the crash caused by the addition of new
> balloon stats fields.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/virtio-balloon-test.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/tests/qtest/virtio-balloon-test.c b/tests/qtest/virtio-ballo=
on-test.c
> index 6bea33b590..ecdd363b06 100644
> --- a/tests/qtest/virtio-balloon-test.c
> +++ b/tests/qtest/virtio-balloon-test.c
> @@ -8,6 +8,7 @@
>=20=20
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> +#include "standard-headers/linux/virtio_balloon.h"
>=20=20
>  /*
>   * https://gitlab.com/qemu-project/qemu/-/issues/2576
> @@ -26,11 +27,30 @@ static void oss_fuzz_71649(void)
>      qtest_quit(s);
>  }
>=20=20
> +static void query_stats(void)
> +{
> +    QTestState *s =3D qtest_init("-device virtio-balloon,id=3Dballoon"
> +                               " -nodefaults");
> +    QDict *ret =3D qtest_qmp_assert_success_ref(
> +        s,
> +        "{ 'execute': 'qom-get', 'arguments': "     \
> +        "{ 'path': '/machine/peripheral/balloon', " \
> +        "  'property': 'guest-stats' } }");
> +    QDict *stats =3D qdict_get_qdict(ret, "stats");
> +
> +    /* We expect 1 entry in the dict for each known kernel stat */
> +    assert(qdict_size(stats) =3D=3D VIRTIO_BALLOON_S_NR);
> +
> +    qobject_unref(ret);
> +    qtest_quit(s);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
>=20=20
>      qtest_add_func("virtio-balloon/oss_fuzz_71649", oss_fuzz_71649);
> +    qtest_add_func("virtio-balloon/query-stats", query_stats);
>=20=20
>      return g_test_run();
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

