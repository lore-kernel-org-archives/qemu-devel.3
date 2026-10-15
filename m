Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A85CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLhU-0007Ad-44; Thu, 15 Oct 2026 09:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLhQ-0007AO-4f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:40:48 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHLhO-000880-Br
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:40:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 582931FD46;
 Thu, 15 Oct 2026 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792071643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLGVSEJd+JplmEYxX6hAApWCapI3JEwNVKd8P8KuLZE=;
 b=HFgtf6NVz/qdI3oylecXPg6cco5222Nio0SVGjgU6bfM9Yk7sXnX4D4pu4GexOvbTjr74P
 TWVxdtrAyjdkitg7MImn9mDq4WQn4aKpeEoMm0ta2IsxxNr+r6S7hvk9CzpZmOmVMy40Uf
 SDXOKz6vvOgK8Er5SYFdogawRS6SZ04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792071643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLGVSEJd+JplmEYxX6hAApWCapI3JEwNVKd8P8KuLZE=;
 b=3mAN4oZvTWSQu6Ks3CtB351ZAOUHOIzac16Lsc9yQ7+2CnLXTrp9D20eYKoHkOS7xWd/f8
 BfSpcuoZwFPnCrAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kYX78RVO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yvZ1b78r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792071642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLGVSEJd+JplmEYxX6hAApWCapI3JEwNVKd8P8KuLZE=;
 b=kYX78RVObjdizZTrsnxzNAzWA6cEmUsexBRXR2MikGQk+NJzB0niRDEOtbU28XkSWHAnug
 uHpAgP71C3YhgkiRmRBlrbCwwQCtD3W3axpAIMJBMMwr+o+tMMuTPjW3k779KyAIitGmLR
 YPJ/z1lCi/OYL6lP+/2SBYi5HFreU3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792071642;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLGVSEJd+JplmEYxX6hAApWCapI3JEwNVKd8P8KuLZE=;
 b=yvZ1b78rqg8sM5aypKoC2nebuyG2KhDdhw+urtT6uyK2Ljd/5pUBS1geSsgo+W53Dq+aez
 WxG0oxPZZP7IDBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49531132C9;
 Thu, 15 Oct 2026 13:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FZ0TI9jX0GrGWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Oct 2026 13:40:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 0/4] Revert obsolete & broken workaround for GNUTLS
 thread safety bug
In-Reply-To: <20261013133622.993935-1-berrange@redhat.com>
References: <20261013133622.993935-1-berrange@redhat.com>
Date: Thu, 15 Oct 2026 10:40:34 -0300
Message-ID: <87mrsfkrot.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 582931FD46
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,meson.build:url];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> A year or so ago we introduced a workaround for a troubling GNUTLS
> thread safety problem that hits when a bidirectional TLS channel
> is used and "large" amounts of data are transferred triggering
> re-keying under TLS 1.3.
>
> Unfortunately that workaround turned out to not work, and since it
> was close to final freeze we disabled it, rather than attempt last
> minute changes.
>
> Fast forward a year, and GNUTLS has shipped a fix itself and RHEL
> at least has backported the fix to stable releases. A user who
> is still affected can workaround it by disabling TLS 1.3, or
> forcing use of a different cipher to avoid re-keying entirely.
>
> Getting a viable workaround operating correctly in QEMU is going
> to be challenging and fragile long term, so not worth spending
> more time on.
>
> Revert the broken workaround (which was already hardcoded to be
> disabled at build time).
>
> Daniel P. Berrang=C3=A9 (4):
>   Revert "migration: activate TLS thread safety workaround"
>   Revert "io: add support for activating TLS thread safety workaround"
>   Revert "crypto: add tracing & warning about GNUTLS countermeasures"
>   Revert "crypto: implement workaround for GNUTLS thread safety
>     problems"
>
>  crypto/tlssession.c         | 103 ++----------------------------------
>  crypto/trace-events         |   1 -
>  include/crypto/tlssession.h |  14 -----
>  include/io/channel.h        |   1 -
>  io/channel-tls.c            |   5 --
>  meson.build                 |   9 ----
>  migration/tls.c             |   9 ----
>  7 files changed, 3 insertions(+), 139 deletions(-)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

