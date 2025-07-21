Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7987DC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 14:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udrsR-0004jt-Tb; Mon, 21 Jul 2025 10:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrsL-0004fI-Uj
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:52:22 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1udrsG-0007zH-6j
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 10:52:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2314021205;
 Mon, 21 Jul 2025 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753109534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pp3q88X/8na6jOiUl1esXb+SXsY7K4Cal8mh0Wm9B/g=;
 b=kGtBvW1DtGhpTMvX4BKX6MluWnVKPNRQRbHs7BQgKwLf0ihJ9PbECnY15YR3MxT1E1OZa0
 hQ0EX/04YWFWeYY18i0smlcUqk3c+uhc8SeO9vJTaTEMqfwQdFd2OVXbTmy79rKa/2ChBs
 PaDX4VoZIT7jh6fIt/oAPwR/2ZizPYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753109534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pp3q88X/8na6jOiUl1esXb+SXsY7K4Cal8mh0Wm9B/g=;
 b=jwkWm9HZ2N5UeTSgT44UImMdCxBISTUWNOQC6z5GXncYS80d6MYUaKUE5PaN8CjufxV+hJ
 2aUlmaE4DR7b4mBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kGtBvW1D;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jwkWm9HZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753109534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pp3q88X/8na6jOiUl1esXb+SXsY7K4Cal8mh0Wm9B/g=;
 b=kGtBvW1DtGhpTMvX4BKX6MluWnVKPNRQRbHs7BQgKwLf0ihJ9PbECnY15YR3MxT1E1OZa0
 hQ0EX/04YWFWeYY18i0smlcUqk3c+uhc8SeO9vJTaTEMqfwQdFd2OVXbTmy79rKa/2ChBs
 PaDX4VoZIT7jh6fIt/oAPwR/2ZizPYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753109534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pp3q88X/8na6jOiUl1esXb+SXsY7K4Cal8mh0Wm9B/g=;
 b=jwkWm9HZ2N5UeTSgT44UImMdCxBISTUWNOQC6z5GXncYS80d6MYUaKUE5PaN8CjufxV+hJ
 2aUlmaE4DR7b4mBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9DD136A8;
 Mon, 21 Jul 2025 14:52:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9BhQEx1UfmjxbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Jul 2025 14:52:13 +0000
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
Date: Mon, 21 Jul 2025 11:52:10 -0300
Message-ID: <87cy9tlhph.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.98%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2314021205
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>

