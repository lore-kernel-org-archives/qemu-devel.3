Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B93BC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udw8J-0003aL-D2; Mon, 21 Jul 2025 15:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udw3G-0006QG-IY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:19:59 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udw3E-0007Ug-Gz
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:19:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D930F1F38C;
 Mon, 21 Jul 2025 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753125590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT4N1pvQDb69+dYc+6OEIhkQcQodpnEFtBro2h4c99U=;
 b=B2qWAIpOCF4U2LO5myFYYTQRtyAcb6MBku8LuJFBR+npISGqo7GoweGPVgDsy/Ik+HoRHx
 gnaZtC31a3jFncg6YyedYPGmwmshfh7SxOYdV4NkihLTUVCr89j57+5sMV2lAKhkxCamW7
 qxkYgWoJH7QjJg7ObsMslkDY5YSmZJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753125590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT4N1pvQDb69+dYc+6OEIhkQcQodpnEFtBro2h4c99U=;
 b=TJLSb/rKl5nSlMNBG/c/WE0QQ1EQPCHsvSVBDUgb0nG3v55AVY58dkJMnwiv/XuPcjKOP4
 m5J5z4xynde49gCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ehsKtpsi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+ExffRjp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753125589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT4N1pvQDb69+dYc+6OEIhkQcQodpnEFtBro2h4c99U=;
 b=ehsKtpsiolgaVwz2c+jDkvUG6RoOJNRP92/3LFk6LKFbMSzRzTFAkHvYxEJ132s+3au6gR
 FrU/2UHBdXfEkHHd34bgjhXQeQ3Wt+x31/BR0H8YTkBgItbURV/zv4ZQOtRoyftVzzpFEE
 n3XkR3NAfGF25S02z9vqnALn7s35ePU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753125589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oT4N1pvQDb69+dYc+6OEIhkQcQodpnEFtBro2h4c99U=;
 b=+ExffRjp9cgD7klpDvjF0KHaTTAFc1i41i38LB64jSMiooRlKe/1nPLShus98gh2YTPHwt
 CYEtVuXybBkyM+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5103A136A8;
 Mon, 21 Jul 2025 19:19:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZSIlBNWSfmgZPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Jul 2025 19:19:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/4] crypto: implement workaround for GNUTLS thread
 safety problems
In-Reply-To: <20250718150514.2635338-2-berrange@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
 <20250718150514.2635338-2-berrange@redhat.com>
Date: Mon, 21 Jul 2025 16:19:46 -0300
Message-ID: <87wm81xsfh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D930F1F38C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

> When TLS 1.3 is negotiated on a TLS session, GNUTLS will perform
> automatic rekeying of the session after 16 million records. This
> is done for all algorithms except CHACHA20_POLY1305 which does
> not require rekeying.
>
> Unfortunately the rekeying breaks GNUTLS' promise that it is safe
> to use a gnutls_session_t object concurrently from multiple threads
> if they are exclusively calling gnutls_record_send/recv.
>
> This patch implements a workaround for QEMU that adds a mutex lock
> around any gnutls_record_send/recv call to serialize execution
> within GNUTLS code. When GNUTLS calls into the push/pull functions
> we can release the lock so the OS level I/O calls can at least
> have some parallelism.
>
> The big downside of this is that the actual encryption/decryption
> code is fully serialized, which will halve performance of that
> cipher operations if two threads are contending.
>
> The workaround is not enabled by default, since most use of GNUTLS
> in QEMU does not tickle the problem, only non-multifd migration
> with a return path open is affected. Fortunately the migration
> code also won't trigger the halving of performance, since only
> the outbound channel diretion needs to sustain high data rates,
> the inbound direction is low volume.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Hi, the CI caught a couple of issues. I'll fixup on the branch, no need
to resend.

...

> +void qcrypto_tls_session_require_thread_safety(QCryptoTLSSession *sess)
> +{
> +    sess->requireThreadSafety =3D true;
> +}

Needs a stub.

...

> @@ -545,8 +600,29 @@ int
>  qcrypto_tls_session_handshake(QCryptoTLSSession *session,
>                                Error **errp)
>  {
> -    int ret =3D gnutls_handshake(session->handle);
> +    int ret;
> +    ret =3D gnutls_handshake(session->handle);
> +
>      if (!ret) {
> +        gnutls_cipher_algorithm_t cipher =3D
> +            gnutls_cipher_get(session->handle);
> +

Unused var when the config is not enabled.

> +#ifdef CONFIG_GNUTLS_BUG1717_WORKAROUND
> +        /*
> +         * Any use of rekeying in TLS 1.3 is unsafe for
> +         * a gnutls with bug 1717, however, we know that
> +         * QEMU won't initiate manual rekeying. Thus we
> +         * only have to protect against automatic rekeying
> +         * which doesn't trigger with CHACHA20
> +         */
> +        if (session->requireThreadSafety &&
> +            gnutls_protocol_get_version(session->handle) =3D=3D
> +            GNUTLS_TLS1_3 &&
> +            cipher !=3D GNUTLS_CIPHER_CHACHA20_POLY1305) {
> +            session->lockEnabled =3D true;
> +        }
> +#endif
> +
>          session->handshakeComplete =3D true;
>          return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
>      }

