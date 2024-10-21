Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A946ED15DBC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vTQ-0007yj-2L; Mon, 21 Oct 2024 12:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t2vTM-0007yQ-2i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:41:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t2vTK-0006o5-BN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:41:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA1A01F80C;
 Mon, 21 Oct 2024 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729528892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9VRDuNf6cO23QShgsD+p4pUu9oLWN2a8kWWfwUKsXw=;
 b=JbnPBxI2vM1n7Yn9x+UNeOALazoLKwCpolv1PNCJMX4oFVZZSfrtRVWCsOK9y+qVVdsffU
 QOHGdX0lDvQBj4wwDxu7YWdv6Ks//aoZBt59gvy15LsLbG+jqUmjy4PCFdC64YDDmFpz4u
 DHMWjWqnSc6u4xLEh8tboEzhqXFqaz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729528892;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9VRDuNf6cO23QShgsD+p4pUu9oLWN2a8kWWfwUKsXw=;
 b=Us49pjTPqGOl3d9O1CEk3M1OSa+esORwYh41X9l01Zh8eMoSpJn8HOlaDRUqEkrrWY937q
 aPPt7bq6aiEHwkAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ji4BrhHW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RZok7Iiu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729528891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9VRDuNf6cO23QShgsD+p4pUu9oLWN2a8kWWfwUKsXw=;
 b=Ji4BrhHWucpaVd16yIauf6NDTQu9/ABCgjiBZPofM7NlrG1YN9jUDO5d1bRsxHTf+1SXvY
 XR7yT2MhBywxyaHffDug3XB7j05HuIdD/BSE5uVMOPG+KiJZ6HebvZREytdbBJtIP04bFb
 xYnE5E5s61brzVRKE4gYNaYk/hBkPRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729528891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9VRDuNf6cO23QShgsD+p4pUu9oLWN2a8kWWfwUKsXw=;
 b=RZok7IiuKPsfb/zGZI1cP/fhSZkvFGuH3Gg0cwpcTLXWEPqtBEUmB8X458hIReV4CabXJ8
 +idGjGd2qABrnmDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52031136DC;
 Mon, 21 Oct 2024 16:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rt6kBjuEFmcTAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 21 Oct 2024 16:41:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>, Brad Smith <brad@comstyle.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] util: don't set SO_REUSEADDR on client sockets
In-Reply-To: <20241021145410.1420261-1-berrange@redhat.com>
References: <20241021145410.1420261-1-berrange@redhat.com>
Date: Mon, 21 Oct 2024 13:41:28 -0300
Message-ID: <877ca1e7d3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CA1A01F80C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Setting the SO_REUSEADDR property on a socket allows binding to a port
> number that is in the TIMED_WAIT state. This is usually done on listener
> sockets, to enable a server to restart itself without having to wait for
> the completion of TIMED_WAIT on the port.
>
> It is also possible, but highly unusual, to set it on client sockets. It
> is rare to explicitly bind() a client socket, since it is almost always
> fine to allow the kernel to auto-bind a client socket to a random free
> port. Most systems will have many 10's of 1000's of free ports that
> client sockets will be bound to.
>
> eg on Linux
>
>   $ sysctl -a | grep local_port
>   net.ipv4.ip_local_port_range =3D 32768	60999
>
> eg on OpenBSD
>
>   $ sysctl -a | grep net.inet.ip.port
>   net.inet.ip.portfirst=3D1024
>   net.inet.ip.portlast=3D49151
>   net.inet.ip.porthifirst=3D49152
>   net.inet.ip.porthilast=3D65535
>
> A connected socket must have a unique set of value for
>
>  (protocol, localip, localport, remoteip, remoteport)
>
> otherwise it is liable to get EADDRINUSE.
>
> A client connection should trivially avoid EADDRINUSE if letting the
> kernel auto-assign the 'localport' value, which QEMU always does.
>
> When QEMU sets SO_REUSEADDR on a client socket on OpenBSD, however, it
> upsets this situation.
>
> The OpenBSD kernel appears to happily pick a 'localport' that is in the
> TIMED_WAIT state, even if there are many other available local ports
> available for use that are not in the TIMED_WAIT state.
>
> A test program that just loops opening client sockets will start seeing
> EADDRINUSE on OpenBSD when as few as 2000 ports are in TIMED_WAIT,
> despite 10's of 1000's ports still being unused. This contrasts with
> Linux which appears to avoid picking local ports in TIMED_WAIT state.
>
> This problem on OpenBSD exhibits itself periodically with the migration
> test failing with a message like[1]:
>
>   qemu-system-ppc64: Failed to connect to '127.0.0.1:24109': Address alre=
ady in use
>
> While I have not been able to reproduce the OpenBSD failure in my own
> testing, given the scope of what QEMU tests do, it is entirely possible
> that there could be a lot of ports in TIMED_WAIT state when the
> migration test runs.
>
> Removing SO_REUSEADDR from the client sockets should not affect normal
> QEMU usage, and should improve reliability on OpenBSD.
>
> This use of SO_REUSEADDR on client sockets is highly unusual, and
> appears to have been present since the very start of the QEMU socket
> helpers in 2008. The orignal commit has no comment about the use of
> SO_REUSEADDR on the client, so is most likely just an 16 year old
> copy+paste bug.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg03427.html
>     https://lists.nongnu.org/archive/html/qemu-devel/2024-02/msg01572.html
>
> Fixes: d247d25f18764402899b37c381bb696a79000b4e
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

