Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B844C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrwE-0002cX-5y; Mon, 21 Jul 2025 10:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrw8-0002Vj-Fe
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:56:16 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrw5-0000NE-RZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:56:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 53A102115F;
 Mon, 21 Jul 2025 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753109772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIgk9utDkVDEOOULX2pnpW3cDNKhRmIaaNTAHedXc2w=;
 b=DxzMB8hd+RDxf6/XhyRMWhGUhPJpnr6TE/6W/ESZe6fCD1Lk7tXKDi5DL/5vCRsm8tloQM
 BH1N5HDGXHvj3u2Osjc9aBNLVhq2FynGAWaaB0Tq68i2+UU+kJOIr150BA39xAC1zvQTjn
 LDye1XHWVbDHNWC5UOjZsXFho0Huil4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753109772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIgk9utDkVDEOOULX2pnpW3cDNKhRmIaaNTAHedXc2w=;
 b=5V5h7HtaDL07b+HLSWPbYt6jyi9idgN494mV732XQ6g97doIGLdE7IHHtgI7zDLzb57R2a
 m+EXbw24Wdyr3bCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DxzMB8hd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5V5h7Hta
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753109772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIgk9utDkVDEOOULX2pnpW3cDNKhRmIaaNTAHedXc2w=;
 b=DxzMB8hd+RDxf6/XhyRMWhGUhPJpnr6TE/6W/ESZe6fCD1Lk7tXKDi5DL/5vCRsm8tloQM
 BH1N5HDGXHvj3u2Osjc9aBNLVhq2FynGAWaaB0Tq68i2+UU+kJOIr150BA39xAC1zvQTjn
 LDye1XHWVbDHNWC5UOjZsXFho0Huil4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753109772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIgk9utDkVDEOOULX2pnpW3cDNKhRmIaaNTAHedXc2w=;
 b=5V5h7HtaDL07b+HLSWPbYt6jyi9idgN494mV732XQ6g97doIGLdE7IHHtgI7zDLzb57R2a
 m+EXbw24Wdyr3bCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E2A136A8;
 Mon, 21 Jul 2025 14:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xs8kIAtVfmg3bwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Jul 2025 14:56:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/4] migration: workaround GNUTLS live migration crashes
In-Reply-To: <20250718150514.2635338-1-berrange@redhat.com>
References: <20250718150514.2635338-1-berrange@redhat.com>
Date: Mon, 21 Jul 2025 11:56:09 -0300
Message-ID: <871pq9lhiu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 53A102115F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> TL:DR: GNUTLS is liable to crash QEMU when live migration is run
> with TLS enabled and a return path channel is present, if approx
> 64 GB of data is transferred. This is easily triggered in a 16 GB
> VM with 4 CPUs, by running 'stress-ng --vm 4 --vm-bytes 80%' to
> prevent convergance until 64 GB of RAM has been copied. Then
> triggering post-copy switchover, or removing the stress workload
> to allow completion, will crash it.
>
> The only live migration scenario that should avoid this danger
> is multifd, since the high volume data transfers are handled in
> dedicated TCP connections which are unidirectional. The main
> bi-directionl TCP connection is only for co-ordination purposes
>
> This patch implements a workaround that will prevent future QEMU
> versions from triggering the crash.
>
> The only way to avoid the crash with *existing* running QEMU
> processes is to change the TLS cipher priority string to avoid
> use of AES with TLS 1.3. This can be done with the 'priority'
> field in the 'tls-creds-x509' object.eg
>
>   -object tls-creds-x509,id=3Dtls0,priority=3DNORMAL:-AES-256-GCM:-AES-12=
8-GCM:-AES-128-CCM
>
> which should force the use of CHACHA20-POLY1305 which does not
> require TLS re-keying after 16 million sent records (64 GB of
> migration data).
>
>   https://gitlab.com/qemu-project/qemu/-/issues/1937
>
> On RHEL/Fedora distros you can also use the system wide crypto
> priorities to override this from the migration *target* host
> by creating /etc/crypto-policies/local.d/gnutls-qemu.config
> containing
>
>   QEMU=3DNONE:+ECDHE-RSA:+ECDHE-ECDSA:+RSA:+DHE-RSA:+GROUP-X25519:+GROUP-=
X448:+GROUP-SECP256R1:+GROUP-SECP384R1:+GROUP-SECP521R1:+GROUP-FF
>
> and running 'update-crypto-policies'. I recommend the QEMU
> level 'tls-creds-x509' workaround though, which new libvirt
> patches can soon do:
>
>   https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/=
LX5KMIUFZSP5DPUXKJDFYBZI5TIE3E5N/
>
> Daniel P. Berrang=C3=A9 (4):
>   crypto: implement workaround for GNUTLS thread safety problems
>   io: add support for activating TLS thread safety workaround
>   migration: activate TLS thread safety workaround
>   crypto: add tracing & warning about GNUTLS countermeasures
>
>  crypto/tlssession.c           | 99 +++++++++++++++++++++++++++++++++--
>  crypto/trace-events           |  2 +
>  include/crypto/tlssession.h   | 14 +++++
>  include/io/channel.h          |  1 +
>  io/channel-tls.c              |  5 ++
>  meson.build                   |  9 ++++
>  meson_options.txt             |  2 +
>  migration/tls.c               |  9 ++++
>  scripts/meson-buildoptions.sh |  5 ++
>  9 files changed, 143 insertions(+), 3 deletions(-)

Hi, thank you for getting to the bottom of this.

Do you think it would be too cumbersome to add a test for this
somewhere? So we don't regress the workaround but also so the test tells
us whether GNUTLS is fixed.

