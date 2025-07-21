Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8F2C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwGc-0002QR-6T; Mon, 21 Jul 2025 15:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udwG3-00028b-GY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:33:08 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udwG1-0003Ji-Lh
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:33:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 519181F38C;
 Mon, 21 Jul 2025 19:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753126382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htEh0aMZjPA/Y95zixsVTfgdNvtPHE4IncCG8oH/9W0=;
 b=GpTJSiBUGnQ53D4zKvqXbqI50HBu3HlUMe3b+sI7dEkUKScpAC/VWb86aoe2UkO+dL0XgA
 /s/D2We6IiSzbN6JhCW+Fbkif8Nf27YCDRE8l2I9Fnqkr/ccZ9tMH7TAsYNdbkmcsx86hz
 AtSkntXxSYQ8rWRfveLgm8XkAAR+Iys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753126382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htEh0aMZjPA/Y95zixsVTfgdNvtPHE4IncCG8oH/9W0=;
 b=kf/+Rx59pMo53hSNYGRS4tg7WUT6rZr7FcuFwPIf3sFQhdtvMPRevjY/rPTKx0NorWXZkf
 ahYK/5Hj1AwS+XBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753126382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htEh0aMZjPA/Y95zixsVTfgdNvtPHE4IncCG8oH/9W0=;
 b=GpTJSiBUGnQ53D4zKvqXbqI50HBu3HlUMe3b+sI7dEkUKScpAC/VWb86aoe2UkO+dL0XgA
 /s/D2We6IiSzbN6JhCW+Fbkif8Nf27YCDRE8l2I9Fnqkr/ccZ9tMH7TAsYNdbkmcsx86hz
 AtSkntXxSYQ8rWRfveLgm8XkAAR+Iys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753126382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htEh0aMZjPA/Y95zixsVTfgdNvtPHE4IncCG8oH/9W0=;
 b=kf/+Rx59pMo53hSNYGRS4tg7WUT6rZr7FcuFwPIf3sFQhdtvMPRevjY/rPTKx0NorWXZkf
 ahYK/5Hj1AwS+XBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB2D5136A8;
 Mon, 21 Jul 2025 19:33:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KcChHu2VfmiOPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Jul 2025 19:33:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 4/4] crypto: add tracing & warning about GNUTLS
 countermeasures
In-Reply-To: <20250718150514.2635338-5-berrange@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
 <20250718150514.2635338-5-berrange@redhat.com>
Date: Mon, 21 Jul 2025 16:32:58 -0300
Message-ID: <87tt35xrth.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> We want some visibility on stderr when the GNUTLS thread
> safety countermeasures are activated, to encourage people
> to get the real fix deployed (once it exists). Some trace
> points will also help if we see any further wierd crash
> scenario we've not anticipated.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/tlssession.c | 10 ++++++++++
>  crypto/trace-events |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index 939f69bdb3..246cd6f7c0 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -615,10 +615,20 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *se=
ssion,
>           * only have to protect against automatic rekeying
>           * which doesn't trigger with CHACHA20
>           */
> +        trace_qcrypto_tls_session_parameters(
> +            session,
> +            session->requireThreadSafety,
> +            gnutls_protocol_get_version(session->handle),
> +            cipher);
> +
>          if (session->requireThreadSafety &&
>              gnutls_protocol_get_version(session->handle) =3D=3D
>              GNUTLS_TLS1_3 &&
>              cipher !=3D GNUTLS_CIPHER_CHACHA20_POLY1305) {
> +            warn_report("WARNING: activating thread safety countermeasur=
es "

And this hit the missing error-report.h weirdness.

> +                        "for potentially broken GNUTLS with TLS1.3 ciphe=
r=3D%d",
> +                        cipher);
> +            trace_qcrypto_tls_session_bug1717_workaround(session);
>              session->lockEnabled =3D true;
>          }
>  #endif
> diff --git a/crypto/trace-events b/crypto/trace-events
> index bccd0bbf29..d0e33427fa 100644
> --- a/crypto/trace-events
> +++ b/crypto/trace-events
> @@ -21,6 +21,8 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, cons=
t char *file) "TLS creds
>  # tlssession.c
>  qcrypto_tls_session_new(void *session, void *creds, const char *hostname=
, const char *authzid, int endpoint) "TLS session new session=3D%p creds=3D=
%p hostname=3D%s authzid=3D%s endpoint=3D%d"
>  qcrypto_tls_session_check_creds(void *session, const char *status) "TLS =
session check creds session=3D%p status=3D%s"
> +qcrypto_tls_session_parameters(void *session, int threadSafety, int prot=
ocol, int cipher) "TLS session parameters session=3D%p threadSafety=3D%d pr=
otocol=3D%d cipher=3D%d"
> +qcrypto_tls_session_bug1717_workaround(void *session) "TLS session bug17=
17 workaround session=3D%p"
>=20=20
>  # tls-cipher-suites.c
>  qcrypto_tls_cipher_suite_priority(const char *name) "priority: %s"

